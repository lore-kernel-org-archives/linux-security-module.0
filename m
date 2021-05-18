Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B288C433ED
	for <linux-security-module@archiver.kernel.org>; Tue, 18 May 2021 17:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10D260FD9
	for <linux-security-module@archiver.kernel.org>; Tue, 18 May 2021 17:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhERRmD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 May 2021 13:42:03 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:38096
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243707AbhERRmC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 May 2021 13:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621359644; bh=OaRaXZ/TyLu+rceOhMWTshaqetdfiL84Ys2DWla4GaE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=cHTfS16ouunxapRJtevME9XWI36OpoDesNx4owqyRVzDr5zO/XV147zh4mM9KUGB+IbiqsPq80svHsKVpnoi4QI+QE5/OIzY1DRzHP1YsIafFvyLawAqqDLiYdHq7H/07bGq8994kteeUd1QNAtxMEV/o9XRME81MpW6543QDfw/gLfr2/3F6HLnEEBUgfD6e6PLyYuZZxJ0InWP3AS0iUBqQf+JWY3wnf4802AGpePoFJ+5yJ71GMUsfh/fQpyiPq/WdUCg8MNzOMj/qo+gDXf2TsGvpi/KbymFnTX5DE5e2UihDZ9vZa5gWuT5mQMXMcDOlst3w+C8GNA+Od3AlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621359644; bh=6ETJSKxd/n3W0jylI8cVdKEYJ+mSomcdrAioFk+OZsc=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=KSSt12t9oPlrgbvqP8rtPOhnLVYIOE1s4dYCfzyRp77f/Q31DbNwDNPkGfcR2cE85a2oQVSvU4C2S6gxK7HYVlBJXMvOKOzlGpeeolJPqvvnJDA1X6fod9j5Fh2VcqRrWE5358tg3zBf2+DOsnoeGRLYiCA5SlV5kR9V5yI9XCd/ynrL+i5I4Y9VGkpghVybnnihmcCr7wuTvArEWjhubFe2AR9sEG9Nc6UD788rfs1ZvlhS1JrR/8kvHBPewji83hLyrgW8zRPBXcMBN4rrS+wcbjy0jrq/09PAnDN377KJUCV+G36+C0QaNFmeu4J7w7GBIQR5/uDUsZ/c+TRe/g==
X-YMail-OSG: aLknHFcVM1kcOHo.Zowg.xsmp0F64c26Q7QDTmFUHtxtedz5WPL_brFC_GTpGBm
 q2imlIui.k_R2.V.15gCJEZ2zrEB_Rm28YmahRkCIOLqxreLsxTW8jnb5Y2bR2GHjsELImC0Wanj
 Oeu4EAo3ewHG2WnfzTkqP9j19L22DZi.VPXiTTzzgY_FnaJn_TmtDNHtZR4s3hNNlkLRDKT2k24S
 z7vqI5KABqr2DKh9I6MuXFzrlEQBIEeZNqWfmE1H9AB7ctQLR3ni1JdfxbncB.wU2ly9J109wSd.
 BzBHGjgK1Ddu2IrewLM1fbky9cJ9ogNb8BnzX1NzEDh7KR.J_pHB.o7uKPcst8imb_Mym779Ljqu
 qHewhUdjU7iKG2pg4zmwnExPSCZZZu45uaqzGwXF_MDLwjrJKudvu0Wb9nQQNyDdziUd7NAe67bA
 5w2cpV8vwF8uc3hS2hqWx2fCMEfT8Eao9c27BiSGIJ5gnjxvV6cp6FFK6VB1pkln8qa2flAPbYBB
 OQYj4pKaebqLkWgqb37ekyjSYa6VYOIE4w5CiLxNaXFSvgN_d7d79qa7eX9ASIHpGUO_aMJlwVTh
 RuG4ChbfOJC_TYACvXSvrlLy2zuhD.3J44henbJykX9oBT.F9FWr4W5B0BhlSavTffyl1_nyhkJI
 IqaXP9xBNWwu9sVTxUxpzixzAdh6kHEPLugnf.hxCS9WpekgV4qmuK5OjMW1G7LilPyeTVKeh.PB
 ceQiBH3SV7N3JxQ_6klMq46PBhsW1fFBICQa7virIRfRXmiCZ7mEE0uCMBQLxCvG23qT2Vbgbg_t
 nEb6D9pFqW4yafC4z1QeEophQJ4xapC.tgRuAGBlhVuT8rszSobqwUAQCnlUML5pmSRdnXllIV4V
 59bNirWhZWlSX.yedOZcT7C2aikl6XuJLjZQm93pZ1qH0GJ4cZJ_GnmzVLMH7S1WK0cDZMkj5D22
 bNYx2yQPBbqR3t7tFn.ina8.ufq3Dtpe9FZdgFI1tpIcgvAW37mTgupHp0NrokWxZP17D4o3B9RP
 3FZBsRq4QMYipxCtIlJ0Q2LMc8Deirr4Yaz_f0els.5gj0Gp7ghANCmXqH4RrlPI38GIm.sbojVb
 EbIveV4hDWI4lDmIhckJ6v3Rjbng8gVUsRmZIWzg9bWjodjXvNagTE5Cv.ORtuF7end6_NdCohPR
 UKKq53kuU3e0jgkQRCwL42.WKHvTw5lMAVIm4aoAJz1SFPau74Zy1qX7ap0wxclcsMOmerZc.KL2
 xn2AyG668s1RZk7CfHvQHTB2dtm3v1OjO_hTtF3wzvAy4iZjjbNt0kqA_Iiw0a5MLClBezzgy5on
 odKpwlvgfj6q5KFVHQA.AosDYnV6MN8XKFfzxwdNd5OxDGOr5I6qIs_HjiOCF_jrSA7IxJJQ_apC
 qPssGg6aLS2iZKzfhO3i7xE8YNNKUYIbfpDKHnXlU3rKoqyC8kLfidPzXTKZm3idF_l2bDqjTc9N
 NZhYg3_zg2CXJBy2vApabji3GiFWiPPd1AYM4dEvBmt61jnGih2RFvo386asrO6X.7pXDBdPOHuv
 TWWYeHByhb0UR9QTbZSmMqbymZAy.mIEbq1bKAD_yN.yqwOf.vPvi9zZ58IqzjjejQGxbQTh.7mv
 ZPxuV8_XoUqyUalme1i4khl.l9P6dR5sx74W6YHWe_IvLCpmRJCsalMzjA76dAGNyt6S6AB.5eEi
 UCnTgbr5aUv42yX0rMX5CBgeJH4BhrhWeii3EI8ypgMZwL2x5.4LIJaIRCYMO9W2Bsu.ydO5ltYY
 b13CS.95VuZx_TX2n3Ea9Qa.zGYSZYZ8MRtM3mUveCcCpPDoqshWQjeFSIPV7Jd7Gb8c2rls3Ukx
 svrTP5z9AU5SYnzj1BwSHnu7G6kFY_O380ovi7Uhq7WyoxRj4x65sYdO1hrNKNWIORscf36cmP_y
 42weCKNuvGLqZtNsDK57R35hxRpeBnnk65UlyN6_PbowaFLrt3g15WuOE0tGAg1ByILGZxAFJksg
 RVte1TNLdf500nRA67WnZBcNpvIcBH7voyA6agZM3cRxyzxLneGVl2i7hOV5La01fHdouKIs9gl9
 5IOn81W6b9veAZhImxl99snaZHdT4oqqPR8VoZxRss5Kcj8pgGrRhOxEh0MQVonTZfmoBQ6Y1ePh
 BnjTLUcYpSUN0Ryu57xCX.wj0u7r9NvWHu1pYJMtZFQESpDTgeQBHE6i2RIlnYUPysmEqvvDznmo
 psZAz_W7x6xeUhNnHSEEugxaaTt.BQdZyrSJV5sCQflgLE9YCtVGOwzLckV.byK_W9PQWwGFmbdw
 QGgTQaAh33D_4UalbrGHeqlR0GTh_BvBaWQG2DXNl2PU5vjVE8sJSCmNMbY6R3GSwOGN2m8oPbSl
 vmXzi9RY91QWr_CXw7l4djV9WtGAVKKu8urKTKx9yd3oyQznzq9P2r8tl3LywprQa.2wN3DDKnEU
 VTaNNlP31LIPI9yj4zvmz5L3F8fqqXmQk0x4IpMt9kfO08Y3GFvqd5HIjDL_ayQw5nA4ZH6uQfIE
 dycvTrjj1bvhAyH3MCzUmXAL75j4nDIr0eb5rKZFj_YatwG39D6F_aeBa8.6G0nGvK516.UqiwQk
 7V_OS._.ieiO8wME.I0pm.nQZN9ak4WBIOgcOs9tQjq2cC9zGHjCb79Ju01sI5yPaNRTyexib_43
 GYR6obqEqO4cWhNahpCjxstDGCG8VkaVioluV.A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 May 2021 17:40:44 +0000
Received: by kubenode546.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6ed5589bd64c2f62052162e8342531d0;
          Tue, 18 May 2021 17:40:40 +0000 (UTC)
Subject: Re: [PATCH] Revert "Smack: Handle io_uring kernel thread privileges"
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <04c7c410-08e8-626a-795e-b77db6666804@kernel.dk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <89593a3e-96dc-f14c-0925-4b62872ca42e@schaufler-ca.com>
Date:   Tue, 18 May 2021 10:40:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <04c7c410-08e8-626a-795e-b77db6666804@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18291 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/25/2021 5:42 PM, Jens Axboe wrote:
> This reverts commit 942cb357ae7d9249088e3687ee6a00ed2745a0c7.
>
> The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
> need to special case them for credential checks.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I have added this to smack-next. Thank you.

> ---
>  security/smack/smack_access.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 7eabb448acab..efe2406a3960 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -688,10 +688,9 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
>  bool smack_privileged(int cap)
>  {
>  	/*
> -	 * Kernel threads may not have credentials we can use.
> -	 * The io_uring kernel threads do have reliable credentials.
> +	 * All kernel tasks are privileged
>  	 */
> -	if ((current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD)
> +	if (unlikely(current->flags & PF_KTHREAD))
>  		return true;
>  
>  	return smack_privileged_cred(cap, current_cred());
