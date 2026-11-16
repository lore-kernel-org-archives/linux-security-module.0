Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835616;
	b=oaOvGZo08EIoe0Xjbc2l5KB3RrPd6LiYsSKYzLvnZQD5x8EnNT+DwmENszMnOV5ZmtLX
	 pbB2Xx+QNfdQM5Naz/4U+jZEPvWUsWaKFwpXdOLcym4OjDzkYY3EJR3pHbf92gB3ThbfO
	 g25Uao3aKtn6zwiRMevgmthsW/8WANCh/1GYXeV0KTYaVHof1Ye0QEQUuL/BtGUQ/DeOO
	 VJ3qKGX+LmAB6Qjfy4KzevJeEEDqmg04cRfXdNLuDkH5gVvE88ZuPGAg4dUfhpgl63uXv
	 5h0mjoY7Yp5AgPMvnTKvXq2tStQsRSgEjj6PrmHR+z0lZRZGi/Pu59d1sz1BTAzftgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835616;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=TCgq84WO/3cyokOtecMji3tTMIJuIqZrzNWkIKcIx0k=;
	b=pb5Rc2W7gnIYFzNTj8XM0iTn7dJ6oW7t1TlOgu9oCo+v35RxUi3PvF3ubmM7DIL51mO9
	 iBLHWFX2DsG7OisUTg+QSmUzYsGJwh2EFyZ5aidk60E9hYsicKgoEQm9+44+mGZWpVWjP
	 d43tHaq+nBs1AzOPTX4rSsAeyzgXuUaJvU+MzhAcrvOGB1Q+bVi/y7HOsDB3HEG0q3Lml
	 sPuqWffflrGrVCWVA+ZRYrDQtUIGmLmOFXbjMjAa5WlfM/NWwbvCXhuw8K40rzmhm7KDw
	 ltEr3+NGN+T0sVfbb6EZfX2z77OLE9tZilGWR/1Mclxf+HVGf5KNhpKr4SF2O/Eq3bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=lgj0Vnbt;
	arc=none smtp.remote-ip=84.16.66.169
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BF606A334
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 13:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51BF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=lgj0Vnbt
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSpYJ6zryz1L6X;
	Mon, 16 Nov 2026 14:26:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794835604;
	bh=TCgq84WO/3cyokOtecMji3tTMIJuIqZrzNWkIKcIx0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgj0Vnbt4KkN/1k4fsZPie+qFfCeFxZPLbG3wkr7ko1kCIzoVmZenCNH8zmdMIBwh
	 RfhgJhZo2l1Uh6cv1mYQYahi/TcY+4Rp7RVr5cuZSJ1HIQlnQrSOdwxDJyd0FWOkUq
	 DYZxj6QopUlCumNVJgAPkKQkCLnAs+p4bEeTx8OQ=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jSpYF0pWnzZ3j;
	Mon, 16 Nov 2026 14:26:41 +0100 (CET)
Date: Mon, 16 Nov 2026 14:26:37 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>, 
	James Morris <jmorris@namei.org>, Josef Bacik <josef@toxicpanda.com>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, kernel-team@cloudflare.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 6/6] landlock: Fix capability restriction documentation
Message-ID: <20261116.afieche0Te7E@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-7-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110202436.2408244-7-mic@digikod.net>
X-Infomaniak-Routing: alpha

Thanks, applied!

I fixed some minor issues though, see
https://git.kernel.org/mic/c/57493c3b7f449a60d1c43322158671b98684f9b1

On Tue, Nov 10, 2026 at 09:24:34PM +0100, Mickaël Salaün wrote:
> Some documented claims about LANDLOCK_PERMISSION_CAPABILITY_USE do not
> hold for every capability check.  Remove them instead of listing their
> exceptions, and call it a permission instead of a hook.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  Documentation/security/landlock.rst      | 8 ++++----
>  Documentation/userspace-api/landlock.rst | 8 ++++----
>  include/uapi/linux/landlock.h            | 6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> index d81f1c2cd236..98c2e7139e8d 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -8,7 +8,7 @@ Landlock LSM: kernel documentation
>  ==================================
>  
>  :Author: Mickaël Salaün
> -:Date: October 2026
> +:Date: November 2026
>  
>  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>  harden a whole system, this feature should be available to any process,
> @@ -359,9 +359,9 @@ framework in ``log.c``, compiled under ``CONFIG_SECURITY_LANDLOCK_LOG``
>  (automatically selected by ``CONFIG_AUDIT`` or ``CONFIG_TRACEPOINTS``).
>  
>  Audit records respect audit configuration, the domain's Landlock log
> -flags, and ``LANDLOCK_LOG_DISABLED``.  Tracepoints fire unconditionally,
> -independent of these settings.  The denial counter (``num_denials``) is
> -always incremented regardless of logging configuration.
> +flags, and ``LANDLOCK_LOG_DISABLED``.  Tracepoints fire independently of
> +these settings.  The denial counter (``num_denials``) is
> +incremented regardless of logging configuration.
>  
>  Each denial tracepoint carries a ``logged`` field reporting the
>  audit-logging verdict: whether the denial would be written to the audit
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 3d45b956b640..d00e94d8ed37 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: October 2026
> +:Date: November 2026
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -532,7 +532,7 @@ acquisition via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`.  Namespaces
>  the process is already a member of when the domain is enforced are implicitly
>  allowed (the process could not continue running otherwise); rules describe
>  which new namespace types the process may acquire.
> -``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates every exercise of a capability
> +``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates the exercise of capabilities
>  after the domain is enforced, regardless
>  of how the capability was obtained (inherited credentials, ``CLONE_NEWUSER``
>  grant, ``setuid``/file-cap-bearing :manpage:`execve(2)`, etc.).  Configuring
> @@ -641,9 +641,9 @@ after a domain is enforced through user namespace entry or :manpage:`capset(2)`;
>  privileged sandboxes that did not set ``PR_SET_NO_NEW_PRIVS`` may also gain
>  capabilities through :manpage:`execve(2)` of binaries with file capabilities.
>  In all cases, :manpage:`capget(2)` will report the credential's capability sets,
> -but any denied capability will fail with ``EPERM`` when exercised.  Do not rely
> +but any denied capability will fail when exercised.  Do not rely
>  on :manpage:`capget(2)` to determine whether the policy permits a given
> -capability; only the actual operation will return ``EPERM`` upon denial.
> +capability.
>  
>  Truncating files
>  ----------------
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 24510e5d8479..c9e4ce23778b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -622,9 +622,9 @@ struct landlock_capability_attr {
>   * - %LANDLOCK_PERMISSION_CAPABILITY_USE: Restrict the use of specific Linux
>   *   capabilities.  A process in a Landlock domain that handles this permission
>   *   is denied from exercising capabilities that are not explicitly allowed by a
> - *   %LANDLOCK_RULE_CAPABILITY rule.  This hook is purely restrictive: it can
> - *   deny capabilities that the kernel would otherwise grant, but it can never
> - *   grant capabilities that the kernel already denied.  Support added in
> + *   %LANDLOCK_RULE_CAPABILITY rule.  This permission is purely restrictive: it
> + *   can deny capabilities that the kernel would otherwise grant, but it can
> + *   never grant capabilities that the kernel already denied.  Support added in
>   *   Landlock ABI version 12.
>   */
>  #define LANDLOCK_PERMISSION_NAMESPACE_USE			(1ULL << 0)
> -- 
> 2.56.0
> 
> 
