#! /usr/bin/python
# coding=utf-8

'''所有使用的字符编码'''
CHARACTER_SET = 'utf8'

''' 服务器数据库ip地址 '''
SOURCE_IP = '192.168.1.230'

''' 服务器数据库端口 '''
SOURCE_PORT = '8888'

'''map结构id'''
FLUSH_MAP_ID = [
    'ROLE_ARENA_HEROS:S',
    'HERO_ARENA_RECORD:S',
    'HERO_EQUIP_RECORD:S',
    'MEDAL_ROLE_DATA:S',
    'ASYNCPVP_ROLEATTR:S',
    'ROLEHORSE_ONBATTLE:S',
    'ROLE_PET_BATTLE:S',
    'PET_STATUS:S',
    'PET_SHOW:S',
    'QUALIFY_RECORD:S',
]

'''set结构id'''
FLUSH_SET_ID = [
    'ROLE_BATTLESCORE:S',
    'ROLE_ASYNCARENA:S',
    'PET_BATTLESORE:S',
]

import sys
from ssdb import SSDB

class Clear(object):
    def __init__(self, id):
        self.check_param()

        self.mapId_list = []
        self.setId_list = []

        for param in FLUSH_MAP_ID:
            self.mapId_list.append(param + id)

        for param in FLUSH_SET_ID:
            self.setId_list.append(param + id)

        self.ssdb = SSDB(host=SOURCE_IP, port=SOURCE_PORT)

    def check_param(self):
        if CHARACTER_SET == "" or SOURCE_IP == "" or SOURCE_PORT == "":
            print("Check Clear Parameters!")
            sys.exit()

        for param in FLUSH_MAP_ID:
            if param == "":
                print("Check Clear Parameters!")

        for param in FLUSH_SET_ID:
            if param == "":
                print("Check Clear Parameters!")

    def show_config(self):
        print("")
        print("SOURCE_IP = %s" % SOURCE_IP)
        print("SOURCE_PORT = %s" % SOURCE_PORT)
        print("")

        index = 1
        for param in self.mapId_list:
            print("mapId%s = %s,Size = %s" % (index, param, self.ssdb.hsize(param)))
            index = index + 1
        print("")

        index = 1
        for param in self.setId_list:
            print("setId%s = %s,Size = %s" % (index, param, self.ssdb.zsize(param)))
            index = index + 1
        print("")

    def clear_data(self):

        for param in self.mapId_list:
            self.ssdb.hclear(param)
            print("Clear %s Success!" % (param))

        for param in self.setId_list:
            self.ssdb.zclear(param)
            print("Clear %s Success!" % (param))

        print("Clear SSDB Success!")


if __name__ == "__main__":
    # 打印所有配置
    clear = Clear(sys.argv[1])
    clear.show_config()
    # 二次确认是否清除数据
    command = raw_input("All configs.Go on input 'y'.")
    if command != 'y':
        print("Bye!")
        sys.exit()
    clear.clear_data()
