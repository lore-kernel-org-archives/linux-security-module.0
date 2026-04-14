Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B92289E13
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193804; cv=pass; b=jpJjQ9e9XLsV8SHTsoetQgjxmOhcNy/tNB9zdVef2PpTfDN1hEAlRECkGqCx6VqkASxMvD3AUJseh7RTkfkSNHtWLbNleZ1t90TvO4oxmLwCbCsa5P1QKukx1ALE3BBTIoPAAVt9V9xG7viDOwSyh5pu6cUyld2hYkgLFjWUaLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193804; c=relaxed/simple;
	bh=J43mBV0ldP+9tAKtYP6opL+oCOolAXGommPsCXcYceI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB6G+9wDnGRc0mENn0PLHAdEyPTINJVErZDvZm/l4e9x5Rq33ekvgNZUQLNH/4PDTnhlAhWvKKkRjD2nsvs55YAqhcTGwCIo3ZC+bTIu/YQ0/bfJO5+BFqZkOFkvAC/6aeNSpKRs0CNdnKRc0uGmSzmSQDoZKc7V4M7BpLnKoow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ExZHjmi9; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ExZHjmi9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso5109185a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 12:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776193803; cv=none;
        d=google.com; s=arc-20240605;
        b=irPEBQK3yo4I+iDybt2Y8cZZ2MQcozArGh9ZDBy8n8qLFvQuTIJ5r0vcJld0K5XE81
         P3ALin9vzxi0ut3wwyx3f+eP1rnykjQyB2oySfV6+WQ0tW1rYz93Q+0B6776528hHIEb
         TwEgazB3aD986JOGDXxJb17jAkRN/HtErSEUXQdbM6sKTTaIlVJv9j1pVV0YhE/2D+QN
         uaJR2NrTIxj395uVYPGTXZXU6cmaLxl/BnbwL/TjIzPX7J1cfUjPpNBc4+IlofoJTdme
         MIxopREw7fQIuveQxjJI8MR5VWMFw14qEFcmKZP3QnhYWxI9mmi0FgGtUJbtDUFNUZyp
         2awA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        fh=Xrg700H2YnxSNPjVgg4VEdzcxS6Bfi6Ma0vxznWNsFw=;
        b=R5pUBJH8lgRPJ5ZHV/DF6lbDsYd7ixvPUrN7AubEauklmFkaJzTNVWbbLjk00n8fR/
         Iu3tqsUpRmsUbpVUK2jef0GZEM5c5dxUB5QRXU2n2SqgNvQl+WlKhQlsreFeNHNXnMBR
         JtbNGMud33GJSTPwunX1kGAc4RWdK+hPkWdDzP8XYuzQdEAp+L/mmQtFt7lWOl7Bpxbt
         Vwppg1mi4rKOTsYWcFwBH4vysO0VJq4cXzH9R0Qx7OQl06Tk0N3/AWn+Uom3mBYtzrNW
         UqvyyClAC81db9Sevzj/zFFybsnWxRwvynsA1GqloJotcqgQoxZ7GeO1yY2YgjWAAXcS
         HKyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776193803; x=1776798603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        b=ExZHjmi9lX9IqrT94HSUjWeI+fXtJcBXvwhEUc/+YY1xv8Rv+ImpKzcGEI0+GsJBIn
         cA9NXcrOzvSiojvwNGbX4DK0jsZuUP2ZcTj2ThU7Oe2DaRgIfdHwYS9MXrJ1ZSCBWAl4
         9PWauySv/so0TigMhbI/ZYT/joSLVF7peyMkEwEyT6bnq0r3KAjl//lsqY8P/l133QdX
         lwu36VEXaz4oK1WI66BvS16iEBKYoqclgb09tDV1+tu1/xOHFS7v1xF+E9HBYKEPjZ7l
         bikZWPv5Hg4OWpUONFrk6gfHgZeYgy6QaTgj3dgNi8EGhI4SDiaadQzqHtHb9yINVb/F
         ZnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193803; x=1776798603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        b=qTgThjRpdgr2frKOf7vKs2VrvS4z64o7DhahvkFpzIzic71cJGmD0/d8q19dE00Lzc
         FlXP0i8zNz/VO0j3n0jISLPESZQ+QBShteqAcqatnsfiEVZhAJhiE/L48yrwpZA4IWxi
         L0WWLvZgS5xbFRC+rM/x81oZwCp8Yju4AR6o/Gq3i9ApST9ZFHnjE4WrDRRlXrz6sW57
         l0vgLhRU9BpMY/wFm3GgTepUgcK3mShP18SNw4MNFFKVw1dWR5P6AYEzmWs6IJ1fcZQD
         ngkZgq3F19lxfbgl8uDEgIAtwXrKZzVoNtwhaLhJL6DaqCFX99CjlTm3gVgmP8KaBm7X
         ZXGA==
X-Forwarded-Encrypted: i=1; AFNElJ/H5cc+V2LfmCB00A91niVlpDLTDmEAwJPksnsXjLdUydY63vjxmHyJMn6KEqjDXTWyrU/rkMtTH1VJrsWVhhr3EaP+aMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTUM3qDL/MAgoA0xZ8y17TkKXyYAxEZfxtmUM4khNSycW43WZ
	hkaVRqgjE0ciyeOJ6O+c8E/W+GoD6mk2T89Sc+/yNgbRH+Ogil29nYtJEXX5+qfVy1wTKvpvveN
	adaxeoKZ7L8Y9ENs7SVDOsFSpF8BRz1Rel6eLCENf
X-Gm-Gg: AeBDietguexfU+2HNkoV7kZL2XLGDXyd8b7iCqK68Rnre8cgGg6Hizb5RaOOiT2PscH
	A4s9p/9ulzOlEqAo8ATrmRIrO+MD5iVxTG+48BMG5Q71l8RallkuwjYyDzhkKE53821vJs/X3wa
	EMPwTIvNXKPaJremsjZycVK9LKJh+8k5xulQaDJVbNH3R3uERkJCN37hhyYGngbZe7uYwecEbU6
	jdcVuRMeoupIIVHMkp2/3pSzu7jgOR1vyiTJhLEwbYQprvXyfqWuNqoa3CKT0hevQB91cKiGhjV
	Kk4fXTU=
X-Received: by 2002:a05:6300:615:20b0:3a0:cd5:82b7 with SMTP id
 adf61e73a8af0-3a00cd5a76bmr10180913637.55.1776193802297; Tue, 14 Apr 2026
 12:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
In-Reply-To: <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 15:09:49 -0400
X-Gm-Features: AQROBzAOdBY4w7LZBBBsHqiX9-ECTPgm0KJFmDB-WN8NELm_4E3dGLmVNUhIl-4
Message-ID: <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Netlabel has a similar issue to secmarks with its use of secids, and
> currently supports only a single CIPSO tag in the IP header, making
> multiple concurrent LSM support impossible.

That's not correct.

We've talked about this multiple times Casey.  The short version is
that while NetLabel doesn't support multiple simultaneous LSMs at the
moment (mostly due to an issue with outbound traffic), this is not due
to some inherent limitation, it is due to the fact that it wasn't
needed when NetLabel was created, and no one has done the (relatively
minor) work to add support since then.

For those of you who are interested in a more detailed explanation,
here ya go ...

NetLabel passes security attributes between itself and various LSMs
through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
is an abstraction not only for the underlying labeling protocols, e.g.
CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
then translate the attributes into their own label representation.

Outbound traffic is a bit more complicated as it involves changing the
state of either a sock, via netlbl_sock_setattr(), or a packet, via
netlbl_skbuff_setattr(), but in both cases we are once again dealing
with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
underlying labeling protocol is configured within the NetLabel
subsystem and outside the individual LSMs, there is no worry about
different LSMs requesting different protocol configurations (that is a
separate system/network management issue). The only concern is that
the on-the-wire representation is the same for each LSM that is using
NetLabel based labeling.  While some additional work would be
required, it shouldn't be that hard to add NetLabel/protocol code to
ensure the protocol specific labels are the same, and reject/drop the
packet if not.

Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
require some additional work to convert over to a lsm_prop instead of
a u32/secid, but if you look at the caching code that should be
trivial.  It might be as simple as adding a lsm_prop to the
netlbl_lsm_secattr::attr struct since the cache stores a full secattr
and not just a u32/secid.

--=20
paul-moore.com
