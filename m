Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD280487A5
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713941; cv=none; b=HcaMN1dDM/Dhe9yGAxLCpmx/ZhV42tQdkuxcovOjZEusTW936Vz+MfOHYaCmXCitm0i6xOcH7k8kQldMyL8vTGEstzt6CXvPixmVK5u0keb0LbSaa8inm3UVJ0ULKAGZbAmoEsRQkN8ecEEtickie3PGHm67LTvYVFuPm/TNG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713941; c=relaxed/simple;
	bh=lseX8yr7Fml4IWKAtwb0sHKRoGS7250CgLsHSbFH5ds=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=VZZNQesNxonYbwYpKd8QznqQO40Ndk/eV64qWgdjy9bI0Ug2PCb941aaR3Qo9/SGZjym6XCIvvaB6goB9gl+h1MdUqdRodIc/feZF0UjVTVzSXrMJNGCa/BxsgUbrIhdRjZlXFmEBUASdYUpma/d9Mo6CFD6serJGos8EMSSDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBnL0e5E; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RBnL0e5E"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf784346b9so23178736d6.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724713938; x=1725318738; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wL9Cvaz0fKLd2JXQCXyQoEx3DlkMZpEiJncmtLe9tuE=;
        b=RBnL0e5EcBMFu1XJOjVf5CS85Vu5L6DNBeix3YM8y6ZHKePHkp455b71NMIGPdTKmH
         AIHxosOBHImegoSQixtPJlsi9EeVug5xZjH7/R+EaktdxCH2vEI3bYer3LqJG9XsqS3r
         oCOeSxtBDWGpx73Jc5uFFlWPMPy3yLMlvO1YDQ2/kifo70XHjyZR42Lp11yZmvz8xizY
         fN4yTNz70b+UV/5Bj+cpzSQRvRfmuwzj623CEXG1OohPbKWhiy6c1MkaIRMm/sVEC0Za
         3sFZC1UmAT/WuHogZPaKrhhRaK+Pkm14qudSoZeiutJiVvrl6ycTtPJdp4IrSziqjT+P
         cxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724713938; x=1725318738;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wL9Cvaz0fKLd2JXQCXyQoEx3DlkMZpEiJncmtLe9tuE=;
        b=n7fuvgUc0qmSEnM9zwOgkrGdahxqPOXONjN5LwQE9HIRUlr5XzafHvP5LTQaFUG0IA
         uQfXLPvOb9BBwmtyYaOx+zBPwzsoY8zo3E2NxuTPhOMkZCOQtWPcj6T6zHJThhxRV/S1
         MVL6TTLwoyQZ8zaQbToNuBSXvsf++COqbSns9VSLhazvsN92P7vMqoEzL1wJAXNUCG+I
         dPzBEY1DDTaNZc3Umdx+MEw0J8wSOW5jTjx5tORxAhGBCw2/OjAjmxL1okANYuKGPpfo
         X6wMi4nS20m9DefYB3POWcOpb0Ksm43ftY5x5pn7pi6Wx8ZAAYUH2RGj812a7PiwHnrH
         Sa6g==
X-Forwarded-Encrypted: i=1; AJvYcCU/gNT1p84CjB4fAilfCSgkuNzxRSOcG525kIr4WZS6/mSN6QjjLV+0fTY1JHsyjq+mAN4gDIlo38fhCAh8CmuF06q9rgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPacJxkMt9XNdkHPvX6q9xTH5F95ZHjSXcv933QbW0CSwnUeZO
	HW1y/HBu8Pk3fXiBLc31Xuq1tTx76Rn3Ag8y/wcrR4Dy5yOyA/2WJi4jAl/6EwdHHb1rBpndFXY
	=
X-Google-Smtp-Source: AGHT+IEz6zVMvxURroYpWnRSPaRvAcVKUUxC5ncSrLQk0/bgrzo48/FNShObtAYtXt8tmM/Vf4jQrQ==
X-Received: by 2002:a05:6214:310b:b0:6bf:6e27:f0fe with SMTP id 6a1803df08f44-6c32b6a1dcbmr8981336d6.23.1724713938435;
        Mon, 26 Aug 2024 16:12:18 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0964sm50554116d6.79.2024.08.26.16.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 16:12:18 -0700 (PDT)
Date: Mon, 26 Aug 2024 19:12:17 -0400
Message-ID: <024d26e3590a84ee81fe66050aae52dc@paul-moore.com>
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] lsm: remove LSM_COUNT and LSM_CONFIG_COUNT
References: <5089fc1c-0172-4ccf-9ad1-28ff1b649597@I-love.SAKURA.ne.jp>
In-Reply-To: <5089fc1c-0172-4ccf-9ad1-28ff1b649597@I-love.SAKURA.ne.jp>

On Aug 25, 2024 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
> Because these are equals to MAX_LSM_COUNT. Also, we can avoid dynamic
> memory allocation for ordered_lsms because MAX_LSM_COUNT is a constant.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/security.c | 37 ++++---------------------------------
>  1 file changed, 4 insertions(+), 33 deletions(-)

Looks reasonable to me, merged into lsm/dev, thanks.

--
paul-moore.com
