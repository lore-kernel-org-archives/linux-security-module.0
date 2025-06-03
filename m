Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1A26290
	for <linux-security-module@vger.kernel.org>; Tue,  3 Jun 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944869; cv=none; b=iAeY4SNuPAvX21X5+d1FPfLDAqN5WoLdgzo6ZMg46t6qgAM2yfeTJCtGH3M7HCKSSOcNqsQRWWo/2o2oBnUbyOh9gTzXHnnpyvXQU/wb/ck/N2uZ8dosR5qkdVsz42ak+45Zxz5jf8idL3T17SIvwB8PrHM54EB7ziDDeV2kvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944869; c=relaxed/simple;
	bh=wZCh2IwvFg+tk8QbVpoHSKHHfZ8SoZIHih+3ejPjRLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlbjvbRWzQKLkJaDQMs7MmlKBpUCmFL6MyLYyY1edUYQ5Wr04BfDo1ZcewvxNTnGuYZQaRSL9snhah5ZytbXVs1vJsnXXRKrfMTLxurYvO4mcbzqIiSGluCXOriU4QRwKiMG8jxz4pRSOXTMhMMsihAggptPndGSTAX0KvWmcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcArEMOK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcArEMOK"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a43cbc1ab0so62862961cf.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Jun 2025 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748944866; x=1749549666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7GaWs/PXPSZvr9LUt4/lhLqHTYvDoyg4MZ4tHy2VtY=;
        b=HcArEMOKmgFIl+H32jPMT2jUu5FeZjr0xQ2qCwnlsa5R5RPPCDd7u+jBCYnpInfh+i
         bWpSZK6StRuNyd2V0kkw98xvYvK9yLJZV0hW1E3jucuupYSjbLu3vijb7ysbq1DyMfNz
         YQfdxr0lqIDgzmwEX60H/IsZwQu9eJB4QR/O7b1rE+X5021rvY/8/42Qs4hNgFJnTiAW
         O9ie3CTkqdbEFFe5obh/C/C1bFfTv/h3orgZsaKZFuCuk1kdPVCWvDjSTICBnlIR08kN
         JmSusAusoOgRpSbvXM6ED/tnhFWKz34+P3XzsCuOyASAv/t/YYQosu70MgwfEiXGBwB7
         oRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748944866; x=1749549666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7GaWs/PXPSZvr9LUt4/lhLqHTYvDoyg4MZ4tHy2VtY=;
        b=ebQaqX08eBJnJ4rJ0rLyPEaftQUruucnWbAzxFSQOY/xI+OZQoJOQ36PdKD75jN1FG
         D80wurLTceufth3j67nFmWhDrvULpZiB7J2AxTwqm+gy7OI5itGkKCNGt1xt7zKPFKB5
         qxy0Cm/A4W129N5OmnLUDsFNSBzGf9zphU3U0goeuMyOulDhANr+aPyjL/TJBM1ndYhb
         jTmcdhb+qJcl7OI9nfX7PM+kFTZrIOWXrL77kTbn4jqI0zuRwbV4MykC5su5wVUCVY9D
         vJppN5/LmoVYIZ69x+OMvFZIbUI7fuSPPN/8V9rt5PHXwgmiVb1VAh7prZiF+WVtM/An
         QNag==
X-Forwarded-Encrypted: i=1; AJvYcCWGqqvPG3ex/zRUGTgKT3kD4eD9WOpOrTyvDvSnXb6UsQVh0FPaOz68P+vl3JGNkcyk2MZDRmgG6l784sf5hFt08+Z8rsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoSr2SfkVfgb2IoFJBTbtTgWCUBy5nIC/QFS2zW9nTvikUuPV
	zZZf1BwEEJLIr4Tqx4OSZdPhd1/47l1q4vL1Du+gxVHxA3TBkhKrNTJ+lQG5Xu/8fgi4eWOYt4j
	U8TYgCXamESoIImWV4YcJ7OGYIqlVj2xYwrP4tkI9
X-Gm-Gg: ASbGncsmizirVzH4Pqbo1kL5K0C6MugNYHIECPgC4ZgDEoXhBer2X5d+27/glkn39Yz
	C1B9Q2xwNd9NctsWYEE2Bbbs/loVP+zMqZql3leB8R8LBnxS0+sZKmq2QImv9ykHr8UX38sd0JI
	dUX524oBgxx6qnBmnb7e16IEHXL3KJ51WnLslbYAKzhmBTuFmkCdyhAw==
X-Google-Smtp-Source: AGHT+IH6ZAybau1ja97dnGA2ipLHiEr00ZHt4uFaAfdubK3NG0MInG41DK2DLbSLv6Rta8US+2luWI3WbLos7Pbn72o=
X-Received: by 2002:a05:622a:1e8c:b0:494:771a:9b48 with SMTP id
 d75a77b69052e-4a4aed46953mr249016201cf.50.1748944865845; Tue, 03 Jun 2025
 03:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522221858.91240-1-kuniyu@amazon.com> <CAHC9VhTM14E7Mz_ToVEqpW0CQr0KEfpwZOnSzTSYdMxX55k4yQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTM14E7Mz_ToVEqpW0CQr0KEfpwZOnSzTSYdMxX55k4yQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Jun 2025 03:00:53 -0700
X-Gm-Features: AX0GCFs2R6reGA7ZPUFR84bqe6vMO5ne8MI2eaAAZVAbMde8zt8IkiCu9HC_idM
Message-ID: <CANn89iJKc==e5pzCVFN2SBzrmb6=U_5nDEia2LMn8s7wdP9zJg@mail.gmail.com>
Subject: Re: [PATCH v1 net] calipso: Don't call calipso functions for AF_INET sk.
To: Paul Moore <paul@paul-moore.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Huw Davies <huw@codeweavers.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, 
	John Cheung <john.cs.hey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, May 22, 2025 at 6:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> > syzkaller reported a null-ptr-deref in txopt_get(). [0]
> >
> > The offset 0x70 was of struct ipv6_txoptions in struct ipv6_pinfo,
> > so struct ipv6_pinfo was NULL there.
> >
> > However, this never happens for IPv6 sockets as inet_sk(sk)->pinet6
> > is always set in inet6_create(), meaning the socket was not IPv6 one.
> >
> > The root cause is missing validation in netlbl_conn_setattr().
> >
> > netlbl_conn_setattr() switches branches based on struct
> > sockaddr.sa_family, which is passed from userspace.  However,
> > netlbl_conn_setattr() does not check if the address family matches
> > the socket.
> >
> > The syzkaller must have called connect() for an IPv6 address on
> > an IPv4 socket.
> >
> > We have a proper validation in tcp_v[46]_connect(), but
> > security_socket_connect() is called in the earlier stage.
> >
> > Let's copy the validation to netlbl_conn_setattr().
> >
> > [0]:
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc000000000e: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > CPU: 2 UID: 0 PID: 12928 Comm: syz.9.1677 Not tainted 6.12.0 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:txopt_get include/net/ipv6.h:390 [inline]
> > RIP: 0010:
> > Code: 02 00 00 49 8b ac 24 f8 02 00 00 e8 84 69 2a fd e8 ff 00 16 fd 48=
 8d 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 =
0f 85 53 02 00 00 48 8b 6d 70 48 85 ed 0f 84 ab 01 00
> > RSP: 0018:ffff88811b8afc48 EFLAGS: 00010212
> > RAX: dffffc0000000000 RBX: 1ffff11023715f8a RCX: ffffffff841ab00c
> > RDX: 000000000000000e RSI: ffffc90007d9e000 RDI: 0000000000000070
> > RBP: 0000000000000000 R08: ffffed1023715f9d R09: ffffed1023715f9e
> > R10: ffffed1023715f9d R11: 0000000000000003 R12: ffff888123075f00
> > R13: ffff88810245bd80 R14: ffff888113646780 R15: ffff888100578a80
> > FS:  00007f9019bd7640(0000) GS:ffff8882d2d00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f901b927bac CR3: 0000000104788003 CR4: 0000000000770ef0
> > PKRU: 80000000
> > Call Trace:
> >  <TASK>
> >  calipso_sock_setattr+0x56/0x80 net/netlabel/netlabel_calipso.c:557
> >  netlbl_conn_setattr+0x10c/0x280 net/netlabel/netlabel_kapi.c:1177
> >  selinux_netlbl_socket_connect_helper+0xd3/0x1b0 security/selinux/netla=
bel.c:569
> >  selinux_netlbl_socket_connect_locked security/selinux/netlabel.c:597 [=
inline]
> >  selinux_netlbl_socket_connect+0xb6/0x100 security/selinux/netlabel.c:6=
15
> >  selinux_socket_connect+0x5f/0x80 security/selinux/hooks.c:4931
> >  security_socket_connect+0x50/0xa0 security/security.c:4598
> >  __sys_connect_file+0xa4/0x190 net/socket.c:2067
> >  __sys_connect+0x12c/0x170 net/socket.c:2088
> >  __do_sys_connect net/socket.c:2098 [inline]
> >  __se_sys_connect net/socket.c:2095 [inline]
> >  __x64_sys_connect+0x73/0xb0 net/socket.c:2095
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f901b61a12d
> > Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f9019bd6fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> > RAX: ffffffffffffffda RBX: 00007f901b925fa0 RCX: 00007f901b61a12d
> > RDX: 000000000000001c RSI: 0000200000000140 RDI: 0000000000000003
> > RBP: 00007f901b701505 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007f901b5b62a0 R15: 00007f9019bb7000
> >  </TASK>
> > Modules linked in:
> >
> > Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match th=
e secattr.")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Reported-by: John Cheung <john.cs.hey@gmail.com>
> > Closes: https://lore.kernel.org/netdev/CAP=3DRh=3DM1LzunrcQB1fSGauMrJrh=
L6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/netlabel/netlabel_kapi.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Looks good to me, thanks for tracking this down and fixing it :)
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.=
c
> > index cd9160bbc919..6ea16138582c 100644
> > --- a/net/netlabel/netlabel_kapi.c
> > +++ b/net/netlabel/netlabel_kapi.c
> > @@ -1165,6 +1165,9 @@ int netlbl_conn_setattr(struct sock *sk,
> >                 break;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >         case AF_INET6:
> > +               if (sk->sk_family !=3D AF_INET6)
> > +                       return -EAFNOSUPPORT;

A more correct fix would be to not return with rcu_read_lock() held :/

I will send this :

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 6ea16138582c0b6ad39608f2c08bdfde7493a13e..33b77084a4e5f34770f960d7c82=
e481d9889753a
100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1165,8 +1165,10 @@ int netlbl_conn_setattr(struct sock *sk,
                break;
 #if IS_ENABLED(CONFIG_IPV6)
        case AF_INET6:
-               if (sk->sk_family !=3D AF_INET6)
-                       return -EAFNOSUPPORT;
+               if (sk->sk_family !=3D AF_INET6) {
+                       ret_val =3D -EAFNOSUPPORT;
+                       goto conn_setattr_return;
+               }

                addr6 =3D (struct sockaddr_in6 *)addr;
                entry =3D netlbl_domhsh_getentry_af6(secattr->domain,
