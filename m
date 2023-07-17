Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4EC0015E
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Jul 2023 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjGQPvW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Jul 2023 11:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGQPvQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Jul 2023 11:51:16 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8710DF
        for <linux-security-module@vger.kernel.org>; Mon, 17 Jul 2023 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689609073; bh=K6MaW+hc+AU1d2GKp5lt71d/ZHmrN5j8UiLiVcUMydo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WjidYh5ploP7BvRxHwXUFjOlBkQPz2ucvmPvOoctO3Lk/WO5rdkNLGGATp+18cHtsO5pf5K/xwaLGHLKAUqD8zV1z8DO/9eytyEF2XRfAFX2rMzdWbjTfiWvvn1bc/FQ/xL+jrFDyQLar+wRvkK1WFj99BENJn13RKv1CKgA+uGL4xa6cuI7l9Ns7M6mmA+V0ist4po8/DXw0gOIhr2bjyMNzgKtLdIQp3TjapAdyOVsRasoJgVSEvSWt30yhrVGnskF9Qct4S++WNIkqU5O8nyROe1cWxv8roU7GUCFrtExnY7dYosMTWdMEodaD5B9jyIzJ9Pm/5bQCXEPb72RQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689609073; bh=CXfw7Zc2EKWJs22ikvw4R2VuSjW/y8YIEetYNkb0SA7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=e84QbHxC/SEQ/t1cz7IVp13FavX8JGLR+guSV+jJhGFuY70UqhFtMTy3ZvjcYOVx9wqRRRCU8hNKl31GzU/v7wz/OJ1GRNdLc0ogDKEN4AXy4mQBdY6mU7Tck5qcVkNnSqOC6qPFjguh3s5vP2fVXzGdwzKBGCTEDLXw9165W3pc4d8cBClR1AvquBwFXs3eltc0EUIQwmumhcLJFwwq5Kl8P5B5eRo8O+uGo7VNopreTjkjZs5cEDg8tMlbAZgq+aWRDLk4ZM4KqC3kHjws5CKthfwLWj/tn6Qywuujk1aXs/veRd2+rhovpTSvrstLLsl4Tuo19m0YQOxYmIpbng==
X-YMail-OSG: h4EEnZIVM1l8gGvEdhuRS3qsV..95e7vrfRt.zqcWjG03FKYIGx25kXZdjr7QrJ
 eXQCCA7m32QY6l7o6QZdu0Z1YiNNk3Fn1WIUJTqs_72cMnmzqkps03jt_NwocqvI4MYvilj3Z5Wt
 aZm27qjj5zUfEk5mgkl6ApbBy1qeT_UfE6f8O9VD.LVrYTJd9kX5csbc41eQicMIadn2.JIVcux_
 4n4XYI85u9HNsA9D8pU6qNfH2PTyO_ua2u721gh.97oV0El_tw_f4PgscUmkTJtlhXxoxSt.wyYy
 vi7ZuslSO9TFMxOoPYBVVZK8VUjSrsXT7Ud.YKRPhbVvKv7sxww2Bg_1_57j8PA2PZ_ninBsPfoJ
 LY6Ak4oho_3yge1mTBNkXhmMEI1R5sVVttTGmvUCT_.Wub2mMeoQAo5nvcE2VGYKgONZjbMe_PMO
 5VW61nnlXEp5UlrMUxhM6jJ.b3jeql9kk.5xfouzPhmU0U03cTdccj7NMiuoSSF.RF5jTwYULhu4
 4bNh.tb3Nq.Tfu0T.5BN1YZr8DfXjpz2_Xho9RXvkw1pRE_AeCpd8CzMkSF.ueKnuVgOSsBwGR9o
 i87I8tJAdRzLCT2Ign01r4uaBduBn34QJF5Zn.twkk_t3YXFpvXBR4Iv_e6E2p0gLJ.JDWZRUWDF
 QXmhW8DjIEdrhICycmTOCOJDwJ84n3P9OerfnWgXkWeujPLdLAc2evlvBP8y5T5q_CT9dEDCUJT3
 EyFlbM8nZkfqXS1F_Tc16wZcxLDn8eCNd913dUGtbypbaVE7ifEK78aax8IiGECHxLNzLn_ut.Tr
 LQFn8FOUaS.MISmfsZ9wSwKil9phJ.y57GmTGJyLW4H2g627tKydk99CJmSy2gs2Pz4Nie2bLGUe
 b0AA8edUrPgtHzt4JCn0v9t6hL5Ur5SjLZeQqo2.AonotiOzBjqMxn1gykDOJuvA0My4xZfixiCh
 rvSjJuihjajPdF92kCbsAODstlwqwohhxntaJeoQpuCjHhFnzT1e8.vkjShbWKf8.YdyMWA8IWYY
 LMESghV7Hgre_OpWKp7ahLgqGZwW7tlEKXpGssseHyg6IL9j79Wn5v1nj8ut5WF_0.qhs0Ny8CsO
 C.RZ_1u6UyuNKNMP_OoF6v4epeOEIobCjptug9di6IVE26VQ9zdnMoYUAD5egkNA.nAGXti8qGOM
 F1jTIHtm8Eo9rJDstJ_XvkslMVfjY19NyGvPFAKa0EBVeVsheB5bztmvPIbl1hrySYb24mqWTG15
 YCnW1Oh1Xr7I1gvtb2kFwwYI_16Q1mgbF6gLGEFfR6QyCDTfvVtuQnsGZGz_.f.1MMJ9SF9vOjNt
 BDK2cTR5Hc_HgUsHAkIR101PF.z_oXC4pBQHHOKmfU7HUIu60uH2kmdt8zDY18u_SHoHNpJdaWYm
 nwFk2HAlFylc5xsBc82nxmYzrBJIlOO1ezhx3bdjkiPI9vvljabtHxTscofFWTcfPTUP6r9n1dcX
 ePVaxwuJnh5iMpARJrWvLXPWdq2WY8IRvTHxsdCNra4Z.Jnk0zMQhlQiX21YUsvexpWovyveGERU
 8JHcM_SixDkbdxnGBR.h8I00hGB5ZpktD9wdHFpuPCz5As2lrC0Gyyn.uOvUbZ6.0Z4RUdRYsBia
 DaOLwnj0uOdUx33QLXXfEmd5UWc.rermuiq258LGamCNlAplMshtA4aRqPSUjXaW9.CcwDm.leGr
 M.PSUkjmpmMM39sYUioUN2FkgJssdxg9xvZpiC5G18nAhnVDJl2wBHvnL1qzE8ahGcTIPGpS_pGv
 N7x69h44HVC9ozmdrCv9Nj.9ZMXeLaCQlcWMh2vrWNetncPCNxmIQZBJjMvKEPgRaW.u1ENx40uc
 pioRA1O6FEL03pWbf7DxoVlI_xHIBXEJo_Iw84qH1jAR_bQ6HKuX25.miqRsZYKVI2oSA2UV3ZzG
 cwIeDpEB0O1nPqwMOsFt5s3g4Y40HwxDJdKU6XWf8H9Mw2KvY0oareFSqJHEiyiNURN0w2E5pdg_
 otwhVq3kYHXlJaOhU7sagtetrNHDjqcsp3xKp1rmPGYCdde174YqNXAUul44Is0g4XcTu3CS8R3n
 ZVuXQfY2gSRWO..TAYu0bExiX0Q5EkAZY11vmpSbxDak_StzgUSU7rW.p_Q9ulfkwcVo8bEmdjba
 HqwhTu7tEKIAS_KwfqbuRF7eVFpVejDbZRpiNTebok9Sg7lfKEx.Thuz6OWocR.oHJsSBezBwpdY
 099QyJBxCo6xUQ6G9JVbwcV298ju8D36Dvysf41tB3ReQQrTYRuFWt.eisVc7DqZdROXSZFgCMqw
 O78o-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4fdf55bc-6943-4811-8fda-0922553fe6ab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 Jul 2023 15:51:13 +0000
Received: by hermes--production-bf1-5d96b4b9f-nmj82 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d5af6fe85a15efb9d3b32e4edf411b1;
          Mon, 17 Jul 2023 15:51:10 +0000 (UTC)
Message-ID: <f21a05f9-249d-e362-6ae4-32499d190a21@schaufler-ca.com>
Date:   Mon, 17 Jul 2023 08:51:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects a
 processon Host
Content-Language: en-US
To:     Leesoo Ahn <lsahn@wewakecorp.com>, Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <6bd218f2-af8a-52c7-cc27-6fd6c27d4446@wewakecorp.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6bd218f2-af8a-52c7-cc27-6fd6c27d4446@wewakecorp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/17/2023 8:24 AM, Leesoo Ahn wrote:
> 23. 7. 7. 23:20에 Paul Moore 이(가) 쓴 글:
>> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
>>  > 2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
> [...]
>>
>> What you are looking for is a combination of LSM stacking and
>> individual LSM namespacing. Sadly, I think the communications around
>> LSM stacking have not been very clear on this and I worry that many
>> people are going to be disappointed with LSM stacking for this very
>> reason.
>>
>> While stacking of LSMs is largely done at the LSM layer, namespacing
>> LSMs such that they can be customized for individual containers
>> requires work to be done at the per-LSM level as each LSM is
>> different. AppArmor already has a namespacing concept, but SELinux
>> does not. Due to differences in the approach taken by the two LSMs,
>> namespacing is much more of a challenge for SELinux, largely due to
>> issues around filesystem labeling. We have not given up on the idea,
>> but we have yet to arrive at a viable solution for namespacing
>> SELinux.
>>
>> If you are interested in stacking SELinux and AppArmor, I believe the
>> only practical solution is to run SELinux on the host system (initial
>> namespace) and run AppArmor in the containers. Even in a world where
>> SELinux is fully namespaced, it would likely still be necessary to run
>> some type of SELinux policy on the host (initial namespace) in order
>> to support SELinux policies in the containers.
>
> Thank you for the reply. It really helped me to know the current
> status of them and what to do now.
>
> Just a little information for who is interested in the stacking that
> we decided to branch the LSM hooks by which lsm the current process is
> in instead of entirely calling them in order.

Could you describe your approach more fully? 

>
> Best regards,
> Leesoo
