#encoding:utf-8
#!usr/bin/python
import os
os.system('git add .')
os.system('git commit -a -m "【脚本】脚本自动提交"')
os.system('git push origin master')