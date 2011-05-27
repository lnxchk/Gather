Gather

Gather up multi-line output from a individual hosts using knife ssh

* Preface

Present all lines of output from a single host together when using parallel execution in knife ssh.

* What it does

knife gather QUERY COMMAND

Waits for all data from all hosts in the run to return, then collects it up by host. Prints it out 
in stanzas, which right now look like:

$ knife gather fqdn:box0* "rpm -qa kernel" 
box01.example.com: 
  kernel-2.6.18-128.el5
  kernel-2.6.18-128.1.10.el5
  kernel-2.6.18-238.9.1.el5

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
box02.example.com: 
  kernel-2.6.18-194.32.1.el5

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
box03.example.com: 
  kernel-2.6.18-128.el5
  kernel-2.6.18-238.9.1.el5
  kernel-2.6.18-164.11.1.el5

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
box04.example.com: 
  kernel-2.6.18-128.el5
  kernel-2.6.18-164.6.1.el5

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

* Notes on the *2 in here
ssh2.rb is a version of chef/knife/ssh I'm working on that outputs like
gather.rb.  It actually does a better job of it, particularly if you're doing
something like running a "service blah reload" on some rhel or centos
machines.  The default output from knife ssh breaks up the [ OK ] onto
different lines, which is crazypants.  ssh2.rb will print it out sanely.
gather2.rb is the driver. Drop both files in your plugins/knife dir, update
the require line in gather2.rb and use gather2 like gather.

(i swear i will learn to properly package this stuff someday)

So, the difference is:

** Original Knife ssh:
$ knife ssh "fqdn:admin02.smq*" "sudo su -  -c 'service named reload'"
admin02.smq.example.com Reloading named: 
admin02.smq.example.com 
admin02.smq.example.com [
admin02.smq.example.com 
admin02.smq.example.com   OK  
admin02.smq.example.com 
admin02.smq.example.com ]
admin02.smq.example.com 
admin02.smq.example.com 
$


** Knife ssh with gather v1:
$ knife gather "fqdn:admin02.smq*" "sudo su -  -c 'service named reload'"

admin02.smq.example.com: 
Reloading named: 

[

OK  

]

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$

** Knife ssh2 driven by gather2:
$ knife gather2 "fqdn:admin02.smq*" "sudo su -  -c 'service named reload'"
admin02.smq.example.com
Reloading named:                                           [  OK  ]
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$

Output for other commands should be the same as gather v1.  I'm seeing odd
behavior when using pipes and special characters in the COMMAND part of the knife ssh, but I'm not
sure if I've got my current environment wacked out with the stuff i'm working on. I'm going to look at that.

* This is a mess, yo
Well, this one isn't horrible.  I might do something using the ui interface to the output, but this was enough to accomplish what I needed today.  Parallel knife ssh is awesome, but I hate scrolling around collating output by host.

