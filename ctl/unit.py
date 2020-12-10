import os
import subprocess
import sys
import json
import pexpect
import re

# # #
# Make sure all containers are up and running.
# # #

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def		alert(string):
	print (bcolors.FAIL + '>>> ' + str(string) + ' <<<' + bcolors.ENDC)
	return

def		noice(string):
	print (bcolors.OKBLUE + '>>> ' + str(string) + ' <<<' + bcolors.ENDC)
	return

def		message(string):
	print (bcolors.WARNING + '' + str(string) + '' + bcolors.ENDC + ':', flush = True)
	return

def		title(string):
	print (bcolors.BOLD + '' + str(string) + ' ' + bcolors.ENDC, flush = True)
	return

ip = str(sys.argv[1])
user = str(sys.argv[2])
pasw = str(sys.argv[3])
home = str(os.environ['HOME'])

STRING_TRUNCATE = 35
MESSAGE = 1
ANSWER = 2
FAIL = 3
INTERACTIVE = 4
TEST = 5
FOO = False

ans = [ \
	[MESSAGE,	'Testing nginx'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip, '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip, '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip, '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip, '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip, '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip, '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip, '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip, '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip, '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip, '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip, '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip, '200'], \

	[MESSAGE,	'Testing nginx:80'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + ':80', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + ':80', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + ':80', '35'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip + ':80', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + ':80', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + ':80', '35'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + ':80', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + ':80', '301'], \
	[FAIL,		'curl -o /dev/null -ksw "%{http_code}" https://' + ip + ':80', '35'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + ':80', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + ':80', '200'], \
	[FAIL,		'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + ':80', '35'], \

	[MESSAGE,	'Testing nginx:443'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + ':443', '302'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + ':443', '302'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + ':443', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip + ':443', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + ':443', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + ':443', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + ':443', '302'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + ':443', '302'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + ':443', '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + ':443', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + ':443', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + ':443', '200'], \

	[MESSAGE,	'Testing nginx:5000'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + ':5000', '400'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + ':5000', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" ' + ip + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + ':5000', '400'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + ':5000', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + ':5000', '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + ':5000', '200'], \

	[MESSAGE,	'Testing nginx/phpmyadmin'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + '/phpmyadmin', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + '/phpmyadmin', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + '/phpmyadmin', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip + '/phpmyadmin', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + '/phpmyadmin', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + '/phpmyadmin', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + '/phpmyadmin', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + '/phpmyadmin', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + '/phpmyadmin', '301'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + '/phpmyadmin', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + '/phpmyadmin', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + '/phpmyadmin', '200'], \

	[MESSAGE,	'Testing nginx/phpmyadmin/'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + '/phpmyadmin/', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + '/phpmyadmin/', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + '/phpmyadmin/', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip + '/phpmyadmin/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + '/phpmyadmin/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + '/phpmyadmin/', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + '/phpmyadmin/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + '/phpmyadmin/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + '/phpmyadmin/', '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + '/phpmyadmin/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + '/phpmyadmin/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + '/phpmyadmin/', '200'], \

	[MESSAGE,		'Testing ssh into Nginx'], \
	[INTERACTIVE,	'ssh ' + user + '@' + ip + ' uname', [['(yes/no)?', 'yes'], ['password', pasw]], 'Linux', 1], \

	[MESSAGE,		'Testing ftps'], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ip + ' -e "pwd -p && bye"', [], 'ftp://' + user + ':' + pasw + '@' + ip, 0], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ip + ' -e "put ftps-test_file.txt && bye"', [['put', '']], 'Fatal', 2], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ip + ' -e "set ssl:verify-certificate no && put ftps-test_file.txt && bye"', [], 'transferred', -1], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ip + ' -e "set ssl:verify-certificate no && put ftps-test_file.txt -o / && bye"', [], '553', -6], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ip + ' -e "get ftps-test_file.txt -o test-ok.txt && bye"', [], 'trusted', -2], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ip + ' -e "set ssl:verify-certificate no && get ftps-test_file.txt -o test-ok.txt && bye"', [], 'transferred', -1], \

	[MESSAGE,	'Testing nginx:5050'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + ':5050', '400'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + ':5050', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" ' + ip + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + ':5050', '400'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + ':5050', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + ':5050', '302'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + ':5050', '200'], \

	[MESSAGE,	'Testing nginx/wordpress'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + '/wordpress', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + '/wordpress', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + '/wordpress', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip + '/wordpress', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + '/wordpress', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + '/wordpress', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + '/wordpress', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + '/wordpress', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + '/wordpress', '307'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + '/wordpress', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + '/wordpress', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + '/wordpress', '200'], \

	[MESSAGE,	'Testing nginx/wordpress/'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + ip + '/wordpress/', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + ip + '/wordpress/', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + ip + '/wordpress/', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + ip + '/wordpress/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + ip + '/wordpress/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + ip + '/wordpress/', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + ip + '/wordpress/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + ip + '/wordpress/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + ip + '/wordpress/', '307'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + ip + '/wordpress/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + ip + '/wordpress/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + ip + '/wordpress/', '200'], \

	[MESSAGE,	'Checking if Wordpress has a preset server is impossible.'], \
	[MESSAGE,	'User should not see localhost as the default wp server, it should point to mysql db.'], \
	[MESSAGE,	'mysql must have been preconfigured with initial wp_ lists.'], \


]

title('\nUnit test : by fde-capu\n')

title('Removing existing trusted certificate from ' + home + '/.ssh/known_hosts:')
remove_ssh = 'ssh-keygen -R ' + ip + ''
print('`' + remove_ssh + '`')
try:	subprocess.check_output(remove_ssh.split())
except:	message('Somthin bout mkstemp?')
else:	print('Done.')

title('Preparing ambient.')
preparation = ['rm -f ftps-test_file.txt', 'rm -f test-ok.txt']
for p in preparation:
	child = pexpect.spawn(p)
f = open("ftps-test_file.txt", "a")
f.write("ftp-test_file.txt content inside!")
f.close()
print('Done.')

#exit()

def	summary(string):
	ss = str(string)
	if len(ss) > STRING_TRUNCATE:
		return ss[:STRING_TRUNCATE] + '...'
	else:
		return ss

def try_answer(n):
	try:
		test = json.loads(subprocess.check_output(cmd.split()))
	except subprocess.CalledProcessError as error:
		errno = str(error.returncode)
		alert('Fail, should get: ' + n[2] + ', got errno=' + errno)
	else:
		if n[2] == test:
			noice(test)
		else:
			alert('Fail: ' + summary(n[2]) + ', got ' + summary(test))

def	try_fail(n):
	try:
		test = json.loads(subprocess.check_output(cmd.split()))
	except subprocess.CalledProcessError as error:
		errno = str(error.returncode)
		if n[2] == errno:
			noice('Error ok: ' + errno)
		else:
			alert('Fail (errno): ' + n[2] + ': got ' + errno)
	else:
		alert('Would have to fail, got: ' + summary(test))

def	try_interactive(n):
	child = pexpect.spawn(n[1])
	for interact in n[2]:
		if interact[0] != '':
			child.expect(interact[0])
			child.sendline(interact[1])
		else:
			child.sendline(interact[1])
	result = str(child.read().decode('utf-8'))
	if attr(n, 4):
		result = result.split()[n[4]]
	if result == n[3]:
		noice(result)
	else:
		alert('Expected: ' + n[3] + ', got ' + str(result))
	return

def attr(n, v):
	return len(n) > v

for i, n in enumerate(ans):
	if n[0] == '':							continue
	if n[0] == MESSAGE:						title(n[1]); continue
	if attr(n, 3) and n[0] != INTERACTIVE:	message(n[3])
	if n[0] == INTERACTIVE and attr(n, 5):	message(n[5])
	cmd = n[1]
	print('`' + cmd + '`', end = ' ', flush = True)
	if n[0] == ANSWER:	try_answer(n)
	if n[0] == FAIL:	try_fail(n)
	if n[0] == INTERACTIVE:	try_interactive(n)
	if n[0] == TEST:	try_test(n)

title('Cleaning')
for p in preparation:
	child = pexpect.spawn(p)
print('Done.')

title('All tests done!')
