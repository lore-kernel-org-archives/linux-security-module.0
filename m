Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B920DD63
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168639; cv=none; b=nwEf/hqd4ejLrzu4ENMVzjMSoRKbGfIrDBSvY94tWv+cBBIQk2Av8YhX8kQHMeZxizKTLVbleFIQSn/ODrB16ciLLMe1ymycM+bz9mAehXjkKUaYSfr1VST7DtJKMm7pd9W4rH8C+T5iMNZng1KcN/ACRwrueRJKSSw8WnGjcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168639; c=relaxed/simple;
	bh=0rsFWbfgTiXpPgGhvo6Vd//Moya6c6WGDhf5n+zOyIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rflmz6gehkpuqVMZy7OCv9rOCfxCEGp9FgCycvkakcT9KPjX6dPl4wbcDbXoXMNstVk3snv/gWLP83PGYCwze8tKh9WAMiEsybcwS6nlnZg/emZpLq7LoeO8TlQqjCTIhUJy1cKi9zrtHs7Z06C1hyQffclH8zySczfYz2+0kYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qs/tNZAE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qs/tNZAE"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fbaa0582a6so25311367b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740168636; x=1740773436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaCf3Nlma4jhclSMBPLprOYEntDDJimnOy91mE59VbM=;
        b=Qs/tNZAELsqHuQ7+DOuWIUa5E2F2cNm7wjrC3bBftcjEn8NoXIFKcXiwf6VAOIe3Fq
         Lxuey9wekDZTb0w3IqyICX0+GnSJJemN9Rj1bi1An4V7FbdFzT6OWW/ZL37zwqeSpvRy
         iQPz9aiqExWVgXnRsW7tXYH8tYXJ+/c1jhd8/fCn8KopSOkGoAXWDklHK9kA9AvSD5Ix
         IY3q4FSRZvVfV4s7iB6NLPsi/F/lsFCZIJfXX9H1fC3tjcUM4kjpFNrFTw+0uLyLOeQP
         6p9D2/mKlKy3VYTqVxBjDWJcdFCKrZPIGPKkRUFV8eH44A2pls1TAK9UXJI+vSTYY4fD
         XyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168636; x=1740773436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaCf3Nlma4jhclSMBPLprOYEntDDJimnOy91mE59VbM=;
        b=W1Np6Mk2a9r4SC8LJmcUZ1xWBzyD2U7e6tEzXp9FgtyPCaJ+q8j0TVCdJifCi2vSlh
         cIX3Rp+QiZbKCkHJa9/8iSffAkxOgNYgqlZYlJyToMdeI2QW2dJEYkB9LG6fkPEz5wqU
         6HhVkKLsYog4CnSgdR3lKTKkvaQw4LTmxTDy1ezkRlcPiYW3PLqgFbXxScTym/Tg79nW
         8ePTnPc5b5Kwr/S2g1R5hU+DndTW8qI28zR7B+prDJ+fJAKjEktJ5HeMIMlPgDujLod3
         Tzeze5y0kkiRQaOCj54BxnhU6g11Q0mXnAcsrkm9tRz8NfWANkjjuN3c/aOdwZynAAnA
         E3zw==
X-Gm-Message-State: AOJu0YxJG92xfy+cMSDF52HbkPEFDx0RkEJEFlkmhIuUyYo2p0IcIF2N
	HsRE6dmWJnzWsgq+y6U1T1tK/os9geNbdPXJh0sC6FR4YzfPaz875GxJv89v20imnwu2M0r9XVk
	TyDu09qIUOsXMqWoLT2MpqNY6ZnsrzHqfbgwr
X-Gm-Gg: ASbGnctqSAl4gstTS6NMlQaLCE/c8TNumO1VQfbtWNRsqrxBqrmN4AbtsaeYoVD0ybv
	+9EF1dOTmgozJymFDwprmCOySeeMoijii29NK9mPv/wL2wj/tpxgnF0M7jN0JW+9xNPhNzGxVCm
	IsRjCsMPk=
X-Google-Smtp-Source: AGHT+IGJ6WUSGWMlvQaaMBPornBmHZRLTtYmy+VqAG/63ZzTIy7EnyeaK4tR60QDpG/AdAkgnXUMxu4c+oIbQpmtkDE=
X-Received: by 2002:a05:690c:6a0b:b0:6fb:5d74:959d with SMTP id
 00721157ae682-6fbb78e24b0mr86105137b3.1.1740168636452; Fri, 21 Feb 2025
 12:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Feb 2025 15:10:24 -0500
X-Gm-Features: AWEUYZlovKsb92mRh54zinleno1McLdTKKAdDUJL3DfgkvZ0swMtLqj-gMAvJmQ
Message-ID: <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, 
	casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:30=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> did not preserve the lsm id for subsequent release calls, which results
> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> providing it on the subsequent release call.
>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c    | 7 ++++---
>  include/linux/nfs4.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)

Now that we've seen Casey's patch, I believe this patch is the better
solution and we should get this up to Linus during the v6.14-rcX
phase.  I've got one minor nitpick (below), but how would you like to
handle this patch NFS folks?  I'm guessing you would prefer to pull
this via the NFS tree, but if not let me know and I can pull it via
the LSM tree (an ACK would be appreciated).

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..c0caaec7bd20 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct de=
ntry *dentry,
>         if (err)
>                 return NULL;
>
> +       label->lsmid =3D shim.id;
>         label->label =3D shim.context;
>         label->len =3D shim.len;
>         return label;
> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>         if (label) {
>                 shim.context =3D label->label;
>                 shim.len =3D label->len;
> -               shim.id =3D LSM_ID_UNDEF;
> +               shim.id =3D label->lsmid;
>                 security_release_secctx(&shim);
>         }
>  }
> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode *i=
node, void *buf,
>                                         size_t buflen)
>  {
>         struct nfs_server *server =3D NFS_SERVER(inode);
> -       struct nfs4_label label =3D {0, 0, buflen, buf};
> +       struct nfs4_label label =3D {0, 0, 0, buflen, buf};
>
>         u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>         struct nfs_fattr fattr =3D {
> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode =
*inode,
>  static int
>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buf=
len)
>  {
> -       struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
> +       struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
>         struct nfs_fattr *fattr;
>         int status;
>
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 71fbebfa43c7..9ac83ca88326 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -47,6 +47,7 @@ struct nfs4_acl {
>  struct nfs4_label {
>         uint32_t        lfs;
>         uint32_t        pi;
> +       u32             lsmid;

I don't think this is a significant problem, but considering that
lsm_context::id is an int, the lsmid field above should probably be an
int too.

>         u32             len;
>         char    *label;
>  };
> --
> 2.47.1

--=20
paul-moore.com
