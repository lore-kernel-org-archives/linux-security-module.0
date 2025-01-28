Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4C3FBB3
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074062; cv=none; b=BA992CMF15GsPMZSDgvQk4OUAbGru7nRA/iBh6pLcvGJCD43swJJXxR9w2O8Qr+KZ0cOrxXV4aQJUNIOlsjt27Bcn9+9Ng/uOAV3YBiWwZdkvsunaSK5FjXfKtLXexm4hO0xGyDGkc3EtsPUK+9lq5onR21ifCiuNUNsfhuYwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074062; c=relaxed/simple;
	bh=D9oaxmNhn8bPdVAIadKxuci7iQwJYkfAW+dvYSZC5Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THMzxQaRUcCZSpIXqEPxcrj/QbTUkAxl3RSAWgTNcFMphdWP5m9ojAbbOSM3P7XAuq129VlCeFYr1efQqIobKoz3v6EHA+oJj7y4XOX2HBA/eukz6XPn1epPMzUw6MfkvJF9F7Vn/r95rQAHSF19TdQcwU/FfZtqJCslqDV5VHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z++VAZR1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z++VAZR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738074059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDtwGzyLUhFclHuJegL5qQB4wHn79dxySq4hBsimLtM=;
	b=Z++VAZR1sJUmVLUYJ4UEmWQdSxgtCUa7EiKesGUn4d1F4kjUC87Bm/ck7oADNZz5NlJPwD
	s1UCE0BSR6LpgWz8tMnVtuSW44hou4LXeHEWWw15eTpFv3PWX6K433HSGBOXa7fCNpkqt+
	wrwMakIG/6R3Xe7/Xp2dgpjpAwaOCbA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-8aJjvtZgMza99l089dT7KA-1; Tue, 28 Jan 2025 09:20:58 -0500
X-MC-Unique: 8aJjvtZgMza99l089dT7KA-1
X-Mimecast-MFC-AGG-ID: 8aJjvtZgMza99l089dT7KA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso11646648a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 06:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738074057; x=1738678857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDtwGzyLUhFclHuJegL5qQB4wHn79dxySq4hBsimLtM=;
        b=WlMy1mHWIIiMnp87rSEAbyBCi1BSxb6S2u1ZcMr8OgKTHr3P/xeW6fdMm93KcvAtiP
         Iq/UlmaSHXR6x61d16m7B6v7UKqEkkPd+pxlvZxzFeehpgLUKQvs99dSYMbRglvLxzJe
         C/gXCslxQse2r9PK5DDh9JfKPCamsUeRu5QfXbMUnllLRmKbugkEY3UEsZNn8c+zV/2z
         zu6mHdguC3rbdwqYdah3c6AlzVqIOPSO1SKrksza/CtxqTXDqeU/7FxXTqRskXh5LaBE
         cSGqy0rSdyWi0C23GtOzVihIjH2C4JlyO0LozDQ1fgWh+hvdfjK0XDijLo1TpnL/uktN
         mNdA==
X-Forwarded-Encrypted: i=1; AJvYcCVAMiExTLlXFGBiLxEOZmTVYpHeih9/e5TWWm9hYKyJtPqTTCvB9fIpNDv7ORoL4msyS6uAUzZt7Mm4hdnVwV2Rg0mi3nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAvws8KH1a9pAvRSAzHBJ98FUD9Izr2s55RzgKv64XQvfIEU7
	lyNrpvdQwSjf8G6njm4/aqL9Ajju6AFtoLfH5Z4DlWLcJ9IKHP6yClLDyD4wFnfVQrNJY4EKrqs
	1w8I8ob/P1mbfoNCJ5VIu95qTlVs+WbLDYDDgINkERFkQLIZxMoB0Ts1Zu3ykCmJzrtnJlEclkZ
	J3+gXZJSdxrnJobUPFqQkh4+n0+MdgA5iI4DdTdmCEBrwxD+dK
X-Gm-Gg: ASbGncsxifLeCfindIsJUsg3+bi9WZbWvWB4i1yrnKKse7Itl6JSyxySNYihto+Cj3e
	ZZ0lumzTmy+iK0RM2ZTy9I9o/wuy2uauZR0/UYzgpCpTQGN3vfztdO2Q2ctstsQ==
X-Received: by 2002:a17:90a:c888:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2f782c6ff50mr68022160a91.10.1738074056992;
        Tue, 28 Jan 2025 06:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLkoSVP9en9QzpKcY6Xy4YZ+5p8cA8G7GD7Vv+4m4AfNhzz2DAH+n7ciNQzuMlQSBYd+zt6z1HhcoTe2jxAzY=
X-Received: by 2002:a17:90a:c888:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f782c6ff50mr68022124a91.10.1738074056671; Tue, 28 Jan 2025
 06:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru> <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 28 Jan 2025 15:20:45 +0100
X-Gm-Features: AWEUYZnKMKSPkvMHSDBYDNT5dz12aid0Wz74BtrYevaWtBSeLiLEN3niiqklU-U
Message-ID: <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stsp <stsp2@yandex.ru>, Willem de Bruijn <willemb@google.com>, 
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EJTAEfNlA7t6KDBOoEJrxP2CcuYTBV7RwhF2h_KlfEk_1738074057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> stsp wrote:
> > 27.01.2025 12:10, Ondrej Mosnacek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > Hello,
> > >
> > > It looks like the commit in $SUBJ may have introduced an unintended
> > > change in behavior. According to the commit message, the intent was t=
o
> > > require just one of {user, group} to match instead of both, which
> > > sounds reasonable, but the commit also changes the behavior for when
> > > neither of tun->owner and tun->group is set. Before the commit the
> > > access was always allowed, while after the commit CAP_NET_ADMIN is
> > > required in this case.
> > >
> > > I'm asking because the tun_tap subtest of selinux-testuite [1] starte=
d
> > > to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
> > > so I'm trying to figure out if we need to change the test or if it
> > > needs to be fixed in the kernel.
> > >
> > > Thanks,
> > >
> > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > >
> > Hi, IMHO having the persistent
> > TAP device inaccessible by anyone
> > but the CAP_NET_ADMIN is rather
> > useless, so the compatibility should
> > be restored on the kernel side.
> > I'd raise the questions about adding
> > the CAP_NET_ADMIN checks into
> > TUNSETOWNER and/or TUNSETPERSIST,
> > but this particular change to TUNSETIFF,
> > at least on my side, was unintentional.
> >
> > Sorry about that. :(
>
> Thanks for the report Ondrej.
>
> Agreed that we need to reinstate this. I suggest this explicit
> extra branch after the more likely cases:
>
>         @@ -585,6 +585,9 @@ static inline bool tun_capable(struct tun_str=
uct *tun)
>                         return 1;
>                 if (gid_valid(tun->group) && in_egroup_p(tun->group))
>                         return 1;
>         +       if (!uid_valid(tun->owner) && !gid_valid(tun->group))
>         +               return 1;
>         +
>                 return 0;
>          }

That could work, but the semantics become a bit weird, actually: When
you set both uid and gid, one of them needs to match. If you unset
uid/gid, you get a stricter condition (gid/uid must match). And if you
then also unset the other one, you suddenly get a less strict
condition than the first two - nothing has to match. Might be
acceptable, but it may confuse people unless well documented.

Also there is another smaller issue in the new code that I forgot to
mention - with LSMs (such as SELinux) the ns_capable() call will
produce an audit record when the capability is denied by an LSM. These
audit records are meant to indicate that the permission was needed but
denied and that the policy was either breached or needs to be
adjusted. Therefore, the ns_capable() call should ideally only happen
after the user/group checks so that only accesses that actually
wouldn't succeed without the capability yield an audit record.

So I would suggest this version:

static inline bool tun_capable(struct tun_struct *tun)
{
    const struct cred *cred =3D current_cred();
    struct net *net =3D dev_net(tun->dev);

    if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
        return 1;
    if (gid_valid(tun->group) && in_egroup_p(tun->group))
        return 1;
    if (!uid_valid(tun->owner) && !gid_valid(tun->group))
        return 1;
    return ns_capable(net->user_ns, CAP_NET_ADMIN);
}

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

