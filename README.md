# Gather

Gather up multi-line output from a individual hosts using knife ssh

## Preface

Present all lines of output from a single host together when using parallel execution in knife ssh.

## What it does

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


## This is a mess, yo
Well, this one isn't horrible.  I might do something using the ui interface to the output, but this was enough to accomplish what I needed today.  Parallel knife ssh is awesome, but I hate scrolling around collating output by host.
