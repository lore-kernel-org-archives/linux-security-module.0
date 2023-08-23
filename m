Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C54EE4993
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Aug 2023 14:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjHWOTK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Aug 2023 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHWOTJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Aug 2023 10:19:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C9E63;
        Wed, 23 Aug 2023 07:19:06 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37NEIqtU083525;
        Wed, 23 Aug 2023 23:18:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 23 Aug 2023 23:18:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37NEIjCs083510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Aug 2023 23:18:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Aug 2023 23:18:43 +0900
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
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/22 1:35, Paul Moore wrote:
>>   "auditctl -D" must not clear rules for tracing fork()/execve()/exit()
>>   system calls. This is impossible because this change will break userspace
>>   programs expecting that "auditctl -D" clears all rules.
> 
> It's a good thing that 'audtictl -d ...' exists so that one can
> selectively delete audit rules from the kernel.  If someone wants to
> preserve specific audit rules, that is the way to do it; 'auditctl -D'
> is a very coarse tool and not something that is likely very useful for
> users with strict auditing requirements.

In most systems, "auditctl -D" is the first command done via /etc/audit/audit.rules file.
You are asking all administrators who want to emulate this patch's functionality using
auditd to customize that line. We can't afford asking such administrators to become
specialist of strict auditing configurations, as well as we can't afford asking
every administrator to become specialist of strict SELinux policy configurations.

Like Steve Grubb mentions, technically possible and practically affordable are
different. The audit subsystem could handle the load, but the system administrator 
can't handle the load. That's why I said

  That is a "No LSM modules other than SELinux is needed because SELinux can do
  everything" assertion.

and your response

  Except we are not talking SELinux or LSMs here, we are talking about
  audit and the audit subsystem is very different from the LSM layer.
  The LSM layer is designed to be pluggable with support for multiple
  individual LSMs, whereas the audit subsystem is designed to support a
  single audit implementation.

is totally missing the point.

For example, doing

  auditctl -a exit,always -F arch=b64 -S exit,exit_group

(in order to allow userspace daemon which tries to emulate this patch's
functionality) will let auditd to generate process termination logs via exit()
system call. This command alone can generate too much stress on a busy system
(performance DoS and storage DoS). And moreover, this command will not let
auditd to generate process termination logs via kill() system call.

  kill -9 $$

Auditing kill system call may generate more stress than auditing exit system call.
Too much noisy logs for catching the exact one event we want to know.

Also, despite too much logs, system calls are not the only source of sending
signals. There are signals delivered without security checks via LSM modules.



The requirements for emulating functionality provided by this patch will be

  (1) Catch _all_ process creations (both via fork()/clone() system calls and
      kthread_create() from the kernel), and duplicate the history upon process
      creation.

  (2) Catch _all_ execve(), and update the history upon successful execve().

  (3) Catch _all_ process terminations (both exit()/exit_group()/kill() system
      calls and internal reasons such as OOM killer), and erase the history upon
      process termination.

  (4) Do the above things without asking administrators to become a specialist of
      system management and without asking administrators to drastically change
      system configurations and without consuming too much CPU and storage.

. Simply we can't emulate functionality provided by this patch using audit rules.

