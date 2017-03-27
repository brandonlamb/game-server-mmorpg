#!/usr/bin/python
#-*- encoding: utf8 -*-

'''
    神州服务器代码部署脚本
'''
import os, sys, string
import commands
from sz_func import FS,ROOT_PATH,PACK_PATH,DEPLOY_PATH,SQL_DIR_NAME,ENV_OFFICIAL_CONF,ENV_TEST_CONF,ENV_NAME,ENV_URL
from sz_func import DB_DATA_PATH,DATABASE_NAME,CODE_DEPLOY_NAME,RES_DEPLOY_NAME,db_default_character_set
from sz_func import is_correct_ver_format,exec_shell,ln,get_current_deploy_ver,connect_db,do_ln,exec_sql
from sz_func import err_log,info_log,get_ver_int,check_version,get_pack_path_info,help,check_input

def get_update_sql_list(current_ver,target_ver,sql_full_path):
    result = []
    if current_ver :
      sqls = exec_shell("ls %s |grep .sql$|grep -v \"init\"|sort -t. -k1,1n -k2,2n -k3,3n -k4,4n" %(sql_full_path))
      if not sqls:
        return True,result
      sql_list = sqls.split('\n')
      for sql_file_name in sql_list:
          if not sql_file_name:
            continue
          ''' 4 = len(".sql")'''
          v = sql_file_name[:-4]
          if not is_correct_ver_format(v):
             err_log ('the sql file named error,sqlfile:%s'%(sql_file_name))
             return False,result
          #判断是否在(current_ver-target_ver]间
          v_int_code = get_ver_int(v)
          if v_int_code > get_ver_int(current_ver) and v_int_code <= get_ver_int(target_ver):
              result.append(sql_file_name)
    return True,result

def backup_db(sql_list,db_host,db_port,db_user,db_pwd,current_ver,db_data_path):
    if not sql_list or len(sql_list) == 0:
        '''没有sql脚本更新,不用备份数据库'''
        return True
    if not current_ver :
        return True
    '''back up db'''
    back_data_name = "%s/%s_%s.data" % (db_data_path,DATABASE_NAME,current_ver)
    cmd = "mysqldump -u%s --password=%s --default-character-set=%s -h%s -P %s %s > %s "%(db_user,db_pwd,db_default_character_set,db_host,db_port,DATABASE_NAME,back_data_name)
    resp = exec_shell(cmd)
    if resp :
        err_log(resp)
        '''删除备份文件'''
        exec_shell("rm -rf " + back_data_name)
        return False
    return True


def update_sql(update_list,db_host,db_port,db_user,db_pwd,sql_full_path):
    if not update_list or len(update_list) == 0:
        '''没有sql脚本更新,不用执行sql'''
        return True
    pre_sql_code = 0
    for sql in update_list:
        #执行
	file_name_wihtout_subfix = sql[:-4]
	info_log("exec sql: %s"%(sql))
        curr_sql_code = get_ver_int(file_name_wihtout_subfix)
	if(curr_sql_code <= pre_sql_code):
		err_log("exec sql error: pre_code=%s,current_code=%s,sqlfile=%s"%(str(pre_sqlcode),str(curr_sql_code),sql))
		return False

	pre_sql_code = curr_sql_code

        sql_file_name = sql_full_path + FS + sql
        if not exec_sql(db_host,db_port,db_user,db_pwd,sql_file_name):
            return False
        
    return True
            

'''return is_success,roll_back'''
def deploy_res(res_version,current_ver):
    '''部署资源'''
    info_log("start to deploy res")
    
    is_success = False
    roll_back = False
    
    TARGET_NAME , TARGET_PACK_NAME = get_pack_path_info(res_version,RES_DEPLOY_NAME)
    '''删除原来目录(将要部署的版本,基本上此目录不存在)'''
    exec_shell("rm -rf %s"%(TARGET_NAME))
    '''解压版本'''
    exec_shell("tar -zxf %s -C %s"%(TARGET_PACK_NAME,PACK_PATH))
    
    """将资源连接到相关版本"""
    ln_resp = ln(TARGET_NAME,DEPLOY_PATH + FS + RES_DEPLOY_NAME)
    roll_back = True
    if ln_resp :
        err_log(ln_resp)
        return is_success , roll_back
    
    is_success = True
    info_log("deploy res success")
    return is_success , roll_back
   

def init_env_prop(file_name):
    try:
        macs = exec_shell("/sbin/ifconfig |grep HWaddr|awk '{print $5}'|sort -u")
        if not macs:
            return False
        macs_list = macs.split('\n')
        macAddress = ';'.join(macs_list)
        url = "curl -s '%s?macs=%s&port=10400' > %s"%(ENV_URL,macAddress,file_name)
        exec_shell(url)
        success = exec_shell("cat " + file_name + "| grep 'RET=SUCCESS' | wc -l")
        if success == 0 :
            return False
        return True
    except:
        return False
    
    
'''return is_success,roll_back'''
def deploy_code(code_version,current_ver):
    '''部署代码'''
    info_log("start to deploy code")
    
    TARGET_NAME , TARGET_PACK_NAME = get_pack_path_info(code_version,CODE_DEPLOY_NAME)
                                                        
    is_success = False
    roll_back = False 
    
    macs = exec_shell("/sbin/ifconfig |grep HWaddr|awk '{print $5}'|sort -u")
    if not macs:
        return is_success,roll_back
    macs_list = macs.split('\n')
    macAddress = ';'.join(macs_list)
    url = "curl -s '%s?macs=%s&port=10400'"%(ENV_URL,macAddress)
    info_log("url: %s"%(cul))
    env = exec_shell(url)
    if not env :
        return is_success,roll_back
    
    info_log("============ env ===========")
    info_log(env)
    env_list =  env.split('\n')
    
    env_map = {}
    for str in env_list:
        if not str:
            continue
        if len(str.strip()) == 0:
            continue
        key,value = str.split("=",1)
        env_map[key] = value
    
    success = env_map["RET"]
    if success != "SUCCESS":
        return is_success,roll_back
        
    '''打印环境变量中的配置'''
    test = env_map["SHENZHOU_TEST"]
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
    
    #print "======== the env config ========"
    #print "======== SHENZHOU_TEST = %s"%(test)
    #print "======== HENZHOU_DB_USER = %s"%(db_user)
    #print "======== HENZHOU_DB_PWD = %s"%(db_pwd)
    #print "======== SHENZHOU_DB_HOST = %s"%(db_host)
    #print "======== SHENZHOU_DB_PORT = %s"%(db_port)
    #print "======== SHENZHOU_STARTDATE = %s"%(start_date)
    
    '''测试数据库连接'''
    if not connect_db(db_host,db_port,db_user,db_pwd) :
        err_log( "can't connect to the mysql db" )
        return is_success,roll_back
       
    '''删除原来目录(将要部署的版本,基本上此目录不存在)'''
    exec_shell("rm -rf %s"%(TARGET_NAME))
    '''解压版本'''
    exec_shell("tar -zxf %s -C %s"%(TARGET_PACK_NAME,PACK_PATH))
    
    #获得current_ver - VERSION版本见的sql语句
    sql_full_path = TARGET_NAME + FS + SQL_DIR_NAME
    success,sql_list = get_update_sql_list(current_ver,code_version,sql_full_path)
    if not success:
        #sql 命名错误
        return is_success,roll_back
    
    '''在代码部署目录内建立到父目录的资源软链'''
    """在代码部署路径中连接资源目录(和资源版本无关)"""
    ln_success = do_ln(DEPLOY_PATH + FS + RES_DEPLOY_NAME , TARGET_NAME + FS + RES_DEPLOY_NAME )
    if not ln_success :
        return is_success,roll_back
    
    ''' ln env '''
    env_real_path = TARGET_NAME + FS + ENV_OFFICIAL_CONF
    if test == "1":
       env_real_path = TARGET_NAME + FS + ENV_TEST_CONF
    
    env_path = TARGET_NAME + FS + ENV_NAME
    ln_success = do_ln(env_real_path,env_path)
    if not ln_success :
        return is_success,roll_back

    '''
    ln area-ice.client
    ln easterrun.sh
    ln stopserver.sh
    ln shutdown-ice.client
    '''
    ln1 = do_ln(env_path + FS + "area-ice.client", TARGET_NAME + FS + "area-ice.client")
    ln2 = do_ln(env_path + FS + "easterrun.sh", TARGET_NAME + FS + "easterrun.sh")
    ln3 = do_ln(env_path + FS + "stopserver.sh", TARGET_NAME + FS + "stopserver.sh")
    ln4 = do_ln(env_path + FS + "shutdown-ice.client", TARGET_NAME + FS + "shutdown-ice.client")
    if not ln1 or not ln2 or not ln3 or not ln4:
        return is_success,roll_back
    
    '''生成env.properties'''
    env_prop_name = TARGET_NAME + FS + "env.properties"
    if not init_env_prop(env_prop_name):
        err_log("init env.properties failure")
        return is_success,roll_back
    
    
    if sql_list and current_ver:
        #有sql更新并且非第一次部署,备份数据库
        info_log("start backup database")
        backup_success = backup_db(sql_list,db_host,db_port,db_user,db_pwd,current_ver,DB_DATA_PATH)
        if not backup_success:
            err_log("backup database failure")
            return is_success,roll_back
       
        roll_back = True
        #更新数据库
        update_sql_success = update_sql(sql_list,db_host,db_port,db_user,db_pwd,sql_full_path)
        if not update_sql_success:
            err_log("update sql failure")
            return is_success,roll_back
    
    """将代码连接到相关版本"""
    ln_code_success = do_ln(TARGET_NAME,DEPLOY_PATH + FS + CODE_DEPLOY_NAME)
    roll_back = True
    if not ln_code_success :
        return is_success,roll_back
    
    info_log("deploy code success")
    is_success = True
    return is_success,roll_back

if __name__ == '__main__':
    '''check input '''
    is_correct,code_version,res_version = check_input(sys.argv)
    if not is_correct:
        help(sys.argv[0],"deploy")
        sys.exit()
        
    current_code_version = ''
    current_res_version = ''
    '''
    检测相关版本输入
    1.版本号是否存在
    2.输入版本号>=目前部署版本号
    '''
    if res_version :
        resp_info ,current_res_version = check_version(res_version,RES_DEPLOY_NAME)
        if resp_info :
            err_log ("check resource version failure:")
            err_log (resp_info)
            is_correct = False
            
    if code_version :
        resp_info ,current_code_version = check_version(code_version,CODE_DEPLOY_NAME)
        if resp_info :
            err_log ("check code version failure:")
            err_log (resp_info)
            is_correct = False
    
    if not is_correct:
        '''告知相关输入参数不正确(不存在或者比当前版本小)'''
        '''此时不需要进行部署恢复操作'''
        err_log("!!!!!!!!!!!!! FAILURE !!!!!!!!!!!!!!")
        sys.exit()
    
    '''same tips for current version and rollback '''
    info_log("=======================================")
    start_tips = "start to deploy,current res version=%s current code version=%s" %(current_res_version,current_code_version)
    info_log(start_tips)
    
    if current_res_version or current_code_version:
        info_log("if deploy failure,please exec the follow cmd to rollback:")
        roll_back_cmd = "python sz_rollback.py"
        if current_res_version :
           roll_back_cmd += " -r %s" %(current_res_version)
        if current_code_version :
           roll_back_cmd += " -c %s" %(current_code_version)
        info_log(roll_back_cmd)

    info_log("=======================================")

    if res_version:
        is_success , roll_back_res = deploy_res(res_version,current_res_version)
        if not is_success :
            err_log("deploy resources failure:")
            err_log("!!!!!!!!!!!!! FAILURE !!!!!!!!!!!!!!")
            sys.exit()
    
    if code_version:
        is_success , roll_back_code = deploy_code(code_version,current_code_version)
        if not is_success :
            err_log("deploy code failure:")
            err_log("!!!!!!!!!!!!! FAILURE !!!!!!!!!!!!!!")
            sys.exit()


    success_info= "deploy success"
    if res_version :
        success_info += " resources version=%s" %(res_version)
    if code_version :
        success_info += " code version=%s" %(code_version)
    info_log(success_info)
    
   
