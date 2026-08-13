Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80022BE639
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622090; cv=none; b=YRx2dc+0EWZ0b2dm9tkzHdx85nyQZh5tGdx7GzrLfoUzMFyRW13KBFBzsK490Z5mN17Z0p7BE0ts9vkdE4tiB3UinSvRPgEYDmGdTxHH/oA4ovI9hcYdQVpopmeXj8uxU+LMlL1yhfALSPiigYP8viZMi5+DY7lHdb/oUt7KFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622090; c=relaxed/simple;
	bh=XK3M6kvlpK9SihF76trD/P7PCReSKfJ/TbsCxbrATSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjmkONqTakH7Kfb0fUgp94ruXuDE6q/Z1Kl0sG+Rnc0/cXPiiRKZN3FiHZ5GtukHTMfg3PJPe+/Ex6AsOw6jI1wYiQEOkev/tKS/KO5/L19y/+7wGDRJk76Wa0agMTAmPRn6tFTY6mxpWlF4GTpOkMLC7gUnUy17WFDuM+VPRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WobqiIh5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WobqiIh5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49553515a8bso28914725e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786622087; x=1787226887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uW1K/+Wxt7hUgt/RNFv7qiVm6hp7QCcrKF60FziImg8=;
        b=WobqiIh5QUPU3hIi9um2DcTDwAgwEn44vQHgB7SWbHmKf3b7+cGD4d2T8Z0sIo/y9H
         m0RdW3wdGz8n9WTvo58nhFsFmVlK38WMq17j8TW5NxpiVXypVpbhYc3Xs6HGpuLN3j9S
         Eixw6m8uOvG7LV3TPQRVWuz2PS6/2uc21JCSVbKZhZ8J5qf+nmN+5/RdIXhGi0hkWUc5
         HycLgAkwbHaZkveDh/y8JcHr/jJ+VxTwD1Rco/MBz12iZvabuipH9lEjbxkPgCKuPyHB
         VuVL8puZtcTD1+mKyFnW0sEt0whO5MCdCgl24sZ69/E+xVtDfJuAZhgQzwMLm/NFHycO
         Fx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786622087; x=1787226887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uW1K/+Wxt7hUgt/RNFv7qiVm6hp7QCcrKF60FziImg8=;
        b=ev3wNAweh23MHuCd/z4EzKvOfc0kV8oUX7LyEsmkRFd5gOXG6XVcZYIPZK7U61urHg
         pZgyUnanxSRz50MrY97/s7J1IIQwjlWtpCOi7DXhMd1DhGA7C5nnRGSIjx/KU2IIZivp
         agK10HiSG2N6Kh/OW4WboTDspV+ofvF2kj5dGfyNGN97HZ1HRE+h0E3RsTe34emhe4xY
         X+YCYEnriwrXmlBD8QX2c7YgpSLLNMCKZs12kKdvkM9LidSu2Dy8FUQ7W/h8jPx3MImh
         RvVt6kxzWqlscdn7hOusLxOuoDUYXRVU1/jajGwZudWG9nLkp0FdH+OsBidioqQDWDhQ
         Qa5g==
X-Gm-Message-State: AOJu0YywYezuf4VX3gmhmDDDeabcXlex4uQm1xrnpgcILtbEAF1r7l5S
	SGFAIcuamWae8iamUVge1RMDCLyJrDuLJkTRl1KJf0cKWi1nPrk1h42olCSN2G3/pg==
X-Gm-Gg: AR+sD10sCzxiRH9XtinCe3CD5l4UJ9pQt0ZUiBymmVssihtpFPXXv/ygHp013tKJUpq
	AmbMG2L+lg9uLO7dF+MasWk7C/jR8BbhomGcyy0BlI2OwBzEORmEIpfQzrNaoojAWTK/Oyu0xVP
	ZoMVVbwoxVLyhEfgSc0pnWRS890h1My6ZvTYuOV3zb7Yn5QA0sn+L1rGtykeQZavvc/MBssXaf9
	FFvMenQXyFiNssAJ6qgHRQudhz1jfWMJJjaa4iqUQQ4jZO1VtAKFns01nEgmfnjYpOt/WJ/emEc
	1BFfEzqNvlZjUBuSGPIdpcDk7u4ujQRRrfunit38CYmYhj/xn0gCcLZiuxWKbsObokwhsMwSoJ5
	FosHONkHFU0Bj3CJmwyo/chuCNPSqwQAQ3LkXxK1yMFAO3pT7nztSZEPTi8Fucm/VJ23iuTwxJG
	SrrPlPGlqK4BjwAah6NorszALIHQJrgaqltkjRdylOGL9TeEhLzk2sTSA6S6OA/i+preP81oMgO
	m9DUMHDjugr1/KAYRU=
X-Received: by 2002:a05:600c:1da8:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499821c3119mr77486355e9.14.1786622086484;
        Thu, 13 Aug 2026 04:54:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d644:bd86:b547:1b3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af19fsm5808593f8f.24.2026.08.13.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:54:46 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:54:40 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v6 3/6] selftests/landlock: Add tests for whiteout object
 creation
Message-ID: <an2wgGdmYzrulP-c@google.com>
References: <20260813093157.1436894-1-gnoack@google.com>
 <20260813093157.1436894-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813093157.1436894-4-gnoack@google.com>

On Thu, Aug 13, 2026 at 11:31:54AM +0200, Günther Noack wrote:
> Add a test to check that whiteout object creation is guarded by
> LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
> userspace:
> 
> * Conventional creation with mknod()
> * Linking or renaming an existing whiteout object
> * renameat2() with RENAME_WHITEOUT,
>   which creates a new whiteout object in the source location

I forgot to update this commit message; this should say:

```
Add tests to check that whiteout object creation is guarded by
LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
userspace:

* Conventional creation with mknod()
* Linking or renaming an existing whiteout object
* renameat2() with RENAME_WHITEOUT,
  which creates a new whiteout object in the source location
* renameat2() with RENAME_EXCHANGE,
  with one of the renamed objects being a whiteout object
```

Please feel free to update it when picking up the change.

—Günther
