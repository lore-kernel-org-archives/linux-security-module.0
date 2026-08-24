Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0A440636
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586882; cv=none; b=r2NoVA6AimVNzfi7o8v4P6cTDME9D2RJ9PclvmsRuBpxrfV1T54qFI1CsMPeNzsiyU7wPUYO1ouYpqarAuwoSCyuREVb6MFz0kXRQEFp2VG0uQ040+vPwPa0Lr98sQlxR/yQETFdvPXuqvdc7QG8CLF0kHLYsIpGeW45PMFJtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586882; c=relaxed/simple;
	bh=USKnBafwqRFKdKWqRWkjXfXuzVpNsWO7NRgRGSeCXa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0YUUb9GRw5DvtNO3BTpD5ZbXwnQ1cXmZBGzmEyNMDpdQ7m+GLccippZPZj/rkJdgKli1UuTZUcek4LxvXx6eRxfS+vsnCPyGqvtEcZHWJ0KRK4XRdXTcjiSxHzee7vQeeBjYypKz4N1H8WTFSJuhgbjcAau8/MtCgMmu6wAPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khra5moO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khra5moO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-472326ca506so1891885f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787586879; x=1788191679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USKnBafwqRFKdKWqRWkjXfXuzVpNsWO7NRgRGSeCXa4=;
        b=khra5moODuVomcOdNRNLMnfnBGS90sj6dadY71wnfxqBH1rOR/zIQXUjWTFoPUphPu
         30+n8ilIpIIj1/SYvLPP/822W+X8fHmBvLsgtb6HM4tnluHwhyQ63yDw/Fj0ewBKnXla
         zOqgXR1BENOy6GlY+sqomVCxbBqs/HZVTWz5nwJgDqr3ICxgkLOQYcRTeAfsN0cz8SlG
         hDziQ1Y3A/Fq0Xydib//uO7t1UYouDNWVcEgcPfBKEEr8jxfIj9k9+5wR0vx57AkVxkD
         Dbie2V/nxCvjtFtWMzmsFZk1nVSr0N7zOg9fhFoVdLU+0KRINLa0Ilsu5OzR2+C1CDuq
         te4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586879; x=1788191679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=USKnBafwqRFKdKWqRWkjXfXuzVpNsWO7NRgRGSeCXa4=;
        b=inaYEP8NACb4w/CtneTZfBRV0WLmVfEWg82dkrQPS8jM7rDITRYVNs3vZRty9ENaaM
         qNEmU3WTM6FmZrBvTSSgAIKyWSxV/On5w5tKBxiCiI0Uj6/a4FaK/Fg9DGLGt99BDKKa
         4rCudtRHbSq5EIR2F9tAnBK+g2tfRLDPKDj2nPAkYDl9s2nAzoI2PQn2NYEZMjL92V2T
         deKJqUlGS6dYNUHEvET7gaoc4hHXjclH6TOG6dajV13QeEMSc1NHnUPLHgNWg1Xou56Q
         +1sDRHW6jxyBjPD0SS2bkTbH/ux4+yRxFL25njtJXIlyc5Sugg4oXNSbadILZh3VT1i3
         f9rA==
X-Forwarded-Encrypted: i=1; AHgh+RrPt2kTSe5qXVub+5D29uOI4hpfAHGdi9Ls9t1Q7UO6FkaDE9aArCme1ZpK8/rODZMbdG+G9yf4LY9rU/eRC9cY7G+MF3U=@vger.kernel.org
X-Gm-Message-State: AFuF++npL1KRN55y8uPjq0GQjqEGPNMxgOsTTsBewZeUQsRi12MNg6x9
	eO+9XalrAUI3m6I0adAbM9xuIx7fFOsEd7PxmP6nqJlvkQ3gCHnalIPb
X-Gm-Gg: AR+sD115kpxFFW4EAhi8FXPgPDbq8+pZSZ7swRewYJcee0Zidsks/fQg04GHdPRwl3/
	6Gk0mgXROSVxdq9pnBzkCsQmHdhkJN6dGJ6/BhqltmrhrEQ3gIB0BEYgK3XQb/X2/lCUCMW3YoU
	5QAsX1PTiTUv7ir79DmSmiG+csILwK6OFmpt0pU5x3Z5i45kyrUnid/lfz7eGcxN5gmJOQ26sYp
	R4qJAtVbXmQw8VJDHI1EfyfLnk4JpOr4/7+SAQGh33lbx7NzLei/W4VFEWnfY2uhErXJnmpJt8p
	fwLEfzn94/W04M8K7q7e/713L04dSrGo8dBL/4zNfknc4iGol9ib1JAujfxE569cnIeXPFq10f6
	aP+Fmtqn4vNi9kPFXxB+JbAopVFqXr9zX9HvdIHW21s6DU7NJSHDgMIm6WbRHgEu2imujUCUF1O
	MjLKDVUmDeGpCijkNk+0+GCx7/X4QRpjqajo84regigx92e0xr8lve+W+PoGTmkXwk4cC4ZaxJT
	n4vv4bZxOrrvrL23yN0aD861JYezQCd/Nkd4WVoOjAFhZZoHHrON7j7shgEDrIyjNU=
X-Received: by 2002:adf:e193:0:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482c0ba3a3amr38819620f8f.18.1787586879357;
        Mon, 24 Aug 2026 08:54:39 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c14dadsm8734743f8f.37.2026.08.24.08.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:54:38 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <1feff118-4afa-4b9c-86f1-271a7a88208f@gmail.com>
Date: Mon, 24 Aug 2026 16:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: clean up IMA_MEASURE_PCR_IDX in Kconfig
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822001545.354195-1-julianbraha@gmail.com>
 <ca87a913bece92019d04ffb2f795f8365fde4a87.camel@linux.ibm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <ca87a913bece92019d04ffb2f795f8365fde4a87.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mimi,

On 8/24/26 16:00, Mimi Zohar wrote:

> The PCR index can be specified as a Kconfig IMA_MEASURE_PCR_IDX
Thanks for the info, this means that there's a bug in the kconfig,
rather than the range just being dead.

I'll send a different patch to add a prompt to this IMA_MEASURE_PCR_IDX
option.

- Julian
