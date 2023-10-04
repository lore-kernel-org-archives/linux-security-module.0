Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B1E7C4F0
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Oct 2023 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjJDTiF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243746AbjJDTiA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Oct 2023 15:38:00 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60CBD
        for <linux-security-module@vger.kernel.org>; Wed,  4 Oct 2023 12:37:55 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-579de633419so1581417b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Oct 2023 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696448275; x=1697053075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQGn2Phe0RwYW5SGubGGOv+c/hAGSSs2LrA09w+wOG8=;
        b=TilTgkhZouIPuv7GuwoG4+G6t7andK6GaOW7wftIFaIREBfgJYPJjkN6KSK+Avay1v
         okj2r3PfUPtWwxcVfYzuc5MIEkhfTszqWOo4sILSQ+TwvnDqz3vm/FRq/pTgPApIJcuR
         xeu8lYuf4TL5C3DOHXnWsxMwLmJ8NFRWzBd9dMgzmLbzx2UVGMEkHFAy7LdbgWhwznu9
         q4MPPTMc+XkAxik+CKCeMKAMl6Ppmmh6L4Fb2iaAJqVXH69Q8w9yDfPkAQh5pDn7RGoo
         QKUSyOL5Kit6+OQz+MneFcrB66bi0fLGTNflIfkoKvSCaS7dbthDD6qpSpwI/e+ED9en
         /4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448275; x=1697053075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQGn2Phe0RwYW5SGubGGOv+c/hAGSSs2LrA09w+wOG8=;
        b=G7hORnw/3nwXc4mUl0p7ZOjkxYePSBJ0siuz1G3r40eYdpsjlQdOs4B339bSjKjFm+
         wQ6FFOo3d+CE5RAnRlOxvlvsfin7k+cdoU/eeHd8vU6YWvbnqBFn2LmC6IUyfFdNPdm0
         9m73PmlWkykGyGiW8ZdBDka5oeu2D/fAZwnZ0yu63UteaRIZYJv2pkyJiIFebV3zqhvc
         7qtkk02mRnvs9P5n6x9ohJMidladvMm3+2Cm8d8Z2+wNnrOFawQvDUXNYeuVW6X704Xg
         +DTSVNp+bLrJ+O0NXUX2Cr8ec6A4yQ2AdRKHUViFRbl9b8ivpQb/A9QmtSwMAuWlSLf2
         vqBg==
X-Gm-Message-State: AOJu0YwBq/XOFEBauN8WgT7GCxkkF58wwKzZ/2QhYJVO3YCk6Bd+FhlY
        hzIjWZFXV6xJPCV2wxRtqJQXLmrm+zM75C0Ke9Qx
X-Google-Smtp-Source: AGHT+IF/30kkFHZBZjg3KbcOdEkEVasuK1il9LqueAt4mYRrIgMYFlqbwoL44JXav1232SSuhV3Vc5nqAWjjxjk5xw0=
X-Received: by 2002:a05:6902:18c9:b0:d1a:955f:304d with SMTP id
 ck9-20020a05690218c900b00d1a955f304dmr3631465ybb.64.1696448274671; Wed, 04
 Oct 2023 12:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
In-Reply-To: <20230928130147.564503-5-mszeredi@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Oct 2023 15:37:43 -0400
Message-ID: <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 9:04=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
>
> Lookup the mount by the new 64bit mount ID.  If a mount needs to be queri=
ed
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
>
> Return an array of new (64bit) mount ID's.  Without privileges only mount=
s
> are listed which are reachable from the task's root.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  fs/namespace.c                         | 69 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  3 ++
>  include/uapi/asm-generic/unistd.h      |  5 +-
>  include/uapi/linux/mount.h             |  3 ++
>  6 files changed, 81 insertions(+), 1 deletion(-)

...

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3326ba2b2810..050e2d2af110 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4970,6 +4970,75 @@ SYSCALL_DEFINE4(statmount, const struct __mount_ar=
g __user *, req,
>         return ret;
>  }
>
> +static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t b=
ufsize,
> +                        const struct path *root, unsigned int flags)
> +{
> +       struct mount *r, *m =3D real_mount(mnt);
> +       struct path rootmnt =3D {
> +               .mnt =3D root->mnt,
> +               .dentry =3D root->mnt->mnt_root
> +       };
> +       long ctr =3D 0;
> +       bool reachable_only =3D true;
> +       int err;
> +
> +       err =3D security_sb_statfs(mnt->mnt_root);
> +       if (err)
> +               return err;
> +
> +       if (flags & LISTMOUNT_UNREACHABLE) {
> +               if (!capable(CAP_SYS_ADMIN))
> +                       return -EPERM;
> +               reachable_only =3D false;
> +       }
> +
> +       if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootm=
nt))
> +               return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> +
> +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> +               if (reachable_only &&
> +                   !is_path_reachable(r, r->mnt.mnt_root, root))
> +                       continue;

I believe we would want to move the security_sb_statfs() call from
above to down here; something like this I think ...

  err =3D security_sb_statfs(r->mnt.mnt_root);
  if (err)
    /* if we can't access the mount, pretend it doesn't exist */
    continue;

> +               if (ctr >=3D bufsize)
> +                       return -EOVERFLOW;
> +               if (put_user(r->mnt_id_unique, buf + ctr))
> +                       return -EFAULT;
> +               ctr++;
> +               if (ctr < 0)
> +                       return -ERANGE;
> +       }
> +       return ctr;
> +}

--=20
paul-moore.com
