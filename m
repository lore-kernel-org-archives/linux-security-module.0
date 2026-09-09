Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B43BED7A;
	Wed,  9 Sep 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985808; cv=none; b=TuN/UUxxxRLGHsjKpV+sZjYknhx4k5uMMiqH32T9Dx0VtD/JJIgDAdKz5MCzrEzXK8gyNjQCUICxlFVEw+Tf4tiR0UcxPmxg90o6vpkjbGpkvjWSiHWgZ/W5rTooolnlApR6A8i8yALM95gylQCoGb/aFdXHuAHt9KuQuAa+weo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985808; c=relaxed/simple;
	bh=s02EU2GNXiVHdlRJ+jyRr/Y7YLTUSaDRYXZzcj7qkc8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GWs9+c9WCWl08Q+SDInMc0xK/GyEhspGdZ48SN13crqSaalMMzq3MYyxTeiIdkiewfEWnf47ScYZKk5xmstNVBAilRhVBg9Q5F40FWTwKjwDoqaRS+OV2h5Wg7MC38Wp4ViezPjo9TKAsd+efOmw8nsRzDJHEBTbuSWDQt/mVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFG7AQ9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFG7AQ9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDAD1F000FF;
	Wed,  9 Sep 2026 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985796;
	bh=QuZM46OhKdDN97PeCm8YPFKOdhxXnQF0sSeKdtxBTGw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VFG7AQ9y4RUvvHULJsxIXmxp0/vBHuDaRJj4luwBOo//gLicsiaDr6JIUnGH7G539
	 g1dj3ADSA1vk/xAWo2QiJmmn/Xs9hiHvO5kMqaMqXDTFho/8j62GCWWBUSZe0CrgDD
	 UKMp9cV6i+QzNW6kvuit3Votz07QFMRQQ4MSZ5C5n7ovVEryHg5vinkSWaOY1MB+V6
	 0SD7ks1h24/S2LSkGplcS6RUlcWgrNH8Fou6pc3Gs7dPyXAvwffdxxE4/GWv0K/mM9
	 e+xkTfe5qIU757TCaYS9ApA1maIVuTW6PmAucUnW9lhESf8Iv8LYux4cmczSx84Zxg
	 kyGIoIpKANuwg==
Content-Type: multipart/mixed; boundary="===============2822446474814226014=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c28736e3864daa3aca308ac20ca4ddf11da29c951013e0daf7a7a9d2c2c780b@mail.kernel.org>
In-Reply-To: <20260909193719.518517-12-utilityemal77@gmail.com>
References: <20260909193719.518517-12-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] landlock: Factor the credential restriction out of landlock_restrict_self()
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:29:55 +0000 (UTC)

--===============2822446474814226014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> index 03449c26247e..f02706f12c7d 100644
> --- a/security/landlock/cred.c
> +++ b/security/landlock/cred.c
> @@ -8,14 +8,146 @@
>   */
>
>  #include <linux/binfmts.h>
> +#include <linux/bits.h>
>  #include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>

This isn't a bug, but is <linux/errno.h> needed here?  The new code
returns PTR_ERR(new_dom) (from <linux/err.h>) and never names an -Exxx
constant.

> +#include <linux/lsm_hooks.h>
> +#include <linux/mutex.h>
> +#include <uapi/linux/landlock.h>
>
>  #include "common.h"
>  #include "cred.h"
> +#include "domain.h"
>  #include "ruleset.h"
>  #include "setup.h"
>
> +#include <trace/events/landlock.h>
> +
> +/**
> + * landlock_prepare_restriction - Compute a credential restriction
> + *
> + * @llcred: Landlock credentials to restrict: provides the parent domain and
> + *          the previous log configuration.  Not modified.
> + * @ruleset: Ruleset to enforce, or NULL for a log-configuration-only change.
> + * @flags: landlock_restrict_self(2) flags.  The caller is responsible for
> + *         validating them against the set of flags it supports.
> + * @restriction: Computed restriction.  On success, holds a reference on
> + *               @restriction->domain (if any), which
> + *               landlock_apply_restriction() transfers to the restricted
> + *               credentials.
> + *
> + * The restriction builds on @llcred's current state: the caller must apply
> + * it to (or stage it for) these same credentials.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int landlock_prepare_restriction(
> +	const struct landlock_cred_security *const llcred,
> +	struct landlock_ruleset *const ruleset, const u32 flags,
> +	struct landlock_restriction *const restriction)
> +{

[ ... ]

> +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
> +	new_dom->hierarchy->log_same_exec = log_same_exec;
> +	new_dom->hierarchy->log_new_exec = log_new_exec;
> +	/*
> +	 * The creation event fired above, so move the domain out of
> +	 * LANDLOCK_LOG_UNCOMMITTED: its free_domain event must fire
> +	 * too, even if the domain is dropped before being enforced.
> +	 * Audit logging may still be disabled (DISABLED); tracing
> +	 * observes it anyway.
> +	 */
> +	if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
> +		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
> +	else
> +		new_dom->hierarchy->log_status = LANDLOCK_LOG_PENDING;
> +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */

The LANDLOCK_LOG_UNCOMMITTED -> PENDING/DISABLED transition moves from
sys_landlock_restrict_self() into landlock_prepare_restriction(), but
comments that document this contract by naming the old site remain
unrevisioned, and no later commit in the 02756181d382..1cc3305917e4
range updates them either.

In security/landlock/domain.c (landlock_init_hierarchy_log):

     /*
      * The hierarchy is born unobservable: landlock_restrict_self() moves it
      * out of LANDLOCK_LOG_UNCOMMITTED once it has emitted the creation
      * event, so the matching free_domain event fires for it and not for a
      * hierarchy whose creation was never observed.
      */

In security/landlock/trace.c (landlock_trace_free_domain):

      * Fires only for a hierarchy whose creation event was emitted, i.e. one that
      * left LANDLOCK_LOG_UNCOMMITTED in landlock_restrict_self().  ...
      * while a domain that landlock_restrict_self() created and a
      * thread-sync failure then aborted still fires free_domain, ...

In include/trace/events/landlock.h (Lifecycle consistency block):

The window is still described as 'A rare thread-sync failure aborts the
just-created domain' even though the new helper's documentation
(cred.c:89-93) states it also covers an aborted execution, introduced
two commits later in 0a88c757f4f0.

After this commit, landlock_prepare_restriction() performs the
transition, and 0a88c757f4f0 adds a second, non-syscall caller
(bprm_apply_policy_object()), so 'landlock_restrict_self()' no longer
enforces this invariant nor provides the only path that can create and
drop a domain.

Behaviour is unaffected, but should these references be updated to
reflect the new code structure?

> +
> +	restriction->domain = new_dom;
> +	return 0;
> +}

[ ... ]

> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index cb294a3582ae..9451376ccf50 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -9,7 +9,6 @@
>
>  #include <asm/current.h>
>  #include <linux/anon_inodes.h>
> -#include <linux/bitops.h>
>  #include <linux/build_bug.h>
>  #include <linux/capability.h>
>  #include <linux/cleanup.h>

[ ... ]

> @@ -546,10 +544,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
>  	struct landlock_domain *new_dom = NULL;
>  	struct cred *new_cred;

This isn't a bug, but is the `= NULL` initializer still needed here?
Before the refactor, new_dom was only assigned inside the if (ruleset)
block, so the initializer was load-bearing for the later if (ruleset)
trace_landlock_enforce_domain(new_dom, ...) call. After the split,
new_dom is assigned unconditionally from restriction.domain, and every
path between the declaration and that assignment is a plain return.  It
is the only `= NULL` pointer initializer left in the file apart from the
__free() declaration on the line above.

> -	struct landlock_cred_security *new_llcred;
> +	struct landlock_restriction restriction;
>  	bool process_wide;
> -	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
> -		prev_log_subdomains;
> +	int err;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============2822446474814226014==--
