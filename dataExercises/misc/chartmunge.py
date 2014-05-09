#-*- coding: utf-8 -*-

from xlrd import open_workbook
import re
import sys

## simple parser for patient charts in excel format
## where input looks like

## excel file with K named sheets
## header row with "HCIN" (ptID) and one or more "%s-rank" columns
## i = 1 to N rows of pt records

## Print by sheet: 
## Sheet1 name
## ----------
## Pt1 (sheet1-rank r1): 
##    Sheet2: row i (sheet2-ranks)
##    Sheet3: row i (sheet3-ranks)
## 
## Sheet 2 name
## ----------
## Pt1 (sheet2-ranks r2):
##    Sheet1: row i (sheet1-ranks)

## Q: do you need to cross-reference across files? A: no

## Print by pt name
## ---- lastname, firstname
## Mammo
## C-scope
## etc. (Listed in order of of tabs from left to right)
## If possible...CAD would have subheader within it i.e. 
##   CAD_Diabetes because I have to put they are diabetic
## CAD
## CAD_Diabetes
## CAD_Lipids
## This could be run after in some other argument? 
## If CAD+ then output: CAD_Diabetes, CAD_Lipids, etc.


def LOOKUP_VALUES(name):
    """ If the sheet name is one of these, return some extra (formatted) text
    """
    TABLE = {
        'Coronary Artery Disease': "\nCAD-LDL\nCAD-DM\nCAD-CHF\nCAD-ACE/ARB",
        'Ischemic Vascular Disease': "\nIVD-LDL\nIVD-Antithromb",
        'Diabetes Mellitus': "\nDM-LastBP\nDM-LDL\nDM-ASA\nDM-Tobacco\nDM-IVD"
        
    }
    if name in TABLE.keys():
        return TABLE[name]
    else: 
        return ''
            

class ChartFile(object):
    def __init__(self, xlfile):
        self.wb = open_workbook(xlfile)
        self.data = []

    def map_records(self):
        """ this mutates self.data, just return self so it's chainable
        """
        [self.parse_sheet(k, sheet) 
         for k, sheet in enumerate(self.wb.sheets())]
        return self

    def parse_sheet(self, index, sheet):
        sheetname = sheet.name
        head = sheet.row(0)
        idcol = match_text(head)
        rankcols = get_rank_cols(head)
        lastnamecol = match_text(head, name="patient-last-name")
        firstnamecol = match_text(head, name="patient-first-name")
        for row in range(1, sheet.nrows):
            ptid = sheet.cell(row, idcol['index']).value
            name = ", ".join([sheet.cell(row, lastnamecol['index']).value,
                              sheet.cell(row, firstnamecol['index']).value])
            ranks = [sheet.cell(row, rank['index']).value 
                     for rank in rankcols]
            ranks = dict(zip([col['name'] for col in rankcols], ranks))
            record = {
                'ptid': ptid,
                'name' : "[lastname, firstname]",
                'ranks': ranks,
                'sheetname': sheetname,
                'sheet': index,
                'row': row
            }
            self.data.append(record)

    def print_all_sheets(self):
        for s in range(self.wb.nsheets):
            self.print_by_sheet(s)

    def print_by_sheet(self, i):
        if i > self.wb.nsheets:
            raise ValueError("No such sheet in this file")
        myrows = [row for row in self.data 
                  if row['sheet'] == i]
        if len(myrows) == 0:
            print "// no records on sheet " + str(i+1) + "//\n"
            return
        o = [myrows[0]['sheetname'] + \
             " ("+ str(myrows[0]['sheet']+1) +\
             ")\n-----------------------------\n"]
        o += [self.format_patient_sheet_record(patient['ptid'], i)
              for patient in myrows]
        o = "\n".join(o) + "\n"
        print o

    def format_patient_sheet_record(self, ptid, sheetindex):
        myrows = [row for row in self.data 
                  if row['ptid'] == ptid]
        current = [row for row in myrows
                   if row['sheet'] == sheetindex][0]
        myrows.remove(current)
        o = str(current['row']+1) + " // " + current['name']
        o+= "  (" + str(current['ranks']) + ")"
        o+= " also on "+ str(len(myrows))+" others\n"
        if len(myrows):
            summary = [
                "      " + row['sheetname'] + \
                " ("+str(row['sheet']+1)+"): " + \
                str(row['row']+1) + " " 
                for row in myrows
            ]
            o += "\n".join(summary) + "\n"
        return o

    def print_by_patient(self):
        """
        Print an alphabetical-by-name list with sheet-row attributes
        underneath.
        """
        data = sorted(self.data, key=lambda r: r['name'])
        unique_patients = unique([d['ptid'] for d in data])
        o = [ self.format_patient_records(id) 
              for id in unique_patients
            ]
        o = "\n".join(o) + "\n"
        o += "\n(" + str(len(unique_patients)) + " patients found)"
        print o
        
    def format_patient_records(self, ptid):
        myrows = [row for row in self.data 
                  if row['ptid'] == ptid]
        myrows = sorted(myrows, key=lambda row: row['sheet'])
        o = "\n---- " + myrows[0]['name'] + "\n"
        if len(myrows):
            summary = [
                row['sheetname'] + \
                " ("+str(row['sheet']+1)+"): " + \
                str(row['row']+1) + "    " + LOOKUP_VALUES(row['sheetname'])
                for row in myrows
            ]
            o += "\n".join(summary)
        return o
        
        
def match_text(row, name="HCIN"):
    """ python reïmplementation of what would be
    grep(name, names(df))[1] in R. 
    """
    for i, cell in enumerate(row):
        # if cell.value == name: ## generalized because 'name'≠'ns:name'
        if re.search(name, cell.value):
            return {'index': i} 

def get_rank_cols(row):
    """
    This was the only other potentially useful piece of information filled in on
    on any of the sheets -- it was named with some prefix, but some sheets
    had more than one "-rank" even though one was filled in and one was always
    empty. This is generalizable to other forms of  "grab the following 
    indices from each row and record them with names".
    """
    return [{'index': i, 'name': cell.value.encode('utf-8')} 
             for i, cell in enumerate(row)
             if re.search('rank', cell.value) #or re.search('cad-', cell.value)
             ]

def unique(seq):
    """ Return the unique elements of a list, in same order as list
    nb: this is the behavior of unique() in R, hence the name

    a classic trick: http://stackoverflow.com/questions/480214/how-do-you-remove-duplicates-from-a-list-in-python-whilst-preserving-order

    see also http://stackoverflow.com/questions/20891166/does-adding-element-to-a-set-return-true-if-it-is-successful-in-python
    """
    seen = set()
    seen_add = seen.add
    return [ x for x in seq if x not in seen and not seen_add(x)]
             

if __name__ == '__main__':
    thefile = str(sys.argv[1])
    c = ChartFile(thefile).map_records()
    if len(sys.argv) > 2:
        # python is 0-based; user is 1-based
        c.print_by_sheet(int(sys.argv[2])-1)
    else: c.print_by_patient()

