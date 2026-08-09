Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02623D283
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289466; cv=none; b=SFmXsNZT5VGmj3oRn2KvM2Z4q4xhT9aBm/tPShqrqB15U1ACsgJRKUtNeXEuS5wZ87TMi3EZ+Q4SLH4bW6gdCD6+XkbeXSPUiRk7dv3P/JWPpta/pIee2qu3j68rPO0dfZ5cPTwBWXb//24Dhsv0CsVbURyDTX8/4icnVLugXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289466; c=relaxed/simple;
	bh=NQcHmxS7xIhHQqpuGnVCLGIb3iN5fdbo1setGuIKFXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaROzA6xgD0JO74/AufD0z5vQUXrul+apWrBqAiiEElAlwDdFQmJVTRpgh7cWqaHtAW3eFDy1CM14NAep4eJfQd1kII30VVuH5vnQ2o8SjxPcf81h8KZv0yQGm/tLJ5yKRiiNyHYg7tOU9koLaqK38A+06KrVyn9teqT9FuhNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdiald5M; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdiald5M"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-668005ba03cso1471091d50.2
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786289464; x=1786894264; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EDBxFhFQtmof6FI6BU85IgML2H9vCi7bM1/04FLnmKo=;
        b=gdiald5MNudCqN6kWG1VX0phZLeeg7Wc0rP0E5x1BNCXd0RM4Gc9exNFi4EKlUpc5H
         IC63cl6Gf4/qmj/MSFMvv+PZJ2aUCaD80NWqkDFDj6/PUvl3iYC32BJfIMR30xlwdkDA
         YivUFyIFuhmkPopYvk0wAx2Otib2E9m/afwigji9nhGV3zoTXGnjMzkhBjazoO1WMv2g
         IHIPYa7HdLfNBlzHOVzlRC+FV5OGJyrSX5lY3JOMBR+ZlKIXJDfyBF/2fUKOKWCHgCnQ
         mIee5BIg70SCp6+FioSKHBSAdgBnnFoTTmVwVjKks6xgA0WXH+/8DCpqdosPpIO+FL1x
         Nf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786289464; x=1786894264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EDBxFhFQtmof6FI6BU85IgML2H9vCi7bM1/04FLnmKo=;
        b=dcfHfJbljJ6Wp9tBzuCaNJhMxQJ086DXUOcHq5WJcwAf4pbKoxl9aF9q5i99pQqKK6
         933IBrJJoJOPxijPWP2tWA4fUxFJgbMCgZE6nFtMOMdF2peLNhVXzuuQHHiF/NUauRd+
         wMAW0eoF1MhaU/k250W/WSbXY/mwPha+6LWOw89boZa/0KQoXmTklnpgDqBRtIOLNVLg
         HX0dWA0REqecjhTslPCLKEMtVe59ut25YZ7Y652X6dBg7r0sQuMCa+YfyHdIJEbPhrBI
         49RjmIQbLOVpO3o+bSHt2IF3oUrFWzRsgGnlgicwRZq5+QMMbmKZt7swT4i423DtNniz
         txnw==
X-Forwarded-Encrypted: i=1; AHgh+RrXtgOS1T/M/57jrqx8zwK9y+Kp1udf7g9UnEYrDPXGi+Y0JrOY5Tfse/xainqFizcZF11ssmGfZQyMZ4qm+gvOxcXUp3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuC0uIIVbgaMlO1pwCDcZazn9VZ9K7pei60B2I7P/cZihxJ3J/
	sJB/VPSgwryYnynx+piNu+4+lYjp5VKzydwELk2f7MmwhfwhogQzpu9p
X-Gm-Gg: AR+sD117esTQGbMrzlKAuCXSI5LDaF6R4v10XpElYzonC05jD+V9P8EYN8F+aAf+hsa
	MPePluHwROHGCP7LZiMfGhywAmjSbtTTXsb5MPoZCNPd4Qb/im2oPjA/KXhYBdkcOpHN4Xa23Ao
	yVvDUERZye7Yq5XALJbaG95oyg3lDbAVRwO2K1XCyfSAy8UXgyidlshX9xfncjl1HiQlY63KZU5
	4ivAV+LpJL1DqiZ6F4OZsqMZs8lZDWdX20Mfqgm0oObkjL9dfAzG7P5VnThUlvxTac1JkoSMo6d
	88x0NEavc7he5dkqbcpx4i9EpK2OICd0GLhT6TdyJLOdAZ7Fbo1ib5r4HpAlYdXnGxJX7Rgl+fd
	Y1uLvWw+6uIIBrCrNqc26e/Uj7jD6ooHJJisehqHv0a54MToWrEFVASihJHA2y1FELsk4j1F3Jj
	Qp+WJ+WtmhJMSu2ni8c/ddrz18ki1PW/9ahiQkz/Z/PTMrQVVKx7Drn/18ONDrmxP1QN3zs/NNc
	yy0K3WnjJtC9yEnr0ZyV1lF4AcLSbuCHPeKaPnVjhG5VQ==
X-Received: by 2002:a53:bb90:0:b0:668:9ea4:774b with SMTP id 956f58d0204a3-6699ad1157bmr14988282d50.41.1786289462954;
        Sun, 09 Aug 2026 08:31:02 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdfdsm4753175d50.2.2026.08.09.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:31:02 -0700 (PDT)
Date: Sun, 9 Aug 2026 11:31:01 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/4] landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <anicFygFIdlz1r_U@zenbox>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
 <20260803223109.707353-2-utilityemal77@gmail.com>
 <20260807.ohpairoh1Aeb@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807.ohpairoh1Aeb@digikod.net>

On Fri, Aug 07, 2026 at 03:18:07PM +0200, Mickaël Salaün wrote:
> On Mon, Aug 03, 2026 at 06:31:05PM -0400, Justin Suess wrote:
> > Add a landlock_restrict_self(2) flag to set the no_new_privs attribute
> > of the calling thread only after enforcement of the ruleset:
> > no_new_privs is set if and only if the call succeeds.  This removes the
> > need for a prior prctl(2) PR_SET_NO_NEW_PRIVS call and guarantees that
> > a failed enforcement leaves the attribute unchanged.
> > 
> > Because no_new_privs is set by the call itself, the no_new_privs /
> > CAP_SYS_ADMIN requirement of landlock_restrict_self(2) is fulfilled by
> > construction, and the related EPERM check is skipped.  As a consequence,
> > an unprivileged caller passing unknown flags along with this flag gets
> > EINVAL instead of EPERM.
> > 
> > Unlike LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, this flag always
> > requires a valid ruleset: with a ruleset_fd of -1, such a call would be
> > nothing more than a Landlock-flavored prctl(2) PR_SET_NO_NEW_PRIVS, and
> > there is no valid use case for setting no_new_privs (possibly with
> > LANDLOCK_RESTRICT_SELF_TSYNC) without also enforcing Landlock
> > restrictions.  Rejecting these calls also keeps the option of giving
> > them a meaning later.
> > 
> > The attribute is only set past the last point of failure, just before
> > committing the new credentials.  When combined with
> > LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the sibling threads
> > as well, in their commit phase, with the same ordering.
> > 
> > Bump the Landlock ABI version to 11.
> > 
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> > 
> > Notes:
> >     v2->v3:
> >     - Reword "atomically" to the ordering guarantee (no_new_privs is only set
> >       once enforcement succeeded) in the commit message and both kdocs
> >     - Explain in the commit message why the flag requires a valid ruleset
> > 
> >  include/uapi/linux/landlock.h | 13 +++++++++++++
> >  security/landlock/limits.h    |  2 +-
> >  security/landlock/syscalls.c  | 28 +++++++++++++++++++++-------
> >  security/landlock/tsync.c     |  8 ++++++--
> >  security/landlock/tsync.h     |  4 +++-
> >  5 files changed, 44 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 27ae3f39cafb..11bf600698f0 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -191,12 +191,25 @@ struct landlock_ruleset_attr {
> >   *
> >   *     If the calling thread is running with no_new_privs, this operation
> >   *     enables no_new_privs on the sibling threads as well.
> > + *
> > + * The following flag ties the no_new_privs attribute to the ruleset
> > + * enforcement:
> > + *
> > + * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> > + *     Sets the no_new_privs attribute of the calling thread only once the
> > + *     enforcement of the ruleset succeeded: no_new_privs is set if and only
> > + *     if sys_landlock_restrict_self() succeeds.  This removes the need for a
> > + *     prior :manpage:`prctl(2)` ``PR_SET_NO_NEW_PRIVS`` call, and with it the
> > + *     %CAP_SYS_ADMIN requirement.  This flag requires a ruleset.  When
> > + *     combined with %LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the
> > + *     sibling threads as well.
> >   */
> >  /* clang-format off */
> >  #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
> >  #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
> >  #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
> >  #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
> > +#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
> >  /* clang-format on */
> >  
> >  /**
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index 08d5f2f6d321..1a7c5fb8f6fd 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -34,7 +34,7 @@
> >  #define LANDLOCK_NUM_ACCESS_MAX \
> >  	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
> >  
> > -#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
> > +#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> >  #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
> >  
> >  /* clang-format on */
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 36b02892c62f..e97f944109f9 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
> >   * If the change involves a fix that requires userspace awareness, also update
> >   * the errata documentation in Documentation/userspace-api/landlock.rst .
> >   */
> > -const int landlock_abi_version = 10;
> > +const int landlock_abi_version = 11;
> >  
> >  /**
> >   * sys_landlock_create_ruleset - Create a new ruleset
> > @@ -502,21 +502,28 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
> >   *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
> >   *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
> >   *         - %LANDLOCK_RESTRICT_SELF_TSYNC
> > + *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> >   *
> >   * This system call enforces a Landlock ruleset on the current thread.
> >   * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
> >   * namespace or is running with no_new_privs.  This avoids scenarios where
> >   * unprivileged tasks can affect the behavior of privileged children.
> >   *
> > + * With %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, the no_new_privs attribute of the
> > + * calling thread is set only once the enforcement of the ruleset succeeded,
> > + * which fulfills the above requirement: no_new_privs is set if and only if the
> > + * call succeeds.
> > + *
> >   * Return: 0 on success, or -errno on failure.  Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> >   * - %EINVAL: @flags contains an unknown bit.
> >   * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
> >   * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
> > - * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
> > - *   current thread is not running with no_new_privs, or it doesn't have
> > - *   %CAP_SYS_ADMIN in its namespace.
> > + * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or
> > + *   %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is not set while the current thread
> > + *   is not running with no_new_privs and doesn't have %CAP_SYS_ADMIN in its
> > + *   namespace.
> >   * - %E2BIG: The maximum number of stacked rulesets is reached for the current
> >   *   thread.
> >   *
> > @@ -529,6 +536,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
> >  	struct cred *new_cred;
> >  	struct landlock_cred_security *new_llcred;
> > +	const bool set_no_new_privs =
> > +		!!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
> 
> This variable should be set later (or not exist at all), see my next
> comment.
> 
> >  	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
> >  		prev_log_subdomains;
> >  
> > @@ -537,9 +546,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  
> >  	/*
> >  	 * Similar checks as for seccomp(2), except that an -EPERM may be
> > -	 * returned.
> > +	 * returned.  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills this
> > +	 * requirement.
> >  	 */
> > -	if (!task_no_new_privs(current) &&
> > +	if (!set_no_new_privs && !task_no_new_privs(current) &&
> 
> This is correct according to the current code, but kind of inconsistent
> wrt previous kernels (e.g. an unprivileged caller *without* NNP already
> set would get EPERM if it sets LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
> whereas it will now get EINVAL).  In fact, a dedicated patch should move
> the NNP/CAP checks just after the flags check.  This is a visible change
> but I think it would be cleaner this way.  BTW, seccomp check flags in
> the same order.
>

If I understand you correctly:

This technically is an ABI change to existing behavior, but it's pretty
niche (for callers passing unknown flags w/o CAP_SYS_ADMIN ||
no_new_privs).

I'll add the tests in that commit as well to make it bisectable.
> 
> >  	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> >  		return -EPERM;
> >  
> > @@ -620,12 +630,16 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  
> >  	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
> >  		const int err = landlock_restrict_sibling_threads(
> > -			current_cred(), new_cred);
> > +			current_cred(), new_cred, flags);
> >  		if (err) {
> >  			abort_creds(new_cred);
> >  			return err;
> >  		}
> >  	}
> >  
> > +	/* Sets no_new_privs past the last point of failure. */
> > +	if (set_no_new_privs)
> > +		task_set_no_new_privs(current);
> > +
> >  	return commit_creds(new_cred);
> >  }
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index c5730bbd9ed3..0b71e158c3f5 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/slab.h>
> >  #include <linux/task_work.h>
> > +#include <uapi/linux/landlock.h>
> >  
> >  #include "cred.h"
> >  #include "tsync.h"
> > @@ -466,7 +467,8 @@ static void cancel_tsync_works(const struct tsync_works *works,
> >   * restrict_sibling_threads - enables a Landlock policy for all sibling threads
> >   */
> >  int landlock_restrict_sibling_threads(const struct cred *old_cred,
> > -				      const struct cred *new_cred)
> > +				      const struct cred *new_cred,
> > +				      const u32 restrict_flags)
> >  {
> >  	int err;
> >  	struct tsync_shared_context shared_ctx;
> > @@ -481,7 +483,9 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	init_completion(&shared_ctx.all_finished);
> >  	shared_ctx.old_cred = old_cred;
> >  	shared_ctx.new_cred = new_cred;
> > -	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> > +	shared_ctx.set_no_new_privs =
> > +		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
> > +		task_no_new_privs(current);
> >  
> >  	/*
> >  	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> > diff --git a/security/landlock/tsync.h b/security/landlock/tsync.h
> > index ef86bb61c2f6..2ae4f938ca00 100644
> > --- a/security/landlock/tsync.h
> > +++ b/security/landlock/tsync.h
> > @@ -9,8 +9,10 @@
> >  #define _SECURITY_LANDLOCK_TSYNC_H
> >  
> >  #include <linux/cred.h>
> > +#include <linux/types.h>
> >  
> >  int landlock_restrict_sibling_threads(const struct cred *old_cred,
> > -				      const struct cred *new_cred);
> > +				      const struct cred *new_cred,
> > +				      u32 restrict_flags);
> >  
> >  #endif /* _SECURITY_LANDLOCK_TSYNC_H */
> > -- 
> > 2.54.0
> > 
> > 
