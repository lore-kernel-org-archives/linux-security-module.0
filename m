Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E84EB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 00:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGGAdL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 20:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGGAdK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 20:33:10 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8F19A7
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jul 2023 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688689978; bh=AoigTnDqTdkANFhuk3JeQ10kKcfh4x16YvNNLaAQGEo=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=pQyrKTYCnYL2gv6NaUB3rU5UxEGQnviKRk1J8/zdSq4gpTJ5aMCOZc2zMaRSvUyQkG1x/Ix/vyVf1EO5SxLVTvTD6CIrbD0dA+8OB/CM48nqBU16Of16hzlTMS1BwyMe2qUEYdgXEzR0HnPzY1tlIQ9F39AtxYZWZ5jUyX0H/uknG9KrymtkAqeU0/t/5enkUfP1YCrhf3hb1HtI6vNuIC1RXf5F09uMTcDeLDRzel48H1XsNesfXECfaPbktq1p5eUTvHb0eEF4sM2DWz25ZXsCa0A5UZE1akGgcHVkNyHXFira1Zx3cn6O1AJvT6P1rWd4O55o6yzZiA2aRyV/DA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688689978; bh=Ec0Z43zy5rvUsLXttbZQv6c5x7dZmXMBIDb4Gl7lCRE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oze5NkKLm3GGoj09m5BNFsUEFwW14dslF4d1vesLKgwiGof6Azyl0iZ1l17Q6xjy2tNmkmfaKHvaH2V9DNm+1QksxeA/KIbMG8FSqRdkReApqa1VgP0KiwG+sSlbAe/mZbhhLzuAhf/ghFTiLztYowPxim5edchckpPLlYluapvK9V19ESRCm360lc4ZSZPN9DJOwi7829Op25E2YSjMj7x1rfegirY0dgpsQMiao/0nQW4bISo0A7ITc/Fh0lmpLE7zGMf6Ogp3lLknmYSZm9+oWWujbcv2+3ForrLRSYUq7WSB67WPK6IUcgih0YiZcORhK12nfv7mFqOl93AZzg==
X-YMail-OSG: wps_E2YVM1lR75DSmXOSBAekPMDGUsWjnrWeCVkq_XmBHVgAcO0IVaub6mJ_Ymo
 FsKoTyT2_BLRgk0PRCra5Ee0CQpv0fx1jBaS6aS.j28tGCP96hV7WDFkHUDAc8MeVE94DIo4KG8R
 M8u5yAJaVFzHAv1Dap7BgseErOzUHBCmVoi9DgP6MoNc0c1bGyVnA7MpDe6PzI6Rdh0cN6Nehrtm
 .cRcDW3pyYMwzmYNqxpu7VUpO3FVHprSZuI2YSBN.DPAYUjG6yj6yVvlA6VRIvrbXRvG6p6_KEIu
 p3aDo.CJTPcaDjHyuZqk2OIUtG.ecDGp42VYeyntw0k6uD8E6pc080YGo6WKNuylZ6NH9wbFxleD
 cVRyQCjIXWqC1THB2Tnr0VUhxiaXW4IUaYd1vJaCGKrpCPE3VbsAzdL_Z_wNWokwPBh.rbPEIHeF
 _tceRsayPuHOMzV72T.ucfNH5WfwsSoPyeQtSlKqKQxeK19sLn5_fFzS3xSMShU2NUtrvTYe_Pyx
 .z3k4Zs7b00pWFc2iZsOqa75cEcGE1p7knBiSv0fjg8WVtEykWrXQwmUbK9.cu9i3tFtQpBlLEw3
 3jqRs0jkOgVStkFPmtJpySCAIRX2Trva9XAV67IWR3GbN7LJ1R3pHYphGLYFxyh7_npEtTwJgJT.
 6SHgZZL2YzmzXZs.vQQOmyFZlU2Zh21bzmBCqNEq5gJi6zUGQDUi8Oq6Vrs7B1KYpA67xox725aq
 bOZQV7aMSuZqr0LN_HjuQTAJa4lDhLhOa_32cTT22_TI3lDtX893JSKloSX3e1v0ZWaVYcHHjvgN
 F0x6uBEq0HbAcRY3rvB0Q.RD3vCiVbuBqZ4UuGOTTim578erkXnXV3IYAP8sHfMq568PJqTT24VL
 OLrLqYGIRNaRpkI53sZiIwgh.yU0ugiqVdC5kPVjBUybtp0hmAAUEhKUuQkcHAjjcn415H5s_nTP
 ViSqyNZuTOsOm0yXW3JdONuKPVos7Zu8nTar5tP0qY8iOUq5l72AqBd8Lx0tMNEUJUB.SrIDjXg5
 xScZMi04BlhRzVqfWEbFjeWE2ceHU57cO2bBiyXLtjB2BAUtok_67IYg7DrB_j1p36.ls0ERX9DS
 3nEh_flh3JSh0qPUkBBQwKiO2f.RHfJVOgA6z1Wg7dfYSuw4v5WdJAGgS_F8rsPIalfcwZgDe5v9
 MWf2n6R6vowlrtBMIAS.L2mxoM0N0wZ3js_I0i2Ki31ZFF9ATPwvZBt5SKSaAH2opq6.iE1zudxq
 ZnUvxhXuVw6FkM836gMa5XDMFvTbZ_srhg9g1_WIfu6UyQ9OI9ITjpEh8hRPPFHW0XA3d8KMThDx
 CP6QDo4uM3WfaGqJt0Z.U0sQpre9wCDaoOGqZYSAO55piaU.J_KSe3EGPrcyJ0gx25G.0OY2_wui
 50H.hK_v7BFy3qGz_pxHiIPqOVwX6rZmLTFuSRUF6CBOHMoFpGTKGEh7PN13Al8ii7XmU.1hNQdO
 YkQz91SDh37XfSuh.EvwzJvIYrv.sgo4ussoHQi7yXHmyijAHUGf3mZ.CfPIPIv6Q3IZtZh26yby
 r6tnIuiiFiYHzFLq_CzdULMYzgXokFJQ0bYZlcKhWSerHxHqe.r0AZPTlqZueetpEMVieUu4BTE5
 .FydguQz8DrS5XERCEm5f9Bb2xSPkkLc9P1Gk4eVBITJbO8Wwe3SXhfTpG7A3mamYaMI99q6TJ4r
 pcZbBmmyDsyLXhaq4RFhHcjwbKeJYZmKguD3KikscGXfInTCoA0lfS9UpSPUGv01xalv7WhISTpk
 UyGNpxFh3geKYHLDKJwfecWVZDmoRLD1rHq8tOkMOAXqNjFskXYBgPx_dzaM__JUB3Lk5q.WaiFT
 hmE4EkmPKa6cobEhmYnO9GdITOEBsn8x5fssgmUX6KELnGWzzv.3ywL0205f3ltXlaA4H_HXE49E
 .Cl.uvgjrlUN0ez0KNAkYeKtPZVbGX_1nYjTy3qhlxI7vZD60t_h3D_C5G3D5oocfCCChsmZT0Mx
 bgIvGRQGbkqRvDQr1ZgjvavuF.EWMK0G88PymnYuyLsyRPKgAo2kR_krX0WUzoHOF4w7EnZ3.MxO
 OTKENGwmX.5JcJKJYPiaHiwflwLP7uTHrX0wcNWvfjzHzPJ2w3QqeJuIU0uMpPvtn782aebY5dvQ
 uCM7yAhSZIaajFqEP8XuW0RmliJDc0Hh2ldOlgpTIvPl194wTOQ1ZEkd9kg9VyZqbyBwIfBiNlAq
 Mg8m3QsHMYkQSOXps__OHg73bsRHPdW2L4PZuN7F0dWJst2R8j.kSJ8fGexqflQnfG8ddEhhxmgI
 4cg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ea3dc297-6664-4097-bb54-c79383416209
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Jul 2023 00:32:58 +0000
Received: by hermes--production-bf1-5d96b4b9f-jv67c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b4754891e418cf17f52f682070c34013;
          Fri, 07 Jul 2023 00:32:56 +0000 (UTC)
Message-ID: <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
Date:   Thu, 6 Jul 2023 17:32:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21638 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/6/2023 1:42 PM, Paul Moore wrote:
> Hello all,
>
> With some renewed interest in submitting new LSMs including in the
> upstream Linux Kernel I thought it might be a good idea to document
> some of our longstanding guidelines around submitting new LSMs.  I'm
> posting this mostly as a FYI for those who are working on new LSM
> submissions, but also to solicit feedback from everyone on the list
> regarding what we should ask of new LSMs.  If you think I'm missing
> something important, or believe I've added an unfair requirement,
> please let me know.
>
> I've added the guidelines to the README.md at the top of the LSM tree,
> but to make life easier for those reviewing the guidelines I'm
> copy-n-pasting them below:
>
> * New LSMs must include documentation providing a clear explanation of
> the LSM's requirements, goals, and expected uses. The documentation
> does not need to rise to the level of a formal security model, but it
> must be considered "reasonable" by the LSM community as a whole.
>
> * Any user visible interfaces provided by the LSM must be well
> documented. It is important to remember the user visible APIs are
> considered to be "forever APIs" by the Linux Kernel community; do not
> add an API that cannot be supported for the next 20+ years.
>
> * Any userspace tools or patches created in support of the LSM must be
> publicly available, with a public git repository preferable over a
> tarball snapshot.
>
> * The LSM implementation must follow general Linux Kernel coding
> practices, faithfully implement the security model and APIs described
> in the documentation, and be free of any known defects at the time of
> submission.

Some commitment to maintaining the LSM for a reasonable time must be
provided. Although this should probably be implicit in the use cases
and goals, changes in product direction or employment status can leave
an LSM orphaned before its time.

New LSM hooks introduced need to be generically usable. Use of LSM
specific data should be avoided. The hook should include data at a
granularity that can accommodate the existing LSMs as well as the
new one. The data granularity must be appropriate for the sub-system
from which it is called.

>
> The entire README.md file, including the guidelines above, can also be
> viewed in your browser at the link below:
>
> * https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>
