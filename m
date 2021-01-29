Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A40C433E9
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 02:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12076146D
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 02:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhA2CLX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 21:11:23 -0500
Received: from sonic314-28.consmr.mail.ne1.yahoo.com ([66.163.189.154]:33809
        "EHLO sonic314-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhA2CLJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 21:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611886223; bh=nmqQSbvblTCv+wTXEJFY18K3Fa1UjJdQ8IW6EhVTg+I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=bIH69WhxflGrjbpsJbOwAB9fslvHGClkk1tkZNXlzCyKCzF4eNrRXT0Y+tNr/JATb17aWj+Op9Tbj8Siw9bTNYpz1zAnV0X/mL+zl8tI3ls4NeWUbMPpnozSxtnJqO5gAHWr645O43CYtCW8EpkW+oJXSnx+8hqDdLbwdm+WVumh8SSclXRQPROpav/WhesRCUNsyi0PdNPzX7Rxhmue8H67vg0NLO60u5QdHTYHdn/9YC/EfgLtqVaC9mcRI2NWa8scwo3MqD8ZDHIvtke0KOi1s+MldTi2KDD8iknB0STJfB4/hph9g2R5gR8sRN0vJXCMfr4l5pc4g7YbucxBvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611886223; bh=7ZB5PhY1DgQl66BIEPOxObc8UGhCLL6Sx+O1A6irJBb=; h=Subject:To:From:Date:From:Subject:Reply-To; b=nw1Uj8FGW77O30aBCtNBAtLqoNEwi3CBmO3y203loFIwlqUlwgvLvT6o5/M83QAwvDw8BkhN+1+G+uojjSX1+YkoiWWlaVnU8tBgr2Zv6s3KhTfBOQBQ8MUJLyo3tRUFBf0vDR8DdiyFGgwa+i5RuyePGTDV2LpoeWbvRY4Xw5I/+BshGYztTlPa/o73ZRAUqH84E1ycaFnGEh+utv2WDgU1j/XxZKyAJGgR/Vo21Kp6eQ1CcGWtn1nOotlPPoalx5H4FVrIn4kubC6e78nNOiigD6FMJNEma+fxVJGCWZOWKJSHCiKkzIBOOqfJeVKoHofFVjnoAhvPt9G7KnopSA==
X-YMail-OSG: fbWFyHQVM1mAaiLI1kafayn_vsSSo4Zy_wVHyI_eWzX6gKFPYKWrM2kgcp94Wji
 FQ3y1VFLx_jnBrXt1T0tunJHg8cKwH9SeGRIqeCRujdolGeP2.XQM_seWEgdRMAY53Ql_yOe3PHV
 pnPr4jSuR.Ko9VkRYKRs.TD5W8VaCKd1CxwqD2jRW2L4oITj3XdsRTl67tu19th2rwtCWA7D.tfx
 7KmcY26.6UF_cWAUOPKmuAAqO1k4OZwF51H6CVbkJoQflKL8ruOjt.MzVX0VxQDCT.5zh2ewK98F
 3bCWQpbfn4JxDNPVF7gvcuIczVDcBPe_bPw28GnbaO8aL5lM.Ux_eqkkgOURoqxZ1IqoXyA4BhYH
 kPqy3AdttmRO9g6dp7AWrZ4nq2sPg9.1cn4jb.009ggiirkxXhmfLA7pXSvvfENBVg7JlXr6JuvL
 mFvrxdB94YxVc7A7fJH2CZBH22S9xH7pPDUZYs40eWI4BPCFO3Q620woblsIT9ggoyyA85uHOFpS
 EZ46.EBb9RM_GxeQndVLEV0q0Ptc6_IezrIR_AVAjS1C0b6dMNq2Z3VS09wISVsL4Fuy7Av4AI5i
 M0iT.45fSk4iXMGc40lk4MdPmOIh6dJ4ELoTN6jYAiAlpeqHVE9oDsKLjZMbGyb8J3fhoR5_68R3
 lGi.Yj3oQ3XE_QrvvsYpVnU_zuNq6DKaoafPwIpiUB2hIrIPguEo9CwHrT0UJG6IbJM8tYnoZ_SH
 XpQuQ.9ygbB8jV4E47w2wVN5vPqCHfh21c90pCl7ONnUjtow4h.nR0vGaleuEbFkZo8Kwr8b0J8L
 ixVmt8k8YSMRGlLG0AP9_8sZqF.epufWrPIIP799vAaFYIaVG.se8pbfFsySF82XbN5d.nO2nXA1
 yKh.4tHBkuuOQybXo.tKTbWAF1uPj5UbGiS_tK8AfWnszxcHkDBjWsdxMy5YIUdEn5dJmQLVQzzy
 6PjiGJr0tMyTTVY3ECGwI6ATbvuyVXNGdrHGOukJxIOowY6RjC.x57iek_koi.voTQGuLTTGjaWb
 nyad5gzO4O2KShX5i4oZ4EEe8Kzkwg_hWKJFhYsIKhX4STYVHFEajEvWacrnGRxtXO7y.SYNoVyX
 rO4DWf63bNhK101nsafTdEeFdknsHiXN9EFPAz6z2Hlw4OISLkWSrE4N3HQSxkZYSE9vTHj6sxff
 AYrFtQKSI8cyeBeN6NrnQwFgOTuXlfeLCrGAjQanYz2WiBh3kc2fTGJFJUF59psJ9vgY0J0kSKTR
 Sg5wP3QqE0tkcnb85oVho6Z7iF2rQ041DHzX037CV7RFxoNFAbqfyT1kLii5myka2K8BT41Xzvlx
 tGummejl3VxWx7UaxQehEoeW7hIwf0qA_u5Ah1e4oK6KGgFFZ6vcVZx5o2LjIOeJiHlBAMO..vuc
 ZA1Bj8BAVdg5hw2aKrq4mwrAhn0hnl6osctDc.06mTau3hbcqPMZkZX8Lh6UytLX9iXlo1vXOvOH
 lGaQHZHjmSPNyzIIkk7pv5IHyd_qFBgle7Lz0S6enbIQSxlTHRky7RlwUiqmaANC4Gy5PWqL21.G
 Nb30k0RDH5cY_I.6BhlQqMzArICvixvFIBTYsGYHKBPeIo6USYMnl5qF2OWhzjusUEHsaL76AB5y
 34TU5mZh3IAbWK1B68U3phG63av_sYm93qubpIhG06KyeHyEAhjmJu_SpfWiCdHRmJp9MKx2h7lG
 MqfCEO3xfe.oXM97pWvArB94O4QfJQxEn09ipiB6LWzD0WvSTNfGVfXw_0LVt5VEfpwxShvfCVw0
 d9u0wSAlxdqQ6nkoIYP3R8yoeHRKMDRHABc2Fp8mCcm.u_CrJy66Obd2ZQ.JQlidVILHsYppZUfN
 WcF0myM4ygSbD7qiiErjKAedo8i1bj6bx7Oh2.aa96FhQCFOXQI1YumFHvJeFaaWyqM1etCwUI0Y
 sP9dkKOblBAOlDvCtEiG_q4BYzv65p6pkcWavX7SoLc1JvuLj7nGUVQ9u7CzPlHWPJnUGEePm9G4
 LhhFHfBmYOOdTgesUVG4kGSQR9Z4Ql7PSP5JumZ0aVjhtTFZD0z.3Q45dxbzQS.LifpTXGQhXSWJ
 mt2XtP6PZwiFTLinn9Z9gIFWOKrCs1TE6QVUkwGsyWHEEOCtE3KC_y07irTkFGlJaF3OJN20wEIo
 zW6PMipSwJXSJWRkYijvMoIoBWH9l25kNNHQIzfuPukk187r6oTtJ5UGuK_0IyzA_rnBt79dIOh0
 CqRPs_fj3yQGRnfx.5kAOvf4MV5A1aMXHKNVvQ53d8x_4xEJ6VFByy_BZW74xorGTSLZ6afp8aJ9
 Gf.6OiVyj0NVTgkDDGqb5qbsdEbhI1UjfWpSyPl2tacQmPfQJFEgxZNcY2o5jDkJm0slucFnSNGx
 zUbtt1YceWYiLgXPLC5bi.Dc1IwsHVnHk9F_HHnu21tCQdbTklv.d1ajh.kNNYP9W.ws78CyNXza
 f6CjntrOkn3fQs_aPJAL9lNaClL1uYgI1rYgAcMm6UchS_l7env4HOm8JkIGj0jpWNMgFFR.uibn
 izw7YxAAzvM8ENrpHYKi8814xno256MDUiXgnLRlBjwF9mFnPoXjTYeaOu0CYKcdRv5ltEP81_DB
 dc2XJduVRrNDuB1zodTVSi6NZZ_Tg1we8uc2LOSKIeohAm8Ld80n3IFqVvlEuHp3ectDcQ5PVSyK
 MwEY73lTmV67a8JLxNGRMKYpOpocdf63_BwQDbJ4pyutxUNrxn5_b5Zij1VUd6aFSDLK9HH.fFTi
 XZyx4ayIH37NejCAEnZwvrodggXthT6yPbM9M8CJ7FLyzpVzt9epyLYHxiJ87_sYCaBMx7PPqKxJ
 G1NHCXSfDAbGVTEPpaBVdj5OfRBF2MaRJA_Dh_JnuRs70T_ZwSX.U4HGmIidfNj0pb6HeNYPi4Dd
 B89yQJfvcg4_MH2lul3L4MjNmBxK1sTtg9wHNjHMoW65QDKdaa4BOjszw2OTOvy_g.2O_fEkOi_q
 Gc5sZJ1G5E.7dJo893vbK5Azm9YGrm2f0Tld24bEdIhKnNeJbZuG8hgbzzHPEo7SWlKdTahqgUoW
 pdDe4FHQr80N5mO62Zf3r.4tacjo3HykzMf8e3g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 Jan 2021 02:10:23 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0425e2d4a9c569fe543c639caa0962ad;
          Fri, 29 Jan 2021 02:10:22 +0000 (UTC)
Subject: Re: [PATCH v2] smackfs: restrict bytes count in smackfs write
 functions
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     andreyknvl@google.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        serge@hallyn.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <5271074f-930a-46e9-8ece-2cc65d45dc19@i-love.sakura.ne.jp>
 <20210128132721.1111920-1-snovitoll@gmail.com>
 <8d66b6fd-81d3-38bd-703f-522a2e2d6fca@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d0f9a341-281b-704c-04e4-4304ed17ba23@schaufler-ca.com>
Date:   Thu, 28 Jan 2021 18:10:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8d66b6fd-81d3-38bd-703f-522a2e2d6fca@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17648 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/28/2021 6:24 AM, Tetsuo Handa wrote:
> On 2021/01/28 22:27, Sabyrzhan Tasbolatov wrote:
>>> Doesn't this change break legitimate requests like
>>>
>>>   char buffer[20000];
>>>
>>>   memset(buffer, ' ', sizeof(buffer));
>>>   memcpy(buffer + sizeof(buffer) - 10, "foo", 3);
>>>   write(fd, buffer, sizeof(buffer));
>>>
>>> ?
>> It does, in this case. Then I need to patch another version with
>> whitespace stripping before, after label. I just followed the same thi=
ng
>> that I see in security/selinux/selinuxfs.c sel_write_enforce() etc.
>>
>> It has the same memdup_user_nul() and count >=3D PAGE_SIZE check prior=
 to that.
> Since sel_write_enforce() accepts string representation of an integer v=
alue, PAGE_SIZE is sufficient.
> But since smk_write_onlycap() and smk_write_relabel_self() accept list =
of space-delimited words,
> you need to prove why PAGE_SIZE does not break userspace in your patch.=


if PAGE_SIZE >=3D SMK_LOADSIZE all legitimate requests can be made
using PAGE_SIZE as a limit. Your example with 19990 spaces before
the data demonstrates that the interface is inadequately documented.
Tizen and Automotive Grade Linux are going to be fine with a PAGE_SIZE
limit. The best way to address this concern is to go ahead with the
PAGE_SIZE limit and create ABI documents for the smackfs interfaces.
I will take your patch for the former and create a patch for the latter.


>
> Also, due to the "too small to fail" memory-allocation rule, memdup_use=
r_nul() for
> count < PAGE_SIZE * 8 bytes is "never fails with -ENOMEM unless SIGKILL=
ed by the OOM
> killer". Also, memdup_user_nul() for count >=3D PAGE_SIZE * (1 << MAX_O=
RDER) - 1 bytes is
> "never succeeds". Thus, you can safely add
>
> 	if (count >=3D PAGE_SIZE * (1 << MAX_ORDER) - 1)
> 		return -EINVAL; // or -ENOMEM if you want compatibility
>
> to smackfs write functions. But it is a strange requirement that the ca=
ller of
> memdup_user_nul() has to be aware of upper limit in a way that we won't=
 hit
>
> 	/*
> 	 * There are several places where we assume that the order value is sa=
ne
> 	 * so bail out early if the request is out of bound.
> 	 */
> 	if (unlikely(order >=3D MAX_ORDER)) {
> 		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> 		return NULL;
> 	}
>
> path. memdup_user_nul() side should do
>
> 	if (count >=3D PAGE_SIZE * (1 << MAX_ORDER) - 1)
> 		return -ENOMEM;
>
> check and return -ENOMEM if memdup_user_nul() does not want to use __GF=
P_NOWARN.
> I still believe that memdup_user_nul() side should be fixed.
>

