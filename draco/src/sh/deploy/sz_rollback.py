#!/usr/bin/python
#-*- encoding: utf8 -*-

'''
    神州服务器代码还原脚本
'''
import os, sys, string
import commands
from sz_func import FS,ROOT_PATH,PACK_PATH,DEPLOY_PATH,SQL_DIR_NAME
from sz_func import DB_DATA_PATH,DATABASE_NAME,CODE_DEPLOY_NAME,RES_DEPLOY_NAME
from sz_func import is_correct_ver_format,exec_shell,ln,get_current_deploy_ver,connect_db,exec_sql
from sz_func import err_log,info_log,get_ver_int,check_version,get_pack_path_info,help,check_input

    
if __name__ == '__main__' :
    '''check input '''
    is_correct,code_version,res_version = check_input(sys.argv)
    if not is_correct:
        help(sys.argv[0],"rollback")
        sys.exit()
    
    correct = True
    res_version_path = ''
    code_version_path = ''
    if res_version :
        res_version_path ,version_tar_path = get_pack_path_info(res_version,RES_DEPLOY_NAME)
        if not os.path.exists(res_version_path):
            correct = False
            err_log("the res version isn't exits,version: %s"%(res_version))
    
    if code_version:
        code_version_path ,version_tar_path = get_pack_path_info(code_version,CODE_DEPLOY_NAME)  
        if not os.path.exists(code_version_path):
            correct = False
            err_log("the code version isn't exits,version: %s"%(code_version))
    
    if not correct:
        sys.exit()
    
    if res_version:
        '''rollback res'''
        """将资源连接到相关版本"""
        ln_resp = ln(res_version_path,DEPLOY_PATH + FS + RES_DEPLOY_NAME)
        if ln_resp :
            err_log(ln_resp)
            sys.exit()
    
    if code_version:
        '''判断是否有相关数据库的备份,如果有则需要回滚相关数据库备份'''
        back_data_name = "%s/%s_%s.data" % (DB_DATA_PATH,DATABASE_NAME,code_version)
        if os.path.isfile(back_data_name):
            '''还原数据库'''
            info_log("start to rollback db: %s" %(back_data_name))
            
            TARGET_NAME , TARGET_PACK_NAME = get_pack_path_info(code_version,CODE_DEPLOY_NAME)
            env_prop_name = TARGET_NAME + FS + "env.properties"
            env = exec_shell("cat %s"%(env_prop_name))
            if not env :
                err_log("env failure")
                sys.exit()
            env_list = env.split('\n')
    
            env_map = {}
            for str in env_list:
                if not str:
                    continue
                if len(str.strip()) == 0:
                    continue
                key,value = str.split("=",1)
                env_map[key] = value
    
            ret_success = env_map["RET"]
            if ret_success != "SUCCESS":
                err_log("ret failure")
                sys.exit()
        
            db_user = env_map["SHENZHOU_DB_USER"]
            db_pwd_str = env_map["SHENZHOU_DB_PWD"]
            db_host = env_map["SHENZHOU_DB_HOST"]
            db_port = env_map["SHENZHOU_DB_PORT"]
            start_date = env_map["SHENZHOU_STARTDATE"]
            
            priFile = CODE_DEPLOY_NAME + '_' + code_version + FS + ENV_OFFICIAL_CONF + FS + "easter.pri"
            if test == "1":
                priFile = CODE_DEPLOY_NAME + '_' + code_version + FS + ENV_TEST_CONF + FS + "easter.pri"
            
            priTargetFile = ROOT_PATH + FS + "easter.pri"
            tarStr = "tar zxvf %s %s -O > %s "%(TARGET_PACK_NAME,priFile,priTargetFile)
            exec_shell(tarStr)
            
            db_pwd = exec_shell("java -cp rsautil.jar com.RSAUtils easter.pri %s"%(db_pwd_str))
            
            exec_shell("rm -rf %s"%(priTargetFile))
            
            success = exec_sql(db_host,db_port,db_user,db_pwd,back_data_name)
            if not success:
                err_log("rollback db failure,db:%s"%(back_data_name) )
                sys.exit()
        
        '''rollback code'''
        """将code资源连接到相关版本"""
        ln_resp = ln(code_version_path,DEPLOY_PATH + FS + CODE_DEPLOY_NAME)
        if ln_resp :
            err_log(ln_resp)
            sys.exit()
    
    success_info= "rollback success"
    if res_version :
        success_info += " resources version=%s" %(res_version)
    if code_version :
        success_info += " code version=%s" %(code_version)
    info_log(success_info)
    
        