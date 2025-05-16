Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B218E025;
	Fri, 16 May 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432170; cv=none; b=jGPMtuoBNrsYxHSxrMrB7nSCnNw9Bh2/8bt/3IMDACi9NP8KMTP3lPJnkfHSV11zKyvMVY/GMMYKSuLSp/gM46HxvNw6ohNU33szzwbwlY6nBO+kU6NL9B3ut4sEAxfK4Bup8fmAv5dUapJeZYGMp2eAKz5KzKroSx7vXwwgXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432170; c=relaxed/simple;
	bh=jhbAWQb7CHbUt7D8a76DsLUOc5gFp5oIGR2+cMUV4nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzF8y29c6TbhLCtOCgkFxKFSTuD65sXSGJ8D0yeiin//zaswft/+B/T3XOxT9FujdET+pwiYdQt/pYG1Y2mk4syMbrSX6VyCNswGi82eblYtG3byK1ajrqgnK4JTaFexO3VfqBo7ypcNO9W2fmN5uu8fblpImKsmbeZm5ZBQc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3lgSdZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3lgSdZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97500C4CEE4;
	Fri, 16 May 2025 21:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747432168;
	bh=jhbAWQb7CHbUt7D8a76DsLUOc5gFp5oIGR2+cMUV4nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3lgSdZNNLXomR2ixJ5Vh2ARWD+Cx4hdYYq6ARC3MI7dM8fyLkFm4YQBa4QQ43ynL
	 GRK6cZOivxdQKrj/fH9kFCY/8t2bGdin/Tx1Lwkoks50Y2CtiyZCc3OtkPL0cMgpog
	 AiblQuqkvGzgHoEu23md37J4uT1n/P3g0FxL1wv1HV1NdHbN7NSSjR99iLV3u7HA8+
	 luSE/wJM4FcBWE5t4YBSAvyPWmiJHvgsWbyo1JsWta3ITXpsoJ1zcrSl4MjR0zjctC
	 67utdWfEPN4QbdGCGjz4BRNQKi9I7VA0VcQl6Jxi4yXZNcgIjSJzFZTAApQvNRci7n
	 6Pck/9PAZmr4Q==
Date: Fri, 16 May 2025 21:49:23 +0000
From: sergeh@kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>,
	morgan@kernel.org, Christian Brauner <christian@brauner.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
Message-ID: <aCey42ACEr4h3fmH@lei>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qmxsuy8.fsf@email.froward.int.ebiederm.org>

On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> 
> Max Kellerman recently experienced a problem[1] when calling exec with
> differing uid and euid's and he triggered the logic that is supposed
> to only handle setuid executables.
> 
> When exec isn't changing anything in struct cred it doesn't make sense
> to go into the code that is there to handle the case when the
> credentials change.
> 
> When looking into the history of the code I discovered that this issue
> was not present in Linux-2.4.0-test12 and was introduced in
> Linux-2.4.0-prerelease when the logic for handling this case was moved
> from prepare_binprm to compute_creds in fs/exec.c.
> 
> The bug introduced was to comparing euid in the new credentials with
> uid instead of euid in the old credentials, when testing if setuid
> had changed the euid.
> 
> Since triggering the keep ptrace limping along case for setuid
> executables makes no sense when it was not a setuid exec revert back
> to the logic present in Linux-2.4.0-test12.
> 
> This removes the confusingly named and subtlety incorrect helpers
> is_setuid and is_setgid, that helped this bug to persist.
> 
> The variable is_setid is renamed to id_changed (it's Linux-2.4.0-test12
> name) as the old name describes matters rather than it's cause.
> 
> The code removed in Linux-2.4.0-prerelease was:
> -       /* Set-uid? */
> -       if (mode & S_ISUID) {
> -               bprm->e_uid = inode->i_uid;
> -               if (bprm->e_uid != current->euid)
> -                       id_change = 1;
> -       }
> -
> -       /* Set-gid? */
> -       /*
> -        * If setgid is set but no group execute bit then this
> -        * is a candidate for mandatory locking, not a setgid
> -        * executable.
> -        */
> -       if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> -               bprm->e_gid = inode->i_gid;
> -               if (!in_group_p(bprm->e_gid))
> -                       id_change = 1;
> 
> Linux-2.4.0-prerelease added the current logic as:
> +       if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
> +           !cap_issubset(new_permitted, current->cap_permitted)) {
> +                current->dumpable = 0;
> +
> +               lock_kernel();
> +               if (must_not_trace_exec(current)
> +                   || atomic_read(&current->fs->count) > 1
> +                   || atomic_read(&current->files->count) > 1
> +                   || atomic_read(&current->sig->count) > 1) {
> +                       if(!capable(CAP_SETUID)) {
> +                               bprm->e_uid = current->uid;
> +                               bprm->e_gid = current->gid;
> +                       }
> +                       if(!capable(CAP_SETPCAP)) {
> +                               new_permitted = cap_intersect(new_permitted,
> +                                                       current->cap_permitted);
> +                       }
> +               }
> +               do_unlock = 1;
> +       }
> 
> I have condensed the logic from Linux-2.4.0-test12 to just:
> 	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> 
> 
> This change is userspace visible, but I don't expect anyone to care.
> 
> For the bug that is being fixed to trigger bprm->unsafe has to be set.
> The variable bprm->unsafe is set when ptracing an executable, when
> sharing a working directory, or when no_new_privs is set.  Properly
> testing for cases that are safe even in those conditions and doing
> nothing special should not affect anyone.  Especially if they were
> previously ok with their credentials getting munged
> 
> Reported-by: Max Kellermann <max.kellermann@ionos.com>
> Fixes: 64444d3d0d7f ("Linux version 2.4.0-prerelease")
> [1] https://lkml.kernel.org/r/20250306082615.174777-1-max.kellermann@ionos.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks, Eric.

Obviously we should continue to discuss Jann's concern and the
potential change in behavior, but I'm hugely in favor of this patch.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 28d4248bf001..96c7654f2012 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -856,12 +856,6 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>  #define __cap_full(field, cred) \
>  	cap_issubset(CAP_FULL_SET, cred->cap_##field)
>  
> -static inline bool __is_setuid(struct cred *new, const struct cred *old)
> -{ return !uid_eq(new->euid, old->uid); }
> -
> -static inline bool __is_setgid(struct cred *new, const struct cred *old)
> -{ return !gid_eq(new->egid, old->gid); }
> -
>  /*
>   * 1) Audit candidate if current->cap_effective is set
>   *
> @@ -891,7 +885,7 @@ static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
>  	    (root_privileged() &&
>  	     __is_suid(root, new) &&
>  	     !__cap_full(effective, new)) ||
> -	    (!__is_setuid(new, old) &&
> +	    (uid_eq(new->euid, old->euid) &&
>  	     ((has_fcap &&
>  	       __cap_gained(permitted, new, old)) ||
>  	      __cap_gained(ambient, new, old))))
> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
>  	/* Process setpcap binaries and capabilities for uid 0 */
>  	const struct cred *old = current_cred();
>  	struct cred *new = bprm->cred;
> -	bool effective = false, has_fcap = false, is_setid;
> +	bool effective = false, has_fcap = false, id_changed;
>  	int ret;
>  	kuid_t root_uid;
>  
> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
>  	 *
>  	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>  	 */
> -	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> +	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
>  
> -	if ((is_setid || __cap_gained(permitted, new, old)) &&
> +	if ((id_changed || __cap_gained(permitted, new, old)) &&
>  	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>  	     !ptracer_capable(current, new->user_ns))) {
>  		/* downgrade; they get no more than they had, and maybe less */
> @@ -960,7 +954,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
>  	new->sgid = new->fsgid = new->egid;
>  
>  	/* File caps or setid cancels ambient. */
> -	if (has_fcap || is_setid)
> +	if (has_fcap || id_changed)
>  		cap_clear(new->cap_ambient);
>  
>  	/*
> @@ -993,7 +987,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
>  		return -EPERM;
>  
>  	/* Check for privilege-elevated exec. */
> -	if (is_setid ||
> +	if (id_changed ||
>  	    (!__is_real(root_uid, new) &&
>  	     (effective ||
>  	      __cap_grew(permitted, ambient, new))))
> -- 
> 2.41.0
> 
