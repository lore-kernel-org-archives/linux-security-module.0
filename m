Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926203;
	b=C55OHlMqEMxQU0Gc9uKJGAxh9+XSBg/U8If9YACrB4sE3mKVcirzOAIsfks77SSq+MGx
	 n20gYtafEeLlR9c4qVJC0tS8FZp5PeWcjwiEMwevNgL7n0sXuAeNEW+lL2blnL3FqQ/m3
	 p8wqGYRR7toTiw/7utOOSeC1UyoGFr8UfhGyi8egpP921nblYFxxVDZ7LteVgd4gsfvi5
	 sFBioUJ+0nqbRBqGt3uUNPI8ddBKzFAR6G395q6nPxYcRbs2K2iG/4ci64lFGV5C6a6rd
	 kZ3wVmLhkeqqbqxWVUS5ETSvj0Gg6aGV+94dZ8C6Eidtn2rOiYk5E8gbQ1lg/EAj1Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926203;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=li0w6gdCJPAXfcZnkZrCMDKNOMXUju5VRPPg+VyiW3Y=;
	b=PC8j+Au03mcYLpDwq6M1KANU/aD1dBgXrEVCStp/QYnn978wRij3xuxDqFSu5IDCIt19
	 Z5MhpLO6Zau0qrF5oDRJsReABo9tJzdrxitQQza59iqvwzqN4vXZ7w20KwAHE5isGjjZ4
	 dhCfsgnRdm9mySIfgLj1AzpObmVb8drmyFTFoQgVgly8MqDs7PHGS5awpRsNKHIVVrA5M
	 kMZrXN/hSlkzD+mmt6ditTOldGcXe+IsptEUBK3hi633SRhEuH8G12EEx6308dUqbBpIS
	 RedxzZMeZwUWVBtNAJfQULUaFO7j2HpJO+YBVnOY4hiINCvRgaYOM1jf0nsi0GptaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBwX3tiS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB257606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBwX3tiS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0C31F008A3
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926202;
	bh=li0w6gdCJPAXfcZnkZrCMDKNOMXUju5VRPPg+VyiW3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JBwX3tiSFVz/SCekdDd1xZteE2je6TCPRWCwHiiSLjEN7Y0A/1bkMbssSXyVdf0iz
	 zHQgL1+4ps43I4bZ3xp23SQXtbxQ6HXtCCnWjmmTceyTb9LqpBu391iElcG24drXTV
	 Pum4uP+9FgqYbVxobLO4Y8bQb2DzXJY0OsYQVe8l9E13wPg1FCI3TKxWbaS3MhHRdj
	 Og2zGGwq3GUPk5MP6SwLjRLjPJxvzExuqJ6v+j9fet6x3Y8HiA6EHzLWcMgnHTmMEF
	 HGKuVupyGbtYpEOPjFoQJxHHrB/0L216vjQPzn/tD7f1F5W9x/5VRTvdajorBhn9PX
	 aJ6Y3u3yHAyjQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-716da696c1aso136745eaf.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 16:50:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxfALiGpsE7pWwWok/TURmW+pTnI759ByAXGb9mjDhmOW4EN3nGZ/t9KU32WMmYg172p2wAAzqNFoYXSbwSj7tVP2L6Jgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zFterP2my0HeJBq9bAk7WpaQ8VbYAcNxN7FMsIvrTYMsVFGY5
	B0HZ5QjRAR806nSIB7du9SBFqrMnWnzTCtUBkTDjxYzav5nfsl4lZ+xPPpGCuaClMr0m1XaAhtA
	iAQC7uBPLdqE1VAeadZ2EBmNhFmRTCWw=
X-Received: by 2002:a05:6820:f015:b0:715:2954:68e4 with SMTP id
 006d021491bc7-716e7942d56mr812677eaf.76.1793926201626; Thu, 05 Nov 2026
 16:50:01 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104150318.1156620-1-edumazet@kernel.org> <CAHC9VhTSCSV-Lic03yzqU=z6OgVZGKUfdUBfYAHnezkTLqOETg@mail.gmail.com>
In-Reply-To: <CAHC9VhTSCSV-Lic03yzqU=z6OgVZGKUfdUBfYAHnezkTLqOETg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 01:49:50 +0100
X-Gmail-Original-Message-ID: <CAL4WiirhHK5=CC9=c=XLR5dFgU_EAH6W5tZfcvgBsXdrzRjhgg@mail.gmail.com>
X-Gm-Features: AclHuK-cUj6ktjY8HuBn4RvzP7D70TC4okO5iksryY4sTrtwiKEXTCYutGdCBV0
Message-ID: <CAL4WiirhHK5=CC9=c=XLR5dFgU_EAH6W5tZfcvgBsXdrzRjhgg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: do not charge request socket options to the listener
To: Paul Moore <paul@paul-moore.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 01:10, Paul Moore <paul@paul-moore.com> a =C3=A9=
crit :
>
> On Wed, Nov 4, 2026 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@kernel.org=
> wrote:
> >
> > calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
> > with ipv6_renew_options(), which charges the listener sk_omem_alloc
> > through sock_kmalloc().
> >
> > tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
> > so each request socket leaks its options size from the listener
> > budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
> > calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
> > all subsequent SYN packets. __sk_destruct() also reports an optmem
> > leakage when the listener is destroyed.
> >
> > Uncharging in tcp_v6_reqsk_destructor() would not be correct: after a
> > migration, req->rsk_listener is no longer the socket that was charged.
> >
> > These options belong to the request socket, there is no reason to
> > charge them to the listener. Change ipv6_renew_options() to use
> > kmalloc() when its sk argument is NULL, and use this from
> > calipso_req_setattr() and calipso_req_delattr(),
> > like cipso_v4_req_setattr() which uses kzalloc().
> >
> > Note:
> >
> > After this patch, calipso_req_setattr() and calipso_req_delattr()
> > no longer need the listener. Commit 10876da918fa ("calipso: Fix
> > null-ptr-deref in calipso_req_{set,del}attr().") could be reverted
> > in net-next (also removing the then unused sk variables), so that
> > CALIPSO works with SYN cookies.
>
> That would be great, are you planning to submit a follow-up patch for
> that once this lands?  Or is that left for others?  Either answer is
> fine, just trying to get ahead of any duplicated effort.
>

I will provide the follow-up patch, thanks !

> Otherwise, this looks good to me, thanks Eric.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
