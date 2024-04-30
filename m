Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED217BB15
	for <linux-security-module@vger.kernel.org>; Tue, 30 Apr 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519862; cv=none; b=jnLgdEH77Ixh5jI4owYfYmUkESxgbIEaDbXrxxDtOFLnqcRBDh3dPAyTYp/km5clRC0QrqQNFJzdfJUJ9UmNzptFzQ6r2V7A7K79yUmqGElIcCduG7UAgQQAmJIFGfq4TFYVHOrdzefZxjPhHjIZbcqlLbHDAdpxCXfH8ojvJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519862; c=relaxed/simple;
	bh=v6l9Dy+zgYtQANqNrAuYoV7RtibvHv1t+iO26o7M3Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKdaA44sv7DwFk/IzoOybtk6OEU2/R4VPnvLW8o0TQtzwWr7h7GFOic2l9JQK+UFqsgfYfB7kTgIdSVaXK0twfAP5pYWkFHtj9rp3wJSU8s1c5O+H5q4qUbGgqbEkYzlzbjeONu9dtC++pOBz6iTh9UHiGe1Y4nueV9cBM0TYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a6v5uoMK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a6v5uoMK"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61ab31d63edso3524007b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Apr 2024 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714519858; x=1715124658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5280T2pBS/YbunN5H2zYRs7nL3ElBlSDV8493aHgyE=;
        b=a6v5uoMKRiOMIwe3EjXwS450hqEDI1KglS3r9NJBLB6AsnNxqdKvV2zmI8E3diO057
         wKEzrluT5vGupnszjOM/7pPWmIiCCROu21WlAiarwjttyFsPaF3rTM71Luu+GSVTvb2U
         Gt56iwax6RnsUnd6TWitdO8XoX8Mcl3ZwgPNCtErkcx/S2WB8hCy2S/J6g8L/NAnSpnh
         srrV9szWQiwkbWu6eDtzzDyXAo2OZkPgew/aQTDDohSKM5lC3dOsWqBSeHCwqoTP0nxW
         Yj4sOLAPhf9ep6W3j5GtVzcFiZ4Ggz9X4eSRULTBjere0vogxCLlaW5LnwOzfF2F448M
         bdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714519858; x=1715124658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5280T2pBS/YbunN5H2zYRs7nL3ElBlSDV8493aHgyE=;
        b=l63BBRmLWqSRJ2wkyPwsaPQTnASQJDPiq2N+wAv4UMYyfmfh/1SV/470NzN8b8VplU
         Y4l/vjmAKCi45W4c9jiF/jFi+QYqiaNWVXrCAOv8z5ohSnLiNvWPL5Z3kJaZZCnpdyU7
         zBMuIHLrlKrFWyjZTsg+FsfI0ymsKbwdtRp+K0xr5zBLJpMcyO+zrd5MVydrGn/4U6yf
         63aqhnqNw5ShMMMaLiExDIc1O+9VfOdLBYyuaoywGMzvDQxoCTtx5bSFPLXtBCMU5XJb
         mq1emtMUFqx+7pw7rr6EMx3HiMjVDdP6jFcSBiwU/j/QkTTssQaanOOcsiSuzqLUNoxm
         yCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4X8kcvj0aw7tQj8TevQQelQdqkj0sOr16dxFy/rMchdhc4HBNEe/Bn1zOvFxOuLNH8doRfR5SwyVcQN5lGjohYsH5lGCn6jzgSTfcyIRRX1r5wybB
X-Gm-Message-State: AOJu0YxjPfLIzo/w23rHWWrsmKy5Hdf2W6Se5jdLYL9XBp9Z2m7YFPjB
	BbCHZEusIol+RhNb3GCd3pDVjUSPeZGR6+tNY7HZbazTGXuIivZD9LdWPFOrj0Mex3v0jqf/OWO
	DEy9JA2lAipfjYb30Op0vsjYnVoMeY+dmyo2p
X-Google-Smtp-Source: AGHT+IEN86rssCp7fIMBN1SDaN+Tl6zfv0tCK8l8/Lj7AhRrV2fBoqG/dDXTgEFJVOZFzDKsk4TL/PKSCoDm4WZNCVE=
X-Received: by 2002:a05:690c:d88:b0:61a:c156:76c8 with SMTP id
 da8-20020a05690c0d8800b0061ac15676c8mr979479ywb.9.1714519858172; Tue, 30 Apr
 2024 16:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c1ba274b19f6d1399636d018333d14a032d05454.1713967592.git.dcaratti@redhat.com>
 <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com> <Zi9yE099IYtqhCzN@dcaratti.users.ipa.redhat.com>
In-Reply-To: <Zi9yE099IYtqhCzN@dcaratti.users.ipa.redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Apr 2024 19:30:47 -0400
Message-ID: <CAHC9VhT4TOBNgo4tX97GoFgTLZEtYpPMxucfWP405y2UsC5urQ@mail.gmail.com>
Subject: Re: [PATCH v2] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 6:10=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
> On Thu, Apr 25, 2024 at 05:01:36PM -0400, Paul Moore wrote:
> > On Apr 24, 2024 Davide Caratti <dcaratti@redhat.com> wrote:

...

> > > @@ -1876,18 +1878,15 @@ int cipso_v4_sock_setattr(struct sock *sk,
> > >
> > >     sk_inet =3D inet_sk(sk);
> > >
> > > -   old =3D rcu_dereference_protected(sk_inet->inet_opt,
> > > -                                   lockdep_sock_is_held(sk));
> > > +   old =3D rcu_replace_pointer(sk_inet->inet_opt, opt, slock_held);
> > >     if (inet_test_bit(IS_ICSK, sk)) {
> > >             sk_conn =3D inet_csk(sk);
> > >             if (old)
> > >                     sk_conn->icsk_ext_hdr_len -=3D old->opt.optlen;
> > > -           sk_conn->icsk_ext_hdr_len +=3D opt->opt.optlen;
> > > +           sk_conn->icsk_ext_hdr_len +=3D opt_len;
> > >             sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
> > >     }
> > > -   rcu_assign_pointer(sk_inet->inet_opt, opt);
> > > -   if (old)
> > > -           kfree_rcu(old, rcu);
> > > +   kfree_rcu(old, rcu);
> >
> > Thanks for sticking with this and posting a v2.
> >
> > These changes look okay to me, but considering the 'Fixes:' tag and the
> > RCU splat it is reasonable to expect that this is going to be backporte=
d
> > to the various stable trees.  With that in mind, I think we should try
> > to keep the immediate fix as simple as possible, saving the other
> > changes for a separate patch.  This means sticking with
> > rcu_dereference_protected() and omitting the opt_len optimization; both
> > can be done in a second patch without the 'Fixes:' marking.
> >
> > Unless I missing something and those changes are somehow part of the
> > fix?
>
> just checked, rcu_replace_pointer() can be used also in the oldest LTS
> but I'm not sure if kfree_rcu(NULL, ...) is ok. I agree to keep
> rcu_dereference_protected(), and the useless NULL check - I will
> follow-up with another patch (targeting net-next), after this one is
> merged.

The issue isn't so much about if a particular function is available in
an older kernel, it is more about keeping the patch focused on a
single immediate purpose both to limit any unintended behaviors and
for the simple reason that smaller patches are almost always easier to
port by hand if needed.

--=20
paul-moore.com
