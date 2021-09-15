Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BDAC433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Sep 2021 22:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7F761178
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Sep 2021 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhIOWOW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Sep 2021 18:14:22 -0400
Received: from sonic313-22.consmr.mail.bf2.yahoo.com ([74.6.133.196]:46140
        "EHLO sonic313-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhIOWOW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Sep 2021 18:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631743982; bh=iL0ogtABgO5oNSBLc+GgdEAUeIcigQxmlq4Qs4c5FTk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=S/kj2Cx5EcR9BwyptxvoHwh8/RAU04UeQw5ven0E2wq4LoHyAJ5QyU1FQGJ9v+syEn5oa6VctRDzCvT9HiuMmtRlTM0HZVGtlG3yUIhWmu/QOZdaO/OE0xXvo2hGTicnwCCTVr6vc7p6Pn+lOEkaZYi3Tr5KgGHVPhuXCPZkbsYAfv2dlE4WY4TFIQG79o7oHScbM/B1vHB6Gt40LIcbzIXfwFLoeT3cNZ+jj/oxKq30HRbd6GS5+2kfz3m9SMY2IUuQ8+voaGmWT/9+1Psx+WFDhNEGg+ZtfXvHMINtRga0roDiugByEHDXVyeti61uX9NiyoUD08Q2qdrPbURHOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631743982; bh=JK4MqExRh+PJWVRPOYv6G+P+K4PqB3Gu/yTCCFJsWdh=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=orJXqm9qcZlCSh/NosMq+jUpphvPHhoBnrC7r0z0gNCr7wRh7z3omfascW36zSKbYx2lu7TvAmPFknB4nSVdTkYamivXs6T56wptNJZmLHlR8VI8hiux+t4rv8lsYGU0L4Ay6ox2Ol2q7y1oFVT3anz+vvOOAMQahtVNZRnxVCNdwwlQWbweDJwH0CFBwt8DXa+otXl9woECIXqj47ODDAF93JkNssw64aZPwt2Jvm2S18h5BrMptVfqDw7CgwQ/gvPFHwd1pz+A2pRQ5yzv44oY2T74JjjYReJwUkeDeKHIUSnmP7uGMC4UT3stopmuN4ErjhXD1HaGo4oHzW+8cQ==
X-YMail-OSG: tuYRgg8VM1lHsl0K6ixbTSBAhF66dc99JiFHhIz7EvTSarjxerKB18W9i_tFJkr
 DAPjHvBMbZghYRLK_hlvSRx19Az6J.K_m1Hjz3ZoqekknuyzS.P3YXQ4d_6Aw9jesrtHSTz4xdqO
 SUERe84yCxgU9vqja56KZLWCeLAHI3VhVdAPAh0KY9e4ArMNKJVhtXqBaG_f.NJaId3Pmsk.wbTl
 OuWah95gF0.YmsaSdi71xrH.0QoCvUiEtp0sO69NKJbueAe4jCNpdfym47nOzz9sNshGE7bQbU7p
 Xl3nAiCUvt6fC4fkELkB0XhyeoqCqI2qDFkMtsWlRK7isL6NLplCIfrji00Dj0u5GywA08DMVQpv
 2qJgaaW9uN490Md8kG1yv7FH2zGcLvOtORXwGlbefMBd0rP5KHWVUFGRQGizHsGoj57O_BtjdG.Q
 6Xp0Oj1eLXgdyFUVPkigaKdBc80NhUhWDycRsdRIw_mnqtVC_oZjFWzY4zY_fJFb9y83q2Ywks7V
 F7NYmJ3kCqyUgp14tzRyHn.fcfZfxS82I.EZbjm7ANFG406wUPzwyChRi9QC0K0Iro.7a8ECLVdS
 7NENpRLL17Lj5ZUTMvhrBEPgu9GrByKrGuT9c7qeFC0k7AZtW8qb2FblSr6rdrpI9YYRDWhnI6bZ
 FzuEwao7nqBvbmpJJjdkBYWOeC9vUyEgRo7umBp5Gn9GeeCMmoNl9TGe8KERT23Jll2seqshwjAr
 lRKLYekAoNgUGjXLDw5l9PMgtp8XqkCXemU8UEpja095YhJOp45.cCiYOfCkUPqSU6voNRkLQC3d
 RTYgHfP.2W6nxmPqcAcMFJ6EC_uFV1bkaJ2zIAJTdINdLQ.YxZhdpWiQr0TPZRM9_azAW7MSlZgB
 J80Mx_LQJ1y_4_hi2AVDrRUN32knehjr04WAI2T3wKBgQFa3KLqknateQCplDLufmsP7ViCrwSvO
 MWvi_kvAl1uMjBtfKkDD6FEZTYO.HQc9sOXIJ2fn8r07xAuPnkY22C2yJj0YQF44pKq.n0Ih1W42
 uRhEUjLWYdzNfSs1lqysiiwCS.NIJ4rOxPuVMLc7sjSKp5yQ6b9Ibe_4f4J8Kgf4OdhTDW5o0tzm
 Q0CDznLMJ9AAhnGvwGPgCZWF45gi3g9LUWMOrbTFMj3b18LPsEAUxIuCOu4YRfapx4zP8pqWFfsF
 5InRvmsSL9gkxQti6NIrzIX2s177caNobQWQFbtYsvBZImF_VnxDchg2zsRq04xyAmsnP0QQQvYo
 aukAh8aEbkn65I41nmGFVfEra6wSY9YDdU9J6D4rXw3y2W7WcLX2NH2rPt7XNMbRE85f1c8LkE9w
 AqFUYL77dlKALsfSfwwy5eZiLc3RoANEJSxOqTLqPEB_ehZDER13XJRHdY__nVcQ2dA89njBxBNe
 UkDHlvjPOYr90vcDzX7ENFXDtuG696ZcARcmNkdcX_gC1lQONLb8.3ZnhawGV.VOAJKY4oezT1Mr
 IpyfPglfXeaoXynU4dlqMZXZHKhsOaCTvx.CtVYcNmXn3Q655.gm4F71kcrDpTGE2dV6dOUn92YY
 Xqt4OWUS110epy_iQ1n5iMF_q3HiHvmFaBvV2HHbwaij3UIQ3oa01DHIYY.G0nVPlcyZQLPoSURR
 qYTcMbvNXxu3dnsKJFRMJ7UweUtKt6ckNMtsnjRwUoRQYthnc61c4Aq1P_9o8Xi8147SUqKOOpiX
 N_xV._BI.eV_1ZXSkifLmlWaU_8rIKKeZeUxaXq.EP8L9_a2G1v9QQ0RGiS6hmPLRDj9o8m5Qp2c
 d9gIex1s7XlyiRJDgVfPM_xlHmqex.0IQuEABLW86fUlm_YS8j9o7MITY8Q9BKo2Lbodm7GtivrW
 Frt.8vV6.MuaWTfnIFJWP9UbCdnUiku3IrBF22lx8SI9_gOAQFwjEj_anWUdCT7aUyXu9J5QljjZ
 duv3DpxCTo_CLY0EqYfsd_iGDUto1skUhDdM4aH6zvFX2TNSTH3AcjFuHXi8ge4XlfgNaRHvPd61
 N3iJ5ReEByRY1CppMvdGoPYWwjMV97YC6ZNzwshPoi7ec9guo_EkXmhf_wvHKLXcwPWpiqr8NwKW
 Ll1x_ChaueoNDwY9RrDTedOXNM1I.Ck1_ZwSwF9VEoT11pe7egfWS.3NUcfMNDVWZ59R_7ONA2R.
 0Dde2WkHgEutcgQd3Vrwe0BbEoqt6io_Yt6X3x_yYvFN6nHDj4t1jRwInBnJoYPkNUmLVoCbqX_z
 HtMFm.n8_dxX1smToNQI1eRlQUtQ5s9k.QpkWO76MOKAj_MMX1TKTcMcU0P6kKZwQTQMUdBXSdt1
 BtNsy1XHQ_A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 15 Sep 2021 22:13:02 +0000
Received: by kubenode517.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e742603612be60ce41c54e7e4112e0ff;
          Wed, 15 Sep 2021 22:13:00 +0000 (UTC)
Subject: Re: [PATCH] smack: Guard smack_ipv6_lock definition within a
 SMACK_IPV6_PORT_LABELING block
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-security-module@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210910094544.3430125-1-bigeasy@linutronix.de>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <dd60e060-7b88-c742-125f-5b560e2bd1c9@schaufler-ca.com>
Date:   Wed, 15 Sep 2021 15:12:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910094544.3430125-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/10/2021 2:45 AM, Sebastian Andrzej Siewior wrote:
> The mutex smack_ipv6_lock is only used with the SMACK_IPV6_PORT_LABELIN=
G
> block but its definition is outside of the block. This leads to a
> defined-but-not-used warning on PREEMPT_RT.
>
> Moving smack_ipv6_lock down to the block where it is used where it used=

> raises the question why is smk_ipv6_port_list read if nothing is added
> to it.
> Turns out, only smk_ipv6_port_check() is using it outside of an ifdef
> SMACK_IPV6_PORT_LABELING block. However two of three caller invoke
> smk_ipv6_port_check() from a ifdef block and only one is using
> __is_defined() macro which requires the function and smk_ipv6_port_list=

> to be around.
>
> Put the lock and list inside an ifdef SMACK_IPV6_PORT_LABELING block to=

> avoid the warning regarding unused mutex. Extend the ifdef-block to als=
o
> cover smk_ipv6_port_check(). Make smack_socket_connect() use ifdef
> instead of __is_defined() to avoid complains about missing function.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>

This is the Smack maintainer, to whom you should send the next revision.

> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  security/smack/smack_lsm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cacbe75185194..fd9e6b54907ee 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -51,8 +51,10 @@
>  #define SMK_RECEIVING	1
>  #define SMK_SENDING	2
> =20
> +#ifdef SMACK_IPV6_PORT_LABELING
>  static DEFINE_MUTEX(smack_ipv6_lock);
>  static LIST_HEAD(smk_ipv6_port_list);
> +#endif
>  struct kmem_cache *smack_rule_cache;
>  int smack_enabled __initdata;
> =20
> @@ -2603,7 +2605,6 @@ static void smk_ipv6_port_label(struct socket *so=
ck, struct sockaddr *address)
>  	mutex_unlock(&smack_ipv6_lock);
>  	return;
>  }
> -#endif
> =20
>  /**
>   * smk_ipv6_port_check - check Smack port access
> @@ -2666,6 +2667,7 @@ static int smk_ipv6_port_check(struct sock *sk, s=
truct sockaddr_in6 *address,
> =20
>  	return smk_ipv6_check(skp, object, address, act);
>  }
> +#endif
> =20
>  /**
>   * smack_inode_setsecurity - set smack xattrs
> @@ -2852,8 +2854,9 @@ static int smack_socket_connect(struct socket *so=
ck, struct sockaddr *sap,
>  			rc =3D smk_ipv6_check(ssp->smk_out, rsp, sip,
>  					    SMK_CONNECTING);
>  		}
> -		if (__is_defined(SMACK_IPV6_PORT_LABELING))
> +#ifdef SMACK_IPV6_PORT_LABELING
>  			rc =3D smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
> +#endif

Fix the indentation.

Also, the patch came through with some html artifacts. Please fix the
indentation and resubmit. Thank you.

> =20
>  		return rc;
>  	}

