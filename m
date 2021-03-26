Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0DEC433C1
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Mar 2021 16:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE19F61A24
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Mar 2021 16:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCZQAq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:00:46 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:35193
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230266AbhCZQAh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Mar 2021 12:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616774437; bh=IVLVSFDtfiMtrawZ4X0NmMkk52h1rLo5ZKdjIylldUE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=UejHDHISFTJ+SmorafMHUDG5YbKhLqN0fNOshNGlJXDAjcOo+JRTXXYPyF0WaHqRFX33e8G1v7SD13XLV9Dq2SKcnFTAjPKyea7J/rRGeqnXTHtMWgJK3MwcWFTnOrvyR3uv4Rb0ttqp5Z96Sp2BqfgBbUQvx1m5X6WwTPKDqQcOJLxWqk6x1GTQ/3sOMuni6noZ21n7zRgAmnce8mPzLCtU1/PZflpR84n6Fpn/cwBp+PvINIvbJQi6EZjcGYtLEaSfWuHo8Mw4fLL92UYg6udlVorS7TAqpcR87Z3hAdFbN+g85ghBHXg8FBr9CkZF4eGo47AcDjaCCAdj957b9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616774437; bh=Y6uta27THN7z+s9quY8CEzCFCW6aJqplcl95aZTXZyo=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=KHTWrXmKN/wpXNNfDgsuPDdVCThJ4J1ou0l9V01IlVGsej23/JsT6fZJKZPWWgwHSFmEHOe2D1e5TKgmzeKab6a5+4pX7mTGmi6M4r/Rh7LKgXfkSDXHYSUNKdnQB4/ejcYVQT4kMF+m4y1ZIFTWd+QxI/wP+ATy5JsBLC3cmmncIl+9ol82+iqgrV/io0HtEHMqeNUIJLlp6RMGbKwF+TkTpvM6x0U193/Xsh4YxNB4z6uDTsOHnA4I3/yKHuNwScEWuEadcJKd5397//9TioWno8KmJ+HMPnd3Rzlq6gddrElRjf8BT/LsOONGH3hfduf05L1qGsNyFUAOj19KPQ==
X-YMail-OSG: EuYAdJAVM1mhLoyXmeOHPzPk5BtkcaO6WFWeguV2sO7_wr3Z0o8yEw9MRkt1.6f
 qVy2V3KO.OcXMsb4sNE0fg7Do8P96HiE5rS61o886pkOtDoVLlfcrmud1ftox.5.2c6OrCW61G3l
 xrm2uAKS.M0jtew009jHjsbpI6vKnQ0uWmo6fF3BBd8McVkqNaUzAxbP3SkFngytHuU6RlF.iaFg
 V.tkLM1m.Xm4rlVnKutkWJKQdqqFWoiKv6qgfnj5EAYzEmKmkW9J_iG7ftlNE87xBDb5PMACs8lJ
 myljgGp1ZrMdW0Tdy4_liEVZHmt5nttQr0myr27Y85CTps2rYKdZvEB6QJ5nVG8Iq3i4_LWU4SpD
 efP6SX2R.FA2uWKFTHgbyx4TFBhAOQfUyMO_4PBD.LkOxlV.EuaQXBdAAdjvA0k.stA1Z8.Jr5BI
 CZOLdsL1mQwx4cAIlUgkGxT1GKRtIp4fC_Gh0_4SmncBVqjZ4aTXmLaG3j7hh1wOYufPKdh82w1r
 iuBIpofWCk_CON9XSCxxscxkRDOesuIWO5FNEqEL.N4.rYiySPs7DdpGZkRrybJT7_n.04AtvRU.
 XFkCoyh2q.cBy.dYOig_80K7Mx4KNiuF0o7EkysKBu5C8No64SCUTThR6Q3pKDv9n3Ej46n0rKfc
 jV36cm97uBzRBS2XIpUV4_zjlt8GXTqlz9PSJG0EdceAwu3rlOcycsCkFMNWw_I4BtPlQieuC2jl
 YeDs3vZldXaJnliG.7lhhuVZi1FyKkLmLYk9XBxXwBF6vdCEY3VDDN.Irrv7hqRkjtmOBQNaTStU
 rlgPyTytUM_YW3radNnxHcJ_EH5Nq8FzAFXJngDWom2FoCG7IX4agURgP7bg7FY93iCw.P8NvUCV
 aBwUezVGLAQxyztjkvtk4iXvaU.BU6tB_oRqsIDgtcO9fwZ9xdVR38i2e5bbS29e4kQVvrJPJ2RE
 tdMIRbLJeBJFiyfVqBxSw_HtS2XGOUYZBgqcPuAjp6mXkDawfj6FEQ4nKtTjk4GiJ_H39mD9ciW5
 7OytpB7VqHsKOk7MqW2yFoMOhQT4Ty6PdI55QUuokUfl_jqr8a4LgRf.MdBVeeg7P7lms2ere0Ke
 kLq65t_1gMTj_3tSJM3r7L0K4UJyuIJjemMwtk7aCvJ2QQfbzTpVFtD1u4XEh4MFvB6kF1fQ2zwF
 7eGwP4LzxHvPTLFeJrK6SuODY4IVe94VHu.NedUFcZCNrEnvxSwnPlqheMKLZno0G8rp126yfCIi
 Qbl6.zWX5JToD3XKYc.UJpgcnGJQxpFHADMS2SgDv2yDGv_K69XV1.BrVVhycCuxlObYJEoHMJRa
 D25MgW_ffSVUULClcRLe3kHYNehlvBNvBnqsTeWPQTC4TDfp58kxdBF8KJX56igk14p2AnrO7972
 8wTn_ZW04oqJkv4O9RAk8jzUXkM5dvVQfU7L8_FA2UvtFkL4I1XHZcnIwXlsPakrfpSgCiCFr7Ux
 i3bKqVVf4MFYeTp_ZXjkH0V8C3S6yaphSVGJJA9rnyvhNMSuxfkGIXJ_7ZDZJ0q1B8tVInac2F5Z
 d0pnoRNCWzDnSDd0Y3FzXLCxxjsiPv3X4aYB8rJ_v1a3bU9ClpmmHuNjggk0JOqSJOk00ND.vnMS
 tdbWgS7gGN8fwa8VK.1DP5fiBFJQWNlopUN52Gj1PT77saAs1V0YR0x0UbJhLYxm.gUzGqkz7JUy
 L6zCkucMh4sy9QE_0Bn6lCsPJHF38C3kcMaj.je_vi0iWVo7bjrbomfPy0RGeWT2idQED7pR_m0V
 iOD3jVfQeOHt9HxID9e.b_Hr2Ikux8yrPPmFLpTrxXBIjhTIhBC6yl5QL6nL6ckhgqn0iu38KFTl
 62s_EFGWN8mW.vXD_6NmhRecYvGl.kOFB7YcSkLlg.8IbmiCdC69sWzfaBAV_mUvFryVBcK3tgUy
 0vN9bRXMOc.2XZc46kBEm.778aadbSu_qdrPOGMkUARFP.Xu0RutrRaHn_6.riIn6.xeMTFAQjZs
 i0B8xhC33C1w3OPqLlqBmY.Pz46_B_3KqG.ljrA7inXquFyJ1lCx6cZKWHJY6vezUp4bW2qiIgzD
 rfxDbLXmhzzRalGrCL68NysJeh1B_vr6_0H9lKmnTJtNaokSYpQGH2zb.btha5bHX1.8vPqy5AuA
 Ohzh3f0BZe6tTyqnWKwQ2nA9nyFYAcZ5H0Yqm.ZwUW18h78eAnDqdX.TBlM0Q_YHtkdQUi4q8L3v
 Q80YTuoGMIKewlESfVP6AzcaQMCt6oxT4LseO3Fp1t.ppEY3YnVSYyQyLbeptlvv2Bhu.ro9DgDH
 Pt2mTA3h2ZeQGsTKNv_IzBiMLlfa8mrWrnH1OHwQpd6yIUTD6s6vx5DFwU_Zxzl0uXmD1rJ0.tcK
 ma7PcDSsERklj_1NdndBgg5Xvf03ooIL_le4NBS_uy6IvCL.OjxxXK1svzoWLyFz5ugFwUOT1DOn
 qEeA5IYdhIBgJ2dCj.dyWp2mFMq8LTm4Q0ti.u7Ch3_wkYIL7Fl8pFqRDCxbO0T4V2Dovd6dhD6F
 35Lfaty_S89WiKwM6R0AS2189ctM7qcX0mcDVca7whU8ZKOA0PnK3MItnjjYTjNyIwIfxLKVe6Dl
 61YMI3XfAJstnscbO2YiybsCtUdhpwEfGXDvoud2YGFOHMSEl8aV9B8KZur3g_QwLhFtq1TySDIa
 DQskw0OE5vXH7vJwUK9DMruX4uayxG0AbkA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Mar 2021 16:00:37 +0000
Received: by smtp409.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID abb0a87953873cb6fb8655002d3fb093;
          Fri, 26 Mar 2021 16:00:35 +0000 (UTC)
Subject: Re: [PATCH] Revert "Smack: Handle io_uring kernel thread privileges"
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <04c7c410-08e8-626a-795e-b77db6666804@kernel.dk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cc7dc28e-f812-a719-ce0c-a288d8facf72@schaufler-ca.com>
Date:   Fri, 26 Mar 2021 09:00:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <04c7c410-08e8-626a-795e-b77db6666804@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/25/2021 5:42 PM, Jens Axboe wrote:
> This reverts commit 942cb357ae7d9249088e3687ee6a00ed2745a0c7.
>
> The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
> need to special case them for credential checks.

Could you cite the commit making that change?
I wouldn't want to see this change back-ported to a kernel
that doesn't have that change as well.

>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
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
