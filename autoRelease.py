#encoding:utf-8
#!usr/bin/python
import os


f = open("CYKit.podspec", "r+")
print ("文件名为: ", f.name)
 
shouldModifire = '' 
for line in f.readlines():                          #依次读取每行  
    line = line.strip()                             #去掉每行头尾空白  
    if 's.version = "0' in line:
    	shouldModifire = line
    	break
    print ("读取的数据为: %s" % (line))
#关闭文件
f.close()

#查找到需要修改的行
print('shouldModifire%s'%shouldModifire)
items = shouldModifire.split('=')
print(items)
versions = items[1].split('.')
versions_last_length = len(versions[2])
versions_last = int(versions[2][:versions_last_length-1])
versions_last_int = (versions_last) + 1
newVersion = str(versions[0])+'.'+ str(versions[1]) + '.' + str(versions_last_int) + '"'
shouldReplaceItem = items[0] + '=' + newVersion

#替换相应的版本号，并写入文件
fo = open("CYKit.podspec", "r+")
content = ''
for line  in fo.readlines():
	print('line = %s'%(line))
	content = content + line
print(content)
replaceed = content.replace(shouldModifire,shouldReplaceItem)
print('修改版本号:' + shouldModifire + '=>' +  shouldReplaceItem)


# fo.seek(0)
# fo.truncate()	
# fo.write(replaceed)
# fo.flush()
# fo.close()

#代码提交
os.system('git add .')
os.system('git commit -a -m "【脚本】修改相应版本号"')
os.system('git push origin master')
os.system('git tag -a ' + newVersion + ' -m ' + 'tag版本号')
os.system('git push --tags')


# print('----------')
# print(newVersion)
# print(items)
# modifire(shouldModifire)




	