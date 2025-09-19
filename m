Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2523C4F3
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298223; cv=none; b=SF9hU65ijPbu66WBt+Zxwp79WusmPtemPwt9aVot32fjUCG2b1RgFQr9zUWleBFdBKTZ9PTvsDbQBIMwbZm5JfdA8zz6sEmYO+7Nk3Lm4Ybyv45ghx+eAkANASV3Zn7WyIQJcdLdI/t7hs5pAkXSuHUu5/E0c3KDoTKP5qwzvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298223; c=relaxed/simple;
	bh=G/U+kWo5+mviyOgPhIMrzQbF8pkHPtF9z/tkf+AQAZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncUK+ouO3EDB2Cgb0ofyCuP/GEtjcgkr6+6JSGlxwK9bsrVTgEOh0Jrdp0QrhEC3L3dih2h5FnhK/BGZiOQI2L4QSffVdA9+SqSURIeHpeyr0hCidZJteLjc/fuEnxbQnnbR4+O4OiggLcnwaYsjBoB8ZwXk8hZduhBDnzHMiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jVE/00A4; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jVE/00A4"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSy1X61nDzGDc;
	Fri, 19 Sep 2025 18:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758297712;
	bh=zBIhbEBnUmhRzWS20b/ahpFER7uvpPEx5f3JxMhrC3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVE/00A4QsN4F4pKSvc/GR1vqucLteHyXqXSXsgtjjC55T88TPGPTviMOIV4sQYDf
	 RKgY3ahLoABrqgB+rYRMI+gzPvQLO2HMubhUHmPZR4ctuBFvUPgvhIhzO+ENvHszHt
	 9lArwlsi5N38OOAe/U8t0NquXm6IK6us0xCF8HvI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSy1X1vbSzGlj;
	Fri, 19 Sep 2025 18:01:52 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:01:48 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Implement LANDLOCK_ADD_RULE_QUIET
Message-ID: <20250919.oTah2joh3uuc@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1757376311.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

Hi Tingmao,

I have a few comments but overall this series looks very good.  Thanks!

On Tue, Sep 09, 2025 at 01:06:34AM +0100, Tingmao Wang wrote:
> Hi Mickaël,
> 
> This RFC patch series implements a first pass patch of the "quiet flag"
> feature as proposed in [1].  I've evolved the design beyond the original
> discussion to come up with what I believe would be most useful.  For this
> implementation:
> 
> - The user can set the quiet flag for a layer on any part of the fs
>   hierarchy, and the flag inherits down (no support for "cancelling" the
>   inheritance of the flag in specific subdirectories).
> 
> - The youngest layer that denies a request gets to decide whether the
>   denial is audited or not.  This means that a compromised binary, for
>   example, cannot "turn off" Landlock auditing when it tries to access
>   files, unless it denies access to the files itself.  There is some
>   debate to be had on whether, if a parent layer sets the quiet flag, but
>   the request is denied by a deeper layer, whether Landlock should still
>   audit anyway (since the rule author of the child layer likely did not
>   expect the denial, so it would be good diagnostic)
> 
> This series does not add any tests yet (and also no support for
> suppressing optional access denial audit yet due to complexity).  If
> you're happy with this design I can write some tests (and add the missing
> support).

Yes, please.

> Here is a sandboxer demo:
> 
>     # LL_FS_RO=/ LL_FS_RW= LL_FORCE_LOG=1 LL_FS_QUIET=/tmp linux/samples/landlock/sandboxer /bin/bash
>     Executing the sandboxed command...
>     [  135.126499][   T60] audit: type=1423 audit(1757374868.281:942): domain=1a435130e blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=11
>     [  135.133298][   T60] audit: type=1424 audit(1757374868.281:942): domain=1a435130e status=allocated mode=enforcing pid=959 uid=0 exe="/linux/samples/landlock/sandboxer" comm="sandboxer"
>     [  135.141869][   T60] audit: type=1300 audit(1757374868.281:942): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=557a9cda83d1 a2=802 a3=0 items=0 ppid=958 pid=959 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     [  135.156620][   T60] audit: type=1327 audit(1757374868.281:942): proctitle="/bin/bash"
>     bash: cannot set terminal process group (958): Inappropriate ioctl for device
>     bash: no job control in this shell
> 
>     # echo quiet > /tmp/aa
>     bash: /tmp/aa: Permission denied
> 
>     # echo not quiet > /usr/aa
>     [  165.358804][   T60] audit: type=1423 audit(1757374898.513:943): domain=1a435130e blockers=fs.make_reg path="/usr" dev="virtiofs" ino=840
>     [  165.363746][   T60] audit: type=1300 audit(1757374898.513:943): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=557a9ce447c0 a2=241 a3=1b6 items=0 ppid=958 pid=959 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     [  165.375594][   T60] audit: type=1327 audit(1757374898.513:943): proctitle="/bin/bash"
>     bash: /usr/aa: Permission denied
> 
>     ## (still in sandboxer)
>     # LL_FS_RO= LL_FS_RW=/ LL_FS_QUIET=/ linux/samples/landlock/sandboxer /bin/bash
>     Executing the sandboxed command...
>     [  203.490417][   T60] audit: type=1423 audit(1757374936.645:944): domain=1a435130e blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=11
>     ...
>     # echo "child can't suppress audit logs" > /usr/a
>     [  219.948543][   T60] audit: type=1423 audit(1757374953.101:945): domain=1a435130e blockers=fs.make_reg path="/usr" dev="virtiofs" ino=840
>     [  219.953918][   T60] audit: type=1300 audit(1757374953.101:945): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5651ea7875c0 a2=241 a3=1b6 items=0 ppid=959 pid=960 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     [  219.969167][   T60] audit: type=1327 audit(1757374953.101:945): proctitle="/bin/bash"
>     bash: /usr/a: Permission denied
>     # echo "/tmp is still quiet" > /tmp/a
>     bash: /tmp/a: Permission denied
>     # exit
> 
>     (still in first layer sandboxer)
>     # LL_FS_RO=/ LL_FS_RW= LL_FS_QUIET= LL_FORCE_LOG=1 linux/samples/landlock/sandboxer /bin/bash
>     Executing the sandboxed command...
>     ...
>     root@fced6595bd01:/# echo "not quiet now" > /tmp/a
>     [  492.130486][   T60] audit: type=1423 audit(1757375225.285:949): domain=1a435132a blockers=fs.make_reg path="/tmp" dev="tmpfs" ino=1
>     [  492.136729][   T60] audit: type=1300 audit(1757375225.285:949): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=55fc4c168450 a2=241 a3=1b6 items=0 ppid=959 pid=964 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     [  492.151727][   T60] audit: type=1327 audit(1757375225.285:949): proctitle="/bin/bash"
>     bash: /tmp/a: Permission denied
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
>   landlock: Add API support for the quiet flag
>   landlock/audit: Check for quiet flag in landlock_log_denial
>   landlock/audit: Fix wrong type usage
>   landlock/access: Improve explanation on the deny_masks_t
>   samples/landlock: Add FS quiet flag support to sandboxer
> 
>  include/uapi/linux/landlock.h                | 25 +++++
>  samples/landlock/sandboxer.c                 | 20 +++-
>  security/landlock/access.h                   |  6 +-
>  security/landlock/audit.c                    | 18 +++-
>  security/landlock/audit.h                    |  3 +-
>  security/landlock/fs.c                       | 99 ++++++++++++--------
>  security/landlock/fs.h                       |  2 +-
>  security/landlock/net.c                      | 11 ++-
>  security/landlock/net.h                      |  3 +-
>  security/landlock/ruleset.c                  | 17 +++-
>  security/landlock/ruleset.h                  | 29 +++++-
>  security/landlock/syscalls.c                 | 28 +++---
>  security/landlock/task.c                     | 12 +--
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  14 files changed, 199 insertions(+), 76 deletions(-)
> 
> 
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> -- 
> 2.51.0
> 
> 
