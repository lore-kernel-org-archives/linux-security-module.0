Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F035BDDF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Jan 2026 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346849; cv=none; b=X9pbJiiaJbKGEU4CNDRnIqZb3RXXx+/5Ea0L9f90i2OM/tRFeYSl9fDtsIkvHaBt+gnchvUQAb7Os6XF9Q2bzP77OxVgBTKs5Vh3Nltk9wGfNbYgFx2rjxwzDem0tZbiYnEPcdxyHt2pRc4sOeymfsg1OA5MAOzUeu6iPKoZ3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346849; c=relaxed/simple;
	bh=eSKvxq9YwVBzyMuYewlHzV06JI+v3ubEKxN2UzdrhAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIbdfsZsjUPECY/dLWM1GJrpPkXdmWAOwx/y31ynB0CYoQ/JFXleqvGFwDLRoSQN0eYCL6uTy6jBHZvA095VJN3fOpsWtJqXG7Zwn7UWGotLcQ1Yj9ILjqQTGp/hD5scVq3DE72HjoqlzUs2IOOFXTblRQkrw2f7zNMoehgz4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cz7LpQGf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cz7LpQGf"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c2f335681so4722415a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jan 2026 15:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768346847; x=1768951647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myIopHE8OLjLfSfgj5xRK52HoztIhbA+miJiAcmBvWQ=;
        b=cz7LpQGfuOmJ1Y66NOVYcrK1WRxvDD9ajc9Fl7lq/dg9TJbjXqOfolAdlT+Qjy4BtE
         dcnHaezi1WNKhrYZCHOhgxPCIQeGk6DBCw1ivOnTBpWVFazDH9kkiBAAQWwnEpdL0Yij
         sHZgg8OQZm4/6HpAez5YqNjhdn8O1S9ZlMvnuB63LEg8IRkGAqTIxAdFnWEXOSsHnlTY
         lgBAKdQuX0YWl/+OghPMnan1WtNwBaUJ4ZrJ2oBqmtH0uGZdhUX6kmG2pntgX97VMBZ5
         CgOLVsJwvkpmq9AvrNxoRBDNMaYEZdNAOsLTTNq9Cwx6LnzTwO7X4+cpyldDVhhsfk3Z
         3GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346847; x=1768951647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myIopHE8OLjLfSfgj5xRK52HoztIhbA+miJiAcmBvWQ=;
        b=g0v3msWsHaWMusVVBcFHB3Nwrke6FNY+Djvd4jGG8Y25/juZce/yvDSg7sPIPmgOdo
         fFpZUMl0y+G/lP9HpyDe+h75EMA9h6AK7mU1B++5sMtcc7bthBsusspvnj2xTYa29tIn
         nRXkrDCJ8qa/o8r9qzX1scRRZYbYGdfIbIxv3es1wsUiMm8nbtMyBZZRAuudV44UOAbC
         zpbBRcRjMquRqgJYWITPuGaT7lzPr2GK0NRQA7Er6HkWmdXqEvllDq2w7riQWKdZk3EX
         XFEh3EQXykQASgdhcvNOTkU/yw/SB941uGfOFEmNF6Ic9l2EmjwhGmfUpKkYYP9MWGWc
         Y6+g==
X-Forwarded-Encrypted: i=1; AJvYcCUSr+K1+fX4jA1NtmZnbb866/8fwHJNn1Qm/4FLfUPZ/V9n/205ukgnsZcqJYImv5W1XtbPAYzbq8FHDng4Coalu0G6crc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0v4wK+chE3CMdJ9gk1y7fIr03qAD1KbVn4DLlnvU5UlH6hnW
	bsnpcI1Ghc+ikg6VuW6mPmTMbaOKe6TDvVNEFAUHRg6ypKbOdgrEaBPTwDQvZFrIZn7Jn1z3rxp
	X0n2JpP+r8b+EA36wyS7xjFOXtS2gM23Sfuobq+pO
X-Gm-Gg: AY/fxX4fbAUKvIHtj7ZTnuhHn8awO+0vT6iJXxIxtMXiVvTq5jm+pNXSbvJI33YiMeG
	EDPsH3LrCLegmxWA/anTRZ7ru3UrhN5Aj/85187bz/6M1KCDlw/gw+IMxyOGnBgR7KGcP6R7Ovh
	FlFipu35dpnwtGWyapvldARILTD0zjuMO3/3+G56yXVMYDc6BvZgKGw8O0zyAMn9GA7jvcR16q5
	VFJnM4dkpvdqYUOUPQpSiE1gB5o8jvcY6peNZatTNPUk/17T9CTROhzJxERHdGy2nsX15o=
X-Received: by 2002:a17:90b:5808:b0:34f:454f:69a9 with SMTP id
 98e67ed59e1d1-35109176388mr565981a91.28.1768346847514; Tue, 13 Jan 2026
 15:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110143300.71048-2-gnoack3000@gmail.com> <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner>
In-Reply-To: <20260113-kerngesund-etage-86de4a21da24@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jan 2026 18:27:15 -0500
X-Gm-Features: AZwV_Qh90nIBcXw1OpIJ0y4At6w-yMoPWBag3gRCXMZrMzEXPFso5KKQHG1ZKIY
Message-ID: <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 4:34=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Sat, Jan 10, 2026 at 03:32:57PM +0100, G=C3=BCnther Noack wrote:
> > From: Justin Suess <utilityemal77@gmail.com>
> >
> > Adds an LSM hook unix_path_connect.
> >
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated.
> >
> > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  4 ++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            |  9 +++++++++
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 44 insertions(+)

...

> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 55cdebfa0da0..3aabe2d489ae 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockadd=
r_un *sunaddr, int addr_len,
> >       if (!S_ISSOCK(inode->i_mode))
> >               goto path_put;
> >
> > +     /*
> > +      * We call the hook because we know that the inode is a socket
> > +      * and we hold a valid reference to it via the path.
> > +      */
> > +     err =3D security_unix_path_connect(&path, type, flags);
> > +     if (err)
> > +             goto path_put;
>
> Couldn't we try reflowing the code here so the path is passed ...

It would be good if you could be a bit more specific about your
desires here.  Are you talking about changing the
unix_find_other()/unix_find_bsd() code path such that the path is
available to unix_find_other() callers and not limited to the
unix_find_bsd() scope?

> ... to
> security_unix_stream_connect() and security_unix_may_send() so that all
> LSMs get the same data and we don't have to have different LSMs hooks
> into different callpaths that effectively do the same thing.
>
> I mean the objects are even in two completely different states between
> those hooks. Even what type of sockets get a call to the LSM is
> different between those two hooks.

I'm working on the assumption that you are talking about changing the
UNIX socket code so that the path info is available to the existing
_may_send() and _stream_connect() hooks.  If that isn't the case, and
you're thinking of something different, disregard my comments below.

In both the unix_dgram_{connect(),sendmsg()}, aka
security_unix_may_send(), cases and the unix_stream_connect(), aka
security_unix_stream_connect(), case the call to unix_find_other() is
done to lookup the other end of the communication channel, which does
seem reasonably consistent to me.  Yes, of course, once you start
getting into the specifics of the UNIX socket handling the unix_dgram_
and unix_stream_ cases are very different, including their
corresponding existing LSM hooks, but that doesn't mean in the context
of unix_find_bsd() that security_unix_path_connect() doesn't have
value.

The alternative would be some rather serious surgery in af_unix.c to
persist the path struct from unix_find_bsd() until the later LSM hooks
are executed.  It's certainly not impossible, but I'm not sure it is
necessary or desirable at this point in time.  LSMs that wish to
connect the information from _unix_path_connect() to either
_unix_stream_connect() or _unix_may_send() can do so today without
needing to substantially change af_unix.c.

--=20
paul-moore.com
