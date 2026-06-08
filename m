Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9CA2DF12F;
	Mon,  8 Jun 2026 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893958; cv=none; b=bVUib3gQtOP067rQT4Ad2JNaV/76U0QQAz5gXUl4v6N+K6+o9mCWV5VNNOivtSrPRwPiEROeCSpHwaGm9ObeH6BAFZuqeyRPPi7VoHY5lbLSSxk2JvZSAnDsirIv1sfqjM6Qdub35W2RPyEK7MiDlezisqXirz9et0oe3SkzBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893958; c=relaxed/simple;
	bh=x++is1IfNVV4zKeMWDHAIznHUFAFJHSplL8qG07sJPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l78QJxU0JPW/3Q6FZBf+l1jr8CLi2+ZMtmMKmE5LnEeLIQzHPVfKkRx88Ya6C+VebPWPoZK7J6B1iSM+SAbk9zwKWs03SCzv6oHR12/SEL3H1awIRKUCIXjkB01aBr+c2ZDbZxAylHI2blhoRlsAtkkTUX4S1PfdWTSUrm+70NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha4UFtXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha4UFtXr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3E1941F00893;
	Mon,  8 Jun 2026 04:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780893956;
	bh=2H0WhdWL1Bkq3n0+yYT8GroFaY2v2hOwt7LwRG3f6Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ha4UFtXr+NqsMKADfvHVmOqN+IqzyhYQpDFKqWgXaXBas1qLRIPwmOcbqZ/uM4JK9
	 X4qcAfDwL/RmunJmSYiyUfqb58+gxPHabhKUFFeHaGqaXHMTGq6E+zH9qKGT+txNZU
	 8CbZotBtqV/G3gR57o5V6iSwe1FIdyCp6423jd+SnXQcfuvxASaSxxW4aHP+BoVSD3
	 dgSHLCdA7ZjVHzKNS5+UTrGJtbo4hx00DKsi/0rR/hPPg3zd+f0cy0SLpmh5mwWLDa
	 qLNgft/toBtCwY1diFN1cUjRSIHi1FQ5I364IZhclC7p1tTLOsUfavPXYqGbR8+T/U
	 fcuZaoglAbgzw==
Date: Mon, 8 Jun 2026 07:45:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v6 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <aiZJAR3-JACaDcwR@kernel.org>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
 <20260605144325.434436-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605144325.434436-5-yeoreum.yun@arm.com>

On Fri, Jun 05, 2026 at 03:43:25PM +0100, Yeoreum Yun wrote:
> commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in")
> probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> 
> However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> initialises IMA at the late_initcall_sync level, so this change is no
> longer required.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 99f1c1e5644b..025c4d4b17ca 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
>   */
>  int tpm_crb_ffa_init(void)
>  {
> -	int ret = 0;
> -
> -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> -		ret = ffa_register(&tpm_crb_ffa_driver);
> -		if (ret) {
> -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> -			return ret;
> -		}
> -	}
> -
>  	if (!tpm_crb_ffa)
> -		ret = -ENOENT;
> +		return -ENOENT;
>  
>  	if (IS_ERR_VALUE(tpm_crb_ffa))
> -		ret = -ENODEV;
> +		return -ENODEV;
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>  
> @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
>  	.id_table = tpm_crb_ffa_device_id,
>  };
>  
> -#ifdef MODULE
>  module_ffa_driver(tpm_crb_ffa_driver);
> -#endif
>  
>  MODULE_AUTHOR("Arm");
>  MODULE_DESCRIPTION("TPM CRB FFA driver");
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

Is this different I applied?

If yes, I'll swap (if mandatory).

BR, Jarkko
