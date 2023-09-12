Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C293CA0ECB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Sep 2023 01:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjILB7J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjILB6y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Sep 2023 21:58:54 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727131D83
        for <linux-security-module@vger.kernel.org>; Mon, 11 Sep 2023 18:29:44 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38C1TbR8038262;
        Tue, 12 Sep 2023 10:29:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 12 Sep 2023 10:29:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38C1Tb3s038258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Sep 2023 10:29:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
Date:   Tue, 12 Sep 2023 10:29:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/09/12 5:04, Paul Moore wrote:
>> If one of userspace tools designed for the new LSM depends on the LSM ID, when can
>> the author of the new LSM obtain the stable LSM ID for that LSM ?
> 
> A permanent LSM ID is assigned to LSMs when they are merged into the
> upstream LSM tree.  This is no different than any other kernel defined
> macro constant, enum, magic number, etc. that is shared between kernel
> and userspace and is considered part of the kernel's API.

Then, your

  * The new LSM must be sufficiently unique to justify the additional work
  involved in reviewing, maintaining, and supporting the LSM.  It is reasonable
  for there to be a level of overlap between LSMs, but either the security model
  or the admin/user experience must be significantly unique.

is an ultimately unfair requirement, for the combination of

  Ultimately, new LSMs are added to the kernel at the discretion of the maintainers
  and reviewers.

and

  A permanent LSM ID is assigned to LSMs when they are merged into the upstream
  LSM tree.

causes locking out not-yet-in-tree and out-of-tree LSMs.

> I understand you are opposed to the numeric LSM ID as part of the
> kernel's API, but I believe this is both the correct way forward, and
> consistent with other kernel APIs.  It is your right to disagree, but
> I have yet to see a reason to revisit this decision and respectfully
> request that you accept this and refrain from revisiting this argument
> unless you have new information which would warrant a new discussion.

I'm not against the numeric LSM ID itself. I'm against the policy for assigning
numeric LSM ID. The numeric LSM ID can become the correct way forward only if
the following problem is solved.



A market is not a location where only products that passed a patent examination
are available. There are always products which failed to pass a patent examination.
But you are trying to make products which failed to pass a patent examination into
unavailable state, by requiring each product to get a barcode number which is assigned
to only products that passed a patent examination. Such situation is a regression
compared to requiring each product to have a product name.

A Linux kernel is not a program where only codes that passed a patent examination
can be loaded and executed. There are always programs which failed to pass a patent
examination. But you are trying to make programs which failed to pass a patent
examination into unavailable state, by requiring each program to get an identifier
which is assigned to only programs that passed a patent examination.

LSMs are one of programs designed for the Linux kernel. That is, there are always
LSMs which failed to become one of in-tree LSMs. But you are trying to make LSMs
which failed to pass a patent examination into unavailable state, by requiring
each LSM to get an LSM ID which is assigned to only programs that passed a patent
examination.

> LSM developers creating userspace tooling that makes use of the LSM ID
> numbers should use the macro name and not the number, this should
> allow the tooling to support the permanent LSM ID with a simple
> recompile.

"Using the macro name and not the number" is the catch-22 situation. The problem is
that LSMs which are under review for becoming one of in-tree LSMs (and LSMs which
failed to become one of in-tree LSMs due to the patent examination) cannot rely on
the macro from the code in the public git repository due to lack of a stable number
for that macro.

When someone wants to try the userspace tooling, you are saying that that someone
can use -DLSM_NUMERIC_ID_FOR_THAT_LSM_MODULE=... argument to gcc when compiling
the userspace, without saying the ... part. The consequence will be conflicts
between multiple LSMs and/or non-working userspace tools. This will not facilitate
use of the LSM interface.



Whether LSM ID is "consistent with other kernel APIs" is completely irrelevant.

The LSM ID must behave like PCI device IDs and/or entries in /etc/services .
That is, whether the device driver and/or networking services are available
in the upstream kernel is irrelevant. PCI device drivers which are not available
in the upstream kernel are allowed to be loaded. The LSM ID database must behave
like the list of all LSMs which are publicly available in the world, rather than
what LSMs are permitted to be loaded and what userspace tools can work.

The current LSM ID is designed for locking out all products which are not available
in the upstream market. The concept of LSM ID must be changed to allow any product
to be publicly available from somewhere in the world. Otherwise, use of numeric ID
(and the "LSM syscall patchset" which uses the numeric ID) is a complete garbage.



The LSM ID is not a API. The LSM ID is a publicly available database.
Passing a patent examination must not be a requirement for assigning a stable LSM ID.
The LSM ID numbers must be available to all publicly available LSMs.

That is, either get rid of the patent examination requirement (so that whatever
proposed LSMs can become in-tree as long as maintaining and supporting the new
LSM for an extended period of time are committed), or assign the LSM ID by an
independent organization rather than at the discretion of the maintainers and
reviewers (so that whatever LSM can obtain a stable LSM ID regardless of whether
that LSM succeeds in becoming one of in-tree LSMs).

