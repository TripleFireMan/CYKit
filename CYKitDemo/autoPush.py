#encoding:utf-8
#!usr/bin/python
import os
# os.system('pod update')
os.system('git add .')
os.system('git commit -a -m "【功能】：使用脚本自动提交"')
os.system('git push origin master')
