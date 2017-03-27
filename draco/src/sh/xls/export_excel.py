#!/usr/bin/python
#-*- encoding: utf8 -*-

import xdrlib, sys, os
import xlrd
import re

reload(sys)
sys.setdefaultencoding('utf-8')

"""
依赖xlrd:
	https://pypi.python.org/pypi/xlrd
"""
def write_file(path_name, file_name, content_lines):
    if not os.path.exists(path_name):
        os.mkdir(path_name)

    full_file_name = os.path.join(path_name, file_name)
    if os.path.isfile(full_file_name):
        #删除老文件
        os.remove(full_file_name);

    out_file = file(full_file_name, 'w')
    out_file.writelines(content_lines)
    out_file.close()


def open_excel(file='file.xls'):
    try:
        data = xlrd.open_workbook(file, formatting_info=False)
        return data
    except Exception, e:
        print str(e)


def format_value(value, cell_type, book):
    #print value ,cell_type
    if cell_type == 2:
        if value == int(value):
	   value = int(value)
	else:
           r = re.compile('^(\d)*(\.)(\d)+')
	   value = str(value)
           if r.match(value) :
	      value = value[0:value.find('.')] 
	      #print value,int(value)
    elif cell_type == 3:
        date_tuple = xlrd.xldate_as_tuple(value, book.datemode)
        if date_tuple[0] == 0 and date_tuple[1] == 0 and date_tuple[2] == 0:
            value = "%02d:%02d:%02d" % date_tuple[3:]
        elif date_tuple[3] == 0 and date_tuple[4] == 0 and date_tuple[5] == 0:
            value = "%04d-%02d-%02d" % date_tuple[:3]
        else:
            value = "%04d-%02d-%02d %02d:%02d:%02d" % date_tuple
    result = str(value).replace("\r","\\r").replace("\n","\\n")
    return result



def read_sheet(book, sheet):
    data=[]
    #行数
    total_rows = sheet.nrows
    if not total_rows:
	return data

    #第一行数据
    col_names = sheet.row_values(0)
    total_cols = len(col_names)
    #有效列的下标(列名不为空)
    effect_cols_index = []
    for index in xrange(0, total_cols):
        cell_type = sheet.cell_type(0, index)
        value = format_value(col_names[index], cell_type, book).strip()
        if value:
            effect_cols_index.append(index)

    for row_num in xrange(0, total_rows):
        row = sheet.row_values(row_num)
        if row:
            row_data_list = []
            for col_num in effect_cols_index:
                cell_type = sheet.cell_type(row_num, col_num)
                value = format_value(row[col_num], cell_type, book)
                row_data_list.append(str(value))
            data.append('\t'.join(row_data_list))
    return data


def export_sheet(book, sheet, path_name, file_name):
    data = read_sheet(book, sheet)
    all_data = '\n'.join(data)
    write_file(path_name, file_name, all_data)


def export_excel(excel_path, excel_file_name, result_path,sheet_name=None):
    excel_file_full_name = os.path.join(excel_path, excel_file_name)
    if not os.path.isfile(excel_file_full_name):
        print 'file not exist,file=%s' % (excel_file_full_name)
        return
	
    print "start to export %s" % (excel_file_full_name)

    book = open_excel(excel_file_full_name)
    if sheet_name :
       sheet = book.sheet_by_name(sheet_name)
       export_sheet(book, sheet, result_path, "%s_%s.txt"%(excel_file_name,sheet_name))
       return 
 
    for sheet in book.sheets():
        sheet_name = sheet.name
        cn_pattern = re.compile(u'[\u4e00-\u9fa5]+')
        if not cn_pattern.search(sheet_name) :
           export_sheet(book, sheet, result_path, "%s_%s.txt"%(excel_file_name,sheet_name))

def main():
    argv_len=len(sys.argv)
    if argv_len < 2:
	print "pls input the excep path:"
	print "eg: python %s %s" %(sys.argv[0],'${the excel path}') 
	return 

    #excel_path = "/data/app/workspace/game/wow/public/gameData/xls"
    excel_path = sys.argv[1]

    if not os.path.exists(excel_path):
	print "path:%s not exist"%(excel_path)
	return   

    result_path = os.path.join(excel_path,'txt')

    file_list = os.listdir(excel_path)
    if not file_list:
        return

    execl_list = [file_name for file_name in file_list if file_name.endswith('.xls')]
    if not execl_list:
        return

    for excel_file_name in execl_list :
        export_excel(excel_path, excel_file_name, result_path,None)

    print "----------- export over ------------"

if __name__ == "__main__":
    main()


