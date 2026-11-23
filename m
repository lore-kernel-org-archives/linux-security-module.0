Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475980;
	b=Dx3h9MsepGijssN7CJ/LcI2Xpg60RlB1CTI/B8+E6iCqW5UqJmSMFLX5ckyUJjzhjTiW
	 wRrmubEGL+jm/xmyKQFJlOZ2l8tWqtzshYWuoIv9PjgxyM8eEEc8g9Svxoywp97PKFM4C
	 B9aI/4EYWbmKmubi9CgBafgAQfFRILbZgPm4GpzRQy4VGU+w/tgc7j/FDATnIGHpHCVKG
	 KFfIfDTYM8pQ4rsoKygm+PuH7LUDbhJp7yk8xN8RAZUNuwO7bTNtqMqtrA9U5ERvSzKSk
	 ZCCDxZhAB8prz3xRA4PWRTKvgmJzaymB9suQKu9GaH+e93R6Jh8TafkpLq+NoIhSodA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
	b=0nlL1dZsbPFE8DuohJhChdExFOfabNFNZ73sj4Fjv4C96KZZgiV6HkxqsgA7uQS7avYC
	 QJ7KlNQto1jRpuWyfAuVRI6vQ5zfMhw6Z0IQAnX4+fmAThcDr3xwWQhdOrrH8mHc5TJ9P
	 z3/jR9Bs0mQpZB5O78+0LbPwY309fukbEjt2HWAxPRXsb8NgSryVia/QoVgOTm9NEgtwh
	 dT3NRghgDLASNA3Y5NVyWRC5MSi7fvutEuGqjkM0AS8piicJKqZarlZZkXC6v0pw+93GY
	 TkGHfpbO0HGvuA48rDqR7aQ9H43+NU+aYLhCx+f09V31QUu9/9Dq+rk1YbwGBdOa6Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="RH0V0w/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC65606A332
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 23:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC65606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=RH0V0w/Y
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f02b9c1f6fso25891965ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 15:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475979; cv=none;
        d=google.com; s=arc-20260327;
        b=Au2XRw+SJdHLqgp3F9JfPO9gdMFPUKhQyw+FAQ+ssrBD74coFV3OVPIhGdmi44oqI0
         CAn1Wn7QSh1IO7vEqobSP6YzivMFz/ZCxUcoIwE3xL4CaDWae7kelOFWYsHxAFF4bAJ7
         ZAsdor5QZQa5ADODQrc504HVodcwqGHk8TgSqLtY22J6/pBB+LNKz7/Sv1g9/IoEWpG7
         xDVG5APx+2pnk+Yt/FuL0YSVSbHIf+/+pWgUf7mZRLBmc8azQyo4G73T0yF4HXsDdlHz
         WEoBHDhDzjLXHe3OSjapUHKLS7PaAQeGJjYbU7kQNPExQIRbtA4N56ftlihylvNhMzm7
         JzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        fh=qBBEho+3HxCXRMb2Pmo/+nvadzHwzecLHZDwvwKFQa8=;
        b=lmb7DY5ta9o+m4J0UnEeXUTm4vRdDJBb1YAZB1eaXren6o/c8ltLM7ZIqzwGyAFg0i
         mIk/sd9Y0+INqVfXkIKn8526u7envW4wZPE68vQjJ+LiUh0K/1kfTOP4KPrOD3vhh6nP
         35X4JcWdVRQG4fB2lUMV/vUaqotfAQtFgzO9DbgRJFwn/HcMlTQux1h+ztLnwo/FPDYN
         lMdB0kxqtgxgnH9kgeqaLrQEOknsxGI26cVBQ3ySc77d+LNhZNFF8hc01lFyiFPbLAgg
         dwC9iMv9/BkTDDeZQBYWkAqFTWTTWIgbMrKZ/elhMmb4VYTIvygGajZkPQQB6Ch1uX5V
         4L7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475979; x=1796080779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        b=RH0V0w/Yr/Z4AMRG2tN8F5gjksBm5yKNRTXUsuF/1NCZKbxj6Px+gUwAwti0vvEIpt
         ze3b0AYAjegli3ajVz8reHPYaQTczy5D/5H8TnUyeIVMRhXGJnsSb2RnhkLCYbicZhtS
         ZETTU1BDFAWMBEqZg2gXH/dKYu5ciTgugb+pbPvjad24YoECg7uC1XTQp+k2Mtqfn/u4
         yQUYcoahFdNOsiB3bh3TXDCfyjppcwNpsbv48RHxu13sF+IUnNZLd7/GZ4I98ylOdH7Q
         mlftfwPpLhqmf1SaXDEf4Z+0c98TbjBQ/xj4UXn4EhbvPUieaPwitbh/1GX9QXJhge1z
         U98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475979; x=1796080779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        b=LfRb9O4Mt7Akof6IMeVvKJ0HI5JQN9lAjgX/UX5lvGHlGL2SVPzBN4O5jcmKOflAmt
         Iwpkz9F0iTFNK1xeRH2unallE6oT0vitlURjm7+N91mUK+kaOkYiab6bUrrCtUgHyYDD
         IDYyx/yh/ZB5QFINQ5n2Et+60gh+KYrSBNwT1wlpAhOKox24bMC8UuERhctPLZ0ngsdn
         96T8nW0b4/6VX0XDnHUvYktDCBI14l9bn02WUnMxQTJ8uYNNeYYdn3Rjd/ifUtuGk67G
         IeM4BeKmrnLFdYM7eff6a7hrdHbPI7Mt+iZdoVFel7Ia320ezc9tXuh7jbYfVHRze5m/
         m/Iw==
X-Forwarded-Encrypted: i=1; AL+hErE0F97tcyvSXBwoTp5J8WIz9hIdgY4+95a1D1K1/QSs9wE3LYjqNgMaScOTQ5Ez9hifaKxqE3iih8yaldBq7CMk5SgA8Do=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h5e+tOuYqOOAA6WNLP8IbBJqcJXLI0xI+4Y9qMqNNAN/U0xNx
	yt6HKIFoE7RbGwfDWdwelsK6E67EtKbPwD1SweCrNtUFpfMSgHZo79KZvacMfY+doVp+aNQ7wfV
	a3Ar3IHiavmvSENfN0SzFGli0mCg/lPGAD4b3QoKc
X-Gm-Gg: AZFdTZfP6ApCm5NMO+D6wt4sQ+1zYCt+JhGTGqntAODhm2PVRdpb/tyo0aT//21OgwL
	0aX7zXGjWeTiAI+RWsV7x3MISZvwpv1/Zb4vcxiQedvoAK6/fvlKsuAdTgQYZNGiKr+qJKdaDEB
	0XblV91FL4vVC9rIo9yrHNobViJDhymtb8bSf4Klk6B3/2LjhMYQGIbth/GN1JZrQnBrhpducvR
	G+VkJwKokHV0YIXRX/NrlPpCNIX2D4VQUctOJIlMuXcLU6wkhGw4CkEZeYRxgSR6ntAV/2QPNaB
	Jlr4asZEk59zg4S98JItuboiYBrMyYBU9iRBE5lNOlJtbeEuwJo+J1xhMaYuL7P9HbhAB9y5keQ
	NM/CpqOsBKuBg5Bf+Mu9azxIFuNI+3BhiTi7hUB+6MUtH3RJVowX2uwlOpo2ZKXY6fmF7zsgbvX
	FHJPdRvnQr9eFo9w==
X-Received: by 2002:a17:902:e5c5:b0:2e9:528c:b9ea with SMTP id
 d9443c01a7336-2f03f18ed69mr94092915ad.11.1795475978663; Mon, 23 Nov 2026
 15:19:38 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:19:27 -0500
X-Gm-Features: Aa3M54p84nMzXEsFfUh5-yY_9m2RQyZXUhbb-xh5PHe7PIY590iycN_cOXWciDA
Message-ID: <CAHC9VhTXzxXECV6fwt0BaJC8jF9EBzmzoon4f7fWaJotv1PyRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] lsm: fix the security_namespace_init() kernel-doc
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The kernel-doc claims that the owning user namespace is available via
> ns->ops->owner(ns). But security_namespace_init() is called from
> __ns_common_init() before the namespace has been set up. Apart from
> network namespaces the owning user namespace isn't set at that point so
> ->owner() returns NULL. And for init_net with CONFIG_NET_NS=3Dn ns->ops
> itself is NULL.
>
> What a namespace_init hook can rely on is the namespace type and, now
> that it is allocated before the hook is called, the namespace id. So
> document that instead.
>
> No functional changes.
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/security.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The way this patchset is structured this probably should be folded
into patch 4/7 as it doesn't make sense by itself.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
