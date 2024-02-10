Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EE364C7
	for <linux-security-module@vger.kernel.org>; Sat, 10 Feb 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707563184; cv=none; b=DBV0jP/cUFZ1fV92HiUXPl1UMkiyKFs0l1BWJC5PlVHYCpt/3aE6iW1GIaRHd4NZKHI6+j+ctqVz5+JeyWcKxFAVrHrLe5ue9nZS+RgI88ujWWrLrsGtHqkphYbiBnplSdZpqXXl5c/+2J90BefezXBdfQGTfKNIdJOLycac21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707563184; c=relaxed/simple;
	bh=q6R9Dxp9XzRCAe3AIXlnKvr1MTND2zL+bYegg47mQio=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=T5yQfuYk6sVL73gMm1q6Gtrt4/2eT98EmLzjL/JTTyQZYqgfE/NI5ld/mjdxIgunJkb4rd2zwFKrT0KilAqnIhubA3toso4O3NSpFB/+yw2/81KUYqP18I5ksVfK85EfOwL5XOXcoQSD2PZMd3r1BpTkbSZjgXPS0UtpKtx5S3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfNKM3Vk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfNKM3Vk"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so28540727b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 10 Feb 2024 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707563182; x=1708167982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KInMdzVeBDmgosyWgBjsNcCjnvmlynJbWBwpS6R9HwI=;
        b=TfNKM3VkYBuVCCk+AEgGeLaC/rQJcJanCrGOTWw+gFADczMIm28BIjdeOaH6CU0JU3
         Ha1BQdI9arj2xpx4M5D+Qi6gII0eKM6alUWcZPM1A8Thd9R4TkqT2um+UbnzARcmyLsH
         zuvcFOQgYq8+Tq1wDDQKKX632UFcs+CXE8DZeZxcvZxFtJMWpcj1ucRlWXlyFmhvDRfe
         bkFF8CkdvJfCzypXhsAfXQiH9SfCjktxOzgipa7kNK/Pup5MokkgnBNJFElN6cV9FbLG
         UdFJIwdwvsPB7nH7PTGeep4RXaCGIAGLkHpZRonMuQ1Xxn8GJXj/J4Lbf9zBcTrUa6xf
         WMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707563182; x=1708167982;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KInMdzVeBDmgosyWgBjsNcCjnvmlynJbWBwpS6R9HwI=;
        b=AwtsDZuDu6oS0GvkybCwi5Lw+K/AUUtuuwg3CWWJ1Q6iEvc9DahPs/xl2HgdOH+Jqz
         44PGSO6zdVfUvlngo9jAvrX+s3jmCc8eX7k23M4nlTQxoTzUvEWb7CmfckowCK0Prot7
         i9xcsiPLPJ8F8jXupIgA4JBlY3hSYopFaQQy2OYPfcuZ7F0zoFbLgiiXahvMmWJyBUj9
         4ZqKFDIouxNuYlUooEZE5rwgBhOTIKNBI4tUmDFBTNotl7jDKAEQocce4wfJ6JipUHW1
         yljxT8Ng/3lmYRCRlYKYSJ2HbI2zlqryuyx5U3mj9WnyELvOhK1ogDukSuxF5J6ssZNS
         qwdQ==
X-Gm-Message-State: AOJu0YywS83cLrq/baf0fv25oMAtmOQGIgqySny/1w3YP+pyHrv294Pk
	YuGLHaBKpQGek41Em5dQUd3/BODtAt4AhHRdHfNzHZEVX6JMmf5BP+HRg+b0C11qCMY999+bIUz
	fsQ==
X-Google-Smtp-Source: AGHT+IFuOodpxJBLEifNcMokBGsEGZaB6PYGGbO766bXy0w9xeo7yCX85IJAKKx8+Dxhi/AKzVejoYF62Ic=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8d33:f17c:2f0b:c8d9])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1148:b0:dc7:57aa:d8f7 with SMTP id
 p8-20020a056902114800b00dc757aad8f7mr34401ybu.10.1707563182477; Sat, 10 Feb
 2024 03:06:22 -0800 (PST)
Date: Sat, 10 Feb 2024 12:06:20 +0100
In-Reply-To: <20240209170612.1638517-2-gnoack@google.com>
Message-Id: <ZcdYrJfhiNEtqIEW@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com> <20240209170612.1638517-2-gnoack@google.com>
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-security-module@vger.kernel.org, 
	"=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnd!

On Fri, Feb 09, 2024 at 06:06:05PM +0100, G=C3=BCnther Noack wrote:
> Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> and increments the Landlock ABI version to 5.
>
> [...]
>
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 73997e63734f..84efea3f7c0f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> +/**
> + * get_required_ioctl_access(): Determine required IOCTL access rights.
> + *
> + * @cmd: The IOCTL command that is supposed to be run.
> + *
> + * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_io=
ctl()
> + * should be considered for inclusion here.
> + *
> + * Returns: The access rights that must be granted on an opened file in =
order to
> + * use the given @cmd.
> + */
> +static __attribute_const__ access_mask_t
> +get_required_ioctl_access(const unsigned int cmd)
> +{
> +	switch (cmd) {

  [...]

> +	case FIONREAD:

Hello Arnd!  Christian Brauner suggested at FOSDEM that you would be a
good person to reach out to regarding this question -- we would
appreciate if you could have a short look! :)

Context: This patch set lets processes restrict the use of IOCTLs with
the Landlock LSM.  To make the use of this feature more practical, we
are relaxing the rules for some common and harmless IOCTL commands,
which are directly implemented in fs/ioctl.c.

The IOCTL command in question is FIONREAD: fs/ioctl.c implements
FIONREAD directly for S_ISREG files, but it does call the FIONREAD
implementation in the VFS layer for other file types.

The question we are asking ourselves is:

* Can we let processes safely use FIONREAD for all files which get
  opened for the purpose of reading, or do we run the risk of
  accidentally exposing surprising IOCTL implementations which have
  completely different purposes?

  Is it safe to assume that the VFS layer FIONREAD implementations are
  actually implementing FIONREAD semantics?

* I know there have been accidental collisions of IOCTL command
  numbers in the past -- Hypothetically, if this were to happen in one
  of the VFS implementations of FIONREAD, would that be considered a
  bug that would need to get fixed in that implementation?


> +	case FIOQSIZE:
> +	case FIGETBSZ:
> +		/*
> +		 * FIONREAD returns the number of bytes available for reading.
> +		 * FIONREAD returns the number of immediately readable bytes for
> +		 * a file.

(Oops, repetitive doc, probably mis-merged.  Fixing it in next version.)


Thanks!
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
