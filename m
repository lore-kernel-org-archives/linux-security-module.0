Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663B43302C
	for <linux-security-module@vger.kernel.org>; Fri,  7 Aug 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108703; cv=none; b=u3ZWLd1SNa8k8dyLagR+OHy2N8MSFeJNBfY3KXqWn9LfaQnVLXb5JFPHPssoNvKyuOGYQcZc4f+S/GIwC/lU5h8ySWsN2xikaEPJH/RSdmbVCFdXtMTTDMVPyBJgYoAaj93YpQcs5j9Ril3FLNsFnO9pwhhkc9CkeSPS78MIiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108703; c=relaxed/simple;
	bh=VfyVeRVuij5uUxGQbDSxByOTS5o97Er3vtE0JFxAc90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY7tNPMpTabGcNMkWi6qMgsLrci6AQiip9C1j+AgJ29knOoZn4ePNeo+YEOtsWjthqTja1CICaN3dV3+qhW3HYhilwdeok9dZ4R19QOldEYLtu26IX0XOVOAtu6r4qid+6PyTdbTioEiKEkNRoQWy+yAmNlTgk2go8hkFny5QCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=w4aevUO4; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="w4aevUO4"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGl845zxdzq9H;
	Fri,  7 Aug 2026 15:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786108692;
	bh=SjXoCDEEFVr8By2Qwuiaz6aHOf6xd3iMswYQfqGuk68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w4aevUO4YqKmt/4UjBxMs0qfnLysmyh128Vo429m+BodOuBHO7yq7pj8ZIjPUFIKC
	 mjxTGVpLzUCNZ6i6qxoONJJJdQ5O+jP1QTLcultHkbmBXtygQmkwvSFlvT4k9SIY9W
	 6Qyqm6YcUkpz6ZVead2C4LnFYmDo5P85sypmwmr4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGl841204zW8m;
	Fri,  7 Aug 2026 15:18:12 +0200 (CEST)
Date: Fri, 7 Aug 2026 15:18:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/4] landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260807.ohpairoh1Aeb@digikod.net>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
 <20260803223109.707353-2-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803223109.707353-2-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 03, 2026 at 06:31:05PM -0400, Justin Suess wrote:
> Add a landlock_restrict_self(2) flag to set the no_new_privs attribute
> of the calling thread only after enforcement of the ruleset:
> no_new_privs is set if and only if the call succeeds.  This removes the
> need for a prior prctl(2) PR_SET_NO_NEW_PRIVS call and guarantees that
> a failed enforcement leaves the attribute unchanged.
> 
> Because no_new_privs is set by the call itself, the no_new_privs /
> CAP_SYS_ADMIN requirement of landlock_restrict_self(2) is fulfilled by
> construction, and the related EPERM check is skipped.  As a consequence,
> an unprivileged caller passing unknown flags along with this flag gets
> EINVAL instead of EPERM.
> 
> Unlike LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, this flag always
> requires a valid ruleset: with a ruleset_fd of -1, such a call would be
> nothing more than a Landlock-flavored prctl(2) PR_SET_NO_NEW_PRIVS, and
> there is no valid use case for setting no_new_privs (possibly with
> LANDLOCK_RESTRICT_SELF_TSYNC) without also enforcing Landlock
> restrictions.  Rejecting these calls also keeps the option of giving
> them a meaning later.
> 
> The attribute is only set past the last point of failure, just before
> committing the new credentials.  When combined with
> LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the sibling threads
> as well, in their commit phase, with the same ordering.
> 
> Bump the Landlock ABI version to 11.
> 
> Cc: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Notes:
>     v2->v3:
>     - Reword "atomically" to the ordering guarantee (no_new_privs is only set
>       once enforcement succeeded) in the commit message and both kdocs
>     - Explain in the commit message why the flag requires a valid ruleset
> 
>  include/uapi/linux/landlock.h | 13 +++++++++++++
>  security/landlock/limits.h    |  2 +-
>  security/landlock/syscalls.c  | 28 +++++++++++++++++++++-------
>  security/landlock/tsync.c     |  8 ++++++--
>  security/landlock/tsync.h     |  4 +++-
>  5 files changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 27ae3f39cafb..11bf600698f0 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -191,12 +191,25 @@ struct landlock_ruleset_attr {
>   *
>   *     If the calling thread is running with no_new_privs, this operation
>   *     enables no_new_privs on the sibling threads as well.
> + *
> + * The following flag ties the no_new_privs attribute to the ruleset
> + * enforcement:
> + *
> + * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> + *     Sets the no_new_privs attribute of the calling thread only once the
> + *     enforcement of the ruleset succeeded: no_new_privs is set if and only
> + *     if sys_landlock_restrict_self() succeeds.  This removes the need for a
> + *     prior :manpage:`prctl(2)` ``PR_SET_NO_NEW_PRIVS`` call, and with it the
> + *     %CAP_SYS_ADMIN requirement.  This flag requires a ruleset.  When
> + *     combined with %LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the
> + *     sibling threads as well.
>   */
>  /* clang-format off */
>  #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
>  #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
>  #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
>  #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
> +#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 08d5f2f6d321..1a7c5fb8f6fd 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -34,7 +34,7 @@
>  #define LANDLOCK_NUM_ACCESS_MAX \
>  	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
>  
> -#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
> +#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>  #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
>  
>  /* clang-format on */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 36b02892c62f..e97f944109f9 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
>   * If the change involves a fix that requires userspace awareness, also update
>   * the errata documentation in Documentation/userspace-api/landlock.rst .
>   */
> -const int landlock_abi_version = 10;
> +const int landlock_abi_version = 11;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -502,21 +502,28 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>   *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
>   *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
>   *         - %LANDLOCK_RESTRICT_SELF_TSYNC
> + *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>   *
>   * This system call enforces a Landlock ruleset on the current thread.
>   * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
>   * namespace or is running with no_new_privs.  This avoids scenarios where
>   * unprivileged tasks can affect the behavior of privileged children.
>   *
> + * With %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, the no_new_privs attribute of the
> + * calling thread is set only once the enforcement of the ruleset succeeded,
> + * which fulfills the above requirement: no_new_privs is set if and only if the
> + * call succeeds.
> + *
>   * Return: 0 on success, or -errno on failure.  Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>   * - %EINVAL: @flags contains an unknown bit.
>   * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
>   * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
> - * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
> - *   current thread is not running with no_new_privs, or it doesn't have
> - *   %CAP_SYS_ADMIN in its namespace.
> + * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or
> + *   %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is not set while the current thread
> + *   is not running with no_new_privs and doesn't have %CAP_SYS_ADMIN in its
> + *   namespace.
>   * - %E2BIG: The maximum number of stacked rulesets is reached for the current
>   *   thread.
>   *
> @@ -529,6 +536,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
>  	struct cred *new_cred;
>  	struct landlock_cred_security *new_llcred;
> +	const bool set_no_new_privs =
> +		!!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);

This variable should be set later (or not exist at all), see my next
comment.

>  	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
>  		prev_log_subdomains;
>  
> @@ -537,9 +546,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  
>  	/*
>  	 * Similar checks as for seccomp(2), except that an -EPERM may be
> -	 * returned.
> +	 * returned.  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills this
> +	 * requirement.
>  	 */
> -	if (!task_no_new_privs(current) &&
> +	if (!set_no_new_privs && !task_no_new_privs(current) &&

This is correct according to the current code, but kind of inconsistent
wrt previous kernels (e.g. an unprivileged caller *without* NNP already
set would get EPERM if it sets LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
whereas it will now get EINVAL).  In fact, a dedicated patch should move
the NNP/CAP checks just after the flags check.  This is a visible change
but I think it would be cleaner this way.  BTW, seccomp check flags in
the same order.


>  	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> @@ -620,12 +630,16 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  
>  	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
>  		const int err = landlock_restrict_sibling_threads(
> -			current_cred(), new_cred);
> +			current_cred(), new_cred, flags);
>  		if (err) {
>  			abort_creds(new_cred);
>  			return err;
>  		}
>  	}
>  
> +	/* Sets no_new_privs past the last point of failure. */
> +	if (set_no_new_privs)
> +		task_set_no_new_privs(current);
> +
>  	return commit_creds(new_cred);
>  }
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index c5730bbd9ed3..0b71e158c3f5 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/slab.h>
>  #include <linux/task_work.h>
> +#include <uapi/linux/landlock.h>
>  
>  #include "cred.h"
>  #include "tsync.h"
> @@ -466,7 +467,8 @@ static void cancel_tsync_works(const struct tsync_works *works,
>   * restrict_sibling_threads - enables a Landlock policy for all sibling threads
>   */
>  int landlock_restrict_sibling_threads(const struct cred *old_cred,
> -				      const struct cred *new_cred)
> +				      const struct cred *new_cred,
> +				      const u32 restrict_flags)
>  {
>  	int err;
>  	struct tsync_shared_context shared_ctx;
> @@ -481,7 +483,9 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	init_completion(&shared_ctx.all_finished);
>  	shared_ctx.old_cred = old_cred;
>  	shared_ctx.new_cred = new_cred;
> -	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> +	shared_ctx.set_no_new_privs =
> +		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
> +		task_no_new_privs(current);
>  
>  	/*
>  	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> diff --git a/security/landlock/tsync.h b/security/landlock/tsync.h
> index ef86bb61c2f6..2ae4f938ca00 100644
> --- a/security/landlock/tsync.h
> +++ b/security/landlock/tsync.h
> @@ -9,8 +9,10 @@
>  #define _SECURITY_LANDLOCK_TSYNC_H
>  
>  #include <linux/cred.h>
> +#include <linux/types.h>
>  
>  int landlock_restrict_sibling_threads(const struct cred *old_cred,
> -				      const struct cred *new_cred);
> +				      const struct cred *new_cred,
> +				      u32 restrict_flags);
>  
>  #endif /* _SECURITY_LANDLOCK_TSYNC_H */
> -- 
> 2.54.0
> 
> 
