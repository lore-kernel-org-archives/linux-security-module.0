Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8451D95A3
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533686; cv=none; b=EMfMncS4LfHJrqngMJkM3iLdm9cLQMZa9AVlkp/QK4AABa3ispExMm/Yy4/2sGmyIztBZnPblE43tSVaUHXqtEZ+AEAZuvuYYATvEIHvaqiB2rDw3pkzxzKvQpO1EBmzGETYk1yVqMf9Yt4Bh5xgoB0AKdIcm76nQHd7LYuCtvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533686; c=relaxed/simple;
	bh=Z9smmFIdJb/NlsIgvB64oPHe69DfqN9t2vacH+UEdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5rzHoPnTiJDCu7BfaTqBR7E9cI2j1i97ZroThFovxj5G2yWERorHGqK4SPWRLV2JYlleFJ4QLIwojTSa6nC9ebzlpp9cpxv2iKT6tvu7D0S+XWd+vsI+wSmnk/SnEcRdj15tc9YgXLen46WHgzXZjjHbTD4eo91IrShXtKOnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i7LnutbA; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i7LnutbA"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfV95t7PzfK1;
	Fri, 31 Jul 2026 23:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533681;
	bh=LM0Bvebm34VP2BofcQ7ewRqFDYbMmR5MEaYhV1ZO1vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7LnutbASOfiCP5ObiZfYpEFqYW+Qj1qeWDhAdjNEBUO2otHLGqIQamcB++a10a4I
	 2PuBbBYL8IRcdpbEnaREu8U1Wph73b5qAWA9M+8uolE4tt60Zwg/gPJ+eY7Pc4BQQx
	 26vrcZImlT856C9cdOmPCVNiqsG1kDDsdROs+CDI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfV922sQzW4r;
	Fri, 31 Jul 2026 23:34:41 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:34:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/3] landlock: Document
 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260731.zoo0aeZ8iyee@digikod.net>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
 <20260717220320.1030123-4-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717220320.1030123-4-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 17, 2026 at 06:03:19PM -0400, Justin Suess wrote:
> Document atomically setting no_new_privs with ruleset enforcement,
> following the same compatibility section style as previous ABI
> additions.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 5a63d4476c1c..ec87d35f4715 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst

The tutorial in this doc should also be updated accordingly, taking into
account the best-effort approach and then the fallback to calling prctl.

First by updating the restrict_flags content according to the ABI
version, and then by updating the prctl block with something like this:

  if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
      prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {

The saandboxer sample should also follow the same pattern.

> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: June 2026
> +:Date: July 2026
>  
>  The goal of Landlock is to enable restriction of ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -789,6 +789,18 @@ when at least one sys_landlock_add_rule() call is made for it with the
>  ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
>  object without this flag do not clear it.
>  
> +Atomic no_new_privs (ABI < 11)
> +------------------------------

You can just drop the "Atomic" in this title.

> +
> +Starting with the Landlock ABI version 11, sys_landlock_restrict_self()
> +accepts the ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag, which sets the
> +no_new_privs attribute of the calling thread atomically with the enforcement

It should be something like "all-or-nothing" instead of atomically, or
just describe the proprety.

> +of the ruleset: no_new_privs is set if and only if the call succeeds.  This
> +removes the need for a prior :manpage:`prctl(2)` ``PR_SET_NO_NEW_PRIVS``
> +call, and with it the ``CAP_SYS_ADMIN`` requirement.  When combined with
> +``LANDLOCK_RESTRICT_SELF_TSYNC``, no_new_privs is set on all threads of the
> +process.

One important point of this flag is that the NNP is only set if the
ruleset enforcement succeed (ordering).

Also, as discussed previously, it should be explicit in the doc that not
setting no_new_privs is risky even when it is not required, and this
flag makes it cheap to avoid.

> +
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.54.0
> 
