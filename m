Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC461624D5
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555756; cv=none; b=X5iu5ZgZPKpCUzmKzKiuYjLbADJiN3/LssAcB9RCztJcDKkdmyv9zJqk0jaY/wx47O8ejTjgufxWkJ76RXEaqP2t4ZAtJd/nfdI/EjJyL0pnY7pYT5tGQqQOa+3tuwROeFr8OzcPUuf8DXBfFkEsR2LbuCTp9m5zpjpaBMVjSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555756; c=relaxed/simple;
	bh=y+vg5TaQbM79SI9CONaFDZmnaifPeFmDvk0wvPMVM64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxkMWSdjGVjRjiAuApB4qZ6LU9JdPELszyDV69IoIUijn/QMH1vsly5wW/nkzvSLTEoopIuH6ANi5u5ATecz37w8SR1Z/AqDbtt83TmaiiWbXmIku7YumvsrqgJdXtq28SWMGeZGkaY/jKqGQ5NaEmMqCB6udLx7mjLqUsI2aqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=e/cYM99+; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="e/cYM99+"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cn0v12nKTzSJS;
	Wed, 15 Oct 2025 21:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760555213;
	bh=C0f/xsFRAwWXnuN++o6H1vHIvfYxXQWcQGBhNInl0Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/cYM99+mnyqW9vk0S+ppqrohMIf+MIKmiB19c+4EBq9nDbJxTZGJghpEJZPTeuhe
	 SVTflFf1Jxg88Cx6XGABfLuw7X3RL/tRbOxJxrGLaZWHKU/KK8ME/1DWvyAmXJbRGb
	 qx81cUmYW7Rsd+Y8SzYJQTgrrDsJqQA+iYLoMV+8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cn0v05w5MzSXv;
	Wed, 15 Oct 2025 21:06:52 +0200 (CEST)
Date: Wed, 15 Oct 2025 21:06:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Implement LANDLOCK_ADD_RULE_QUIET
Message-ID: <20251015.Gaim1tieCesi@digikod.net>
References: <cover.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759686613.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

This patch series is not simple but really good, thanks!  I mostly have
nicking comments.  I'm looking forward the kselftests.

On Sun, Oct 05, 2025 at 06:55:23PM +0100, Tingmao Wang wrote:
> Hi,
> 
> This is the v2 of the "quiet flag" series, implementing the feature as
> proposed in [1].
> 
> v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/
> 
> The quiet flag allows a sandboxer to suppress audit logs for uninteresting
> denials.  The flag can be set on objects and inherits downward in the
> filesystem hierarchy.  On a denial, the youngest denying layer's quiet
> flag setting decides whether to audit.  The motivation for this feature is
> to reduce audit noise, and also prepare for a future supervisor feature
> which will use this bit to suppress supervisor notifications.
> 
> In this version, the most significant change is that we now have a quiet
> access mask in the ruleset_attr, which gets eventually stored in the
> hierarchy. This allows the user to specify which access should be affected
> by quiet bits.  One can then, for example, make it such that read accesses
> to certain files are not audited (but still denied), but all writes are
> still audited, regardless of location.
> 
> This version also implements quiet support for optional accesses (truncate
> and ioctl), scope denials (signal, abstract unix socket), addresses
> suggestions from v1 review, and further enhances sandboxer to allow full
> customization of which access to quiet.  Network and scope access quieting
> are now also supported by the sandboxer via additional environment
> variables.
> 
> I still haven't added any selftests yet but did some testing with
> sandboxer.  I would like this to be reviewed as it stands, before
> finishing up the tests which I will hopefully add in v3.
> 
> Patches removed since v1:
> - landlock/access: Improve explanation on the deny_masks_t
> 
> Demo:
> 
>     /# LL_FS_RO=/usr LL_FS_RW= LL_FORCE_LOG=1 LL_FS_QUIET=/dev:/tmp:/etc LL_FS_QUIET_ACCESS=r ./sandboxer bash
>     ...
>     audit: type=1423 audit(1759680175.562:195): domain=15bb25f6b blockers=fs.write_file,fs.read_file path="/dev/tty" dev="devtmpfs" ino=11
>     ^^^^^^^^
>     # note: because write is not quieted, we see the above line. blockers
>     # contains read as well since that's the originally requested access.
>     audit: type=1424 audit(1759680175.562:195): domain=15bb25f6b status=allocated mode=enforcing pid=616 uid=0 exe="/sandboxer" comm="sandboxer"
>     audit: type=1300 audit(1759680175.562:195): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c86113d1 a2=802 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680175.562:195): proctitle="bash"
>     bash: cannot set terminal process group (605): Inappropriate ioctl for device
>     bash: no job control in this shell
>     bash: /etc/bash.bashrc: Permission denied
>     audit: type=1423 audit(1759680175.570:196): domain=15bb25f6b blockers=fs.read_file path="/.bash_history" dev="virtiofs" ino=36963
>     ^^^^^^^^
>     # read outside /dev:/tmp:/etc - not quieted
>     audit: type=1300 audit(1759680175.570:196): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c868e400 a2=0 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680175.570:196): proctitle="bash"
>     audit: type=1423 audit(1759680175.570:197): domain=15bb25f6b blockers=fs.read_file path="/.bash_history" dev="virtiofs" ino=36963
>     audit: type=1300 audit(1759680175.570:197): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c868e400 a2=0 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680175.570:197): proctitle="bash"
> 
>     bash-5.2# head /etc/passwd
>     head: cannot open '/etc/passwd' for reading: Permission denied
>     ^^^^^^^^
>     # reads to /etc are quieted
> 
>     bash-5.2# echo evil >> /etc/passwd
>     bash: /etc/passwd: Permission denied
>     audit: type=1423 audit(1759680227.030:198): domain=15bb25f6b blockers=fs.write_file path="/etc/passwd" dev="virtiofs" ino=790
>     ^^^^^^^^
>     # writes are not quieted
>     audit: type=1300 audit(1759680227.030:198): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c86ab030 a2=441 a3=1b6 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680227.030:198): proctitle="bash"
> 
> Design:
> 
> - The user can set the quiet flag for a layer on any part of the fs
>   hierarchy (whether it allows any access on it or not), and the flag
>   inherits down (no support for "cancelling" the inheritance of the flag
>   in specific subdirectories).
> 
> - The youngest layer that denies a request gets to decide whether the
>   denial is audited or not.  This means that a compromised binary, for
>   example, cannot "turn off" Landlock auditing when it tries to access
>   files, unless it denies access to the files itself.  There is some
>   debate to be had on whether, if a parent layer sets the quiet flag, but
>   the request is denied by a deeper layer, whether Landlock should still
>   audit anyway (since the rule author of the child layer likely did not
>   expect the denial, so it would be good diagnostic).  The current
>   approach is to ignore the quiet on the parent layer and audit anyway.
> 
> All existing kselftests pass.
> 
> [1]: https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918
> 
> Kind regards,
> Tingmao
> 
> Tingmao Wang (6):
>   landlock: Add a place for flags to layer rules
>   landlock: Add API support and docs for the quiet flags
>   landlock/audit: Check for quiet flag in landlock_log_denial
>   landlock/audit: Fix wrong type usage
>   samples/landlock: Add quiet flag support to sandboxer
>   Implement quiet for optional accesses
> 
>  include/uapi/linux/landlock.h                |  64 +++++++++
>  samples/landlock/sandboxer.c                 | 133 +++++++++++++++++--
>  security/landlock/audit.c                    | 113 +++++++++++++---
>  security/landlock/audit.h                    |   4 +-
>  security/landlock/domain.c                   |  23 ++++
>  security/landlock/domain.h                   |  10 ++
>  security/landlock/fs.c                       | 103 ++++++++------
>  security/landlock/fs.h                       |  36 +++--
>  security/landlock/net.c                      |  11 +-
>  security/landlock/net.h                      |   3 +-
>  security/landlock/ruleset.c                  |  19 ++-
>  security/landlock/ruleset.h                  |  39 +++++-
>  security/landlock/syscalls.c                 |  72 +++++++---
>  security/landlock/task.c                     |  12 +-
>  tools/testing/selftests/landlock/base_test.c |   4 +-
>  15 files changed, 538 insertions(+), 108 deletions(-)
> 
> 
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> -- 
> 2.51.0
> 
> 
