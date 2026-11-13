Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=VB41V8C6CJGSMyPr/voO9v96EMQcrAlFawvFSb3r8wGLam4t1/CPHuTZUPPI4rhnDP7h
	 4OGzv5xJjC6qo9tPUBTXS5peE++3Mkek5Qnxk4EssznMUc1vb5WtH2N5bpsAQtJZMx/hu
	 pWY1gn2EMgMK26OAU/BTSTqkwezR/yLh5ky03s1iu8/LSYDZQ9SuDbPbq3p9rQIop45kT
	 tLLFXZB9mS2ZfE2mG4D7UF+LiLObCEBzWVO8MWWbVrtx2eajy3Rhksw8V3I75+0dIryr3
	 h3ABZLUcTP037IZFwnV2Ws0iraJO+Px1HavB18qkOhC44xNHg7FMnGUts7wqoI83oMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=ScsJQO9eZWUUFV9OaqPSlBUtef2TkvNEIB89Vu07w+QdUhJhZWarYtxSB15ISMGq5Xo3
	 FNvZuM7HrwRB2lHoewnlXy9uaHV98xPDbF44co8KpIHGKfMlNHXJFZcq9PA0SquaLXwC/
	 Qn6WkTYDZcZpg69LIlcd4XLbGewNKv3I45ZOR0+KCiaGK+HFy67wIZwQ5DnBe7UT/ZJ/T
	 5LrSEvjAXaBVSOeYp5t0ww0n09FErjJytnhZNyYLyYzdjrQXnRIaMmOULdN06QemDBJSC
	 qr7JPD2S8nOFF8h9MgawEW3pH0TXBAhtVrRcIfDldUm3jnFEmenRQVfvl4Qy1GjYGuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C73606A32E
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4C73606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so9108265e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Kaf4Snhvk8+Mxq0U6uLwqhigso4bG4Cjz6cJxbNs+egPGkmUN5X2AO5FmE/PTOK16e
         EolhavX/fMU/6vHvn7720uA2AYFM/qMXLCUjyQawJLEBeh88nJHf96ZUO9w1inYLUZfw
         MgAxNLqaGGPQnOYeItfXdPGaHEslEqRnUbYdutGtUkPiF87pjAyvDP+brLpfFSePe+pZ
         0pj1aFO0abwqIr30YokbiKH0YRFz5kwZjfcmI34UnlM189Xn6sn8fGmXLxeKMJtKfdWo
         vU54DJlsaKPHOUFvZQobz4X2j5qmempNu5I0CO5cqzC400Ob7aR01AZF+Icl5c8clhQP
         QMbQ==
X-Forwarded-Encrypted: i=1; AL+hErE6AQCIXy4ewhP7K93YYht29DJSG9XQtGmeL8VZTTjwr92IHoeQjxvkXlhdllSCvFdrx4TYy0JwUhXGspJY7ciAjHc4cXM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dNcB4lyriqY+a8+5wQflmQawhuuNIgIFjqgxaFZyAHa5MBP8+
	meITe16pUQ4V5ehUWZp13NVKICZ3ZKqe89CaitHpydIKGAFahtrTXdub3vhvYvzdcANX
X-Gm-Gg: AYBFou3E9d1FXzu6q9fXVM3Zmexn8l7A5RGgFKNDK3AlIyDvuvWzJN3M7FA/0WtMgEr
	VI6DEkLUCa6qPYt6ryu9PA5LHV0VCU9OH9LzFS1mWEHiVxH1mMZ9zgwCHuVzgHGZkJxZH/IoyuE
	t/bheVapD5XHYvtpslf1gMUjhnsRcgHMQFhOz7OE7hJqkU3VzOtBGPvcYJGDa83eS9Ng/MEPvrd
	kln+HAbwqoScEQrVPy09nO84Of/fho0xVPP4Cj8d0sDTC43HzsvOwDIX1QTaf0lR0DN4Gae6vU+
	s5hDFW+4qQYozr6kTs44Ze+LDqa7N1cQ46hYMpsMFJYknzeG0+32tOs1wL68dqLDXngeuEASKo+
	d37akEGP2t9zR5PqriquaYuSkYFI4NMc3gSjcAlbMfZfGI145c9HF2a+bMV6G8nTZ/zQ5Ft6y9e
	cSFmBJSNQI3pWVx4dmX7+zcM/w8mwzYoBW3y5eRZotgzTr5/3lH69GB74rPXrLhZ2pUwMJr4lMt
	p17pLspwD16k7EFV1ESVrsGPbZlpxrNGIYWENIZJvRZe0gCAq8k3vVlgXM29NhASL8VLqjdeOr2
	RmVzIzvPvp60Q+/PcfQdKOG4HQ2Kce8oFu+6oLSf1LAOWQcmoqEDkyHnp3JjZdc=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
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
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
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
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
