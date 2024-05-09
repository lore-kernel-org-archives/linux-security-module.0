Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12F7EF1D
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282030; cv=none; b=n7BABw9rNNlmsSCGMH0QNSRU2U5cYTQ59KW/YvuNK2Q3IaQPGNO+ks+X4mt7mDewrpG2pf5rlmaX64W9J79dfl0KEOLMzz/lVTZ03gASGD/pTUFLGtkQ094q7r5CGzlSMx2rT4DRcha2aNwCE82YMm9Rzk0u9cwUJmx1dDrLJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282030; c=relaxed/simple;
	bh=1G0QDR8JUJFyxaGNVbL1UI3DtGhHUGbyrMYHlnXXzhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXtKhle6CJb8q8b2wnjlRy7GxhNYOtR1k7Zl+y6ID0rbgCtWQLY3oj5mz/0oSvHwvK1MksjMVZDyaRbmj+P3d6oPbiyCS+74SNKp99zeb+Mkm+9WPOhDL7bVur59UstqvIZoNwdibsJp2+/eCBAapq6gse4yVlmvzp38wE61+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HhPg85s/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HhPg85s/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-620314aa1d7so13410817b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715282027; x=1715886827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5+CpfPTydUeT3vKTfUos21UxKzlhAl+5pqEA8g6EMk=;
        b=HhPg85s/v6Htcvh2B2b1drMbpAeC4qjPAA6iOVP+p25cuKi5Ty4uiBb2rzA4ONOb4A
         dRMdG71gWQek6x0b9arUEuiUAakh2nfTV+YPcbhd6DGk8kDi73XEnzrAIkGyxHPnHztT
         1wyXrHNmXDWOyYwfLU1/g+5EEhNkPZYM7ssrC7O7tk2sZpQuSvwCzH030tL61Fgu3zdh
         BiwXGTq6CUYu4IE51Sp4g/UUYAyGOzia1JACLf82EkmrJRi3/MnskyEE9XLe0TArZRDH
         WnuXHHzGLjAP91P5dtNTo+P0bhIIi1LGmSnGxr2pMm6cizkkPd8H7pF4cnw7jgS4lUud
         Dumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282027; x=1715886827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5+CpfPTydUeT3vKTfUos21UxKzlhAl+5pqEA8g6EMk=;
        b=ovLOearF9y+lGb0xV1z7qfNLzB7s2c5XgtEFpxU01CHzPKz8tjvHk/G4jDFh7EhJbl
         Q+VEBu60tf5MFJZEPyHPYCBxM2u0isIo6NLEesowhuMRKhcwfDppi5BwxFU3PkNnixQp
         9Vx7OtnG1yR6eC7/VRGtmi7yFwcbGAGfrAEHXSC7iwfjsCWepsTJL+0J/Sw6DCvMh0/G
         L6sqXBZJWUXDvlSIEYWeMGK9mN8tGPstwpJbzRzCrSWJjNf8U1mFXJe+he0yws4vrmtt
         RDZZJYLgvooml8nkb3e87tOWaPagtsv8GvXxh8QVvHab8d58SfMNy48UAtU/Ai4RYxqB
         1A1A==
X-Forwarded-Encrypted: i=1; AJvYcCWZsc4uygmLGRorxHV/wyX0b3mXmxtxo1q9E6UDinRSbqcKKe63CXEHtXWkvLdhAVvxwndfT0QY1mdegZ0QJQ20YucbVPxE7HIAPmpPHCiOXWLYq0q0
X-Gm-Message-State: AOJu0YxZooLRHG4BAnUnDdRGnqYO13EjGgrqzZy17CmBECX7MxoHIZ1P
	lBLGCmKiNOaYOVfLU1FHWLQAEXUrfSuCHKJ2k6fjZIc2eSA/nDXHwAaBTbjFQgmjV3wllRgbryW
	pWM9TLGN2yGuPooHtDHHJwDc5TnxZxKybigSL
X-Google-Smtp-Source: AGHT+IHUWBa+ghPEnr1ieJmvlpKHqw0gEV0F6yX4442fyzIAt9aMggaDcKmU/XZYYhXknN1mpz1tA24TgG24v/jaGhg=
X-Received: by 2002:a05:690c:b1b:b0:61b:e62e:8fad with SMTP id
 00721157ae682-622affb59b1mr5628747b3.21.1715282027468; Thu, 09 May 2024
 12:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <262f71a207e8cedd388bd89d17ef16155eb2acee.1715248275.git.dcaratti@redhat.com>
In-Reply-To: <262f71a207e8cedd388bd89d17ef16155eb2acee.1715248275.git.dcaratti@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 15:13:36 -0400
Message-ID: <CAHC9VhQEa+6BQs-9jT4JR64nDGio8FbAG5smPaq8E3gi=H1SLg@mail.gmail.com>
Subject: Re: [PATCH net v4] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, casey@schaufler-ca.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-security-module@vger.kernel.org, 
	pabeni@redhat.com, xmu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:36=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> Xiumei reports the following splat when netlabel and TCP socket are used:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.9.0-rc2+ #637 Not tainted
>  -----------------------------
>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
>
>  other info that might help us debug this:
>
>  rcu_scheduler_active =3D 2, debug_locks =3D 1
>  1 lock held by ncat/23333:
>   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setat=
tr+0x25/0x1b0
>
>  stack backtrace:
>  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  =
07/26/2013
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xa9/0xc0
>   lockdep_rcu_suspicious+0x117/0x190
>   cipso_v4_sock_setattr+0x1ab/0x1b0
>   netlbl_sock_setattr+0x13e/0x1b0
>   selinux_netlbl_socket_post_create+0x3f/0x80
>   selinux_socket_post_create+0x1a0/0x460
>   security_socket_post_create+0x42/0x60
>   __sock_create+0x342/0x3a0
>   __sys_socket_create.part.22+0x42/0x70
>   __sys_socket+0x37/0xb0
>   __x64_sys_socket+0x16/0x20
>   do_syscall_64+0x96/0x180
>   ? do_user_addr_fault+0x68d/0xa30
>   ? exc_page_fault+0x171/0x280
>   ? asm_exc_page_fault+0x22/0x30
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>  RIP: 0033:0x7fbc0ca3fc1b
>  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e =
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
>  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
>  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
>
> R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>   </TASK>
>
> The current implementation of cipso_v4_sock_setattr() replaces IP options
> under the assumption that the caller holds the socket lock; however, such
> assumption is not true, nor needed, in selinux_socket_post_create() hook.
>
> Let all callers of cipso_v4_sock_setattr() specify the "socket lock held"
> condition, except selinux_socket_post_create() _ where such condition can
> safely be set as true even without holding the socket lock.
>
> v4:
>  - fix build when CONFIG_LOCKDEP is unset (thanks kernel test robot)
>
> v3:
>  - rename variable to 'sk_locked' (thanks Paul Moore)
>  - keep rcu_replace_pointer() open-coded and re-add NULL check of 'old',
>    these two changes will be posted in another patch (thanks Paul Moore)
>
> v2:
>  - pass lockdep_sock_is_held() through a boolean variable in the stack
>    (thanks Eric Dumazet, Paul Moore, Casey Schaufler)
>  - use rcu_replace_pointer() instead of rcu_dereference_protected() +
>    rcu_assign_pointer()
>  - remove NULL check of 'old' before kfree_rcu()
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/net/cipso_ipv4.h     |  6 ++++--
>  include/net/netlabel.h       | 12 ++++++++++--
>  net/ipv4/cipso_ipv4.c        |  7 ++++---
>  net/netlabel/netlabel_kapi.c | 26 +++++++++++++++++++++++---
>  security/selinux/netlabel.c  |  5 ++++-
>  security/smack/smack_lsm.c   |  3 ++-
>  6 files changed, 47 insertions(+), 12 deletions(-)

...

> +/**
> + * netlbl_sk_lock_check - Check if the socket lock has been acquired.
> + * @sk: the socket to check
> + *
> + * Description: check if @sk is locked. Returns true if socket @sk is lo=
cked
> + * or if lock debugging is disabled at runtime or compile-time
> + *
> + */
> +bool netlbl_sk_lock_check(struct sock *sk)
> +{
> +#ifdef CONFIG_LOCKDEP
> +       if (debug_locks)
> +               return lockdep_sock_is_held(sk);
> +#endif
> +       return true;
> +}

It might be cleaner to do this:

#ifdef CONFIG_LOCKDEP
bool netlbl_sk_lock_check(sk)
{
  if (debug_locks)
    return lockdep_sock_is_held(sk);
  return true;
}
#else
bool netlbl_sk_lock_check(sk)
{
  return true;
}
#endif

--=20
paul-moore.com
