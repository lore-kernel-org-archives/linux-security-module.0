Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA81CE7A8B
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 00:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIYA4O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Sep 2023 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjIYA4O (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Sep 2023 20:56:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D11E8
        for <linux-security-module@vger.kernel.org>; Sun, 24 Sep 2023 17:56:06 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38P0tlNp091055;
        Mon, 25 Sep 2023 09:55:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 25 Sep 2023 09:55:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38P0tlBT091052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Sep 2023 09:55:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8912fc96-cb8e-ec3b-273d-6bd8ad6b5513@I-love.SAKURA.ne.jp>
Date:   Mon, 25 Sep 2023 09:55:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <kees@kernel.org>
Cc:     linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
 <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com>
 <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/09/13 4:00, Paul Moore wrote:
> On Tue, Sep 12, 2023 at 2:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/12/2023 11:08 AM, Paul Moore wrote:
>>>
>>> Once again, we've already discussed this many, many times: out-of-tree
>>> LSMs are not the priority and that is not going to change.  One
>>> corollary of this is that we are not going to assign LSM IDs to LSMs
>>> that remain out-of-tree as this would negatively impact the LSM layer
>>> by cluttering/depleting the LSM ID space.

Like Kees Cook said, we don't need to worry about depleting the LSM ID space
because lsm_id::id is a u64. We only need to worry about cluttering/conflicting
the values.

>>>                                            LSMs that are working
>>> towards integration with the upstream Linux kernel can self-assign a
>>> temporary LSM ID which will be finalized upon merging in the LSM tree.

A review might take years (like we did with the pathname based access control
in the past). What userspace would want to use of long-term non-persistent
registrations? At the stage of publishing an LSM (and userspace tools which
make use of LSM ID value), the LSM ID value should be long-term persistent
registrations. Recompiling userspace tools every time is no good.

>>> Based on all of the arguments you have already submitted - and let us
>>> be very clear: you are the only one speaking out against this - I see
>>> no reason to change this policy.
>>
>> I won't say this is a great idea, or that I endorse it, but we could
>> allocate a range of LSM ID values ( 10000 - 10999 ? ) that we promise
>> will never be given to an upstream LSM. We wouldn't make any guarantees
>> about conflicts otherwise. These could be used by LSMs before they are
>> accepted upstream or by LSMs that don't have upstream aspirations. I
>> seriously doubt that anyone using such an LSM is going to be mixing
>> multiple such LSMs without being capable of managing ID conflicts.
> 
> Not a crazy idea.  I had debated something similar, a reserved
> "private use" or "experimentation" range; there is definitely
> precedence for that in other areas, e.g. network protocols.  What held
> me back is that invariably folks will want to create long-term
> persistent registrations against this space for their out-of-tree LSMs
> which would require some sort of unofficial, adhoc registration
> authority which starts to get a bit silly in my opinion (the
> registration authority for the Linux kernel API is the upstream Linux
> kernel community).

Not silly at all. I do want to create long-term persistent registrations
against this space for any publicly available LSMs.

The sane and the better usage of LSM ID is to register any publicly available
LSMs. If LSM ID serves as an index for what LSMs are available in the world,
by maintaining "the LSM module name, the LSM ID value, short description about
that LSM module, the public git repository or web site for more information
about that LSM module" pairs, people can easily find what LSMs could be used
for their purpose, and developers can avoid re-inventing similar LSM modules
which are already available somewhere in the world (and optionally helps
avoiding module name collisions with any publicly available LSMs).

> 
> Temporary assignments while a LSM is undergoing the review-revision
> cycle on its way to being merged is something different and if we need
> a couple of reserved numbers for that (one or two MAX) we can consider
> that, but I don't expect this to be a major problem in practice.  LSMs
> that are in this transient pre-merge state shouldn't be used for
> production purposes and thus a LSM ID change on merging shouldn't be a
> problem.

It is possible that more than 3 LSMs concurrently get under the review;
reserving 2 at most can deplete the reserved LSM ID space.

No userspace tools want to recompile due to unstable LSM ID values.
Temporary assignments is no good.

