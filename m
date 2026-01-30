Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100A378D6A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771170; cv=pass; b=tEWE2S84ehZIqaYvY2e0BAckxn8JYWjey/782tnGrEZFpjr6qEtX5rE19BDYUUJAiBvppM1ap74i8Rk/7FHZ7irby+f/kLaRcY3TYS0q+JPY8omdfSjMvgqOBp9IWDNMS5E70gP/hhZCZMcieW1d86Iv2Y+OW40UpGpFJVO+3Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771170; c=relaxed/simple;
	bh=9/zpKffe7y3uB+Qn0SF95hcsB79LbAi7GedReWEKmVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+rdpkHkiFVNpEKN/ujO9N3wPchN74quRSZ02X4GOvs07+Pd/c/1YkBMzOxant4mdzfavN8K3+SaQLjvxVHXyiqf/9uo3T2ELpBYhthkw4QOhLPBc+kIFMGazQYYQAmzomIoxnimXrKdt+k3+0tVayxfJuX75BhewX2tBuwcq20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIPqm4+U; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIPqm4+U"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so2692104a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 03:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769771167; cv=none;
        d=google.com; s=arc-20240605;
        b=EzaP/tSNNeZFaJE4qM/2sIuFCZ2U1TV6o4y89gj3EWoLntptj8mhXBErYrlPGMtYCM
         YDk0Rforl4osVFq317fNimmF5p9ckiTjOx8vh5Bqntp1Fc8W2Oee9MeQalCLwF5HbDav
         nHuy/QdiM+Bfh8EI7LMBnArO9/y+acd/QT+0JwlJbQ1bDlWEknSJmCxnv2lpyoBEUdqc
         x41qm6Q4bmrITkWA0FE7oqJqR/mc9P/oRIGF9txgKrIW4rNMlPh0F45LFVyfpXsxAN1K
         0qWUhhcxppQPNiw1Fl2kRAHHKPyB+tdvYTPPAgIOxhNp8fNI/X28prK26E5e9D42PoZF
         J2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KJi4aV/ZmRDHm0hyQsYhdJh23rHtSjaZzhOLa52dkXo=;
        fh=KAcwRvP8x5wXvjEUYtmU7+QH+ZBNe0Cl/eY0mGDTFbE=;
        b=dzPkTX8WpT/CfEeF0S2mFTKgn5RyEXoEgJbG0vwT9POyFuO0QnbKyd3qTWNF/IzS1a
         X0jbvyHBlvjP1ZfWwTjOrAZN9Ps/B+7vqepKfs2lrSVss43ovaHr3spVOxz3LhdHWIX1
         t//9Mu6gpmW1r2UBP05GLuHU9B4dT9pqZaw7spsn3kAmts2EzoGfEp8oYpYYxu1198TS
         MzaTGC0PGeTLe0YB5Vw0v0EK9pjyVw8+D35W5brZyoc+swL3dgU3CSSftU2ZCIq3D04J
         1OGVBLqdJS5YsKYV8BxU4xI4d5eqS9l1J2SzOHqr1dnoArZmlNWwczBJa58AclONJLRX
         kkiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771167; x=1770375967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJi4aV/ZmRDHm0hyQsYhdJh23rHtSjaZzhOLa52dkXo=;
        b=hIPqm4+U7OpUx4koc8RxObDAUkvZy6VqulOYO9UF7VmAqvuywLjIBne/1s2y5L2HSl
         3NOn4JBHg4TW8CgfTcWdRF4fTU7Dzgj3zjxxux8m0FaIw4XhxHpKTw88+Se3e16dF3pe
         i3KvNaXRk8wHAZ04vVaKk6BjxrpDuTvVVPqzba6D3tXrZIGMA+oQZgSwYKNRmeKdiNPR
         LRo23su5YjT6ie/CZEpITLV2onC0bu5b6UFf7AUTV7s1dtxI7/6H/ED9C+97NiFlJVak
         TAEIah49ALrBIzvxVT5Yk6E17Sqp5tSb8rsC2bIlt94bwfu82BR8LzjfR8eOJPzeMpqO
         HA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771167; x=1770375967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJi4aV/ZmRDHm0hyQsYhdJh23rHtSjaZzhOLa52dkXo=;
        b=eOU+zJoUuLAE1CY+/M9X2p77chrtIKzaN/mpoT9D0n462ojW3QYuWzJfWzTqgamH7E
         HJ0j3A8DvbPKLtvinmy2y661i1KCyjNEbfV8nqKS6sunrGy18qQjd+FEYrsQ4tbw1/3e
         9cYY771kUHWfhnj8c8iK6//BB8yxgal1uPY2mhv7KHv5r1fZ/bQ5Uq7IAXLJYGjvMNKm
         fQeELI6sOaV2jUjks5WQCeWaW5MF49wNWkNg3KdlWtItdMrL1ST4Bj2uORp1u1cvCPgd
         u/ymM+tjGmuqz28La+NQlb8JBoBw12w9+43Fs/r7paV6/1amzK3Qqo9FJgJCGEO5voYx
         XAdw==
X-Gm-Message-State: AOJu0YxPoNlXTgwNGEKSdUQZ5WJ50ypyYe/mkXP4sW1okd0wd2Dle+AD
	FTP5EgyX/zFitda1crpLqfROjXZ3eJTF0B19DIAc+N6KGzmKfKXT817vlE8lkawzIWyjzpO2H1x
	hVH4Saxt9kYA11c+/QGcUV8MNKFL43sc=
X-Gm-Gg: AZuq6aJNxX4EMJC9cLZsJSYzIGz9KDVP8aFoe+/HFVtd1B9b+WDpAOJSyDK7PXjgbe3
	bTKisWNRMUBGXbO3ADPn3eTFhO95XDKMOXDjQnvl5GjlKH19wuWcddNutnqqE9KqqhLFMLuOHZC
	tisMOGEon9uXgU08GGSf3I1mXhLJgvPQGrstDuJ9RR3d8dcYe9Mypxe431ARWl6r4+cRmACcryQ
	RxsexCUpebbqw0M9t/03wIUAZv4nKJo0IwSyD+Fyu0jnsH5GmK9OolNqGIn+SkVl43vdFS1e/+h
	0oxzJvOG4MweauCwp5xHkQ5WoMXV5w==
X-Received: by 2002:a05:6402:144f:b0:64b:588b:4375 with SMTP id
 4fb4d7f45d1cf-658de543897mr1599144a12.2.1769771166763; Fri, 30 Jan 2026
 03:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130001418.18414-1-wufan@kernel.org>
In-Reply-To: <20260130001418.18414-1-wufan@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Jan 2026 12:05:55 +0100
X-Gm-Features: AZwV_QgghBBStBrPYhn9xu--KNUWAryBYerGvsUjHEDtz6N4ByrCAVmC06166_U
Message-ID: <CAOQ4uxhf6EQKcoN055xzmi-RW2GPxRzz_ExsQawGQBSmoX2WYg@mail.gmail.com>
Subject: Re: [PATCH] ipe: document AT_EXECVE_CHECK TOCTOU issue on OverlayFS
To: wufan@kernel.org
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, mic@digikod.net, 
	miklos@szeredi.hu, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 1:14=E2=80=AFAM <wufan@kernel.org> wrote:
>
> From: Fan Wu <wufan@kernel.org>
>
> Document a known TOCTOU (time-of-check to time-of-use) issue when using
> AT_EXECVE_CHECK with read() on OverlayFS.

Hi Fan Wu,

TBH, I don't like the way that this problem is being framed.
IIUC, the problem is using IPE on a non-read-only fs.
Is that correct?

That fact that IPE metadata is usually coupled with read-only fs
is interesting for the understanding of the use case, but unless
IPE feature mandates read-only fs, this is a generic problem.

OverlayFS is just one private case, which happens to be common
in Android or containers? IDK, you did not mention this.

Please describe the problem as a generic problem and give
overlayfs as an example, preferable with references to the
real world use cases.

If I misunderstood, please explain why this problem is exclusive
to overlayfs.

Thanks,
Amir.

> The deny_write_access()
> protection is only held during the syscall, allowing a copy-up operation
> to be triggered afterward, causing subsequent read() calls to return
> content from the unprotected upper layer.
>
> This is generally not a concern for typical IPE deployments since
> dm-verity and fs-verity protected files are effectively read-only.
> However, OverlayFS with a writable upper layer presents a special case.
>
> Document mitigation strategies including mounting overlay as read-only
> and using mmap() instead of read(). Note that the mmap() mitigation
> relies on current OverlayFS implementation details and should not be
> considered a security guarantee.
>
> Signed-off-by: Fan Wu <wufan@kernel.org>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index a756d8158531..b621a98fe5e2 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -110,6 +110,34 @@ intercepts during the execution process, this mechan=
ism needs the interpreter
>  to take the initiative, and existing interpreters won't be automatically
>  supported unless the signal call is added.
>
> +.. WARNING::
> +
> +   There is a known TOCTOU (time-of-check to time-of-use) issue with
> +   ``AT_EXECVE_CHECK`` when interpreters use ``read()`` to obtain script
> +   contents after the check [#atacexecvecheck_toctou]_. The ``AT_EXECVE_=
CHECK``
> +   protection (via ``deny_write_access()``) is only held during the sysc=
all.
> +   After it returns, the file can be modified before the interpreter rea=
ds it.
> +
> +   In typical IPE deployments, this is not a concern because files prote=
cted
> +   by dm-verity or fs-verity are effectively read-only and cannot be mod=
ified.
> +   However, OverlayFS presents a special case: when the lower layer is
> +   dm-verity protected (read-only) but the upper layer is writable, an
> +   attacker with write access can trigger a copy-up operation after the
> +   ``AT_EXECVE_CHECK`` returns, causing subsequent ``read()`` calls to r=
eturn
> +   content from the unprotected upper layer instead of the verified lowe=
r layer.
> +
> +   To mitigate this issue on OverlayFS:
> +
> +   -  Mount the overlay as read-only, or restrict write access to the up=
per
> +      layer.
> +   -  Interpreters may use ``mmap()`` instead of ``read()`` to obtain sc=
ript
> +      contents. Currently, OverlayFS fixes the underlying real file refe=
rence
> +      at ``open()`` time for mmap operations, so mmap will continue to a=
ccess
> +      the original lower layer file even after a copy-up. However, this
> +      behavior is an implementation detail of OverlayFS and is not guara=
nteed
> +      to remain stable across kernel versions. Do not rely on this as a
> +      security guarantee.
> +
>  Threat Model
>  ------------
>
> @@ -833,3 +861,7 @@ A:
>                       kernel's fsverity support; IPE does not impose any
>                       restrictions on the digest algorithm itself;
>                       thus, this list may be out of date.
> +
> +.. [#atacexecvecheck_toctou] See the O_DENY_WRITE RFC discussion for det=
ails on
> +                             this TOCTOU issue:
> +                             https://lore.kernel.org/all/20250822170800.=
2116980-1-mic@digikod.net/
> --
> 2.52.0
>
