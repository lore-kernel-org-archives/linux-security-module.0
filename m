Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E872F7AD4
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234296; cv=none; b=fBLbQXD+s9KXo4SBUoI5HjiPwYha+Z2Q+3n0F3ENSX5sjYPV1XaprhMdyNykEKWz5VRD02D78Q8M6o2m0hJ74LMgNge1ei/JPTTclNmXcV4AHJaoKEdhAdlE1VZqIoCUpJmDCaQlek/pa3bXoOEWBeuKas1DJOScC3h329wCO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234296; c=relaxed/simple;
	bh=KD8kMWmVHWif/IAatoSGDNampJhPM/CNfGdxYnMKEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BK2AaAEjXN40t0YI5bL3llqXOy2a+320bxaZp733MjOoYyo+gww8MW1QchQT5D/r6GJerYDCPzKgr6awkDLL/0L8MKL/icT9HbqQ7sFfXOS5mDBuaLNOXCPulCs6x9ylUMZR2hsyXaMmf4wJcTlZFFIVT3l+WGcw50t8FNbk4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=De2HCYpu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De2HCYpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759234294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYhlOTDpz0Sda3KEKTdInplw8rxwP1Ctg1XIqKxUWtw=;
	b=De2HCYpuUgr7oGDomhsFLIVb/bTgI9y7RUJU/i1Ka7wxZDRBVgp+2u6cwvL3W4q1125hnW
	jU0h4Zybm7jPPhUAEGe/PuhnOJ2I7GaodtVudxC5ecYUNL6CtD+ifhX8yGVVuIWTlwPUN9
	6E87pKQgwyfu2t+Niqv8Q1+BNZBPEXA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PRkgNaoFN2ivzhbGm8ASKA-1; Tue, 30 Sep 2025 08:11:32 -0400
X-MC-Unique: PRkgNaoFN2ivzhbGm8ASKA-1
X-Mimecast-MFC-AGG-ID: PRkgNaoFN2ivzhbGm8ASKA_1759234291
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-634b661347bso5599968a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 05:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234291; x=1759839091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYhlOTDpz0Sda3KEKTdInplw8rxwP1Ctg1XIqKxUWtw=;
        b=gZevLrjFUPu+vfiuvAP4O6FrAUTE4Ri4fVHMAUbevnVCIfq1gr3JEHNfTg2Y5gKL+0
         iAPfMhX2a0/Lw58gEHvevgXqmXF14u+GDX9A1Czpv+xOQuvC5KjmNH1DhxRrFDOc7urN
         s00xsb8yf+g/Uk13NBfx6jOM37pTWPtZL6pNzWAyI7xL84AUMwzXrpSOF0KRmoCTa6TQ
         ZNRUeWZq3r8+teY9jFo4yoKoFZ/F7cNHhoRGkM5/0C8xSOcdDRunQ2hsLGUC3vOEgDwR
         ZQHlUtSaBEZ+5IAOrmia0lyS7EIXrAd1unnB2BK1xSU58h7INvLlw5t/ojqYT4yd+fLF
         OGSA==
X-Forwarded-Encrypted: i=1; AJvYcCUiigQPHeX0gqtNR+bbQ+dVPBX9NNm/oHhMOizWHNvGYejdbm6OAlUqz4Ure9aM3+hKe578r1ESAFMqy5ZlNPyHbY0n9f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJc54p63XEgP39NTxXjs6GwM/cQ2+NGtagnh0MPDiqdxzFVrdm
	4RQyxTHqjCQ8I1DxXn+7fbkktjgejWqGqckMUWmM/2Jm7/xTJvMdWIWo8tWBY40J9U2OvPQzjlk
	Un9sd1CqXv1+HBysK38StjrZF4PUrPY3alzzLLm+JqOJs/6Ybrt1O2HcBJ0p79jKTTQh/1EEZ1h
	+Scg==
X-Gm-Gg: ASbGncuiw9RiEpxaiQ403mBFPliATEXJ1PWJm48WUZtcREeHjDwcGZ/8YT5Mw3qko3C
	SbBOO+RnGwp8MmgACmjC7T2T/ZR+tW1wSUMVhxFeoMuyocCLgVKDsYZOAloTJeHHumi18kl9kkB
	xZctv2Jsrm4Mf0qB9E0+hnaJYjwTezJnpb0scXoNbackqAksh9U3YEb/gdo0FuBnjBpD88j2njm
	j3JlReYC5qA/FPFphZ1Fkcg+I6uly0fFkDjuvliUTiFAtFtR1Ffjmgr/Rg5cMv4lxKPmQ3h7w19
	pVektLHlzay5yDvG5BjCqU4nqh7Fn7FBywO6HWet9TRLZZuDVL3ercSGfvtZpGIJtDM0uuoyUHO
	XOgWL08piuC276hZK1vQGXA==
X-Received: by 2002:a05:6402:3551:b0:636:23c2:e61f with SMTP id 4fb4d7f45d1cf-63623c2f2d5mr11899894a12.26.1759234291451;
        Tue, 30 Sep 2025 05:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpBFHlpi6h26vswLogB4lR1OKDkES+l20vuTxXnbWfysRnTRsji62rg1W2cZYzxCghNaMmAA==
X-Received: by 2002:a05:6402:3551:b0:636:23c2:e61f with SMTP id 4fb4d7f45d1cf-63623c2f2d5mr11899850a12.26.1759234290960;
        Tue, 30 Sep 2025 05:11:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b02ccbsm9498953a12.45.2025.09.30.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:11:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:11:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] tpm: Use -EPERM as fallback error code in
 tpm_ret_to_err
Message-ID: <hjay4b2lomj6k63tbnuk55q6mm4sdj2d7yycw64ybhu372l6bd@uqetr6ipbtg4>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250929194832.2913286-3-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rceHXn97aytI3B9Web3W6v7UR6YCSnC9pDne7EzZ-3A_1759234291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 29, 2025 at 10:48:24PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Using -EFAULT as the tpm_ret_to_err() fallback error code causes makes it
>incompatible on how trusted keys transmute TPM return codes.
>
>Change the fallback as -EPERM in order to gain compatibility with trusted
>keys. In addition, map TPM_RC_HASH to -EINVAL in order to be compatible
>with tpm2_seal_trusted() return values.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- Removed fixes tag as it hardly categorizes as a bug fix.
>v2:
>- Split trusted_tpm2 change to a separate patch.
>---
> include/linux/tpm.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

LGTM now!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index fc7df87dfb9a..51846317d662 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -453,8 +453,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> 		return 0;
> 	case TPM2_RC_SESSION_MEMORY:
> 		return -ENOMEM;
>+	case TPM2_RC_HASH:
>+		return -EINVAL;
> 	default:
>-		return -EFAULT;
>+		return -EPERM;
> 	}
> }
>
>-- 
>2.39.5
>
>

