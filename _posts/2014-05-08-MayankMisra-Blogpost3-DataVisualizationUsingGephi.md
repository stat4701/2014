
# Data Visualization Using Gephi

This is a quick post on steps to visualize data using Gephi.  A few of you
reached out to understand the steps and the compexity involved with using Gephi
for explortory data analysis and visualization.  What follows is a set of steps
to visualize Twitter data and soem resources for further research.

Gephi is an open source visualization and analysis software focused on graph
visualization of datasets. The gephi website describes the tools as:

Gephi is a tool for people that have to explore and understand graphs. Like Photoshop but for data, the user interacts with the representation, manipulate the structures, shapes and colors to reveal hidden properties. The goal is to help data analysts to make hypothesis, intuitively discover patterns, isolate structure singularities or faults during data sourcing. It is a complementary tool to traditional statistics, as visual thinking with interactive interfaces is now recognized to facilitate reasoning. This is a software for Exploratory Data Analysis, a paradigm appeared in the Visual Analytics field of research.

## Prerequisites

- Download Gephi (gephi-0.8.2-beta) from [here](https://gephi.org/)
- Note for Mac users:  Gephi 0.8.2 needs Java6 which is deprecated for
Mountainlion and above.

    -- Install 'Java for OS X 2012-006 Developer Package' from Apples Developer
forum (https://developer.apple.com/downloads/index.action).  A developer id is
not requiered.  Use any valid email address.  Look for
javadeveloper_for_os_x_2012006__11m3909.dmg.  Confirm java version.  The default
for the OS should be Java 7 (jdk1.7.0_45.jdk)



```
$ ls -la
total 0
drwxr-xr-x  5 root  wheel  170 12  6 17:34 .
drwxrwxr-x  5 root  admin  170 12  6 17:34 ..
drwxr-xr-x  3 root  wheel  102 10  5  2012 1.6.0_37-b06-434.jdk
drwxr-xr-x  3 root  wheel  102 12  6 17:08 jdk1.7.0_45.jdk

$ java -version
java version &quot;1.7.0_45&quot;
Java(TM) SE Runtime Environment (build 1.7.0_45-b18)
Java HotSpot(TM) 64-Bit Server VM (build 24.45-b08, mixed mode)
```

    -- Edit '/Applications/Gephi.app/Contents/Resources/gephi/etc/gephi.conf'.
On the Mac ⌘⇧G enter /Applications/Gephi.app/Contents/Resources/gephi/etc
    The changed lines should look like this:

```
jdkhome=&quot;/Library/Java/JavaVirtualMachines/1.6.0_37-b06-434.jdk/Content
```

- Supercharge it while you are at it.  Increase the memory allocation.  I
increased it to 4GB in my case.

```
default_options="--branding gephi -J-Xms2048m -J-Xmx4096m -J-Xverify:none -J-Dsun.java2d.noddraw=true -J-Dsun.awt.noerasebackground=true -J-Dnetbeans.indexing.noFileRefresh=true -J-Dplugin.manager.check.interval=EVERY_DAY"
```

- Install [NodeXL](http://nodexl.codeplex.com/releases/view/117659).  NodeXL is
an Excel template that

"displays and analyzes network graphs created from edge and vertex lists stored in an Excel workbook. It is compatible with Excel 2007, Excel 2010 and Excel 2013."

## Get Twitter Data

There are many ways to get twitter data that interests you through the [Twitter
api](https://dev.twitter.com/docs/streaming-apis/streams/public).  If you are
interested in analyzing your twitter network, the easiest way is to get an
archive of your [twitter account](https://twitter.com/settings/account) or use
the NodeXL Import option to birng in your followers.
I thought it would be interesting to explore the network relationships in my
Twitter network.  I used [NodeXL](http://nodexl.codeplex.com/) through a
[Parallels](http://www.parallels.com/) installation of MS Excel, to get scrap
the data.  NoeXL is actually pretty cool as it provides pre built extractor for
many social networks (including YouTube and Flickr).  Once you have the archive,
use the 'Export' button to save the file as a GraphML file.  Your Twitter
dataset is now ready.  Although you can use the NodeXL to render some basic
relationship graphs, I prefer Gephi as it adds many more algorithms and provides
the ability to weigh relationships in using data statistics.  The dataset will
be small as Twitter limits

Here is how you bring in the dataset in Gephi: File > Open > Navigate to the
file

In the Import Report, make sure its a Directed graph.  Twitter is a directed
network (you follow people and people follow you but you don't have to follow
people who follow you).  Make sure 'Append Grpah' and 'Time Frame' are
unchecked.

Gephi has three tabs that you usually follow step by step.  The Overview tab is
where all the work is done.  Teh Data Laboratory tab is where you can mung or
enrich the data by creating calculated columns.  The Preview tab is really for
finalizing and creating the visual output.

We will use the [Force-directed graph](http://en.wikipedia.org/wiki/Force-
directed_graph_drawing) as the layout.  We will use the
fruchterman_reingold_force_directed_layout alogorithm.
For more on [fruchterman_reingold_force_directed_layout](http://www.boost.org/do
c/libs/1_35_0/libs/graph/doc/fruchterman_reingold.html)

Let the alogrithm run and thats it for a first pass.  You can play around with
the visualization by tweaking the way you weigh/rank the nodes and edges.

Here is the output for folks who follow me on
Twitter, along wih
a cluster representing their followers.  Now I know who I need to prioritize
when responding to direct messages.

![output for folks who follow me on
Twitter](https://dl.dropboxusercontent.com/u/10381353/blogPost3.png)


## Further Reading

Here is my curated list of resources on network analysis in general and Gephi in
particular.

1.  [A step-by-step introduction tutorial to Gephi](http://www.obviousleaks.org
/step-by-step-gephi-tutorial/)
2.  [Gephi – curated list of
tutorials](http://exploreyourdata.wordpress.com/2013/07/29/gephi-curated-list-
of-tutorials/)
3.  [Network Visualization guest lecture at #DataVizQMSS at
@Columbia](http://blog.ouseful.info/2010/04/16/getting-started-with-gephi-
network-visualisation-app-my-facebook-network-part-i/)
4.  [Video Social Network Analysis using Gephi and
NodeXL](https://www.youtube.com/watch?v=hN3-wTOxrsY)
5.  [Graph Viz 101: a blog post series on the visual exploration of
graphs](http://linkurio.us/graph-viz-101/)

Lastly, it was a pleasure marinating with you on data exploration and
visualization these last few months.  Thank you.

In[ ]:

```

```
