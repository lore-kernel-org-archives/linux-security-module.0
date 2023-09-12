Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B3EE3F0C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Sep 2023 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjILSkG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjILSkG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Sep 2023 14:40:06 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12B10D3
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694544000; bh=3DAFe8RlaTn0JMN/O699DrlzngWIv+7ot9yh0WHrvmI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oLCDQZtOsDwQHDS8fCAyHmDKuPKMSSZ8l5RxuO5oZtWRK0LfGnhs+79xbK3K4BLiIYZVWU0twKk35j6oh+ikrLsiDiorJ2VFIjdF8l2mNboIMZaSac1o9t3n3HKUrZLFSZSDkEj0w3voVhAFpopdEVsvIW+VfhpNNtqCm7n65rabf4xdWkEsY9IkYW/95X5gf93ibiKjo1KPWJ52F+90TcxImkSbzgaeiEZCTU58ajkLsOiCt5GMZKj8Tn2mhaPbS2lfvuUyqTtc00HJoF9QMI+YDoK+GbqN6yT+HVnZJPXFCbJ62FrJ1yASAMaPUPjOO3ziO7B6hXDEkekc+wr91g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694544000; bh=KM95sFlDxAinu9+nvgtULLji/0GfGRP0WQqGsiyOwlz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AKs0Ooni0E8cWM7HqoJOp/jdeDxtq80LObLcXpq5nALsk1d/hvPZqCikcFb49SKb/8hMmhT9yJhLAxqEypwGA3KdXyxLXqtn/mvC7wfMR9tYaw8kVQQ3HJGTi9YCVrM9rKn5NbKxgyb2+jfnYUwjMx4FMNVXOrfAYhEDyJs9o/b5ORu901z47PUJ23xezpbuYwx9XCltZWAIiT+Qyw6LirCGuxjyZSNZsQvnmQp/ZjxTZLW+a+j/MUTnDItRiDFZsLjvxqxkXH3wXHCmXOn5vQ4LyJr3kgo3+TpqJATytYRFwR1n/7uB8deghfkDPw1TUqfIKpe+nygM+JgFaB3RBQ==
X-YMail-OSG: N8V1Ov4VM1l1bYuH02gTfzwBXxBVH7oiCgb4tIEuDte6_ycKusIxFqAJRvKiHR8
 c4qljt97EtPyHR2W2wpEBnX_XHcqXSz53sNt1x.7u3x4rzOE_FfH.1ISnNhx.BfHNAbNpidbGlrp
 XuFQGCPATHSt3a4TdiZjy7qTgYCefdNhWiEq6LFDm.FkmTituO0_ab9BO9YlU8Azd84qgAWlVPfy
 7afNtQ1tpNDf_G6cOyjw81JhIrbyOTCh7h4nzYK2BKPahioADqG6u0_YZFf4ADUzdMPDdaT6Wnpq
 GDMWDISc5Si8fvW5J7FLEJ5rVZBYtff1aTwQQUZ7q3sFnlhikfoWCKlWQ.srvkc2DFxrwdzl9R2z
 JmO8Owy5fM4nXVbBXNNHz_Djch3vAv1T1uv.SdDGAAF_dWzQhCl1rPU6BW.sLhIWnMmaXMUMENlU
 tYiphaZQAuhQ.SpXjNCK4MleIBPdKjbDXXZygDd8j7uNa9Xz7E0t_6dieqi_lcyZQwgzy8.coLSp
 drVz3zOKxLNllr9DdI7co9mF7suX2PtGUzdofOooyBzMLxqT3JfmyEXbPDb_FLlYSoGyk6P.4bWG
 T3oREclfnjmGS_.C_YDv.phsyWTEBiKkVnujw4Tc2UpCR_5o2wLZdH0hEG0rxB72xZQBybbsFPw9
 HUzhTTeMBsWK1iSnX4QkuOu08ItKfXOHGhFnlTociuj756_YEk8Xwdkye5kwvJhzqT37C9BDd8LR
 Zbp0hmQSXomxaglJc7fLSAc9opYCZwguLTCLKrIR6wKSj5KioP5TYS4ap4EWS_TtknyjX8EWEDHi
 L6ram8olDwsiekAPdq6g8iOTCIyeppe6RC5eHr02N.cbmS.eMhyjl7GIeyKhXFkp7qKD7UJvKXuX
 7mV0l1z4QGEeoxM_P6y5TnuVgwunZZpQYP5XNqutIRkRhzY_fW.6yVDggI0lAXEBMNNX8UsPNRWr
 IBYVn2Wnngyo7Oo7ZXKDezRh.gXvobzPedNmyOyMqYsRgP69hckrcMMip.6m5x4getnzl.QeKJxW
 dDcooHb80t3VuHju5nBzxmTffSNosype.Z7WX.F1iq8Qt8HK07dV0hZiCJkApMVvCgBgkbsoCHY5
 5JBUH1i7caRceWmyNW6c2kc19ccLfYDdBBLN0Td_hFS0TM2mi32y4OEJ4lgACsGDecdoBCudE6A4
 fNwYXVwGYZYB0PKpbsWZtWCfiSHCINjPTYbPtviGS2R.Pp10NfXJwLjhCv60CkzlTh.Aag1r8lqs
 6VVl5PBL3gLkyF1yArvmP4enxNHKx0SlATW_dcmH8720MToWY1PzN2vLUsJdwWYzAnTIAa1r2df8
 8.3Tpzx9wZiom2Xn3CCgM_UaE3Fw9WmJGc8.tQmRLe4JUsbV8Zgloh316aqPTORNTvsTJXLlnBXP
 8vPrH5OTK0hm9qlRLa2WKq_rV31TEUw5DkLqgTOA76ip3qIU3KsuYJ4HVbtchklnuez.RnRAN1f7
 zeh4Y_jxmnm6lCV2QLh0s2r475aYitOsxhzkzWlEThfnmtu2V50pPOvAGpFhdvKFQV_mB7UUo6NN
 5XlCGek0eh8YS4EFptkLOg5Lv24eRfYFVuGZJXA1kSaP7_ZkIeYep2eqCl9YyjKzSpfXFsJsNEy0
 OzfUVDam35hpcWNPoTgyNw2E8hY_edS67fXnAZv8xF5lFcBl8ZssXgqFy1CQIzEoNjdLKvnTWTQF
 dCDXXas_tBU4MN5oF.Ir3bKjCuan_dwtcEsfpP6gGDcTinDWq3KqDhEzrPBzK7mQJZTeuA6uNb09
 qBlrwSxLqAycOZPXPqeCJBWMQmSP7KQO68.JI8Pv28whFy1NyBLO0XN9eFuswim59yCFhRnYQdq_
 Ccc_mpzneeJyOyNkKCa0xloJKaHKvxHbJFTPWmOPBJKwXHyiEN00dZikGYKMaOaMBwEwLgrJ.Sd4
 toVE12wLjF2DNzQFgtCmN7yUJfpDX5aXqnf9TjEdWN8Co_15dhrKhgfyuDUYRN3n_nHDLd.Yun.d
 kq6mw_83UPC.CVT0M_UwrbRf6dZhKRSXNnC5eyaSYbPXMVrkJcWF1E0phZnuZ3yzogSxFtm3ND5q
 xs32Mne_1908sG8rZL7l0LdMhZPnqADrk9V9_csMXfXHI4kBg5ZkXKVTV.3tmCh3mOChnve8n1VP
 FhWoyquGcKKym1mtYCvIpsxUWg.eGfxsBjdGhoiCN8YIMTT0cam49UBTjotcG.Ap9XhGKoP7bgcF
 VtzhFJ1BrYTk0u.U_gq9Dr5N9QVgxYDQ4Lf6Pg_i7MIiZc4z7f41.EK5rEf9UJ2Qo2SbL1hkHKmr
 JCMIlxBSV
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 816dfa26-b66c-40ce-8244-9ac1b084fdf3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 18:40:00 +0000
Received: by hermes--production-bf1-865889d799-dr56j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 327260da7b78eae04eaed3d2e3778478;
          Tue, 12 Sep 2023 18:39:55 +0000 (UTC)
Message-ID: <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com>
Date:   Tue, 12 Sep 2023 11:39:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/12/2023 11:08 AM, Paul Moore wrote:
> On Mon, Sep 11, 2023 at 9:29 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2023/09/12 5:04, Paul Moore wrote:
>>>> If one of userspace tools designed for the new LSM depends on the LSM ID, when can
>>>> the author of the new LSM obtain the stable LSM ID for that LSM ?
>>> A permanent LSM ID is assigned to LSMs when they are merged into the
>>> upstream LSM tree.  This is no different than any other kernel defined
>>> macro constant, enum, magic number, etc. that is shared between kernel
>>> and userspace and is considered part of the kernel's API.
>> Then, your
>>
>>   * The new LSM must be sufficiently unique to justify the additional work
>>   involved in reviewing, maintaining, and supporting the LSM.  It is reasonable
>>   for there to be a level of overlap between LSMs, but either the security model
>>   or the admin/user experience must be significantly unique.
>>
>> is an ultimately unfair requirement, for the combination of
>>
>>   Ultimately, new LSMs are added to the kernel at the discretion of the maintainers
>>   and reviewers.
>>
>> and
>>
>>   A permanent LSM ID is assigned to LSMs when they are merged into the upstream
>>   LSM tree.
>>
>> causes locking out not-yet-in-tree and out-of-tree LSMs.
> As discussed many times prior, I consider in-tree, upstreamed LSMs my
> priority when it comes to decision making.  LSMs which are under
> development and are working to be merged come next, and LSMs which
> have decided to remain out-of-tree remain last.  I do not
> intentionally plan to make life difficult for the out-of-tree LSMs,
> but if that happens as a result of design decisions intended to
> benefit in-tree LSMs that is acceptable as far as I am concerned.  You
> are free to disagree, but I believe the policy I've described here is
> consistent with the bulk of the other kernel subsystems and I have no
> plans to change this policy.
>
>>> I understand you are opposed to the numeric LSM ID as part of the
>>> kernel's API, but I believe this is both the correct way forward, and
>>> consistent with other kernel APIs.  It is your right to disagree, but
>>> I have yet to see a reason to revisit this decision and respectfully
>>> request that you accept this and refrain from revisiting this argument
>>> unless you have new information which would warrant a new discussion.
>> I'm not against the numeric LSM ID itself. I'm against the policy for assigning
>> numeric LSM ID. The numeric LSM ID can become the correct way forward only if
>> the following problem is solved.
>>
>> A market is not a location where only products that passed a patent examination
>> are available ...
> Once again, we've already discussed this many, many times: out-of-tree
> LSMs are not the priority and that is not going to change.  One
> corollary of this is that we are not going to assign LSM IDs to LSMs
> that remain out-of-tree as this would negatively impact the LSM layer
> by cluttering/depleting the LSM ID space.  LSMs that are working
> towards integration with the upstream Linux kernel can self-assign a
> temporary LSM ID which will be finalized upon merging in the LSM tree.
> Based on all of the arguments you have already submitted - and let us
> be very clear: you are the only one speaking out against this - I see
> no reason to change this policy.

I won't say this is a great idea, or that I endorse it, but we could
allocate a range of LSM ID values ( 10000 - 10999 ? ) that we promise
will never be given to an upstream LSM. We wouldn't make any guarantees
about conflicts otherwise. These could be used by LSMs before they are
accepted upstream or by LSMs that don't have upstream aspirations. I
seriously doubt that anyone using such an LSM is going to be mixing
multiple such LSMs without being capable of managing ID conflicts.

Just a thought.

>> The LSM ID is not a API. The LSM ID is a publicly available database.
> By every definition of "API" that I have ever seen, the LSM ID *is*
> part of the proposed LSM syscall API.
>
> In my last email in this thread I asked you to refrain from revisiting
> old arguments.  Unfortunately you either chose to reject that request
> or you mistakenly thought your latest email was presenting new ideas
> as opposed to a slight reframing of your existing objections.  I am
> sorry that we have reached this point, but I am done discussing this
> with you Tetsuo; unless I see any new arguments from you this will be
> my last reply to you on this topic.
>
