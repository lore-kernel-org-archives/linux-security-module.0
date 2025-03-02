Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785E3594F
	for <linux-security-module@vger.kernel.org>; Sun,  2 Mar 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935036; cv=none; b=gep5jR+OH234CZchmr7obrn5m9NiVkAg5SZeFcx+pq51walKPjV9ERv3DIF06+XtK8dR1JzSp8DUtDZs4nVvINEuypQwbP6vdbto0vb+V0sAqhvrghPoSM+Vimak+dSJdev7O6mH64NxF4wAx90lsqwFmFY/IH2/syIVxIAJy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935036; c=relaxed/simple;
	bh=Jr9R8vIzdNfnl+63+7Tld7PHUSKbPDcWlZRyvrPyR/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCJLlfAC9HWCKV94C/7BK6D6WrvCBMwGM7uqPPqVDqTkyXDJ1U1sTSNhsJ+Kl+W0uSQDky9PJGUnRCkMGVS3fyo6WmsZPh6L3nhT1P3Lnpggp4VIlvubJ5QeOyKvvtjn9dSL18TZOsVG3MlwRjbe+dVPZgYhck9dUun5+POBxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TX2P197F; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TX2P197F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740935032; bh=Lra0vUwN1K4kba2+U3+GskifVMgR2zgvSIvCEe7aAto=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TX2P197Fvz+7VaJkUJEl8jkPvhe+QtaLMZYG0Gt7gno1uc7OO4WwJ7w03X8mt5Yh4La3QUxwv2qOSOEdkke4G5uIzdu4Qd3dVHyVzBxHQBtQt4NOqiLr91G60s0bBg4rXkbsyBnA7NA4GwgrBPjQK1VpPOWPKwVAmafBgGvMDf1u086xD64jIzUGzQT32+gdTImwaPe2k66s6y4HV/QFtY1JrBps96vc+rtj9gf/uGLgk2hNfTCYrLCz+vE7t+htHH5pz86WtTCD1dgsK5DCV2ZwnxcnCqK1W49zmy8WAeKoK6/JyMXyep2qkjLURKrwSPiNA+pMQhfG4ZWjgMpqew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740935032; bh=zo65IzgKukXXbqiXXKTPWPT9ND9QQ+G7vFPhoJy9+a9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ECWEHq64hBWDlWx1NeOVwZQu58ZxDatEifmExI0KyPJ40txbmloqg0DjrxFRKWXNNe17yWQjhBJG+DGNJhUc+vfmFP7jv6cjCt1c5ieX5ExM7nYWBV9eH6/XML3OhCQrkDbvqbZlikJY7N4NbegYt8aHGclzYUVlEYmKOVqtf2gkJOa9gmENelCHvfa53pZwr67bzisq38gNjVhDazUx7295Wu5HFm3v9zpr9BK1TN0HdzJ0M/Wi67t6p8DnY5kRVrFn+KtdVb/enJxzNyDezXpQFllSogbm3qU/JroA30rQjJrxdtfzFExyrOLqeZZHzmAJ5RoiVD+Qeh73vZVMxg==
X-YMail-OSG: wv88pfkVM1njmcOBhx7tsi13s8FX9bSGHrTdzXuW9d5Ytl4LUgPOXIn3ptgiYD8
 pqeg7fI6FRp.KjL0VsEnb6U1Nq8viH2wkEORY_DTxvTBF8l_YZ2LYU3IZbDn_n5uYBtatAzXNf1U
 fwAQmVwrbX7THPBR3n6Rk7eIq7FMCpWiQDsyGnsG7j7yfw1iQgZGONsOG3SYDGLK6wjCSeC5mSbJ
 vwf2eNCeY5zvRhpsKjvAfxV7x.xaGw7s377mhDsHTnDWawKUx7JGXRyYQOIw6SkkexziT3qtlI9b
 AlWIR9xI5_IaQNxXjfh.rLWJrCFr28AN5dWktIxJAyHj1Lj2q97Y4177BA28Vh55ljWvzCS5Hnf2
 yIE275tgqoxssSeHfXTtmqnL_Aj4MWGOjVbGjrUqPPXOPYJ4jlnrJd2D3lO6cinJEx0k8ewF1IBv
 z3d8GE.KOs5iyeMjpQolTZObMrZMErJdusFPWUd7vQhvhgfRvXqzN9EVndlavLow3FQ.WdWQDlPX
 Dp6klnQJlDPMUTD7NxaqINsZoweyKX5a7mFfB7dpMbtxglhkPb1qH9_mMm8RKbf2bI5bbyUprP.u
 cNIAQQQyAdsWR9l6m38SOSbChB6MxyPPyW.XgGeB4L7jX2TushxpffsP8IcD9u_5gX6yK.UEUBG2
 uGap1iO3kDnkjynKxHMD.yxuvAf_eRHaVGT11gsl2fVLDAMUo925V44hNvSaOi9R6P2CenEC8mnl
 nqH4soY1p9G9PQxndqK8MYmWNY7Dk4mMYPTlLKufOI_88_yTeNiMMPmpmfRBGthYAltijl2uGw46
 clR7c3g0TKWWC5E4KVW62nJu2wQyJTZr0nQFPwQCShv_ZQ20LfXRIBcrrew6g_n2ljv1HBCTuXX.
 aWhhgh_tsGnN5QaCpRc56Q4lqZqKc60h__QZvQ5NNPP52SfDkRQDAEhQAt94tuCy3y9eBTrAlD2U
 DQjn.F1OkPvFjSh9UFUivliA9.ZF.lq4glNlvpOrsAvbHSioSJ3ZNB7lmhfaClrK0p.7UKMHjHqC
 1aBMKP4sJy7x4UDHyWRnXQ3e98rShGoulLKlFKU4TF2sGLcKEyMr3btXkOvdsVVddvrdsyTGkd2X
 R9Nq42EnCgZ.HhiKJrI7YOhxFktAHgXVB1e6mkLbiapFcwVC0tvUqcIJji5a5NteqlcgVFx_LF4E
 6kRe6kv0PCkSXwF6SZB66tUdu.TThECekzP6Pri2gKoCeqFqg8x9G8lPAjwVxdm4MripQ9atJphv
 qpkf1MIJiWpS4lTnU7Z.23uAr1HcwbRpaLwuVtnf7qV0X0RqtAURXF8T7sXGYiXW7GFvBJh4q1F0
 df8juOfxsIxAHjLr9GHwvJ0gnSWKVXomWcCdLp1d.I.8SbaowxHHTWmf9TEwCKkjwzAa7_dcLPZs
 CRdVYHfWT1chRC9J3JTPqThg0_R827i4uBY_FFjy0qf.dVTsn4IEKNTEGvW.GkW2mXrv_ahGFaKp
 cLYr2TAllGe.319oMToJIZTy_2Iks4zrPiLMm2atfwR3.xJUPZIv9fWGCh_K9I__a7fOvtYaXl7v
 OiQS0Z9tcgB0R6VGAORHminYObCI1WAOMhUx0XNKEWLpavxjLsRN6pHggA3c1EOsaAn1WoUXe04e
 Ii7bOJ.5Wze5jpNrYTNDDy0J3fbbFQzJhuAJR7RPFURmPmBd032J7HIuzAtpYqD71xp5EoCzoWTq
 cXreqOT7fUGlBf0SdHefABcLsqkYn1fhcO0Q0XCYAbo5wumQcKJs4.8FWEamHPUAPmCB5tul_d98
 ks0qI.lO6WZHjZ3HdbZrUtioQmiki5MP3LbO2fefHU1nt2QQAlRSIJeFDYD3zUoR8XqKcnC0PMAp
 bWLHWNrx2KmZSZ0sFGkpp2RLKmbjp.Iu6OAe1hOgVzvoDWkLQoNSkOdbMmYdUawRID6ZIzG_fcoT
 F.wJjVAcweiL0wrJBWdvxw5sXzppbIbxFARg0xRaKvnkOYX.s98XvzMmrAYXkvQCg3DI9O02xe5d
 pIEvPV7VAa5IapvVb_vkx0B.u1EMegSTbdCR6YBqNnQ6CIu2zKD6uJzxHAmUznphqp.hUHEBV.AA
 azu8pBmi6Xl97L54ozTRZpk30uvkRMnJ__al_wzyERfbUjBsYE2srryjNYRtEBZWK21dV_Y_hW8w
 xIEdI8NyaOfoJXLyrdlYbHTRYpkO8DcacD3giXNxKAzdwatjwe5CJqlKtTFvcCnOty5UMdrpgqsF
 eJutUMIPekgJzyzmgPCIzEr4PoMqgsrJPhfz9dmaJv7gDNvBTzn7GV9bpGdg8ZZZILLyl7mU3xAw
 7KcU1MrKmyg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2b07aca3-e99e-418f-8d19-36a7f689996d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Mar 2025 17:03:52 +0000
Received: by hermes--production-gq1-75cc957d6c-7gjr6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 69b926c9c32d591f2598364d1898b010;
          Sun, 02 Mar 2025 16:53:41 +0000 (UTC)
Message-ID: <6f74f18f-ba64-4372-8307-efba97c03bf2@schaufler-ca.com>
Date: Sun, 2 Mar 2025 08:53:41 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] coccinelle: Add script to reorder capable()
 calls
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 cocci@inria.fr, Casey Schaufler <casey@schaufler-ca.com>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-11-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250302160657.127253-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/2/2025 8:06 AM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.

What steps are you taking to ensure that these changes do not
negatively impact LSMs other than SELinux? At a glance, I don't
see that there is likely to be a problem. I do see a possibility
that changes in error returns could break test suites and, more
importantly, applications that are careful about using privileged
operations.

>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  MAINTAINERS                                |  1 +
>  scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 scripts/coccinelle/api/capable_order.cocci
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0..b1d1c801765b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5196,6 +5196,7 @@ F:	include/linux/capability.h
>  F:	include/trace/events/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
> +F:	scripts/coccinelle/api/capable_order.cocci
>  F:	security/commoncap.c
>  
>  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
> new file mode 100644
> index 000000000000..4150d91b0f33
> --- /dev/null
> +++ b/scripts/coccinelle/api/capable_order.cocci
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Checks for capable() calls of the left side of a binary expression.
> +/// Reordering might avoid needless checks, LSM log messages, and more
> +/// restrictive LSM security policies (e.g. SELinux).
> +/// Can report false positives if the righthand side contains a nested
> +/// capability check or has side effects.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2024 Christian Göttsche.
> +// Options: --no-includes --include-headers
> +// Keywords: capable, ns_capable, sockopt_ns_capable
> +//
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  Pattern to ignore
> +//----------------------------------------------------------
> +
> +@ignore@
> +identifier F1 = { capable, ns_capable, sockopt_ns_capable };
> +identifier F2 = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E;
> +position p;
> +@@
> +
> +(
> +F1@p(...) op F2(...)
> +|
> +E op1 F1@p(...) op2 F2(...)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@ depends on patch@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E,E1,E2;
> +expression list EL;
> +position p != ignore.p;
> +@@
> +
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E, E1, E2;
> +position p != ignore.p;
> +@@
> +
> +(
> +*  F@p(...) op E
> +|
> +*  E1 op1 F@p(...) op2 E2
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------
> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for capable reordering",p)
> +
> +
> +//----------------------------------------------------------
> +//  For report mode
> +//----------------------------------------------------------
> +
> +@script:python depends on report@
> +p << r1.p;
> +@@
> +
> +msg = "WARNING opportunity for capable reordering"
> +coccilib.report.print_report(p[0], msg)
