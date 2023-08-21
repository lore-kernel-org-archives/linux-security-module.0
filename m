Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F0EE49A0
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 22:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjHUWXl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHUWXl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 18:23:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921AEDB
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 15:23:39 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37LMNKLF047450;
        Tue, 22 Aug 2023 07:23:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 22 Aug 2023 07:23:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37LMNKC8047447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 22 Aug 2023 07:23:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5db92f8f-44c6-b6da-edeb-d7edf86d7ad3@I-love.SAKURA.ne.jp>
Date:   Tue, 22 Aug 2023 07:23:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] audit: add task history record
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        audit@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>,
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
 <20230821160446.GA1317178@mail.hallyn.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230821160446.GA1317178@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/22 1:04, Serge E. Hallyn wrote:
> On Sat, Aug 19, 2023 at 04:09:46PM +0900, Tetsuo Handa wrote:
>> Anyway, enabling TOMOYO in Fedora/RHEL kernels won't solve the problem
>> this patch is trying to solve, for TOMOYO cannot utilize TOMOYO's process
>> history information because LSM hook for sending signals does not allow
>> TOMOYO to sleep...
> 
> Hang on a tick - I think perhaps you should have led with this.  The
> main argument against this has been (iiuc) that it is a subset of
> tomoyo functionality.  In that case, I'm on the fence about whether it
> should be included.
> 
> But here you say that tomoyo cannot do this.  If that's the case, and
> this is simply completely new functionality, that changes things.

This information is duplicated upon fork() and updated upon execve().
That is how TOMOYO defines TOMOYO's process history information.
Therefore, I'm saying "TOMOYO-like task history information".
But this information provided by this patch is different from TOMOYO's
process history information provided by TOMOYO in two ways.

One is that TOMOYO embeds pathname of a program passed to execve() into
TOMOYO's task history information because it is used for describing access
control rules, whereas this patch embeds comm name and pid and time of execve()
into task history information because it is used for helping administrators
understand system events.

The other is that TOMOYO can check and generate logs with TOMOYO's task history
information for only operations that can sleep (e.g. open()/execve()), whereas
this patch can check and generate logs with task history information for both
sleepable (e.g. open()/execve()) and non-sleepable (e.g. kill()) operations.

Since one of use cases of this task history information is to identify who sent
a signal that caused an unexpected process termination, TOMOYO cannot be do it.

Also, system calls are not the only source of sending signals. There are signals
delivered without security checks via LSM modules. In that case, inserting a
SystemTap script helps catching such signals. But SystemTap scripts are loaded
too late to emulate task history information from boot.

