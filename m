Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937626;
	b=MucogHqJiIW4m/gRSioUKCtbvOTyV+JLUNipFDe9ljmugaLPCDMGW/MLTCLWGO3GjFnc
	 noOhAnAX7+u9jyvbdtmVyWeaNYbUf44v7/APiZQFpZH5jbcTHlz+DhJOHSbCCPHl98STx
	 0TdBaTcpIltfa/KIcrXzREramytE45wefdU/5i6xM+8s235T/cNaEmW2B4ADpE/48ogOS
	 9QaDX6qTHuh9gEEWh2B07t59T2irmmZSmAG1b9kIc1AqyWTMK0kB3R+nwX4wyv8WYkjKs
	 pmsUgBZKXwR0gKK+OIjYHhWcgxQk+fbzwUpW+xqnIAYwDMx4N3sCzbi3mpKhaQMP/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937626;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gG4gJBH70vwhLBAwsJc2f1i9/ZRakdwRX/cphXhKEFk=;
	b=l/Fv+EvLKQcRi5XVHwTk80Z3b/Gz3boeXYr27IEgb0SDTwUt7PwoHcAB4b8SuP6kDiGO
	 XA3CkvhpIpRluoqn3lgKVMkBXhXI9Z00kcd4IXLnwGeRbpfYk/Fw6oJIPsAAzZSvM5ico
	 UVnmo1iMHdch3EkAwKo+bCzMZvJQV7SL/Bb+CZoS5kmTAHtr/7E5ac5a/hrUjwiMieq12
	 DMXEPNFln/FPIlFVouay343P1bYM9ZIIk1+5wjnlfIGBSnDwiQuLJCbsdV467fUgZFuCj
	 GvlmEMs7oENQWu7ggJ71fUom5laM5Sn+SD+Hk+XrwaT6jMsNYXJkbHhidsgkrWDpsCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=mdXfHJVU;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F1606A326;
	Fri,  6 Nov 2026 04:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=mdXfHJVU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793937623; bh=VWYqX418nByO0eoQ9OmIikW5u3giy1iv2vfsvfsWcl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdXfHJVUNstvS7SNDFebCZBeIvf2ahtlMsWniderv+naRr7tXLoWMJ7ZQEix/psmk
	 wesVHRPhXe31ctoJh2BG//NKeSRePLTCch+8oS3ujHamvSh9U5xT4/K+NXzxiFDR1L
	 ibJlXHfX4voo1A4UZDeUcrleyQQ7Mbno7X9ZnPohrdeht/qOm60ZkaN6yVKQdf8c1N
	 80QUx8IDy6zQMoECZLntfc2d8YZuKslHhPjvPxJscDFe6iEgq1eaHCRSgh73Q1wFvN
	 nbY9Ir1qxDeUwhJtpnJU+29hk0Rks5GhxXea8Z9+r/d1b7kN1PdPDSYAmajXO+v90r
	 yvz9hgk2nGhVw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A5CD7229E; Thu,  5 Nov 2026 22:00:23 -0600 (CST)
Date: Thu, 5 Nov 2026 22:00:23 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 00/13] cred: gather the "same uid" checks between
 tasks in one place
Message-ID: <au1Q1+s102IDLWJ0@hallyn.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>

On Wed, Nov 04, 2026 at 02:24:27PM +0000, Josef Bacik wrote:
> v1: https://lore.kernel.org/all/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com/
> 
> v1->v2:
> - Rebased onto v7.4-rc1, patch 1 didn't apply any more.
> - Patch 1: VFS_WARN_ON_ONCE() in the default case of
>   cred_ids_allow_control() instead of failing silently (Serge).
> - Dropped the Assisted-by trailers, see 1e035297ffda ("docs: remove
>   Assisted-by references").
> 
> --- Original email (v1) ---
> 
> Hello,
> 
> We have a dozen places in the kernel that let one task mess with another
> because they belong to the same user: kill(), SIGIO, the scheduler
> syscalls, setpriority(), ioprio_set(), prlimit(), ptrace, moving a task
> around in cgroup v1 and resctrl, and KEYCTL_SESSION_TO_PARENT.  Every
> one of them open codes a handful of uid_eq() calls on the two creds.
> They come in six flavors that differ in which of the real, effective and
> saved ids they look at, and in whether euid 0 gets a pass, and there is
> nothing that tells you whether two of them differ on purpose or by
> accident.
> 
> I tripped over this working on something else that needs to change what
> "the same user" means.  I kept finding another copy I had missed, and
> for this kind of check a copy you missed is a hole.  So this pulls all
> of them into kernel/cred.c, side by side, with a table that says which
> rule looks at what, and converts the callers one at a time.
> 
> Nothing is supposed to change.  What each of these means by "the same
> user" is ABI at this point, so every rule is kept exactly as it was,
> warts and all, I have not tried to unify them.  The capability checks
> and the LSM hooks stay with the callers.
> 
> The one patch that isn't a straight substitution is the fcntl one.
> F_SETOWN copies the uid and euid of the caller into the fown_struct, and
> the helpers take creds, so it holds a reference on the cred instead, the
> same way struct file does for the opener.  That means the cred sticks
> around until the owner is set again or the file goes away.
> 
> For testing, patch 2 is a KUnit test that holds each helper against the
> expression it replaces, verbatim, over every combination of a few ids. I
> also ran kill, setpriority, ioprio_set, sched_setaffinity,
> sched_setscheduler, prlimit, a cgroup v1 move, SIGIO and PTRACE_SEIZE
> for all 64 combinations of real, effective and saved uid of the two
> tasks, on a kernel with and without the series under KASAN and lockdep.
> All 576 results are the same on both, and they match what the table
> says.  The resctrl and usbdevfs (kill_pid_usb_asyncio) callers I have no
> way to exercise, and the MIPS patch is compile tested only.
> 
> This is based on vfs.all only because that's what the other work sits
> on. Thanks,
> 
> Josef
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

thanks,
-serge

> ---
> Changes in v2:
> - Link to v1: https://patch.msgid.link/20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com
> 
> ---
> Josef Bacik (13):
>       cred: gather the rules for acting on a task by uid
>       cred: add KUnit tests for the id rules
>       signal: use cred_ids_allow_signal()
>       fcntl: use cred_ids_allow_sigio()
>       sched: use cred_ids_allow_sched()
>       MIPS: use cred_ids_allow_sched()
>       sys: use cred_ids_allow_sched() for setpriority()
>       sys: use cred_ids_allow_control() for prlimit()
>       block: use cred_ids_allow_ioprio()
>       cgroup/v1: use cred_ids_allow_move()
>       fs/resctrl: use cred_ids_allow_move()
>       ptrace: use cred_ids_allow_control()
>       keys: use cred_ids_allow_control()
> 
>  Documentation/security/credentials.rst |  19 +++
>  MAINTAINERS                            |   1 +
>  arch/mips/kernel/mips-mt-fpaff.c       |   3 +-
>  block/blk-ioc.c                        |   3 +-
>  fs/fcntl.c                             |  19 +--
>  fs/resctrl/rdtgroup.c                  |   4 +-
>  include/linux/cred.h                   |  20 +++
>  include/linux/fs.h                     |   4 +-
>  kernel/Makefile                        |   1 +
>  kernel/cgroup/cgroup-v1.c              |   4 +-
>  kernel/cred.c                          | 162 ++++++++++++++++++++++++
>  kernel/cred_kunit.c                    | 218 +++++++++++++++++++++++++++++++++
>  kernel/ptrace.c                        |  16 +--
>  kernel/sched/syscalls.c                |   3 +-
>  kernel/signal.c                        |  10 +-
>  kernel/sys.c                           |  10 +-
>  lib/Kconfig.debug                      |  13 ++
>  security/keys/keyctl.c                 |   7 +-
>  security/landlock/fs.h                 |   3 +-
>  19 files changed, 461 insertions(+), 59 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261018-b4-cred-ids-eb01b2b38524
