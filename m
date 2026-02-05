Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF13D522A
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296696; cv=pass; b=Zd0d3X1Y5MlCXK8fJCE+++larMwZfDEv38ZDeOQCXP1mqYr/YmMHtlA5C4+n9YnM2UomeaayxdFftx+G/X47XN+jVV3I+bMsVDLJ6oOKdOKKSbf7XAoPjAf2X95+YjbyBzOO1EqqOJpQ57IfUblXYuWLtQz1SNeqNn9nBfPDVmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296696; c=relaxed/simple;
	bh=N2c1RM0b4ERNHu8Wc50fN3R9BsKRWCfa11p9n8FFco4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eok5C+7ffALHn+vK+LUNGzMJRcGbFUsSdo8UJSz/5WlLjcetqaE39uZ2E8AjMbOUSW36BYagf0Tp7/ckuc6BjOTKz9NnXc4kpJJ36qwDziz0PgMXD8f6DPkaWCTdiYDU3u4dlsRRg+M6hksM/7RcLsV7WhE3FujonheQYhSOjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFj/Wgov; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFj/Wgov"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d2c96215so755458f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 05:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296694; cv=none;
        d=google.com; s=arc-20240605;
        b=RXhoI14wtN4dO9utFYU4aSrj7k6x100sxybF3nOrsawkgYRK7S2wvSciJwgKsCq8gD
         6PoxIH2Wt9D3PWnmaclYdWzZpiijHaFd115zZnOOUvZsGhhEne2RdUw8r0HM8x8220e6
         6CTGi3Fkf47QuGYHWWGDcVqHLD/JUwE7OfTnIYksOItKlpcYW3YJiSPsFJvFBjwV8k0B
         CcQxOWCb+4+07T6pfxcmm/n+4OXkDgzE+AbyeUgmKAeWB9ZG/4/HkDzt7/XYXZ37gaWh
         0ElIyEKD01JmT8veXVbI3z5pCJ+ABM5E/5EeZzfCscqst/pu/O5az99cHVrZEL0OgTNU
         7i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        fh=2eYpO5z5rXrRiwLC42C3m+KkpX25Z/HHlf3jxm8RWmo=;
        b=NuJMfPaZhgy0QP04GxmMoUL9k9xWu/r9zbexRSQVURRlhdj3VaP15kf0cVuwyJfZNx
         IvzLU0ZpbllEXacWFxH4yalwjf7JSSKirJr+vTkeo3tW+Y8aDGh2rrcAMCJIYMQgYZbW
         u5CPC16fM6aSZDa4OMXQs3s+rFgJAMs+rAxrJSaIXImyLKjq5/LwWe6joXViSyaXc6Uy
         84Wxgi8u7r5rzryi+qFggYNp0zmHoRcAOpY3MTOGrEmQdbvctm4fiuRCORZ3E37+iyC/
         b2A0TqMV1LsKuPCWu07vhh005hlGigWCxR6lsFwVrY6I9e/sDRM7P9X9s+QqMqQKNNfO
         ETuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296694; x=1770901494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=eFj/Wgovw5nx28AuntEcmYhTLWrcShD+FEPlxv8t7bORKwNp4fZgpa1A8jYpx19B7V
         zpkQAXJ4K4F1Rv7pM72BhwnMUSRonxs65fpBhDO4SGuX0qAlWPM8t4D5sePSeStUIeFr
         q/hMmt72lMyU9ipFKtciig6U6q4SzUh9UN7CUoRKLW2gH8q1i1KthFAMEUcimBVmwnkX
         fbv53HjAq8YAWe/nohi9dOQlYvBcBwPjRxIto8GV/ST/gaM13N9HphSRgAZAg+w0Rq6K
         YgOePfLA4Z3vgrxDj4Z5paCLoAaxyEGqvGJgUxqAYNThBSY9LBmewV+08tHdpfqS5uF6
         B8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296694; x=1770901494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=MmbVLbORiAbG7gB/vOrvq2dY3O4Fmx6rhwMJgjsiXa6P9an3Nb6Qx+7Tg3hAwBwEqw
         /2SbGqvgpYKqVL5gBsEaMzSIzjUa9DbxpbGNBqomoTDqXpTQyfBiCgsmTFHePbIyvNdz
         L6a8oWZ+L+GWbfEm0V4VSaiMcI3TyL5/CulOqrcKmpdOkQuWYD0qEHmByjlZ3PrS5LT3
         qpIyhFx5o2/FfRUQqPLjxxmoJXU5Eo3wNbUaqCS7QVXyC0en1A2lw+H18HWwvyrhZhnj
         TxZ7Bzpl2yk+kr3VoMTnXXlYwwkOnAvHThHy0arNT0COArMUoLfWmAvTHxkwP8fBQmfh
         cQlg==
X-Forwarded-Encrypted: i=1; AJvYcCVXdFWTQXBH9/sonu7zK168rhhywFYaZAKJ9Ip3QckX9Js47jkfDWMa3IBFwqEOB4/ToyHOavs/YGO9N3FnPZrfu4dDZgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3wh+ttFFsA1cSG6DomUYNSe2LUak2Gp9LuJ6taimBAMwoscU
	6zsvyjZyz6c9IJ1tpzt2apVKcvs38rswipvN7gbSQtrloz3FcSi1pa5vwlm/Wf2gAXY46KRFgir
	7KDC5VSPg+J5dR3xZYXgeU+zLmm+jD+c=
X-Gm-Gg: AZuq6aLG9760At45DkbLMBct5Um708sYw5IsQlRklI9W8mFK7Pj8ImTr3O1fsuQnPww
	1X3QMWnWi84/66G8o/766Gcw4G5qtsT/zokCWahGt1TSluSvqdXLszz+ShybdcTn+4c+M71oYTK
	4R7ykTVxHGRUjgyI1vDD5HNg1pu8OA2M37FJRN/wTW6CfyrWjuSWf0psQgnOIqskxf6VkSQxNG8
	n3nQG7q/Z10013rgf7vgHp3xaiAu4SgGJLfqzbVY1gbgK7WT9XF03r35LOeyChnSzILsiLMoyUt
	n5KPhbeAmZBlIZVEv9kzvVmXfsZjXA==
X-Received: by 2002:a05:6000:1acb:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-43618053bc4mr9962281f8f.39.1770296693827; Thu, 05 Feb 2026
 05:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-9-neilb@ownmail.net>
 <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
In-Reply-To: <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 14:04:42 +0100
X-Gm-Features: AZwV_QhEkTNuUX-zP-udJB3TTtiGdaNYEr11QFKjoqWXaHOUCtxdu5bQUZv0f1A
Message-ID: <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
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
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb1567..dcd28ffc4705 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct =
dentry *connected,
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
> > +      * @connected is a directory in the overlay and @real is an objec=
t
> > +      * on @layer which is expected to be a child of @connected.
> > +      * The goal is to return a dentry from the overlay which correspo=
nds

As the header comment already says:
"...return a connected overlay dentry whose real dentry is @real"

The wording "corresponds to @real" reduces clarity IMO.

> > +      * to @real.  This is done by looking up the name from @real in
> > +      * @connected and checking that the result meets expectations.
> > +      *
> > +      * Return %-ECHILD if the parent of @real no-longer corresponds t=
o
> > +      * @connected, and %-ESTALE if the dentry found by lookup doesn't
> > +      * correspond to @real.
> >        */

I dislike kernel-doc inside code comments.
I think this is actively discouraged and I haven't found a single example
of this style in fs code.

If you want to keep this format, please lift the comment to function
header comment - it is anyway a very generic comment that explains the
function in general.

> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> >
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > -      * from racing with underlying layer rename. In this case, we don=
't
> > -      * care about returning ESTALE, only from dereferencing a free na=
me
> > -      * pointer because we hold no lock on the real dentry.
> > -      */
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
> >       err =3D PTR_ERR(this);
> > -     if (IS_ERR(this)) {
> > +     if (IS_ERR(this))
> >               goto fail;
> > -     } else if (!this || !this->d_inode) {
> > -             dput(this);
> > -             err =3D -ENOENT;
> > +
> > +     err =3D -ENOENT;
> > +     if (!this || !this->d_inode)
> >               goto fail;
> > -     } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> > -             dput(this);
> > -             err =3D -ESTALE;
> > +
> > +     err =3D -ESTALE;
> > +     if (ovl_dentry_real_at(this, layer->idx) !=3D real)
> >               goto fail;
> > -     }
> >
> > -out:
> > -     dput(parent);
> > -     inode_unlock(dir);
> >       return this;
> >
> >  fail:
> >       pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
> >                           real, layer->idx, connected, err);
> > -     this =3D ERR_PTR(err);
> > -     goto out;
> > +     if (!IS_ERR(this))
> > +             dput(this);
> > +     return ERR_PTR(err);
> >  }
> >
> >  static struct dentry *ovl_lookup_real(struct super_block *sb,
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Otherwise, it looks fine.

Thanks,
Amir.
