Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793923840;
	b=BpangNzF2K+o+9E1xgTz30kUnRXvhglue1uwRvHPVg2zu9eA/lKRDKCdHYufuJ8Q2qtr
	 jap5JIG2/uFLD5YFhCAhMhjem/c79HU8GCf3ERDff15vKevIczUw2z3HzbfmMxn4lqtT0
	 utRx2nAd5L5eCOHwdsZQTntR/SCDoqqAcwWEUVQf0ZcrqpnJ1EM7Sd/HJ+uXVtDYtGNht
	 O685S2ey7vMaIv0pyJ7IVnz5Mk9Cg0icBVRL8RN+9wwQbMKlWRj7E8Wx2Y7Olc/Yb3xxH
	 68Yh6rXbgMC0n02NH/adgfXFhYRfx8EWuFaOFZHBZX+nK1+FDhtFg+pXk+7wwM3qnqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
	b=f6Dd7Rsg7GZzSFlLxwXxowro7izcGz/hQB4woIbO8jW2EnzD1/PNmjIGw5DVoArGw409
	 jFXnB54Dyeie3zsYXDig74AtP6y3JcsGhtjxyESSoYwP+FcIOEQPUNYboptskHuIoN/Tz
	 Tb7iWYtx1tFm7uFx+O5U/prxlLIySxYaLK1yEtB2f/Z2fMlZXDdOWwRPWAJYjnT6SjooN
	 koEjr6VypMbYKTvLlju3pVuufIh+kwOkdX0sVnL39pyzVvaGFHOQNVk9v/cyzAh/Xpsuo
	 1RBhqksZlgxQ4yCDS2JmUisKaomM+yE99+j2K8qV/QLkxVzf+jV0TU9Rr0yavsN4OAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XfnqDibT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5E606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 00:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XfnqDibT
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so91609a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 16:10:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793923840; cv=none;
        d=google.com; s=arc-20260327;
        b=mgCQ+q9cmImCURiLkb05QuZFHfF6I82av5lM/+Qt1D2dRXFkYfEvOzDjvOD2CZU/Qy
         3CQgQ+PFevjIE16CCYgVx5ZZuVr3OjBNqqbw6R+6NTDBMFBWOFmhSO+7ACWB7B7FLIGz
         uyT/tVG93y1lBSYVAkpku7Fbt2iJL4q1OSGebxzEoorEDh9uF/Utt8e1a1pqLv+ad+/a
         RluQ9RuRsOzfQg3Prg0RgwvGIRvOXOmEnet+5w/U8GvKVdhvoZ416LvJ7Rik8iDjUZ60
         WVARPV06I7baSFiO1e1SiZYc2hT6+lajjQIAmry0AFDBxVc9FRwFr2WwD4pRBtB4poSW
         ilLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
        fh=pIHIld5NjgYgPqiNP0H92MrT3mfo297zdoCYJcmWzGY=;
        b=G8HBJlrvIjJOIaY+CI+3nBUc2jCLhcw1MDrNOKnFG1GwOqiJQM8zLn3Km+yY1YfumD
         HRuyq9Hrey5x3Bi6tyLvLd1yjzJlJzKwQ8hQt4H1gg6VJpf/XfmrUbcbh4hKBReq7la9
         qFsFwKIFf0HCajve/X4HcYAomDqxNdIUJDkm9Dy4TYDxMpPfBbaJ7wTBCzZwcTWhC3BW
         BYCMRk4M5PyKTmN+8ikOWQSNLdJ9iCb9ML3IRqyQix0Qqe3An2WnVD1wjfAPkJCR2Zie
         gxU4zmnjRhUOFKoLkPeu0IxwD3yyWt7AdnZdS6D1U8TjjYG7oKljO8gh3fdpyrlPY5TJ
         9qew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793923840; x=1794528640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
        b=XfnqDibTtLU96TUbfYbxCvtzm/oJJIQCbBmI/LpLqEe8l1nznTGCGrGkUoIQLd4sIx
         DzKHVznBDwCoDSoyVF12mB5smbU6ZmV7hJs1ZLnGrFbLarghU/CsdREd3XsaB/pYbCYt
         Mr6vHapI3OUTIyTr5vIDXViLJhucujvdDx4mImAbqw5K9BirkbrzZbU+wiSW2x0jooqv
         T5LLy1UnFqfE3wolq8o+Ghnpr/3X55jfnyeC+y6S7TdfLw/bRMuqGhWk62OdnURqB7IQ
         xA4T8SzSu1L3RqXVw/bH/lT1hAaFe/C/Ie100FNLLwvVznwlfmekZEBKKHXOtbT3BBsi
         JiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923840; x=1794528640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1bL50lNxWo1x/ueBX/G/p1juBW6wsfb8QdUKb7CUxE=;
        b=T8ZzToPNveqsxZwYFPgmA7yVZYJdLM6rpA+ZUOy1jN3TDhFnYXcz61c55maT24aJeS
         hF0yuDspP6UOYtifblke/pVVelKCPmLkLkEc2PIZD+ra4AABT1uhM5Sj9eKCaBDNaMqt
         jKJxWilZ5rEg4u/Dm9jZyXUHh1yiy2rdP01/keNWjO2qskhorsZeRGLpMxv/lSA7me1Q
         Oq8b20khJ1qv5kXdS+VWcFGnVEPFNKW1AT8KlHQMXoP4VlGdC88Wj5E44vMoXRjWTU34
         8eilyIiI2jOmTExomJ5dvbbXoRVh5WsoD9emhsJLFXsIeBO1KI8at20PDy6tkp0WYuK/
         SSyg==
X-Forwarded-Encrypted: i=1; AKwUvBwKT7tcpzz6KAtKgHp0wz8yRQGlVenD6h5myXvDv7JrYkLN/dWWrZ7Lm5NZkeXXzId7dPXcyHeefuevlnbM27YAC72qiSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jHHnOM1DJ36JXxqOvfT5AHODivVemaOzrar/bog2ODTHF/eG1
	FxXpWB/Q69KTytazieW2E8GielSvmv6aXAOzCUv6ViqTNQBDw9r7nPVSu8T5xRY9G73WJ2p4WZd
	Q2d6ri9MT7p0BXJngl8a6lCDL+ZfyOe86o+XYhJ/r2LYGN0QEgWPc+aZ4
X-Gm-Gg: AYBFou1NjsC8yj8j1KyYTUsO3D6iYLnjAPao6+lapSuPfPaGARtNDz4w+CliurT8EIU
	3Ty+wpZsZheoQMkbayIdMJbaRjntiDEaI05YhnwGRER7mtZnxyCurOvHYx8LWlUFLQXiiv/PSaJ
	WAYXh75s4u/Y8F+gXi9ZPkBYAbhWbJkx26HFCEaKCR0Sb4Dius8TBBeBK8vVvdoTWIaD4XQolrR
	GWqw4KAT6dqJdkwTs1ybtuZP2USirbchziB+QrTygA4PXht3pYNLIilkqR9rkckMjxqpEKeZYQ3
	cJjCicsBC3uYOyQx8JRKySPUG8+GvItA4isU8RMBs7gRBViCWgIjhpCiFnTMnj55fv/qQ6tfuER
	bETEGAbdasqWXgzLFNgD3CyvMXQuz8MKa1g6tf30YHphW05G9s1Cx9BDGPSh/uPagyZwS
X-Received: by 2002:a17:90b:52cc:b0:3ac:ffb8:183b with SMTP id
 98e67ed59e1d1-3b0db6f90ddmr848021a91.51.1793923839712; Thu, 05 Nov 2026
 16:10:39 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104150318.1156620-1-edumazet@kernel.org>
In-Reply-To: <20261104150318.1156620-1-edumazet@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 19:10:27 -0500
X-Gm-Features: AclHuK98rYrPfudZFSat64ObHfvEPYyRkfAS3zcmw2zEmSVc-KwTmWjym9wDchw
Message-ID: <CAHC9VhTSCSV-Lic03yzqU=z6OgVZGKUfdUBfYAHnezkTLqOETg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: do not charge request socket options to the listener
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
> with ipv6_renew_options(), which charges the listener sk_omem_alloc
> through sock_kmalloc().
>
> tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
> so each request socket leaks its options size from the listener
> budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
> calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
> all subsequent SYN packets. __sk_destruct() also reports an optmem
> leakage when the listener is destroyed.
>
> Uncharging in tcp_v6_reqsk_destructor() would not be correct: after a
> migration, req->rsk_listener is no longer the socket that was charged.
>
> These options belong to the request socket, there is no reason to
> charge them to the listener. Change ipv6_renew_options() to use
> kmalloc() when its sk argument is NULL, and use this from
> calipso_req_setattr() and calipso_req_delattr(),
> like cipso_v4_req_setattr() which uses kzalloc().
>
> Note:
>
> After this patch, calipso_req_setattr() and calipso_req_delattr()
> no longer need the listener. Commit 10876da918fa ("calipso: Fix
> null-ptr-deref in calipso_req_{set,del}attr().") could be reverted
> in net-next (also removing the then unused sk variables), so that
> CALIPSO works with SYN cookies.

That would be great, are you planning to submit a follow-up patch for
that once this lands?  Or is that left for others?  Either answer is
fine, just trying to get ahead of any duplicated effort.

Otherwise, this looks good to me, thanks Eric.

Acked-by: Paul Moore <paul@paul-moore.com>

> Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled by =
the lsm.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179378292255.488856.69175774518130=
10963@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  net/ipv6/calipso.c | 12 ++++--------
>  net/ipv6/exthdrs.c |  5 +++--
>  2 files changed, 7 insertions(+), 10 deletions(-)

--=20
paul-moore.com
