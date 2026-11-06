Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006411;
	b=mb8/DVZDPeZuGy494irCItAVqYcgFC6euRGn6Ya/Ke7fV/pn29LDDot8jlahzMeQMbO9
	 UWJeLu6DrqcZEdThXinxmzfBxGLIzae2h3BdB+hr+n7WVj8XNUoXicTNXqV4wxRx3jBfu
	 lkpW3R+uwi955OuGIiCk95u34tGBvls31Z0JDbp84nOZJUSJxzsLaZgEmKhk1AKMx/80M
	 tPUm0Z1i6x5k8jI/IlXO7JazBDaUhf7AnLkk9o/Mc0WzKnWzw5DDmZT1voRM+qy2bXDjB
	 oj/G+XDsdGduduGB5qEKPfJrKt1FCFQIeRYsXRrtZd+MGG6AilGcu0yKwAN+9NEY1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006411;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OVffpMJpscIOft4NV2Jq0DE8YsEUp+bRS1xd5OErd84=;
	b=xt1fhmEM/TBkje39bdRwPWs8Fm4kChgUBOP+mduM7TWa0YbstJjlWE2GPnsiuoHNZyvX
	 Yp+tqeLeQp4tMhFwIQsZgYoT1utkbm8FkaVTBzjFBVC4fZNBrvMdLu8WoOi0r9DpoaxLZ
	 bKAI1ghnDXEaMwa8iR1P3scqdn1Gp1PObYVoGIWnyjaKcZsUojYTth7Mekozz14r5MxaQ
	 iZ/ol+r5B41FdgXf3GHFdux/azokcHrrHlhaWQdfGj9AVdW0yBEM4j5X6SiSnH34lQkV1
	 jcHQzUd8KpD9uCol7t3hoakD/by/lRyzK6kxFSCh5KJdLmGnyRIG0USYcYNWe4IHHXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYwNIh8Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1B606A32E
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYwNIh8Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2D61F008A3
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 23:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006411;
	bh=OVffpMJpscIOft4NV2Jq0DE8YsEUp+bRS1xd5OErd84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OYwNIh8QKo6/ciABJWZoZQ2F11ZJxzpsNlhkZ8/01rtd6f6oTTOdG1NxYR1HW9KuT
	 LHEuJThM6xdBL1T7dj+RSPuu3ZR3wZBj5+lsFciuyUk5TgUIFP925g4XwXCptwPrdS
	 cSGyEK2GDAjS4l2U7gLx29alPdQIGAbIofczc2ymmR0Ex1p8NQ7ObdTracIRtb7izs
	 dblSPzucqwbwi2KyXyuYqjlEwKOqbdIW1AiqyzDkYGpDcanjOBNjZIdgtIciMT4KAK
	 qX01LM2nNseoFhTVU/yeSZtXrxtvpZKax5Cw33IApSeqsQFrNfF8wUNucNfRwPdFje
	 IQussb2MR1O5g==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f48c750afcso699586a34.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 15:06:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwgIe9cGdnY6ITExCLHEsRiZiv/GhFW4E/UX/OkE1P5ZVyDT8YOk5hMKUPy+JaJrcnlrBTqLhOWaYJRB2l1U4eiQ+GJxD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xv8SCvYePMqjH6ZZLDF+UCP5sbCgXIksgx9HFFUooRvtwKhVg
	KeiRPT/Hv/TuvejKMOmark9i22S5voj2PchBRGq4+I6X0jPiaqEn07dMWsN6788BEKUC0BuXJMv
	atByoMusYEabotg9+eHEu20HH4hBy5IA=
X-Received: by 2002:a05:6830:2693:b0:82f:5471:4dd7 with SMTP id
 46e09a7af769-85f1d16d8f2mr4156210a34.30.1794006410384; Fri, 06 Nov 2026
 15:06:50 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 7 Nov 2026 00:06:39 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
X-Gm-Features: AclHuK85IAMcn42mvCatif5dGLCxV02KCNk7hXkKoMekgYmtNrFJzX8kSNTk-t4
Message-ID: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 22:40, Jann Horn <jannh@google.com> a =C3=A9crit=
 :
>
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must alway=
s
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
>
> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> propagate memory allocation failures.
>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I've sent a separate mail with a reproducer to Paul Moore.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Side note, not for this patch: Smack calls netlbl_sock_delattr()
and netlbl_sock_setattr() under bh_lock_sock_nested() only, which does
not exclude a concurrent lock_sock() owner such as
setsockopt(IP_OPTIONS). Both sides can then kfree_rcu() the same
old inet_opt. This already exists in the "cipso only" branch of
cipso_v4_delopt() and in cipso_v4_sock_setattr(), and with this patch
the copy branch has the same issue.

The rcu_dereference_protected(*opt_ptr, 1) in cipso_v4_delopt() hides
this from lockdep. Smack should probably use lock_sock() like
SELinux does in selinux_netlbl_socket_connect().

Thanks !
