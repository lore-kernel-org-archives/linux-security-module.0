Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A6149387
	for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722329; cv=none; b=lo4Uaoz7pdBdINYNy8c/YOiH9+A5ig2t+Ep3y/Re9wEynYHYToOo/r1K7kMipaB6EDbnrFX7vpfhJLInUVGDVcSDoyTAH0wRWMs6QfAbbSR74qFgdldFFCRJ98s81DC2IhVTHN2LnGZIReVSHF3MYPtpaSFV91mruyH/dJtFgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722329; c=relaxed/simple;
	bh=R/+O8H4O8BwAv9+xJIMOzoReW2oS/QadBD8zkAnLLDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYMlFiHY53K/H0sKp9w1Mv9dNG4miM8qhzDEenUH8X1htehY1lK7eE6LybPorDttOil9ePxm428EAwP2dxr9T/qfIo6LDaEmbHzs7NJESsd8+yQN7Xo+M+Q3Rg49GnC9TmW+bo2TfWkXFjOA0Vc1EY1ns9hrb6wGcF8V4jPlL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=McsG/xV1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="McsG/xV1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso950362276.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 13:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708722327; x=1709327127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytWrr/Z6XKokLdRa6LccyRlNuSfIGCRB1ohMJ1fqRns=;
        b=McsG/xV1Q6wYwr0hBiL8gQeBgfp9QLQCnz1I6NLyCHktW9rh10xkCwRtX0St8yoNQq
         /Ht/LQzBV0OaCYUlMiAIDqIP+1fia1PNf1+v8WxJaqCj0RR2bSWhW8tJ0z7evZpeqOL2
         tNnxB0sIaVaqcsLZlXrF8ucmB/4B9FpP0s8xO2XpmqZISqV/ss+MoRARStuh/cO+3/9h
         pEI+WO3EFFlMvbK0cdj0T63DTQXZJRMbHzox6kRF8a3usSaOoMf7EetFZbkgtM0PNvBL
         ygVSJ2UbkD8CQVbEMf+qHwG4N+bol0bNRqYHIhecnSGum/RSz5wPq9OCd4KTA3IEUr0O
         m5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722327; x=1709327127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytWrr/Z6XKokLdRa6LccyRlNuSfIGCRB1ohMJ1fqRns=;
        b=DXHzWPS+krmIp5Srjs8YPk+2HKKUjVN+jMGcq+VP0aFmqTVBngviITutk+KvTc7EVs
         mpXvNT+iLmsf3kMGmv2WT9obw4aAxpHUeXEyiVNS68IU/AvATTv9x0dy/tUVIFnvA1+1
         XzsyzyM0wGM7/zbql0XQRWczWCREpgnBTQie2+L7DGlbBMI7SAqlKDgnuicB75XG+1qc
         jMGv1KWMzw8BRRZ9ZfyiRFJvcdjLyDn5LQlJngNC/UBh1maIsYDdVHCs+njpekSoVMts
         sVI5T+mCtTdV2KlYqunzhkD7AyBxW9rEsssnzoAo05C+rqcIy1RbRzScPfqUu/M1d41C
         /TNA==
X-Forwarded-Encrypted: i=1; AJvYcCV2BRyoRK2NFnoiK1fURnqvGuT/2WGAyMeVm8AW9JQiYq3BaEPRQVi4YyBytW/bBGjZQKSOv3SVIxK3EDdnVZy3ZyEnyk12zA71s8FDzZ1Eopxe3zf/
X-Gm-Message-State: AOJu0YyeaM6CJpWfHeV5KOvmNsmn5QAsVRwx0OCsbYJ1fBonXXg3cOJ4
	dGgU79BWPQAIoS8uNVpsPqjot39FKwjIo2w73DsYv2UFovJeHOfJDHymJ6xSaFYigJndMD0qrLP
	az5kvnODXwy3x9ucPcJbVjoZ1LnlTTAP5Qzbb
X-Google-Smtp-Source: AGHT+IEpVFDrzEuIGmXD+usw6kJRjPirAlh3UAEtBi1UxjtPyCLhEp1Orc6J/F3wzIU5WK49aEGT3jx6+SyrtibdDLc=
X-Received: by 2002:a25:2bc6:0:b0:dc7:6d9a:37f2 with SMTP id
 r189-20020a252bc6000000b00dc76d9a37f2mr1120688ybr.38.1708722327204; Fri, 23
 Feb 2024 13:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223.ieSh2aegurig@digikod.net>
 <20240223.eij0Oudai0Ia@digikod.net>
In-Reply-To: <20240223.eij0Oudai0Ia@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 16:05:16 -0500
Message-ID: <CAHC9VhRdRK3FztE-Th=3M+0ZjCZQJ+5sTiXPwfK6xXX_=SFHhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:04=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Feb 23, 2024 at 08:59:34PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Fri, Feb 23, 2024 at 08:05:45PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > selinux_lsm_getattr() may not initialize the value's pointer in some
> > > case.  As for proc_pid_attr_read(), initialize this pointer to NULL i=
n
> > > selinux_getselfattr() to avoid an UAF in the kfree() call.
> >
> > Not UAF but NULL pointer dereference (both patches)...
>
> Well, that may be the result (as observed with the kfree() call), but
> the cause is obviously an uninitialized pointer.

Adding the SELinux list to the CC line; SELinux folks the original post is =
here:

* https://lore.kernel.org/all/20240223190546.3329966-1-mic@digikod.net

Thanks for finding this and testing the patch, based on our off-list
discussion, do you mind if I add a Suggested-by?  Looking at this a
bit more I think we'll want to make a few changes to
selinux_lsm_getattr() later, but this patch is a good one for stable
as it not only fixes the bug, but it is a trivial one-liner with very
low risk.

I do think we need to tweak the commit description a bit, what do you
think of the following?

  "selinux_getselfattr() doesn't properly initialize the string
   pointer it passes to selinux_lsm_getattr() which can cause a
   problem when an attribute hasn't been explicitly set;
   selinux_lsm_getattr() returns 0/success, but does not set or
   initialize the string label/attribute.  Failure to properly
   initialize the string causes problems later in
   selinux_getselfattr() when the function attempts to kfree()
   the string."

--=20
paul-moore.com
