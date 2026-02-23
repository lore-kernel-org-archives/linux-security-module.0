Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4623C51D
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854156; cv=pass; b=UBGGahsvLPu0cLBGAC9LOu9g89CQjQSVW6pJ3YenyVi6ZVWRPfile0iiAWk1swOLllbkBMFCv+mb/gx5aSYnPJmSOF4rr5L0aPQ12DilvDFVLZtmHOyJ25dB1o0/kkTuoY5yldjCCVcIgA3X0va4iaYv28EGJW3+Z8274jWxQao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854156; c=relaxed/simple;
	bh=3vshmxc5tGDcDwufTtgEK5XIRPq/zCoj7NLZuvL2OUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEW5ot0cO2bluG6UPVVu/keRdGhhqhp1HD3VvQVnZyCmxZKPBUVRsrB4uzYiY2L/gVtZjYNV8uUYAluHCAZU5TE8X+d9wGnzpayXDAyLX7Y0CRf/dIg7YPLJckfNZ8KmHRSklYhryk7i91VwrtPYQOJsEwE9xmZO5IHaWcBzcL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxwDdZG9; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxwDdZG9"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b904e1cd038so616524666b.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 05:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854152; cv=none;
        d=google.com; s=arc-20240605;
        b=irLmawh5yJM5NR5w1XtXdLP4FESwlmTKeX4Acrq3C3D9GUBHNBtyTpQKuBCbZRZvZv
         I6B8FVhhaN5Yav/kmk2WB3NOruW9q7qrUBcxMm+9axuuIXbdiIR5a7pQEqwumGYDo3q0
         3UjXc1K5vXRRG7tXAJmBYz/0YHgXREwr5L1yvvnm12q1AzG46tkHJbWOD2RWqo989GIl
         TxUhTB5mTp/A3J4SwalnrkUzAGB2VQi6RdiLuP3fQ93W8sU/2a3/NmfhW8/eJjcjV38H
         FvWGVryNZAWEJX6UYOVZ6BTHVJxaesgYiT0MHJD4IwwZD5Mn3//JyrBVlJuUY89cz2bz
         T8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYqIR5a+IIRIL9B6CcCBN1lSzoy1pmPgI7+7PRVLxeU=;
        fh=gfESTIqk0Nl2h749bIwz9sMk/t8X8nwLx2MDh0PDe28=;
        b=i28CGWIg5GCVT4eUqC7vK8Jsi9nltAKPdzX7kXR5SPhApcd4vNip6f/DG0SyguSBfP
         qHfFUq7i9siPQ9VNYl7BWeNsSaOK5fSRt6aaQNprDHVuN+QD5mN3WJMAmxiC4U0d3x0L
         1yOiTqpNR4gzFXDOrNiqMh+zlvVE0TKWarzRFN/E4aYtrALRSqHN/ZtdIhJp7FVKkT1S
         gAS4oJ7oii7tbHfawkOV8Hv6mhUBKRTj1UOX1KISPBWlHWhbjH6i5UWw+Si2YR3mPZ46
         oYDKbQede7py+InNMD6zuMe7FnmyDlbWTNKqZLiolMxvE/fgN2nTOblfyzbLOXgggNYv
         2zJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854152; x=1772458952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYqIR5a+IIRIL9B6CcCBN1lSzoy1pmPgI7+7PRVLxeU=;
        b=CxwDdZG99TeHt4hb/Q2hzUmmbmTVOYWOhNE6JJzF0mo5xDoqFbKL5ZYz5NmdRdVu9+
         qPAj41/mjRug2h3KECWrNunHtWcQZlZS0qOJxJWFQ2QKiopt63u05CX62G1EfwckGNQN
         CFbzH27gDeTt94JPBHpnrfo5DVhKhonYnavaQSih0rlU2Cq+RW6TVBHdCIPU4Bg3P5WG
         BnNWYeexue9dLsQ3jxINWnDCOig18smScRk3UEFzEUV5rppYBoZK6Tj2ABsREUtZ39Uh
         I/b3943DJwf7bQb3EUppdtXLMhJ3vHB5gA5WJIh27VJFfsQ2bw643y+aKnXEPZfX1PkM
         wWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854152; x=1772458952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYqIR5a+IIRIL9B6CcCBN1lSzoy1pmPgI7+7PRVLxeU=;
        b=XkQYFJqXjpoc57d9ZgvsSUc09zBY47YePN0+LJDbgPvyuwYG9YjfklUJLxwdUoJ62m
         jaCa8aBCUbUhekBwm2YExRKZ2efGs9LzmrAVW8sLpx/MNv8uNhO7YapfpKkebCeZVtG5
         hS2DzgBk4WHXzkOVRX/zKDwgx/+apBB8Py1iVpmPJX50tKGqi0/Hvrj11P/iTx4OR4KW
         qTvBor94WGmXAP4QNIqh5LJkK1jm2NsQZXpEzruNX0m5Yw9oq3o2QLwhpkZxw3TxiE7e
         a0LJl9gq/tVfaEpi4If4ETcEKV/5mRKO22FZC+QLp26a8Wqs7ILjnWaIc93ubk/xTy5W
         UICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpE5ER1ioxDYfLN9q/IVjnETlq40D8O3hYDWw+cDCY5xWahsmbKansogeWxEtTaeXMs2SXuVUPsOw6Dd79sQ+ys1fKRsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHnMyKyrhKyylZJPrzv1gg4N7woa/K1fi/OrFEzTBkk9EfjY9
	dDxrQZEE5Hxx2xoTzC9a9H9A9opF541yJQx+Bx7CVilRkAbscYooiw9hqxJ3W0fSdxqWHfIKUyN
	1byG7urfyjWqlNHktebrK7gyg4TXIk+A=
X-Gm-Gg: AZuq6aLob+FD9QfyOROJGk9Etbob5SCgGB/lUMTzuGeHgHPx1Q3qZOsyfne5w4coLtj
	Yt4HaUO1a2eKr/X+x1//NEi16LEpZeb3kN4Y0ZbgZ4BKK5jYKGcgDIZj+fXDG9Yi4vLKiqgGw+8
	iSj/Y6vt/RDTTgwPJ8SCM3x+gg/mZmmXUuXJZuBB79IoBLD9a7f7tCKCkN3ItleUKE9FfMxPXoB
	zWhQBsqFo1sTrUTcZZVitk/fxspcnAd+gldBDkHWwHnxHQ6apzm8ABRgP12PQksdsN1qApWWjik
	6swY9CQhpOfcT7v0yIGE7FAdPXk0jQas0JZsgHG5YQ==
X-Received: by 2002:a17:907:84b:b0:b90:bc06:2acc with SMTP id
 a640c23a62f3a-b90bc063e40mr41246666b.5.1771854151460; Mon, 23 Feb 2026
 05:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-10-neilb@ownmail.net>
 <20260223132027.4165509-1-clm@meta.com>
In-Reply-To: <20260223132027.4165509-1-clm@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 15:42:19 +0200
X-Gm-Features: AaiRm52WUoDV9vuNNf_TRYKkff03CBHKSKX_6G_n5O_M7CVzPVA-lit5gSUxti8
Message-ID: <CAOQ4uxirM8dW9rOw4SvGtfH-s0Eg9LGuFk1aZooMvEDc=2tbyA@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:20=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > The primary purpose of this patch is to remove the locking from
> > ovl_lookup_real_one() as part of centralising all locking of directorie=
s
> > for name operations.
> >
> > The locking here isn't needed.  By performing consistency tests after
> > the lookup we can be sure that the result of the lookup was valid at
> > least for a moment, which is all the original code promised.
> >
> > lookup_noperm_unlocked() is used for the lookup and it will take the
> > lock if needed only where it is needed.
> >
> > Also:
> >  - don't take a reference to real->d_parent.  The parent is
> >    only use for a pointer comparison, and no reference is needed for
> >    that.
> >  - Several "if" statements have a "goto" followed by "else" - the
> >    else isn't needed: the following statement can directly follow
> >    the "if" as a new statement
> >  - Use a consistent pattern of setting "err" before performing a test
> >    and possibly going to "fail".
> >  - remove the "out" label (now that we don't need to dput(parent) or
> >    unlock) and simply return from fail:.
>
> Hi everyone,
>
> Amir asked me to run these through, and this commit was flagged.  I recen=
tly
> changed the prompts to include some vfs knowledge:

Thanks Chris!

>
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/vfs.=
md
>
> And I also put in some words to make it prefer reporting problems that mi=
ght
> not be bugs, but that do violate some rule in the .md files.  This might
> be a false positive from that new shift toward blindly trusting the guide=
s,
> but I'll let everyone here decide:
>
> commit d1bfcef048896cdc9e4c57e3249b6ad344d64c02
> Author: NeilBrown <neil@brown.name>
>
> ovl: Simplify ovl_lookup_real_one()
>
> This patch removes locking from ovl_lookup_real_one() and reorganizes the
> control flow. The function now uses lookup_noperm_unlocked() instead of
> lookup_noperm() and performs consistency validation after the lookup rath=
er
> than holding a lock during the operation.
>
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb15674..b448fc9424b64 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct d=
entry *dentry, int idx)
> >       return NULL;
> >  }
> >
> > -/*
> > - * Lookup a child overlay dentry to get a connected overlay dentry who=
se real
> > - * dentry is @real. If @real is on upper layer, we lookup a child over=
lay
> > - * dentry with the same name as the real dentry. Otherwise, we need to=
 consult
> > - * index for lookup.
> > +/**
> > + * ovl_lookup_real_one -  Lookup a child overlay dentry to get an over=
lay dentry whose real dentry is given
> > + * @connected: parent overlay dentry
> > + * @real: given child real dentry
> > + * @layer: layer in which @real exists
> > + *
> > + *
> > + * Lookup a child overlay dentry in @connected with the same name as t=
he @real
> > + * dentry.  Then check that the parent of the result is the real dentr=
y for
> > + * @connected, and @real is the real dentry for the result.
> > + *
> > + * Returns:
> > + *   %-ECHILD if the parent of @real is no longer the real dentry for =
@connected.
> > + *   %-ESTALE if @real is no the real dentry of the found dentry.
>                                        ^^
> There's a typo here: "is no the" should be "is not the".
>
> > + *   Otherwise the found dentry is returned.
> >   */
> >  static struct dentry *ovl_lookup_real_one(struct dentry *connected,
> >                                         struct dentry *real,
> >                                         const struct ovl_layer *layer)
> >  {
> > -     struct inode *dir =3D d_inode(connected);
> > -     struct dentry *this, *parent =3D NULL;
> > +     struct dentry *this;
> >       struct name_snapshot name;
> >       int err;
> >
> >       /*
> > -      * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> > -      * from racing with overlay rename. If the overlay dentry that is=
 above
> > -      * real has already been moved to a parent that is not under the
> > -      * connected overlay dir, we return -ECHILD and restart the looku=
p of
> > -      * connected real path from the top.
> > -      */
> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> > -
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > +      * We need to take a snapshot of real dentry name to protect us
> >        * from racing with underlying layer rename. In this case, we don=
't
> >        * care about returning ESTALE, only from dereferencing a free na=
me
> >        * pointer because we hold no lock on the real dentry.
> >        */
> >       take_dentry_name_snapshot(&name, real);
> > -     /*
> > -      * No idmap handling here: it's an internal lookup.
> > -      */
> > -     this =3D lookup_noperm(&name.name, connected);
> > +     this =3D lookup_noperm_unlocked(&name.name, connected);
> >       release_dentry_name_snapshot(&name);
> > +
> > +     err =3D -ECHILD;
> > +     if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> > +             goto fail;
> > +
>
> A subsystem pattern flags this as potentially concerning: the VFS subsyst=
em
> guide indicates that TOCTOU validation checking d_parent should also chec=
k
> d_unhashed() because a dentry can be unhashed (removed from dcache by
> concurrent operations) while its d_parent pointer remains unchanged.
>
> The old code held inode_lock_nested(dir, I_MUTEX_PARENT) during the entir=
e
> lookup and validation, which serialized with operations that could unhash=
 the
> dentry. The new lockless pattern creates a window where:
>
> 1. lookup_noperm_unlocked() completes and returns dentry `this`
> 2. A concurrent unlink/remove operation unhashes `this`
> 3. The d_parent validation passes (parent pointer unchanged)
> 4. The function returns an unhashed dentry
>
> Other overlayfs code uses the complete pattern. For example, in
> ovl_lock_rename_workdir() at fs/overlayfs/util.c:
>
>     if (work->d_parent !=3D workdir || d_unhashed(work)) {
>         ...
>     }
>
> Could this validation miss a race where the dentry is unhashed but d_pare=
nt
> still matches? The subsequent checks (!this->d_inode for -ENOENT,
> wrong real dentry for -ESTALE) might catch some cases, but is that
> sufficient for all the scenarios where an unhashed dentry could cause
> problems?
>

It's a very good comment and very important rule to check, since
we have at least 3 fix commits on breaking this rule, but as this
code is utterly confusing to most human I do not blame LLM for getting
confused here.

The lock not taken on 'dir' which is the overlayfs inode and the checked
'real' dentry is on the underlying fs.

Therefore, the check of real->d_parent was not protected in old code as
well as in new code - it is a mere best effort sanity check, so I think
there is no added risk here.

Neil, do you agree?

Thanks,
Amir.
