Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C3C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 16:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376976AbjKBQnB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Nov 2023 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377036AbjKBQnB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Nov 2023 12:43:01 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17475186
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698943377; bh=IPS6Lr/18xGcOMBLJi07s+ttnxLRyUVnEyiHv9geCw0=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=qeg9UGiFUCpjEkcAsnwlzVlfGgwOx84veb2xmeOyGzoE/kF8eB+k4eD/BV4tW99VXW7Oqqyh44Eu7XgNgL6s/MLI8K1vyvYH2YPofSFm8hBO8IOToP4G1C2/9AwhUWqIZB+hpm89DSFmy59J7P/4HBP9idXAuaX7RsBCeGR1JVTrVmbw/5yNp72CHj+fxIBJWdhBPsLkqf4ZYqPielrKo7CksE8Hro2WVjfRe6OEMTkxLjXIVLFKyMSL5CtiOKdkL1wJQepJ+2QCMOWo0sGEh/qRHYMCucemuikoD/5HrNq6x21xAM1S1lqfwDV+SjdoKPtUTi1DqhWVSpBpmtahHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698943377; bh=J8o52KqmDQkNyVrJ3tp5EWmCdL1RzdFF13P6L2jHr6F=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MWaFqMUua7go8easRmEj+o+595xS/fV3cYcMGeSKsZAsQbx+IkDw6qNkVyIh+tBSx5j4BxWh/vEIoFHq9c8crmmxO27szPI87C1v8yUj5xuhL3vne2Hxn3coTj8SUUL72UnObjtgN9DHO8h2MNfKTq1Mskid7swA3i+sQCoWOfwn0njVzIlsrn+Ge8pED6PeO+CN9lZFJlC9uCzgIzkyxMeTpkPxzg7Cbem+1xez3obhXQ6CKHwsyWrD0y6IEywEAUcTwENx0+DLS8ifC/fH3n+sxxyJYV07Mi3GYjvvD6ua4lcsBTXfjaNOQfgTk6K1ui3ma5yyHq7SvrU/zK2bcQ==
X-YMail-OSG: f2x37skVM1mzMNw4UA4hpzWzIAj6E820kU7XRVAnDX4TzBaMUuWgkZf3UIZ3SiA
 UzoX7EKMQ09sszcM7Qy4INoqY.is1cafs8ZUsgZJkf0H40I978Jww8PeQMEcK.wAOGjdBPJJ43ZM
 r_seXFw6wa0MZtJ9lxT_emjNkaUnQtJtky89KTACVJamycy3HSsC_yo3nsfmTpshHs08YxDc3aCw
 T30eRE5OhwoQg4h4aKCMp3qeEmwcb6xwbQE8Xuir7qw7wVhNSS9guJyK0CQ_htHwemlNzgx8tcLT
 vHAt195jgByvwGVhbeoKMaNWimA4kodMtHBuhzpBVu_C9EtM1t5uuyRvHvJBKsdtENux_jzh9u86
 wCdJ1FAmKM08kGl_JuQ8UvTTOkYb1cIKAD6xvBbeuV3tYHL3Yyt7TT2Do69h4O0GkBl8BErlaZqG
 azkZv2YLKF.oh7JeaZpJHY_g613t.X3EIdU..afkPC3FeTlFsYqA6EbNcJ56h3TA90FSklwdP90w
 svvVGmjeVzDsS1QIEdFHny8qvURj8JBfoOUs5IxJyxVVdshqcJ7EFB_O8_gQ.8Jg17RQuNLUnCPg
 f4.nJXX3QINSo2OFtdkiYJdEj7iRtNcR6oIdXKXpHVBhZAySN1Np3tyLvEQ3A2TQMMeQqFrEwzvH
 iZESW4BJXQCl.R7OaGzDaOr_KXmufceLRdnUscDeZP3p6hnK6suGVKowvc8bBrHJ1LbIG2t6u7r_
 YqWbETt6UQBfFvMZlypMPrEg_BKN36hwKeRwI08ZhfPJ1sZejYfRu87NgDcQ4suQuum.Ko2T3KMb
 4TvF4Fx1BFkqwrS3ZKYp0MdajA3qW1vd8yKW3zvRO06o4K.WBSFb_7fdg8gibEfLa.JZsmAjTm52
 Jyg.2Iu7XUw4pOC.ji9_y9YHG_nzLR7IeFo2AGUGoQToxrKxyAiUivTjBhzgJ9e2s.8QVQmpEPBp
 9mzcYw3zLb9NkTZp1bjFq29yvTj5QNWYfPSV_JPbEJtNufJX0v23MXJN7iufyFy42qM8Ft70yFyH
 77toJyOtJbWsEezzqXG47z_LmDX1QR6QdVeA9bMztHBkSsfRWkfFXmq0eZeAFgwd.nm32TqoROBB
 ZUmlnPqhVFUW.mdwL7q1X42RNKdRGrEcwjTmWPOc3DRSsNDEsZlXNw.m_sM_vv_1UyRH9PZRHqe2
 5J55iDgj3U9rGwXlKSECK14mCh5NUoIO7RbzynIaEAjx1etKqF1PYSBY4Ao2NxhE6zboz25WE8KA
 eWE4kHhZXSkgnbQmwaUEoH17UJfeVSF39rbOLoK2KNn68gQc3a_0MUInLan.Zqe0zJKFZpXkt5XT
 xdljId.k8bb6n3ua1I0O6tBOXDnJYTDpzjrPWTKtIPtGvcZ6Dx.zuHvEVW11EYuZh4F65ykzn8KZ
 jJEAa.19yL4wYPHSO8rEoNYFsuTYoKn_mfnZotofApKFGS4zUANz2_BPPwL4Zqh7gT0cUTW6Gmc5
 Y7iYNLGswLVRgx9LzuiO2DmF_RK.DAEoCpmx8k8TCBT5vPVYWHRFpfQUSxhbviXNNHqzoohfzxO9
 dDz02T7nDS3l06tK1g06XARY7vsFPTkIQRuSQ9Orfp_X7qFWJfiYtdHu4MS.hicQdcJ8qevPM.KR
 c1IkArksI8BvFmTPZcROE3kM5jwYvgRvAMpf0I93MEwBLULYcNcP7psvVmuZXGBXl6oT8HscfGnB
 oCQj4mSnuhxpGxkKv10OsjVnaANWRlCnawqjbGt_FVBzhz7Bw914h9qSkssuHrb9.ujHZdYuqMM6
 zEfWvNThif11sHP60YedPHkbLQUQIK.VbWA00lU5jPq.WIACNGA5fwL9.wfzEm.QmD0dixnawOsL
 8daJe3HN45FQGuXhRbUOH9Sa3zMpyjzMfNc8CyILUham.2HkV6mhiMVSZhYEU.VAHp_Nk6QaDrhF
 PPT1hSvQIYr0cEpK6cit7Ev3FGOIuynLsbMwX2blpMP6sh9kn4QS2GS7nJtiOpeGC2ujhR5Iupre
 8Y0bqcDw0_fT9TvrGODEve3nSbXH1Dm9z9tnBXsngAFl4GF79UV94mxz3TUnM.mmTPoXZP9UUpiT
 Ha.A1sRW9J03oSAc_yuuEfNyjaRxrsnHxKUWncbNGDkcedw1nBUSxO6W6QYPGIDeJjl66l3J.Cgp
 rjch5iIzwx3lF51uA163lZ8UE0ZRGJ4CTl7oun7KRNewWIhqiLEeb6xzsE1LGxJRqEMzT2soDB9r
 ZOydyVeZFV_aPyGPSdPoWu90vKLRCXkm28qrSkd.xWM1CyOmyvfW7c5tCKj0UAF_k0fE2f.rCwUK
 7Th3ZTU4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 21eb5d2d-56c3-4cfc-8fc2-400472299da4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Nov 2023 16:42:57 +0000
Received: by hermes--production-gq1-59b5df67b6-gs8xt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 855b9370b3c8d9adf5339f2bfe1dbf76;
          Thu, 02 Nov 2023 16:42:54 +0000 (UTC)
Message-ID: <2eb17e11-b69e-4c77-944a-b7df49d532da@schaufler-ca.com>
Date:   Thu, 2 Nov 2023 09:42:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: convert security_setselfattr() to use memdup_user()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <20231102015354.511078-2-paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231102015354.511078-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21890 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/1/2023 6:53 PM, Paul Moore wrote:
> As suggested by the kernel test robot, memdup_user() is a better
> option than the combo of kmalloc()/copy_from_user().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310270805.2ArE52i5-lkp@intel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index a808fd5eba6d..d7b15ea67c3f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4011,14 +4011,9 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  	if (size > PAGE_SIZE)
>  		return -E2BIG;
>  
> -	lctx = kmalloc(size, GFP_KERNEL);
> -	if (lctx == NULL)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(lctx, uctx, size)) {
> -		rc = -EFAULT;
> -		goto free_out;
> -	}
> +	lctx = memdup_user(uctx, size);
> +	if (IS_ERR(lctx))
> +		return PTR_ERR(lctx);
>  
>  	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
>  	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
