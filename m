Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A533D349E
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294398; cv=pass; b=igW0LcdXhOtgEm4bQjWt0OdLQ7g6mlAnHjwUwkgWHEcL776j5zLz3gSNeZ0k66mHk5Fue0h67pPtYelc/A8zPd4OBFvB6x82EB1XxsOaPoFJ5pa2KyJUvcWLM3FJ16WNPAl8PKoJtOIdrs9YgQHO56ZI3iLNPBn6WU8ok8Lqvdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294398; c=relaxed/simple;
	bh=C5vOLxPnRhY6qi4kHmtoIzIplBE7B/w6zl9ie5PvVMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQkQPE9Gwl7T5yBxjGp1xW7t7moC8+5Nz/LcoUXyitXrjz/k2Zd0RHBQnE9lTZ+R0FavZ4mqlTGQ3oXbv1iOA/abZXeOI1I4U9TqBvelIWmDzKmKAvgJDKo3IhFypTCDTmLnqngq0oAHxVW2MTR6ahMWLp9utK2ctCSFCGtnqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ/kpL9h; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ/kpL9h"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso1231879a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 04:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770294396; cv=none;
        d=google.com; s=arc-20240605;
        b=T01Fz8WIp41HAlLm7TK4kJu0QgK++ixbqNXRgadJc6+poHveD7mz0onsOm3NsLdvo/
         f41Gm2dyh9HwJRkUa8P6HzId1NXwWsE98iY5qARkdHrRFBuHRa/X0jlrjXPJzw+j5EIj
         HgfE1hOhpVv+M7dMx2NyTyWjuzrw2rZHCWJ1Ns84yeVhgBGnnDbLoqkgqkXPq+NAXhxx
         cqEfgivDfC2/fOQi5PbaiFfYfS6CD/MYEUiPMuVONahA6oMi2VwyUHbiEEDWi2BULv2K
         ufRRM9VpYG1u3oENVstszaL+mJGOzTiYx0QUoktRlF3M6uySzbXCNom4JEnscwUPS4KG
         SO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        fh=RXHK31+E0QpBVFcZjjKw5Uc3KSna6SQiVCDxwX1LE8s=;
        b=dBiVMA1SlGt24pDD/Gq3kMvErBiWOT67pX+3gOR88Cvw9SWpUkivsbtNbFJSLS+Kao
         wKZCKJp+WhFXRQJ7JiiQ+o5mm6mhF8Qktbzka6QEn2k/1JH8WURpxxrgjT2GQ6/tBcJC
         YtrJTwDuRCVzssYSp2TVt+wj2GFCogh26QqyiSRo7OCwKVfdN2+cwXtEtxjqwGWh8vIQ
         tkWatncU4uhrbypBhzsg7+xJir257fevSB++VaZCqFAlzSfqcDoC3lm5yEdoM/EXYdUa
         NWxaA/b/6fuOqUxVmJYY+oIYCvGU70v6EFBUB9JYkzwX74RhPOvGOMLI35lbY6T32RLF
         XhKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770294396; x=1770899196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=fZ/kpL9hZrFuXxqlS1kf2FfrnO/ztwaBbfZ/BlG0wBhoFgNZEsapLLAefnFQgMqkq1
         XXvGhaSwnWhmNbZikkTCHoBgcVDl2axU+pJ+wlbZMXdx4fHUB2xuMNyZ261p+ZgJ3qup
         xhcqU3iR0u6y7+u8IPd2D9FCJgEmXsQnr6SFDs7c5/IrEwrqYFAmk7SLoD1I3Z6hudiw
         NfL9PkCt9G1fmewoD7gqXVEV006stKo16cyVFIJ9soAxUyxzATAbArOcRxmZNb3v95iw
         yt7t3Qf5K7kDqDaPrewJLZ+f2OmdX8RJOgo7zjinRhCbBk6sG+ARRxe6RSVg9Pg5Zh8N
         Yk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294396; x=1770899196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfB0UXxHCYVgd7CIr3QzJ56G7ROPE9D9qGfdOM8KDP8=;
        b=A1LpTZf1lJZhFEAV2IeHnvwEHef3/LPwJzEC5W6ZlrjXUyBWd5EvLFbHCMuoHTsND8
         90BQqB/VYEDQZy1qmhUBczLUsZjKMINdYCjrfsFRa8ROlqi8ioySt57wHtds1jrEekOS
         iwquC8Jo7NVcUKHUkMjdTahE6idQ5PdM8RXnwjp4wx1UunI5H13l0Ygm0MoEGtUkb6RE
         +iRR0NrAypiWh/Ox48JG36NzB3pNNNkNWBUQGWaL1PWzitKeFSh96jNAAmyYcOuG9KqV
         YJuoqdQoXkR0/fATRkbAMMHjMBHjp6k7dSmqyzdbLnTN/9M8LR47+BI6tSgYaUNcrqY+
         nI1g==
X-Forwarded-Encrypted: i=1; AJvYcCWv+IJio8vQ4h8cfrb9V7FVI9whxhkccX2SVTZ8KdMan9zFztnP9oqmp8nSg8LXvPhYorsDPCRS/iQBrjebrv8qcHE4XdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnmniGFllgs/qyN8DKys4q1S/pIng7UQ5yy/ZIJ2xvyDsuMQ+
	ekQhe96aqQACUERI4N+d5ui9ADzASvRJIbCC1qWs+N8tPjHKGBgwAy7EVtNO7OPpJFXEYN1iK1I
	LXX8yjYadoclYK7a1uT/wPwtee5k4Xy0=
X-Gm-Gg: AZuq6aIzxNSZdz+JEiDyE7uX9tEB8myt3Jjw3ap/JpawwtSab7K1CTR8NBsF2F7RFnz
	+TkyjDeN5pv/qtzLVZKVICAG086JqD+YDp4qfEwV/NRp/sku1q7pM5OslPm3VFyi2C1p5gIVJAm
	zam5sGtcJj30COah+UnEXrNp9EsLGPMA7pmy/OJ7aAEGKMoylIK/dwlvOJxX7G6AsgHrck7U3g7
	PAN0bQLJdYuMBBZRYtMb7A9m9pqQxfXHzar5Lm7PxQO906VkEk04TeQAMj0QDi85kd6xgflVjet
	JLNu+MDEPVf4r7nqLqRvS/KlHJgyMA==
X-Received: by 2002:a05:6402:2711:b0:658:da9:787d with SMTP id
 4fb4d7f45d1cf-65949dc2762mr3243637a12.21.1770294396096; Thu, 05 Feb 2026
 04:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-11-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 13:26:24 +0100
X-Gm-Features: AZwV_QhSomAYq3e-9LVlkwiUvLVwnQqEgYbdyasP4aBJdb_z_a8NyX57euMmGhk
Message-ID: <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> When ovl_create_real() is used to create a file on the upper filesystem
> it needs to return the resulting dentry - positive and hashed.
> It is usually the case the that dentry passed to the create function
> (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> filesystem may unhash that dentry forcing a repeat lookup next time the
> name is wanted.
>
> So ovl_create_real() must be (and is) aware of this and prepared to
> perform that lookup to get a hash positive dentry.
>
> This is currently done under that same directory lock that provided
> exclusion for the create.  Proposed changes to locking will make this
> not possible - as the name, rather than the directory, will be locked.
> The new APIs provided for lookup and locking do not and cannot support
> this pattern.
>
> The lock isn't needed.  ovl_create_real() can drop the lock and then get
> a new lock for the lookup - then check that the lookup returned the
> correct inode.  In a well-behaved configuration where the upper
> filesystem is not being modified by a third party, this will always work
> reliably, and if there are separate modification it will fail cleanly.
>
> So change ovl_create_real() to drop the lock and call
> ovl_start_creating_upper() to find the correct dentry.  Note that
> start_creating doesn't fail if the name already exists.
>
> This removes the only remaining use of ovl_lookup_upper, so it is
> removed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
>  fs/overlayfs/overlayfs.h |  7 -------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..ec08904d084d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
>                 err =3D -EIO;
>         } else if (d_unhashed(newdentry)) {
>                 struct dentry *d;
> +               struct name_snapshot name;
>                 /*
>                  * Some filesystems (i.e. casefolded) may return an unhas=
hed
> -                * negative dentry from the ovl_lookup_upper() call befor=
e
> +                * negative dentry from the ovl_start_creating_upper() ca=
ll before
>                  * ovl_create_real().


According to the new locking rules, if the hashed dentry itself is
the synchronization object, is it going to be allowed to
filesystem to unhash the dentry while the dentry still in the
"creating" scope? It is hard for me to wrap my head around this.

Or do we need this here because some filesystems (casefold in
particular) are not going to support parallel creations?

>                  * In that case, lookup again after making the newdentry
>                  * positive, so ovl_create_upper() always returns a hashe=
d
>                  * positive dentry.
> +                * As we have to drop the lock before the lookup a race
> +                * could result in a lookup failure.  In that case we ret=
urn
> +                * an error.
>                  */
> -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, paren=
t,
> -                                    newdentry->d_name.len);
> -               dput(newdentry);
> -               if (IS_ERR_OR_NULL(d))
> +               take_dentry_name_snapshot(&name, newdentry);
> +               end_creating_keep(newdentry);
> +               d =3D ovl_start_creating_upper(ofs, parent, &name.name);
> +               release_dentry_name_snapshot(&name);

OK. not saying no to this (yet) but I have to admit that it is pretty
ugly that the callers of ovl_create_real() want to create a specific
stable name, which is could be passed in as const char *name
and yet we end up doing this weird dance here just to keep the name
from newdentry.

Thanks,
Amir.
