Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D921A5B8A
	for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836615; cv=none; b=KX20N1ckZhItiPAKWiFFx9RVShDJhYdNPEFLr+RT1idOcgZVT52Ov5DgPLTdpN9ZVEIVcSPIpBAIi2/IGKVe+BuMMWpKcdw5RnmGbODVv5nV+a6npxbV01OCJrZVSu1Fw3cWC1WaIvTk0MqeeejaljXe9R3cVviU7z30jG5p1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836615; c=relaxed/simple;
	bh=NHzS9de879TWXADLxJMYwU8mVvLH2hsmvpVHGZjzne4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdzaT1bHCLXtEsAaVdCLE+XvGxoCoYkWvGgYX1V4PXpG4x+kGNscyvB3q9ivAOKp4W8bHUEv5HPvKz825gdEwwEltoVvme4pHwNqhwIv6TKTX4KeAw1eWYdcRfr3vfDakRxC8VYWAoydh4TUrjbc4bRCvpOUXISEi8r2ibUfQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N7bt6Oa2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N7bt6Oa2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f754678c29so43787587b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 15:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739836612; x=1740441412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jas/F8W9i8zLaiPkdYshXZ/hrXRR+6A/SNOHNaxDI2M=;
        b=N7bt6Oa2tQg+Jc9YSq23OLJwDlmMA/PCS6D0E+SNUdy4uEu763CVF/YtCzD0cs/GG1
         KFb9zMpcnZiOMTnzODoqo0J9IjbjjC1O613gGvlCEzR0761g84OKu6yZOPf+nhV08iH6
         YeBLo88AOXy4FqylddV8pSzs6Y7dNW6EJjKybi1NfqQdvDU+hryJ3mIZXi5900iJaJqE
         siVi1UkGPqTZq9Z7W2DHAwMow5ruQA0EW0kDEJp04p7H9XfLwWyXThhHX7z1/E+LuMWf
         rIx7Kfs0+khbJ/QmR44kaPgu5UW6P+/B3zWKyXcQC3Wh3jmuUDMD8tY9dC/1Jf3cgeDi
         x06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739836612; x=1740441412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jas/F8W9i8zLaiPkdYshXZ/hrXRR+6A/SNOHNaxDI2M=;
        b=UDZ5SnsBVHdD7EvSMTjQWMOz/lBuTwW7XMWHPX+KxAq8MUnzfzE9dA9HYHWYSfh7wV
         /fsGYWX1c9NYndohqS1huwYAGnPiqOjK+7r05Yw4iI3tSK234bPNTxF9TVMTAwR5LtF5
         rth98h+0hfbo/MSqdPSUdr08bP/L8gdSeyaFBr8XS45Hhh41e72NGqoFURlkgyv4k1u2
         SP+5edkeEJZl67txIHujT8Qbd1wjnt8r42R50gnJqpnwJPPiO/lcpNr5OlBTer4R3RNj
         AcOxWQL06icYExPt2ysOAeSPAXRDg9WkL7+z1CYWvyAinornyAlbze+WWQZGDDBstLgH
         fM6w==
X-Forwarded-Encrypted: i=1; AJvYcCVHzGRlwHVYMlchybZcEuCSiby1v1cWIkxoTmING8nGbGg1t6nnn3b4eHawWXH4MnozphXKnKjhBQYyQmrjH3/kk87vZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxco6lbZH4Cl7GMSxZzoGPKjP4C0fo3cfavED69Kx7pb9jbhE
	lFRTkQTKr8z1Fjiqn6EfjptXERMSHmZ5sHAxxU4Ug7siU+ghEDje+YjmbSJaaKzuI5eerM58jwp
	2Mdqdj3hc7zndXLhOE+KmiV9TSISBzoomgC9N
X-Gm-Gg: ASbGncsklQEwR3v2d2H5pJqQgK+a6lot8Y6cFlDl2i7UANC4t6MShvBfu9UVjVrYlYr
	c8a7PiJmFCF7H9/6BmKMhs+fQvnMCKFsfdToCzUrZdJ/5B5dGFOhCBzOA/GRhk9pm9YDtPk5V
X-Google-Smtp-Source: AGHT+IE1NnhKAUfO7VvAInRISI+SUXeJ6Uhzmjkycqhi5QAWxyXx35LnVFyT4sRDPBNHcnQXxxMG1jVONtd9g9dO+1A=
X-Received: by 2002:a05:690c:48c6:b0:6e3:323f:d8fb with SMTP id
 00721157ae682-6fb5829496fmr108110827b3.14.1739836612691; Mon, 17 Feb 2025
 15:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
 <CAHC9VhT2YnbCKcAz5ff+CCnBkSwWijC4r7-meLE7wPW6iK2FUQ@mail.gmail.com> <Z7PC1JoBvgFL9JAU@hog>
In-Reply-To: <Z7PC1JoBvgFL9JAU@hog>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Feb 2025 18:56:42 -0500
X-Gm-Features: AWEUYZkdMSF0tZcmgK9ZqWa5FVg0ZtfF4pQwTnJ-2vZ598dn0XskvQG1AWuGj5c
Message-ID: <CAHC9VhSXfQY6u9MWb0kLdqVsop188JUE_7DYe8uTAYxCHf5emw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: drop secpath at the same time as we currently
 drop dst
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, linux-security-module@vger.kernel.org, 
	Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:14=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
> 2025-02-17, 17:35:32 -0500, Paul Moore wrote:
> > On Mon, Feb 17, 2025 at 5:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail=
.net> wrote:
> > >
> > > Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> > > running tests that boil down to:
> > >  - create a pair of netns
> > >  - run a basic TCP test over ipcomp6
> > >  - delete the pair of netns
> > >
> > > The xfrm_state found on spi_byaddr was not deleted at the time we
> > > delete the netns, because we still have a reference on it. This
> > > lingering reference comes from a secpath (which holds a ref on the
> > > xfrm_state), which is still attached to an skb. This skb is not
> > > leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> > > skb_attempt_defer_free.
> > >
> > > The problem happens when we defer freeing an skb (push it on one CPU'=
s
> > > defer_list), and don't flush that list before the netns is deleted. I=
n
> > > that case, we still have a reference on the xfrm_state that we don't
> > > expect at this point.
> > >
> > > We already drop the skb's dst in the TCP receive path when it's no
> > > longer needed, so let's also drop the secpath. At this point,
> > > tcp_filter has already called into the LSM hooks that may require the
> > > secpath, so it should not be needed anymore.
> >
> > I don't recall seeing any follow up in the v1 patchset regarding
> > IP_CMSG_PASSSEC/security_socket_getpeersec_dgram(), can you confirm
> > that the secpath is preserved for that code path?
> >
> > https://lore.kernel.org/linux-security-module/CAHC9VhQZ+k1J0UidJ-bgdBGB=
uVX9M18tQ+a+fuqXQM_L-PFvzA@mail.gmail.com
>
> Sorry, I thought we'd addressed this in the v1 discussion with Eric.
>
> IP_CMSG_PASSSEC is not blocked for TCP sockets, but it will only
> process skbs that came from the error queue (ip_recv_error ->
> ip_cmsg_recv -> ip_cmsg_recv_offset -> ip_cmsg_recv_security ->
> security_socket_getpeersec_dgram), which don't go through those code
> paths at all. So AFAICT IP_CMSG_PASSSEC for TCP isn't affected by
> dropping the secpath early.

Great, thanks for clearing that up.

--=20
paul-moore.com
