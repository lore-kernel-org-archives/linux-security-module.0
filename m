Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8780C282CE
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A8820850
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vosG8vk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDKWdv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:33:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34522 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDKWdv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 18:33:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id j89so7044315ljb.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIm9vPGJNIaMjPsM0exdjgba12xrNjONltVh1DbePhs=;
        b=vosG8vk81Srj32kvLww0q8BkB81RbJaOoIyUZWM9XlMC6WmCgqnFyE7B/BQaxDPMSK
         p1s6rgaoaZc8era43bg+zTVeTR7Tdpccmev/7oyJnbuP1qsUZvTLfKo3Hj8if59uNh1V
         VU814E9FNjvJqSCA+BxJqoG544fFo7mU4evnW6Itlp17g/pFvFOzPcZZvimkT7YcXlVb
         dDG01MSa7Fob8UE70XPEBVBIssdmLhfFTe8FhzlJn1yfol7F1u9ajziT/CG8VE3vDjLH
         pCLvixL2CrCSNAxeiPrfIs/d8baoeZr0DebPlaKQcwv0zwl/tygWeW46F28tocpmtpoY
         mbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIm9vPGJNIaMjPsM0exdjgba12xrNjONltVh1DbePhs=;
        b=F2fS/HZpidjErXWrHSPJIpr0hLpsC9DmoILKd0Sq2mVtRJnhsbs4rXNKZWl+60nctu
         Am7UDUjL1vG6jB1D6A7BHJa5PPGTf+QoHH29VH55zNboOXflCGns0/GtHpL0Xj5DPwhI
         cAo66dT8xdOopZcKlzFi48yd9Kntg9MATyzm4mnmZ5OjUKXpyJKuMKeQPGH/QEy2Cryi
         jcH530VpmsVjBwPF75DueqSOjV52iLUy3bvP4nWb5YHyql0dq5pFYcaMjFXDQFxX5CHE
         m/o+Z8mMxJfwZffVTE8bb4JMICLToy7aI3/TcIcn16vp2huQ0MwpMbsr+J0vq17eNcXY
         A2EQ==
X-Gm-Message-State: APjAAAX6A/gDwtVll7ble4QEErG2qlzWnDZYxW6on1XOZu0aLwKpe5KX
        Wg+XVwTjdpOysOBZ0JB0gJ0Ty/cV8quG6srN5VB9
X-Google-Smtp-Source: APXvYqwvfZZp86pWqum/t1HOtoXdcshruAEFZbLnAp3+qG7MTxUlcC6FJOAnfz/gBA8We0JTvvw90E/tma94o0hRoV0=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr27938662ljc.120.1555022028253;
 Thu, 11 Apr 2019 15:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <1554128362-12274-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190402.132306.2280596762532017665.davem@davemloft.net> <b4083428-53b2-0f71-585f-d648b8fd1331@i-love.sakura.ne.jp>
 <20190403.214926.2003732231073495468.davem@davemloft.net> <4d077355-03de-0b8a-b6fc-51757eafe7eb@i-love.sakura.ne.jp>
In-Reply-To: <4d077355-03de-0b8a-b6fc-51757eafe7eb@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Apr 2019 18:33:37 -0400
Message-ID: <CAHC9VhQy=UheDzhpwn7S2SUq51UmZ0MrNM+JtNdkoAi5Juscpw@mail.gmail.com>
Subject: Re: [PATCH] net: socket: Always initialize family field at move_addr_to_kernel().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com,
        syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 11, 2019 at 7:32 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2019/04/04 13:49, David Miller wrote:
> > From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Date: Wed, 3 Apr 2019 06:07:40 +0900
> >
> >> On 2019/04/03 5:23, David Miller wrote:
> >>> Please fix RDS and other protocols to examine the length properly
> >>> instead.
> >>
> >> Do you prefer adding branches only for allow reading the family of socket address?
> >
> > If the length is zero, there is no point in reading the family.
> >
>
> (Adding LSM people.)
>
> syzbot is reporting that RDS is not checking valid length of address given from userspace.
> It turned out that there are several users who access "struct sockaddr"->family without
> checking valid length (which will be reported by KMSAN).
>
> Unfortunately, since tipc_bind() in net/tipc/socket.c accepts length == 0 as a valid input,
> we can't reject length < offsetofend(struct sockaddr, sa_family) with -EINVAL at
> move_addr_to_kernel() which are called from bind()/connect() system calls. I proposed
> always setting "struct sockaddr"->family at move_addr_to_kernel() but David does not
> like such trick.
>
> Therefore, LSM modules which checks address and/or port have to check valid length
> before accessing "struct sockaddr"->family in order to determine IPv4 or IPv6 or UNIX.
>
> Below is all-in-one change (for x86_64 allmodconfig). Well, I've just realized that
> move_addr_to_kernel() is also called by sendmsg() system call and for now added changes
> for only security/ directory. Is this change appropriate for you? (I wish we could
> simplify this by automatically initializing "struct sockaddr_storage" with 0 at
> move_addr_to_kernel()...)
> ---
>  drivers/isdn/mISDN/socket.c |  4 ++--
>  net/bluetooth/sco.c         |  4 ++--
>  net/core/filter.c           |  2 ++
>  net/ipv6/udp.c              |  2 ++
>  net/llc/af_llc.c            |  3 +--
>  net/netlink/af_netlink.c    |  3 ++-
>  net/rds/af_rds.c            |  3 +++
>  net/rds/bind.c              |  2 ++
>  net/rxrpc/af_rxrpc.c        |  3 ++-
>  net/sctp/socket.c           |  3 ++-
>  security/apparmor/lsm.c     |  6 ++++++
>  security/selinux/hooks.c    | 12 ++++++++++++
>  security/smack/smack_lsm.c  | 39 +++++++++++++++++++++++++++++++++++----
>  security/tomoyo/network.c   | 12 ++++++++++++
>  14 files changed, 85 insertions(+), 13 deletions(-)

Some minor nits/comments below, but I think this is still okay as-is
from a SELinux perspective.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d5fdcb0..710d386 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4503,6 +4503,12 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>         err = sock_has_perm(sk, SOCKET__BIND);
>         if (err)
>                 goto out;
> +       /*
> +        * Nothing more to do if valid length is too short to check
> +        * address->sa_family.
> +        */
> +       if (addrlen < offsetofend(struct sockaddr, sa_family))
> +               goto out;

SELinux already checks the address length further down in
selinux_socket_bind() for the address families it care about, although
it does read sa_family before the address length check so no
unfortunately it's of no help.

I imagine you could move this new length check inside the
PF_INET/PF_INET6 if-then code block to minimize the impact to other
address families, but I suppose there is some value in keeping it
where it is too.

>         /* If PF_INET or PF_INET6, check name_bind permission for the port. */
>         family = sk->sk_family;
> @@ -4634,6 +4640,12 @@ static int selinux_socket_connect_helper(struct socket *sock,
>         err = sock_has_perm(sk, SOCKET__CONNECT);
>         if (err)
>                 return err;
> +       /*
> +        * Nothing more to do if valid length is too short to check
> +        * address->sa_family.
> +        */
> +       if (addrlen < offsetofend(struct sockaddr, sa_family))
> +               return 0;

Similar comments as above, including moving the check inside the if-then block.

>         /*
>          * If a TCP, DCCP or SCTP socket, check name_connect permission

-- 
paul moore
www.paul-moore.com
