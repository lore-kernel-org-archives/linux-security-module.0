Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92B340410;
	Fri, 29 May 2026 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094807; cv=none; b=rcBqEjuRq/vwdD5p9017w5o2DQgCtA978OOqtTSqHLYFpUcipuMlxesmH9l39YJbr5ZmaHn/7JE49wsFqU1bjD74D93pzglY4zTAkfAWCWW7MUSdbw1DOkJ70KLn5NL1FODAch/i4GgBlnjlGpph6GLbpb3JaqKqv668kUrImuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094807; c=relaxed/simple;
	bh=WMUBw2iE0cBVBC8QL3QIB04iiLysK35KZUzG29cbv4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZErYoMlm5Xytgw8prpQWItzQ6VCGYQwyvrnxlLewytrFiWh2Nkj6Gb5wrszTsPNW75t4Wyduun7BCde9bQ62CZGD8Wp0KwY/VZeC9Win4Uwf06idiQxpaaKPqPWhjwF81RhplWBDMJGUSUC2z4dMYfLugYv0rFj0A02SR5WEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/zcM+VC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/zcM+VC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CC0451F00893;
	Fri, 29 May 2026 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780094806;
	bh=ME90hvCQ6fJK46SQ+z7iQsm6NZwy5LYJy6nOyR7PwI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D/zcM+VCFS+toOOFiOV9b33kzs/9M6yjNE6jvIQLmo0YPr5Mo9q/XBnqbyM6U/vKX
	 g4CBhzitNO2Aq3pehv297Hd6oYr+1N/xPKkI1ROdaSm6wvz5uBe48+o3TBAdWWL/uA
	 2iF6WwWTWXbyJOj9RjLhu1ucPrrt6TzpidE/ceMWZqkSl0pxcqMJFUuBfdQSRc6gVr
	 YX5kR+xcyq1zyLRwp3KRXtCQgzJXZvs2Gx0cCONhVZojOQPUAaSoFovKtC0yHS9BrA
	 Qg+5lmKHIBI9mVphhn2kRp8hAKFFAtwda87vVdITwra28Qs73f6XTNl3KuaVJ+LWSr
	 icY329Yt1lL4w==
Date: Sat, 30 May 2026 01:46:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ahoXUjbsPmKxfV_R@kernel.org>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525075404.3480282-4-yeoreum.yun@arm.com>

On Mon, May 25, 2026 at 08:54:04AM +0100, Yeoreum Yun wrote:
> commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> 
> However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> initialises IMA at the late_initcall_sync level, so this change is no
> longer required.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
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

How we would sync up this patch? Through which tree etc.


BR, Jarkko
