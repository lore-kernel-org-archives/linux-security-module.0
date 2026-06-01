Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6F3438AA;
	Mon,  1 Jun 2026 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298239; cv=none; b=gvl6sJ2cxmByUPT7wFj+hnOeIpzzj9ynV+Skzbt2ofwtqzHJBF7ywdn//ksPyNVyWQWBp6TiOIWgclQBH/BJC9evUqBj9hQrL0HGAlIJURx0WA87yTwhvfZj01gBfJTkzFgoXsKjSBK64aiUqbBpwFjogk3MJMFrVpK9Xyd9noY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298239; c=relaxed/simple;
	bh=DO4msaOqvF3H3bb+laz9ttCBKElD4pZtlseR0ijQPVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVmBQ2ZKjMzlJhaOm4u4ovx8YGUZkh43YbZcNj/bKokS8GibZNvEAgVl0gay9G5bPNhIwgPHxCL0AV0pq/qI0ByUulsuyOC2WE60DSV0y3qYhk69yk1iJH++tJIx6HEToDHBNEOv7Hj4ASGl+nIZIujL3VQph1tmu1QQC/BOYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M95KQeCI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M95KQeCI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D779267F;
	Mon,  1 Jun 2026 00:17:12 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7283F93E;
	Mon,  1 Jun 2026 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780298237; bh=DO4msaOqvF3H3bb+laz9ttCBKElD4pZtlseR0ijQPVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M95KQeCIlLPF7OhDaVJJv5gCMWpS5dcnDQmYVPxaImLK2BCBRNd2t/5fQ/91yzHVR
	 7k/QgIRh/jS9NjROhLHKtgVlyeDwIsQMeyB3mTJzniGBXCFohl+S4fNVD5FR1jBpbi
	 X53f5BMyexI2gWbAeo9OUSqoYh/15o0zgOUMECd8=
Date: Mon, 1 Jun 2026 08:17:13 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah0x+YDypYFzpFqt@e129823.arm.com>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
 <ahoXUjbsPmKxfV_R@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoXUjbsPmKxfV_R@kernel.org>

Hi Jarkko,

Sorry for late answer.

> On Mon, May 25, 2026 at 08:54:04AM +0100, Yeoreum Yun wrote:
> > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > 
> > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > initialises IMA at the late_initcall_sync level, so this change is no
> > longer required.
> > 
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
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
> How we would sync up this patch? Through which tree etc.

IMHO, the IMA relevant thing would be into IMA tree,
However I think this patch would be much easier to sync into Sudeep's
FF-A tree where ff-a initilisation is reverted to device_initcall
unless you're uncomfortable.

For this, It might be better to split this patch from this series
since by above and defer probe of ff-a would make a register failure
of registering tpm_crb_ffa driver which is built-in.

@Sudeep what do you think?

Link: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?h=for-next/ffa/updates&id=cc7e8f21b9f0c229d68cf19a837cba82b5ac2d87 [0]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?h=for-next/ffa/updates&id=e659fc8e537c7a21d5d693d6f30d8852f2fa8d91 [1]

-- 
Sincerely,
Yeoreum Yun
