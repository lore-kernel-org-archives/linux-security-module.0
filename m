Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A901D86ED
	for <linux-security-module@vger.kernel.org>; Thu,  7 Nov 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023465; cv=none; b=lf1r4a//94ZeRRCH3C8xlhjVl7YjI7DWGrpAnyGAfW5e2YenwxhRAYEGv+18qMC2tsCqBbgvR0uvGMxROq82835a2Pb/6G/rUoYhskR8y0uf6FFESLtEOhn/6+QMq5IVqDAsHT9zmxmH0XiJgr30QThsE/ykwEqgA4iM1Htfvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023465; c=relaxed/simple;
	bh=VGQa/dfmMCi7k0Ero8n21PXo6Z224JQz/T5pDsCjwTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJx2toT5GlyxwVjOPP5DjW3Y/mR+r+m0OdnEGfx/wjByukZ2VjRA8r7nDjxJdjsJEeE9TquAoZsXy3UUCz9cupR44V/CYgjpuSlF65vqizd0UHEeDHpTbJZKt6JJ27cAC6XjXY4MDB8Hurwd9Krg3Fr8wq05tfLkIcC1MdCZ4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HBc4aorI; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HBc4aorI"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so1475622276.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Nov 2024 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731023461; x=1731628261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o2QdvUrmjtWvx1OaQyam1dECjHJOE9NkQJ80zYMUbI=;
        b=HBc4aorIZXUVUO4LsJtCtlaLxoX4OcnUmFX6+qVS7xCBEU2i5FQHEnABs2cPYAj7cq
         tT4X7/GkU+H1zvoUFEcuCGmK1Gy7gtkyxOloPQUar/ymjpK8hfRqgrcuRfb8bpOwfSSe
         McwGwG5YJ45yulIBsn5T64spbJdVXgFLvOhH1dzBWFEwDZ8hzJeyVLh2khuEJyefZRbe
         QmFSQvH/+D518fWt8S+C6kxepBdbY0C01/NMyHNy0SL2zcJGVEhBn9XdwtAgAlUYVQbo
         iPGmtHTbklaA+DS+FdO9Ws812ObtuY57ggCuXxB1Nuba1XozYgBjsvhN6X8iMedmMbHf
         3Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023461; x=1731628261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o2QdvUrmjtWvx1OaQyam1dECjHJOE9NkQJ80zYMUbI=;
        b=PD0ZgLeiQgK0VEQTBfdIxJZlrkJddznrQZ8OtpbOzTQe/iOgArXlfur6Ya+wEuodMG
         YHmli14fOwepQ7UcdLNqNsHKXaONP8Q5MxowMKvzHpugSZO0MNWol9pvox5Mb3IRvJEI
         JJ6xediu+ZEsZHneI3Sx1dRIBmFb0xoqaw9zOEPm0SK30SU4Fqi3+RWoEH/zV+j5mCqb
         cxM03LLRlc8TEHiTZ0DdiLzhNkPQyZLOj0ru8PMzXGmcBsb4A/su/4+FVb0rAi7OagO0
         sSjQRxIUJDvIcOgYoyIEEt2OmJ2UITPrqQs/6EB6HuBOM1KumoI/20HRPt18YspQGm91
         ej7A==
X-Forwarded-Encrypted: i=1; AJvYcCXsJMwcKUhr6/IM24B6OrYnhvm5S5XFeMGwAf0OJI+bf6kU+acFPRbG/os/FrOklAUBDKvdEbzeXp8fkSgXYL4VHOhyjJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3Qdc+w01CoA2xCl4ECRQlg9GOEB06/xiwdmTPlqn61g22bjN
	fnNT8h5A/MvlknlL/11YiSQw4vrzxoQFIQPPMs72Tr2LPlTs06/ALuQ+ZbUTJphJPTXwEzZTtP9
	PDCfpdRoHkP5U7NAyc/I2jszBc6LnWJ7Yj16P
X-Google-Smtp-Source: AGHT+IGBMUSkXgES6Kte8jOJe/wokdN/D/ojyHVde+avcBK17qucFa9cz89V/ErnOqwmSAzAR1B9I5C0gq66/E0ugkM=
X-Received: by 2002:a05:6902:20c7:b0:e30:cbde:1252 with SMTP id
 3f1490d57ef6-e337f8cef7bmr1103118276.36.1731023461324; Thu, 07 Nov 2024
 15:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
 <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com> <CANn89iJj2sQX3rZvmbL0zQjX7K-OFwyautgAXqxNvk2M17++bw@mail.gmail.com>
In-Reply-To: <CANn89iJj2sQX3rZvmbL0zQjX7K-OFwyautgAXqxNvk2M17++bw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Nov 2024 18:50:50 -0500
Message-ID: <CAHC9VhS3yuwrOPcH5_iRy50O_TtBCh_OVWHZgzfFTYqyfrw_zQ@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Eric Dumazet <edumazet@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> On Wed, Nov 6, 2024 at 5:54=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> > On Wed, Nov 6, 2024 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> > > >
> > > > SELinux tracks the number of allocated xfrm_state/xfrm_policy objec=
ts
> > > > (via the selinux_xfrm_refcount variable) as an input in deciding if=
 peer
> > > > labeling should be used.
> > > >
> > > > However, as a result of commits f35f821935d8 ("tcp: defer skb freei=
ng
> > > > after socket lock is released") and 68822bdf76f1 ("net: generalize =
skb
> > > > freeing deferral to per-cpu lists"), freeing of a sk_buff object, w=
hich
> > > > may hold a reference to an xfrm_state object, can be deferred for
> > > > processing on another CPU core, so even after xfrm_state is deleted=
 from
> > > > the configuration by userspace, the refcount isn't decremented unti=
l the
> > > > deferred freeing of relevant sk_buffs happens. On a system with man=
y
> > > > cores this can take a very long time (even minutes or more if the s=
ystem
> > > > is not very active), leading to peer labeling being enabled for muc=
h
> > > > longer than expected.
> > > >
> > > > Fix this by moving the selinux_xfrm_refcount decrementing to just a=
fter
> > > > the actual deletion of the xfrm objects rather than waiting for the
> > > > freeing to happen. For xfrm_policy it currently doesn't seem to be
> > > > necessary, but let's do the same there for consistency and
> > > > future-proofing.
> > > >
> > > > We hit this issue on a specific aarch64 256-core system, where the
> > > > sequence of unix_socket/test and inet_socket/tcp/test from
> > > > selinux-testsuite [1] would quite reliably trigger this scenario, a=
nd a
> > > > subsequent sctp/test run would then stumble because the policy for =
that
> > > > test misses some rules that would make it work under peer labeling
> > > > enabled (namely it was getting the netif::egress permission denied =
in
> > > > some of the test cases).
> > > >
> > > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > > >
> > > > Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is r=
eleased")
> > > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-c=
pu lists")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > >
> > > Can we explain why TCP packets sitting in TCP receive queues would
> > > need to keep xfrm_state around ?
> > >
> > > With thousands of TCP sockets. I would imagine that a similar issue
> > > would be hit,
> > > regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
> > > is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
> > > to per-cpu lists")
> > >
> > > We remove the dst from these incoming packets (see skb_dst_drop() in
> > > tcp_data_queue() and tcp_add_backlog()),
> > > I do not see how XFRM state could be kept ?
> >
> > The problem is not with the xfrm_state reference via dst_entry, but
> > the one in skb_ext (skb->extensions) -> sec_path
> > (skb_ext_get_ptr(skb->extensions, SKB_EXT_SEC_PATH)) -> the xvec
> > array. But you have a point that I should say that in the commit
> > message...
> >
>
> So some secpath_reset() calls should be added in various protocol handler=
s
> before packets are possibly queued for hours in a socket queue  ?
>
> I see one in l2tp_eth_dev_recv().

We just need to make sure that skb_sec_path()/SKB_EXT_SEC_PATH is
still valid when the socket filter is run as that is currently where
the LSM hooks into the stack and authorizes a packet to be received on
a sock.

If there are xfrm packets still alive somewhere in the system in a way
that they could be sent or consumed by a task then the SELinux xfrm
reference count should probably still be non-zero, unless of course
we've already done all the access controls.

--=20
paul-moore.com
