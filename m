Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D6C05052
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Aug 2023 10:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358407AbjHRKcF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Aug 2023 06:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359745AbjHRKa5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Aug 2023 06:30:57 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDF54495;
        Fri, 18 Aug 2023 03:30:08 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37IATtGB020408;
        Fri, 18 Aug 2023 19:29:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 18 Aug 2023 19:29:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37IATsT5020404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Aug 2023 19:29:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
Date:   Fri, 18 Aug 2023 19:29:52 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/16 22:53, Paul Moore wrote:
> On Wed, Aug 16, 2023 at 6:10 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2023/08/16 3:44, Paul Moore wrote:
>>> On Fri, Aug 11, 2023 at 6:58 AM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> When an unexpected system event occurs, the administrator may want to
>>>> identify which application triggered the event. For example, unexpected
>>>> process termination is still a real concern enough to write articles
>>>> like https://access.redhat.com/solutions/165993 .
>>>>
>>>> This patch adds a record which emits TOMOYO-like task history information
>>>> into the audit logs for better understanding of unexpected system events.
>>>>
>>>>   type=UNKNOWN[1340] msg=audit(1691750738.271:108): history="name=swapper/0;pid=1;start=20230811194329=>name=init;pid=1;start=20230811194343=>name=systemd;pid=1;start=20230811194439=>name=sshd;pid=3660;start=20230811104504=>name=sshd;pid=3767;start=20230811104535"
>>>
>>> While I respect your persistence, we've talked about this quite a bit
>>> already in other threads.  What you are trying to do is already
>>> possible with audit
>>
>> How?
> 
> If you configure audit to record exec() and friends you should have a
> proper history of the processes started on the system.

That is a "No LSM modules other than SELinux is needed because SELinux can do
everything" assertion. People propose different approaches/implementations because
they can't afford utilizing/configuring existing approaches/implementations.

Your assertion is a fatal problem for merging "Re: [PATCH v13 00/11] LSM: Three basic syscalls"
at https://lkml.kernel.org/r/CAHC9VhQ4ttkSLTBCrXNZSBR1FP9UZ_gUHmo0BS37LCdyBmUeyA@mail.gmail.com .

Please please allow LSM modules like https://lkml.kernel.org/r/41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp
to obtain a stable LSM ID if you don't want to support something that possibly have an alternative.

