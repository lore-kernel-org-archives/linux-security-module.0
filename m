Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA8ECAAA3
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Aug 2022 16:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbiHZQPn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiHZQP3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Aug 2022 12:15:29 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E348DA720F
        for <linux-security-module@vger.kernel.org>; Fri, 26 Aug 2022 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661530525; bh=oUp8DX8jyJ7HHumQCC2ZFCAZqkPR5fu91FBV3FKlr7Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=naE3iXa9vF+v35nmk2nPgL/FrcRXNqr+4eZjIcIaCdjEuoKvM/txRjJGsCyQcjSf0+Hk7gicL39NE285exquIvalHdQNAlgihNXhX5xhEU8r0jp9L65gwaF0hql70JVjM5oV7M56VanD7Kf3U45gnWy16+GsuAp+4lTk1nOZ5nO3vvLO4SgfIgCJqfgXuP8sim5fFvU0+bjMjZDM6Ck8OdVagme4i8bKYhzjyAbfvMl17u+fD7YVSgzqTH7qsSET6upjkwfqEVJhtsznvvYsv2dazsFk7yS9E0eYJlOBYJNshgzu0xjisEOJWA3wsIVnP+Y79PSvTFXDKYTX2gsOVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661530525; bh=YKOcybwvWVUatLJGcGZdorPvETOUYGiWFpwLQkfyGxA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iMhu/G2+031ifGSM4b/WL0FyXb6i9/mcxdGm7FnwguM/mn4gghL2iEGpT6whNVrnOIgC4PMiZeWe8lzuxBziwjd78l3kuU0pVy/eK4upmpzDSED1tFmRygDG3hfY40oP2jCRLMcaX3gey6T314qRBizptSMElTdvAW/J9HIL1ZNFLinvhyXtj2554A+H2WF5/d1j4ld3P9daME69c4KMfA92Is4BmU7nqL8N608dtrPq03iZQbI6OeZurhKevmgIHe9IjkRGLAcl88ZcLCvDFPDAS91nJ+C88LU3dxdoVbLPZSPpMeIXVL4MFzGEjBxniVAPD+hf9eyoVXszKEHH+Q==
X-YMail-OSG: AQDCg7oVM1kRB.WVprmnYYReIm11qDMoosm5PzoEfI6xgjcOLZgBSztVwTQjuvE
 sX96FUl.WUVNt5H8VCkDrY3o7HI6vuU2wSKfXsWG15aVvinMh2hq7jEQSDIOUivl1tfqNwzM._9O
 sI19lnMaCnTMcwhZTV7zFqQ_yZb5kRxcO8hB7H3._yBp_xi1hj8N2qSggvDYT.yar88KSt3sQy2n
 vZ.XFca47vq_NVSnJR9YDU.kMx_0K4kh8FA8_mNix4ix3XNE8pPq9uoJfgi7D4w3gkwC6z2BAC96
 593IAf2M_.vz4nv_5n0Pg9QBhqFOg79bkEloAft1VaJjAEdxinJmS8G4tSJ6xc2QXL_B6d3ZAITH
 g6aVK5YJE_kuE6x3ON_DV.XtL_8bPAFjb7h_.sMU7mH3kxipeHgikuC48urqMHkyt7u6ecf8G0O7
 .TnU2MwuV653IZ07uvhDULhiFiWV25Rgbr9F_lQLIm4YUGrhnf_u9I4a26iss3X4JYuMq0il5OPm
 TRi02dCRcXWxDIzqJ3bbXmd6yWb3W_FnZubshtTNgN1eT_isj5jHuBfGmsHIVkb12CYip41SzQDl
 JOyht3bO6QdajbGrs3FlVfXLtvkt.fEz1GyPbkMIpq9zb1X29CRx1VchB7z1EYqcN9qCANczGhSp
 LscEhcsxSPJxE46rV.oggbsJDSNStdp396HRpHkiZGEWEHU6A2u3S6DItbgjiNSl17gJ0BkvdApo
 Mq1mGi9ZQ2nsNFSaP8RwrKDkKJEtqqLGQHHuxO1tZkPhYaVXm2Eia2LCQjQPh.heGlcnTTyXkppZ
 P_3l5_52s8dEEwAT.KrsCpWNn0Vd5KcLOgz.4ty93HeGAAnKN3feLF0Oh9Ke8WBuxhzLqmxx7DgK
 NLI5jpVaCuNx6jmuDr.jJ1ZqqNlM7ZKKJm17HnQcu.fBKGN_0COOnkJE31.Xu1BNtqx9dXnIswyr
 ZWp5YtmUuAwOPsueAF9pAqwMEykIAj1odmqvazxrks9uNfMNU7Xh.gyuaG6TOxlqGN5TvLOu2qYi
 aABny6V6owwfeNyOlnXPv4vkRZWHAt6UjWne0h5ngdJrspvWyKhSHo2bC4dm3zLNy8u6_BN.gqSy
 2u4g0XPPWeUtVl3hp8hgElr.Bbb2kgnBWe8btkfLNvpKb4MZv0g7tvr639l0.wp69g8VLTLsFjFk
 7VN8hPi9ylVcOaF6ZFSxkR9rmzeIikk9CzLY9fCDtcLk0M8_R_bO5EbaYyP5EqRMRi3.wD42LHed
 hS9BOmiADcMej9RXHcI7dNlee5ASO4TCqRUm4fjyK2DfntZleZocngxczXElf8Dse.thKn4X0kEO
 K8Tqetk4sbQp14rJIGaJ8eAkIqgDAQPXo5cQhQZo0urSaq5dBF2DqVDHomFKG6JPTCQH2BNd5FPH
 3jRHgCaumy.Em44oMARtzhRzSqpY1iHqwIyzj.iMFv8Hw5CRazJE15q3KsFT6iAUIJElog49OaxY
 y3vvBTGnxwQJUXixgaTIAIuta57rZ6EYYbMdS_NhjaTcKDXuyqJ95cwCEiGxxT4yQT5G.AiedJJR
 7rzsxfFbLeWu.JXxGEc4aFaPHtRjjgETiQs.WbqWCHzqp1lhp6pNkB54TNpBA4Qz0xh6f1gUTY4h
 CjNktjdTLiafbijw8ja.Y0brQ.L2V9DpLZJI_eGo2UvGySKepj9ioarYvV77mYsVxPmFpt_QjSTN
 sIoOE74jfDThvuUAQfWAfAMdf6h87rpeXVC1MifafjSMNI_Ov6bgc3nY0qzh2rGKDtLDSpCctz5F
 ewJnAL2lP5ST72u9qvfQS7vJRYzhTHwazY4DXF5A2et3eR5xKHa0eb5aB8PPhFxX9FrnEOP0XCPS
 DyjW9Y8CbvH3hcmSw5HoifcCkIAxOoKamGDJoxOtIlU_IBOlM.2nNnldyyetG9GKZPCahbnFWU2H
 1srCcGGPa3mWsNwYAzfcO_aMw0fLf8wD1OqDKF6pnnK5TGG8GbH_iCpzZshXOAOjtGCLc4OEMt6q
 0l421iavcjfri5F19cYvWSuPIcftRGUZwzi47GZNTMmS_Xe7F_PGnbG7Lgyez_uZYbSmt9MYLSUm
 6ThbqCiQ3WZxl2zLbecqW_TDxmfOvx4cBANfv0jR9ZUBemJoANw6hp7fJaKC.7PUapsCY22mK_kc
 a63VBOTB4hdggN7tVJ4bnL1NBP3xnPygxjYI.LL_4GpAYwC52AeHESSRD_KqubDpX7U5gDwN7XSL
 Kvblr_Mljlo4VBsMT45DzTuLZ5tiD1e45GEej0H8LOhyLUrKgmQz6HT07wXreY23YAHRRAJBBdgB
 .wCAYQB2Mwuk1xA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Aug 2022 16:15:25 +0000
Received: by hermes--production-ne1-6649c47445-5hpzl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5a249b87b76be1c51e37b6c861164a31;
          Fri, 26 Aug 2022 16:15:23 +0000 (UTC)
Message-ID: <2d4958bd-dc67-8244-c688-eed4feb64ba8@schaufler-ca.com>
Date:   Fri, 26 Aug 2022 09:15:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: SMACK LSM checks wrong object label during ingress network
 traffic
Content-Language: en-US
To:     "Lontke, Michael" <Michael.Lontke@elektrobit.com>
Cc:     "Ostertag, Martin" <Martin.Ostertag@elektrobit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Wei=c3=9f=2c_Simone?= <Simone.Weiss@elektrobit.com>,
        "Valleru, Yuvarajesh" <Yuvarajesh.Valleru@elektrobit.com>,
        "Irgang, Thomas" <Thomas.Irgang@elektrobit.com>,
        casey@schaufler-ca.com
References: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
 <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
 <0e3266a5c93229b29c10a0a7b68232000453aabf.camel@elektrobit.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0e3266a5c93229b29c10a0a7b68232000453aabf.camel@elektrobit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/26/2022 1:40 AM, Lontke, Michael wrote:
> On Thu, 2022-08-25 at 08:59 -0700, Casey Schaufler wrote:
>> On 8/25/2022 2:25 AM, Lontke, Michael wrote:
>>> Hello Mr. Schaufler,
>>>
>>> we observed the following behavior of the SMACK LSM kernel feature.
>>>
>>> PROBLEM: SMACK LSM is checking the wrong label when receiving
>>> network
>>> packets during high system load.
>>>
>>> Full Descrpition of the Problem: During a test scenario involving
>>> high
>>> system load (cpu, memory and io) in combination with ingress tcp
>>> network traffic, SMACK is checking wrong object labels leading to
>>> denied access for valid scenarios.
>>> In below test scenario the label 'stresstest' is only used for the
>>> application 'stress' but appears in SMACK audit logs as object
>>> together
>>> with netlabels.
>>>
>>> This issue initially appeared on hardware with kernel version
>>> 4.14.237
>>> but was also being reproduced with qemu for kernel version 4.14.290
>>> and
>>> latest 6.0-rc2. The used rootfs was generated via buildroot version
>>> 2022.08-rc1.
>>>
>>>
>>> KEYWORDS: smack, networking
>>>
>>> KERNEL INFORMATION: Linux stable kernel
>>>
>>> KERNEL VERSION: 4.14.237, 4.14.290, 6.0-rc2
>>>
>>>
>>> KERNEL CONFIG: smack related kernel configuration
>>>
>>> CONFIG_NETLABEL=y
>>>
>>> CONFIG_SECURITY_NETWORK=y
>>>
>>> CONFIG_SECURITY_SMACK=y
>>>
>>> CONFIG_DEFAULT_SECURITY_SMACK=y
>>>
>>> CONFIG_DEFAULT_SECURITY="smack"
>> What is the value for CONFIG_SECURITY_SMACK_NETFILTER ?
> # CONFIG_NETWORK_SECMARK is not set
> therefore CONFIG_SECURITY_SMACK_NETFILTER is not set as well.
>
>> The implementation for IPv6 is much more robust for the
>> netfilter enabled path.
> You are stating that
>
> CONFIG_NETWORK_SECMARK=y
> CONFIG_SECURITY_SMACK_NETFILTER=y
>
> and therefore using SMACK_IPV6_SECMARK_LABELING instead of
> SMACK_IPV6_PORT_LABELING path in kernel code is more reliable?

Yes. The netfilter version is used in all known commercial deployments
of Smack, and hence has gotten more attention. The port labeling code
is a "clever hack". I hope to replace it with CALIPSO now that CALIPSO
is supported by newlabel.

