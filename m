Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9629FEB64DA
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjGGQuy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGQux (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 12:50:53 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB62114
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688748649; bh=bSVqOwSyMu5aAXBzVZa0kzxE1dM9eqS1Cku17av24mM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Zaar0ZOQk1xM4wCr3ou9Lco11tp3YjoPVKx65kzOb2v5i/GLtBJ/kQbThpz7wx/Rej1HXMeFTuZ4V4maCN9cmVtIY4evzQMbQpnecHMHcgyu6Fo/KRRyPn0JNrO95jJbiAr0i9IkfTN2bJf2PTYg0UBb85tDLqkyzYHXtjZa/bgAv76IH47GN7VCstcJ1B+Cs/lTvfB2KWgcjSz1CDMWelLWD6rcG9OmAbG3+WZwEtbp30sgiThlgmWQkTkh3/KF4aNr8E6NtSajlZAnVXoH5YFKKsOVLwSvZgbChdn05g2zbbJJkdLo6LfslwI/UIXklpTTbRtSUSPbs1vBv1wELQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688748649; bh=EgS5Vxn0QGhqlTKWd8t4l0Gl53/Cm0Y7DkwTc+tWnfK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ota/+iSxalJydVG7oXhlePCoX1DZB196VoZP1vck6+Mu5MUlQ/RUg7ag0YHSFcRMxl9ahHpIDsgG/vq9ZrBSAM3dHZP7pNyUc8Vg+DYT8wfc40HH/ZAzhWRZP5P9Y+pD3UW9tsqTsApHYnp9B8HvQjoDMPA6euw/cNDBiu/FbbERg/2jOR3+w5ruVQ2omKXBQATnEXPcSA9oZiNacIEh7jqH92EYc1M0hjHnOF5KIRAroZ9ilcoR43TPdF3qyJTAJaZZkNnw6c26MrvsYIwNrq8xObjhFUi2pWhkLNMNYbNa5MS5ChLwj2NQ1gN/KJqI722yHPRh1M9aORI93Dj/kg==
X-YMail-OSG: jii3WMEVM1lSh.dWGBUyf6njQvSkuv6f4oj8gPIet7kT_Z5Eem1mEmsD.uO8w20
 6M3tYjU3zHDTwR8CNH0nYGFKtZoc5Fw0ps8Y6uTnYgiq2HcHFUXO579rSNVqovEbH9Gl53teI1sn
 o0JaIs5Yntw.hMH2TvCdn8hPZZ9ruEFEPTfpdN9DX5k_NKbH4yoV49Htrv.1pJiQQ0xZAwS6Ryyd
 koa8RSe4ao9DRMVpDcJ_qE1L56avbV6.0sKVEJ18cPBcdAcuKOO9UfHaNGXu2lcFt4Cgd5GVQNHC
 uI696SWe8J3kC_I9r05.M4JjT6B0mAJ5NqGF0kWkG3JL4QIIMeX3q41tNEmAl2NTEVnKgq5o8bEH
 t7QLA2IDZpseXbD_KsDQKnbOXXtrvzPHpqofpHssR2AVdCHfwjGHFpNGjRO8niqQpk1ma2NHmZy2
 c0o3N8UcF7ox1DkE8J8IDuwDKfvNAFwYSsPlB5.SDq5V75.Z2M8_yDDCW6H1Q5QJAL.vl9Zcm_.d
 grJSYEf1C987jcwZHfOdS0.7_jgsMTlQkEL3aD7m9NNFSupCIx.1LVwUWmOYjd4qPt2_DEY1SmVl
 kYm04wZ0RVE6wtVlLbVs.G5KuequE_xP1STZ6eC10dZ1eDAHNpzn.AdSGtmncMTwSHPwstTgbyQg
 7KBfBqfNCExvw2zY.KNVF0rYQFdxpLcXTytGaWZRcz9wGbfjNog0LVw.2q89SsM.jalq4bsearCZ
 5Xg_CExFXlWSRvdK4LR8cQ_BEGS0dLW2NxcIpgvy9pZTxPNLDq_tqK1jWW3MR8vtBwPWYyCvHrgT
 zyKzO8cg0bw7P2T2JuYP2xCoWmDltFn.Z2Tl8S.veHsmgkSLAPFN6oCSbfnbl433GkP70pZKeY2T
 Xk9gyVELg19obY1ngYHIsIqEBoFhCeS0Ucb_0R8abzxat9yPNeSnM2Z385najv27VZ1heTkvouJN
 78zAwMPVpT5Yrbmm2AKZSBW_foPeaSlXhMKGlCOQstE.VdwM0dv8mYggXyVOrX2dgynjuxb7.aMe
 lfc53CrKAyBABnXKWYbBLAQNrxj9GyNnh.SJSdt1yDj3jjG0YhuDs54T1V77P1jk1odH2J9wMIHd
 d_pPiyIbuSP5ttdHA.nSLvdUo7ErQAjTn5E17.XOePoH6GYYVjlpXuVKVKZfpZY8Z7exz.avka2J
 gKN8qlyNyg2MASRq8CCQkD.XT_ktVjMXUUxjRr8t.lpg1ZQuCrHR1n.xYGk3Y.CzdWDrJqQyFyCn
 sGl0Ely4tnbJcklhbGbkvH_3DU1W4iNf6mI5il2PiXEYQDRs6Qpcqli0w4qt8tuOWKvg3kcY3sGQ
 BhQzHuBExsXXkGZtWUV4cv6tDN36BeDi150BpWewQKMeGzW4wGMYWqnlLlRcEwL9fhpwMrTnVqQ5
 xF9Z.OOJvrXuJucaK2Acy.XXn7HXLXrYCXmDXjK8u6o2VArD.x4T.nsd3VBo1DjI4GIKZcciV85k
 WMC21FJr2Y1BUMBRxeQCsUhorue7SjalA7AyQBGGG.dqJbt1VpFD037dnHb00KwWV7Qh_4gBrj2_
 p3MnwEHlwRU9zWLY_cdhU7wMNN.xkKH69CS.aaf8nCwM8ha1EXc5ihRxdj6y_Uw6YdXkERiiquXx
 kyOz7ElHoXD22EK9XiPxv73aKr.gmR2wlIXEfkc_r20tTjZt1lYdGUxCISyz5lLCnIGmRtz049qW
 1Y1mBXh6L3iuhKc2VNG_mLvPCa08Fz6syXH0YM.lgiEpgsU6FNBXh6t8u56k0kr7iQ53z0NEa79V
 HmKirstlTmJhcnt6QkikOOk3Kxn0In2IcGodNBFWLlkc2IEHUheZvoctQfkKPHQ7DFzqfWA6TSnr
 nA_bEsPYxfbK8ZX.R1fuiJneShcagSQpSIb.v1J.3_ZOy8DqWdqePd7BwitnnSXs2TPjSl8ZAqcx
 RhV_drLSgM4u6ICL146OHdhihBSse5rZKa7._3SUNq3xO2ezR2_SDGJjvh9b2amW_ORglVSoKNq.
 N7PEyHyX57F3EMdu1e30W0WiqA6kDCMojNxgI4f04BYTA1R5G2KvglRbAjUqQRX4Wk4uaCy_hnmv
 GX3k4XZLaWYHEmp8dYWATv7g2n9dULNGzhhjVGzxnQfWevVC7eisN9hoH4_1vy8jEOHk4j74buGk
 1LaHPVH.5v_zT6tvHZocvj18Jll_EGAyomR0IrMyWSuhanxOSidP4dEUSdbrMX0pqamysJWvU2b6
 MYtJiBSfGKcx9MS3chour6VN_2ABdpo75eBxm.pIyEbrCWRkHkaM7xPJ2ASbk9OxMBf9NFj2K7ag
 VgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 86f05f82-c883-4f1e-a323-3745712aee51
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Jul 2023 16:50:49 +0000
Received: by hermes--production-bf1-5d96b4b9f-chf5g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 281f1646563d0530afbd86272a4e9cf8;
          Fri, 07 Jul 2023 16:50:44 +0000 (UTC)
Message-ID: <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com>
Date:   Fri, 7 Jul 2023 09:50:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21638 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/7/2023 7:20 AM, Paul Moore wrote:
> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>> 2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
>>> On Thu, Jul 6, 2023 at 1:20 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>>>  >
>>>  > Hello! Here is another weird behavior of lsm stacking..
>>>  >
>>>  > test env
>>>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
>>>  > - boot param: lsm=apparmor,selinux
>>>  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
>>>  >
>>>  > In the test environment mentioned above and applying selinux policy
>>>  > enforcing by running "setenforce 1" within the container, executing the
>>>  > following command on the host will result in "Permission denied" output.
>>>
>>> SELinux operates independently of containers, or kernel namespacing in
>>> general. When you load a SELinux policy it applies to all processes
>>> on the system, regardless of where they are in relation to the process
>>> which loaded the policy into the kernel.
>>>
>>> This behavior is independent of the LSM stacking work, you should be
>>> able to see the same behavior even in cases where SELinux is the only
>>> loaded LSM on the system.
>> Thank you for the reply!
>>
>> So as far as I understand, the environment of LSM Stacking,
>> AppArmor (Host) + SELinux (Container) couldn't provide features "using
>> SELinux policy inside the container shouldn't affect to the host side"
>> for now.
>>
>> If so, I wonder if you and Casey plan to design future features like
>> that, because my co-workers and I are considering taking LSM stacking of
>> AppArmor + SELinux in products that both policies must be working
>> separately.
> What you are looking for is a combination of LSM stacking and
> individual LSM namespacing.  Sadly, I think the communications around
> LSM stacking have not been very clear on this and I worry that many
> people are going to be disappointed with LSM stacking for this very
> reason.

There have been many discussions regarding the viability of the using
different LSM policies in containers. Some of these discussions have
been quite lively. I have never claimed that LSM stacking addresses
all of the possible use cases for multiple concurrent LSMs. If people
are disappointed by how little they can accomplish with what is currently
being proposed I can only say that we can't get on to the next phase
until this work is complete. 

>
> While stacking of LSMs is largely done at the LSM layer, namespacing
> LSMs such that they can be customized for individual containers
> requires work to be done at the per-LSM level as each LSM is
> different.  AppArmor already has a namespacing concept, but SELinux
> does not.  Due to differences in the approach taken by the two LSMs,
> namespacing is much more of a challenge for SELinux, largely due to
> issues around filesystem labeling.  We have not given up on the idea,
> but we have yet to arrive at a viable solution for namespacing
> SELinux.

I remain more optimistic than Paul about the options for supporting
generic LSM namespacing. I hope to explore a couple notions that I
have more fully, but as they depend on the current stacking work I
may not get to them very soon.

>
> If you are interested in stacking SELinux and AppArmor, I believe the
> only practical solution is to run SELinux on the host system (initial
> namespace) and run AppArmor in the containers.  Even in a world where
> SELinux is fully namespaced, it would likely still be necessary to run
> some type of SELinux policy on the host (initial namespace) in order
> to support SELinux policies in the containers.

SELinux policy is sufficiently flexible to support what would look like
different policies on the host system and in the container. I think that
the administration of such a system would be tricky, and the policy would
be very complex, but it could be done, for some use cases at least.

