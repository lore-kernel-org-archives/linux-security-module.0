Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D871799F;
	Fri, 31 Jul 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536647; cv=none; b=Z5I71eVA1qMKO7jyb2b2gJiQoX4SvcSJzrDiTlHjwBgzENpP0tiqZ73WWkehnlrek/JE7uPjyXsbQyrs79SGw+pr6dBl/TWGbOjSaXXfP5zE5YWmNNJslxrj0d3fpCpNJpwJNvXOWcMqXb+76ZbHYPJTX2XN/fEPxOQJUolgni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536647; c=relaxed/simple;
	bh=pZlDBW6wFmBMfiD7gvv+9wWnzXa9gTqOU3IgdZHxurI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tFpQMGaHaq3m1ctv3Zhen2TmMlnMuwRJBQGsAu+pK03jScW1ijHv4lYyhcGtjwtskhCsEK6Cyl1HHkJTPuxHHCbtP2bFIZAwpEnkqoI0fKQ7y4rximpP2RQEL/GPEbYobo3e1WRFQ68D+p5qiFTY/v2/NXoRruns1JXf7GDOMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaEQg0g/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaEQg0g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938D11F00AC4;
	Fri, 31 Jul 2026 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536645;
	bh=Uo/MlC3YOMWoUPCUcPdIAEmndEKoNUaoCcxG1B29CzM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PaEQg0g/7nzGdaHF7IK/MLSyJ2o3cA+FjIF+4sRrBCHZdpAGf1zzieJdYkXk1YrQf
	 lVUDeTBZVrOx8tUFBnNIta5B3TXOWUnJtDbK+ym42/VEnLwD2nxz9EEoazjk9bo5Fm
	 hI5hQOBPtxE2HtfTLjS5z0a8F/JEG+6EjJFfVwjDobLI1pHIm3ncMpDF4+pcoehTEg
	 I/QWMatYCAttxkgZYKW9MKUpnQOzVox3WD56AGy9gdzyE/1r3Ttlsq3qgZsmlSNI29
	 xomjMBYNsQOeFm6w5Mnf5wg11GLMY1THEetYjTmLV9jjsp1IQgtq/scMCAnYq2qXxQ
	 UexdvsD9EqUxw==
Content-Type: multipart/mixed; boundary="===============8898737113916352117=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea9b8de8b22eb98e115d87edf25dbf6793b5b00aadc9cb62ca09402e689545d8@mail.kernel.org>
In-Reply-To: <20260731022047.189137-6-utilityemal77@gmail.com>
References: <20260731022047.189137-6-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next 05/13] landlock: Factor the credential restriction out of landlock_restrict_self()
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:24:04 +0000 (UTC)

--===============8898737113916352117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> index cc419de75cd6b..13b3952c31c57 100644
> --- a/security/landlock/cred.c
> +++ b/security/landlock/cred.c

[ ... ]

> @@ -8,14 +8,114 @@
>   */
>
>  #include <linux/binfmts.h>
> +#include <linux/bits.h>
>  #include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
>  #include <linux/lsm_hooks.h>
> +#include <uapi/linux/landlock.h>
>
>  #include "common.h"
>  #include "cred.h"
> +#include "domain.h"
>  #include "ruleset.h"
>  #include "setup.h"

[ ... ]

> +int landlock_prepare_restriction(
> +	const struct landlock_cred_security *const llcred,
> +	struct landlock_ruleset *const ruleset, const u32 flags,
> +	struct landlock_restriction *const restriction)
> +{
> +#ifdef CONFIG_AUDIT
> +	/* Translates "off" and "on" flags to booleans. */
> +	const bool log_same_exec =
> +		!(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
> +	const bool log_new_exec =
> +		!!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
> +	const bool log_subdomains =
> +		!(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> +	const bool prev_log_subdomains = !llcred->log_subdomains_off;
> +#endif /* CONFIG_AUDIT */
> +
> +	*restriction = (struct landlock_restriction){};
> +
> +#ifdef CONFIG_AUDIT
> +	restriction->log_subdomains_off = !prev_log_subdomains ||
> +					  !log_subdomains;
> +#endif /* CONFIG_AUDIT */
> +
> +	if (!ruleset)
> +		return 0;
> +
> +	restriction->domain = landlock_merge_ruleset(llcred->domain, ruleset);
> +	if (IS_ERR(restriction->domain)) {
> +		const int err = PTR_ERR(restriction->domain);
> +
> +		restriction->domain = NULL;
> +		return err;
> +	}
> +
> +#ifdef CONFIG_AUDIT
> +	restriction->domain->hierarchy->log_same_exec = log_same_exec;
> +	restriction->domain->hierarchy->log_new_exec = log_new_exec;
> +	if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
> +		restriction->domain->hierarchy->log_status =
> +			LANDLOCK_LOG_DISABLED;
> +#endif /* CONFIG_AUDIT */
> +
> +	return 0;
> +}

This isn't a bug, but would keeping the merged domain in a local (as the
pre-refactor new_dom did) and only storing it into restriction->domain on
success read a bit closer to the surrounding landlock code, and let the
explicit NULL reset go away?

The merged domain is only ever referred to through restriction->domain:
five uses in the error handling and three restriction->domain->hierarchy->...
chains for the audit configuration. The code this was factored out of used
a local for exactly this (struct landlock_ruleset *const new_dom =
landlock_merge_ruleset(...), then new_dom->hierarchy->log_same_exec = ...),
and the neighbouring landlock code consistently uses that shape (e.g.
security/landlock/syscalls.c: ruleset = landlock_get_ruleset_from_fd(...);
if (IS_ERR(ruleset)) return PTR_ERR(ruleset);).

A local struct landlock_ruleset *domain assigned to restriction->domain on
success would also fold the explicit restriction->domain = NULL; reset away,
since restriction is already zeroed by the *restriction = (struct
landlock_restriction){}; above.

> diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> index f287c56b5fd4b..1d5039b46ce7a 100644
> --- a/security/landlock/cred.h
> +++ b/security/landlock/cred.h
> @@ -20,6 +20,31 @@
>  #include "ruleset.h"
>  #include "setup.h"
>
> +/**
> + * struct landlock_restriction - Computed credential restriction
> + *
> + * The result of landlock_prepare_restriction(): the new state that
> + * enforcing a ruleset with a set of landlock_restrict_self(2) flags
> + * gives to a credential, decoupled from its application.  It is
> + * enforced with landlock_apply_restriction(), either right away
> + * (landlock_restrict_self(2)) or after a staging period (restriction
> + * of an execution).
> + */
> +struct landlock_restriction {
> +	/**
> +	 * @domain: New domain to enforce, owning a reference.  NULL if the
> +	 * restriction only carries a log configuration change.
> +	 */
> +	struct landlock_ruleset *domain;
> +#ifdef CONFIG_AUDIT
> +	/**
> +	 * @log_subdomains_off: New value of the credentials'
> +	 * @landlock_cred_security.log_subdomains_off.
> +	 */
> +	u8 log_subdomains_off : 1;
> +#endif /* CONFIG_AUDIT */
> +};

This isn't a bug, but would &landlock_cred_security.log_subdomains_off
work better here, so the rendered docs link to the other struct the way
ruleset.h does for &landlock_ruleset.root_inode?

The member description cross-references another struct's member with
@landlock_cred_security.log_subdomains_off. Per
Documentation/doc-guide/kernel-doc.rst, @parameter is for members of the
struct being documented (formatting only, no cross-referencing), while a
member of a different struct is written &struct_name.member to generate an
actual cross-reference.

cred.h is pulled into the rendered docs by
Documentation/security/landlock.rst (.. kernel-doc::
security/landlock/cred.h), so the reference renders as plain bold text
instead of a link to struct landlock_cred_security. The surrounding
subsystem already uses the & form for this, e.g.
security/landlock/ruleset.h:71 (Type of &landlock_ruleset.root_inode's node
keys).

> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 9af2407274b25..899601af7c4e1 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c

This isn't a bug, but since this hunk drops the last BIT() and
hierarchy/LANDLOCK_LOG_* users in this file, could <linux/bitops.h> and
"domain.h" be dropped from syscalls.c too, mirroring the includes added to
cred.c?

Moving the domain merge and audit-log configuration into cred.c removes the
last users of two includes in syscalls.c, but both includes stay.
<linux/bitops.h> (earlier in the file) was needed only for the
BIT(new_dom->num_layers - 1) in the deleted domain_exec update, and
"domain.h" only for LANDLOCK_LOG_DISABLED and the
new_dom->hierarchy->log_* stores.

Grepping the post-patch file for every symbol either header declares
(BIT/GENMASK/hweight/fls/test_bit/set_bit/... and LANDLOCK_LOG_*,
landlock_hierarchy, landlock_details, landlock_init_hierarchy_log,
landlock_get_hierarchy, landlock_put_hierarchy, LANDLOCK_PATH_MAX_SIZE)
returns no hits.

cred.c correctly gains <linux/bits.h> and "domain.h" in the same commit,
so the dependency moved rather than disappeared. Note <linux/compiler_types.h>
is still needed (__always_inline at line 66) even though the
__maybe_unused user went away.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30599733854
--===============8898737113916352117==--
