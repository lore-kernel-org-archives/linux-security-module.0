Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700051C34
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jan 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569380; cv=none; b=rIuABng7pfQzkelTg3+7AWEn6I65AnuJqNBkyzFKjZYvVqlVZjE8hBX6e3zsM3rnzBMqVtuLQOdaEMz3MCyXNsAp3HlYQjI2OTZ2Q9Xc09eu0nHsMyK4MfoyWK+8PN+MWP7SJy5rY1ycRwm1Biu5g15hTB7ixCUbCjTHGnIU1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569380; c=relaxed/simple;
	bh=mbsVb4/+yu3Zf0bRTCy8Zwk/hnS7z8MpxnsAC0RCJeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRNBh2MkEQzNPsw+jccDMsYnK3r4rH5ZWjFESHMYYt7h8OwMxsB/FZwkBRidrAYbTYpormsSgPPjxv0CZkJE8WIW2gg0Uo75PMleKPVK4RROitbb+UcF++YG/ebJp1Cr57QTALbB71aBl+hkx8aVO+AQcQkbg+qiLzQ58dlQ7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ImLcqy/I; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ImLcqy/I"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc25099b084so2512220276.0
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jan 2024 15:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706569376; x=1707174176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtl2tQuVJr4sSMyVZL/zfLMXHDpRGDa69MttDkr3/CY=;
        b=ImLcqy/IMqwiR61ydieEYyO6IkIZWSDCjdmA9qPZzXp40TDg0VViTEOpkgxLRyW7xB
         dzqySbWDPMnbqmiO2VyMR1iABxAqC9uGJvdhszzwA5TaiFXuA/5vL98eCUahZqDGNuQi
         4dOPgdQ8ktu2hqmQFR4xiJBk7mUqSKYpL7RgdCsH5wpz0DWEfapshL1jTqt+poVS7j91
         +YBCrr9lJTmiLN5m6rulnSImNJIGsB31udaxsiRqvrHlxpOdmR+A+cWujsYdq+rLZAqG
         Tc7CFiF8bZE6EuIgxVB4szPDaEllliZ6Y1+ysK3Y2F2y2xUGkgmymrXt1/+XMqi1UCTK
         jNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569376; x=1707174176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtl2tQuVJr4sSMyVZL/zfLMXHDpRGDa69MttDkr3/CY=;
        b=q1OkafUk/kktsMXfzykX51kMQ0PvGdaqzbH+wmMfjleNDOsjjFzyJt8mZUS8X5bNjf
         XFknss/tc40RqYaVCFoetyps2NF6NIZTrZJC9DtlNHxdVFDQvH4SZC9G9y7sd00+1bom
         f6G4f3Oy4joBcOCi1mIbjQsp4gvCydNXr/Z8Q/BJXOrxNs4SW8X3R22V0BvY7GEdLitS
         VmZEYqhTaladPukI5jMwPiL8V0bacRZHSwslwM7QykRgWQJenVpsn0wRkOMf8H1jz1In
         FqtKmY2CW4wsFP8Pl7wNyZF3qS6biWLuhaeE/ELeblIIacfAK2ivoVyzmKqQ6uYAcXtj
         gYQw==
X-Gm-Message-State: AOJu0YzEIvLULidNnfchBedJud2PTVDtxKTY46vvn6lcqWVxxOrb0N4+
	E/CFld76R2J98XQ59crPCIND9CcEKnK3aWTuAuRbk5X805Tbpti79qNDHIrxe2RRXTgsyH18cVG
	AE4KImYflBIeUgz0iFUTrbiuqMgi8Nd1IIrWVEwVvAWITIrE=
X-Google-Smtp-Source: AGHT+IFw0zYVr9Dl0Gbe1ksxUJfQKO+FVfnhHvHnP/sETDlJcFzAIJHzZXz4ECrkHPjGs6Z6gQ6Q1FvC37qUd9sBa78=
X-Received: by 2002:a25:d84a:0:b0:dc6:4927:9142 with SMTP id
 p71-20020a25d84a000000b00dc649279142mr3146265ybg.131.1706569376582; Mon, 29
 Jan 2024 15:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126184531.1167999-1-omosnace@redhat.com>
In-Reply-To: <20240126184531.1167999-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jan 2024 18:02:45 -0500
Message-ID: <CAHC9VhRy2uYmfoWYx57P6dRcZsJHmgCmdixi56hUoO=YvOqa5A@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix default return value of the socket_getpeersec_* hooks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:45=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> For these hooks the true "neutral" value is -EOPNOTSUPP, which is
> currently what is returned when no LSM provides this hook and what LSMs
> return when there is no security context set on the socket. Correct the
> value in <linux/lsm_hooks.h> and adjust the dispatch functions in
> security/security.c to avoid issues when the BPF LSM is enabled.
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  security/security.c           | 31 +++++++++++++++++++++++++++----
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 185924c56378..76458b6d53da 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *so=
ck, int level, int optname)
>  LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int =
optname)
>  LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
>  LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *s=
kb)
> -LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *soc=
k,
>          sockptr_t optval, sockptr_t optlen, unsigned int len)
> -LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock=
,
>          struct sk_buff *skb, u32 *secid)
>  LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t p=
riority)
>  LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
> diff --git a/security/security.c b/security/security.c
> index 6196ccaba433..3aaad75c9ce8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_t opt=
val,
>                                       sockptr_t optlen, unsigned int len)
>  {
> -       return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock=
,
> -                            optval, optlen, len);
> +       struct security_hook_list *hp;
> +       int rc;
> +
> +       /*
> +        * Only one module will provide a security context.
> +        */
> +       hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_s=
tream,
> +                            list) {
> +               rc =3D hp->hook.socket_getpeersec_stream(sock, optval, op=
tlen,
> +                                                      len);
> +               if (rc !=3D LSM_RET_DEFAULT(socket_getpeersec_stream))
> +                       return rc;
> +       }
> +       return LSM_RET_DEFAULT(socket_getpeersec_stream);
>  }

I'm beginning to wonder if we shouldn't update call_int_hook() so that
it works for LSM_RET_DEFAULT() instead of assuming a zero/0 return
value.  Thoughts?

--=20
paul-moore.com
