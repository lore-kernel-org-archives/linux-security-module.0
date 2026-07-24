Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49E1F12F8
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852707; cv=none; b=KYsHKm+Wa4WHcU4/DkfYIH4FJv92cMRX5cBSm9LpIJO1z2vxwpGmrFE/JypchtIablepFNzPPnpw88ih5j7AxSmaFRcGPFLcjUc1TK1hqwhg6y4/7F0DXuWek9RPipDnf9VAjGB1ACso0xUmqd3JDZNjryQU9t7Y9ImCl6uRIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852707; c=relaxed/simple;
	bh=ccMcpYHfkbI3aMSX/cRaKf3Pn1l35LkeDuOd1giBR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4LPkgVNjtLKZHyhZN1AOz14z1ahUeJXpClxM5HVz04J5P+5PV/LRd/YVG8M+FsRyt1ajZ+wGF5jpJBa+LWf2dSYYP64dTvZSRUibbfOOMb7hM9JZ1z7Xxe7PBTXAEkpvn4FXuKWqHOtkwW1B6tO+IO/wrJ9Jc0xWRaZJWmiIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fljYUSX0; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fljYUSX0"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6681e7911b0so1105142d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784852705; x=1785457505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ccMcpYHfkbI3aMSX/cRaKf3Pn1l35LkeDuOd1giBR1A=;
        b=fljYUSX09z4UzMcv5DXWsqJKp4vwONhVGB9GdMM705GKvrDU+BMK7bSyF7uvxy1ULr
         nUIe5Omi6iWK/A1rzlIeJCAxU3KhJeKzh1ajHBM97C7LcZ1vlhSwlKXNl2AH0eXCgC6i
         doSA2R6reETEhWexf7hgM6SIFBpY4VQybEvOXiU4MSUHfpkTbQXp12ZkA19WvEVu6rMw
         liQk2986ayZyt14xuvLCRVZAoXpr9340+hItI9TjB/UE5SxhzrYmBBB4SkFA5PKQ/Q4E
         uS/hK4Yn+y4r3I28a49QK7UjYrnU5pZYphWEtm8uKC6sEdwOLUuK0QY6xY4JyMYXYGpi
         qkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784852705; x=1785457505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccMcpYHfkbI3aMSX/cRaKf3Pn1l35LkeDuOd1giBR1A=;
        b=AFkzukUrqEVqabEKFQk+dXLS0Tx1Vf1qihnkR0ue9yQ8gTHzxpY97r+1Us5ca9lOV8
         ni4LKPBzsdv0F44XQwdX1qK7ieKNPcPryK7SHkXjQacCmOlQLLqjoilTbIqEWAS0L5zQ
         QXH2ROQ1Lh0AoxjkpL1ynJPkYPbS77zu/qTLtpA3SlZQ76oav4PLUyGzh5pij8F0X1ZO
         KJRmQgDJ/QaQGtntCPGrXGemNwDVcVmHpdyPyJ9HtLAW+wkamgDq0s9i9i+U+NHAghAO
         tepK2PivxNo54CN4awuyYrcdC0hVSmmr8efsXcPLGkfjgopmaZRLFMIfucIwebTGIFWP
         ZMHg==
X-Forwarded-Encrypted: i=1; AHgh+RqXQHdFnSKnQhOd9R9dwJ4nAteAp5W2KtMJIbWI4z2snHZwbh8jALvzoWFxE3PSg3E9BheopcjpwQAr3BxIfJ8ZZYy70rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcQQdgOH5kRjvAiScsjqh5GjV/el+0hfuR4tfWfgoupctuqSl
	ZZ6LVJ+TnQdalzhpolFcO9ZLe8qeyv+QLZKk1NShyc87aJN78hN8qQsS
X-Gm-Gg: AR+sD11BiVe0c45cTSpc0jnkOqR8hk5IJx8Zm/Jx9rnQwiTZgruOCaA9i6eJRYFHYqS
	QGZsL5h8Vf3wlgykIcXBzaVG1dDwm6Z1O4Cd/3S5jJYr5WGKxUIyTzfJ792wlzaIrscu1eeELkj
	QDXxToLwTwDGXeoGYkBfk5YTiH5RxawSt3aOjxU6SjjiCPTu+SK2yYtjKY6MNUAARzGoRWyofoD
	TPmx4B/uP42DKaEDOoe77MrK4yUw0Jhp3Zy3vb8+hROLMjz+NUv3Mtu/wIqwPJ5y2+cjqmUIws2
	Fw5vPtrPwF/NJgNtBu97nyzwZ4gv073Y92lquFp9rdZKqWLTriBrB8Hu+fbptKtPq/OAjj6ugku
	Nlz8gdy3kaqRJx6HQVCpVwoawba+ic3XzgtemJyDRTkF59uLMSbyq+bZAhDNraEB/CGkVbguwC3
	k=
X-Received: by 2002:a05:690e:484d:b0:668:9230:e269 with SMTP id 956f58d0204a3-668a4c60022mr833880d50.41.1784852704908;
        Thu, 23 Jul 2026 17:25:04 -0700 (PDT)
Received: from gmail.com ([2804:d45:3612:3b00:e1aa:6f0b:6cfa:c97c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c627c9sm35847627b3.19.2026.07.23.17.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 17:25:04 -0700 (PDT)
Date: Thu, 23 Jul 2026 21:24:59 -0300
From: Lincoln Wallace <locnnil0@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, rdunlap@infradead.org
Subject: Re: [PATCH 0/2] doc: LSM: update usage document for current LSM
 stacking
Message-ID: <amKuTh0WV1vhvA93@gmail.com>
References: <20260714013832.977443-1-locnnil0@gmail.com>
 <d14f03a6-2c48-4f96-8682-29453945b29d@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14f03a6-2c48-4f96-8682-29453945b29d@schaufler-ca.com>

On Thu, Jul 23, 2026 at 10:47:12AM -0700, Casey Schaufler wrote:
> I've been stewing on this since it came up. We should probably
> remove the somewhat complicated logic from the Kconfig files if
> it's not adding value.

That seems worth doing, but it looks like a separate change to me.
The document currently describes behaviour the code does not have,
and that's worth correcting either way. If the Kconfig is simplified
later, updating these paragraphs again should be a small part of that
series.

Happy to help with the Kconfig cleanup if that would be useful.

Do you see anything in the two patches that needs adjusting as they
stand?
