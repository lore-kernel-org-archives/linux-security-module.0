Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA17C3DA6F
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Aug 2023 13:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjHXNVs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Aug 2023 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbjHXNVi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Aug 2023 09:21:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB3198D;
        Thu, 24 Aug 2023 06:21:36 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37ODLMiX042500;
        Thu, 24 Aug 2023 22:21:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 24 Aug 2023 22:21:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37ODLLoD042496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Aug 2023 22:21:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
Date:   Thu, 24 Aug 2023 22:21:21 +0900
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
 <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
 <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/23 23:48, Paul Moore wrote:
> We've already discussed this both from a kernel load perspective (it
> should be able to handle the load, if not that is a separate problem
> to address) as well as the human perspective (if you want auditing,
> you need to be able to handle auditing).

No. You haven't shown us audit rules that can satisfy requirements shown below.

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

We know we can't satisfy requirements shown above using audit rules. That's why
this patch maintains process history information without using audit rules.

> 
> Tetsuo, as should be apparent at this point, I'm finding your
> arguments unconvincing at best, and confusing at worst.  If you or
> someone else wants to take a different approach towards arguing for
> this patch I'll entertain the discussion further, but please do not
> reply back with the same approach; it simply isn't constructive at
> this point.

Although it will be nice if we can fetch this process history information
directly from "current", I can live with fetching this process history
information from "current->security" (that is, moving what you call "the
support burden" from audit subsystem to LSM module authors).

