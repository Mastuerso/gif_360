#!/usr/bin/env python
import subprocess

user_cmd = [ 'whoami' ]
user = subprocess.Popen(user_cmd, stdout=subprocess.PIPE).communicate()[0]
user = user.strip()

arg1 = '/home/%s/gif_360/main/cam_setup.sh'%(user)
cmd = [ 'bash', arg1 ]
cameras = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]

arg2 = '/home/%s/gif_360/main/auto_config.sh'%(user)
calib_cmd = [ 'bash', arg2, cameras ]
subprocess.Popen(calib_cmd, stdout=subprocess.PIPE).communicate()[0]
print "Done"
