Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521F42D76C
	for <linux-security-module@vger.kernel.org>; Fri,  7 Aug 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100733; cv=none; b=bjv6wLRTiqIssCncE1aP0Q8asQkPFMcsudtIQ1cMhdiB2GE5RTbiqd2JOPA7onvtGrgLTiuSC78ObMCfaw1CghLj82CcSJQXdM3S3X5GXAMDQk5Jdfcf1NhQwaWBCwWKXAu5K0X8LBtNHUHyx0M4618bln9TCUYh6k4PsHNX5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100733; c=relaxed/simple;
	bh=tIC3ChZmnMfd5Mq09babRsj7ZfwBXShv6mpf+8lH5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f90f/HVjuz40XoosyBL123nZ15hmmcFHt5zSzCdVGtATsqi3m+Y+935zlJgtkq1LRVUle2VKfDjP4m2EQWgedriDIiQIkS/K0hXiUku9xQzsoa4GppXia8E3UUPJj3bStG8wE5HCBEwXFJnq4PgMwdLqgOwl7IIPHwjUDqyL/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OUYIO649; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OUYIO649"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGh1J08mKzqv0;
	Fri,  7 Aug 2026 12:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786100227;
	bh=t1DXwWwjpP6UIAKW2IV2JfNVb4wsFSCa0DjtRx85wOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUYIO6493KoDHl5J+UgPYCxZ8ALUhiiXeh6qLtpKs2RBksFPkfRHxIXHfc5L40gD9
	 UpiGJeFHStArg6opcih0uK45Mu/VtkiuGKZveVQeXV387HhSDMwGv3jsxA3qV0d7L8
	 uidKPtrJH3W96jYX0ST+e2FJjPajDOC55Kr6iNRQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGh1H3043zfBh;
	Fri,  7 Aug 2026 12:57:07 +0200 (CEST)
Date: Fri, 7 Aug 2026 12:57:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 3/4] landlock: Document
 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260807.IeD6oowuipee@digikod.net>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
 <20260803223109.707353-4-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803223109.707353-4-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 03, 2026 at 06:31:07PM -0400, Justin Suess wrote:
> Document setting no_new_privs with ruleset enforcement, following the
> same compatibility section style as previous ABI additions.
> 
> Include a section explaining the tradeoffs of setting no_new_privs
> through any means for privileged users of Landlock.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Notes:
>     v2->v3:
>     - Update the tutorial: restrict_flags per ABI version and prctl call
>       skipped when LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is used
>     - Drop "Atomic" from the section title; describe the ordering instead
>     - Explain that not setting no_new_privs is risky even when not required
>     - Fix ABI 8/9 switch coverage (case 8 ... 10) and indentation
> 
>  Documentation/userspace-api/landlock.rst | 47 +++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 5085822d8930..0e4a73fd5ea4 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: July 2026
> +:Date: August 2026
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -250,7 +250,8 @@ similar backwards compatibility check is needed for the restrict flags
>  
>      __u32 restrict_flags =
>          LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> -        LANDLOCK_RESTRICT_SELF_TSYNC;
> +        LANDLOCK_RESTRICT_SELF_TSYNC |
> +        LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
>      switch (abi) {
>      case 1 ... 6:
>          /* Removes logging flags for ABI < 7 */
> @@ -269,16 +270,36 @@ similar backwards compatibility check is needed for the restrict flags
>           * children (and not for all threads, including parents and siblings).
>           */
>          restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
> +        __attribute__((fallthrough));
> +    case 8 ... 10:
> +        /* Removes no new privs flag for ABI < 11 */
> +        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
>      }
>  
>  The next step is to restrict the current thread from gaining more privileges
> -(e.g. through a SUID binary).  We now have a ruleset with the first rule
> -allowing read and execute access to ``/usr`` while denying all other handled
> -accesses for the filesystem, and two more rules allowing DNS queries.
> +(e.g. through a SUID binary).  For unprivileged processes, setting the
> +no_new_privs attribute is required by Landlock.
> +
> +Processes with ``CAP_SYS_ADMIN`` in their namespace can enforce a ruleset
> +without it, but not setting no_new_privs is risky even when it is not

This is a new paragraph and understanding the "it" requires some
stretches.

> +required: sandboxed processes could still execute set-user-ID, set-group-ID
> +or file-capability binaries, which would then run with elevated privileges
> +while being restricted by a Landlock domain they may not expect, making them
> +potential confused deputies.  Setting no_new_privs should only be avoided if
> +such a privilege transition is expected.
> +
> +We now have a ruleset with the first rule allowing read and execute access to
> +``/usr`` while denying all other handled accesses for the filesystem, and two
> +more rules allowing DNS queries.
>  
>  .. code-block:: c
>  
> -    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> +    /*
> +     * If the ABI > 10, we can tie setting no_new_privs with successful ruleset
> +     * enforcement and skip the manual prctl(PR_SET_NO_NEW_PRIVS, ...) call.
> +     */
> +    if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
> +        prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>          perror("Failed to restrict privileges");
>          close(ruleset_fd);
>          return 1;
> @@ -792,6 +813,20 @@ when at least one sys_landlock_add_rule() call is made for it with the
>  ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
>  object without this flag do not clear it.
>  
> +no_new_privs flag (ABI < 11)
> +----------------------------
> +
> +Starting with the Landlock ABI version 11, sys_landlock_restrict_self()
> +accepts the ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag, which sets the
> +no_new_privs attribute of the calling thread only once the enforcement of
> +the ruleset succeeded: no_new_privs is set if and only if the call
> +succeeds.  This removes the need for a prior :manpage:`prctl(2)`
> +``PR_SET_NO_NEW_PRIVS`` call, and with it the ``CAP_SYS_ADMIN``
> +requirement.

Reading this looks like CAP_SYS_ADMIN is always a requirement...  What
about:

  +``PR_SET_NO_NEW_PRIVS`` call (or ``CAP_SYS_ADMIN`` use).

> When combined with ``LANDLOCK_RESTRICT_SELF_TSYNC``,
> +no_new_privs is set on all threads of the process.  As explained in the
> +tutorial above, not setting no_new_privs is risky even when it is not
> +required.
> +
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.54.0
> 
> 
