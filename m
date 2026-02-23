Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58936331A66
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867918; cv=pass; b=dYlsr0uasytx6zpNRbz63ZOm95EFkCNPEPnmNkvx9u89HF2w6r3IsKExQfgQL6sFG52QGs/mP76m9njojLE/T4VWnb5I29/urwVknnqypZfyHe7wujTRz4yXx2KqFh7N9l8iPHyvekhsvGCAoM5NSNIO4aocAZ7x3bIU5B0HcY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867918; c=relaxed/simple;
	bh=hK/0jeoKCkucbRZSvX1AYVctVojQdWNjxRFJpKPT85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grjlGxhE+g1KnfZY499G6l+kmFyHsHlCjW10e/t38CshGHoyh5bk7jlCXeH/CrLHU3ECXOfKWsVRBszIBzNIwjSZS/kLB4j9OarSJU4xmpjXVw9dc/kSem3qdbDjdAtrmt8ek+SOvfzzYuWsqBumCNo1lUxCCcKPPShzwhVmlB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F+M8ReRS; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F+M8ReRS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824a829f9bbso2398823b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 09:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867915; cv=none;
        d=google.com; s=arc-20240605;
        b=jb+oEKtNcV3GBGG+pMEpmcK9zUEBN112D+TcXS2gPCuGO7hZvt00d3eZttfTesltn9
         Ihf8fHF7VeWI5XSKDsQehEHVnE1jOugi58/Nre30Q+wKxYK23W9g/Dpw1rT/jI4+IMlv
         bqLgJ+0E6M168K4R6iyTSpV+/EiI6r0vDIO31z+LIkQmjO7p0c+xZKNwyQyjaW2v4cXg
         Lb8Pp8+qp3tEmnalBtyOoLCkB0a1sHjazN8GCZdT+dV1rUiDzkmp89htVypyWQ9ungyc
         C6aG5dalYq2gMNLPFs1G8GnFBVDmJeqfBoig+C/rCs8GupRF6uCyNOJz5zD++f2ajxzh
         c8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        fh=h1+2Mq0kK3L4mfKqKT0kHU70P0Hw0CZn9s9BN28f4Cg=;
        b=dL8Lggdp+bYV8ibw3lxy4Cc3H9OdNYKoKamyaq1GdRP57+z4eTi9vrj4q6Nj9ICCVz
         OKyzIK+pnqpi0zMbQoL2MLqbcXU0BgX7Xvj5aQDic5h7ysvi63uApltvHi+eHUaUXGlU
         /Ei2lLvdFgu55P8HmVMx0RSRp596RLXXGFlBgpky4xD+Lotqi5bsuJJLHmn84SD9HI8A
         CVYKZsD78B6+uGjrDdiM1ehtrc4IHmkvIMNZOOdJqNtBQs3dJF3zwMgAcPHXOSyoQRjh
         8YTijEYCDvlBoUk8jyU10Sa9GyMDSNHdQZfixJGlUbrBCktWQS4qEk53428kxSnPv/1C
         lgZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771867915; x=1772472715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=F+M8ReRSjHBcODwL6YMsB62k5KM9tS8sOWzeJ5+cgWNwRgCriw3XQa/eD8Yx/Hni30
         IdB+LiB/ApJjquQB5KcxVEI5HLkLWuZ1vTpKyL0E0HUfvIQZRWdXowU9+z67g7Gwx52C
         +oyHQZzV3WLMrQboFAG7U9dC2B2apXVJrFgLqbBoeCt8vO8eZLDHjMm8iii0dsQnf5WW
         Z+IHssdjgGYFzkGRQY1XVAsJ4gq0CVWEFyPOg2QbuYKPHrO7FhEUN0jl57qhGgMjZ2bq
         zTkZ+QXwpKHtOYw10dJFzE57zltv532RD2Y3Hk+vJDyanvg3sI0G/4PpvFt2TNvnCaPd
         NKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867915; x=1772472715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=d2D7+HMF0TixW2bzpLxtWWwjTtwqBUqImLAzvcD8zHMIffKs9Tuk5QGDhdkLOnk84c
         iv0yC8qYh9oY/Ey64HZNh4agrm4VxPeqYQ0v9QBDe6k8Hu8VlFVX+TuGa2pT9AU57TSD
         TA5bBpz9nYsh3I5pfb1FpMkXcl/vUPre/NMSWc/bhlyngt2xluDptm1ncWiVOXoeEBaH
         MBF3VSDOMbxO7hjiuOVrykjMQj5kMcQPYOh1Hy9Fd6iecu3EEVVULm31DRSM76qlC/bS
         MY/kfhi2730zPDSD0kUxHfJk66LJcIrhGS2DIc3JUbUFI5+L+cY4PZSCwD02KEti9IO+
         51bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo3/aty5GoFhIpuPLdhwH8MG/oZ8xsTc8g/DU4JMdUKl7XZy2eIavRtQAEPdTEZR0yC77egqmfDujbYrDMyONis6GL/Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhNiJ63wSw0EwH/3aK0OvgQFpGiYmMv0zfLC71OErfSHSKuFu
	h2hGH03PdW6fpKB3NcXQEWgs1ndkS9kTuvJ8kJW94dRImeemMeZ+hUAQRv67N+Uy+ckOYacVDuh
	oVNpP9bc5Ki3psAR2l+Tcfuk3cE6JYnSMsvgjmD5r
X-Gm-Gg: ATEYQzyb7wrCeSCcibHx4UdHO8+YPPWpQr/fKKaRMuadZHZKb3Vg9u3YMqukTbmELOB
	aWP1msRMux5IJh1FI/cFMBFF+ltGrt5Yt+5ibWEd1HfQF5TNo+3kfBqp4BQ3AOA5TrJnVcFBtF9
	gZWLfUkZzjcxGGUPQUkqXYdbOlzdOlBYzOuXsHqQF3f+V/SHgTUYnCayHEBqZ4/betudVZN0qol
	B/QUA99toGYDDZ8SrW8MSVi3u0JMgC4DHkZmSLW1bYDXKD4g39gzOFnDrgwgRypCXiWdZm3q/Js
	VN+j2QU=
X-Received: by 2002:a17:90b:2543:b0:352:b674:2592 with SMTP id
 98e67ed59e1d1-358ae7c3605mr8357173a91.7.1771867914678; Mon, 23 Feb 2026
 09:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-7-neilb@ownmail.net>
 <20260223132533.136328-1-clm@meta.com>
In-Reply-To: <20260223132533.136328-1-clm@meta.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 12:31:40 -0500
X-Gm-Features: AaiRm52jwDH7iM8Njra-WDPg6xnZ2flvbCTBnLCHZ5MkdIrvbyo0z9crRKbktmQ
Message-ID: <CAHC9VhSVjLNeTdxHmwYsGX75Z4FOAP+26=PjVdFxpmEkTrPvxA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:26=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > Instead of explicitly locking the parent and performing a lookup in
> > selinux, use simple_start_creating(), and then use
> > simple_done_creating() to unlock.
> >
>
> Hi everyone,
>
> Amir suggested I run these through, and this commit was flagged:
>
> commit bc981629767980bbaee2ca3c7348b5a648665a9d
> Author: NeilBrown <neil@brown.name>
>
> selinux: Use simple_start_creating() / simple_done_creating()
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup. The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds. Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 3245cc531555b..7d4f90e5b12a0 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_d=
ir_inode_operations =3D {
> >  static struct dentry *sel_make_swapover_dir(struct super_block *sb,
> >                                               unsigned long *ino)
> >  {
> > -     struct dentry *dentry =3D d_alloc_name(sb->s_root, ".swapover");
> > +     struct dentry *dentry;
> >       struct inode *inode;
> >
> > -     if (!dentry)
> > +     inode =3D sel_make_inode(sb, S_IFDIR);
> > +     if (!inode)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     inode =3D sel_make_inode(sb, S_IFDIR);
> > -     if (!inode) {
> > -             dput(dentry);
> > +     dentry =3D simple_start_creating(sb->s_root, ".swapover");
> > +     if (!dentry) {
> > +             iput(inode);
> >               return ERR_PTR(-ENOMEM);
> >       }
>
> Can this cause a kernel crash when simple_start_creating() fails?
>
> The function simple_start_creating() returns ERR_PTR on failure, not
> NULL. The check `if (!dentry)` only catches NULL values. When
> simple_start_creating() fails and returns an ERR_PTR value like
> ERR_PTR(-ENOMEM), this value is non-NULL and the error check is bypassed.
>
> Execution would continue to d_make_persistent(dentry, inode), which
> attempts to lock dentry->d_lock, dereferencing the ERR_PTR value and
> causing a kernel crash.
>
> The old code used d_alloc_name() which returns NULL on error. The new
> code uses simple_start_creating() which returns ERR_PTR on error, but
> the error checking pattern wasn't updated to match.
>
> Should the check be `if (IS_ERR(dentry))` instead, and return dentry
> rather than ERR_PTR(-ENOMEM) to preserve the actual error code?

Good catch Chris, yes, please change this Neil and feel free to preserve my=
 ACK.

--=20
paul-moore.com
