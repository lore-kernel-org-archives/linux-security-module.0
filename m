Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15712C534
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816251; cv=none; b=WKrDvrQsaSSH80TQ0FX29NBuj3CRGvYPXuGd5R5juae/EyH6UNMmMTAN/ORQENYrbpafS9UVnqeIdnafrVLwI3JFBESv7XNqeqsh6iURtMhOoenRwYf8yyDq0bbcplbJGaamp7wDHyY4Ui/Hvc+G+I4XhOO74NnSyuhbll5vUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816251; c=relaxed/simple;
	bh=RJdyXZLNvnH8cN9wPXjrAPOlXdC7e8+6kAEh4RhBejE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmfTTsy2C9H+3cmCLgsnUdyA4+KLsMsCBxrFyzFHD5xo8WuUqCHiD73JX5CIzbonoVWPDM+MR1i7krD5fYfO7TZw/ArjZSkZExvtHwZYszgXY1vCisg64lFOH6SP1zxEkQwwSkOuZWTvYW4YM65lLJ8iikSw4ndALeHiZqFVryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAo2UX58; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAo2UX58"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a45a90e1661so59672766b.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709816248; x=1710421048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBW/1MEz6JNZVrnhcpxVAwMPPAr+vdVKO2wgbn75mCU=;
        b=EAo2UX58MvMc9Wbtba/wMaNJ5Hq3S/5wWGr/Q/BSzmJAAYbXl6j/jZc7pDC2cD8GF5
         HWt6Utz/0l5PHLQRDXfDyaMcFxvgg14/UMILZs0ivEJm4ZaikxD7KhaILl3UzaQw8+Mu
         bDX3y5WTa2n42jdg+DMPyRj/2aBEANwnVNyUxb6Zhant0lnu7gxSDuDU+SK1Aitq7+1N
         mKmmdrf9YzpNq73NAthR5/Gz7tDkn2o3EdHSv7FZgzkReZ1oruwEU2VkrpK40Pz8fpux
         kKp/XvjZMV4abeKSn2GkbVI1xIhqMyiQBpi5dmfNHlUNyf08bbJAaldb5oB8S09FCXsW
         gXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709816248; x=1710421048;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBW/1MEz6JNZVrnhcpxVAwMPPAr+vdVKO2wgbn75mCU=;
        b=gpEEDjA9l7n6ZthrdN6/18FXefSKGOAPdvp68cqu/wMqSR4kYGg1ZVZlWhAmqH/Q81
         Hbl+dLf9Z8XbuXWjZ6+5a+tOpJModBZ/Abg7yh0kBJRW8dv1h0Lwavzh9lbhjNaC0Ex8
         38m/Y3jufYJB2ObK9KghzfiE2DoPGxWVOU2RzCga2QJK6cOVEXZXEzICjTt358IfvlDS
         EW0345lYZShjI9w3Gh5emNgUtDWxpqubaEEXOlS5+V3kaAp6SjsjK4SzwmYQjV+rYKGo
         h+EQRLjsU4OsJ8fH7+SbfArxdO7bJyJDP+Ouluhg7YklY5mckv5/WY67gHpbSDYAXcy4
         GrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtp5n8zG7UxlKf+dhI9ITuffTocUoxL/vL02E11z/wPCArvcS9psYCL0ePkL5HCX27CYR6fAqy9f2mJuPQa2t0+mgDGdI+CB+2ebNUQ8+UV32Mouk5
X-Gm-Message-State: AOJu0Yy5Mj0waCPk9Oi2k54eu16VIQKLCneDW/+Ff4HUP5aa+lR6BHph
	mtuamliVMtqBSr0IbjQFtZmro71eJMy8V7Z/d7iySX8Bh2egCXetCuLw7R+J7JD+Z9PG5ztZ03V
	lpg==
X-Google-Smtp-Source: AGHT+IHjqHWp2CPC7ca+ld5dxvSKopEz7nwEwKfTKFdzg18uJSgze7bS6XZR5A4/Au9LDR+Ykn2ASs8lcXI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:1c4d:b0:a42:ea24:f8b8 with SMTP id
 l13-20020a1709061c4d00b00a42ea24f8b8mr32093ejg.14.1709816248127; Thu, 07 Mar
 2024 04:57:28 -0800 (PST)
Date: Thu, 7 Mar 2024 13:57:26 +0100
In-Reply-To: <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219.chu4Yeegh3oo@digikod.net> <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com> <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com> <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
Message-ID: <Zem5tnB7lL-xLjFP@google.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 01:21:48PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 13:15, Christian Brauner wrote:
> > On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
> >> On Wed, Mar 6, 2024, at 14:47, Micka=C3=ABl Sala=C3=BCn wrote:
> >> >
> >> > Arnd, Christian, Paul, are you OK with this new hook proposal?
> >>=20
> >> I think this sounds better. It would fit more closely into
> >> the overall structure of the ioctl handlers with their multiple
> >> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
> >> you have the same structure for sockets and blockdev, and
> >> then additional levels below that and some weirdness for
> >> things like tty, scsi or cdrom.
> >
> > So an additional security hook called from tty, scsi, or cdrom?
> > And the original hook is left where it is right now?
>=20
> For the moment, I think adding another hook in vfs_ioctl()
> and the corresponding compat path would do what Micka=C3=ABl
> wants. Beyond that, we could consider having hooks in
> socket and block ioctls if needed as they are easy to
> filter out based on inode->i_mode.
>=20
> The tty/scsi/cdrom hooks would be harder to do, let's assume
> for now that we don't need them.

Thank you all for the help!

Yes, tty/scsi/cdrom are just examples.  We do not need special features for
these for Landlock right now.

What I would do is to invoke the new LSM hook in the following two places i=
n
fs/ioctl.c:

1) at the top of vfs_ioctl()
2) at the top of ioctl_compat()

(Both of these functions are just invoking the f_op->unlocked_ioctl() and
f_op->compat_ioctl() operations with a safeguard for that being a NULL poin=
ter.)

The intent is that the new hook gets called everytime before an ioctl is se=
nt to
these IOCTL operations in f_op, so that the LSM can distinguish cleanly bet=
ween
the "safe" IOCTLs that are implemented fully within fs/ioctl.c and the
"potentially unsafe" IOCTLs which are implemented by these hooks (as it is
unrealistic for us to holistically reason about the safety of all possible
implementations).

The alternative approach where we try to do the same based on the existing =
LSM
IOCTL hook resulted in the patch further up in this mail thread - it involv=
es
maintaining a list of "safe" IOCTL commands, and it is difficult to guarant=
ee
that these lists of IOCTL commands stay in sync.

Christian, does that make sense in your mind?

Thanks,
=E2=80=94G=C3=BCnther
