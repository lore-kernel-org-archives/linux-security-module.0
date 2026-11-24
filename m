Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795541693;
	b=SmpIgjVDR0uZI4aXOIKCB2bubzm+JE4HFT0fEQjnpGHWoAng/foE1/ppMG2CdF3yFmoo
	 mF7sRvjQlxnWemL7m1oE6WkzsN8/V3w8K0Ae8YdWpv2s44sN5pLzhp9CCjoXHtQEMVuwp
	 EKZcify7e/K2kYUyB/w4UdApo774GI9nEwNTcc03dwpUIVjAggf8U+DPgx0ZymWKpgJT7
	 +E9e8gDigxpGKXyYhqTldMAEEKktDnQeumAuvrYCHXBZsrWD6pTnH/hzOXMEjlHsSGgmg
	 aFp0h8+oXePPM8eVxzpNv2muMQQAbprGCoXVIcswTx/PDlVN1D0m6Iuz6VR72e0qVFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
	b=1I42HCWC7TiOp9ATXWz+vIB8TB+2OdbY6xOxgJpqn6OJqMevXjNwcartwstadQ0Y5fpF
	 R0PwjdmTuaKl4w+8w7MSntyfS5UNe1qz5wYbkx8x78E7cJptmLNpdjMR1VVNvgAD+2u4m
	 sBeBLkP0kfjpsOYU8BVy3oYABaMhFI/tAn9qxCNmeaMRcfbqMOewk9bzSHzXD/NeVYfXy
	 SK0L4VpFI7S39IJhYgzykBeKZL0nOEnFE3X8rkeY5oQgPN24MrOjzEiQa6Q06UnpndAZX
	 8IL7Zo8u7zKKmOsMJ3ZxfOrD1V7+M43f64wnfFHL+ZUoerRAsBEG/SKEQZvyFPyItYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=HHrCeQgK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E606A329
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 17:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F277E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=HHrCeQgK
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f041f88577so26671085ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 09:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795541691; cv=none;
        d=google.com; s=arc-20260327;
        b=L1vNpP28GMCW8l0MvlXWpf4xv+TBVHme7LwevEzpV/JOrMWZj6fgQ53JPgYszCvc0k
         9WIdvU3ARnngB82PGBg2tRKRWYF3jhmVFwK+9krNJLJbfUexPH1jEZiSdWlNvOp0v5ZL
         Cz83ndqZBlMM00afdK4tKj8Wr094ba8btclahv8TPJiE6Q7re0V3mM+d3wPy9KtUq+Ob
         WSTEOLITzJuOnpDBFHw28NAD0C6t1zFrHWxeQkBqGcy+wwPA88ny4/bzEvKbvGEmFybA
         25uCM59fLhUimq1id4VVZhFhikXItZkjySjL3NEAbRH8Saf2p8r1XI8Fj50eRSODswVH
         tXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
        fh=3pmUuIvn8r+0qE6PgNthcEMxGmcpAZ9WTpoNCkOEp58=;
        b=Ir1m7CnqhuX+bqQ/XPwZiutPMPRjrFwK8a0CnLVhZiHXDSNqLzgFr3dcZpV7IoxZ/B
         8uH0zYdWkbSiJwiRErev8KIxVHrztkfU5UWUdwAKo84uBZEse71HEkBa9vKQDOJreIXD
         C6SmqrUIaWp82JRyxHJMsytcVcdJ5pIY01Eff99P18Fl+u4LCN/eqnFQMb+KP5llz01S
         szQ0eQRsf1VsiN9++zSCgzzPQYy+0Xw0pmkOPr0f5zWOieNW5KF8DAqHbndUgRIt5zpj
         2q+lY+IsF5kg44H83g10+nNiIIBf7dNlx00RSlqvKJyz2vrZ28/hemJZB+zKLGn1izxn
         J4kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795541691; x=1796146491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
        b=HHrCeQgK/kBXJZ90aRHYJCoHRDaE82HsZ115cJLDYso+RPO71e0P2oCB3lgCU0MEgS
         vqh6phVdkz6ulUaoDB6e0l9qXvOSEIoCNR8KSiDiVRPP1eH/PJFHDDwfunnlA2EdZlpl
         IBc1H1MQCifglg++qUTABRftlRuR/pBz23mq1/edbPJ07HpWcQ/nQ99/W7hJb+mJamiF
         iS+HRsAVyYIlrP5fvIffCfiB9wn7spnsPetVxVjsy7/oH/YZVmk3MDTVudG9t+lq4Vov
         ZiT59zFmbR/7glqKQYhrwI/SlcgE56F6BJH34DFmhgVPkJwjU4EUv4gXctECwbp9F3xP
         kl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541691; x=1796146491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
        b=W1UQnjAlxDF47GH6jl8L+vqIsjnoPlQs+uTwoc1mIRRG++V+p59otkkbXb/DiSbpqe
         /tZauqIi1bsrvAtQ/4/jzKXG/13EVtK/I3n0r/QD6YlHPMJ4Q6sHmuHiocPmAVrhJoVC
         xuBOZIdr1bk/CSm2RdS78HLzxT8/KkyQRAsaLWvb19TNaG7oJWLncn++98wMNAK8O3yV
         l3+D0ha/m7OW5p6a4LwKG8ryUmfTOXGnH219AulJgNyZQpVblAd/HfRexvy788qlt26s
         Hq5pcQORZR6IyRQyz7qYPjZb4+nEv/IhNZz1j3SDklAqRCcCKTI9VWgbmw/w94wh6dXX
         qnBA==
X-Forwarded-Encrypted: i=1; AL+hErFv0Na/YGAf9xRtBx/tt205ik/HgH0hQef+UuIZZJeNP8LA7clCgFQiG/RmsxjGt7QRfHKt8fTucRVrClx8mcHSIZy50T4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8esUNopi+chqv0wQfguVrNdSPsv2JmP/LE2Qtr1w8CvWA6fjT
	dKLuUJ8zANXqrwOqUnElkwjk+2YsT5fIdKtpXcGADhZskQna0QjSmGIDy1lqCAzTTh/IpS1rhbI
	iOAWWCdGPCfkUseaWZn57TrBGpYUlzyAgmSw1+zVE
X-Gm-Gg: AZFdTZeefuo5idWb21Rh4JbSxy21tjh2Hrl5y0TCl9tRERPqd0rD1Hy/NDaT4GKLAf8
	0KMrH8u0nNGowskpbNovoRdhg9c5yPLZS/2cDJjg8xBo+/36UqrPUUYjcAW/QEtvVfifkT1nRj8
	JR8oRLh5NR3CC5qdbyRorZ50leQCBB4JKK7vaYD5yejzwsZJV162ZBeoKrVBQ7heOKLsmhCiGdL
	gtqvmocaTXA05NTVoxlx0C06qAqkzNQPRdxaKn1wCktfa2rXXotLAp34uPhgj8FrSZII/5uA2ED
	dJMrQJBKq54A4/4wGWQMfD+ifRzBfHG1j2jcWNGRyzoAJTU0OwfPm3yghE4eJncZLgX8+sy+eak
	ildiiNQMSlKyCFwxQ5DRwBvOK+QUcGmzt+AE08OfnNkMnu1QD9PMkQD7AXfeHY7cBNoc7
X-Received: by 2002:a17:902:dacc:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2f03ef5a25amr159510795ad.5.1795541691316; Tue, 24 Nov 2026
 09:34:51 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com> <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
 <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com> <CA+X8SdjoyJT1i1Rf08psCsLQyPQ+yU_tAH0rCQPXpkm4DF_=Nw@mail.gmail.com>
In-Reply-To: <CA+X8SdjoyJT1i1Rf08psCsLQyPQ+yU_tAH0rCQPXpkm4DF_=Nw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Nov 2026 12:34:38 -0500
X-Gm-Features: Aa3M54qCAAAH8qnzn7NrvXOlemcU2WyGsLTrIJLHcpwId-DXnie5s0o5cb3103Q
Message-ID: <CAHC9VhSY5_NLka8n-yDVwv2FmXj9DF9PWWxomGv1_-mFzZ3Pmw@mail.gmail.com>
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
To: Wong Steve <shyckless@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stevewong@hust.edu.cn, 
	kaixuan.li@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 12:19=E2=80=AFPM Wong Steve <shyckless@gmail.com> w=
rote:
> > the x25_make_new() function is called by
> > x25_rx_call_request(), which as far as I can tell is on pretty
> > analogous to an accept() operation, is that correct?
>
> Yes. x25_rx_call_request() runs in the receive path
> (x25_lapb_receive_frame() -> x25_receive_data()) when a Call Request
> arrives for a listening socket. It is the X.25 counterpart of TCP
> creating the child socket for an incoming connection:
>
> - x25_find_listener() finds the listening socket,
> - x25_make_new() creates the new socket and copies the listener's
>   settings,
> - the new socket is queued on the listener's receive queue, and
> - x25_accept() later takes it off the queue and grafts it onto the
>   socket that accept() returns.

Great, thanks.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
