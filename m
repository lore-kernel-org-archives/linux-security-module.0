Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF11D12E2
	for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289322; cv=none; b=KkYfbUicuIDirxjZ3j5+h/ufQRMYI82g72FHr2m76j+ov2juvUGPQ+VGhiJSH1HqdAPpHdVTnWcQuMHZYqFROvDfAsdTQZpPFG81XJSHORwKbwUyu9Kr3r0U/6WDkSji2EgT9edfz6u51V4wOd29KtgtXoPwTgndAqN2qdnQzVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289322; c=relaxed/simple;
	bh=BkPMs50zZc13AIm05w79Kkl6L8vilNFRPKZV7U9hmTE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=OGWOU8lEr2ezv1Y6ZvvUw3Pg+sBdnEpFx2N6FTzefTAKjXapwZXyq/MJ9b5eE7CkHUvIkmA93Q+kx7vPJIOHdJ6UsO8IXFebgJ8Z3KiJY+L43isPSvWRPPCAdmVuXxGZX4QR9DPUbIY9wZGmzvBj2uHXMGKPo7rRPAj0NqRrHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FtctVcKy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FtctVcKy"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf747371ecso1024956d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 18:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724289318; x=1724894118; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/yhTGH7B+0bIS9/Xf7YTxbX1d8basfp6eUrsQRQNnPQ=;
        b=FtctVcKyxp4m6jS23HJopYF5sHwVaOuQRc4oXoNO9hunOhBawhE8m7sqnputCIdtpV
         i6yCkeZ06ntZWNasOSrUpkpu7PhUc/3lFGC4Q1PodwyyDc+enaHSvthmezDHtWOnLext
         czfFnl8K7/7pUnC/encTO9gHBzI27WfXQ4TEcftdSd8NylT0HqiSCxfDPIMPfqAjVw/b
         ctNiilJgU6+84QCR8/mRYpQz4zqeuj2h6LP56cQHZbkaMHymoeXOGXBe3Sax7yDOWJrn
         H4419+Pt7PuqVXBSwu6qnkt/vIx4A/DfeSeziVQyd0atH3dsSa+/QA9mtBjyhumgAt8a
         IX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724289318; x=1724894118;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yhTGH7B+0bIS9/Xf7YTxbX1d8basfp6eUrsQRQNnPQ=;
        b=COehULjqmdnbXe69tI70vpFn/mjLnBCRF1FClX/4g/e5iZe5FOtAqEU3GRLpO5Jtee
         fSdamD15V/qR0CCrhnirGNqrB06fgJNHR6907W8EUhq4mvBrAuRhOHCGK0l4ztT+3sJW
         Ias/K24EbAVY3mPU1Pj2FSR+zGG06cRtgP/U5scbA15p8JhXaatUlDnV7+VF3axQ+I1E
         VHmXnBwnNEpw0zZ/ZTyqvmV41bTgglmHPJ+t6SIcCD/ouLTCd959/xT9auIN2Iy8jXiK
         B17EryXm7vpwQ/+aUfPm8TU/MQYo8RDF2Hlsqf26wttCGEYTVGjR0P513TywVdVU19Bk
         xNkQ==
X-Gm-Message-State: AOJu0Yw/giSKOpnhHzZPlQTPUZebFnSVir7LgrrdsyBsK7F5C/Njs96X
	FeP2Tm1FIDfwBASyFqT5715ilZgWMVJLmVnmfmv0QFdBVmDS7LupQZn15+tabA==
X-Google-Smtp-Source: AGHT+IFg+T2SWaUpA0ZTAUOuKnsncWSGUp6DTMp/CKzgv9Wbl2Lt9OAlx4XAVzNo9EwGAbX6FtnZfA==
X-Received: by 2002:a05:6214:3a02:b0:6b7:b441:8fdf with SMTP id 6a1803df08f44-6c1568b08dcmr40545306d6.56.1724289318129;
        Wed, 21 Aug 2024 18:15:18 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d6adsm2491236d6.27.2024.08.21.18.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 18:15:17 -0700 (PDT)
Date: Wed, 21 Aug 2024 21:15:17 -0400
Message-ID: <99e5b2c57719f6e1ca0162e77a61903e@paul-moore.com>
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
To: Yang Li <yang.lee@linux.alibaba.com>, wufan@linux.microsoft.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ipe: Remove duplicated include in ipe.c
References: <20240822003123.118140-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240822003123.118140-1-yang.lee@linux.alibaba.com>

On Aug 21, 2024 Yang Li <yang.lee@linux.alibaba.com> wrote:
> 
> The header files eval.h is included twice in ipe.c,
> so one inclusion of each can be removed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9796
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  security/ipe/ipe.c | 1 -
>  1 file changed, 1 deletion(-)

Looks good to me, merged into lsm/dev, thanks!

--
paul-moore.com
