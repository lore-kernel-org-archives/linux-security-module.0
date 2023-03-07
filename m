Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF67C678D5
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Mar 2023 17:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCGR53 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCGR4y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Mar 2023 12:56:54 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BECA3B4D
        for <linux-security-module@vger.kernel.org>; Tue,  7 Mar 2023 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678211500; bh=j1xXZ7AsC0SiMy/xoLGhGDWAEScUiPsakL/c2zQSjSk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Qf3JsGN0BG2utCpv0EU1oHMI02STZHdT83vavRU+sDIs7e/AkREXIxF5IeBotS7Egv4gQDLhheSTsRLkET04jtCaq/M3+oh006Mj0TOrkmcC4EbkN2QN4NTEKWMBtfgRkkXRJnGcj8SSsDheWI0quJk9YT2Q3goW103Grtx3QYw4MOv0nFGJK3Ga951Cv9Ru2d0FC5SUXROOeGFawCY2UK8jcCxqhNwEuRIshY9YGfmDjeN+G4kJZcftmVkMLeFZLreLGYKyrv+uxJYqPBr0bl8ls+v3bTujbwAR9qgmJZTgqZwwfXnunKBwB0+xfMRaMfZvGRhHoK/UObYBL7AKfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678211500; bh=TqX//aNrylf3uY04/XYPW/2pwOHu0S2I26jrnAa/Ypn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hU7wQngi8m7rY5BgKDdvhFIg+ym3+lYZHUdHCoCiXQXH2xIxZUDNs8ANA8C/INRJw398cbtzIhzkXJtCt3g7fLo7eVogA/Fy2DcbYwIgmWY5nX6aV68faitrirAsKXhhT3BlttgXEw6MH+F8QsB9nirOIVMF371AkXKITzKeH2PSRp65D60dO8KlVyr1MZEMPG29PcqsjfDwJnHIG41RI+X10Gow73SBpNa7i8O0kPEn+QxC9qReJi8YZ4U0zICKUy8jXZLKEWwuDdvfSI2aSSsqT0gUdtMH1YQX24AKmINBCwIaLJDuVgBRqMTM7GOB/D9s+9u9yu/UQfIV63rRpQ==
X-YMail-OSG: aza0gbIVM1mSqS2YSXZafwDRlo84_S4r8I3Jn5G1d2LprBz0S6_2UQsIraczz0W
 r_XIRJgSurJQYgfyWoGGlhaKrvmzr0W9jNlnhrsM0R1fuZCWj7Td3TiGeMuoyCnnudV_Wh1FzciY
 1UKaASvqhL_AKCjjRBMe3sQt1BBGq26WEylZ3yoisdE5dh4GK56Uy.4Bw_NB6Ydgxvhie.pzguqY
 EDnD2LAbN9fIA4LMUwsnACWltczblgB1KpYhmWN6xCSE.A8.H9l60gFkUA.iHhNVvhadZMeN255s
 knB0Rn_Ah40D018V84QvzfjMNZPoXd5J1m3rh4n0g9osVai0KKU04_XadT3Pikhh8hIepFTWc6RY
 .DWmDmXlJ7gh56lu7qOj.KQ09AecdThLplohEIhdmpS1zimbhMpbS4y9qXo6cPmtW8Zg9TSqdeRy
 keLO5MyGJNO7uYdC5Z0J3emG3JQ9aRg3flX_NyXLmFycO7VlkjuokC.nAPHSof0u4TP243YQ43zx
 l5uoxDVVqXO05KI.huwy9T7fAW4EXdAG.5ubeEHJGkt6ptzbjStMOAnj_ZHPD2FdU14_136wIGAt
 iljlVh.x9n57bfn7F_7OIvblS7pOMhDoA_ku0WhtpotJhJY7DLNIV5mFVyuD9iMj4JfVypVuM0tw
 YQzs_yMZ9eYjNBGlR4JuHM4gvYQSPI.lvRPA6IPiJUO885j2XpllxTqajrlIbtAtiFMdZXCF2wFb
 yxJdnOOuhZqpvp3PGoynFatIsW58B4ddpl11TxH3P5jLmyd0a6_5RXXQdv6hjgAf13Pw5tYMntaM
 xpbXWPXhFgWnOeYJu_XLBBBre36qrmdcbpDhjLIxKh1Mj97TQ.9ZhSn5tBaIRgfFNRWgvBNll6SU
 boZAucbxZ2AB8cnMbfGAQxPCgbYxQ_Ghea1dg1tw7wGK_yVZQcdt9CseccwfU95_1Nf5v78KG95r
 tvTuHKAF40jBw_LwUdr94FcHiYoy3KruRU0Ga1AMDeORovkrzTY.kmQrQmhVkFAzevK3hDguOjjC
 jrPOW8XKmbnwap99thldAbNF4myKrny1IR0qvD9oSZOohA0CuURCI23D2z.bGaA4zuwfBPPZtLQ1
 3rDShcHI59gOfY6G5QnmcNX9FlM4jkvWtqdTXRzZnY8ZAVZ8Qt7TAXUr0RVy6R90P4sxnbKFAZbL
 jQ5BlpLUT0wwuYaVTaQWcJ46e2TEhRMKrfoO_mZqdCfLUqeSlNvz37rOxTyW2xjO6OvkIHfG6xlx
 fUlHvFIj_yrJI6MhsvYIHEMf_S3ReJbid_zcSAEouwqlsgXICbko64X1gm9cWluWaWIY370LiqhP
 Dk6yhET.KOc.u.4pEo1APMoQONh7jbD4.tlki1pUAWp6_MfgtypCJ1V9UGO5DdqMWPTNOOoQNvjs
 rIS05Ra8LxoAyh47PLqJutIcaLONhyOehavE9QYkzuUDTEhmGhXy59TtXgm7H1bnoJSv_nStI9HM
 L17HJWb8.6AJnsfCinArjwtZoetSesq2EWtXtK.tNCFNoKI.31nNeDv76RvtLrx.niTzHOLbryo2
 _z2QpeiC5gauGYXNUdzIA.yFEDjcdP_5bTa6bQksUQHbbH0JqUfiwpKgkaHGFfi8R8LYiBBHTPtN
 usmUG8ytbudYAdB7kjbxpxyj22Klez_ZsTzUzEW_ngmldAiuDM_8ETOaMoGIqu2qzdK3ekgHRyg.
 FYgzBZ2IA6RYCVnwDPzKgI7w6rCt17Tn63jPolKn7r9M1kpwzy0JhYH4LMJarWnoeLLrotONVdYM
 k48ym5PkR55_gWe8PIeYXzD3bKIG9N5vMXHabYjB77qbkzMqbGYVeiZ8ivHqQwoxUxqD8yEZrKj7
 RTLOWfzT_fnKUny2RZxfrgsPp14gQ5g1PUHX30ZX2uLHV3EjSYXA9LJU_8Y0oR20SwW9R0gxfILP
 RUCEQZpQOqBy2VkTBjIY0sSdMZx_wnCB6ipSEnIRycG5YEnonkNc1kYjFYS3AXLbpz4HGoukWNaP
 JsZdJNk88Ni4_aRGNaW4RwYHx0.Wy1vTuSErCO78fMGdgKczZ.HOK9xMaCEFStemmA9ntYY0CDm3
 83ipZlbwSckiwRxLV6tTvez_NokkHIPfM3C.DGPhiOqKIrWVlLxCYENOM.Uaufa07c6TmKJfDc0Q
 cFB3b7UIYXPkIZdVVrUciOcPJjIOhAbRkeY3jze.Kmy5u9AukduC0xZ0W4lnUBdtvDlThyRLHyoj
 E60SmMZv.XdCGP2NwlTbBv1_eik1Mtw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Mar 2023 17:51:40 +0000
Received: by hermes--production-ne1-7688d778d7-pf58k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d524da5514d4ae1565de090f2be6d00;
          Tue, 07 Mar 2023 17:51:38 +0000 (UTC)
Message-ID: <dedc8ab7-1b85-de92-cfe3-85b30bec1cac@schaufler-ca.com>
Date:   Tue, 7 Mar 2023 09:51:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Content-Language: en-US
To:     Shervin Oloumi <enlightened@chromium.org>
Cc:     mic@digikod.net, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jeffxu@chromium.org, allenwebb@chromium.org, casey@schaufler-ca.com
References: <20230302185257.850681-1-enlightened@chromium.org>
 <e8cf7da9-77e4-e836-9107-db219a266158@schaufler-ca.com>
 <CAMb9sThf-ys4a+vmH=p5SKLixfhJtm8j3XX_4M004WvZheyRoA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAMb9sThf-ys4a+vmH=p5SKLixfhJtm8j3XX_4M004WvZheyRoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/6/2023 2:40 PM, Shervin Oloumi wrote:
>> Emphasis: DO NOT USE /proc/.../attr/current! Seriously!
>>
>> I made a huge mistake reusing current in Smack. If you want to
>> provide a Landlock attribute in /proc create a new one. Long term
>> we're trying to move to a syscall interface (patches in review).
>> But for the time being (and backports) a new name in attr is easy
>> enough to do and will avoid many headaches. Better yet, a subdirectory
>> in attr - /proc/.../attr/landlock - will avoid all sorts of issues.
> Thanks for flagging this. Creating a new directory and attribute name
> for this makes sense, but you can still only interact with process
> attributes of a single LSM on the system right? Just want to make sure
> my understanding is correct, because even when Landlock uses a
> different name and a new subdirectory for this, still the kernel only
> calls the hook function of the first LSM on the list (Landlock in our
> case). So reading proc/.../attr/current or any other attribute besides
> /proc/.../attr/landlock/some_attribute would result in EINVAL if
> Landlock was first on the CONFIG_LSM list.

That's true, but we've been able to move parts of the general stacking
process forward when there's a specific need for them. In this case we'd
need changes for security_[gs]etprocattr() that are already understood.

