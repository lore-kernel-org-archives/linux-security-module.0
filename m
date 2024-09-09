Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885B13A3E6
	for <linux-security-module@vger.kernel.org>; Mon,  9 Sep 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897806; cv=none; b=pTD3Ewp6Tb1zPl8KEEqgU4h7tJAEWcOHTMyxjt3Fwj3PybiXIdkpPC/OLXXAH7SoPtj597NVKchmYMkTJ5uRTO2/2g5FUkfKnLV6FkQPHp/CBuZA39ky8+xUwT/JBXyzrXZjVz6PXJpxxVv/IRxHqFWmM6r274WVLJdRauK2bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897806; c=relaxed/simple;
	bh=UD2ljjMyeCTiG/VAuf2toxKpwa7RSFcC6BIY4yWZNYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gswgyxI7xgEEBbYbA27DFoq43Tlwdk2BgkYG+lgJx3WxnceyVLHTP0cwDR1cOHddiLf8z0ZAebUuwXPuEfYJmIk99JgnYoopwCv83lTIWAK9C0dtrljO0TOzAOsb/EH5j+ykRzLtXWFDAZLR+peN8JwTlWQ17K72hecIsrci1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dLprfjyR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dLprfjyR"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db5abe2cafso17162247b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 09 Sep 2024 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725897804; x=1726502604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmLD+KoyfTyy43xEOB1Jl+N/7L+1hOh+6Y9O1otzjvc=;
        b=dLprfjyRK5uq/nYa80qxz7L67vNzBIztE3iaw1kXiHeXiEE5qUJdJs75Pazd4Ox3sM
         dnMBirVg9XDN4x6GhnjpCPlX7KNMnbrWkNTGUZpF7yg08v8vO2CgBMNXyQnr1b/mlTJk
         Bowjjv2X/4cBI4Dpzh+z8WKsw1c0HLlQtrHGjQ/J/Qzs8KwmyG0TF0dQAGIcW9ykro43
         lzVg3iGS4VKQ7iNL4lgDPnjQccev9SA7jijY3NH6rUhIH6W9xJ8zTYdUXe8vbhPSS1f7
         z/Xzfd5cEDmsNpjEXFHdbn6JILcL8ngh92frrPQsDWeZGfb1lEjPeMiGpSxJqV9LR7xz
         qRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897804; x=1726502604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmLD+KoyfTyy43xEOB1Jl+N/7L+1hOh+6Y9O1otzjvc=;
        b=tV0WhGdabNbHwOOwE2+NMfx+LYm/ocdVMMnJS1Lj7JPUHyepYQlkwaJBNEIvenKWoF
         61CbW3qht5xyvRpdPhYZHWKEtky8UdTGsjDkimiDS+K5NBiP0VfDeHOnVnVWfbLAygxx
         h/mm4TQBNarz6TVXp618yzYzWuoxjMCY6mjmbQJgWqok3dLmC1kyADMN7he1qnjPN88N
         SLlLpCA737klJ/djBtIJSPEyvOptBOzuZZXUsn23pb0TkQqz6BZVvs54aBQwBHtVjvt1
         H4sDf3gk2svy+GetzljAZHGpMzjod73iHpzoMzWh15J/gx7zJg9onMEjPBE8QvThNHpq
         Zj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf7sLZBQ8vwQyHw03dPSV4tjlH7J0zhCGS7gTOERACXBW6kFyv5Kr9zj1WoDHSJ+kEpuE/RJOPr5PudEV6W7bpcsZDFfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXYSglMsI7qL/VSA6Q5wbf4mGWO22EgoTtuYUCXRM0aMWp/Wz
	YKkwKe00IHpwCgi79qVgB8q5012XRx8ILt7c7Nib4sjQ6C+hILo0IUgZOEcexQjK9t2zNaxjMa1
	Tb2Bwv/o3Fb+fwAONvdLFAb1pLrqLSDfNWRc2
X-Google-Smtp-Source: AGHT+IFXJbCdQgIsUYiuclOIDXjii4BA+zlkZU46pBKrIPA+T27zslxg+uUckYtLiLzOREZpnuOR1x8LngOyzQPy6Do=
X-Received: by 2002:a05:690c:350a:b0:6b2:7ff8:ca1 with SMTP id
 00721157ae682-6db4515443dmr111890657b3.22.1725897803463; Mon, 09 Sep 2024
 09:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821095609.365176-1-mic@digikod.net> <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
 <20240908.jeim4Aif3Fee@digikod.net>
In-Reply-To: <20240908.jeim4Aif3Fee@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 12:03:12 -0400
Message-ID: <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 2:11=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Wed, Aug 21, 2024 at 12:32:17PM -0400, Paul Moore wrote:
> > On Wed, Aug 21, 2024 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGUR=
G
> > > for the related file descriptor.  Before this change, the
> > > file_set_fowner LSM hook was always called, ignoring the VFS logic wh=
ich
> > > may not actually change the process that handles SIGIO (e.g. TUN, TTY=
,
> > > dnotify), nor update the related UID/EUID.
> > >
> > > Moreover, because security_file_set_fowner() was called without lock
> > > (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a r=
ace
> > > condition and inconsistent LSM states (e.g. SELinux's fown_sid) compa=
red
> > > to struct fown_struct's UID/EUID.
> > >
> > > This change makes sure the LSM states are always in sync with the VFS
> > > state by moving the security_file_set_fowner() call close to the
> > > UID/EUID updates and using the same f_owner.lock .
> > >
> > > Rename f_modown() to __f_setown() to simplify code.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >
> > > Changes since v2:
> > > https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> > > - Only keep the LSM hook move.
> > >
> > > Changes since v1:
> > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > - Add back the file_set_fowner hook (but without user) as
> > >   requested by Paul, but move it for consistency.
> > > ---
> > >  fs/fcntl.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > This looks reasonable to me, and fixes a potential problem with
> > existing LSMs.  Unless I hear any strong objections I'll plan to merge
> > this, and patch 2/2, into the LSM tree tomorrow.
>
> I didn't see these patches in -next, did I miss something?
> Landlock will use this hook really soon and it would make it much easier
> if these patches where upstream before.

Ah!  My apologies, I'll do that right now and send another update once
it's done.  FWIW, I'm going to tag 1/2 for stable, but since we are at
-rc7 presently I'll just plan to send it during the next merge window.

--=20
paul-moore.com
