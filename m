Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997BEE4981
	for <linux-security-module@archiver.kernel.org>; Sat, 19 Aug 2023 07:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjHSHK0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 19 Aug 2023 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344346AbjHSHKJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 19 Aug 2023 03:10:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EFC4231;
        Sat, 19 Aug 2023 00:10:04 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37J79m2c075496;
        Sat, 19 Aug 2023 16:09:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Sat, 19 Aug 2023 16:09:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37J79mSQ075493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 19 Aug 2023 16:09:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
Date:   Sat, 19 Aug 2023 16:09:46 +0900
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
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/18 23:59, Paul Moore wrote:
> Except we are not talking SELinux or LSMs here, we are talking about
> audit and the audit subsystem is very different from the LSM layer.
> The LSM layer is designed to be pluggable with support for multiple
> individual LSMs, whereas the audit subsystem is designed to support a
> single audit implementation.  It is my opinion that the audit patch
> you have proposed here does not provide an audit administrator with
> any new capabilities that they do not currently have as an option.

Before explaining why an audit administrator cannot afford emulating
this patch, I explain what this patch will do.



There are three system calls for managing a process: fork()/execve()/exit().

  https://I-love.SAKURA.ne.jp/tomoyo/fork.gif
  https://I-love.SAKURA.ne.jp/tomoyo/execve.gif
  https://I-love.SAKURA.ne.jp/tomoyo/exit.gif

As a result, history of a process can be represented as a tree, where the
root of the tree is the kernel thread which is started by the boot loader.

  https://I-love.SAKURA.ne.jp/tomoyo/railway.gif

This fundamental mechanism cannot be changed as long as Linux remains as a
Unix-like OS. That is, adding this information will not cause what you call
"the support burden".



Currently, a "struct task_struct" has comm field and pid field, and
people use these fields like

  printk("[%s:%d] some msg comes here\n", current->comm, current->pid);

for giving hints for identifying a process.

What this patch does is to allow people do like

  printk("[%s] some msg comes here\n", current->comm_history);

for giving hints for identifying a process more precisely.
That is, users of this information is not limited to audit. For example,
an LSM module can use this information, an audit record can use this
information, a SystemTap script can use this information, and so on...



> 
> There are also concerns around field formatting, record length, etc.,
> but those are secondary issues compared to the more important issue of
> redundant functionality.

If someone tries to emulate this patch, we need to be able to trace all
fork()/execve()/exit() system calls. Or, the history tree will be broken.

If an audit administrator tries to emulate this patch using system call
auditing functionality, we need to make sure that

  "auditctl -D" must not clear rules for tracing fork()/execve()/exit()
  system calls. This is impossible because this change will break userspace
  programs expecting that "auditctl -D" clears all rules.

  Rules for tracing fork()/execve()/exit() system calls must be enabled
  when the kernel thread which is started by the boot loader starts.
  How can we embed such system call auditing rules into the kernel and
  tell whether to enable these rules using the kernel command line options?

  In order to avoid possibility of loosing fork()/execve()/exit() records,
  auditd must not be stopped even temporarily. Who wants to enforce such
  requirement in order to be able to obtain process history information?

It seems that Linux kernel also offers "proc connector" mechanism. But is that
reliable enough to guarantee that all fork()/execve()/exit() histories are
kept up-to-dated? Any emulation done by userspace programs is unreliable,
for programs for emulating this patch are started too late to trace all.
Only the built-in kernel code can trace all fork()/execve()/exit() events
and guarantee that all fork()/execve()/exit() histories are kept up-to-dated.



The tracing implemented by this patch needs to be done using the kernel code.

https://www.intellilink.co.jp/column/oss/2014/093001.aspx (sorry, this article
is written in Japanese language) explains 4 survey methods for finding locations
affected by CVE-2014-6271 (also known as "ShellShock"). This article was based on
https://I-love.SAKURA.ne.jp/tomoyo/LCJ2014-en.pdf . Copying P43 and P44 of this
PDF file here:

  Is SystemTap good at everything?

    SystemTap can be used for not only measuring performance
    of functionality but also tracing functionality.

      LSM interface allows probing at only locations where LSM
      callback hooks are provided, for it is designed for making
      security decision and auditing.

    SystemTap allows probing at almost everywhere (not only the
    start/end of a function but also any line number in a function in
    the source code).

      For example, you can find out the exact location in the
      source code where the errno the system call auditing would
      record was set, by writing a SystemTap script which probes
      at specific line number

    Unfortunately, SystemTap is not a tool designed for monitoring
    throughout years.

      LSM modules do not skip events nor stop working until
      shutdown, but SystemTap might skip events or stop working
      due to SystemTap's safety mechanism (and/or external
      factors like SIGKILL) before the event you want to record
      occurs.

    Please check whether SystemTap is suitable for solving your
    problem.

      There will be cases where system call auditing is better.
      There will be cases where single function LSM modules
      explained later is better.

P100, P101, P102 of this PDF file demonstrates a SystemTap script
which tries to emulate subset of what this patch can do. The difficult
part of such emulation is mainly managing the process history tree.
If the built-in kernel code offers the process history tree, writing
SystemTap scripts will become much easier. 

But I can't propose this code as a patch for SystemTap, for SystemTap
is not a in-tree kernel code. I need to propose this code as a patch
for in-tree kernel code. LSM and system call auditing are users who
can utilize this code. But you don't want this code as a patch for
audit due to unknown "the support burden".



> 
>> People propose different approaches/implementations because
>> they can't afford utilizing/configuring existing approaches/implementations.
> 
> From what I've seen, both in this thread as well as the other related
> threads from you, these recent efforts are due to a lack of TOMOYO
> support in mainstream Linux distributions.  My advice is to stop
> trying to duplicate the TOMOYO functionality in other subsystems/LSMs
> and start working with the distributions to better understand why they
> are not supporting TOMOYO.  I believe that if you can determine why
> the distributions are not enabling TOMOYO, you should be able to
> develop a plan to address those issues and eventually gain
> distribution support for TOMOYO.  I understand that such an approach
> will likely be time consuming and difficult, but I think that is your
> best option for success.

https://bugzilla.redhat.com/show_bug.cgi?id=542986 was the request for
enabling TOMOYO in Fedora. But Red Hat people do not want to support
TOMOYO due to unknown "the support burden" like you say.

TOMOYO is tested by syzbot, and quite few bugs have been found in TOMOYO.
I think that enabling TOMOYO in Fedora/RHEL kernels won't cause "the support
burden.". But I can't determine why Red Hat people do not enable TOMOYO.
How can I convince Red Hat people afraiding unprovable, unexplainable,
unknown "the support burden" ?



Anyway, enabling TOMOYO in Fedora/RHEL kernels won't solve the problem
this patch is trying to solve, for TOMOYO cannot utilize TOMOYO's process
history information because LSM hook for sending signals does not allow
TOMOYO to sleep...

