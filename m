Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EBA23B634
	for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194272; cv=none; b=AmfqFXIlu3ylHmDRGMDvo6G50oQlv2/tOlhg5smCLARAsVFBaa1qht2Tfi73ZrW5UJiz/HFylwOhql+fH7DpLgdZwCkAZ5z9fotIEStEFRdqjMW+DbJ0Gfkhe0Wu4jWm9chyAMnqGdm13BUfUctrp3e9lcWGjPd4dgPZg7OuiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194272; c=relaxed/simple;
	bh=G7EyBO9aaixvVybf61PXE6lTfXuLk1htvEcQFvTJAzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw7hD0/EPPpHiwH3Ak7ZHiElObpfmid4Rdsd3d/UW2VthNUCHKsMhKSX3NoxBvU0YLr1nh3k/KOZFKdzF6I1ZTK1dABKkiuF6jOuiPmeeNUH86q0LtYOcByMRdSGmGn8zX6NpChYfrOr/D1eZtHz8Od7KseeCpV/4N6LCSvwuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d8kRfGIp; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d8kRfGIp"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71101668dedso53966217b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750194270; x=1750799070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLSaH5FJ0osFIVIC7b0ua1GAmBIi8+s8Y1MlWceWV4Y=;
        b=d8kRfGIp3RdQR+cjCI8hG3Oau0KjjVm2IcPrRSLhktOd4p0gxHWAu/iYgTGn/lY8Mo
         pT7ieg3bOESqn25Fh/zzwEZ9QmOakDGGm0qEZGpgpU1V/IYtWBFU73Ac0KkK+5bzqcMT
         CPJR+b4xJ45cwPnsuvr+cL+PHCKal30Y0O8DmhFeF4nTjm7lPtZHwl5DC+e8nmdHcN4X
         H6EhKQm728EDGDFgwr1vMMDqD9w+O9VrMhjUbPbXAInmC6fNLi9FbUgJzQtNIetWKiJA
         52amJ3mIrdqyz7Sq9VjwVWmRk4Z/knaZbtwIqKWIodpZVD0IIzoTGwbSSr9R6hZJFVnL
         YFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194270; x=1750799070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLSaH5FJ0osFIVIC7b0ua1GAmBIi8+s8Y1MlWceWV4Y=;
        b=Mdvq3pei1qq3SF/MLyEoMjeTIFxE9FNQyr04wVWjzG6K4D9vc7oOA8I+mJTssRsB/2
         S9gI4MEFklh3Jwg64DA8zf8MahgGjU2chrOwDl9zmGT2LyhVF5Fwe8iZxWxX4w1L1hQE
         v3kgttZIUE2ydCnwN1Xlj6UDFBBCsIy11v9lPoSgEB6nVGtVCDwTt+qDWoRabw1Ssa3n
         TqlwOBy2r/gZnl1JPa+f3bi07mKOClEq/uIrb/UZohMD2KaSYCLrMQswlr0qk3RrlyfS
         jBO326zwv6Gs1LGWHQyyE3gKhf/s6GKhL3lxfa8ojTt18+0v18twijaOf1ChnWL1xfYj
         /WpA==
X-Forwarded-Encrypted: i=1; AJvYcCUodEQP0RLBnmduLf0z+pxvERozWeM7AvqMMQI6D9qb0J239wIh9TFhjjxdrY08z5M1HPUjWB6iS/tmuNFokrJjyvmLdC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1dl1SJongan8+LBDHm4nkM592yZra4wdaS1WCmoawM8s3btX
	dKlYFPJwqKR3lcf+57A4Gvjd2zYjtaZsP15l9gXdvnVPta4V7yJVUAA9W2r5fq5SQQc7fl88Gdq
	VoM0bk2HCPUpbXwK2kF2AMMahhKxOow0wQeW912/5
X-Gm-Gg: ASbGnctnGDgFeGlVx84U7yXCZFBH+hbg+b67ulAse6lY6JDeFH7+i4eOHWExFknaGvi
	Z0UKtigjRQJucpNWVE76hLe/M6E0oxnuWTfWabBu5H9z6l5fpap5fAAUMzpcI2u65FePuyoXF8o
	L5kVQTm3kHDjyPMrWDvQ9zKlK9kOJOmKe9kh0QZBm54yY=
X-Google-Smtp-Source: AGHT+IF1EZ1a0hQWE4asfB5JT5FSJBolOr0rcgGVLC/42lBKbzDGscabkq8Ij553a+7rnbN0R+EVacrmZkz63U4IiPM=
X-Received: by 2002:a05:690c:6:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-71175384ed3mr212955347b3.6.1750194269666; Tue, 17 Jun 2025
 14:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616172612.920438-1-kuni1840@gmail.com>
In-Reply-To: <20250616172612.920438-1-kuni1840@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Jun 2025 17:04:18 -0400
X-Gm-Features: Ac12FXxP97gXP9l2v6eRR4pipJgnyOXpsbqjly8R6nBKnPWsPTOXFXGZ5UfFv1c
Message-ID: <CAHC9VhTPymjNwkz9FHFHQbbRMgjMQT80zj1aT+3CFDVY=Eo5wg@mail.gmail.com>
Subject: Re: [PATCH v1 net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, 
	John Cheung <john.cs.hey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> syzkaller reported a null-ptr-deref in sock_omalloc() while allocating
> a CALIPSO option.  [0]
>
> The NULL is of struct sock, which was fetched by sk_to_full_sk() in
> calipso_req_setattr().
>
> Since commit a1a5344ddbe8 ("tcp: avoid two atomic ops for syncookies"),
> reqsk->rsk_listener could be NULL when SYN Cookie is returned to its
> client, as hinted by the leading SYN Cookie log.
>
> Here are 3 options to fix the bug:
>
>   1) Return 0 in calipso_req_setattr()
>   2) Return an error in calipso_req_setattr()
>   3) Alaways set rsk_listener
>
> 1) is no go as it bypasses LSM, but 2) effectively disables SYN Cookie
> for CALIPSO.  3) is also no go as there have been many efforts to reduce
> atomic ops and make TCP robust against DDoS.  See also commit 3b24d854cb3=
5
> ("tcp/dccp: do not touch listener sk_refcnt under synflood").
>
> As of the blamed commit, SYN Cookie already did not need refcounting,
> and no one has stumbled on the bug for 9 years, so no CALIPSO user will
> care about SYN Cookie.
>
> Let's return an error in calipso_req_setattr() and calipso_req_delattr()
> in the SYN Cookie case.

I think that's reasonable, but I think it would be nice to have a
quick comment right before the '!sk' checks to help people who may hit
the CALIPSO/SYN-cookie issue in the future.  Maybe "/*
tcp_syncookies=3D2 can result in sk =3D=3D NULL */" ?

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index 62618a058b8f..e25ed02a54bf 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1207,6 +1207,9 @@ static int calipso_req_setattr(struct request_sock =
*req,
>         struct ipv6_opt_hdr *old, *new;
>         struct sock *sk =3D sk_to_full_sk(req_to_sk(req));
>
> +       if (!sk)
> +               return -ENOMEM;
> +
>         if (req_inet->ipv6_opt && req_inet->ipv6_opt->hopopt)
>                 old =3D req_inet->ipv6_opt->hopopt;
>         else
> @@ -1247,6 +1250,9 @@ static void calipso_req_delattr(struct request_sock=
 *req)
>         struct ipv6_txoptions *txopts;
>         struct sock *sk =3D sk_to_full_sk(req_to_sk(req));
>
> +       if (!sk)
> +               return;
> +
>         if (!req_inet->ipv6_opt || !req_inet->ipv6_opt->hopopt)
>                 return;
>
> --
> 2.49.0

--=20
paul-moore.com
