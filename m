Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909778;
	b=K6m4ocvu/dwNGR0+4tAargvr45V7sTZpKnea1wSCerkt4zT4C5ItgJlMg/jCdfIb5KN8
	 BiXe3tNyTiqUG2+X1IZoqJBuJQ/5Bhvcq8mC+ZdNbTvAfu/eE7qCke4IpXQVbqPxicT7Z
	 0Q1YkFabcxTvIic/V2k+jxkjv3VbAJ3r4NNL/tjQ9eIJbFPz1dcZd0wRp3S9FgawWe+yy
	 Y4QCNozKJ15BaczvaGGhfmLXSS3K4PavhKBOEhQajhnG2UXOvxOH7x1k3+MHjiiaJuY/C
	 evYRhGEIqTbglzidrvOCenlWhHB2A5V6Cac9h5Lzm8kh2msy+AmJMQS9+AyzLEv7ToQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EIQy1/TAGoU8eKcCEo0zLnQFQImrjv7x5uGLH/nZ0FA=;
	b=JXAuCZU5ycjI2q0ts/RkNu1xsCzqfgZ9ymbsT0VAToWmdaBI9T34maSDziX9cH/DRXOc
	 e8xqByN0XNllCVKq8eH/Lv7xOqIoM9/XvY0Bzg3j9ZLQ8aIMA4QmntUhf1l5pRilb8WDW
	 0DYh6JG66dQqqunPxw2IhrIW2vvIu0wZ95G55TcYFptFwZvn1l4ej2yGFMbQxx0aYLKMP
	 Pcwvg9MFoqQucWTKaZLp2ZNIvHatHjh3aj1VA0iU2FEpCc/ZeFllX58tsQGYC6r3X5lag
	 MJyKLAS3zlJ0+AZQdKy8QR9dOyEtPKzeNb7dn663MMXM6UCXvZkPqeYJZbUPXY6yK5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="c9gkSRk/";
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D51606A335
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 20:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D51606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c9gkSRk/
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b07b06027eso2728140a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793909777; x=1794514577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIQy1/TAGoU8eKcCEo0zLnQFQImrjv7x5uGLH/nZ0FA=;
        b=c9gkSRk/G5cQaDx3BSrZGBoDMCozv4szM8QvS2Th579Qnisyokp/JdrpkjOZDHP45X
         iTpj6U5QGGnf4wNaEELIgCTz9BACb3zfyo046QWk1uLstSQyRlZKaqFhuH/2RLWqejnQ
         QAtnKIqy6prKraHvJKKR3ady4Fyn6sBSgjvQhgIlofqXP123yfJzkT8scbG1ZMQtH6FT
         vBBQSCt7Zdepm2bJggcyD1e6cpvu/9N6zrgr2tvZ0AleLOTZcymiNZ2vLmP6A1WTb8pa
         sZNviGhek4kHBVs5Q6xsEJSokuDU9xH5nF3FecmRtc5dzrow7+/801IJt181nXWU/7wW
         Afpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909777; x=1794514577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIQy1/TAGoU8eKcCEo0zLnQFQImrjv7x5uGLH/nZ0FA=;
        b=ak8z2nSyxIRGN0vn8sZ4onfUcIUtPBmTAkQ2KYmClkRZF71rg7gBgOFicq0sj6t0LV
         m5A1YgkYc3A3Qp1q0ovsfy5R5sDJK2p+I9FUwvgBAZzZISeThgGTBdjLqbuH2x2IA7/s
         dpKEFV5bGcTv5p2S2TPpXY3+EUI23nV7Bw04JOm8j6CxAqJzZs9yVD/FEZagtTNwh8bq
         cc1iyx2PRGMv0iFJ+5jov74jywfDhXtXnu2M7mqpMDZ46JvdHT7gB5Rvq2C5os/roO2v
         /7mmn/pvq0WKZ2ZIYK6BSbyz6OSAoCFdvyh3Oxdvd/oDWyxq6vcltXX9p32Sa9AwXV7d
         2EHA==
X-Forwarded-Encrypted: i=1; AKwUvBx7IhzTZ/Ams8XA6R2n8eZHgSULAhu0m2Vc8nA5Jf8NR1KdDcz8zuf0JoxfOU16RWvAbIXLk975+D/GSi73sZaKZrG4y3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z94wsU7NmRVWizJrGKDVow7ScovAOemJ2Wd1vUtIeeBYlSwO73c
	HEz8E/noeNqPYsZlDaACEHdPQk0U3ORfdR7IErfVpN0KLK5BzMeHDVFpyKSKwpnQPWtl5C1rMdZ
	Mmf1+dw==
X-Received: from plby6.prod.google.com ([2002:a17:902:ed46:b0:2e9:6f2c:71c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288e:b0:3ac:9669:846b
 with SMTP id 98e67ed59e1d1-3b0db5f7106mr137314a91.9.1793909776747; Thu, 05
 Nov 2026 12:16:16 -0800 (PST)
Date: Thu, 5 Nov 2026 20:16:16 +0000
In-Reply-To: <20261104150318.1156620-1-edumazet@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104150318.1156620-1-edumazet@kernel.org>
Message-ID: <auzkBSLZp4br_6OX@google.com>
Subject: Re: [PATCH net] calipso: do not charge request socket options to the listener
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 04 Nov 2026 16:03:18 +0100, Eric Dumazet wrote:
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
> 
> Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled by the lsm.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179378292255.488856.6917577451813010963@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
