Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D527F4E5
	for <linux-security-module@vger.kernel.org>; Thu, 24 Apr 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509226; cv=none; b=WN7hVKroeCEJ+JMrjzcUrZJ1NsjpFt6XSurLy1TbsZpYhbbdNUnt3EBQcN/LsKxakY6y+HN5ed2uh63dKrqj7j1Pgx3oPTERXO3u56IqJ3fuWjzfUimNmpxgDJP4fQWPZ3vo3V0tAdqxHBhzOkK5v+UO4dT3jTnEu/8q/JyJcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509226; c=relaxed/simple;
	bh=2kU4zcvrL7YbCjnkq7n+jO3UxoN5TmVVEjgW6RQAS3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=rGeATBeNUIiLKQ2O31zmywhDt9qceR4zWEViVJSilhVyDfhWAT6xH6TZiXao/hb8DeDULKosNW8eOqm8nC/ws8gvib1a/4HKa9jUWwkb9JJm0J8DWyiZNtQySw6I2pUZN1Vci+YH765USNhFJFFOPrCP/86Rxgktlti1xjXy02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMBwdwf6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMBwdwf6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso1127791b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 24 Apr 2025 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509224; x=1746114024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pElVRnbM8O/DhK/o5KfXpu3krpqXcfDKNkQNvTEfW/E=;
        b=LMBwdwf6eKrFzDglb1kzXnPXxONx0B/bqXqb5AQebsMxlyWDJLC1QQh7JwHqsg+1t+
         B3LTZJ4E5Ia5M2o6cpbd9VoJBm8mQHcyqxNZoRC4848OodgC6pPxRli5wFm7ZPMjc+/N
         9CJO9z5a5OjiWdSM8Yb9rQ4XdZuJ/DxRrL+VY2jsTqVlPiBqusITYXJ9u/o/gwGHnkAm
         +aSh5SUueUsAnzNCs76db2sQXfY2VB3EuJ0M5yyr8cVXFMPpGyJGtvAcszZhhUvROCNd
         k1u6CWZAA3Ng+U4DnsPFu+FF/yx8uPUO+V3YKpXVtFvCdFcSlRtzo/PTzaTakI4T+6x/
         RbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509224; x=1746114024;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pElVRnbM8O/DhK/o5KfXpu3krpqXcfDKNkQNvTEfW/E=;
        b=N0c0mKksGYDN5pHv08dnMU/HGTQ9JGWa+Erlnme0Oj/vAmXOegcFvoZze/N0w17IS+
         NK9gYx+hVLB6SCrv1GMdE8FU9nr75xnKFMvNOO/1ZViVfJ56fqexJrcXULw6WccTN07r
         NHRDkVk75HsHiLrQDZzj+bhatNcD8PEpYvlXYWE2rimYbPYrjI8V0YO60+ESapfO0znL
         I+Xw6xIT1knhCbWu6MqPxb95XD2WOB9nJfc0hd8yk3I2Mf9ViN19uFk3YTyjuvoL5emL
         55TfSsVXvhsDpZxf5Zdpl9X2eXcONaSzrHd8m1QSx+cqwMr80ppsncdYuZTjM8DdUSWT
         az/w==
X-Forwarded-Encrypted: i=1; AJvYcCXH++aaTq6L0+6daiBrpVrwKFNRcAFs4sPL8SO+4e5TLAfsivvPfsnIz3JcvdPP0c+H8Cixp5TFPXogVDqDCpJoJ3cp1Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygILfx2EnV3QRD8qUPtqgNlFF29yoNj1+cOs/Hf/KVS91Qv7Ej
	fooyc0XpPPhJJMMgiHvddKN1sFsP7jLDOVrxIT0jZmJTIr9mmP5dkVE+dA6JXPgZVUFt2PvvqSs
	L8qNXwf12B6Zr6UiQfoyDSFhaZXg=
X-Gm-Gg: ASbGnct+lcfggEGqRkJN4USNSaBALu8pZLYY1UEUqbCriJDn5Bzf7I1CwbcsslpJVKd
	NamWVx40ANX4yZeco9P8NoDDgG/Gp4YJdSrKeX9AUrPF3Ui2mrESOkdrZy1H771ySytmBDNTswt
	TWYE6lQ76MA2jZQP7/G0aX3g==
X-Received: by 2002:a05:6a00:1c92:b0:736:34ca:deee with SMTP id
 d2e1a72fcca58-73e32fb2b6fmt232021b3a.7.1745509224234; Thu, 24 Apr 2025
 08:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Apr 2025 11:40:13 -0400
X-Gm-Features: ATxdqUG3sr40DXPqU7DwPGb7IBjfQ5iQvZE5Wbb_bSEPGq081PqgLufaGeVqmLk
Message-ID: <CAEjxPJ6V8aApDHaiU2+8pfDzf7S-bpgdFO3X6UHjRdCNFUNhXw@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The vfs has long had a fallback to obtain the security.* xattrs from the
> LSM when the filesystem does not implement its own listxattr, but
> shmem/tmpfs and kernfs later gained their own xattr handlers to support
> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> filesystems like sysfs no longer return the synthetic security.* xattr
> names via listxattr unless they are explicitly set by userspace or
> initially set upon inode creation after policy load. coreutils has
> recently switched from unconditionally invoking getxattr for security.*
> for ls -Z via libselinux to only doing so if listxattr returns the xattr
> name, breaking ls -Z of such inodes.
>
> Before:
> $ getfattr -m.* /run/initramfs
> <no output>
> $ getfattr -m.* /sys/kernel/fscaps
> <no output>
> $ setfattr -n user.foo /run/initramfs
> $ getfattr -m.* /run/initramfs
> user.foo
>
> After:
> $ getfattr -m.* /run/initramfs
> security.selinux
> $ getfattr -m.* /sys/kernel/fscaps
> security.selinux
> $ setfattr -n user.foo /run/initramfs
> $ getfattr -m.* /run/initramfs
> security.selinux
> user.foo
>
> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y77ph=
0EcfcqcUUj+T87FKyA@mail.gmail.com/
> Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.small=
ey.work@gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Fixes: b09e0fa4b4ea66266058ee ("tmpfs: implement generic xattr support")

> ---
>  fs/xattr.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 02bee149ad96..2fc314b27120 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
>         return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_=
LEN);
>  }
>
> +static bool xattr_is_maclabel(const char *name)
> +{
> +       const char *suffix =3D name + XATTR_SECURITY_PREFIX_LEN;
> +
> +       return !strncmp(name, XATTR_SECURITY_PREFIX,
> +                       XATTR_SECURITY_PREFIX_LEN) &&
> +               security_ismaclabel(suffix);
> +}
> +
>  /**
>   * simple_xattr_list - list all xattr objects
>   * @inode: inode from which to get the xattrs
> @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, str=
uct simple_xattrs *xattrs,
>         if (err)
>                 return err;
>
> +       err =3D security_inode_listsecurity(inode, buffer, remaining_size=
);
> +       if (err < 0)
> +               return err;
> +
> +       if (buffer) {
> +               if (remaining_size < err)
> +                       return -ERANGE;
> +               buffer +=3D err;
> +       }
> +       remaining_size -=3D err;
> +
>         read_lock(&xattrs->lock);
>         for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(rbp=
)) {
>                 xattr =3D rb_entry(rbp, struct simple_xattr, rb_node);
> @@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, str=
uct simple_xattrs *xattrs,
>                 if (!trusted && xattr_is_trusted(xattr->name))
>                         continue;
>
> +               /* skip MAC labels; these are provided by LSM above */
> +               if (xattr_is_maclabel(xattr->name))
> +                       continue;
> +
>                 err =3D xattr_list_one(&buffer, &remaining_size, xattr->n=
ame);
>                 if (err)
>                         break;
> --
> 2.49.0
>
