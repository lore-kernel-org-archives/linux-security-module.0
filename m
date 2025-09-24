Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9228643F
	for <linux-security-module@vger.kernel.org>; Wed, 24 Sep 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701123; cv=none; b=iPe6TzdZ2/6oF/4RLwBAQ0j1MPgSfQ6+6iobrN6EcyzNPGl9nbjMOaCyBJ1vd8yBqptlpqNKPIZzGcbxvzSLZdDZkXnSDOahYP9Q/IGcBF8raALvR/XcgGD9fvq67LeuCIdhb1KEBFwkVZ2c1s7DieJV6wIHJ9/ryhkDdWOgjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701123; c=relaxed/simple;
	bh=crF6Az1YSgLdU9XhdJ1KkmiF1PxZyJXrk5Vf93YEvks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uaBQAYJQur+QuMpSFDVNTUSDs1/gbYxlZfYzahA6FTIWVJRm1wImh7c/Sd7R1qE/zLNftz5VcEHDQWeIsZ58F3QSD9+ANRy7H+vpaiWQFEO/fzicvjqW3qQIxGrCFEyp9QrlHmc5eJ6VSdYau0uWTksPGn1vK7ufUsMPVxDZctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3OAXv1X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3OAXv1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lE0jLBwj6v5RJ9sfXT8HYz8ot+vmwAivygaeoOEjH7w=;
	b=V3OAXv1X8gKCly+cVHdtjsOuo4dcygsPPILeT622dTvoFb2dJ7J5m0yTsKzC0ZXZhpHnnA
	yQCNX4p2999619/poHbBsajR0MWyMRWfnuwZzOOQRG5dV6X0BmI2uz5usDBlDrxacOyZhg
	M94nW5dpta2FsIyGDGA90lltTFI6Koc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544--08LqOj6Ofy3ceRtCN-grQ-1; Wed, 24 Sep 2025 04:05:16 -0400
X-MC-Unique: -08LqOj6Ofy3ceRtCN-grQ-1
X-Mimecast-MFC-AGG-ID: -08LqOj6Ofy3ceRtCN-grQ_1758701115
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5509ed1854so4314968a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Sep 2025 01:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701115; x=1759305915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE0jLBwj6v5RJ9sfXT8HYz8ot+vmwAivygaeoOEjH7w=;
        b=bjZ3N25D1fWaQPiiATnudrMk/xIGHsGus/nfXhTahr4a2JfG+2vgKfhtptkS974Wd0
         SGM3tzjTvLoCIaHbFCN2aeXxIDeicU5YhwbUt2d1Hix8TXN3kiidfkw+24WkJ2RDMbyP
         lXWVE9T3MIvkQ2sZ0pk4UOcEAE4AYcwZCc9JI8bbYShlP7JZUMGawTNS771UWu6PY4K7
         ccAxXyw3PZrf/kaU6a0ZzMWXZdit2SIMGu+nGwuNkj28ENQyeuiKOYassVyOw0hbpvQD
         JHiCXERs0koMlAAq915q9I4UDLPC3h7BgQXMr8pEYpxo2rd9bA1cRh7gG/Ec8zcCbo4g
         d0Og==
X-Forwarded-Encrypted: i=1; AJvYcCWQAui2cgTLJtvmBoTxP5MtEQt+Gf/i6fkOfMLwzpgd/wjJNdOrRrT33U0SY8ieQV8wXKGyrLrlIhkszK7WgO5SbQ7pAQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7am5nbFuyUyYqaErxADo2g2xPjBqy1sD/mVJpdybrVcGcUDi
	M76wcuTUGsAVwHatT/JVmOQPR1vHle9zx/Y2ZteaVOyo7egDZJYnX0DeWpswQdbZ/s1TENLsGa/
	g3AR5h1xuYWuT77azGJgHdmT03AwhtopXWWe00tKXhjRM8foYni4UZh+Bp90d7ymgwG+Shh/3gF
	HLXQ==
X-Gm-Gg: ASbGncsWUDvH7ap+TdwdQHe8rp8YSPb2qEfHCyooqUV/YFPRlecLOPILtBI95TR1KP0
	G9vMQQG1H+BZdyTRqvUJzQeCYNo7l/ESEZ/0ulbttNyzvouHflPGCPHbGpCT8lN5+p6jyV7HAL0
	QzwLYogyP2zg63xEwfm+XJZJ1tUQ9YOK1njGD0D6UPf2ytc1imREN5KOs2qbVE/yDc9DIakeOgs
	Yh4jrZJg4K9+bzILsdR4sytbF0zUd2oQ++j5neD7cMbFGAdJYJBvyGG6xc4AQWFByJWVTfmfDDl
	hdypnanV0rd/O9HgJt3EolfKLlc5HXI=
X-Received: by 2002:a05:6a21:3395:b0:263:4717:564 with SMTP id adf61e73a8af0-2cfddc69ce1mr8313161637.6.1758701114638;
        Wed, 24 Sep 2025 01:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGuhOhnDnh5hDS01MfzwD+uSDir+osMndP2WHac8aNDoTYljhwk/oMLyIc2NRJK/sfRtf6gQ==
X-Received: by 2002:a05:6a21:3395:b0:263:4717:564 with SMTP id adf61e73a8af0-2cfddc69ce1mr8313098637.6.1758701113951;
        Wed, 24 Sep 2025 01:05:13 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551518480asm14410381a12.28.2025.09.24.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:05:13 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:03:34 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <4l7l4duxfximhzixruim3lnij5mhnlqs5srzycc6j6c2bu5zda@ogoj3ade37fd>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
 <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rx79qESlcFluxZg97BE-aSdLXNyplyYU6wyH6VKzykc_1758701115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 15, 2025 at 05:05:42PM -0400, Mimi Zohar wrote:
>On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
>> On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>> > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> > > When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> > > signature won't cause security.evm to be fixed. But this doesn't happen
>> > > to a file with correct IMA hash already set because accessing it will
>> > > cause setting security.ima again which triggers fixing security.evm
>> > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
>> > >
>> > > Let's use the same mechanism to fix security.evm for a file with IMA
>> > > signature.
>> > >
[...]
>> > > ---
>> > >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
>> > >  1 file changed, 21 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> > > index f435eff4667f..18c3907c5e44 100644
>> > > --- a/security/integrity/ima/ima_appraise.c
>> > > +++ b/security/integrity/ima/ima_appraise.c
>> > > @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>> > >  		integrity_audit_msg(audit_msgno, inode, filename,
>> > >  				    op, cause, rc, 0);
>> > >  	} else if (status != INTEGRITY_PASS) {
>> > > -		/* Fix mode, but don't replace file signatures. */
>> > > -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>> > > -		    (!xattr_value ||
>> > > -		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> > > -			if (!ima_fix_xattr(dentry, iint))
>> > > -				status = INTEGRITY_PASS;
>> > > +		/*
>> > > +		 * Fix mode, but don't replace file signatures.
>> > > +		 *
>> > > +		 * When EVM fix mode is also enabled, security.evm will be
>> > > +		 * fixed automatically when security.ima is set because of
>> > > +		 * security_inode_post_setxattr->evm_update_evmxattr.
>> > > +		 */
>> > > +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>> > > +			if (!xattr_value ||
>> > > +			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>> > > +				if (ima_fix_xattr(dentry, iint))
>> > > +					status = INTEGRITY_PASS;
>> > > +			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
>> > > +				   evm_revalidate_status(XATTR_NAME_IMA)) {
>> > > +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
>> > > +							   dentry,
>> > > +							   XATTR_NAME_IMA,
>> > > +							   xattr_value,
>> > > +							   xattr_len, 0))
>> > > +					status = INTEGRITY_PASS;
>> > > +			}
>> > >  		}
>
>Instead of re-writing the IMA signature without a clear explanation, define a
>new EVM function named evm_fix_hmac() and add a call here in IMA. Only in EVM
>fix mode would evm_fix_hmac() update the EVM hmac.
>
>        } else if (status != INTEGRITY_PASS) {
>                /*
>                 * IMA fix mode updates the IMA file hash, which triggers EVM
>                 * to update security.evm.  ....
>                 *
>                 * Similarly, trigger fixing EVM HMAC for IMA file signatures.
>                 */
>                if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>                        if (!xattr_value ||
>                            xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>                                if (ima_fix_xattr(dentry, iint))
>                                        status = INTEGRITY_PASS;
>                        } else if (status == INTEGRITY_NOLABEL) {
>                                evm_fix_hmac(dentry, XATTR_NAME_IMA, ....);
>                        }
>                }

Thanks for the advice! I wonder if we should use existing
evm_update_evmxattr instead of defining a new EVM function. 

     /*
      * Calculate the hmac and update security.evm xattr
      *
      * Expects to be called with i_mutex locked.
      */
     int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
     			const char *xattr_value, size_t xattr_value_len)
     {
     }


I already tried evm_update_evmxattr and can confirm it works.  But later
I switched to __vfs_setxattr_noperm because I thought it's consistent
with current logic of adding security.evm when there is already correct
security.ima and it's a slightly smaller change.

-- 
Best regards,
Coiby

