Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D122FDEC
	for <linux-security-module@vger.kernel.org>; Sun,  9 Nov 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723790; cv=none; b=KhvTdK3GqTodB9OSyXxPSMyr0VihF7tFFXAw0ygm2yThVf81HGjBvxBOnKYPMzv7f9Un1aXMiFpBQBrzZosOmx6Wv1Ur3viyktsZAhhOAoptywC5zZijyMrUpl67UUZd2liwE9OW9Najui9hjK63IqXJOBYXG1/TbNJSVpmAkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723790; c=relaxed/simple;
	bh=JrigkIGSgV9JIr0Y27hJlw0LIABya4VUB00KUecvaio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS1EC7R7e8U/pVR95tayYD2mnpqI8spQWABimP/hvIPlV04f1Dd0wqbC8YpZBoNWKONFRZFz4o7t+hfXS2Vxpb/2LlpnpQPr8UL00ESTxVut/c7fjmBDBzXM1taHxqO0rGDAZc0mg5GZ+ZGeNw9mjKmV/GoEJzL1I71yLb9CSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OxWIsBJo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OxWIsBJo"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so707199b3a.1
        for <linux-security-module@vger.kernel.org>; Sun, 09 Nov 2025 13:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762723787; x=1763328587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCpmNG4HaDD27+nahLSdV0GLwVqvHMVSI5yLttqUzTY=;
        b=OxWIsBJoHlvIzNzd6IBOGvRRz1c6QKTV/yvr2GLR+QUqgtJ9lKPa87KsZdupWerixO
         zVrvXaXpNv9HhdHCHEqmcaCqWaLVyy8+a/wYXhNlXxjBjbjAGr7s1IXDEuYILfM8FoiR
         DyiRINY5kpwHTiYKX9BX2RjG/Sf42BTQOpBIht6DFy/24wBr3LVkFIA58/zHODe58506
         w729xa9HYmR1XD6B+DI50BvgBlgNzNe6A2eW5eUWSlIr1EwVzak3aH1r8fp/XdtvJjqZ
         DJsjepZjcE+bekhrdPH60KmoR9/nylo1JSj0pIDaH+fFfKaEcs1NxA9ELandcxh/s6Xc
         jZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762723787; x=1763328587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCpmNG4HaDD27+nahLSdV0GLwVqvHMVSI5yLttqUzTY=;
        b=McNN2i/xXHcqFpuOzkc7CBkzoXB2nXyEQfyxTgifFZykl1QobMTgO+F859VIyahECC
         B+xBfzM2GakGkzCkUdt9XzTjtAeOymVdNwpJ6KUFfCq2Sfml2Ojka7jf6sNXW5kJHz6i
         7wTZFqdbP9/MXoerEWJQd3o5gCa8ajSDcD1st3lQe6T1Xcbzkf+k8ffr+JNrieuBfr59
         LSZ/LCNh28JikapLks/Be/iMExr/Wbaf5Vfci6ewR+P4wA5yP35eWhrR+g8SJTDpnMmE
         +iUe+kDn87n4GMQZcH9j00ct/tDK943HADMTxQuDXKc/Vk/vymNhBnz+P2y8itLHDuyc
         F/pg==
X-Forwarded-Encrypted: i=1; AJvYcCUJqEbfy9TZvbRnkl4utsrTaizPv826Ep5C6LCf9kbrXC37CCj3VYAwUcEToAOu/t6SLKicMAZwQ73aLX5AvGxTfsI+uf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkJXnEHiz2Ii6uENaDJb4e1YxZW3y9BYei5mAmltG5rfxHYYN
	Dr0fn4KM0s/nE0hcved9PGv6chwLaqkBTsaMn7bxh4NXk8BEOsuhwYVEPqZl9uEOoBe7bL6xrhS
	A5VkMAGdlaznJx2MpCtFSrCzenfYRLvAAp5oQhVJI
X-Gm-Gg: ASbGncvlCcSvu1HmteihB0hHSKLJNdi/iCxQYLgBrzjLTCxh96cvTbql0MLYCtX0Me5
	+YIj6RKe5AP28jHTmXKza/v9XRVCsCEFb9nX1zpKRyKuJN2lpeL9IuAvmeogJ9e+D/lBAYVhMEF
	rjtheazCp/qhgLwppQlxukkaW9eG6XoZaf49/mxdhGBjgxAiO1QbH7U336oipCx1U67yOkGufK9
	SNdCIuQpY0IovBwqUko4FyK7UwLqm08DglPhlft9oRDFD88WUuONtNP5uCUEaW/61DSgak=
X-Google-Smtp-Source: AGHT+IHQURL9arEF85Xkv8L1+bVtKSsyFyQE9v4YKONDepS09vRsAyNwdyCGR5zutC8ImL3+GPy9CjT7M/xiyteZdi4=
X-Received: by 2002:a17:90b:4c07:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-3436cd0f053mr7880146a91.37.1762723787291; Sun, 09 Nov 2025
 13:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109192940.1334775-1-mjguzik@gmail.com>
In-Reply-To: <20251109192940.1334775-1-mjguzik@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 9 Nov 2025 16:29:35 -0500
X-Gm-Features: AWmQ_blvWeHspBMm4bMAdUMJG2fZcKCHI3qaL-nFDjha9t3_WwcCVdZIlbe5Ro8
Message-ID: <CAHC9VhRCvoXrUESCjbxz5Bcxjq8GXLj4GvSoXq+sukdP1cuXNg@mail.gmail.com>
Subject: Re: [PATCH] security: provide an inlined static branch for security_inode_permission()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: casey@schaufler-ca.com, keescook@chromium.org, song@kernel.org, 
	andrii@kernel.org, kpsingh@kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 2:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> The routine is executing for every path component during name resolution =
in
> vfs and shows up on the profile to the tune of 2% of CPU time in my
> tests.
>
> The only LSMs which install hoooks there are selinux and smack, meaning
> most installs don't have it and this ends up being a call to do nothing.

Unless you have a reputable survey or analysis to back up claims like
this, please refrain from making comments like these in commit
messages.  I can't speak to Smack's adoption numbers, but last I
looked in 2023, and considering only Android since numbers were easy
to source, SELinux was deployed in enforcing mode on over 3 billion
systems.  Of course I don't have numbers handy for *all* Linux
systems, and there are some numbers that simply are never going to be
public, but given the +3 billion Android systems alone, I think there
is a very real likelihood that there are more systems running SELinux
than those that are not.

> While perhaps a more generic mechanism covering all hoooks would be
> preferred, I implemented a bare minimum version which gets out of the
> way for my needs.

I'd much rather see a generalized solution than hacks for a small
number of hooks.

--=20
paul-moore.com
