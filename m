Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F733A9F3
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990771; cv=none; b=BtkOvOHqqHDo0j3gR5FSomp1r7bjCVDD9dxzvQ/rz1RNsEmzJIPB+eniwCz99RjFx+oz46XAVyaolOr/t8b/sMr8KTQ5Ne92EOtBeS0J7nnLwDAJvyOGF3I4ZFNJmWNFPj9aV5nQF7+3MorP9Cbq4dj7g5pMt0Q9vowS2eEe1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990771; c=relaxed/simple;
	bh=R9hDlIbF8cUzRNWfsyT5ohhBuOde+8fqRk+s/FqZNHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsBCet5uKq5nvepX/jE9GJEAnJVQy8mqEqbVwtnK5/BkHBrfZyVVKeGFPlmFZaBDkEDRcq+AxibdbJinly2UJ/mhBFqJ/n1pNgp2h2N9a0B8hsvO7oByvmt6+7nfTA2tx+TTFoQZtZjJPln0XJfCrA3nMQYtU6CpIIGcjc3C/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01C7uwgJ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01C7uwgJ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso13230495e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768990765; x=1769595565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FcOyoV+nbEcpO/X+XKwwBcFld4GtW09lpc/VejdB43Y=;
        b=01C7uwgJoo7+3eDFNpfbAXi8G7FDxYr22knuDuEh02b6ZQJx/P03RsnphMR0kmHt8H
         HSaISSQcRJkk70eYfKybRun+ef6s7StsjzoXDW8IR3HLqNOfj2/VjTv2+/KRlfjatrK4
         IS7xQsHn8DTFwgaq5zV99yuNy15aIYzPF543x4RjwT7lFoDVYy3+I78DZ1KHEtS8jClE
         DkHjcrfgfgjM1Rum2AAYCGBDitEjJ2IAa8FxAOHiT/tvBGOO0dnobmjvihy/WXGWCRBc
         mt521kSU08Qv/xxw+fSC8WhK/4U+5ItBFL1t7HLXKbFYJKQCnp1vUlKgw4sAKriS8C+u
         BbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768990765; x=1769595565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcOyoV+nbEcpO/X+XKwwBcFld4GtW09lpc/VejdB43Y=;
        b=wKdd/LR0huhBddecZSYqegtOVAoIJ9u82J8JNIf17mf6O5RUA6QcNL267m4wE4KWJA
         7a4/dnyFmfZdn9roBE3Jldy5UYAQP/cuthA451PDALT1qQ7TEe8WHsEs9RFZ447Jp/ps
         qYRAlmsnGlZep4B9gZD3v92Y7oLVJhshQrBxRg3HY74evsVhaOaAOcYLJURiRYzfCK2B
         Tk5hQUOkDK9tvfKVeYKGox7/a1KFdPAaAAX9aYxGSjga68W5HD2PJJu2ecWOqzT75LbC
         Cc+aB5Dxq6qkwVpQEkOrv+2jxNTYrlsLba2TzLg155O3W4obcWeNM9qslieoXSfxjVP5
         YSfg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0/Foo2Zhe4vODwYTcIZfnm46OditV0VxU7zPmBesoN/8L19df/uj9FUxVm5Db2Lcg6kStv27d9D485uz+QrOz3dGnYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvPmBVtSahKoxDKuJX8iMRdrOwi1a7AVfB7tRrJyj9UtzPJUC
	zHYBLQbEjHZysJygbxN4hu0JXTuuNPl1Lh+H2NdLd+u9zaUG76IxzwNP6HNlW5kf7Q==
X-Gm-Gg: AZuq6aKRcqfJzXiOJiC5kwfV12eSLPYakfT2bBm9eczYK8TJNhvCDIv+IrepG1T50GB
	hV8v7yYX09OB2EJ4l7rw3TdPMixNGmZ3SMxr6MOTbytqQPlwOCM3rkv6pxqtI1TJweZV01MvTOc
	Ue4ge/gdD4bnTWiZrVlXSJwB21OG0TE5IlyixHWkY4cXU0c+HiEzK90zKd8xWyajmvet+aR+nL9
	CQQFUaYHaYO9mKIOLoh1UkGLgiQRc30MdlaGIiGcdzcg2Yqbs5KNZNZOuARED+DX6JLmOV7i4Uh
	RxnC9DvS8Z35Fbh4xgRoWwCMnamoF6pz477EGllWyzn10IYYNhBEAe6CpXmgV0BZB4Q/Niq/I1D
	LVUhWQ07eI2fvAQdUCv8Rv9hUC8VFOFIV3264RP+TOJnHncXeowZLDiY+/7ajDR5X93JiBvwqWi
	minzNWF3HU/PZiXq+GEBb2skgzTav7lfhUjtaufic4Bg==
X-Received: by 2002:a05:600c:638e:b0:47e:e946:3a59 with SMTP id 5b1f17b1804b1-4803e802282mr69860425e9.34.1768990764894;
        Wed, 21 Jan 2026 02:19:24 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:4dcd:eab0:72dc:f1a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm34838157f8f.18.2026.01.21.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 02:19:24 -0800 (PST)
Date: Wed, 21 Jan 2026 11:19:18 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] landlock: Add comprehensive errata documentation
Message-ID: <aXCoJs9nTAlrlN_F@google.com>
References: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
 <20260103002722.1465371-3-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260103002722.1465371-3-samasth.norway.ananda@oracle.com>

Hello!

Overall, this looks very good to me, thanks for documenting that!

Some smaller remarks, mostly on structure.

On Fri, Jan 02, 2026 at 04:27:14PM -0800, Samasth Norway Ananda wrote:
> Add comprehensive documentation for the Landlock errata mechanism,
> including how to query errata using LANDLOCK_CREATE_RULESET_ERRATA
> and links to enhanced detailed descriptions in the kernel source.
> 
> Also enhance existing DOC sections in security/landlock/errata/abi-*.h
> files with Impact sections, and update the code comment in syscalls.c
> to remind developers to update errata documentation when applicable.
> 
> This addresses the gap where the kernel implements errata tracking
> but provides no user-facing documentation on how to use it, while
> improving the existing technical documentation in-place rather than
> duplicating it.
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  Documentation/userspace-api/landlock.rst | 60 +++++++++++++++++++++++-
>  security/landlock/errata/abi-1.h         |  8 ++++
>  security/landlock/errata/abi-4.h         |  7 +++
>  security/landlock/errata/abi-6.h         | 10 ++++
>  security/landlock/syscalls.c             |  4 +-
>  5 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 650c7b368561..930723fd7c1a 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: March 2025
> +:Date: January 2026
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -458,6 +458,64 @@ system call:
>          printf("Landlock supports LANDLOCK_ACCESS_FS_REFER.\n");
>      }
>  
> +Landlock Errata
> +---------------
> +
> +In addition to ABI versions, Landlock provides an errata mechanism to track
> +fixes for issues that may affect backwards compatibility or require userspace
> +awareness. The errata bitmask can be queried using:
> +
> +.. code-block:: c
> +
> +    int errata;
> +
> +    errata = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_ERRATA);
> +    if (errata < 0) {
> +        /* Landlock not available or disabled */
> +        return 0;
> +    }
> +
> +The returned value is a bitmask where each bit represents a specific erratum.
> +If bit N is set (``errata & (1 << (N - 1))``), then erratum N has been fixed
> +in the running kernel.
> +
> +.. warning::
> +
> +   **Most applications should NOT check errata.** In 99.9% of cases, checking
> +   errata is unnecessary, increases code complexity, and can potentially
> +   decrease protection if misused. For example, disabling the sandbox when an
> +   erratum is not fixed could leave the system less secure than using
> +   Landlock's best-effort protection. When in doubt, ignore errata.
> +
> +For detailed technical descriptions of each erratum, including their impact
> +and when they affect applications, see the DOC sections in the kernel source:
> +
> +- **Erratum 1: TCP socket identification (ABI 4)** - See ``erratum_1`` in ``security/landlock/errata/abi-4.h``
> +- **Erratum 2: Scoped signal handling (ABI 6)** - See ``erratum_2`` in ``security/landlock/errata/abi-6.h``
> +- **Erratum 3: Disconnected directory handling (ABI 1)** - See ``erratum_3`` in ``security/landlock/errata/abi-1.h``

Is it not possible to include the errata descriptions here through the header?

For instance, further below in this document, we also include the
system call documentation from the UAPI header, using:

.. kernel-doc:: include/uapi/linux/landlock.h
    :identifiers: fs_access net_access scope


> +
> +How to Check for Errata
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If you determine that your application needs to check for specific errata,
> +use this pattern:
> +
> +.. code-block:: c
> +
> +    int errata = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_ERRATA);
> +    if (errata >= 0) {
> +        /* Check for specific erratum (1-indexed) */
> +        if (errata & (1 << (erratum_number - 1))) {
> +            /* Erratum N is fixed in this kernel */
> +        } else {
> +            /* Erratum N is NOT fixed - consider implications for your use case */
> +        }
> +    }
> +
> +**Important:** Only check errata if your application specifically relies on
> +behavior that changed due to the fix. The fixes generally make Landlock less
> +restrictive or more correct, not more restrictive.
> +
>  The following kernel interfaces are implicitly supported by the first ABI
>  version.  Features only supported from a specific version are explicitly marked
>  as such.

At the end of your added text, there is a similar issue as in the
other commit, where a section that previously belonged elsewhere is
now part of your new section by accident.

I think the paragraph "The following kernel interfaces are implicitly
supported..." is meant to belong to the "Landlock ABI versions"
section which is above the text that you added.  I would recommend to
rephrase it slightly, because it also talks about the "following
kernel interfaces", which are not immediately following any more, e.g.

  "All Landlock kernel interfaces are supported by the first ABI
  version unless it is explicitly noted in their documentation."

Please feel free to rephrase if a different phrasing seems more
suitable.


> diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
> index e8a2bff2e5b6..ba9895bf8ce1 100644
> --- a/security/landlock/errata/abi-1.h
> +++ b/security/landlock/errata/abi-1.h
> @@ -12,5 +12,13 @@
>   * hierarchy down to its filesystem root and those from the related mount point
>   * hierarchy.  This prevents access right widening through rename or link
>   * actions.
> + *
> + * Impact:
> + *
> + * Without this fix, it was possible to widen access rights through rename or
> + * link actions involving disconnected directories, potentially bypassing
> + * ``LANDLOCK_ACCESS_FS_REFER`` restrictions. This could allow privilege
> + * escalation in complex mount scenarios where directories become disconnected
> + * from their original mount points.
>   */
>  LANDLOCK_ERRATUM(3)
> diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
> index c052ee54f89f..59574759dc1e 100644
> --- a/security/landlock/errata/abi-4.h
> +++ b/security/landlock/errata/abi-4.h
> @@ -11,5 +11,12 @@
>   * :manpage:`bind(2)` and :manpage:`connect(2)` operations. This change ensures
>   * that only TCP sockets are subject to TCP access rights, allowing other
>   * protocols to operate without unnecessary restrictions.
> + *
> + * Impact:
> + *
> + * In kernels without this fix, using ``LANDLOCK_ACCESS_NET_BIND_TCP`` or
> + * ``LANDLOCK_ACCESS_NET_CONNECT_TCP`` would incorrectly restrict non-TCP
> + * stream protocols (SMC, MPTCP, SCTP), potentially breaking applications
> + * that rely on these protocols while using Landlock network restrictions.
>   */
>  LANDLOCK_ERRATUM(1)
> diff --git a/security/landlock/errata/abi-6.h b/security/landlock/errata/abi-6.h
> index df7bc0e1fdf4..a3a48b2bf2db 100644
> --- a/security/landlock/errata/abi-6.h
> +++ b/security/landlock/errata/abi-6.h
> @@ -15,5 +15,15 @@
>   * interaction between threads of the same process should always be allowed.
>   * This change ensures that any thread is allowed to send signals to any other
>   * thread within the same process, regardless of their domain.
> + *
> + * Impact:
> + *
> + * This problem only manifests when the userspace process is itself using
> + * :manpage:`libpsx(3)` or an equivalent mechanism to enforce a Landlock policy
> + * on multiple already-running threads at once. Programs which enforce a
> + * Landlock policy at startup time and only then become multithreaded are not
> + * affected. Without this fix, signal scoping could break multi-threaded
> + * applications that expect threads within the same process to freely signal
> + * each other.
>   */
>  LANDLOCK_ERRATUM(2)
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0116e9f93ffe..cf5ba7715916 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -157,9 +157,11 @@ static const struct file_operations ruleset_fops = {
>  /*
>   * The Landlock ABI version should be incremented for each new Landlock-related
>   * user space visible change (e.g. Landlock syscalls).  This version should
> - * only be incremented once per Linux release, and the date in
> + * only be incremented once per Linux release. When incrementing, the date in
>   * Documentation/userspace-api/landlock.rst should be updated to reflect the
>   * UAPI change.
> + * If the change involves a fix that requires userspace awareness, also update
> + * the errata documentation in Documentation/userspace-api/landlock.rst.
>   */
>  const int landlock_abi_version = 7;
>  
> -- 
> 2.50.1
> 

The texts all look very good, thank you very much for documenting this!
—Günther
