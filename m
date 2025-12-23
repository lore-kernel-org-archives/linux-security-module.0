Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1527380A
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531325; cv=none; b=fLfarc6IDp6C/+AHZZ9CFTc9HQzyRAT/kcFRizq0dGd70J9zTAoZUpujZjfAzOXNrV6ulAuII0xDVOOVHmjZRQ4BQYDt4P6NqBoS7zz1oAT/tjX7kLNHUiGpprkE9rK383dt/cqBlZfD2WaP1/G7x0oatQJXOP31hFJRmA24Dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531325; c=relaxed/simple;
	bh=bZiqXniXLESkfZfzYkSfJ/Z7Xx0cGWAn3jJhutChG5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnL80vt9D+6IMP5Tq428te01bfGQOmUfJ9L38Fjz1VfjijuJ9hOR7rla/3YLzgo0xnWr6V8OC68k7v/HTG457c9ZKH+7Jtrxigr+m5XfDs/NYIRmLrZZfmuMbYvVWaIRgxmBJv5zhLFtUNnnpbQAcfLpmEbad2MPpXTemsg8JTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7SeYsPJ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7SeYsPJ"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b76b5afdf04so805610566b.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 15:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766531322; x=1767136122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDropeRqTtgrwlhMZpkxMhsrElPaz8xHFP2RAvCSuYU=;
        b=h7SeYsPJfYvIzL1x0pLQ4Ik/v7XECXGRBv8qKQBtQnPYC9YUwe5x3gFNvZ8qH4CvCb
         TR/J6hgEZZBJMDw3rOgGBylzv0AjPUOF5tiN9aLkV1KEkUHChERB6hN7QoYbREeAsaxR
         iJGyrC0vmKqrEkCRDhFu6Inz4htr+IyE2cFphYz8j0vFarc/pQG572s97qgjS/0pOMJN
         5hRuaKZZHuw8RJSbs++DZhXdKs2h6p0QtLirzU21k9SdHSpw5FfIy2678cyjuu5RgkKL
         niFCl2ZOr1C6Jhm5DG4rA5C97P2N8gWY9OdqOr3Couwuj1QMSBpt77r8/peZWs9CmwSs
         w5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766531322; x=1767136122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDropeRqTtgrwlhMZpkxMhsrElPaz8xHFP2RAvCSuYU=;
        b=Dt2cNSKOo8vU5Qfd7us9Fr7OzvSz9F97Ua1fwVmI8gwX86Th/q5fgTSSPLW7rWQ8Vn
         yPQkZC3o7wk+I/MY83i3gzGLM5m6JkKKeK7Ilebee8jjeZKO/WkbjEowIDJvpUPbpH89
         SyuyH3ckdwS96VQ+i3pAR/7t2ekabRtE0eRIaRVZSkd28nlWMyIjX+sjfbBLEQsxFaPy
         5gZlZgJctPkIQuPmLObYML/Rd54aY6iM8hM3/t/pXMJwpyv7p7PpDXUy3xEY7aUUG0qD
         DecGJo8fEvQ1C+T3tRxi7aKX7oinENWabSLTI0mtBIqg3hP9ChytFCWYJh9+S+XXMrOX
         B2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWiIqmrUcrgC2F+2WAMBS6IfkmSxsIBuJ5jBoFJC0GaAlrnjinMV2yAa2jdLJp4EAqUrSzo295yIpuRmkQ0pbw5Req63VY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4jNuKl33o66Sqes7S5GBiA9VDt/FUPSOfRFLT1NQ4CUgMKdi
	kqMNyMInlgshfMLVVtfE4ZIaHQAOlOdKvEXOIXEShmTRPkWLtYoXdijFoJg9VY10
X-Gm-Gg: AY/fxX5rZD2MhIDeytyzvxbBUiG9+fko3OrQJCtDVCdYNq7Zk5bOwYx9d9hWTz5Tu0M
	Fp1f2kBFbWdo/nIv4xMzKNbj+jbv8Au/XhCK3E4HTuHJYe04/s2GOgIaQXKC1ykjwAxnDTj3SUl
	PvSZerJHp6wLHMhQa92R4+OhiJDam0DPjIVST/rwWsXLzH0Q5qXRP7Kiv1CxeW8LxojjvWVL798
	MW2pmahvNYi3xp9q6MTJw+cospc/Ce/tr8dobRfUzQVub/y5aLHEqY6IxK3IxuvzpH28t3fLX22
	pdJmoFZVZWqAXNkDVVRd5IvcdRZpMvgqIRbr7MLqI82fON6JKVEGCZJw83Etw9BbtuDMGFvlraD
	rs6hw/eM/X8i9A/kDu2WoxDVAnB52UEP60F/n171wqqHL9jQoiULoiEzjTjRAIgnHdzxD2vHaVc
	xNZ2o8PTGNKVcn0TcwF7eKjiziKxpH3IzrQes2+gqJ96i6+kE=
X-Google-Smtp-Source: AGHT+IGNrd/aiJoscqZbZMwuTziKyxo6LNJXwTNPF9UPCeFXUo3EHhJXhsvqRUnckvFUizQH+2K+SQ==
X-Received: by 2002:a17:907:968d:b0:b7f:fa99:2cde with SMTP id a640c23a62f3a-b8037153916mr1722224066b.40.1766531321748;
        Tue, 23 Dec 2025 15:08:41 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b803d3cea32sm1454810666b.34.2025.12.23.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 15:08:41 -0800 (PST)
Date: Wed, 24 Dec 2025 00:08:39 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: mic@digikod.net, gnoack@google.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] landlock: Document Landlock errata mechanism
Message-ID: <20251223.4aaf05850b4c@gnoack.org>
References: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
 <20251216210248.4150777-2-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216210248.4150777-2-samasth.norway.ananda@oracle.com>

Hello!

On Tue, Dec 16, 2025 at 01:02:43PM -0800, Samasth Norway Ananda wrote:
> Add comprehensive documentation for the Landlock errata mechanism,
> including how to query errata using LANDLOCK_CREATE_RULESET_ERRATA
> and detailed descriptions of all three existing errata.
> 
> Also update the code comment in syscalls.c to remind developers to
> update errata documentation when applicable, and update the
> documentation date to reflect this new content.
> 
> This addresses the gap where the kernel implements errata tracking
> but provides no user-facing documentation on how to use it.

Thank you very much, this is absolutely right that this was missing
and overall, this is an excellent change!  I have only some nit-picks
and smaller questions below.

> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  Documentation/userspace-api/landlock.rst | 99 +++++++++++++++++++++++-
>  security/landlock/syscalls.c             |  4 +-
>  2 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b8caac299056..d1f7dd30395d 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: March 2025
> +:Date: December 2025
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -445,6 +445,103 @@ system call:
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
> +Known Errata
> +~~~~~~~~~~~~

I see that the following sections are based on the descriptions in
security/landlock/errata/abi-*.h.  These header files have docstrings
with "DOC:" identifiers -- would it not be possible to improve that
documentation in-place and link that from the user documentation?

I like the structured approach with the "Impact" section.  This seems
useful for readers who want to evaluate whether they are affected.

> +
> +**Erratum 1: TCP socket identification (ABI 4)**
> +
> +Fixed an issue where IPv4 and IPv6 stream sockets (e.g., SMC, MPTCP, or SCTP)
> +were incorrectly restricted by TCP access rights during :manpage:`bind(2)` and
> +:manpage:`connect(2)` operations.
> +
> +*Impact:* In kernels without this fix, using ``LANDLOCK_ACCESS_NET_BIND_TCP``
> +or ``LANDLOCK_ACCESS_NET_CONNECT_TCP`` would incorrectly restrict non-TCP
> +stream protocols.
> +
> +*How to check:*
> +
> +.. code-block:: c
> +
> +    if (errata & (1 << 0)) {
> +        /* Erratum 1 is fixed - TCP restrictions only apply to TCP */
> +        /* Safe to use non-TCP stream protocols */
> +    }
> +
> +**Erratum 2: Scoped signal handling (ABI 6)**
> +
> +Fixed an issue where signal scoping (``LANDLOCK_SCOPE_SIGNAL``) was overly
> +restrictive, preventing sandboxed threads from signaling other threads within
> +the same process if they belonged to different Landlock domains.
> +
> +*Impact:* Without this fix, signal scoping could break multi-threaded
> +applications that expect threads within the same process to freely signal
> +each other, as documented in :manpage:`nptl(7)` and :manpage:`libpsx(3)`.

Maybe to help explain the impact: The problem only manifests when the
userspace process is itself using libpsx(3) or an equivalent mechanism
to enforce a Landlock policy on multiple (already running) threads at
once.  Programs which enforce a Landlock policy at startup time and
only then become multithreaded are not affected.

> +
> +*How to check:*
> +
> +.. code-block:: c
> +
> +    if (errata & (1 << 1)) {
> +        /* Erratum 2 is fixed - threads can signal within same process */
> +        /* Safe to use LANDLOCK_SCOPE_SIGNAL with multi-threaded apps */
> +    }
> +
> +**Erratum 3: Disconnected directory handling (ABI 1)**
> +
> +Fixed an issue with disconnected directories that occur when a directory is
> +moved outside the scope of a bind mount. The fix ensures that evaluated access
> +rights include both those from the disconnected file hierarchy down to its
> +filesystem root and those from the related mount point hierarchy.
> +
> +*Impact:* Without this fix, it was possible to widen access rights through
> +rename or link actions involving disconnected directories, potentially
> +bypassing ``LANDLOCK_ACCESS_FS_REFER`` restrictions.
> +
> +*How to check:*
> +
> +.. code-block:: c
> +
> +    if (errata & (1 << 2)) {
> +        /* Erratum 3 is fixed - disconnected directories handled correctly */
> +        /* LANDLOCK_ACCESS_FS_REFER restrictions cannot be bypassed */
> +    }
> +
> +When to Check Errata
> +
> +Applications should check for specific errata when:
> +
> +1. Using features that were relaxed or had their behavior changed (like
> +   erratum 2 with signal scoping in multi-threaded applications).
> +2. Relying on specific security guarantees that may not have been fully
> +   enforced in earlier implementations (like erratum 3 with refer restrictions).
> +3. Using network restrictions and need to ensure other protocols aren't
> +   incorrectly blocked (erratum 1).
> +
> +Most applications using Landlock's best-effort approach don't need to check
> +errata, as the fixes generally make Landlock less restrictive or more correct,
> +not more restrictive.
> +

This section looks good to me as well.

>  The following kernel interfaces are implicitly supported by the first ABI
>  version.  Features only supported from a specific version are explicitly marked
>  as such.
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

I think this is a very good change.  My main open question here is
whether we can link this with the header documentation instead of
duplicating the documentation in two places.

Thanks!
–Günther
