Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313851EF36E
	for <linux-security-module@vger.kernel.org>; Wed, 10 Sep 2025 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467520; cv=none; b=BqCybq6s9AJZxlSo+cflr5oee8JG9JLT9CsEKc9zaWsT29F2p3aSnevxHX3y1HTR0b0p7Rmn7f01inoavEBW1V3YArLeDm53x5Dxm7wDizin05k2aiY+QT0ovwsi634Qf1nkvopuwQ6tft44R/hcIJq28jSCKH8fvRqkbR9g/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467520; c=relaxed/simple;
	bh=4GWi8FJrFdGglwpD+ZM2rzgalHuKfUIMSpQQxJduueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QZkMQffyEA4OsDrdl+IB/FGGQ8K0SlcsnOxhR2EME87BSo+YjlLDXWEjmww5Z1PRgXjeZGOvioObYHgZvj/4/kkqdkCgMIkf99LmJq4f3n/GMXrRVe5OFVQ2AhcK9UsXJaVmwQOXTtZ0TL+GfwuKLjmITDPoX4DheENAgFC4rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acJ56xBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acJ56xBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757467517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1S0JMauUdEExgpfNai3TrQujfpxsJzdhy7tT6tsEQaw=;
	b=acJ56xByVMTpcaK6bN634MnxWdpVoxxORMj9Ahi2G6Ie52E7BJsXdJ1ngwZEXvV7vSNr6Q
	ItyM+jbxXOgl3BeqLJLiaTIuU9lpK7TmEPTncOYGNpvO77kO+qyy/M+jI3q7zWznJftR9J
	Zr3eRdX5H/OyvPqoeiMVmPHLTICz/o8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-FTe8hBfbOXKcN9QYMLpuhQ-1; Tue, 09 Sep 2025 21:25:15 -0400
X-MC-Unique: FTe8hBfbOXKcN9QYMLpuhQ-1
X-Mimecast-MFC-AGG-ID: FTe8hBfbOXKcN9QYMLpuhQ_1757467514
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32db3d5f20aso745352a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Sep 2025 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757467514; x=1758072314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S0JMauUdEExgpfNai3TrQujfpxsJzdhy7tT6tsEQaw=;
        b=i9hlCU9gWrz/AViWOKTFjpXGTjh7avAVb6/OVSYuU0N9j7JsmMD50vAWMu1ARFq9dk
         oBp5PXagPBTUN6OTsqAzHp5iiC4bPFtkaNrbiaw7VAscJlNqcThp2ardTkN1GBghXUZJ
         NTv7auLKV05UbY+4mQjgEaWaIvAV/bRlvGjVADFX1wNOgEvutIw+2CnGCTdNfS7rqb2r
         IcmOQGBnm/wIL1aOHVyADcN25OvOBFQInKITRDUfCEGk8PtWI3ysORomqMTJTCdpvSV+
         94aqzNguWGfbH735dWRxF8TRXz1pdA1vs/K0PUlAuHnzTnWn3MI0LPGuZnjnUokwcMmF
         coVw==
X-Forwarded-Encrypted: i=1; AJvYcCVIH8DKzf7lJ2eqyrWzcrfZGn3o/UPn1L2H36vqKEHc8sRW7YZl+Xy/EFMGOVxqKd3wxNZqKoO8VeLgnL3CHqk+hf0Ay1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThTPi70LP91pCx0JXPxrQO2pZtrDAyRmTkc3Tg05vaEnMugN5
	jlSOqOVJF1fKFOJoCWCRSnmwjPyGcBzJOvj1wARoI5RUhQkmTuU0rOZq5SIYBLlq5N0x2dJPYa3
	7lFS9Af0GUCnM7S7kebX8TNdUKEAveoFm+XqfCHF0KIKpiYLjNDxPH1f60oUr1B5sW0V07fmhv+
	WPng==
X-Gm-Gg: ASbGncvUpbGAo/AVkteTh5K0FarSYFi58UwpSIrmItAlFhZ9rbmHpCK+XDfvEt0CiYY
	QAfnLHy9tJOfA5dCQesvRWozU+sCxpEoFTrt+MKCGhSpPP1r8y0mAiDrRtbPjdShXeneo6i+qxh
	R/v1Alvb6uEaBQbxjN4P3eBIuZAtLAB9XXOkADcxGHUoYEXzZIS0ot8iXRHs6aHTN/l10jE5uMm
	h1ZGntxDyD25JKVK8DrLlwj+ASbaoY1Pp78PrI6nksN0jgyKruU7XPeFKh03hrBE/UrS8bpCT+2
	/v5NWOaLIBMedI6e8EWduYP85ybxb1g=
X-Received: by 2002:a17:902:e849:b0:24e:7a4a:ec59 with SMTP id d9443c01a7336-2516dbf1ed0mr157716645ad.22.1757467514409;
        Tue, 09 Sep 2025 18:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwc9Y0nnGPtTYZcw0VCtzujxBLCFu6IrQ2CgEWKnSXXOY5vhKnUk+VwzDfNYN9T92gLbLFbg==
X-Received: by 2002:a17:902:e849:b0:24e:7a4a:ec59 with SMTP id d9443c01a7336-2516dbf1ed0mr157716525ad.22.1757467514072;
        Tue, 09 Sep 2025 18:25:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f2fd4sm3336388b3a.93.2025.09.09.18.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:25:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:20:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xw9xO0Tq-3cv71PUjHXEdTCPlzsky_JzO3hiKdIMDBs_1757467514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> signature won't cause security.evm to be fixed. But this doesn't happen
>> to a file with correct IMA hash already set because accessing it will
>> cause setting security.ima again which triggers fixing security.evm
>> thanks to security_inode_post_setxattr->evm_update_evmxattr.
>>
>> Let's use the same mechanism to fix security.evm for a file with IMA
>> signature.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Agreed, re-writing the file signature stored as security.ima would force
>security.evm to be updated.
>
>Unfortunately, I'm missing something. ima_appraise_measurement() first verifies
>the existing security.evm xattr, before verifying the security.ima xattr.  If
>the EVM HMAC fails to verify, it immediately exits ima_appraise_measurement().
>security.ima in this case is never verified.
>
>This patch seems to address the case where the existing security.evm is valid,
>but the file signature stored in security.ima is invalid.  (To get to the new
>code, the "status" flag is not INTEGRITY_PASS.)  Re-writing the same invalid
>file signature would solve an invalid security.evm, but not an invalid IMA file
>signature.  What am I missing?

Hi, Mimi,

Thanks for raising the question! This patch is to address the case where
IMA signature is already added but security.evm doesn't yet exist. So
EVM HMAC fails to verify but there is no exiting
ima_appraise_measurement immediately.

And you are right that re-writing an invalid IMA file won't fix an
invalid IMA file signature. And even when IMA signature is valid, the
verification may fail because the key is missing from .ima keyring. This
happens because we need to turn off secure boot to enable fix mode. As a
result, CA keys won't be loaded into .machine keyring. Btw, if I'm not
mistaken, current IMA code assumes we are not supposed to fix IMA file
signature.

>
>thanks,
>
>Mimi
>
>> ---
>>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..18c3907c5e44 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>>  		integrity_audit_msg(audit_msgno, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else if (status != INTEGRITY_PASS) {
>> -		/* Fix mode, but don't replace file signatures. */
>> -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>> -		    (!xattr_value ||
>> -		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> -			if (!ima_fix_xattr(dentry, iint))
>> -				status = INTEGRITY_PASS;
>> +		/*
>> +		 * Fix mode, but don't replace file signatures.
>> +		 *
>> +		 * When EVM fix mode is also enabled, security.evm will be
>> +		 * fixed automatically when security.ima is set because of
>> +		 * security_inode_post_setxattr->evm_update_evmxattr.
>> +		 */
>> +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>> +			if (!xattr_value ||
>> +			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>> +				if (ima_fix_xattr(dentry, iint))
>> +					status = INTEGRITY_PASS;
>> +			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
>> +				   evm_revalidate_status(XATTR_NAME_IMA)) {
>> +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
>> +							   dentry,
>> +							   XATTR_NAME_IMA,
>> +							   xattr_value,
>> +							   xattr_len, 0))
>> +					status = INTEGRITY_PASS;
>> +			}
>>  		}
>>
>>  		/*
>>
>> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
>

-- 
Best regards,
Coiby

