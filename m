From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Fri, 24 Mar 2017 21:27:48 +0900
Subject: [PATCH] LSM: Revive security_task_alloc() hook and per "struct
	task_struct" security blob.
In-Reply-To: <20170324131144.3ef645b6@d-jobol.iot.bzh>
References: <1490355993-15773-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<20170324131144.3ef645b6@d-jobol.iot.bzh>
Message-ID: <201703242127.HIE04181.SMtFFOFLJHOVQO@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jose Bollo wrote:
> Acked-by: Jose Bollo <jobol@nonadev.net>
> 
> (if it cares ;)

Thanks. I reposted this patch in case James missed this patch.

> 
> Also below, I expect in some future that task_alloc and task_create
> will be merged. IMHO not allocating the task is of less importance than
> having a simple and unique hook. Statistically the normal is "the
> task is allowed" so the cost of creating the task structure for
> nothing is only relevant in cases where efficiency is just not expected.
> 
You have below post in your mail box. ;-)

------- Forwarded Message
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: casey at schaufler-ca.com, jobol at nonadev.net
Cc: john.johansen at canonical.com, paul at paul-moore.com, sds at tycho.nsa.gov,eparis at parisplace.org, keescook at chromium.org,james.l.morris at oracle.com, serge at hallyn.com,linux-security-module at vger.kernel.org
Subject: Re: [PATCH] LSM: Revive security_task_alloc() hook.
Date: Fri, 6 Jan 2017 20:35:16 +0900

(...snipped...)
>> @@ -1479,6 +1489,7 @@
>>       int (*file_open)(struct file *file, const struct cred *cred);
>>  
>>       int (*task_create)(unsigned long clone_flags);
>> +     int (*task_alloc)(struct task_struct *task);
> I suggest to add the 'clone_flags' as below
>
>      int (*task_alloc)(
>                     struct task_struct *task,
>                     unsigned long clone_flags);
>
> It would allow to treat CLONE_THREAD and/or CLONE_NEW... in a specific
> way.

OK. I added it. Now, I'm tempted to eliminate security_task_create() call.

Creating a new thread is unlikely prohibited by security policy, for
fork()/execve()/exit() is fundamental of how processes are managed in Unix.
If a program is known to create a new thread, it is likely that permission
to create a new thread is given to that program. Therefore, a situation
where security_task_create() returns an error is likely that the program was
exploited and lost control. Even if SELinux failed to check permission to
create a thread at security_task_create(), SELinux can later check it at
security_task_alloc(). Since the new thread is not yet visible from the rest
of the system, nobody can do bad things using the new thread. What we waste
will be limited to some initialization steps such as dup_task_struct(),
copy_creds() and audit_alloc() in copy_process(). I think we can tolerate
these overhead for unlikely situation. What do SELinux people think?

(...snipped...)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
