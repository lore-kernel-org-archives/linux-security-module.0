Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417112D205
	for <linux-security-module@vger.kernel.org>; Thu, 22 Feb 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638745; cv=none; b=AUdDLIFVGgIZUsd1SMsCn49s3utAuj/5jb2zmXku2cRBtbopkO8Wvp/AV0s1AN70Hh6Gm3si61UKUV7QSow+264/37vs3yUsuBSggv9GqsiyHPQVk7w5RMSCdA/utLuES3qVntmsgrMrZdTzB0sOynL4/7f47JbpzkXRCPZ7I/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638745; c=relaxed/simple;
	bh=lnP1NZrl4ujuG8QKHHnD8jKJ9PO0jPr801whPzeYlHU=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=pOSsfDuIfy9aLztmJG0V5agBKSNf7F+aJveeTQTUL9nC3TyXFQdvkTzqXoVKbNH+Q+7bsNGXnrbJ/B7itW1ddkRtR6nw8hRCQ7e3WgDW5yg/cGT6gsFEPseWqaXco2GWjNOxBPraCRVUXlGzb6+ftNniiWSc4maJFF4wHBOcY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TVs8XNoy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TVs8XNoy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6861538916cso1777976d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Feb 2024 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708638742; x=1709243542; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8ZBrZ/+pFxkY1oFxjpZNMC+wvu9hBcY1b6MYAFWJmI=;
        b=TVs8XNoyEDL8CN5GCcSqifvILtmmKaE+pNlOp6k5vZUV0pShoU/GqTuA5mEP6VbWd1
         6He6JAI+gsj+5kKJNxoYl39ZlZQCBXo35K5tG3xBnExD6N2qMDwSTkCS10GIm/TD9tw+
         Jd02Eh2eKBg7rfugF/izs/hZv6tZB8AIlTId2Z2Vse03D41X39yrrQ3ShoH5WWEBVws8
         GveEnvDoRmIxxR7x2J1i+9Z4AsVVelYhbHRn9LSCteyFc7Q41qIEEujFuu/RcTX9fc+r
         IShPgNaub2OpgZ49wnPzAcXXrwaamMp/8/qg1lMMNrjy17kt6t9SnJK6zjASf8GadHGt
         n3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708638742; x=1709243542;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8ZBrZ/+pFxkY1oFxjpZNMC+wvu9hBcY1b6MYAFWJmI=;
        b=r5D7xx6xC1eJg1/Gy8NqneOCrl7U6Czpi//fc1fEe4eIDiJ00beg8BZWkoq3xc21l3
         4owm2r5KjIgytYbVyXihDUGAsKtyifCeP0eITZUy3i2+bLT4B78y+gd3wxAgjdAZQDUC
         lW4h8tI3UnLg0/7AAlRPIc0lGE7mKj0/CpSqoB7fgUMuR3ReYY/wYtftlW1E+GiwV7cS
         kYdN3kqIc77a494eYjlFN8qDosTRONYVeW7QnVsmtnk2gqURsJwEO5MbCO2mW/hh6khq
         zqw/y3g7b9fu5RyK8hWhXgjLQfb+RihZS+4UYjVEUFQ6X6mmHKKNXSREp5HrNZ7Dkjbw
         /+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWmwKXV4rKfw9wOilUSYXdLB7eC1tSGlJ4KniU6J2WlxTmiPKxc2qmvuDEIvigM66BVEe9A5mWDuDetXI3Rtya6xVDvroeTrrF4p1Oj9LfW6G0JzjbO
X-Gm-Message-State: AOJu0YxvacufLVYAxMgeCnButObkO+DnY0VHZqsgCa7hs+i62EReVnlY
	0FlEgQYg2lPoi3IK7eBofB6pP8YRnGZlMrB8T3G8BNiKdlwx/0zKLsmgbaR5ug==
X-Google-Smtp-Source: AGHT+IEpHmEMqK5EW7I4nyXpGk8Yx/n+LjAN6DfyqGeUomkyax6MyFYUHXzta/ywW6EKPUNuUHuJCA==
X-Received: by 2002:a0c:b681:0:b0:68f:2d21:d62f with SMTP id u1-20020a0cb681000000b0068f2d21d62fmr403459qvd.40.1708638742412;
        Thu, 22 Feb 2024 13:52:22 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ob6-20020a0562142f8600b0068c39b7a7cfsm7396689qvb.12.2024.02.22.13.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:52:21 -0800 (PST)
Date: Thu, 22 Feb 2024 16:52:21 -0500
Message-ID: <539a7320f63cb88914728368f8e96490@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: use default hook return value in call_int_hook()
References: <20240130125659.1709410-1-omosnace@redhat.com>
In-Reply-To: <20240130125659.1709410-1-omosnace@redhat.com>

On Jan 30, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> Change the definition of call_int_hook() to treat LSM_RET_DEFAULT(...)
> as the "continue" value instead of 0. To further simplify this macro,
> also drop the IRC argument and replace it with LSM_RET_DEFAULT(...).
> 
> After this the macro can be used in a couple more hooks, where similar
> logic is currently open-coded. At the same time, some other existing
> call_int_hook() users now need to be open-coded, but overall it's still
> a net simplification.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 525 +++++++++++++++++++-------------------------
>  1 file changed, 221 insertions(+), 304 deletions(-)

Thanks Ondrej.

Merged into lsm/dev with a fair amount fixups due to merge conflicts
from the IMA/EVM promotion as well as the tweaks in
security_inode_copy_up_xattr() that were discussed in the thread.  If
anyone notices anything odd, please let me know.

--
paul-moore.com
