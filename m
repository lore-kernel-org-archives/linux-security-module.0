Return-Path: <SRS0=CMy/=4M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD3C11D2F
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Feb 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B74520714
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Feb 2020 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o+hVr4Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBXQJj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:09:39 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:40609
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbgBXQJj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Feb 2020 11:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582560578; bh=ViOIOXczxT6z0pFkg2K3ireeWowQ0T+MQDPd9bJgqKQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=o+hVr4UfG8lBy/Vp66je1o07PZLIsdJVjGAs1tZ1dxgkBtZlyAunCHrnztISNdrS/6zi/7LB0AZgK17yZJanpRbi88Hw/59dfarzRsy2mZGgR07IF9XTTLboYP1n2MvwJsErg9l50AJ75ElEsiK5YuI2nsyFap/ZGXT41QMQP83r936ycEBKkhHcQpHlASki9w5r0mhD1DVxwTnUinmVnhP15+OdSGzP7clVaT7jtX5Jpq/wRNFkn9lJpqXOOB8tYD6rIYVCcU3HstwcalolX8DNC5MdjI7Vj+BVcAqZPgoax1Y66+o/drHz64jGfSDyfVBLG751Ivp8usVMoM0I6A==
X-YMail-OSG: cD8JWZsVM1m1ELLWFgf2fJiQCcYP9wwOSA35dKRCFnIhJPUycPknGMD.JyGKlfe
 99pkk0CG3jCAzaA2SCBd3SfNx2GOuxPIOeBNy7fz0W.8VEad8o8IjCz_4GpQi.rr2v4j8CBwIfdx
 q_Ic9svuGRvbxb944og9T.x0K.CzDiqHL8eOq2fpcYU_K20jOkRDQwx1.5GBmvMI1iakAn2TmcOG
 gurkfrMXK4P9uwF_A_h5U8KV9d93FG0N8QEFSEx9sV66gUsj_JlZAF3CDtRqIkT587TfaNfl8qrt
 2gy3ZOOMeCNUzz1bLPyJ7G59jzcLA0k3uG.ib9VfdY15220W5SKMettLnu1kxElcH97ywvrY.p3L
 k5D0VXuxV8vmlXj6.GTPYtVVvKTNL6fVqY_xc8.0x_a38k.PNqU0D3QQOz.pfWyLjtMczYEshPdl
 iOzSVDqeY3C7vdS091qF7ypRbj3QWL8Bfuomixg9O9iHUnfFwUPRC.GnnMkXH8vtZlD8esw3E_3o
 67B7LBdAkmagnl1nzgP6wedcxtgooR4r_HbKD6AJZdzf.lGTZsbyl0VP3K5sfgfMdY20V1kfpVfL
 .cNKz7LvcLJLvyOYK5Crnh9JmdtDKo6u9fF8A1Ir9hM.3Gsix_uzYOsaebJHI2Dbw3ndyx_2639N
 dhSO00XJQ6wLYlH2HewAU2QCUOzkvrOTXroz96h7VBJOTUI.5gkdNNsK.RdILBhYIKUSDohANZI.
 dj4EwwBgBHsYwNCFeYP4MAK5K.DQn4mVfoXA3ac0ivrPn0ExvNXpUr30lCQcGiaGJm9lr7uqb.Oi
 PdlplXK8RuZgbuyXnwc16uBx6FgMUe9xZqH5XjlWx11oGSmWq1R6ekoGNQjHRqamC26V29L7R.na
 7cRvzFnRdX8nTL3dXZBVfsCJ5aNJBqQBMYEZcT6VZStJX.U_jZmk5u7r1C8i87Keb7WofPKbB.kZ
 jGsPj2_nn8mdvIerwu.A2AqjK7XF_JxaIsf2b5vk.RwBfesq_A80VAFb_8kiZnTEaXQPHDRTGO9e
 zp6fQysdAVBA6TVSv2db0hwf3AH0g4AtwAp9VINYBpQ_pvqaOw0W9SFR2Jt7oO8c4Yx0_9THTfeJ
 pjh0Zhubakhcar6hP_PvCk_RN88wEvWl5aNkkJ6jvmO86NEyvqAUCtj1p3BATdasCoBYiHdRpPah
 XZgA4ahcQEfX.X6TjyDrsUq2bMfOP9xY0V2_GSJ.OMyeksmlm4r1y9g1h_0hNIwAv39BjKUNAdCr
 EITZA36oFlWHt6CC29pMPfzOZsRy2sO6RVcdzJNmijC070q4x6NSPe2CXtioqRZ31yvek7BcvEBx
 sqZV0HN0FfYo82Y0SGP0miOdEF.RzUTFyx6vjEQNaC5OAm4vtqNr1ARE1He0E5.bk9INYUmGVrlA
 lhKPA3s2_Op6Hs7FpLznOtKdOYPQ_bb8ss6b2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Feb 2020 16:09:38 +0000
Received: by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 04f8dc3ff9fac56c2e4b74fff34b2533;
          Mon, 24 Feb 2020 16:09:36 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
 <202002211946.A23A987@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <fd599cd6-c571-f19f-cd38-58777beb7a38@schaufler-ca.com>
Date:   Mon, 24 Feb 2020 08:09:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202002211946.A23A987@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/21/2020 8:22 PM, Kees Cook wrote:
> On Thu, Feb 20, 2020 at 03:49:05PM -0800, Casey Schaufler wrote:
>> On 2/20/2020 9:52 AM, KP Singh wrote:
>>> From: KP Singh <kpsingh@google.com>
>> Sorry about the heavy list pruning - the original set
>> blows thunderbird up.
> (I've added some people back; I had to dig this thread back out of lkml=

> since I didn't get a direct copy...)
>
>>> The BPF LSM programs are implemented as fexit trampolines to avoid th=
e
>>> overhead of retpolines. These programs cannot be attached to security=
_*
>>> wrappers as there are quite a few security_* functions that do more t=
han
>>> just calling the LSM callbacks.
>>>
>>> This was discussed on the lists in:
>>>
>>>   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium=
=2Eorg/T/#m068becce588a0cdf01913f368a97aea4c62d8266
>>>
>>> Adding a NOP callback after all the static LSM callbacks are called h=
as
>>> the following benefits:
>>>
>>> - The BPF programs run at the right stage of the security_* wrappers.=

>>> - They run after all the static LSM hooks allowed the operation,
>>>   therefore cannot allow an action that was already denied.
>> I still say that the special call-out to BPF is unnecessary.
>> I remain unconvinced by the arguments. You aren't doing anything
>> so special that the general mechanism won't work.
> If I'm understanding this correctly, there are two issues:
>
> 1- BPF needs to be run last due to fexit trampolines (?)

That's my understanding. As you mention below, there are many
ways to skin that cat.

> 2- BPF hooks don't know what may be attached at any given time, so
>    ALL LSM hooks need to be universally hooked.

Right. But that's exactly what we had before we switched to
the hook lists for stacking. It was perfectly acceptable, and
was accepted that way, for years. People even objected to it
being changed.

>  THIS turns out to create
>    a measurable performance problem in that the cost of the indirect ca=
ll
>    on the (mostly/usually) empty BPF policy is too high.

Right. Except that it was deemed acceptable back before stacking.
What has changed?=20

>
> "1" can be solved a lot of ways, and doesn't seem to be a debated part
> of this series.
>
> "2" is interesting -- it creates a performance problem for EVERYONE tha=
t
> builds in this kernel feature, regardless of them using it. Excepting
> SELinux, "traditional" LSMs tends to be relatively sparse in their hook=
ing:
>
> $ grep '^      struct hlist_head' include/linux/lsm_hooks.h | wc -l
> 230
> $ for i in apparmor loadpin lockdown safesetid selinux smack tomoyo yam=
a ; \
>   do echo -n "$i " && (cd $i && git grep LSM_HOOK_INIT | wc -l) ; done
> apparmor   68
> loadpin     3
> lockdown    1
> safesetid   2
> selinux   202
> smack     108
> tomoyo     28
> yama        4
>
> So, trying to avoid the indirect calls is, as you say, an optimization,=

> but it might be a needed one due to the other limitations.
>
> To me, some questions present themselves:
>
> a) What, exactly, are the performance characteristics of:
> 	"before"
> 	"with indirect calls"
> 	"with static keys optimization"
>
> b) Would there actually be a global benefit to using the static keys
>    optimization for other LSMs? (Especially given that they're already
>    sparsely populated and policy likely determines utility -- all the
>    LSMs would just turn ON all their static keys or turn off ALL their
>    static keys depending on having policy loaded.)
>
> If static keys are justified for KRSI (by "a") then it seems the approa=
ch
> here should stand. If "b" is also true, then we need an additional
> series to apply this optimization for the other LSMs (but that seems
> distinctly separate from THIS series).
>

