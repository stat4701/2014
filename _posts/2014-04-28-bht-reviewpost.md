---
layout: post
title: Ben's Review Presentation
description: Reviewing a work-in-progress 
tags: finalproject
---

## Project Introduction

* Housing complaints can become violations, but which do?
* Initially framed as a prediction & understanding project
* Prediction ended up separate from understanding

# Beginning with R

* I initially wasn't able to see too much: ![cats](http://i.imgur.com/dxiswkY.png)

* In my initial regression result, "only 93 complaints were assigned a prediction over 75%, while 71203 complaints were under 75%. The 'over 75%' group only actually had a 60% conversion rate. Silver lining: the under 75% prediction group only had a 28% conversion."

* Only useful if a decently sized share (say, 10%) of the population can be classified

# AdaBoost Decision Trees Committee

* SQL factor construction:

With a database connection, parameterized queries, and SciPy (scikit-learn), I was able to take another approach:

```{python}

for combo in apt_to_search:
 
 	#create a tuple to pass as parameters
	apt_combo_tuple = tuple([combo[3],combo[2],combo[1],combo[3]])

	#query for records on this building prior to the current complaint
	cur.execute(get_apt_evidence,apt_combo_tuple)
	res = cur.fetchall()
	prior_comps = len(res)
	if prior_comps == 0:
		prior_vios = 0 
	else:
		arrPriorVio = np.array( [[x[4],x[5]] for x in res])			#get two binary columns
		prior_vios = sum(arrPriorVio[:,0]*arrPriorVio[:,1])			#multiply to get the number of positive matches
	update_data = tuple([str(prior_comps),str(prior_vios),str(combo[0])])	
	cur.execute(apt_update_query,update_data)						#update the record with findings
	cnx.commit()			
```
* Domain knowledge matters: these sorts of transformations might be hard to discover algorithmically 

```{python}


def getCmpFactorsExt(): 
    try:					#try-except so I can use the function in the middle of a session where i've imported * from utl
        import utl
        llist = utl.csv2list("/media/nas/DatabaseBackups/DI_dbcode/Prediction/HPD_Complaints/complaint_factors_ext1.csv")
    except:
        llist = csv2list("/media/nas/DatabaseBackups/DI_dbcode/Prediction/HPD_Complaints/complaint_factors_ext1.csv")
    newheaders = ["ComplaintID",
    "SCID",
    "ProblemID",
    "LegalStories",
    "LegalClassA",
    "DoBBuildingClass",
    "ManagementProgram",
    "Zip",
    "BldgArea",
    "Res_FAR",
    "PLUTOBldgClass",
    "Comm_Area",
    "CommericalAreaPortion",
    "UnitSize",
    "MinorCategory_ShortName",
    "SpaceType_ShortName",
    "problem_count",
    "prior_apt_comps",
    "prior_apt_vios",
    "prior_bldg_comps",
    "prior_bldg_vios",
    "outstanding",
    "doboutstanding",
    "fispcount",
    "defaultcount",
    "dobstopwork",
    "HPDclassAvios",			#information leak
    "HPDofftrackVios",			#information leak
    "Vio"]
    llist[0] = newheaders
    return llist
```
* while the "prior_" fields were calculated with care, these violation count based fields were recent and could include the complaints that converted to violations, introducing inappropriate information to the model


```{python}
def vectorizeCmpFactors(llist):    
    try:
        ldict = utl.llist2ldict(llist)    
    except:
        ldict = llist2ldict(llist)    
    #make a list of dicts where the keys are the first row (list) values
    ldict.pop(0)    #remove header row

    #we're building a classifier, so we need the class labels vector to be separate
    classes =[]
    for i in range(len(ldict)):
        classes.append(ldict[i].pop('Vio'))     #the class is Vio=1 or Vio=0; pop removes the key while returning its value
        try:
            ldict[i].pop('ComplaintID')         #db record IDs 
            ldict[i].pop('ProblemID')
            ldict[i].pop('SCID')
        except:
            continue
    #select certain keys to convert to floats to prevent factorizing/vectorizing
    if "Res_FAR" in ldict[0].keys():            #check which version of the factors I'm using 
        convert_keys = ['HPDofftrackVios','LegalClassA','HPDclassAvios','LegalStories','outstanding','doboutstanding','fispcount','prior_apt_vios','prior_bldg_comps','problem_count','defaultcount','BldgArea','prior_apt_comps','prior_bldg_vios','dobstopwork',"Comm_Area","Res_FAR","CommericalAreaPortion","UnitSize","Zip"]
    else:
        convert_keys = ['HPDofftrackVios','LegalClassA','HPDclassAvios','LegalStories','outstanding','doboutstanding','fispcount','prior_apt_vios','prior_bldg_comps','problem_count','defaultcount','BldgArea','prior_apt_comps','prior_bldg_vios','dobstopwork']
    
    #go through and convert these values to floats
    for i in range(len(ldict)):
        for k in convert_keys:
            try:
                ldict[i][k] = float(ldict[i][k])
            except:
                if ldict[i][k] == 'NULL':           #set nulls to 0; this is ok for this data
                    ldict[i][k] = float(0)
    t = np.array(classes)
    t = t.astype(np.float)      #make the class vector a numpy array of numpy floats

    #now we take advantage of scikit functions 
    v = DictVectorizer(sparse=False)            #v is the 'vectorizer' object turns categorical (string) values into indicator vectors
    X = v.fit_transform(ldict)                  #use the fit_transform method on a list of dictionaries to get the indicator matrix
    return (X,t,v)
```

* Choose to convert Zipcode to float (to treat it as numeric and not as factor) in order to model geographic distinctions above zipcode level 

```{python}
def makeTreeAndRecordZipErrors(X_train,t_train,X_test,t_test,clf):
    clf = clf.fit(X_train,t_train)
    predict_arr = clf.predict(X_test)               #get np array of prediction flags
    flagged = np.sum(predict_arr)                   #sum for count of flags
    valid_flags = np.dot(predict_arr,t_test)        #dot with observed classes for count of valid flags
    zipscores = {}                                  #this will hold [valid flags,total flags]
    for i in range(len(X_test)):
        tempzip = str(int(X_test[i][221]))          #I have kludgingly hard-coded the index of the zipcode value
        pred = clf.predict(X_test[i])[0] 
        if pred == 0:                               #we only care about positive flags
            continue
        obs = t_test[i]                             #we'll store the observed outcome conveniently
        if tempzip in zipscores.keys():
            prior_tuple = zipscores[tempzip]
            zipscores[tempzip] = (prior_tuple[0]+(obs*pred), prior_tuple[1]+pred)
        else:
            zipscores[tempzip] = (obs*pred, pred)   #obs*pred enforces agreement
    #ziprates will be [[zipcode, rate, # of flags]...]
    ziprates = [[k,zipscores[k][0]/zipscores[k][1],zipscores[k][1]] for k in zipscores.keys()]
    return (clf,valid_flags,flagged,ziprates)

In [7]: feature_imp = zip(v.get_feature_names(),clf.feature_importances_)

In [8]: sorted(feature_imp,key=lambda x: -x[1])[0:20]
Out[8]: 
[('problem_count', 0.077702429031960646),
 ('prior_bldg_comps', 0.077621733699117124),
 ('UnitSize', 0.067957446437712843),
 ('outstanding', 0.05731972881893696),
 ('Zip', 0.044465942038431842),
 ('BldgArea', 0.043297950340402534),
 ('prior_apt_comps', 0.041302811142280627),
 ('HPDofftrackVios', 0.040126903639353388),
 ('HPDclassAvios', 0.038437452377418697),
 ('LegalClassA', 0.0342664696634815),
 ('prior_bldg_vios', 0.026191556888992586),
 ('MinorCategory_ShortName=HEAT', 0.024601173896559744),
 ('Res_FAR', 0.022406624007920928),
 ('CommericalAreaPortion', 0.018807876008999237),
 ('doboutstanding', 0.017598575149783673),
 ('defaultcount', 0.014371625962105172),
 ('MinorCategory_ShortName=ENTIREBUILDING', 0.014356283018548417),
 ('SpaceType_ShortName=ENTIRE BUILDING', 0.01319921194806817),
 ('MinorCategory_ShortName=MOLD', 0.011135164597022072),
 ('Comm_Area', 0.0107276814767333)]

```

## PyMaps: not really

* All in Python so far, so I aim to skip RMaps and just use datamaps.js

* Implement two improvements from RMaps: creating records for missing data with missingData fill (user error?), and adding a letter to numeric keys for CSS-safety

```{python}
#get a full zip set from another dataset where I already filled in missing values
#the dataset is 'dec' because I decoded it from JSON; the first year of that data was '2009'
fullZipSet = set(dec['2009'].keys())

def assembleZiprates(zr1,zr2,zr3):
    models = {"model1":zr1,"model2":zr2,"model3":zr3}
    assert len(zr1[0]) == len(zr2[0]) == len(zr3[0])
    #implement the R 'cut' function in numpy...   
    if len(zr1[0]) < 4:                         #check to make sure input data dimensions look unlabeled
        for mod,dataset in models.items():
            #grab the rates
            ratearr = np.array([np.float(x[1]) for x in dataset])
            #set percentile cutoffs:
            bincuts = []
            for quantile in range(4,101,16):
                bincuts.append(np.percentile(ratearr,float(quantile)))
            cutlabels = np.digitize(ratearr,np.array(bincuts))
            #make sure we have the right number of labels for good measure
            assert len(cutlabels) == len(dataset)
            dataset = [dataset[i] + [cutlabels[i]] for i in range(len(dataset))]
            models[mod] = dataset
    #assemble the data in json-ready structure
    print len(zr1[0])
    #python mega comprehension; loop rows in outer layer and fields in inner layer for each of three datasets to make a dict of 3 models 
    dataPack = {mod:{"Z"+str(dat[i][0]):{"rate":dat[i][1],"flagCount":dat[i][2],"fillKey":dat[i][3]} for i in range(len(dat))} for mod,dat in models.items()}
    for mod in models.keys():
        missingData = [k for k in fullZipSet if k not in dataPack[mod].keys()]
        print len(missingData)
        for key in missingData:
            dataPack[mod][key] = {"rate":'0',"flagCount":'0',"fillKey":"missingData"}
    return dataPack    

def dumpDataPack(dataPack):
    fp = open("dataPack.json","wB")
    json.dump(dataPack,fp,sort_keys=True)
    fp.close()
```

* Data shaping for C3 via IPython terminal session and Sublime. C3 seems to work but is mostly free of explanation. 

* (app-in-progress)

## Todos

* Why won't the update for model0 work?

* What might we visualize for each feature to understand why they have the model importance that they do?

* Think I could put images in the tooltips? (as way of showing something about feature distribution)

```{javascript}
    // tooltip - show when mouseover on each data
        var __tooltip_show = getConfig(['tooltip', 'show'], true),
            __tooltip_format_title = getConfig(['tooltip', 'format', 'title']),
            __tooltip_format_value = getConfig(['tooltip', 'format', 'value']),
            __tooltip_contents = getConfig(['tooltip', 'contents'], function (d, defaultTitleFormat, defaultValueFormat, color) {
            var titleFormat = __tooltip_format_title ? __tooltip_format_title : defaultTitleFormat,
                valueFormat = __tooltip_format_value ? __tooltip_format_value : defaultValueFormat,
                text, i, title, value, name;
            for (i = 0; i < d.length; i++) {
                if (! (d[i] && (d[i].value || d[i].value === 0))) { continue; }

                if (! text) {
                    title = titleFormat ? titleFormat(d[i].x) : d[i].x;
                    text = "<table class='" + CLASS.tooltip + "'>" + (title || title === 0 ? "<tr><th colspan='2'>" + title + "</th></tr>" : "");
                }

                name = d[i].name;
                value = valueFormat(d[i].value, d[i].ratio);

                text += "<tr class='" + CLASS.tooltipName + "-" + d[i].id + "'>";
                text += "<td class='name'><span style='background-color:" + color(d[i].id) + "'></span>" + name + "</td>";
                text += "<td class='value'>" + value + "</td>";
                text += "</tr>";
            }
            return text + "</table>";
        }),
            __tooltip_init_show = getConfig(['tooltip', 'init', 'show'], false),
            __tooltip_init_x = getConfig(['tooltip', 'init', 'x'], 0),
            __tooltip_init_position = getConfig(['tooltip', 'init', 'position'], {top: '0px', left: '50px'});
```

* Can we use the feature selection lessons from the models to come up with a decent logistic regression classifier? Add this model to the graph?

* D3App: Should show overall valid/flags rate for each model, and the style is still semi atrocious





