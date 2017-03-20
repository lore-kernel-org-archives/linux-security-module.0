From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Mon, 20 Mar 2017 13:27:04 +0900
Subject: [PATCH RFC 1/9] LSM: Add /sys/kernel/security/lsm
In-Reply-To: <673eb042-0f74-0af9-73ca-b2c15a8a89b9@schaufler-ca.com>
References: <4856407a-3c94-362f-d548-5228c09c84be@schaufler-ca.com>
	<201703172152.GBD04133.QLOSVFJHOOMtFF@I-love.SAKURA.ne.jp>
	<fd0fe8c8-9c0d-ce5e-fa9e-e521d8bb0f93@schaufler-ca.com>
	<201703181653.IJE26029.OHMOOFJLFVFSQt@I-love.SAKURA.ne.jp>
	<673eb042-0f74-0af9-73ca-b2c15a8a89b9@schaufler-ca.com>
Message-ID: <201703201327.GCB35413.LFMOQVSHtFOOFJ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> On 3/18/2017 12:53 AM, Tetsuo Handa wrote:
> > But looking at PATCH 5/9, do we really want to use "context" format?
> > TOMOYO uses $name=$value encoding which can include arbitrary characters
> > and thus allows simple tokenizing using a whitespace like
> >
> >   lsm1=v1 lsm2=v2 lsm3=v3
> >
> > but you are trying to introduce
> >
> >   lsm1='v1'lsm2='v2'lsm3='v3'
> >
> > format at the cost of giving up ability to include arbitrary characters
> > (e.g. '\n'), aren't you?
> 
> I am open (yet again, I've asked for input several times before)
> to suggestions, but there has to be a way to represent the complete
> "context" in a finite way. This is my best effort at doing so.
> 
> > If userspace has to concatenate strings like
> >
> >   lsm1='v1'lsm2='v2'lsm3='v3'
> >
> > and write to single file at one time like
> >
> >   echo lsm1='v1'lsm2='v2'lsm3='v3' > /proc/$pid/attr/context
> >
> > , userspace can simply do
> >
> >   echo $v1 > /proc/$pid/attr/$lsm1/$name
> >   echo $v2 > /proc/$pid/attr/$lsm2/$name
> >   echo $v3 > /proc/$pid/attr/$lsm3/$name
> 
> This isn't atomic, and while it is possible to
> do it thus, there can be races in global policy.

If I didn't overlook something, PATCH 5/9 does not make
security_setprocattr() do something like

  cred = prepare_creds();
  for_each_module_which_matches_given_names() {
    cred->per_module_data = new_value_for_that_module;
  }
  commit_creds(cred);

. Therefore, while copying data to /proc interface is atomic,
processing the copied data is not atomic. Same thing is possible
by doing

  base_fd = open("/proc/$pid/attr/");
  fd_lsm1 = openat(base_fd, "$lsm1/$name");
  write(fd_lsm1, "$v1");
  close(fd_lsm1);
  fd_lsm2 = openat(base_fd, "$lsm2/$name");
  write(fd_lsm2, "$v2");
  close(fd_lsm2);
  fd_lsm3 = openat(base_fd, "$lsm3/$name");
  write(fd_lsm3, "$v3");
  close(fd_lsm3);
  close(base_fd);

.

> Also, it would require user-space to know about
> the available modules, and part of what
> /proc/$pid/attr/context gets you is the ability
> to fetch the process security data the same way
> in all cases. Very useful for "id".
> 
> > which will not need to exclude characters like '\n'.
> 
> I can't see ps, ls or id being at all happy
> with security attributes containing newlines,
> formfeeds, bells or backspaces. There's a reason
> Smack labels have a restricted character set.
> 
> > If there were hundreds of modules, the overhead might matter.
> > But given that there will be only few modules which use these
> > interfaces, I think userspace can tolerate such multiple writes.
> >
> Multiple writes aren't atomic.

PATCH 5/9 does multiple writes which aren't atomic.

> I'm much more concerned with multiple reads.
> lsm-1='data-1',...,lsm-n='data-n'
> is as good a representation as I can come up with.
> Please propose a better one. I don't think that 
> anything requiring sophisticated parsing is viable.

TOMOYO uses /sys/kernel/security/tomoyo/.process_status for reading all
process's information without opening every /proc/$pid/attr/ interface.

If you put priority on readers, I think prctl() interface might fit better.
When there are hundreds/thousands of processes, opening each
/proc/$pid/attr/context interface only for one read() request is a big
overhead.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
