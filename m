Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1F328B4E
	for <linux-security-module@vger.kernel.org>; Sun,  1 Feb 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769948635; cv=none; b=lygr2Ht3mN7jicc5Oxqyvuz1MEvu69Q2kWFXhAySPp2IGjonnIzAmVDMWu3Q6ancxXOOeRA/b3dQBBwqdsQPwDFT72J69ahXGuShRFdNHn/LCdJ+BaTAFK0aXQ4mJl1a6F55yKZLYw55JvKJcTIpw7+28Y12wZE3Pq0gLb5Peu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769948635; c=relaxed/simple;
	bh=u9WzVtq3FflXvLajh9HLE6R+XJwIscID3OJVOnuPSXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc/aUotIJp9s2kBUdKzfAsFVBCXvIpRHBMOsIXff4hRJO3n7sOEWbZtjR3gHxQmrMI8O2BYB0emL9QmS4eTQcLjSW8sNyRTXaud0Q2xhbgHKQuSEuMwJMrY4E6xhrEw7FLpwd6SN9UmCV07qNxVth9iphjStju23ZQYxq5NdK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1lIJT7C; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1lIJT7C"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee2715254so18839555e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 01 Feb 2026 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769948632; x=1770553432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fMxuPTCQDeYX3OcLb4TDFsExc7fTzzeJw8TFQDM/n+E=;
        b=R1lIJT7CvOkHxvD2YI8AfzusH3RDUcTvph5PDgYXdaC0ewg6BeQOoC6JF5OFI4fm4D
         SKc8FObV5Bkk5sJExRhi4JJG0dAbmNeU7Y6yRghA6/kmcbGJ5Z/jBUmbQK52If3etuF4
         CHzz1A59MjL6qgA6yuN/3ru6VeYU+OZtRaaNW+axq+P7HonOrJRs7z4EVrWpohZIb3oL
         3XjEb8rDBuJYhRyWw5cuUAjtWXvEM/BoCzqaFrLLiZWR/GC8M9CdQGsqLvLSxTWG6b1o
         6lEJzpYKreRxgVmLAD584/I2JRJXMDDtmoweI38c+5seR5h8YSmKZfCPRjiyBnK2Exk4
         ANyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769948632; x=1770553432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMxuPTCQDeYX3OcLb4TDFsExc7fTzzeJw8TFQDM/n+E=;
        b=LQGJRkFG+vF4xHVPoMhFThCcvtuecoS8OGzA+t9p3x8XLg9A4utuhMdmMa6DVZeuTo
         RoqV3MrNNYdGe41A9ICNGlz5VP70lg/yNGLxZKLn3OoBgcrwI9sDgi4P93nKUJP9I+HK
         aoEfNkEmMKMHqmLus0DIN/6wTl6iW2pqeDtSlwr2iCWtKDeZvxxR/0iT9SelN8BR9IxA
         z+/bF6ir1M9yxeB119N+UKF7skmunVytJPTqX2PKZZrkl/xYTEDCuVq/NHPuIohCGSAI
         Yg+SdOxNaQpZKzgUBBNexwSQn1gmHQCIyDEvNv3kn9rjIalf4pHcc9aQ3ukwAyz8t2vP
         zl+g==
X-Forwarded-Encrypted: i=1; AJvYcCVviWGMtycmUXxHy0WzN1/LbTv6LqamCMINQu4htKICqoWfckPfIS7Jq/T2+8FL1ZcXbQ2XbJI8ufPXXrjJIb0pW5YENy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGHLNl46lrJAfVTUk8S+Y9uJ6WZ02kNwxnAUE8oqerlzpy9m6
	C73d9eGMOT3QokUcBvP9GHFUFpAN/XzKuP/oJYcTcqmcWw26VSXcplmG
X-Gm-Gg: AZuq6aIzrpVEF0HbX8pGOKyel0fqwIdjIM+tTIaOetZgHdJB271UkpmyOa8EH7/EACq
	+2LqJYtOjZo4NsE8+UbRgrTgu/jNo4AXjBA79JQZ+aQSHzOpDkWHfTiA3ahPjXVLBW4DDnM9RbY
	AX67H6UjKivPfJNMj6RB1OmtJzSZ0fkeiTy7n92J/yFhRQwbjRtA4L4q3O9nXir6Tk8DD3hwLik
	jDI4ovpsQIZwnyFnH83bpTQJSmfjl4LOCMagdzMbqr+qy6aW0KBkK/OcFybFyGnfRbFUAN/L0Uc
	V+1UJXNjXwTL1WUiEvQYMMmvsBEUL42620CqBrQhg5IeaXNimSQqFXbDRZynnwrYnd8/1tKe/yp
	WOywpdeIwmtd6rltgjP3CJXy050/VMrEjhTJnXVD0DHWBNuz/hod3pyX6wqa4RqLUHeVvQCh2B+
	U37aKygKG5jYE+zF+rvQAtli9ALTwT56BNdwN7
X-Received: by 2002:a05:600c:8716:b0:47a:80f8:82ab with SMTP id 5b1f17b1804b1-482db48d4c0mr110664345e9.24.1769948631989;
        Sun, 01 Feb 2026 04:23:51 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm324696025e9.3.2026.02.01.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 04:23:51 -0800 (PST)
Date: Sun, 1 Feb 2026 13:23:45 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: gnoack@google.com, mic@digikod.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] landlock: add errata documentation section
Message-ID: <20260201.3b3b0fb4f042@gnoack.org>
References: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
 <20260128031814.2945394-3-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128031814.2945394-3-samasth.norway.ananda@oracle.com>

On Tue, Jan 27, 2026 at 07:18:11PM -0800, Samasth Norway Ananda wrote:
> Add errata section with code examples for querying errata and a warning
> that most applications should not check errata. Use kernel-doc directives
> to include errata descriptions from the header files instead of manual
> links.
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
>  Documentation/userspace-api/landlock.rst | 67 ++++++++++++++++++++++--
>  security/landlock/errata/abi-1.h         |  8 +++
>  security/landlock/errata/abi-4.h         |  7 +++
>  security/landlock/errata/abi-6.h         | 10 ++++
>  security/landlock/syscalls.c             |  4 +-
>  5 files changed, 91 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index c8ef1392a0c7..405b2d73e699 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: December 2025
> +:Date: January 2026
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -492,9 +492,68 @@ system call:
>          printf("Landlock supports LANDLOCK_ACCESS_FS_REFER.\n");
>      }
>  
> -The following kernel interfaces are implicitly supported by the first ABI
> -version.  Features only supported from a specific version are explicitly marked
> -as such.
> +All Landlock kernel interfaces are supported by the first ABI version unless
> +explicitly noted in their documentation.
> +
> +Landlock errata
> +---------------
> +
> +In addition to ABI versions, Landlock provides an errata mechanism to track
> +fixes for issues that may affect backwards compatibility or require userspace
> +awareness.  The errata bitmask can be queried using:
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
> +   decrease protection if misused.  For example, disabling the sandbox when an
> +   erratum is not fixed could leave the system less secure than using
> +   Landlock's best-effort protection.  When in doubt, ignore errata.
> +
> +.. kernel-doc:: security/landlock/errata/abi-4.h
> +    :doc: erratum_1
> +
> +.. kernel-doc:: security/landlock/errata/abi-6.h
> +    :doc: erratum_2
> +
> +.. kernel-doc:: security/landlock/errata/abi-1.h
> +    :doc: erratum_3
> +
> +How to check for errata
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
> +behavior that changed due to the fix.  The fixes generally make Landlock less
> +restrictive or more correct, not more restrictive.
>  
>  Kernel interface
>  ================
> diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
> index e8a2bff2e5b6..3f099555f059 100644
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
> + * ``LANDLOCK_ACCESS_FS_REFER`` restrictions.  This could allow privilege
> + * escalation in complex mount scenarios where directories become disconnected
> + * from their original mount points.
>   */
>  LANDLOCK_ERRATUM(3)
> diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
> index c052ee54f89f..fe11ec7d7ddf 100644
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
> index 5113a829f87e..5cb1475c7ea8 100644
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
> + * on multiple already-running threads at once.  Programs which enforce a
> + * Landlock policy at startup time and only then become multithreaded are not
> + * affected.  Without this fix, signal scoping could break multi-threaded
> + * applications that expect threads within the same process to freely signal
> + * each other.
>   */
>  LANDLOCK_ERRATUM(2)
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 8eaec8d35c44..9b7a7f39f26c 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -158,9 +158,11 @@ static const struct file_operations ruleset_fops = {
>  /*
>   * The Landlock ABI version should be incremented for each new Landlock-related
>   * user space visible change (e.g. Landlock syscalls).  This version should
> - * only be incremented once per Linux release, and the date in
> + * only be incremented once per Linux release.  When incrementing, the date in
>   * Documentation/userspace-api/landlock.rst should be updated to reflect the
>   * UAPI change.
> + * If the change involves a fix that requires userspace awareness, also update
> + * the errata documentation in Documentation/userspace-api/landlock.rst.
>   */
>  const int landlock_abi_version = 9;
>  
> -- 
> 2.50.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thanks!
–Günther
