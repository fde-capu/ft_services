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

def piped_output(cmd):
	ps = subprocess.Popen(cmd, shell = True, stdout = subprocess.PIPE, stderr = subprocess.STDOUT)
	re = ps.communicate()[0]
	return re.decode('utf-8')

ip = str(sys.argv[1])
nginx = piped_output('kubectl get svc | grep nginx | awk \'{printf "%s", $4}\'')
ftps = piped_output('kubectl get svc | grep ftps | awk \'{printf "%s", $4}\'')
pma = piped_output('kubectl get svc | grep phpmyadmin | awk \'{printf "%s", $4}\'')
wp = piped_output('kubectl get svc | grep wordpress | awk \'{printf "%s", $4}\'')

user = str(sys.argv[2])
pasw = str(sys.argv[3])
home = str(os.environ['HOME'])
cwd = str(os.getcwd()) + '/ctl'

if ip == '🤷' or user == '' or pasw == '':
	alert('Syntax error?\nIs the cluster running?\nnginx:`' + nginx + '`, user:`' + user + '`, pasw:`' + pasw + '`.')
	exit()

STRING_TRUNCATE = 35
MESSAGE = 1
ANSWER = 2
FAIL = 3
INTERACTIVE = 4
TEST = 5

ans = [ \
	[MESSAGE,	'Testing nginx'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx, '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx, '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx, '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx, '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx, '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx, '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx, '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx, '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + nginx, '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx, '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx, '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx, '200'], \

	[MESSAGE,	'Testing nginx:80'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx + ':80', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx + ':80', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx + ':80', '35'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx + ':80', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx + ':80', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx + ':80', '35'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx + ':80', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx + ':80', '301'], \
	[FAIL,		'curl -o /dev/null -ksw "%{http_code}" https://' + nginx + ':80', '35'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx + ':80', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx + ':80', '200'], \
	[FAIL,		'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx + ':80', '35'], \

	[MESSAGE,	'Testing nginx:443'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx + ':443', '302'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx + ':443', '302'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx + ':443', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx + ':443', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx + ':443', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx + ':443', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx + ':443', '302'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx + ':443', '302'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + nginx + ':443', '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx + ':443', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx + ':443', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx + ':443', '200'], \

	[MESSAGE,	'Testing nginx/phpmyadmin'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx + '/phpmyadmin', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx + '/phpmyadmin', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx + '/phpmyadmin', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx + '/phpmyadmin', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx + '/phpmyadmin', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx + '/phpmyadmin', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx + '/phpmyadmin', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx + '/phpmyadmin', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + nginx + '/phpmyadmin', '301'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx + '/phpmyadmin', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx + '/phpmyadmin', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx + '/phpmyadmin', '200'], \

	[MESSAGE,	'Testing nginx/phpmyadmin/'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx + '/phpmyadmin/', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx + '/phpmyadmin/', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx + '/phpmyadmin/', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx + '/phpmyadmin/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx + '/phpmyadmin/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx + '/phpmyadmin/', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx + '/phpmyadmin/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx + '/phpmyadmin/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + nginx + '/phpmyadmin/', '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx + '/phpmyadmin/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx + '/phpmyadmin/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx + '/phpmyadmin/', '200'], \

	[MESSAGE,		'Testing ssh into Nginx'], \
	[INTERACTIVE,	'ssh ' + user + '@' + nginx + ' uname', [['(yes/no)?', 'yes'], ['password', pasw]], 'Linux', 1], \
	[INTERACTIVE,	'ssh ' + user + '@' + nginx + ' cat /etc/issue | head -1', [['password', pasw]], 'Alpine', 3], \

	[MESSAGE,		'Testing ftps'], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ftps + ' -e "pwd -p && bye"', [], 'ftp://' + user + ':' + pasw + '@' + ftps, 0], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ftps + ' -e "put ' + cwd + '/ftps-test_file.txt && bye"', [['put', '']], 'Fatal', 2], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ftps + ' -e "set ssl:verify-certificate no && put ' + cwd + '/ftps-test_file.txt && bye"', [], 'transferred', -1], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ftps + ' -e "set ssl:verify-certificate no && put ' + cwd + '/ftps-test_file.txt -o / && bye"', [], '553', -6], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ftps + ' -e "get ftps-test_file.txt -o ' + cwd + '/test-ok.txt && bye"', [], 'trusted', -2], \
	[INTERACTIVE,	'lftp ' + user + ':' + pasw + '@' + ftps + ' -e "set ssl:verify-certificate no && get ftps-test_file.txt -o ' + cwd + '/test-ok.txt && bye"', [], 'transferred', -1], \

	[MESSAGE,	'Testing phpmyadmin'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + pma + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + pma + ':5000', '400'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + pma + ':5000', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" ' + pma + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" http://' + pma + ':5000', '400'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + pma + ':5000', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + pma + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + pma + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + pma + ':5000', '200'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + pma + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + pma + ':5000', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + pma + ':5000', '200'], \

	[MESSAGE,	'Testing wordpress'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + wp + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + wp + ':5050', '400'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + wp + ':5050', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" ' + wp + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -Lsw "%{http_code}" http://' + wp + ':5050', '400'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + wp + ':5050', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + wp + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + wp + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + wp + ':5050', '302'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + wp + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + wp + ':5050', '400'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + wp + ':5050', '200'], \

	[MESSAGE,	'Testing nginx/wordpress'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx + '/wordpress', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx + '/wordpress', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx + '/wordpress', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx + '/wordpress', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx + '/wordpress', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx + '/wordpress', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx + '/wordpress', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx + '/wordpress', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + nginx + '/wordpress', '307'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx + '/wordpress', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx + '/wordpress', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx + '/wordpress', '200'], \

	[MESSAGE,	'Testing nginx/wordpress/'], \
	[MESSAGE,	'...do not redirect, do not ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" ' + nginx + '/wordpress/', '301'], \
	[ANSWER,	'curl -o /dev/null -sw "%{http_code}" http://' + nginx + '/wordpress/', '301'], \
	[FAIL,		'curl -o /dev/null -sw "%{http_code}" https://' + nginx + '/wordpress/', '60'], \
	[MESSAGE,	'...redirect, do not ignore self-signed certificate:'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" ' + nginx + '/wordpress/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" http://' + nginx + '/wordpress/', '60'], \
	[FAIL,		'curl -o /dev/null -Lsw "%{http_code}" https://' + nginx + '/wordpress/', '60'], \
	[MESSAGE,	'...do not redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" ' + nginx + '/wordpress/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" http://' + nginx + '/wordpress/', '301'], \
	[ANSWER,	'curl -o /dev/null -ksw "%{http_code}" https://' + nginx + '/wordpress/', '307'], \
	[MESSAGE,	'...redirect, ignore self-signed certificate:'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" ' + nginx + '/wordpress/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" http://' + nginx + '/wordpress/', '200'], \
	[ANSWER,	'curl -o /dev/null -kLsw "%{http_code}" https://' + nginx + '/wordpress/', '200'], \

	[MESSAGE,	'Checking if Wordpress has a preset server is impossible afaik.'], \
	[MESSAGE,	'Therefore, mysql must have been preconfigured with initial wordpress database.'], \
	[MESSAGE,	'If it was mandatory to ssh->nginx->mysql->mysqlDB, it could be tested.'], \
	[MESSAGE,	'Since this is what I have done, here are the unit tests (mysql container is named "mysql"):'], \
	[INTERACTIVE, 'ssh ' + user + '@' + nginx + ' mysql -h "mysql -u' + user + ' -p' + pasw + ' -e \'use wordpresx;\'"', [['password', pasw]], 'ERROR', 1], \
	[INTERACTIVE, 'ssh ' + user + '@' + nginx + ' mysql -h "mysql -u' + user + ' -p' + pasw + ' -e \'use wordpress;\'"', [['password', pasw]], ':', 0], \
	[MESSAGE,	'Still, user should not see "localhost" as the default wp server in case the initial configuration is left open.'], \

	[MESSAGE,	'Verify influxdb database. Service must be called "influxdb", database must be called "telegraf"* and curl must be installed on nginx container.\n*) I speak Portuguese and do not care for the Oxford comma.'], \
	[INTERACTIVE, 'ssh ' + user + '@' + nginx + ' curl -sG \'influxdb:8086/query --data-urlencode "q=show databases;"\' | grep telegraf', [['password', pasw]], '{"results":[{"statement_id":0,"series":[{"name":"databases","columns":["name"],"values":[["telegraf"],["_internal"]]}]}]}', 1], \
	[INTERACTIVE, 'ssh ' + user + '@' + nginx + ' curl -sG \'influxdb:8086/query --data-urlencode "q=show databases;"\' | grep telegrax', [['password', pasw]], ':', 0], \
]

title('\nUnit test : by fde-capu\n')

title('Removing existing trusted certificate from ' + home + '/.ssh/known_hosts:')
remove_ssh = 'ssh-keygen -R ' + nginx + ''
print('`' + remove_ssh + '`')
try:	subprocess.check_output(remove_ssh.split())
except:	message('Somthin bout mkstemp?')
else:	print('Done.')

title('Preparing ambient.')
preparation = ['rm -f ' + cwd + '/ftps-test_file.txt', 'rm -f test-ok.txt']
for p in preparation:
	child = pexpect.spawn(p)
f = open(cwd + "/ftps-test_file.txt", "a")
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
		try:
			result = result.split()[n[4]]
		except:
			alert('Missmatch')
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
