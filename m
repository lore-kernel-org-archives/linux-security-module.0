Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7625351C07
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562015; cv=none; b=dwku0q49DKkbur1ZGKr4pPhRiRCjKfaltgu+TgmXukLp3tUhLZ3cVwbwqPK9AcPh9HGZZLXmNvPocny5vxyEN4zotBhnU72j5z3aQJhyuBnQiWF4iuipCKQoA6M+2IOg6lwLUkQr0mVg60ngFcii4IEvVCw9KLvZek6r0E0KoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562015; c=relaxed/simple;
	bh=TigRnNucP1JKqKFvRMBZ0GY+U+2g7xnwdmAkCAkMdiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ3F0eqe7ZctE9MbeZ7GynO9QeOE+V/ptaRLAve1XD07s+15I55jrXjUHwjJlNI3MrFeJnAHxOepqHUhqX9Ydf3bSd2qqyV9B3IJvVBZvdjCm+CF7VQkacVwJXqHqvhllruagEjyNq84wa6CCyZHbf8WiFLbj9eiYlpTrUxpUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jNjgqlir; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jNjgqlir"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQNrw3NKLz1yy;
	Tue,  3 Mar 2026 19:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772560864;
	bh=wJDqabafsMaqpu2AVqJ8pzPHaGqy+cEbE05PR3lKnyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNjgqlirGrFfb9odDN47hX3pD63z2G8adQ0UyStWa3nkyaU0Uf43Wm9k/tv78onHH
	 oO7dPV6htnydaiobEM+ktkNnv1DUiIp7w/aNJKg4KG2TcGBxzbeDisVwV/R7MqgQPA
	 gVbDjCq1R0BYS23bX8kwQZuC9yum1Hf4S6iz0eXk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fQNrv3jygz9ZQ;
	Tue,  3 Mar 2026 19:01:03 +0100 (CET)
Date: Tue, 3 Mar 2026 19:01:00 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Cojocaru <dan@dcdev.ro>
Subject: Re: [PATCH v3] landlock: Expand restrict flags example for ABI
 version 8
Message-ID: <20260303.Paechahp4eco@digikod.net>
References: <20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net>
X-Infomaniak-Routing: alpha

On Sat, Feb 28, 2026 at 10:36:59PM +0100, Panagiotis "Ivory" Vasilopoulos wrote:
> Add LANDLOCK_RESTRICT_SELF_TSYNC to the backwards compatibility example
> for restrict flags. This introduces completeness, similar to that of
> the ruleset attributes example. However, as the new example can impact
> enforcement in certain cases, an appropriate warning is also included.
> 
> Additionally, I modified the two comments of the example to make them
> more consistent with the ruleset attributes example's.
> 
> Signed-off-by: Panagiotis 'Ivory' Vasilopoulos <git@n0toose.net>
> Co-developed-by: Dan Cojocaru <dan@dcdev.ro>
> Signed-off-by: Dan Cojocaru <dan@dcdev.ro>
> ---
> Changes in v3:
> - Add __attribute__((fallthrough)) like in earlier example.
> - Improve comment for LANDLOCK_RESTRICT_SELF_TSYNC (ABI < 8) example.
> - Add relevant warning for ABI < 8 example based on Günther's feedback.
> - Link to v2: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net
> 
> Changes in v2:
> - Fix formatting error.
> - Link to v1: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net
> ---
>  Documentation/userspace-api/landlock.rst | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 13134bccdd39d78ddce3daf454f32dda162ce91b..b71ac7aa308260b8141e5d35248fb68cec6dcba9 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -196,13 +196,33 @@ similar backwards compatibility check is needed for the restrict flags
>  (see sys_landlock_restrict_self() documentation for available flags):
>  
>  .. code-block:: c
> -
> -    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> -    if (abi < 7) {
> -        /* Clear logging flags unsupported before ABI 7. */
> +    __u32 restrict_flags =
> +        LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +        LANDLOCK_RESTRICT_SELF_TSYNC;
> +    switch (abi) {
> +    case 1 ... 6:
> +        /* Clear logging flags unsupported for ABI < 7 */
>          restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
>                              LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
>                              LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> +        __attribute__((fallthrough));
> +    case 7:
> +        /* Removes multithreaded enforcement flag unsupported for ABI < 8 */
> +        /*
> +         * WARNING!
> +         * Don't copy-paste this just yet! This example impacts enforcement
> +         * and can potentially decrease protection if misused.

What could be the use case when that would be an issue? What would be
the consequence wrt just tampering with a sibling thread?

> +         *
> +         * Below ABI v8, a Landlock policy can only be enforced for the calling
> +         * thread and its children. This behavior remains a default for ABI v8,
> +         * but the flag ``LANDLOCK_RESTRICT_SELF_TSYNC`` can now be used to
> +         * enforce policies across all threads of the calling process. If an
> +         * application's Landlock integration was designed under the assumption
> +         * that the flag is used (such as when children threads are responsible
> +         * for enforcing and/or overriding policies of parents and siblings),
> +         * removing said flag can decrease protection for older Linux versions.

In this case, the application *must* check the ABI version and exit with
an error if it is not supported.  That's the same use case as programs
wishing to sandbox themselves at least with a specific set of
restrictions.

> +         */
> +        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
>      }
>  
>  The next step is to restrict the current thread from gaining more privileges
> 
> ---
> base-commit: ceb977bfe9e8715e6cd3a4785c7aab8ea5cd2b77
> change-id: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366
> 
> Best regards,
> -- 
> Panagiotis "Ivory" Vasilopoulos <git@n0toose.net>
> 
> 
