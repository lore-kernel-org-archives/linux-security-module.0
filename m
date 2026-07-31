Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E535C68A
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533341; cv=none; b=rgcB9YobssxydaZx6+8TdYE8CiogM/VUhRTsEOHOtn4snHLcn0dLy4cL9pcdOXIhvy8GwzZVs7rug246H/OQaUgH6qL9JjxRH0rXElqPVfJUjqpfaNYiD56dssUBlVugUuVLYCE7Uai2bVtT2GpAAxH/5icdmJF6GjiPyQZV7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533341; c=relaxed/simple;
	bh=lk9mcOzhOvLveT64rfTMeFBHWLi4O33r5eL7IJNKsOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF/eRURVrm3lRWVqW6O5VQ8wzeDzHeAUFRbEzs5w0Kdb54o35F3T6b8M5tCZe63JHcM236X4JQ84iezQtwZ0IUEcl13vgI6RMy3CH1QhOo0iP6aYWrvZ3cYABFyudIo1ES/SSo2HYr8XElI0LAfSUkvgs2tFpwhO0WTUcS3mKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q7qs8eCU; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q7qs8eCU"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfMY2CrRzfnR;
	Fri, 31 Jul 2026 23:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533337;
	bh=fmx03uNIRtjM1M+bfrzeMOji2HiOgXjypZd0nPp8hGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7qs8eCUwgLwyNGGUghohXJTK7KNN/Ptz83QIfvevsKtTQhbUl5cqJrRZT7TOOdf0
	 WL7Shnpk9JldCQWbLPuCPJ1llHcXZ0+jYqeETamjFWD4tA72vY0L+77nWQTYDHIEFr
	 8TPkTK0mdjcTCEqm/nNK5dmWqLp+ArW2oIgaJxb4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfMX4fn5zllS;
	Fri, 31 Jul 2026 23:28:56 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:28:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260731.at2Zilei1ech@digikod.net>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717220320.1030123-1-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 17, 2026 at 06:03:16PM -0400, Justin Suess wrote:
> Howdy
> 
> This series adds a new landlock_restrict_self(2) flag:
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
> 
> This is a redesign of v1 [1], which added
> LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC, a flag staging no_new_privs so that
> it was only set at the next execve(2).  Following Mickaël's feedback,
> [2] the staging mechanism (credential bit and bprm_committing_creds hook)
> is dropped entirely.  The new flag instead sets the no_new_privs
> attribute of the calling thread atomically with the enforcement of the
> ruleset: no_new_privs is set if and only if the
> landlock_restrict_self(2) call succeeds.
> 
> Semantics:
> 
> A single call replaces the usual prctl(PR_SET_NO_NEW_PRIVS) +
> landlock_restrict_self(2) pair.  Because no_new_privs is set by the
> call itself, the no_new_privs/CAP_SYS_ADMIN precondition is fulfilled
> by construction, so the flag is usable by unprivileged processes.  This
> is safe for the same reason the prctl(2) pair is: the executed programs
> can either gain privileges or be restricted, never both.
> 
> The two states cannot diverge.  A failed call (invalid ruleset FD,
> E2BIG, ENOMEM, interrupted TSYNC, ...) leaves no_new_privs unchanged,
> and a successful call never returns without no_new_privs set: the
> attribute is set past the last point of failure, right before
> commit_creds(), which cannot fail.
> 
> Combined with LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on all
> threads with the same guarantee: each sibling thread sets it in the
> commit phase of the TSYNC protocol, after its all-or-nothing barrier,
> so either every thread gets both the domain and no_new_privs, or none
> does.  This also makes it possible to atomically set no_new_privs
> process-wide, which prctl(2) cannot do.
> 
> Unlike the v1 flag, this flag requires a ruleset: calls with a
> ruleset_fd of -1 are rejected.  As a consequence of the fulfilled
> precondition, an unprivileged caller passing unknown flag bits together
> with this flag receives EINVAL instead of EPERM; the selftests pin this
> error ordering as well.
> 
> The reason why -1 ruleset_fd is rejected is basically then we are
> making a Landlock-flaved prctl(nnp) call that doesn't do anything
> special. It seems better to be able to have the option to define
> behavior later rather than have a useless feature stuck in the
> syscall abi. So we reject the -1 ruleset_fd for now.

I think it's the right approach to always require a valid ruleset (see
my reply on the previous thread), and this should be explained in the
commit message.  I don't see valid use cases where someone would like to
set NNP+TSYNC but not add any Landlock restrictions as well.

> 
> The Landlock ABI version is bumped to 11.
> 
> Test coverage:
> 
> base_test checks that a successful call sets no_new_privs without a
> prior prctl(2) nor CAP_SYS_ADMIN, that a failed call leaves it
> unchanged, that the flag requires a ruleset FD, and the updated
> EPERM/EINVAL ordering.  tsync_test checks that TSYNC sets no_new_privs
> on sibling threads along with the domain.
> 
> Changes since v1:
> 
> - Renamed LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC to
>   LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, per Mickaël's feedback.
> - Dropped the staged "on exec" design: removed the credential bit and
>   the bprm_committing_creds hook; no_new_privs is now set atomically
>   with the ruleset enforcement.
> - The flag now fulfills the no_new_privs/CAP_SYS_ADMIN precondition,
>   a significant departure from the v1.
> - The flag now requires a ruleset (no ruleset_fd = -1). Otherwise such
>   a call would just == a vanilla prctl no-new-privs call. This is left
>   in case we want to repurpose it later rather than defining useless
>   redundant behavior.
> 
> [1] https://lore.kernel.org/linux-security-module/20260708133928.852999-1-utilityemal77@gmail.com/
> [2] https://lore.kernel.org/linux-security-module/20260709.Eaphooyoh6sh@digikod.net/
> 
> Justin Suess (3):
>   landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>   selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>   landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> 
>  Documentation/userspace-api/landlock.rst      | 14 +++-
>  include/uapi/linux/landlock.h                 | 13 ++++
>  security/landlock/limits.h                    |  2 +-
>  security/landlock/syscalls.c                  | 28 ++++++--
>  security/landlock/tsync.c                     |  8 ++-
>  security/landlock/tsync.h                     |  4 +-
>  tools/testing/selftests/landlock/base_test.c  | 65 +++++++++++++++++--
>  tools/testing/selftests/landlock/tsync_test.c | 33 ++++++++++
>  8 files changed, 150 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 55f82176ef8dde632ea3eb94a6224950ed809d7c
> -- 
> 2.54.0
> 
> 
