Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27E35F172
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433126; cv=none; b=I/62cdYhCDwR+Nh4fQh+BMXNitVaiXxyOc1vyGazmJekJShjMF1u7eR2+m/BfefPtQObupkzNXCWpU+/RSpE51TvRfBSaNg7h6e6nAaY41kBecwO1sKmCvRsix6sTmuy605DRTbs2qavyXTfTzyhhCUK4SQk8V3xMcm5BRwXaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433126; c=relaxed/simple;
	bh=YIpk+Aaj1YOC7lr47qFPzAJeh9zTkp05s52Zh2cemDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSIPFPIS745sEZGmkVn3IdGnnach3ZhzDFpkEj5vBVEN7JZIpKUCZdzEzJNg8wGQovogaFpS+rJngiuh2QaibMGnnsJeduSIje0Ob/4pk5fezYyEM3PdkUiNaLHEMbG0VQxxOUIH0y/cjqxM1xDXskgQUcImDJdHiM9tCErx9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JZN1DVU8; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JZN1DVU8"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK30M1Pqjzdpl;
	Tue, 11 Aug 2026 09:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786432771;
	bh=vo4kG04uZSK7UAf6MOJGjqkZ6AcO+9nAZkNBqsETgBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZN1DVU8ydxzzo+U//1WBFhjq40wGnQv3Aht+Pyy3MpIqwIU6qPnEMpzDyP2Jl52B
	 RXfOW0Ddj/lKnlBskkkGYHnaNxpEDc8qkpJi5hu9qAQsfi44sZz67coiSb+ioYYKjd
	 ci0mKVM8DyRS/IPI5DVqo7UjQJVD5Mc8OJPOJY3s=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK30L44f0zb2S;
	Tue, 11 Aug 2026 09:19:30 +0200 (CEST)
Date: Tue, 11 Aug 2026 09:19:29 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260811.yo6ahLuuc3xi@digikod.net>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809154544.1253100-1-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

Thanks Justin, it's now merged in the Landlock next branch.

On Sun, Aug 09, 2026 at 11:45:18AM -0400, Justin Suess wrote:
> Howdy
> 
> This series adds a new landlock_restrict_self(2) flag:
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
> 
> The flag sets the no_new_privs attribute of the calling thread only
> once the enforcement of the ruleset succeeded: no_new_privs is set if
> and only if the landlock_restrict_self(2) call succeeds.
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
> does.  This also makes it possible to set no_new_privs process-wide in
> one call, which prctl(2) cannot do.
> 
> The flag requires a ruleset: calls with a ruleset_fd of -1 are
> rejected.  Such a call would be nothing more than a Landlock-flavored
> prctl(PR_SET_NO_NEW_PRIVS), and rejecting it keeps the option of giving
> it a meaning later.
> 
> Following Mickaël's feedback on v3 [1], a new preparatory patch first
> moves the no_new_privs/CAP_SYS_ADMIN check after the flags check, in
> the same order as seccomp(2).  Unprivileged callers passing unknown
> flag bits now consistently get EINVAL instead of EPERM, whether or not
> the new flag is involved; the selftests pin this error ordering.
> 
> The Landlock ABI version is bumped to 11.
> 
> Test coverage:
> 
> base_test checks that a successful call sets no_new_privs without a
> prior prctl(2) nor CAP_SYS_ADMIN, that a failed call (invalid ruleset
> FD or layer maximum) leaves it unchanged, that the flag requires a
> ruleset FD, and the flags-before-privileges error ordering.
> tsync_test checks, through variants of a common multi_threaded
> fixture, that TSYNC sets no_new_privs on sibling threads along with
> the domain, and that a TSYNC call failing on the layer maximum leaves
> it unset on every thread.
> 
> Changes since v3:
> 
> - New preparatory patch: check the landlock_restrict_self(2) flags
>   before the no_new_privs/CAP_SYS_ADMIN requirement, like seccomp(2),
>   per Mickaël's feedback.  The EINVAL/EPERM visible change now stems
>   from this patch instead of the new flag.
> - Folded the minimal selftest changes (ABI version, last-flag, and
>   checks-ordering updates) into the main patch to keep the series
>   bisectable, following the commit tweaked by Mickaël in his next
>   branch.
> - Dropped the set_no_new_privs local variable; the flag is now checked
>   directly at both use sites.
> - Turned the multi_threaded_{success,no_new_privs,
>   no_new_privs_max_layers} tests into variants of a common
>   multi_threaded fixture.
> - Reworded the documentation: removed the ambiguous "it"s in the
>   tutorial paragraph on CAP_SYS_ADMIN, and used the suggested
>   "call (or CAP_SYS_ADMIN use)" wording in both the compatibility
>   section and the uapi kdoc.
> 
> Per-patch changelogs are below each patch.
> 
> [1] https://lore.kernel.org/linux-security-module/20260803223109.707353-1-utilityemal77@gmail.com/
> 
> Justin Suess (5):
>   landlock: Check landlock_restrict_self(2)'s flags before privileges
>   landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>   selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>   landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
>   samples/landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to sampler
> 
>  Documentation/userspace-api/landlock.rst      |  47 +++++++-
>  include/uapi/linux/landlock.h                 |  13 +++
>  samples/landlock/sandboxer.c                  |  16 ++-
>  security/landlock/limits.h                    |   2 +-
>  security/landlock/syscalls.c                  |  35 ++++--
>  security/landlock/tsync.c                     |   8 +-
>  security/landlock/tsync.h                     |   4 +-
>  tools/testing/selftests/landlock/base_test.c  | 104 +++++++++++++++++-
>  tools/testing/selftests/landlock/tsync_test.c |  96 ++++++++++++++--
>  9 files changed, 283 insertions(+), 42 deletions(-)
> 
> -- 
> 2.55.0
> 
> 
