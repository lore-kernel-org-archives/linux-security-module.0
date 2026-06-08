Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D412F1A08AF;
	Mon,  8 Jun 2026 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902912; cv=none; b=dXE0e7pTqzjsNPQA/JzJv8uxr1TooJRtsiDuEhX776oH04EocHSYcgrMaF6uz8Md1Oozfq/nFbZh2tYVKRYGhy8ykJMGQW8qE13zsYzD9N4kMLBOB64KTDg3szAm8UUg41CdV4pHHWHCYRDf7mo8YV6IHoVesebaWIvW/PM3jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902912; c=relaxed/simple;
	bh=5gc16I+Zlxa1Mu3A3sEKwJZ9PzG4qKIAiQ4/ymUJTqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBXtxMtvZgrDtLRsuh2rKpq6Z8sDY/QZyql0XVK293uYOmO6lveL6aqXOp32+IWNYSTn9vEfOIFC3zxb077iA4NgqYlbeIghEOdxYsCfvE4alGV9EolWF312ryBY09qtZNtNdAadhF6s62UwzNP4MxqncKFbvU0JsDTDw64RM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Cju8cs99; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Cju8cs99"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D79307A;
	Mon,  8 Jun 2026 00:15:03 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCF773F86F;
	Mon,  8 Jun 2026 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780902908; bh=5gc16I+Zlxa1Mu3A3sEKwJZ9PzG4qKIAiQ4/ymUJTqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cju8cs99JJqFxpnt2SJfylZbYR/fjTG0j/vl3UwYXkWWIOMr+Vnvlm1TRxdPhIUbr
	 NSlzl7AoNiJgRH93ceNBoDj89N/uHZd6GvoG/OqoIL68m7KJ2gTIk9lchYY4OOa6nW
	 rbqE48XGdAIgRWbF3MBv/PhOVumYLWVUWbH3z6+Q=
Date: Mon, 8 Jun 2026 08:15:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v6 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <aiZr+E4M+gl6sWsy@e129823.arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
 <20260605144325.434436-5-yeoreum.yun@arm.com>
 <aiZJAR3-JACaDcwR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiZJAR3-JACaDcwR@kernel.org>

On Mon, Jun 08, 2026 at 07:45:53AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 05, 2026 at 03:43:25PM +0100, Yeoreum Yun wrote:
> > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in")
> > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > 
> > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > initialises IMA at the late_initcall_sync level, so this change is no
> > longer required.
> > 
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
> >  1 file changed, 3 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > index 99f1c1e5644b..025c4d4b17ca 100644
> > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
> >   */
> >  int tpm_crb_ffa_init(void)
> >  {
> > -	int ret = 0;
> > -
> > -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> > -		ret = ffa_register(&tpm_crb_ffa_driver);
> > -		if (ret) {
> > -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> > -			return ret;
> > -		}
> > -	}
> > -
> >  	if (!tpm_crb_ffa)
> > -		ret = -ENOENT;
> > +		return -ENOENT;
> >  
> >  	if (IS_ERR_VALUE(tpm_crb_ffa))
> > -		ret = -ENODEV;
> > +		return -ENODEV;
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> >  
> > @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
> >  	.id_table = tpm_crb_ffa_device_id,
> >  };
> >  
> > -#ifdef MODULE
> >  module_ffa_driver(tpm_crb_ffa_driver);
> > -#endif
> >  
> >  MODULE_AUTHOR("Arm");
> >  MODULE_DESCRIPTION("TPM CRB FFA driver");
> > -- 
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > 
> 
> Is this different I applied?
> 
> If yes, I'll swap (if mandatory).

No difference. Thanks! ;)

-- 
Sincerely,
Yeoreum Yun
