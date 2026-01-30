Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A72D3231
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791713; cv=pass; b=VcqIcYEBP10zY9Vtk6gQQQ02knH4ABSXdhwgU5skfh0uJj8MY5iSo3b+nP+quTqwnFsd8mduAv7T4mfA2szHeMgDN4Baleoq373DtnL8TP5Kl9JC1k61dQnFElDKSH9N2wZVyvyQASl6mLTsKFUUdJH0/xb05t1oKbMYesHJGJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791713; c=relaxed/simple;
	bh=WAJpcrwcx4eEP2gfm7Q0AJYgp2N2Wzxsc25pp47pirQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fM/E4Ek9NEUD+ZyJCQlnkJoOD3Ss4BxEYoCHzCqaj3YPS6ORBiR05DhfPIweZnL5trT2P6EzWGoupqjT/BRuv4wKCQNoCTC53t3BSWuL8mvG2yMPIvhh2e0ZYRiTXZIGt+8E/ubfg5zOU2H4vG/eAfkGCbLaM1L0pcOpSlvYlEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cP96998R; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cP96998R"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0834769f0so15647045ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 08:48:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769791711; cv=none;
        d=google.com; s=arc-20240605;
        b=HMDPnriFl3iUV/0a3OObDOcq7Q3vETGs523URM5sFGfiWG8HNpBEvveGjLmTMUinml
         ekDKsu1QpdU31lGqiwt+0qgCfUK0xEF/W6s+S89ObEp0/soTiF6v2+opEjJZDgeWYRkz
         exhyQkg9l1tbJ/cX6wD/qkeNWs4ZKTWJYUpF8pqapIRCq9aJXZ9oXHUQh8y5yE1UliCI
         88iHY4OUf18q7/5NZSKvs2KRBr9uU/G79ViJEUUvWQhesrhxcX7iJcrwf1cha+K/Ima9
         m3tyW4rxxP8a4yZINA9/FTwWJBtoAEFHKD+s3lBgjuXKNwb9kyxjHXrZPTAPsGMUmvp0
         y2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzBnHIH7LnjecF3bPO9bEFfJeYSW4F3Z6RvyBhoZ3M0=;
        fh=3JJuTFugSKXyxSk/CUlIYsuGvbWZBwoWsQKPLMxy4yk=;
        b=N1R498wxjPbY0duHUKj74OOwtGa2QBYYx6ealXQwQoSLWiv8kFOUMyiyv510n31f7n
         GpQhn4xIuqdFzdT0j0+0XNCaXe9yqi+Z7V3xrIbrBlBSFEduHzRCU9AWBCD0WQXN2+gz
         dsH5rGHj3Yly/eYdQPDwyIpaQGwc6kTQttMZUE29CKDUm44qyknku2MdM/TW+x66VlId
         9X3GLSHtkwWGiA5FON4P/Rw3KKwgwRPecL3uL3NmrtbEApx7IXuDTJ2F2zz+5TtRRPul
         O3nEgboQlZ08sVZ5D4kuY41emfVl462CTUXaIp7Riehn/dP40i2rj8/UTLZngez89CuY
         nDpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769791711; x=1770396511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzBnHIH7LnjecF3bPO9bEFfJeYSW4F3Z6RvyBhoZ3M0=;
        b=cP96998Ro3vZl624iZR8DgsdpnCgon1+wLW3uiGJUE7ei1ymxVUg0HrnEGFCpYUquN
         r51O9c3TdvjD33RTX5l20mUvHx3eJJvzHOk9I7+29eKubrH57Ah/8UJLQQWuI1zDjuqG
         PKyH4XDTsibHZbsbluYX8c0IFnBHXtxvu5c76R8GjsGAytAmRsDCmalL47f907HxB+M5
         6TlclK8OcyYwjnQYKYdOJ5GcTkdBHWirgh2F9lhBiRtBZthFxdY88zP3hX6D+upHzhXt
         Unq8tA/rrHKEFXOprdIE7+R0ahjzBaCUQFY5t28I1PRWbXOt4NmkooYqSKcYfB9CeGQf
         p30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769791711; x=1770396511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzBnHIH7LnjecF3bPO9bEFfJeYSW4F3Z6RvyBhoZ3M0=;
        b=i433Pw/2kOXkO6kJCNstvwLpTpAM/1vN8VB8dj71RblJbKx4md2OzMnC4qkiQz503a
         B81POC2oeTqt4NSv1kCgWXV3IaUzZSddU5zbYg/vFhTFqTXyDZgGq2CvnqkkQBSir3WU
         cVmaR7O7n1F/8+HblLVrW/qUMEpBhwd/pd6E5RjRDv/EAV88UdAeyi2DAoLh0TQui3os
         75x1JN56LSoxZoZdYF77OEeEXrh1Mi+VznRqOSeQnPe4ZS41s8jV8dKBCfU5kxDLTrA2
         wEPkhpJ41WrKa2tIXAcB3mn1gaoy+dxmQ4IRdPG8fT1s3WOLhte5PAbaH9BZRab2Qays
         jaLg==
X-Gm-Message-State: AOJu0YwW2EF/vHtt0DqMI5h15vmjgchlf1kgpbX8VR4aUcOdbU0dkpjh
	/2B5gt5d2y6bnC8gNp0eZNXuvyenY1waR/H7uHi0qeq2/d0abrzm2HuhWrbiQwAXOQ9ukNy9CR1
	LYwAVQPb1AixTNVWtirbO6t5ffEPubP0/Le6v2vLK
X-Gm-Gg: AZuq6aI9KE8AkgdClXsNk96G2pCLG2qYtRENxDcMDmzHC/Qx6wznhU3MADrY39bOB3p
	PQCcZobenCCJN67Q1/NQuKtt5erjuIKvJVGFGTZGD/g1sPnvYYPTOof97xpEVswLuG6Na1dvxr4
	7Bveifg7GlPFYTkQluT07gIinUNTJvPmvzySqrrzunL6NfGC3KC7awiL9LxD0R/d4oUSJS/zd/u
	+nnM6K4bawqr9mDl2Caih1yFlfjd8iNHYAk0HI6eYIvoSXzaOfzc9c2ejrKjkS3Y/wIG7M=
X-Received: by 2002:a17:903:2b04:b0:2a7:9e5a:a516 with SMTP id
 d9443c01a7336-2a8d990b710mr38647195ad.28.1769791711048; Fri, 30 Jan 2026
 08:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129225132.420484-2-paul@paul-moore.com> <202601291730.45120C1A@keescook>
In-Reply-To: <202601291730.45120C1A@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Jan 2026 11:48:19 -0500
X-Gm-Features: AZwV_Qh4Ohkl16EgJ4oaj21z6gSU8EcMXzEt-HgB_8gRApB5wUnJP5Smmit89ag
Message-ID: <CAHC9VhS77c1-5HTRUVXV=e2Z7Q3wHeo_e8S3RswqGWLTB0_ZhQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 8:31=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Thu, Jan 29, 2026 at 05:51:33PM -0500, Paul Moore wrote:
> > While reworking the LSM initialization code the
> > /proc/sys/vm/mmap_min_addr handler was inadvertently caught up in the
> > change and the procfs entry wasn't setup when CONFIG_SECURITY was not
> > selected at kernel build time.  This patch restores the previous behavi=
or
> > and ensures that the procfs entry is setup regardless of the
> > CONFIG_SECURITY state.
> >
> > Future work will improve upon this, likely by moving the procfs handler
> > into the mm subsystem, but this patch should resolve the immediate
> > regression.
> >
> > Fixes: 4ab5efcc2829 ("lsm: consolidate all of the LSM framework initcal=
ls")
> > Reported-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Good catch and fix!
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Merged into lsm/stable-6.19, with plans to send this to Linus early
next week after a day or two in linux-next.  Thanks everyone!

--=20
paul-moore.com
