Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731083;
	b=GoiymVlHGiXzJXrcvQVLx3MKUeP+N1Rr/mDxw+2TAt68FJx60Am/HK+fZ6RSiDByCHFl
	 Wg7TH204x5MBx92pGScvJnK8O2uLapiie7WtCMCo8XuUOUAtNbXikSGMchB9XNiO610e8
	 UQCEYQ7Y92ndlH4qrqHGP9AG0PrNN+XllSZfBjmboAB7JBJfBKDxikStqI/I9N7cJRkcM
	 dyJfzMGx0vDq66CZt7eImUwDgnn5xZ68Gh8GlRT6m0z9EZs39PlOJfqiSKTfKk5SCXCWT
	 Kzrc/EvLLzO1/vkq8YVb7mMnjJ1u+fnov4bh6bLxrpdO0uA3a9yalr4M9fRcnTZkQdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
	b=row/RqB8dNLjazGy1wEuM0zpSIhjMgoiIIz9a8vz5b2+GRnu3Y1t4q0eYf2SraSR5n7P
	 RVAyqEc4nVAgEVwlpm3oAebUHgwMt340hcihTi+PN2gIn9ArNk1KROr9Gsk98C2iWSyZ4
	 35Xl3B62sfQp+jFoJchqdm2l0WAp0GZxF1ARFWzsk0lk1wpRxO9u8pfLmjxAlJ0+PQP9m
	 OeGH3L4O4kAS5BDvfLHOskBXqqpuzcJQN3lURsdYvckXXvvNF/fCBuW0KMlJ6h6nZ0xsX
	 My1Ko+lBVyLzW9hV5+92hSJYbqFc/NHDCpuY89uvfw++ACHyjRa4J4v+Yj9dfW0vv9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nVCsNw0y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76E606A324
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 18:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE76E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nVCsNw0y
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so4779411e87.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 10:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793731081; cv=none;
        d=google.com; s=arc-20260327;
        b=OJA/mYRoLpiSFHVoW0nEHgY499meCw463ln1/dslX11MC1ktovugNHN9l9ZzIY4owJ
         B10NsQh17K6LklY0AupJdXS7addEFBQ6UBEscCMRuaYrgwEN/Dc7yU6AMXT9KgU7pT/l
         fgTDDOrtd7vCW7BAXA5HTpGx8G4eQyeeO/DD3p5QwGT2DHzHWKdi4RCvo+3BKkMVRqza
         vblYUg2XlhEBA9ehLx9+eiDmTm0ak3VxsGMCjYRchy/miG1QSSjhuL0Gj+AyTd5RqNDf
         G3fSt4+HOBWiJgseQL6OpwiVXyU6AWYCVAAbI4oVhl4hkRJWBZAKjd8Hby7RfRXnU4Bj
         9+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        fh=IyledhKrhJFTEEIE22S1VJyGaCQCGxlyVyG5JGM9914=;
        b=AbPFYKEcO4Iu5bxCoebxroR8WyeRG+iieKQtn5TEpLTeVxjjABFqKMus72R9PzZaVJ
         XouQi8cHu7Jrr6f/iwxYEnT/vv4PZ9foBRaaXIhFDj0m93s8M2ngmwX4648Rixlu4nD9
         ueYvljhV+0k+a8OpXKwNZy8LE8fMzpqbOBTBVaY6li42l4bi55O3epdl0UOmWoAsFbqe
         k9J08ejqZrk0+E86wH7HtSHNxc0kEz6YufaBr8swCS7Hjw+JNgC5JV4Ggg+ykpWxfeQw
         Q5gmiZuaiPBqi12dUENgdzca6ZShDblLcTNdOkWtsVehD/rA3FtNZQpXuvLqA/tdY7Mh
         wdyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793731081; x=1794335881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        b=nVCsNw0y6hskrENSBv8EU3amWuYztT8dLT5p7AwDRfBEJgh5KCH4wcnDy1+4F8oz26
         mugE2B8LWKKCR0Y9k2Z98xSLZ5eNvcfR272i+te/45lnsb9AWyAtGJcy3D9bL7ir+f71
         qQpNmsSv7T5esoFkU7QTr7zF74lmigXGg9dzQbwmAGy2M5yd+bQ/6ZIx3r0WugxBJ5RO
         hJm/oKDuQExrJP3FUtAD2VCpRZdYySsqRCW8MbRDOe9JChKA+5WjiMn7EutjmI1dtjC9
         TX6PAuZUUq43suQ5ErDcrLsoaFbkM/WfFXDhbG1erayEtyXYdgmMQ2TL7MALbarBBDH6
         21vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731081; x=1794335881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        b=K7/pgbHkzUOHzhHWRgSdWHA3DTe3tf7OXwGEujjLK4yLEydsgX0cKbRAm0E437hGRd
         Uyz/z22An4ivJXjcz64UoqJ/1evJo5wuqNHpm0AcIqEF7GVE2rG2E5oO/TcfZMsK+S6O
         NZaf/+zcpyYcAwG8gitJEAEGWoaFsxCZIwdhybM/AwEt9JfP3IXtVY7HcjDj3Ez59RxZ
         R3mO4PVI8Xuec8+C2pLHqHRd/66xDmyIadd1xvnM22+DOuPS3nsb4y1tfy567wRF0fXx
         RlbjhzfVZfSqy0jB4e4UFTFVe8aTJXfFhZmNzHEo7yI9B8H/lZsD8GL2l6vgu6dn0Wxr
         0mIQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6dBXXutW1lSjSPAOBq0aWrKg2q3WkMBHGH+lbHpaigHIZ72wNecMns2q33jIys6iXEgR57dWfr06nPG68hEFU6tlacMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hGdvdu7O8qW4avGVL0sKRCIyfiPKd/DASDfDvsCr2C9ElVhJK
	T86pqXorxr/6gv1oQVdxuTCno4/Q3VWgZcYlh9kPywrbcYFbzxDyEpnYHzfWAFebqIYBvc43Jp0
	6UHu0sGJYSe4g1PwfiThbuOuMVxsWBWwYjh2Pnfyr
X-Gm-Gg: AYBFou0vawfdGgL8pOEebBAdYerap/INy/yQSI1TjboVP6bbEZgYy3TiT0reL4JMU9H
	qz6wc6PwMkaUapdUbi/d4vev00BBREodROYIeP3XwPuSQSMj9s0zNEgA7p9YE4xLQn+N+4IlhnI
	cP9IPR2pt8lfMJQLzqkxdhV7FiChOuWFn9exX5L2S8d2GQrubv/M/ty6MTSMIYC5DiYuIAyTuxR
	0OZV5xiHkgoWBhyhEs0061Roxw5yTeNDQyfzV1Qoc466MgQ/hAfaZJEfO9q9B2ZqmkjNaBRXiyg
	t00Iz7dwqhKTmEV3/JwyBKGzq6AkfBdONUk9jg7Uik9o2qtFdC+48BUfBmcQ+fbLLTPi21cFen6
	B8Ha1ChScur3lzzvVTNSiNJR8ClH3aEdk0Q==
X-Received: by 2002:a05:6512:3ca7:b0:5bc:e8b0:5652 with SMTP id
 2adb3069b0e04-5bfd9589099mr5147409e87.63.1793731080985; Tue, 03 Nov 2026
 10:38:00 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <auM32mOlBLu6ZUlt@google.com>
In-Reply-To: <auM32mOlBLu6ZUlt@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 3 Nov 2026 10:37:48 -0800
X-Gm-Features: AclHuK_sfbKF658HbwyCTsOToNn9cXs0qzXn8uaPUG4vxi_nXA5hXmjvbt4jwHQ
Message-ID: <CALCETrUD4vh_iSHV7G0bprUFU8=c+ECo701-tXcbQ3UXBWC1ig@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:11=E2=80=AFAM Hallgrimur H. Gunnarsson
<halg@google.com> wrote:
>
> On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:

> >
> > Why should the task's cap masks affect this?  *Maybe* cap_bset makes
> > sense, but I'm struggling a bit to see why cap_permitted and
> > cap_effective should matter.
>
> Sorry, the phrasing here may have been misleading. Just to clarify:
> none of the creating task's capability sets (cap_bset, cap_permitted
> or cap_effective) are used to restrict the new user namespace.
>
> When I wrote "reusing the existing task cap_bset, cap_permitted and
> cap_effective sets on namespace entry", I was contrasting this with
> the prior series from 2024 [1], which proposed adding a 6th per-thread
> capability set to struct cred.
>
> In this series, when a task creates or enters a user namespace, we
> simply initialize its new cred->cap_{bset,permitted,effective} in
> that namespace to user_ns->cap_bset instead of CAP_FULL_SET.
>

Okay, this makes *more* sense, but I think it's too weak.

I have a sort-of goal of having the creation of unprivileged
namespaces be allowed in most contexts by default, *even in Docker*
(which would involve the Docker team changing their default seccomp
rules, but that bridge can be crossed later).  (In furtherance of this
goal, I fixed an ancient bug in newuidmap that gets us quite a bit
closer a couple weeks ago.)

But tying this mitigation to a parent userns means that it's
completely unusable in the single-deep case.

I do have a question about this whole scheme, though: are we talking
*just* about CAP_NET_ADMIN?  That is, is there any other bit that has
anywhere near enough security relevance to make this kind of thing
worthwhile?  Because if it's really just a single bit control, maybe
we can come up with a nicer scheme.

--=20
Andy Lutomirski
AMA Capital Management, LLC
