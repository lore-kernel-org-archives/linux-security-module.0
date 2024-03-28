Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB47EF0A
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631307; cv=none; b=at+0Ev79Ci5wkC6H3iHVUxVLx2iVn09VzGJ5CXZHOXHsYq9wbvjW2ENVV9RIeO14qbC1sGeYOHn6MoNJCuEugGd6hOb6xflLTPv0BppdBm4yScz0wqzcpjXKT7Sy4wNIsInVENpLbZ8bdofEmAcAeBBRin+46TAI1L0cyZP/jwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631307; c=relaxed/simple;
	bh=Q9iWHX0IPpMbeqcoJRikaJ89gnv80sbp3IhpzuI1ttI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX42AaOXEM+1/n/wN+TQnKJNO83FZ7Q/L94mTX73G0UX+ah4jFE++OsZAkOuTQWj2XcwFb56lEliCkwzIYai/cK6Kx3qTYWLWVLZO1un0V6ZnLP2+gCZXN25FT3eOEdcbrNZ66Vq9n8vnortXXWAXPLrEELVAOAesi/ESN/2Ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=StnZw3hT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="StnZw3hT"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61130dd21c1so10087987b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711631305; x=1712236105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAwB5SvUtfOc0OQIFY/17yabinsU0l79BDMDWApoFk8=;
        b=StnZw3hTN81BdznuS1JyepqwYYfxBIzAg5cXgQoH4rvuYG9ID672i7xTjeM3oCIAHU
         bUzMMHFkt9Wr/GTZU3iTGV6HwKgv2WvpwJanQFu8QYK5TKn4yWliFQ009pWuwAYiuvK2
         v3PEJ64Y3x6NSy0uZnwEslWREu7eU5pZH/djx9af6m+lC+aQq7kpTEXSUU2BZi2EsgrR
         R/4Zmp56GwOM8X8lLh4Y6bJl5Tuf3jdBMkEJxvXjTnk+F2MPq/N2grY1dD3AVb2+HZFW
         iWx0Ytp9n35YvsBTqTD9RFWG7M5fDsyf2TOR8SQtEZKz/TJGaOdF8B+L+PrcMI5hsom1
         w3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711631305; x=1712236105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAwB5SvUtfOc0OQIFY/17yabinsU0l79BDMDWApoFk8=;
        b=KieUnpc6sHZ0mVeywt0Pw6yea6ATUeMtpjHETc6a6h2Afl5dlzInO49KuH3kvCJYLp
         VF69d7AH8QnNVhnUr2jXxTEV9bD5HudaDx87TEXw8j7I1uUMKyP9B1pWw1/MkBCF9l8U
         0jG4aTQqt6Asp4ko4+wGkIDkKh+9gn7c4Y/bdIzkwpbZ9jcYiGJaGnAEIqj/qNx5fV4N
         QGgqh2AEhz/sdl43fzAG0gSyojzH1y6GrJrQOMWoE3enLM1vcS8w2iMN4Uf7rFrhLUWd
         8cmdEu3mm2sTiVsvN8ojKMF0OL+zsnMfah8qomLvsMla9k/gJfNuf4Nxky2OCYZ6YeMd
         tmfA==
X-Forwarded-Encrypted: i=1; AJvYcCUKBl8dMqvUPPRUD8ZjzRu0NkewGdUOf6SWrZsQU7Mm6nLxoTtyLGzDQ2eHX0i6wRBVkQUqOBRNw/6pW0y5BMh9PhmifAJTUs18sqWZuSs8lwMI0vR/
X-Gm-Message-State: AOJu0YxPQTDpZp5DtFqrw8po9glEwknECykr5liIRzVoRlRfYYU8BPd1
	2imSHSlxf2RR+6H3iQqo+69gtIGy2xWzajrL6Na9e/JZpg9GOJ73h0evbilRMmyqYxA/8DHNNPl
	5G4wDdkxm5K6ox1Y4/FM4bbBDKuaHmgmNTmbt
X-Google-Smtp-Source: AGHT+IEaZ/DWaB9kQfke/Wt9K0JwNig6IYkR1JcE7UM+nBmZeQHmNqKMp6t+dN1gP2Ldf62K+SXrioH8t4S9zT6UhRU=
X-Received: by 2002:a25:8452:0:b0:dd6:82e2:47d1 with SMTP id
 r18-20020a258452000000b00dd682e247d1mr2862330ybm.53.1711631305121; Thu, 28
 Mar 2024 06:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-11-gnoack@google.com>
 <20240328.ahgh8EiLahpa@digikod.net>
In-Reply-To: <20240328.ahgh8EiLahpa@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 09:08:13 -0400
Message-ID: <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:11=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Mar 27, 2024 at 01:10:40PM +0000, G=C3=BCnther Noack wrote:
> > Landlock's IOCTL support needs to partially replicate the list of
> > IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> > do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.
> >
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  fs/ioctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 1d5abfdf0f22..661b46125669 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *fil=
e, void __user *argp)
> >   *
> >   * When you add any new common ioctls to the switches above and below,
> >   * please ensure they have compatible arguments in compat mode.
> > + *
> > + * The commands which are implemented here should be kept in sync with=
 the IOCTL
> > + * security policies in the Landlock LSM.
>
> Suggestion:
> "with the Landlock IOCTL security policy defined in security/landlock/fs.=
c"

We really shouldn't have any comments or code outside of the security/
directory that reference a specific LSM implementation.  I'm sure
there are probably a few old comments referring to SELinux, but those
are bugs as far as I'm concerned (if anyone spots one, please let me
know or send me a patch!).

How about the following?

"The LSM list should also be notified of any command additions or
changes as specific LSMs may be affected."

--=20
paul-moore.com
