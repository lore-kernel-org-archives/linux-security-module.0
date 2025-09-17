Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E01D54FE
	for <linux-security-module@vger.kernel.org>; Wed, 17 Sep 2025 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069298; cv=none; b=aAwqpGu054yLmBX7M6/SRzyjn9FJChVeZhTU3TMwDKo5jrKDDjAjbj4LPLHHy5fz32tHyxRf1OyCifD3wfMYASHB9hTg2j6+hdQWWvfSZZVdTUsVKDzf5m1fdviMDTUyYnOmTzA2M+Z378cwIupEKuPHCgk1v9Rn0ordHdjHQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069298; c=relaxed/simple;
	bh=6/rB1l/eXWHaa3FIjR4b9vplzipgbYUFKcxcVcRHxEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EySyyC1noDfWjqcjGDgAHbZTvoJkQuqCR/xTJdn9nMCGZ6gFqJTyKtlDGM62PdIr4hsaVepa+HqXj8mgT2Va0A8N0HNqpaxevwhhjGfc8i4eVPA+qH6bpcXUKRx2sfrP6wXrAnq4w0/RTDWcE5TLIvL60lAYovfGedO76Bz7SGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhV3CkUR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhV3CkUR"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5694f0e29a1so1628e87.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758069293; x=1758674093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AF9Zf/ufENcHrKMvHlrpWPSseQ/RzWNQreOKhevrxE=;
        b=OhV3CkURQqmcrRTl0ac29G3gbVj0iibi6GClojK388ma6gLPbjDN7Kwz2j4bi5Ou8h
         D/xA81kVVIOcxJZXPglu7BNbzHxNBRKbOfSJY+TJXYrCAQ9bigvXoM9o9QYUClqQVNr9
         0PiqN5ybujC6Q8IDznsHQkR4a7ileIqbxdG4mjnrIRmlpT2LNbMmoDhbc0mFVro3atQu
         Xo8JIAk4a8kn1ZvmZKUeXq8SNRtM18HA+BFdEfkjLOfydOPG9NBAg+tkmCq+sskKs+wW
         mmdkED0nVPqvMZqRe31VQAb9cNmswsEZbgWk6RFWSIZuhGOXPR1XHDSmkS+CVXATo+GS
         OnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069293; x=1758674093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AF9Zf/ufENcHrKMvHlrpWPSseQ/RzWNQreOKhevrxE=;
        b=gOzhkpJW7e6aWhp/bAF8Uunrv1bCE/QxLqG5ccfpEDoiZ/xBaNKmS5U4gwXntE/Sga
         PTf6aKfCe8anrdv6J4pLSra5oOxdKm1iD1LdXtVW4TLSIWjMBEzSLnW9BbMfj1S+qTge
         R4h20ugEHCOMfM5ysx3VwFhg+/fItdrG9nNS6laQTLLNrTXSlwy6kGH4/Oa1JXPTHxH8
         8/Jzw7n3mhDkoP1CjbHHSve9ZWzmoGFgMlCeNGchGbOD9x0J1teHBUzRsxS5X1EBFoaL
         3z7I2GUbGHj0pMy/mFJABVWflUWuKywfQN/pQqdzi30ZOHWoDGmh1vyZaq4RVG20aeUZ
         6GWw==
X-Forwarded-Encrypted: i=1; AJvYcCVX3bBwge0FybIhoZ+JlJ3y5N6ORUR0iXwKDhTT2zaul7LMe4ukx3awkrM4ar+ohk/VGpHHnJ1R0VF+zhy5wzRHlLhDT6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMg3WNoJSc9TsIJIHjJBGsdJe5sVpeq0Pq9e/bSwsqFjpbUlyP
	3ch/ruwWaC4NN9WQ+JKfV0EHFRHZzxV5yj2cHQ6wfMWfONK9LaqqSlBpHW88QLdmDN6pMWbRn67
	AcKfuhOmLxrz30CyxrWv5XSfsxkGBs1p85Q4wtfP5
X-Gm-Gg: ASbGncv+alktxMoZWpel6CAn3E33cV1sBo1sD+YPMoeKG+NNUaydoBMx5VGWlRdhc4j
	bnTvuz5Ik413ionCKm+Hd7QYTRjUqDG+dvTLrEwNCci1gK1+hi/Y2zaPzwxuUDdhzTd6Ld4a/RB
	QMT+BcdNGCliHYpumOWqUr37afDjQ+K0JExVg9ntT5Tc/A2YrotLy6P439zZCRZmmGFuCg3xZCZ
	oy2Vm6PwW9jvGj6DjovLiXRb8/5j+nIxTuyxY0NdaJK1FYQ+qo=
X-Google-Smtp-Source: AGHT+IFcyjJzZ4NT9Tir+GT9MJKYCt97IWoZnmQP2gWhP7KEs1D5HqDovMOSpMabAp7PkDXB7hRvrieMLGEHtt4HWvI=
X-Received: by 2002:a05:6512:61d0:10b0:55f:6ac4:c3b2 with SMTP id
 2adb3069b0e04-5774cebae57mr183502e87.0.1758069292874; Tue, 16 Sep 2025
 17:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com>
 <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com> <CAHC9VhQejS05C8AExkh32GidBdzXjauKPP6T_3eSGZDEwfwDuA@mail.gmail.com>
In-Reply-To: <CAHC9VhQejS05C8AExkh32GidBdzXjauKPP6T_3eSGZDEwfwDuA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 17 Sep 2025 10:34:34 +1000
X-Gm-Features: AS18NWBUShakTwgjwy447Q25zdtRhMIo7Iqnzp_7z4P3lmEl_tUSeuf2NkCr0RI
Message-ID: <CA+zpnLe8Z=2qY3rVCyZXyGPOaO2a0V2BVrdMkuwKs789igGCzw@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: Paul Moore <paul@paul-moore.com>, Hugh Dickins <hughd@google.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:26=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Sep 16, 2025 at 1:07=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > On Wed, 3 Sep 2025, Paul Moore wrote:
> > > On Aug 25, 2025 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <twe=
ek@google.com> wrote:
> > > >
> > > > Prior to this change, no security hooks were called at the creation=
 of a
> > > > memfd file. It means that, for SELinux as an example, it will recei=
ve
> > > > the default type of the filesystem that backs the in-memory inode. =
In
> > > > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it w=
ill
> > > > be hugetlbfs. Both can be considered implementation details of memf=
d.
> > > >
> > > > It also means that it is not possible to differentiate between a fi=
le
> > > > coming from memfd_create and a file coming from a standard tmpfs mo=
unt
> > > > point.
> > > >
> > > > Additionally, no permission is validated at creation, which differs=
 from
> > > > the similar memfd_secret syscall.
> > > >
> > > > Call security_inode_init_security_anon during creation. This ensure=
s
> > > > that the file is setup similarly to other anonymous inodes. On SELi=
nux,
> > > > it means that the file will receive the security context of its tas=
k.
> > > >
> > > > The ability to limit fexecve on memfd has been of interest to avoid
> > > > potential pitfalls where /proc/self/exe or similar would be execute=
d
> > > > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vector=
s,
> > > > similarly to the file class. These access vectors may not make sens=
e for
> > > > the existing "anon_inode" class. Therefore, define and assign a new
> > > > class "memfd_file" to support such access vectors.
> > > >
> > > > Guard these changes behind a new policy capability named "memfd_cla=
ss".
> > > >
> > > > [1] https://crbug.com/1305267
> > > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@goog=
le.com/
> > > >
> > > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> ...
>
> > > Hugh, Baolin, and shmem/mm folks, are you okay with the changes above=
? If
> > > so it would be nice to get an ACK from one of you.
> >
> > So far as I can tell, seems okay to me:
> > Acked-by: Hugh Dickins <hughd@google.com>
> >
> > If I'd responded earlier (sorry), I would have asked for it just to use
> > &QSTR("[memfd]") directly in the call, rather than indirecting through
> > unnecessary #define MEMFD_ANON_NAME "[memfd]"; never mind, that's all.
> >

Thanks for the review Hugh. In our case, it is necessary to expose
MEMFD_ANON_NAME as there is a string comparison done in
security/selinux/hooks.c (see selinux_inode_init_security_anon
changes).
I would argue it is cleaner to reference the same constant. The
alternative here would be to have 2 copies of it, with the risk of
them being out-of-sync at some point.

> > Please do take this, along with the rest, through your security tree:
> > mm.git contains no conflicting change to mm/memfd.c at present.
>
> Thanks Hugh, it turns out we ended up having a discussion on the
> SELinux side (proper return values for error conditions) and I'm going
> to hold off on this until after the upcoming merge window to give time
> for that discussion to run its course.  The good news is that gives
> Thi=C3=A9baud an opportunity to do the qstr fixup you wanted.
>
> Thi=C3=A9baud, are you okay with making the change Hugh has requested?
>
> --
> paul-moore.com
