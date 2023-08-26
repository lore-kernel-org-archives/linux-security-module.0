Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B6C83F11
	for <linux-security-module@archiver.kernel.org>; Sat, 26 Aug 2023 06:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHZGjl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 26 Aug 2023 02:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjHZGjG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 Aug 2023 02:39:06 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D651FF3;
        Fri, 25 Aug 2023 23:39:03 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37Q6cnLU006839;
        Sat, 26 Aug 2023 15:38:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 26 Aug 2023 15:38:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37Q6cnSX006836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 26 Aug 2023 15:38:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e4603ea-3ce8-5b9e-0ddf-9ec893ddd32e@I-love.SAKURA.ne.jp>
Date:   Sat, 26 Aug 2023 15:38:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] audit: add task history record
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
 <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
 <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
 <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
 <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com>
 <e9c593d9-6369-2987-ce20-5832dbebd027@I-love.SAKURA.ne.jp>
 <e56ed3a6-9d82-a181-bbc7-e322ea47cb98@I-love.SAKURA.ne.jp>
 <CAHC9VhRTVsoMWhP1+j7RcUqy2EiV=Z7W_00h55PE-WezzLg=Ew@mail.gmail.com>
 <693f623f-76dd-a709-4916-6d78fe29c9b4@I-love.SAKURA.ne.jp>
 <18a2ac400f8.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <18a2ac400f8.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/25 12:36, Paul Moore wrote:
>> It is unfortunate that you continue ignoring the
>>
>>  How can auditd generate logs that are not triggered via syscalls?
>>
>> line. I know how to configure syscall rules using "-S" option. But I do
>> not know how to configure non syscall rules (such as process creation via
>> kthread_create(), process termination due to tty hangup or OOM killer).
> 
> At this point you've exhausted my goodwill so I would suggest simply reading
> the audit code, manages, and experimenting with a running system to understand
> how things work, especially for non-syscall records.

Are we on the same page that non-syscall records include process creation via
kthread_create() and process termination via send_sig() ?

I tried "make M=audit_test/" with below example.

audit_test/audit_test.c
----------------------------------------
#include <linux/module.h>
#include <linux/kthread.h>
#include <linux/sched/signal.h>

static int test_kthread(void *unused)
{
	char *argv[3] = { "/bin/sleep", "10", NULL };
	char *envp[1] = { NULL };
	struct task_struct *p;
	
	printk("test_kthread is running with PID=%d\n", current->pid);
	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
	rcu_read_lock();
	for_each_process(p) {
		if (!(p->flags & PF_KTHREAD) && !strcmp(p->comm, "sleep")) {
			printk("Sending signal to PID=%d\n", p->pid);
			send_sig(SIGKILL, p, 1);
		}
	}
	rcu_read_unlock();
	return 0;
}

static int __init test_init(void)
{
	struct task_struct *task = kthread_create(test_kthread, NULL, "test_kthread");

	if (!IS_ERR(task)) {
		wake_up_process(task);
		schedule_timeout_uninterruptible(5 * HZ);
	}
	return -EINVAL;
}

module_init(test_init);
MODULE_LICENSE("GPL");
----------------------------------------

audit_test/Makefile
----------------------------------------
obj-m += audit_test.o
----------------------------------------

I tried below steps in order to generate all possible records using auditd.

----------------------------------------
# auditctl -D
No rules
# auditctl -a exit,always
# auditctl -a task,always
# insmod audit_test/audit_test.ko
insmod: ERROR: could not insert module audit_test/audit_test.ko: Invalid parameters
# auditctl -D
No rules
# dmesg
[  219.826840] test_kthread is running with PID=4044
[  219.832367] Sending signal to PID=4045
# ausearch -p 4044
<no matches>
# ausearch -p 4045 | sed -e 's/ /\n/g' | grep syscall= | sort -uV
syscall=0
syscall=2
syscall=3
syscall=5
syscall=9
syscall=10
syscall=11
syscall=12
syscall=21
syscall=35
syscall=158
----------------------------------------

Only records issued by system calls (read(),open(),close(),fstat(),mmap(),
mprotect(),munmap(),brk(),access(),nanosleep(),arch_prctl()) are generated.
Neither records issued by process creation via kthread_create() nor records
issued by process termination via send_sig() are generated.

Are you confident that auditd is already capable of generating records for e.g.
process creation via kthread_create() and process termination via send_sig() ?

> If you find a place in the code where you believe there should be an audit record,
> post a patch and we can discuss it.

I believe that auditd needs to be able to generate records for e.g. process creation
via kthread_create() and process termination via send_sig(), if you insist that we can
emulate process history information offered by this patch from user space using records
generated by auditd. (That sounds beyond CONFIG_AUDITSYSCALL=y though...)

