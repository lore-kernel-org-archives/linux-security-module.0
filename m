Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9023DC04A6A
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Aug 2023 17:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjHHRxL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjHHRwl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Aug 2023 13:52:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995728EBB;
        Tue,  8 Aug 2023 09:23:31 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 378A7BCl055363;
        Tue, 8 Aug 2023 19:07:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 08 Aug 2023 19:07:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 378A7BmK055360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Aug 2023 19:07:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6f3a90b9-b210-512a-f74a-6003aebf5c30@I-love.SAKURA.ne.jp>
Date:   Tue, 8 Aug 2023 19:07:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
 <CAHC9VhSsDTyfae6f0XvYYcCRH590L1ZEqbHSM4UgUCHRGm7X_g@mail.gmail.com>
 <2155117.irdbgypaU6@x2>
 <CAHC9VhRG2aX-_ye7ZRWpZkR7rq8Op7RUVS3cMtxhF8t1bdw5oQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRG2aX-_ye7ZRWpZkR7rq8Op7RUVS3cMtxhF8t1bdw5oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/08 5:13, Paul Moore wrote:
> On Mon, Aug 7, 2023 at 3:03 PM Steve Grubb <sgrubb@redhat.com> wrote:
>> On Monday, August 7, 2023 2:53:40 PM EDT Paul Moore wrote:
>>> On Sun, Aug 6, 2023 at 9:05 AM Tetsuo Handa
>>>
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> When an unexpected system event occurs, the administrator may want to
>>>> identify which application triggered the event. For example, unexpected
>>>> process termination is still a real concern enough to write articles
>>>> like https://access.redhat.com/solutions/165993 . TaskTracker is a
>>>> trivial LSM module which emits TOMOYO-like information into the audit
>>>> logs for better understanding of unexpected system events.
>>>
>>> Help me understand why all of this information isn't already available
>>> via some combination of Audit and TOMOYO, or simply audit itself?
>>
>> Usually when you want this kind of information, you are investigating an
>> incident. You wouldn't place a syscall audit for every execve and then
>> reconstruct the call chain from that. In the case of long running daemons,
>> the information could have been rotated away. But typically you want to see
>> what the entry point is. A sudden shell from bind would be suspicious while a
>> shell from sshd is not.
> 
> Once again, why not use the existing audit and/or TOMOYO capabilities.
> 

Can't, for Fedora/RHEL does not enable TOMOYO.
I need a way that can be used by RHEL users running with selinux=0.

This history information is expected to become available for those who
might want to investigate unexpected system events, but should not become
unconditionally available for those who do not want to bloat audit logs.
Switching via lsm=tt is a handy way for satisfying both.

