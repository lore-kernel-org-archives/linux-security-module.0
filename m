Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FF3D092A
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778816928; cv=pass; b=iim5rNPFAWqM8/vB/5j2qE8PsNY/QlGD1OWbmtYEHIK2IfZLS/KA4qJ/CHtyrBjFTmzJi/hZ+CNbUW0Nc+HefYLCCpXdquZp2lB+G/uJ6UfQF12fTXL+9/+rDI3QFdb9BpR6kGvrNzDvW6nIDjyNVub4g3ck7IVmzPPiqpVRANQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778816928; c=relaxed/simple;
	bh=axJimQpTH54Vk+wcEK9CMzTx0gjIcv6uLIP6tuXgnsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdM920WTVlfJtlplPqvnqlV7a43ZAvOXku2NUQ7d+S3kkxHIEdo6Dob0OHRQTPeZ2RpebCBZLQbYhC1j6gnmtv8O2YpuGXdw71UmQODVYKmpKd1dvvZc1Vfd7DwB1pk7Xzxcl+zJ/Dkzvo+vwxPbcTjDVBmcbLiME/QWVGKtChI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eCuJcjog; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eCuJcjog"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso3792349a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 20:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778816924; cv=none;
        d=google.com; s=arc-20240605;
        b=V3dnQBo1exnQdZa3kzyUbNDaYXU9c3MfXSnJfUFb6CFirECQxte9sW5nyXMwWPfALi
         3E9jKrFZ8HGYyy+Vsq13YGkeXdJ9LM5cvOJ3baPKv3T+yjdqcYWUfD1rYlxqRHvI6Ppk
         DANtnam4MqU4JEodufJD6VzciBWO5icnRvX/8hY3hOV/wXSW4maCz2zIeVcz4Kug3BFY
         XLod3BLuQx2sCRlq3BRzdcxhS6EZznYPGkl3eAUkcRn4pB0yEx11vfx0F3lp2Y2+COil
         qgTgpOoHv96AfnQMoBqDgHjgh+Nh1iC8MDot8uqmZX0OIF4IL7TIVoHmR2upcmBYbEMt
         4VdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kbAj3QkbSA9sXO8i6EDoM3LNbpdhiqhg3HK+8g7Mcbs=;
        fh=Wfi5bZrMVVx54A18QllabxWIRGq5NM5wZRFgLo0ZyN0=;
        b=Zdxr1RXP6MwhrqrluxGElnwT5y7qERVv4kEc5YrgtxfAbT8HIh7SiHwPSgoh0hxQJT
         5OTLmhI4EasK7eNgdjJriRThovGy47CAbmC1eMGaPCxwQ8vD0XTp6yDJJO+LlstXk5fI
         irIS2c+bWbKE3h3pxYED6jz0bMdL5vE00xZPnaUAoX9w7N5v4GkBPzItBgdjWZiQH90K
         JMnEjkC2AZ5rqc8YcNcKrmKJiguzVjgMH+Gg33Tp5usktwCOGC/mW9ImzZ/XUbIgumTQ
         IEJO/frr37fUxynYol40Cmep2lXo1AoXyXehGIQiRp9h1iLYzTy1057aPmOUD4olkvXx
         sffw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778816924; x=1779421724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbAj3QkbSA9sXO8i6EDoM3LNbpdhiqhg3HK+8g7Mcbs=;
        b=eCuJcjogazgHx1HmwNxl9a51S3GLjs5pS4nDxe37/8LXdA5Fu20goCgJtAKS42+Cor
         mHvNYms0FnDGEwfsiM7okmTbroOVgHRULZWDAUGjSqqm2uW6r4QYOeNXDTf+xkXkOAiq
         65BxlH+Eo/WolkI1yV/IpGAP6AWP52cMtBLNwXtI5vfDmltmGae2mNMOLAlQvtbXUeLC
         j9kZnmJfUEN+Q481D79Rsui32+CMPNJhP+4XqD9nBglVufmX1xONPMSyZVa7oS0mviop
         Ic83TUblVdcReOEiWKWyt0tqysvXvQ4IJfXhQmN++N89i0is1gU0xe9EJNz/lSyzdYEK
         e1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778816924; x=1779421724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbAj3QkbSA9sXO8i6EDoM3LNbpdhiqhg3HK+8g7Mcbs=;
        b=GIqO65+vWYs8/GfdHvlTuX4bTnpfutpTMaY54bXdEfyrXVhlBPoJHfyq4TDP1cKiiq
         tJ6nDMWc+oxu4jz4ELaW1vlCKIFk+OgjrZ7KAU4Y/pTpF71tLiT4RMsgEyJK49TlJy/j
         ZWXXrVwfZGpcMym99sKX0LntTusgWj+WHnyJvPVBAXpGz7aYpqu6lRHjDolxqv9gEysp
         mCuRmgO3Fw1zR0bnFEvoz7TWCyS1Uj3Om48awhjzZ6QLvxqlbk244y+S81N7e6S7u+kz
         o9Gvr8VL2LuioSj2Plz64ppreqiBKZXLU3QjGWY1fE6QW4nNAh5IPunrJ6KoMH3SFwnD
         GniQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eOnPZSKLtDYm/hCe3fPfR2cO4BwBH0xacfaTBOYT+biEfI4vcRZMIoBh4Prpf4rdPw+lBi71xcQodd8s5pNXfX5K+gk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxttRchub2qFBhtyCNx3p7rahndhWwNSRVVBKXxQQg971ksVc6
	o3rI0K1mN7+kSAAZGXvy8ToWGqsIYDNk/oCboLIAzTZoU//akuUCt1KLhVNeBjaaq26ALAG06Jr
	lnkZDLp7iWr7J96osXhvgPaFuC3L/bDp5W3sOvYq4
X-Gm-Gg: Acq92OF425wiEVg0+inQzbUMj4dqqjYQfz0KKcif1Fmk6RIydh3DHeXTzAy5uAW+YPe
	dp8Isx27M+VjcqnNDuqxC33W9gM9z9Io2fy/+tnyn45MEmCBIj7XNUzlUU66KSQSzYikVIzQxwZ
	eXQ0bAeCcJLODORgmL0qIcytx5nWkm5YDDsFpFBRc5GuNwNKA7szftRYn14MyxUq8biV3bJH8o1
	yIhpLlIK0Ab7+KTNuiA2lIuECFlt9vn0UmYni7HOAo1JwA9zGKhYwpomk0oIxA0SNvb9ylvXO5o
	tsOi0oI=
X-Received: by 2002:a17:903:1b4c:b0:2ba:7610:3f21 with SMTP id
 d9443c01a7336-2bd7e802964mr23892325ad.5.1778816924539; Thu, 14 May 2026
 20:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org>
In-Reply-To: <20260507070547.2268452-1-sashal@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 23:48:32 -0400
X-Gm-Features: AVHnY4IFjeygqhvOWHf7nnff2hcSoElhRffZjECjs-fQ1g-cwaO4KY2xNXWLrHM
Message-ID: <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, akpm@linux-foundation.org, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 3:05=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> When a (security) issue goes public, fleets stay exposed until a patched =
kernel
> is built, distributed, and rebooted into.
>
> For many such issues the simplest mitigation is to stop calling the buggy
> function. Killswitch provides that. An admin writes:
>
>     echo "engage af_alg_sendmsg -1" \
>         > /sys/kernel/security/killswitch/control
>
> After this, af_alg_sendmsg() returns -EPERM on every call without
> running its body. The mitigation takes effect immediately, and is dropped=
 on
> the next reboot.
>
> A lot of recent kernel issues sit in code paths most installs only have e=
nabled
> to support a relative minority of users: AF_ALG, ksmbd, nf_tables, vsock,=
 ax25,
> and friends.
>
> For most users, the cost of "this socket family stops working for the day=
" is
> much smaller than the cost of running a known vulnerable kernel until the=
 fix
> land.
>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/admin-guide/index.rst           |   1 +
>  Documentation/admin-guide/killswitch.rst      | 159 ++++
>  Documentation/admin-guide/tainted-kernels.rst |   8 +
>  MAINTAINERS                                   |  11 +
>  include/linux/killswitch.h                    |  19 +
>  include/linux/panic.h                         |   3 +-
>  init/Kconfig                                  |   2 +
>  kernel/Kconfig.killswitch                     |  31 +
>  kernel/Makefile                               |   1 +
>  kernel/killswitch.c                           | 798 ++++++++++++++++++
>  kernel/panic.c                                |   1 +
>  lib/Kconfig.debug                             |  13 +
>  lib/Makefile                                  |   1 +
>  lib/test_killswitch.c                         |  85 ++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/killswitch/.gitignore |   1 +
>  tools/testing/selftests/killswitch/Makefile   |   8 +
>  .../selftests/killswitch/cve_31431_test.c     | 162 ++++
>  .../selftests/killswitch/killswitch_test.sh   | 147 ++++
>  19 files changed, 1451 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/killswitch.rst
>  create mode 100644 include/linux/killswitch.h
>  create mode 100644 kernel/Kconfig.killswitch
>  create mode 100644 kernel/killswitch.c
>  create mode 100644 lib/test_killswitch.c
>  create mode 100644 tools/testing/selftests/killswitch/.gitignore
>  create mode 100644 tools/testing/selftests/killswitch/Makefile
>  create mode 100644 tools/testing/selftests/killswitch/cve_31431_test.c
>  create mode 100755 tools/testing/selftests/killswitch/killswitch_test.sh

If we made Lockdown an LSM, we should probably also make killswitch an LSM.

For the LSM crowd who might be seeing this for the first time, the
original thread can be found on lore via the link below:
https://lore.kernel.org/all/20260507070547.2268452-1-sashal@kernel.org

--=20
paul-moore.com
