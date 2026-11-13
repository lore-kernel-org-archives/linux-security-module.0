Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564808;
	b=kPlXr5+FJ4YgDX0tCUGlOJbEA3JjyEJW1J2GEBy9dKNvKYzrwQXyVyHgMv4Ek62PsTeV
	 FjEsDxgdhGFkh5OiqqqJ4LIdXl7E3cO1Ti3NVn7wVlwiavR0lzvLT4GvxPVGKtwnOoC+c
	 dCGhaqoaGAcMvLijiF3q+M/u7Y1bETTjA7+WROGVS6dI33pKr/aXpmas9ne3opx6a0fDp
	 i53JMT6OdCqgwoX9jIiejA9ZiIRTvSqb+YzsyfaY7mOp4tcUhomKFj7+5XhCgJWwIRcxI
	 YnFFPJj2k0Lau0xr51qPUBXyr72Iyb1fARemCMNw5u66NA9TOkNZ7AnVacIXAK/L5UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
	b=E+JE7302KnrbW2eaQQav2FGVzDwfAx6mnXKBreGSwc0NCPJcTscCy9FJexEORF+qaITV
	 IPhJdP9ltBdL2B7uBkkR2WCxDeMubrakoUOw/pA1Hdbt826gdP4ZBTKGB/6XokI0jYjeU
	 4Fbr8HqrUSgd55pw+ggJ0ptMDTrBhAADaqZyOTZpbkn94mcsDLn8VXrMba0cYTVS1pPsE
	 fU8Z2OwgSin1pH9QvujtQ21hgqOoZ1TP419XcCLX8dxQQiLdqAO7yfuaspXY2W8xuOFNJ
	 QkCImLhChGIod8Wb/Vt4Fj91wRnaPI4/yiJ8AVmxf/cvWXRqPoEbhdUXN/TU1ozMdpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A2606B116
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022A2606B116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10214375e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564806; x=1795169606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=rqBNEWhefqtER2dpEJNVPTElbe19fVdkNyIzbVbNULqUnWk9JP4TtodfrAxZg35Ufq
         +ciPTMXXDC3Fn73QdDq1nxL10hoZ0LEMTSuk+HTluWLCH3mNQBpp5ecm/W/Lr1PQghIv
         NQThaRjLVubmwKFzY9W4H2pkvpw752j1vTd8XwcKuq70wsUgwzLrChjclsxLFe4j6CXh
         P2+zI4RYwkyiSmtYnxi7mmM5Yw0kfqLENKBervoD5JNkytp6QIULxp+qmuf3k5WOFN+d
         HC6ACfaHkSpUVoBZwd9XYoAangfmrtxV8FymQjjH9iY0qoozDauX1oxEdXhYxV5zTWYW
         c/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564806; x=1795169606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=1JMxOEuaHWxp8iwpMtVIrhdvfO2LD814BInjQUcIW+GU5HXIsWbm4z5Br1I68ufzGr
         rAg2OWFgfKz66Cjm3B2CLAhv936L9CZuv5ONVOGBIclar7chbAWidqdT2fdDybL5DnmA
         MN9Y/6w2KAwMDGfDDQ1KKEy1a+SbqbjXLqMs6caID27cg3QF60w0SLW8x/IVfQ21mK5U
         xpU8LGiZVtuOPQD04qroqW/ZSwL+cwt7KvEVKBNSQCysuj65jtpqfeGKhdKoT6OP+6tt
         ntRW/wmdwML+NgjpC90Mq8eFXgsd64ckBqPuivsjghACTgvnGPNpI2qeR8Ksx2pfHTFA
         o6XA==
X-Forwarded-Encrypted: i=1; AL+hErFDVNWsUTR40UPkgNwtcrE7WeB5ZWhUL6dSNcbYumbJbWZvYrYfBrI4EqdhEVTmUG+AUyqmlUX6I/IXMILv3p+aNy0QTFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JOMtlLYMJ5tP9NszF6dSECQMaMA6yWc5mApIjizi9IryrQaUd
	0ykJpwHTm1zfoeJw9gWw/6ZnKqKCQqe4CZpPLdYiDuC19UYMbpEevJYOY8u6GFVbcZcx
X-Gm-Gg: AYBFou2E85nxmoBgTSnQ2384Href7sycgoZKpBOP8qQr7ndSrj6q954ABmXWaGr7+8D
	y8cDdUwrfMlkbrt0hbjMijHTDtuJvF97B6+JPbYoPm3b989Obw91pflcH4nW9KblifXlNvXrox8
	Vf8uUKf0Lp45Et1FVB9UYEmwHl4j5s73nyhXxMsOnWMipZTNGISmC26jx/1RyoryCNjplJ8AUgO
	Q30bi4RAS/YrG43odoCbHf36qg5fh7akPYR6bAAcLvYNWLUT9dagXoYupa7qX3U/iTvHNx0gLsu
	wQONJ7FAblaVQKFwt4pTsqp7IMvzPKDX1ShO/8BqMgYCZac7HiCveC+9Zmzq8jnGTLJuHwsyz5A
	rdJ5XugNUtp2LdcmufbvA2b4Nu8Zkysxi73KEUcYwKXmwQJ6jg81MBnYz723Z2Te1K0zV/+uvpM
	V1nUur20WlOdXElIGfM7EFkr8+N0rMfYub8OXsy9pY11YmX9y4kktBScJmopZhlOCbzgdNVJF8m
	9HiHA/OZF6pnYSd2PXpX8dWR2CxB+mtlAFHR3cRK47TsLEOapWCpHe5bJRuPCD9+NxWYMLCAYIw
	y9oK9pYsa8W2BgCVvhZAhxnAbk6UcuoSqHPgJYEQjnyfqdyGmeAiWeeh4FGYYv0=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43583035e9.2.1794564806374;
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm4362275f8f.49.2026.11.13.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Message-ID: <23edc29c421f5d4c1103004f79e104e9f94d42c2.camel@amutable.com>
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:13:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/fuse/control.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 21ffde596d61..4497362e7df0 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0
> =C2=A0#define FUSE_CTL_SUPER_MAGIC 0x65735543
> @@ -334,6 +335,7 @@ static const struct fs_context_operations
> fuse_ctl_context_ops =3D {
> =C2=A0
> =C2=A0static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> =C2=A0{
> +	fc_init_pseudo(fsc);
> =C2=A0	fsc->ops =3D &fuse_ctl_context_ops;
> =C2=A0	return 0;
> =C2=A0}
