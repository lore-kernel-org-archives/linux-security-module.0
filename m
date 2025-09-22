Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E917BA1
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509148; cv=none; b=ARqMAbykGwP+p4L2GIneiUNMS51u9q3sMS+0puqlbPe5ryjm4nmekSeJWn74xB+sPxhyIux4kPXaPwxxX4hi/V05ZfqDxda+1eJg2clVTET+WK13jL2mnEWz9cT3b9kgI+BFdyNaEzDf42CfWMxXR6KDesqNKK37IwL+NX95yP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509148; c=relaxed/simple;
	bh=OHE48olg519spvFlWFIeEJNbuS0jmy3zVtKbGyHkqJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKAc2OymcDfsZx0t9fKQskxqtI1BK/mw3s5RAtUopNRSe9oWMu2SbH+0Pk5AAImnnuPWGjwnhpcOfIT8kHWYi0NxnPiowRYmR7wonR8C7HrDLK2f0orSZ0ByYQ+RfTpBFVMOFSIZa+7XOCFB2BohSwxWxJEaH/M5g0tJwp14Dm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S/Y1+Kxq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S/Y1+Kxq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1876055a91.3
        for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758509142; x=1759113942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5yco6RQ2dd+Ews268XrBumZVhE08ntx5AK0Kf4JXDI=;
        b=S/Y1+KxqbkPnKVzilsAmklHGJCqUoFZLXO9Vn9TUpcv/J9HhcFHFN42ekhScfnwT64
         LI0p5LqAnEHgFd9fmrElOj7h1ldiCpKmlG+Ihnc979tX4P/D1Ehu6gLHY7FwGtQw0vpO
         DHl1QpupJMk/2apSKn5oKaMAc0OkZEhsNgRT+UO/kj5WDaTLcUJar1jGGittqyAohxsi
         0xgmxfKqh/g/w36Ps5N6HZ7qByf6K3ZtkrSsiYWOKFU2l51c1rVz98jP5wult//DyRQO
         Cl9L05MGwI5QpopdpYaRWn6ttJQe+vrUSAgWCO2yEloCwRXLJlO6i6IZsuODwKu4D5Wt
         6TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758509142; x=1759113942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5yco6RQ2dd+Ews268XrBumZVhE08ntx5AK0Kf4JXDI=;
        b=S0iZxKG32h6za/GJrfJ/exRTtYzRkj5ZCpL5UgpFMKW7LgpM5M3Yik1NiP9LPT5UlN
         pgk8xn/fjgDtm5KpBiQDedj+rDGTmQPe7Y9di50iiG0GfnrfHe4fY929cMK01+ALUxco
         7YvKis9mgDl5sW8DtC8JGSz9So8c4kJc05kOK1f7P2K8d4G09wLhbEFD+s30b0r6IAZL
         E6ZFefpNsHJ5qX/e8HM5oD24hjKLgeAEwMBHJQq7g0QY6XAe9dTxmTpLF0vVf7H2/SYu
         y7h/XZHOQe17obmOFEhx+XetVZNqJpUxUzGEHtMCdkrkWZGTqQYcOUftPvSNzkw+U2WT
         Jc2w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Bwb7r6GCgOyOF609/x0TrS/dwtQDUxPh0Wu2N8hRixFBucO0kAtPimk0DM8VGJ9mVElLDC0dBjOmO7UPxYD6zutR/R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdzKOfQ8rdEJw1KPD3WfDc5rOQjzcBs2GfRs6Vg3ze/QZ4tjgo
	PybNEzd+shCa0Lz+f96tfbHiuyG6WWmEhoBSMELPeFlgxSij7N76mz8t4iE8x2xWju6B4EZdVgj
	381VSTWSWdw6H8aITkZoTwXuXe1H4epvxUFmYyyyr
X-Gm-Gg: ASbGncvQ9uQyny/EF0mT/fukJ64w4I/pbpgQEmjEY5kqO8r5tTbZrnuUGrG2W1Q4VSF
	GzZyEoI8EXOCHrtgb5XBUoW7XZg9H3n9tvtNObLpG5oJULgHY2LHgFuXy03De5l9jUBQdY6z5te
	eAnnZEIYf4ffswYzkrnlVx9a55I+y/1BKUQDWW2fPL/JjlanWPprz+y9diAVz4GLx6AseMQYx4w
	mFFgwk=
X-Google-Smtp-Source: AGHT+IEQyRXg1l8K42z9GbLLsdJuiyluA15xPpywWswDmAxZCo78QiyFuNoZntuVqZOjN2SIw824qpjzx0zvEHbgdFY=
X-Received: by 2002:a17:90a:e18c:b0:32e:ddbc:9bd6 with SMTP id
 98e67ed59e1d1-3309836e606mr12959586a91.27.1758509141924; Sun, 21 Sep 2025
 19:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV> <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk> <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV>
In-Reply-To: <20250921214110.GN39973@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 21 Sep 2025 22:45:30 -0400
X-Gm-Features: AS18NWCvL9IvxmO_xFeAz1bpOPNMU2283UQ2z-7po2tvqlqTgOAFSSkKcG2Pr5s
Message-ID: <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, casey@schaufler-ca.com, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 5:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
> > > +       dput(dentry);
> > > +       return dentry;  // borrowed
> > >  }
> >
> > Prefer C style comments on their own line:
> >
> >   dput(dentry);
> >   /* borrowed dentry */
> >   return dentry;
>
> Umm...  IMO that's more of an annotation along the lines of "fallthru"...

Maybe, I still prefer the example provided above.  The heart wants
what the heart wants I guess.

> > > @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_block =
*sb, struct fs_context *fc)
> > >                 goto err;
> > >         }
> > >
> > > -       fsi->policycap_dir =3D sel_make_dir(sb->s_root, POLICYCAP_DIR=
_NAME,
> > > +       dentry =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> > >                                           &fsi->last_ino);
> >
> > I'd probably keep fsi->policycap_dir in this patch simply to limit the
> > scope of this patch to just the DCACHE_PERSISTENT related changes, but
> > I'm not going to make a big fuss about that.
>
> Not hard to split that way.  Will do...

Thanks.

> BTW, an unrelated question: does userland care about selinuxfs /null bein=
g
> called that (and being on selinuxfs, for that matter)?  Same for the
> apparmor's securityfs /apparmor/.null...

That's an interesting question.  The kernel really only references it
in one place after creation, and as you've already seen, that's easily
changed.  It's more important that it can be uniquely labeled such
that most any process can open it, otherwise we run into problems when
trying to replace fds when another file that the process can't open.

I'm adding the SELinux list to tap into the folks that play with
userland more than I do, but off the top of my head I can't think of
why userspace would need to do anything directly with
/sys/fs/selinux/null.  There are some comments in the userland code
about not being able to mount selinuxfs with MS_NODEV due to the null
device, but that's the only obvious thing I see while quickly
searching through the code tonight.

> If nobody cares, I would rather add an internal-only filesystem with
> root being a character device (1,3) and whatever markings selinux et.al.
> need for it.  With open_devnull(creds) provided for selinux,
> apparmor and whoever else wants to play with neutering descriptors
> on exec...

With the ongoing efforts to push towards better support for multiple
simultaneous LSMs, we would likely need to make sure there each LSM
that currently has their own null device would continue to have their
own, otherwise we potentially run into permission conflicts between
LSMs where one could end up blocking another and then we're back to
not having a file to use as a replacement.  Not sure if that is what
you had in mind with your proposal, but just wanted to make sure that
was factored into the idea.

--=20
paul-moore.com
