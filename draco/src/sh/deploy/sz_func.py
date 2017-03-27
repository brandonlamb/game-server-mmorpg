#!/usr/bin/python
#-*- encoding: utf8 -*-

import os, sys, string
import commands
import re
from termcolor import colored

FS = '/'
ROOT_PATH='/data/easter'
PACK_PATH='/data/easter/pack'
DEPLOY_PATH='/data/easter/deploy'
SQL_DIR_NAME='sql/update'
DB_DATA_PATH='/data/easter/data'
DATABASE_NAME = 'easter'
CODE_DEPLOY_NAME = 'easter'
RES_DEPLOY_NAME = 'resources'

db_default_character_set = 'gbk'

ENV_NAME = 'env'
ENV_TEST_CONF = 'env_list/env_test'
ENV_OFFICIAL_CONF = 'env_list/env_official'
#ENV_URL = 'http://192.168.1.180:19310/env'
ENV_URL = 'http://areaserver.moogame-inc.com:19310/env'


def is_correct_ver_format(version):
   '''判断是否正确的版本号格式'''
   p = re.compile('^(\d+\.){3}\d+$')
   if not p.match(version) :
       return False
   return True

def exec_shell(cmd):
    return commands.getoutput(cmd)

def ln(real_path,virtual_path):
    if virtual_path.endswith(FS):
        virtual_path = virtual_path[:-1]
    exec_shell("rm -rf %s" %(virtual_path))
    cmd = "ln -s %s %s" %(real_path,virtual_path);
    return exec_shell(cmd)

def do_ln(real_path,virtual_path):
    resp = ln(real_path,virtual_path)
    if resp :
        err_log(resp)
        return False
    return True

def get_current_deploy_ver(deploy_path,deploy_name):
    '''判断是否有部署的目录'''
    hadDeploy = os.path.exists("%s/%s"%(deploy_path,deploy_name))
    if not hadDeploy:
        return False,""
    '''获得当前部署版本'''
    cmd ="ls -lih %s|grep \"\->\"|awk '$10==\"%s\"{print $0}'|awk -F\"/\" '{print $NF}'|awk -F\"_\" '{print $NF}'"%(deploy_path,deploy_name)
    return hadDeploy,exec_shell(cmd)

def err_log(err_info):
    print colored(err_info,'red')

def info_log(msg):
    print colored(msg,'green')
    
def get_ver_int(ver):
    value = ver.split(".")
    return int(value[3]) + int(value[2])*1000 + int(value[1])*1000*1000 + int(value[0])*1000*1000*1000

'''return resp_info,current_ver'''
def check_version(to_deploy_version,deploy_name):
    '''判断此版本的文件是否存在'''
    place , target_pack_name = get_pack_path_info(to_deploy_version,deploy_name)
    resp_info = ''
    if not os.path.exists(target_pack_name):
        resp_info ="the version file isn't exits,version: %s"%(to_deploy_version)
        return resp_info,''
    hadDeploy,current_ver = get_current_deploy_ver(DEPLOY_PATH,deploy_name)
    if hadDeploy and get_ver_int(current_ver) >= get_ver_int(to_deploy_version):
        '''当前版本和将要部署的版本号相同'''
        resp_info = "the version which to deploy >= the current ver:%s"%(current_ver)
    return resp_info,current_ver

def get_pack_path_info(to_deploy_version,deploy_name):
    TARGET_NAME = PACK_PATH + FS + deploy_name + '_' + to_deploy_version
    TARGET_PACK_NAME= TARGET_NAME + '_tar.gz'
    return TARGET_NAME , TARGET_PACK_NAME

def connect_db(host,port,user,pwd):
    cmd = "mysql -u%s --password=%s -h%s -P %s -e ''"%(user,pwd,host,port)
    resp = exec_shell(cmd)
    if resp :
        err_log(resp)
        return False
    return True

'''return is_correct,code_version,res_version'''
def check_input(argv):
    is_correct = False
    code_version = ''
    res_version = ''
    if len(argv) == 2 and ("--help" == argv[1] or "-h" == argv[1]):
        return is_correct,code_version,res_version
    
    '''判断参数个数'''
    nargv = len(argv)
    if nargv != 3 and nargv != 5:
        return is_correct,code_version,res_version
   
    '''解析参入参数'''
    for index in range(1,nargv):
        if sys.argv[index] == "-c":
            code_version = argv[index + 1]
            continue
        if sys.argv[index] == "-r":
            res_version = argv[index + 1]
            continue
   
    correct = True
    '''验证版本号格式'''
    if code_version and not is_correct_ver_format(code_version):
        err_log("the code_version: %s is not correct format" %(code_version)) 
        correct = False
       
    if res_version and not is_correct_ver_format(res_version):
        err_log("the res_version: %s is not correct format" %(res_version)) 
        correct = False
    
    is_correct = correct 
    return is_correct,code_version,res_version

def help(cmd_name,func_name):
      print "sz %s" %(func_name)
      print "Usage: python %s [OPTIONS]"%(cmd_name)
      print "-c"
      print "       the %s code version" %(func_name)
      print "-r"
      print "       the %s resources version" %(func_name)
      print "eg:"
      print "python %s -c 0.0.0.1 -r 0.0.0.2"%(cmd_name)
      print "python %s -r 0.0.0.1 -c 0.0.0.2"%(cmd_name)
      print "python %s -c 0.0.0.1"%(cmd_name)
      print "python %s -r 0.0.1.1"%(cmd_name)
    
    
def exec_sql(db_host,db_port,db_user,db_pwd,sql_file_name):
    if os.path.isfile(sql_file_name):
        cmd = "mysql -u%s --password=%s -h%s -P %s -e 'use %s;source %s;'"%(db_user,db_pwd,db_host,db_port,DATABASE_NAME,sql_file_name)
        resp = exec_shell(cmd)
        if resp :
            err_log(resp)
            return False
    return True


