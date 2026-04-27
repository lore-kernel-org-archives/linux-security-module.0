Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF73A9DA9
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332779; cv=none; b=k7rsgzzfeZphBQF0Y7uZiy11q+3t0gPwes6FBLUcpkic7Yqk0SyXGFUWKEkFISHtycIeOeHdjWzSIhIpS8Ub3h2uJjVkSh9P9B6smUcBW5sJyKMpTCATS7RvbCAe8+OCn10t3CAzIV/efAT7ARlIKipGycQMeA2C8ld2mxeXLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332779; c=relaxed/simple;
	bh=26JcQONhsnOoI3eYTKhqy18PwJWdR4v9SHzJaJb9hhI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=c18R53h3+qP4cvBh2be/SQEMGnAqju8aDzTe28XJ/4DtEJY/KK/CB0NHRZAk5nnZHiAm4lElAsbl3tjUrActVXpyiZpGfH5rS6DsKxnJXJ850TW4VlrLHvaWfEECZWQ7rBjbgx1Zai4QynrjiBW3GNaz/KLU4jGBwyq/4I2xdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PGECWZjM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PGECWZjM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d4f78fc9f6so1183933885a.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777332776; x=1777937576; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AacrbQWeONsXwYeqMAMp8ZNpTduvDnpFQOhYm8v5DdI=;
        b=PGECWZjMVMuvoHZEqtbcT9v16+X5abPB6pFB+QMndGI/JN3GIG0J2s6/R/1ir23f9z
         Rnx1dk84bc/GRU4Q6LDApegzMdvstZEW/bjUcUEtIRR9xKaWO5Oj6wGaLauocTTGuoRh
         DWvvYx6P31mcZborlxcUm13iRU2S8aO5AIsYhVSzwuPRPH6UgJdZHCyhYtete7ZojZu1
         cRQf9nnX8HqOJHrnmOt3WNOKO04bAJMQqB0hSJpLTdnhhozP/Z6OSc/nYQhJrHR9c0DS
         eiE3+RXp1ef2jFxL77nf5iM3BdB7F/I+jjbCYV0L3e2quvuVKqnBCU9MsqtnkuqCCd96
         ShjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777332776; x=1777937576;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AacrbQWeONsXwYeqMAMp8ZNpTduvDnpFQOhYm8v5DdI=;
        b=lEzCRyH1vF5JFgXDQmkXc9A1A+CxpVyrXb0BJHSLkjQLNvWwAWqNvIJIKsA5AaN87v
         8P/k3DgockC2GQgO98ZVTbBjseCc3FFBwm0PxHWy59IWFA7DQAr4YtHfG6Z/w2y6aiLW
         g3ILfgM2TjD9KYtOpVlBp6LlI//zoySJJN1021vTnqRr75aUlVg/+1UHtvlB7oifgSgS
         YzX9bE/8cjVf7xynjgmgilbUneahGB3p/v3SB1a/JSOU8v/EO7yTOOxHVino1400xwYD
         5rlwewehBEbkTOY6HWpywsBeGjHXeHaxYzFDtaU6OKCDS3KZIEKSUspiOnYPPXTuy2W9
         yPvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3lmd+V+bhZqbo92y9bknnSsNk1k5cMcT4uBDwL4CE6hj+chMwGnV2AjA5JIGDGXnWmM/iwObalFRltjEX+qA7X94EyMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDWKh/ZymzP5ZSGt/qPNDI/Ste+egnB2LTQ0hSt4tdmAuWYY2
	cVHuy/zmFG6Wlf9Mje3v106XZceCohjeTiEXOJWQx4KTsUkMLYh/IRdzJF8qcfumUg==
X-Gm-Gg: AeBDievjT7GOCteQDV/nNgrASF9wpfYDb95oUcElX+fg+Fm2gMhA7c6+OvPeE81M+oa
	tr4NroFLY2wNdvbcgvORXX6ppVuqcrpkQUDw9afT2wazXj1eNNXU5o9VWxN5Jad7fSunSlieOEH
	HB8yTQQmSwTrzA0i0BLa9KLIjCvjOXA9s494RVM4FiUb3W3aYbKXkwtVlTG4IBXCLAkkVt+sz25
	0W2nzVZpQ5rJjaaP4bpJdHIsObS2HL5tLikB6k5b7QFVCgk+lo7ccMtXgx3SykAQS+HZJR39NGu
	9YCyTUNxcrFuPpVvdoMDcf7cEDCJdFB+aeZuMVK72GJd28hfvZz1+spBgIpcS0pJ4c2FC9c8z5/
	6bR6mKNI/JlsBrWC2Q46oKTijdaA3CNSTVTW5QgRAS7079RTpUDnrNg+WOJHodNSwdgFstu/SpJ
	IfIQEx27qHk6RnEFrc5CXYk5hvVnHpc4DEV4yBcOhg2ZERfsivK1zik2aUFFhgmi2UXPnfONZvz
	fC71Ww=
X-Received: by 2002:a05:620a:7111:b0:8ce:5a30:9523 with SMTP id af79cd13be357-8f7d6f3dd9bmr106905485a.4.1777332776436;
        Mon, 27 Apr 2026 16:32:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c49c4953sm52474885a.3.2026.04.27.16.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:32:55 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:32:55 -0400
Message-ID: <0a65e27845468d7b0b57810086a563d3@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260427_1759/pstg-lib:20260427_ 820/pstg-pwork:20260427_1759
From: Paul Moore <paul@paul-moore.com>
To: David Windsor <dwindsor@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: don't reserve xattr slot when we won't fill it
References: <20260426232349.844289-1-dwindsor@gmail.com>
In-Reply-To: <20260426232349.844289-1-dwindsor@gmail.com>

On Apr 26, 2026 David Windsor <dwindsor@gmail.com> wrote:
> 
> Move lsm_get_xattr_slot() below the SBLABEL_MNT check so we don't leave
> a NULL-named slot in the array when returning -EOPNOTSUPP; filesystem
> initxattrs() callbacks stop iterating at the first NULL ->name, silently
> dropping xattrs installed by later LSMs.
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Good catch, thanks.  These seems like a stable candidate so I've merged
it into selinux/stable-7.1 and we likely send it up to Linus later this
week.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..4ff118a9395f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2966,7 +2966,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  {
>  	const struct cred_security_struct *crsec = selinux_cred(current_cred());
>  	struct superblock_security_struct *sbsec;
> -	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> +	struct xattr *xattr;
>  	u32 newsid, clen;
>  	u16 newsclass;
>  	int rc;
> @@ -2992,6 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	    !(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
> +	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>  	if (xattr) {
>  		rc = security_sid_to_context_force(newsid,
>  						   &context, &clen);
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.53.0

--
paul-moore.com
