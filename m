Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C11519A2
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108640; cv=none; b=XyMxXRrvuNB3P4epu+oa35MqbPIvsO7hQ25YIcFPbajqkR48ixOZ2E1ZciUW7kSrWil2iG7bx0aQvPlpMt+hlSpMQfbz6cGw40xP7GsfmXzbDF/465zFcRbyDF2MYSvJwbl/n4iF0X2j+5mvLvqMmkNCmI6GTWfvxpLsvxtRFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108640; c=relaxed/simple;
	bh=eNC9ZuejUvdpqu5WNpeuhEOoPI/+DOEicU46P4QdZZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYJZOoEKXbkOuL2nha/BUlhnb1maOFiijSr92yncRILYm4GNvwjo+GC+FJYgeHtc9Uji5sut66kG617PqQQyytc4HZ0Hst5CiFkcIbSufs0aqq62wYaGI86T1jR72WpkEuGYM/dfSIssoo+iSFbHK0IT+CJxiDaViRFGqSV1zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EaSRICvW; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EaSRICvW"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4be5ec1262eso351093137.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2025 19:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740108637; x=1740713437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jhxEXkcJolsUqGmM9PW7X2Wli6iSVP3m68cQMuMSGo=;
        b=EaSRICvWkeUTP/1qVNR6CLhbACmm5yumTZEjKWwwitxmMCDltjVPvWcVuRyrhOO8si
         Ot0nL9clV39+Glzpn0Ol8jzWKvDoh569YM5ybl2nnxiAnCfgce9tQE+oUvwTcuVuQbNx
         I5PKWJMNLR5HrJS2wS9rZXkTIqKGJN//MN7D+xH0lZRk8CAxZciYxvxKrJ8wxYoOL53f
         7WzqNmA2P7NZtthAcakS8uLjFAXlRqnNbg1kff53lzvQwtuhrnEiPxtMQxnOUCCanse9
         lKRcHwmvfrJz+vLTljmwiVEKAfFrSV7yc/7+Y6ON5hm2LwFBCuGu9oS8pASPriyGE3HW
         Jq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740108637; x=1740713437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jhxEXkcJolsUqGmM9PW7X2Wli6iSVP3m68cQMuMSGo=;
        b=f8RKOsjW1j0vd6EDvaDtqeI8NFQnyGVV1lJsiylV2WWGCh2xQmI6B26sitOXkDzdKq
         iT9DaQ3Zf2wwlHf6KNx/1lhCZISoA7dXurOeXm/kJ2dqxyx5r8mnqy2wI2utIsudc6T2
         1kAB7atCkf2puY2z3YnnbUKe9+2+KPSOpsdLVpDeQhTlIc9umayZjJAf8y2embwVSPTl
         Vkp450rvZ4PR4ZYsn9o9FP94NuFz/RheB+/M+h1HYkTdnjBh6wi7YGRko3vGNuICVkoC
         YQQiisJS48JsGaW3h199kI70ZEmGRhkY5a8v0nilq5RyWN96sMCK3jpyYz6mFnDQI7Q+
         j7eg==
X-Forwarded-Encrypted: i=1; AJvYcCWla6MY3GLthR/w6foMzxrlNnqUYKe5vRkzdsm9fSOyJGevHakWSOEiUH9LzpbHcuH13IgS067NoxRs/KFMRMfNXfF0nB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntOF468VSPlYgIWtymvnHfcsV/k030OwgJYiDApeJF8TD0iPP
	Fkwrl4aA8yp9nXDp4WjxRQpapPJd50d8mXtQAnovZA27S1HlMd+sgyhO0x8KpZgZ4OimuD0ieG8
	DrPv7wHgRxcgo/oUwYVfrpmshDy5u/B0GPkPT
X-Gm-Gg: ASbGncvYwu3Gqvm/uCeZSPb+K68xxAyOJZ7dwohzJIyjBjOaLeTGNm47SDg/49GGfZb
	Gx3Q+u3tPYN1HgwM3laHly6p6+GU9QHWA+ROoAq+1T4WrJ10bktCrZoe8MNYJtZp1AhslJ9RyVy
	R3p6yh6G8=
X-Google-Smtp-Source: AGHT+IElmufFPlRhN6WUP6xsl2j3aSKliL509oOsAP2BM3ztinN4sZ7IjqPpc6kdwKkEtT/lAxOMSlL/ROY6KYO1KR8=
X-Received: by 2002:a05:6102:3710:b0:4bb:e1c9:80c6 with SMTP id
 ada2fe7eead31-4bfbfd6a86emr1520102137.0.1740108637514; Thu, 20 Feb 2025
 19:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com> <6bf60899-fbc2-404f-b6e9-378fd828f303@schaufler-ca.com>
In-Reply-To: <6bf60899-fbc2-404f-b6e9-378fd828f303@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 22:30:26 -0500
X-Gm-Features: AWEUYZmWL9Qf57mUu_KeL1_WsMAja84czDYkD32q68uwNEjULQl6e3slofEC6z4
Message-ID: <CAHC9VhS4WcoOhrCsxP=ea6XD1f6pu2uCi7=TH=BBvSkW6SyYiA@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:35=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 2/20/2025 11:29 AM, Stephen Smalley wrote:
> > commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > did not preserve the lsm id for subsequent release calls, which results
> > in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> > providing it on the subsequent release call.
> >
> > Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Please don't accept this. I will have a better, simpler, more appropriate
> fix promptly.

We're still only at -rc3 so if you need another couple of days to get
an alternate solution out for review/discussion I think that's okay.
However, the solution proposed here is rather small and easy to
understand, which has a lot of value for an -rcX fix.  If the
alternative is notably larger and/or more complex, the patch here may
be preferable for v6.14 with the alternative/"proper-fix" being
something we can queue up for the next merge window.

Regardless, let's see Casey's fix before we worry too much about this.

> > ---
> >  fs/nfs/nfs4proc.c    | 7 ++++---
> >  include/linux/nfs4.h | 1 +
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index df9669d4ded7..c0caaec7bd20 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct =
dentry *dentry,
> >       if (err)
> >               return NULL;
> >
> > +     label->lsmid =3D shim.id;
> >       label->label =3D shim.context;
> >       label->len =3D shim.len;
> >       return label;
> > @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *labe=
l)
> >       if (label) {
> >               shim.context =3D label->label;
> >               shim.len =3D label->len;
> > -             shim.id =3D LSM_ID_UNDEF;
> > +             shim.id =3D label->lsmid;
> >               security_release_secctx(&shim);
> >       }
> >  }
> > @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode =
*inode, void *buf,
> >                                       size_t buflen)
> >  {
> >       struct nfs_server *server =3D NFS_SERVER(inode);
> > -     struct nfs4_label label =3D {0, 0, buflen, buf};
> > +     struct nfs4_label label =3D {0, 0, 0, buflen, buf};
> >
> >       u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
> >       struct nfs_fattr fattr =3D {
> > @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inod=
e *inode,
> >  static int
> >  nfs4_set_security_label(struct inode *inode, const void *buf, size_t b=
uflen)
> >  {
> > -     struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
> > +     struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
> >       struct nfs_fattr *fattr;
> >       int status;
> >
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 71fbebfa43c7..9ac83ca88326 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -47,6 +47,7 @@ struct nfs4_acl {
> >  struct nfs4_label {
> >       uint32_t        lfs;
> >       uint32_t        pi;
> > +     u32             lsmid;
> >       u32             len;
> >       char    *label;
> >  };

--=20
paul-moore.com
