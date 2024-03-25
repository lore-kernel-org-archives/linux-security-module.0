Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574814BF96
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373122; cv=none; b=hqOaQ77FrIKuYoXQSIMDJNhqyJfacO0QhhZr4ibCpZn4LhEeXiGLjPk+uBoTl4jIvratLpzdU0Escvl+DgyP2QsovropRo3HTUKPZuj0385Bt3JuBZqFKWul5eZi1kUg6gsZpeehi4KatKy4jvT7FTwy2s1n2lsAFykn/D8bJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373122; c=relaxed/simple;
	bh=udtrNptnFxbxKqQrX9+mM5Q4/jyDJfWjZsxVyKdxm8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MzCVYszZtwfGdgUMZS8sAT8FzjJa98M/D/12Q3kPxFM7iQafM01z2aHnIk+SfeUNCGEA8ccPYwqNA8yOYKnwUMQnASdRKsHmqT5fhI1OtcKIYG2GZALXSFSNcDOpSkMO0iJq2uPoMv54/Gf7IVaz+DyazNx0mHa2rwhvr2MvR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWawwgNX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWawwgNX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609f2920b53so69610037b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711373119; x=1711977919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUirGja49fq+EfmDjKlBPEUoLvWOsAMP244ZtmR22XM=;
        b=tWawwgNXx70YIQfp1C2vlb+Ms+NvfKDRUs9gWQxOGAuK9RfvPqf4fUbwGaWK8hxFp7
         kMRPBunG4azhnA/TTTLDY++k7xqz7Wbca2CJzTJq8K8cp0pvNkMhRGWjwP4RG5O/j7tj
         uVTGugB8MVY+grlXIijy5a/znOgOSdgzZ6sebAoG1KjAPQIk1sd++NZWKZPUqE+lbsog
         29tUSIW7bMdA/ZCbhdEFFzCrFCK/fnGqT/qFwy9fX2rLG3mlB7Be3oDFx6doyy3PEpvy
         XnYDOThCt9MXcsE+UepwsAWQbuf/DQYu5rcSGLLpyT0S/H9kdXUMNfwScfSbZfJF3TeB
         nbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373119; x=1711977919;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUirGja49fq+EfmDjKlBPEUoLvWOsAMP244ZtmR22XM=;
        b=F2Q9kwcFj6VW9reCbsJjFvPkoRJAScnXPyFtfKnSuKN1gyKqONGaCMjhFbC6kFYDst
         QP+42rtTiygD1jmXlFHR44i9zMUfvS5LqFMdL6t5NVMm+PTdNLG6Fh1Vde1UbFhbREPC
         UdL8n16GQJt+/CSbjLsq+l2rtL8Z9fZ2AnHJuBox/ZQKlubm7wEEogrAnKtJwDOZsT2L
         oHQVynxDsurxwAYR+zZVxJI4LjCtcik/wWMURTFuKcT20V0R/WOpnEmdCLZV07Mn5qi3
         yD+tgQJY0Jc9RixkCBXuMolVl7EZFj5DOupWySBgq9gBW1Z1Q1ksMm6Cnb5UgsYcdDpT
         Cg9A==
X-Gm-Message-State: AOJu0Yy6mk+88nxQOhnkejxCFlrMQdQWXoYpBEU6Lrbys/hIFxclNOEI
	kFqcb7VlRFAQlBhOoFvOs/fV6wBjO0hvA+nZ2tZmPFraKZ9m34hqJJO5Y73v/KQYKWep4eaDkKc
	I4g==
X-Google-Smtp-Source: AGHT+IGZ4GbHZfQqNyfKU0ORm9bHPGuAWEguo10JeYmC3vb/xuHNhO0+53sAJ0STxwXrlIhD9OeWLlMDZ1s=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:610c:b0:60c:ca9c:7d10 with SMTP id
 hi12-20020a05690c610c00b0060cca9c7d10mr1690248ywb.2.1711373119532; Mon, 25
 Mar 2024 06:25:19 -0700 (PDT)
Date: Mon, 25 Mar 2024 14:25:16 +0100
In-Reply-To: <32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com> <20240322151002.3653639-2-gnoack@google.com>
 <32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fastmail.com>
Message-ID: <ZgF7PFWDIxoFdgIb@google.com>
Subject: Re: [PATCH v11 1/9] fs: Add and use vfs_get_ioctl_handler()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-security-module@vger.kernel.org, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 04:31:58PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 22, 2024, at 16:09, G=C3=BCnther Noack wrote:
> > From: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >
> > Add a new vfs_get_ioctl_handler() helper to identify if an IOCTL comman=
d
> > is handled by the first IOCTL layer.  Each IOCTL command is now handled
> > by a dedicated function, and all of them use the same signature.
>=20
> Sorry I didn't already reply the previous time you sent this.
> I don't really like the idea of going through another indirect
> pointer for each of the ioctls here, both because of the
> complexity at the source level, and the potential cost on
> architectures that need heavy barriers around indirect
> function calls.
> =20
> > -static int ioctl_fibmap(struct file *filp, int __user *p)
> > +static int ioctl_fibmap(struct file *filp, unsigned int fd, unsigned=
=20
> > long arg)
> >  {
> > +	int __user *p =3D (void __user *)arg;
>=20
> The new version doesn't seem like an improvement when you
> need the extra type casts here.=20
>=20
> As a completely different approach, would it perhaps be
> sufficient to define security_file_ioctl_compat() in a
> way that it may return a special error code signifying
> "don't call into fops->{unlocked,compat}_ioctl"?
>=20
> This way landlock could trivially allow ioctls on e.g.
> normal file systems, sockets and block devices but prevent
> them on character devices it does not trust.

Thank you for the review, Arnd!  I gave your suggestion a shot and it seems
cleaner - I'll send an updated patch shortly.

=E2=80=94G=C3=BCnther
