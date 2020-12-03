import os
import subprocess
import sys
import json
import pexpect
import re

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
	print (bcolors.FAIL + '>>> ' + string + ' <<<' + bcolors.ENDC)
	return

def		noice(string):
	print (bcolors.OKBLUE + '>>> ' + string + ' <<<' + bcolors.ENDC)
	return

def		message(string):
	print (bcolors.WARNING + '' + string + '' + bcolors.ENDC + ':', flush = True)
	return

def		title(string):
	print (bcolors.BOLD + '\n' + string + ' ' + bcolors.ENDC, flush = True)
	return

ip = str(sys.argv[1])
user = str(sys.argv[2])
pasw = str(sys.argv[3])
home = str(os.environ['HOME'])

MESSAGE = 1
ANSWER = 2
FAIL = 3
INTERACTIVE = 4
FOO = False

ans = [ \
	[MESSAGE, 'Testing ftps'], \
	[ANSWER, 'curl -o /dev/null -sw "%{http_code}" ' + ip, '301'], \
	[FAIL, 'curl -sL ' + ip, '60'], \
	[ANSWER, 'curl -o /dev/null -sLkw "%{http_code}" ' + ip + '', '200'], \
	[ANSWER, 'curl -o /dev/null -sLkw "%{http_code}" ' + ip + ':443', '200'], \
	[ANSWER, 'curl -o /dev/null -sLkw "%{http_code}" ' + ip + ':80', '200'], \
	[INTERACTIVE, 'ssh ' + user + '@' + ip + ' uname', 'Linux'], \
	['', ''], \
	['', ''], \
	['', ''], \
]

print('\nUnit test')
print('Removing existing trusted certificate from ' + home + '/.ssh/known_hosts: (in case there is)')
subprocess.call(('ssh-keygen "' + home + '/.ssh/known_hosts" -R "' + ip + '"').split())
print('Done.')

def	resumestr(string):
	ss = str(string)
	if len(ss) > 25:
		return ss[:15] + '...'
	else:
		return ss

def try_answer(n):
	try:
		test = json.loads(subprocess.check_output(cmd.split()))
	except subprocess.CalledProcessError as error:
		alert('Fail, should get: ' + n[2] + ', got errno=' + errno)
	else:
		if n[2] == test:
			noice(test)
		else:
			alert('Fail: ' + resumestr(n[1]) + ', got ' + resumestr(test))

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
		alert('Would have to fail, got: ' + resumestr(test))

def	try_interactive(n):
	child = pexpect.spawn(n[1])
	child.expect('password')
	child.sendline(pasw)
	result = str(child.read().decode('utf-8')).split()[1]
	if result == n[2]:
		noice(result)
	else:
		alert('Expected: ' + n[2] + ', got ' + result)
	return

def attr(n, v):
	return len(n) > v

for i, n in enumerate(ans):
	if n[0] == '':						continue
	if n[0] == MESSAGE:	title(n[1]);	continue
	if attr(n, 3):	message(n[3])
	cmd = n[1]
	print('`' + cmd + '`', end = ' ', flush = True)
	if n[0] == ANSWER:	try_answer(n)
	if n[0] == FAIL:	try_fail(n)
	if n[0] == INTERACTIVE:	try_interactive(n)

title('All tests done')
