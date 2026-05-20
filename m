Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0332FE05C
	for <linux-security-module@vger.kernel.org>; Wed, 20 May 2026 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247429; cv=none; b=DyrwNXizSni/iSmvwZrh+se/eTnSFSsbHh/5CTuQMA/MfalFDZr0KtHR1MJ59d2WraIjnu7n68+aDjCGQFtYlIk2EVPyXn2Vt5CHjpi5VDmhoab2gL73nMnWqOSnpJ6ayidnQK02eK0e9das4DlLx8fSwDj+V2mZmg620U9b90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247429; c=relaxed/simple;
	bh=edpgFvB1eBWa0iwOxw+kh4PXSWfZY4/hi/ukSm0/DQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Y4b4NQ981QXJGfwF63xKPZFQAU4nCloGChJKtfo+Zua9NeCHkKQYs45EKmULUn6ggwhHtNi80h0X9TDGEm2f7fMkq6HzfXbrKywHTEMFYsQi3BSk5tIsd6Kra85L53JOJcFFmAb7labn8eMCc4JP+dgD4ydTxgL2zOYNa7WAVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzFXx2eQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzFXx2eQ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48e82c23840so34804375e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247427; x=1779852227; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edpgFvB1eBWa0iwOxw+kh4PXSWfZY4/hi/ukSm0/DQQ=;
        b=GzFXx2eQ9W5oUArmp7XsF6iMMlygpKbjh1rugDMVRPggB7ibcKEfqmJzvzSl+ZIQOM
         2aXynZnPJIWmt603Scqu1XzH+cHEMsgtd4kwGasCjCfn8IpE68rnObB55OADGI/YuYEP
         MozXp7R9YYz+LoPw9ZHWRVncdtsb441n+wksKYNouVilyOT3lT0sBPhAGsNPzJHwMAuX
         ns6aTfdLjRURIgaJPagAzn+ZWk1Uyl0c7fZyerN97/u9TGJDGVm7Vv2fbXiLuWHV1ssu
         RsjebfH8+QbXfoigLG58HySYxSw2kawdxIvQ3dpveHhrxjH6WC3/aMBopqi2XcBefcy5
         S+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247427; x=1779852227;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edpgFvB1eBWa0iwOxw+kh4PXSWfZY4/hi/ukSm0/DQQ=;
        b=TZHPgh+aVHKsamMPhKO7tLa676RXwBY3rOPUl8wXp0uaLbNoP+77YGxaUizVsersk/
         7v6Dt3wH3gZLJaoQ32PmxQsRPNrZEzj/Osu0uYM5uiAZUtBthStXauLdgqCseLzU+frV
         ZatlFDryOh2xYmV392iBxR0JZyI7wZWzTqAumaG5gTpp5IO2m5SORUyE6BbExqM4I8mW
         HC4fYsEwQLmG/sLVh8dZs+m5f1BciP7WluGFYl+bJv7O0+DpdiXCPoSx48Uy6C7ptSC3
         GtfHfv8XcZxs/yZLpNNlCRuISDnleL0GhPpSkGpW4qhvAu0MpOeRCzZ43KuMjBaVqFXw
         SRlA==
X-Forwarded-Encrypted: i=1; AFNElJ877El0TMvYG1f6t/nonYt3nOthi3qUBGIHUNbpBMm9ZEYRz8ZKdU0IehZIQxVHoZNR8u81hkofG/ozeJ46C7Uyw9PwCnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQj3I5b2qmZZhRxCR9d88Em06+JoZoTWbTzqTTfLViDXaunaMc
	SODCM1hLmwc4MFKRvTtGrZch1T/0G115GylTdianUDXlM0p/oabSZM1T
X-Gm-Gg: Acq92OEXDrs+f775q2/T+XR287EbKtktSz2t6BkCGpbp/6Gdo16XfGtx2jcILeP9OMo
	bQhQlS2K2kNmTmPY7PDHeudkzjaSg82bwlk3rZ1kvhrvy51QTA+xG4BOsr16u7rTN5skE4aWXRL
	RABS/9d0NdLNbyqJi+kaBa4WUfwdbXRZDYdtE2GA0Brj84UQ+sfjd5XNHZ1MQGEVMUFn/B1nGWb
	Cq2xm2iv7PRigcvdcwWmRLBPH6GwSAxg+qsMRS+MdegLH8NFRuX4Ns8jmyORYbp1rvOSn3lsag4
	sZgGe/bjMjc05qCBgKONo8qVkVfirDWW48j8S4jjT0R/m8/OZj72RJhLSyVIq9mJc9BSJnN01GV
	vJtnajnnHGgJnmS+e379SAmNlNDmlrVVj/fNzossLFOlSwS1ywLRC80z6Ie3tVlCinfDRs5fyCq
	QXjVe6LXSEbtC1kPnUc1bgZS57/S3j/OCKIkbF0UAc5A8yqgyWsEy6Fs7QgoLAN31Gs2VmivvIG
	OcVsMFsmLBZCMhy50WQBZ4ZrJWPFUPeQAcwXltmcqDSjG7as6OaAG+3EUucAldkcg==
X-Received: by 2002:a05:600c:1384:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-4902238403fmr59342235e9.8.1779247426819;
        Tue, 19 May 2026 20:23:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490191b5244sm36266215e9.3.2026.05.19.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 05:23:46 +0200
Message-Id: <DIN6KNJ9BUXI.2A1LG8WW3842M@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "KP Singh" <kpsingh@kernel.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, "Xianrui Dong"
 <dongxianrui1@gmail.com>
Subject: Re: [PATCH v2] bpf: reject NULL data/sig in
 bpf_verify_pkcs7_signature
X-Mailer: aerc 0.21.0
References: <20260520024059.313468-1-kpsingh@kernel.org>
In-Reply-To: <20260520024059.313468-1-kpsingh@kernel.org>

On Wed May 20, 2026 at 4:40 AM CEST, KP Singh wrote:
> __bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
> backing). bpf_verify_pkcs7_signature() forwards the pointer to
> verify_pkcs7_signature() unchecked, causing a NULL deref in
> asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.
>
> NULL-check both pointers and reject with -EINVAL. Mirrors the guards
> already in kernel/bpf/crypto.c.
>
> Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
> Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

Added missing acks before pushing.

> [...]
