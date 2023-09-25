Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B4BCE7A8C
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 04:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjIYEc1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Sep 2023 00:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYEc0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Sep 2023 00:32:26 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E6E92
        for <linux-security-module@vger.kernel.org>; Sun, 24 Sep 2023 21:32:19 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38P4W3VZ057764;
        Mon, 25 Sep 2023 13:32:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Mon, 25 Sep 2023 13:32:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38P4W39m057759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Sep 2023 13:32:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp>
Date:   Mon, 25 Sep 2023 13:32:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <kees@kernel.org>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
 <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com>
 <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
 <8912fc96-cb8e-ec3b-273d-6bd8ad6b5513@I-love.SAKURA.ne.jp>
 <202309241827.6818149EC8@keescook>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202309241827.6818149EC8@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/09/25 10:32, Kees Cook wrote:
> On Mon, Sep 25, 2023 at 09:55:47AM +0900, Tetsuo Handa wrote:
>> On 2023/09/13 4:00, Paul Moore wrote:
>>> On Tue, Sep 12, 2023 at 2:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/12/2023 11:08 AM, Paul Moore wrote:
>>>>>
>>>>> Once again, we've already discussed this many, many times: out-of-tree
>>>>> LSMs are not the priority and that is not going to change.  One
>>>>> corollary of this is that we are not going to assign LSM IDs to LSMs
>>>>> that remain out-of-tree as this would negatively impact the LSM layer
>>>>> by cluttering/depleting the LSM ID space.
>>
>> Like Kees Cook said, we don't need to worry about depleting the LSM ID space
>> because lsm_id::id is a u64. We only need to worry about cluttering/conflicting
>> the values.
> 
> Right, this will go one of two ways:
> 
> 1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
>             it the next LSM ID."
>    maintainer(s): "Okay, sounds good. *review*"
> 
> 2) author: "Hello, here is an LSM that has been in active use at $Place,
>             and we have $Xxx many userspace applications that we cannot easily
>             rebuild. We used LSM ID $Value that is far away from the sequential
>             list of LSM IDs, and we'd really prefer to keep that assignment."
>   maintainer(s): "Okay, sounds good. *review*"
> 
> No problems detected.

No problem if what you wrote above is the policy. What is important is that the assigned
LSM ID value remains available for that LSM. "Okay, sounds good." has to be the only
requirement for assigning long-term persistent registrations. Whether that LSM succeeds
to become in-tree must be irrelevant for assigning permanently available LSM ID value.

It is not clear whether the proposed LSM ID value is added to include/uapi/linux/lsm.h file
of the upstream Linux kernel (it is required for avoid cluttering/conflicting) before
the LSM module which wants to use that LSM ID value succeeds to become in-tree.

But if LSM ID serves as an index for what LSMs are available in the world,
by maintaining "the LSM module name, the LSM ID value, short description about
that LSM module, the public git repository or web site for more information
about that LSM module" pairs (e.g. somewhere in the LSM community's Wiki rather than
in include/uapi/linux/lsm.h ), people can easily find what LSMs could be used
for their purpose, and developers can avoid re-inventing similar LSM modules
which are already available somewhere in the world.

That's what I said

  Since the LSM community cannot accept all of proposed LSMs due to limited resources,
  the LSM community is responsible for allowing whatever proposed LSMs (effectively any
  publicly available LSMs) to live as out-of-tree LSMs, by approving the LSM name and
  assigning a permanent LSM ID number.

in https://lkml.kernel.org/r/94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp .

Casey and Paul, do you agree to change your policy for assigning LSM ID ?

