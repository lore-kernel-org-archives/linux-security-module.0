Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C665136349
	for <linux-security-module@vger.kernel.org>; Thu, 18 Dec 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766020966; cv=none; b=QvmfjrEF51PgghNAE5X7CoPEL/RT6B0g+QFdL4+eexNG9M2KOf9PbchjXwuwoAip0Y7qOS9VjF4fSCe9/y+CemBNmEI4e8kUW2+A2aK20a9kkMY1E3aA2qESivOdi2zC/yuE51yOuKP/aMDZdu6dtuZLK9jjrM+lGlM+gpYTx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766020966; c=relaxed/simple;
	bh=EfOagSKtMPrAituOBjbg9sgoDPP1BxPBt4MiTxip3EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEIwNJI+sRyo34v+xd3w4T6omKOB4NhuptlpmvyrO9YcUoHz4B/QSuWd3mUAfpGnKW/U8JC6wJM0HdyX0fwdrtdLmwVIZa55pkl9RdStRuEW1LW5rH3776rmxVdrjEk4X8j8NDkTm5HwpCms3fk2NBxbkOH47zozEF6uR1dkikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN55ENsN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN55ENsN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477b91680f8so1072445e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Dec 2025 17:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766020962; x=1766625762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUfWSU55e6klqk06RT8DooaLMYJUGtBJoBI7Mktsq84=;
        b=DN55ENsNgF+7YGhsoHuvLt6apieEJ1LPFRaaosUYvut7V/c6wUrYq5vBUgbgfep8dG
         m2u9c+BKzWIczWyN539tepMkIGU3JTE7Sg/cs3Z+chyZd0VqE4roZwxLXBEaHcCyB7Cy
         Y9SyhM9T+2tVykRZC9QCZujcSP6aJbl6nchIve9RCjZnsMAzdAKHBVaQvB8Yes2X4tmb
         8xNB8aqoNJyNgb2BG1DcaF4j4EiCcpAULrWOUXh7Y67ikN0P4lgigb6EmKN2VdFFl6xU
         YDNjlRuIa/5QDTjAxRudbN/ZR6/fRXE5Cfy1AJpKvutZ4xQj494UCfKtlCvMtcK+soJb
         vlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766020962; x=1766625762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pUfWSU55e6klqk06RT8DooaLMYJUGtBJoBI7Mktsq84=;
        b=KMC1FXrIajt829gyzTIUUSre2MWGL/XdAhvgr4hTRPZX+ynKMNDJWgvERq4RtIKVSM
         yyWF3HrQbeDzgFKM6nF+lm3qMhMWBX1znvXrqZ0PYk/3DcOReUG2do//5c+I0XTUcroQ
         3M7ChKCG3WsdNgjADEt0xKU973ml7ZKY4j0xiIVaVZgGrtInntVpq5yJ2sS+FfbCtgHx
         hOg66XMFBxqpChGMzb/mIy+KcMMooiXVIQcCaWzIy2VTSUo4YFQ7ZDeNR/RnVf1xvFn7
         ORAdOvoaOZy/ks8pyTOQ8XkHEyRbDHdjsHTmFlF7vsn49bBLwCQKFfOAH+4CWvocrgWg
         8sEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJpmVmXgP8anRLeN/Cs6Iv8MZIbOdb1GntCQ92CNWn6zBokyC0KTIZFZs4VPfmsKGj+5US8dg9tNiF7MetKBEB6X/D1YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNO7MddpNG8QALfbYZ9vtXOhDB8CADGiAWHUOg2pJif+7W/P/
	Du/BswjrTQoxva94CKxGuaZrXKfAcs8ml+CBuCZq1k6K/d9kRmqYo4jAEqycj3cQO6POfcznG7Y
	5SEQH1SA1XAsJu7LfGF87jUpepNW/2C4=
X-Gm-Gg: AY/fxX4Qw3JJBijz87aWmlLvbgq2qkvZhrnJSyep5UtprLHvVZ5eqp8VgePr2VPUU/v
	/JB0w2sDJmp8lSDxTn0pZUE1Gde9yOU7wJ2FR45hCc8c/WcQq3NNYfBskJKdbvXa/1hBSycFaz1
	5YrG5lQ9H9YVkM/VM6Zn/7/GY2T+ZHUiKpEWLgIqQXppPiRpI8AagneL9GQx03GvYl5pjq/mgrt
	f/ScFcgM2xnewsPCcwQbLQFYVnhShT9OshM/XrvYfXtMMzGUgaxJpBblv78uQQNRY2O8qbuDiCf
	iQ5ox4H/za1ICwapY1XnE/acPGitnrVI1GnFYP4=
X-Google-Smtp-Source: AGHT+IHI3Zc9UJLZXFYBDkFjZPO4pblK6riURRpClPTH4+jaz0+GBZQG1W/4BPm+kxxoU98+ZUMSkwR1ds2u6Ik3HAo=
X-Received: by 2002:a05:600d:f:b0:47b:da85:b9f3 with SMTP id
 5b1f17b1804b1-47bda85bcf1mr52495445e9.23.1766020962351; Wed, 17 Dec 2025
 17:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com> <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
In-Reply-To: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 17:22:31 -0800
X-Gm-Features: AQt7F2rvXmPxXxfmFoBVvyhzz_llncbRbWXwHKjWzs06OF3RTcKub-VfqDonp-0
Message-ID: <CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com>
Subject: Re: [RFC 08/11] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 6:14=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> +++ b/security/hornet/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_HORNET
> +       bool "Hornet support"
> +       depends on SECURITY
> +       default n

So you're disallowing this new LSM to be a module?
That doesn't smell good.

> +static int hornet_verify_hashes(struct hornet_maps *maps,
> +                               struct hornet_parse_context *ctx)
> +{
> +       int map_fd;
> +       u32 i;
> +       struct bpf_map *map;
> +       int err =3D 0;
> +       unsigned char hash[SHA256_DIGEST_SIZE];
> +
> +       for (i =3D 0; i < ctx->hash_count; i++) {
> +               if (ctx->skips[i])
> +                       continue;
> +
> +               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +                                             ctx->indexes[i] * sizeof(ma=
p_fd),
> +                                             sizeof(map_fd));

As was pointed out several times earlier this is an obvious TOCTOU bug.
An attacker can change this map_fd between LSM checks and later verifier us=
e.
All the "security" checks further are useless.

> +               if (err < 0)
> +                       return LSM_INT_VERDICT_BADSIG;
> +
> +               CLASS(fd, f)(map_fd);
> +               if (fd_empty(f))
> +                       return LSM_INT_VERDICT_BADSIG;
> +               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))

Ohh. So this is why this LSM has to be built-in.
bpf_map_fops is bpf internal detail. It's not going to be exported.
You cannot open code __bpf_map_get() and get away with it.

> +                       return LSM_INT_VERDICT_BADSIG;
> +
> +               if (!map->frozen)
> +                       return LSM_INT_VERDICT_BADSIG;
> +
> +               map =3D fd_file(f)->private_data;
> +               map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);

This too. It's absolutely not ok for LSM to mess with bpf internal state.

The whole LSM is one awful hack.
The diff stat doesn't touch anything in the kernel/bpf/
yet you're messing with bpf internals.

Clearly, you guys want to merge this garbage through LSM tree.
Make sure to keep my Nack when you send it during the merge window.
