#encoding:utf-8
#!usr/bin/python
import os


f = open("CYKit.podspec", "r+")
print ("文件名为: ", f.name)
 
shouldModifire = '' 
content = ''
for line in f.readlines():                          #依次读取每行  
    content = content + line
    line = line.strip()                             #去掉每行头尾空白  
    if 's.version = "0' in line:
    	shouldModifire = line
    


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
replaceed = content.replace(shouldModifire,shouldReplaceItem)
print('修改版本号:' + shouldModifire + '=>' +  shouldReplaceItem)

#写入文件
f.seek(0)
f.truncate()	
f.write(replaceed)
f.flush()
#关闭文件
f.close()

#代码提交
os.system('git add .')
os.system('git commit -a -m "【脚本】修改相应版本号"')
os.system('git push origin master')
os.system('git tag -a ' + newVersion + ' -m ' + 'tag版本号')
os.system('git push --tags')
#提交到cocoapods
os.system('pod trunk push --allow-warnings --verbose')





	