Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0844063C
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279379; cv=none; b=PJlQKUMEDlS0ZkU1UC+xmYyaswly8++xU06QKGjFJlxunYtac4NHkaaNm5G1/18JV1WLfsL8LbuNwlvDN6X1xTJnXyIcNWpZqpVZYgQR0VYnSKn1xpSzZEfTXNWig8n5dmvOxAzpsjfMIWcLetfs6mDF+wZR1dj3aJjKSK7Wvnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279379; c=relaxed/simple;
	bh=eDOuu6SSu52TKbjWx6ehFX9DzfSBGnFG4ldHBQmydqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX3eF5bePE8EnkX2inp5xU+Ucj8caluQZz8dZmvNcQ6knXWsXXnAEaP7/kOMFHIewnuRzsGxH0EeqtZjvBQ6/R6OKvmtvXKYQDLDNJkvP22RyPFUfaIu1fXLD93AenceMv1Ouv1EL9mCOmPkswtswl1wBv26NLuvTFWKTYgrz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6Ll7cs7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Ll7cs7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so34731355e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788279376; x=1788884176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sg3qBeJDPejirqtBPfSpWtNEMRQUM5xEwb+IRE4corw=;
        b=p6Ll7cs7LZhhhfYhmC5Uq2eKvjhG6DnFGcHMlrg38mvfkSZOxwu/Illqe92gXn7oDK
         ujRNKiY78StWqYXY40H7+isDnySn53TgaiCbMJXL9NM/A+Fuii3u2ybmwht+oFvWPG7W
         YO2v/BJfs5fe0U0z6IEZ4OJxTejoq4/TwvLonu4H6DRNXLne6UncaZ8d83PDGupQuQEK
         9gsXQSQlUfmgWQDHHoPVwbNwKbvpIJvy0rM/8oc2kShiVTzjyQ2bk+LKTczxpF0CHCad
         1JXRky/rGUXYn3UFAPLjqagDYQwIS73DsIa4pwDS57VTGwjuUuvm50OUF4ugVpnAVQAH
         Dt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279376; x=1788884176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sg3qBeJDPejirqtBPfSpWtNEMRQUM5xEwb+IRE4corw=;
        b=THdSJQiLQ26OS6oTmTeyG2Ofgb7Oo1TH+muJ9CnudzMyG729nKMDz55xMSpR0/AsNa
         8l3TyAM/uAGqjzB+0Vuydq5DidGYrI3gm+DlV9/K9PfZIWCfquXH+otqv1hAtxRi+j6v
         WaglcCDKPQg1o1c+XTYb8TCvSefsCjpqWtR9QJ3uTa+aBwF92+BGifYLWOQhttNDMrkO
         IRDwZUlM+LumIvoUrnPscp/h+S+BRzqPRgZZv/Xjg4Uhp9Z5vrFSdTuWjebWfaxP0mRW
         upAZCy/ufqKNO+Je4kUerRmgCIS1fMKFDWb3grkJMvbTD76FdxNbOpve4Ss7bkgvlQTF
         TsGA==
X-Forwarded-Encrypted: i=1; AHgh+RrmjtE03cY7A3LsD495KyZZcX3tjOfkS+8BcPZRSvUfwIdkYQSZGLbhKixp6i2/jTmpZVTYuggrQnn3qHSP4nGMeb9PXqE=@vger.kernel.org
X-Gm-Message-State: AFuF++lduOSRdE3rqEueotBeEcGulG65MJKtmCo/jyGfe0rHY5W7fxD3
	iWF/YemGoN6jCeN+y/Z2hXls0fwNPnoum48P9gGLHe1oKOHCIlC6/KPW
X-Gm-Gg: AR+sD137gn7Jzl8HNxvVushDF2A7wVHfKGhs6+uNjnsc4Q1zHrBrmxjzHOOHqALNmHn
	KD767i/3LBaaeriTsMA1W8sp4ppCEBKgoUEmTcB/yjcejT0NaKICGPiymFONTPzM5y0fogNvzds
	HVCRuuXkG0E27/eI7uLu9zf7JzGhh8NY2kH/iaw6SU8AHq7ZUdziOS621pA6mlUQag+R5eR9beX
	LNTgddQkGmla2hjsmhCBOyRHPDpEs0tU+PYyLEWwIvHGXdZ/oGvxZ774jNk0BgWhLNlRiLyGSxt
	UxMlKZY5k46+uXeHMujA/a1TuAYQqxoOxCAEJMCeRFd2m73CIOA5Y9vIGDWy+dPppPM5uyimaO3
	s7aFNVtWMXsP+opkfI4ZUKXfYhtEpz1Ka6D8ex/2cE2o0m70d0f87R4BzT0HJhqsIztg0O65/fw
	vrGMp9+iRjlPf59xjreo0AKoCleo/QYBC91OXQ/z7fQgltYpdIZL+yG8L7v4ZuwW380DSBBbv4/
	tHF+voRWt1JqgJycEj1zsKDFvk4NJ07RqlvBF8/v3+3cMEPJgHiRyNWCJueBZdLX4uZhXOti/JI
	JMqwGq9G6iGOZgIuUXGh0fh3gbalf9zqm0gPgFjGJFzGnUwOTjXPJ9hJKpmm7px1T88K0ThRFYv
	s9fUSlw==
X-Received: by 2002:a05:600c:c11c:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cdc422c5bmr176732735e9.2.1788279375445;
        Tue, 01 Sep 2026 09:16:15 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce365048asm17915365e9.5.2026.09.01.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:16:15 -0700 (PDT)
Date: Tue, 1 Sep 2026 18:16:12 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: set persistent keyring timeout before destination
 linking
Message-ID: <apb5_kMgDxSIviWb@gmail.com>
References: <bb0370340c671.1788111790.git.kmehltretter@gmail.com>
 <apbTc9BisLTqBaE_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbTc9BisLTqBaE_@kernel.org>

On Tue, Sep 01, 2026 at 04:30:27PM +0100, Jarkko Sakkinen wrote:
> > Tested with QEMU 10.2.1 TCG. The reproducer set
> > /proc/sys/kernel/keys/persistent_keyring_expiry to 60 seconds, restricted
> > the destination with KEYCTL_RESTRICT_KEYRING, and then called
> > KEYCTL_GET_PERSISTENT. No LSM policy was loaded.
> > 
> >                       syscall result  /proc/keys expiry
> >   i386 baseline       -EPERM          perm
> >   i386 patched        -EPERM          1m
> >   x86_64 patched      -EPERM          1m
> > 
> > Full kernel builds completed for i386 and ARM926, and for x86_64 with
> > CONFIG_PROVE_LOCKING=y. The x86_64 reproducer completed without lockdep
> > reports, warnings, or bugs.
> 
> Please describe this in the commit message and delete most of
> the text it has. This is the motivation part.

Got it, thanks. I'll shorten commit message.

I also found a narrow race if linking is delayed past expiry and GC runs.
It is unlikely in practice, but reproducible with an injected delay, so
I'll address it in v2.

Thanks,
Karl
