Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7623D984
	for <linux-security-module@vger.kernel.org>; Tue, 25 Feb 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513091; cv=none; b=DgslyBDR/Sv93j2wGYL7VdIP84v7hozJX4PREHC43Dyo17Yrnw6qxpwdmM+ikWPnzJ1rCxwcrdm283xRL3ztaRGKFuGyXpDnj3fIh4/ssVO0C43qQJhOBTUTUxdUQRmH1kheNjHlOIfZg6q+ZWm48j9ez5d8k2Lyb1JGY++AH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513091; c=relaxed/simple;
	bh=2rfJ4MjbYODeKeK6MzMpamuNOq9atNzLshJAtp01P4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVpXjRceDr/qhRXmpgnHDmj3WcNxKGiUkjS8riUCNykD6I9fn/oQLRK6NuEAHgMEz7qicSQCHam9rTRWp+lM3mmWG2rqUdRuVgmlge1luaEyB3ZkE6KymoZaNEkeT/IuwT3TH0DXtLfMtnCzDhU8Ys5M97RHbk/LYqJ5gPw6fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lzfRJcpV; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lzfRJcpV"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z2SsK3cW4zkhw;
	Tue, 25 Feb 2025 20:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740513077;
	bh=N75QuTFSA8bLUuhnsRdwpVAcsyfe/PE8QYVob2sNaSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzfRJcpVmXpier2Aa5RVm/Qc0ff8/8Od7A7pBEwQC2C367xp5zxV4QpHMg1V2cIhA
	 FyhlK9QRSOlS7X3H/3BgPvpQa5fUt0l/BojupPCI0giLZqtVnu5+WU9EVuUG265tej
	 6D3ef+74jA7myTHIhKOtElzmPln79JpvZmVx0dxo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z2SsH1cDSzW3Y;
	Tue, 25 Feb 2025 20:51:15 +0100 (CET)
Date: Tue, 25 Feb 2025 20:51:14 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 00/24] Landlock audit support
Message-ID: <20250225.Ahd9ohTegh5U@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
 <20250222.0cd761da0d19@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222.0cd761da0d19@gnoack.org>
X-Infomaniak-Routing: alpha

On Sat, Feb 22, 2025 at 08:47:40PM +0100, Günther Noack wrote:
> On Fri, Jan 31, 2025 at 05:30:35PM +0100, Mickaël Salaün wrote:
> > Hi,
> > 
> > This patch series adds audit support to Landlock.
> > 
> > Logging denied requests is useful for different use cases:
> > - sysadmins: to look for users' issues,
> > - security experts: to detect attack attempts,
> > - power users: to understand denials,
> > - developers: to ease sandboxing support and get feedback from users.
> > 
> > Because of its unprivileged nature, Landlock can compose standalone
> > security policies (i.e. domains).  To make logs useful, they need to
> > contain the most relevant Landlock domain that denied an action, and the
> > reason of such denial.  This translates to the latest nested domain and
> > the related blockers: missing access rights or other kind of
> > restrictions.
> > 
> > # Changes from previous version
> > 
> > Remove the AUDIT_EXE_LANDLOCK_DENY audit rule and add 2 new
> > landlock_restrict_self(2) flags to filter Landlock audit events, which
> > makes 3 flags:
> > - LANDLOCK_RESTRICT_SELF_QUIET: do not log any denied access because of
> >   this new domain.
> > - LANDLOCK_RESTRICT_SELF_QUIET_DESCENDENTS: do not log denied access
> >   from child domains.
> > - LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC: log denied access for processes
> >   resulting from an execve(2), which is not the case by default anymore.
> > 
> > One patch was merged in mainline: 7ccbe076d987 ("lsm: Only build
> > lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are set").
> > 
> > # Design
> > 
> > Log records are created for any denied actions caused by a Landlock
> > policy, which means that a well-sandboxed applications should not log
> > anything except for unattended access requests that might be the result
> > of attacks or bugs.
> > 
> > However, sandbox tools creating restricted environments could lead to
> > abundant log entries because the sandboxed processes may not be aware of
> > the related restrictions.  To avoid log spam, the
> > landlock_restrict_self(2) syscall gets a new
> > LANDLOCK_RESTRICT_SELF_QUIET flag to not log denials related to this
> > specific domain.  Except for well-understood exceptions, this flag
> > should not be set.  Indeed, applications sandboxing themselves should
> > only try to bypass their own sandbox if they are compromised, which
> > should ring a bell thanks to log events.
> > 
> > When an action is denied, the related Landlock domain ID is specified.
> > If this domain was not previously described in a log record, one is
> > created.  This record contains the domain ID, its creation time, and
> > informations about the process that enforced the restriction (at the
> > time of the call to landlock_restrict_self): PID, UID, executable path,
> > and name (comm).
> > 
> > This new approach also brings building blocks for an upcoming
> > unprivileged introspection interface.  The unique Landlock IDs will be
> > useful to tie audit log entries to running processes, and to get
> > properties of the related Landlock domains.  This will replace the
> > previously logged ruleset properties.
> 
> What implications does this patch set have for Landlock's performance?

I did the benchmark for the hook_file_open() (with the changes explained
below) and there is no visible overhead for the worse case: opening /
takes ~8 micro seconds with and without sandboxing, and with and without
this patch series (when the request is allowed).  I'll do the same for
other significant operations, including for denied requests, and include
the result in the next patch series.

> 
> For some aspects of Landlock domains, when domains get merged, their
> rules can potentially get merged into simpler "flattened"
> representations at the cost of losing track about the original domain
> for individual denials.
> 
> For instance, when a process enforces the following two rulesets
> nested in each other:
> 
>  * RS1 allowed to only connect to TCP ports {1, 2, 3}
>  * RS2 allowed to only connect to TCP ports {2, 3, 4}
> 
> Then the resulting merged domain could build the intersection of these
> two sets {2, 3}, and store a smaller set of port numbers than the two
> rulesets individually.  Similar tricks would likely also be possible
> for the rules for socket type restriction, as well as for
> IOCTL-per-command allow-lists, if we had done that at that level of
> granularity.
> 
> I realize that we are not doing this right now for ports, so it is
> slightly speculative, but it would be an option in the future.
> However, when we want to attribute each denial to the original domain
> which caused it, that kind of optimization does not work any more.

Yes, we are not doing this because of the requirement to identify
domains, see
http://lore.kernel.org/r/86db9124-ea11-0fa5-9dff-61744b2f80b4@digikod.net

We really need to be able to identify the cause/source of any denial.
This is a required feature for any decent access control system to
enable users to debug their systems/programs.  I should probably extend
the Landlock guiding principles with this requirement.

This requirement might limit potential future improvements (at the
margin), but it's definitely worth it.

> 
> In performance-sensitive environments that don't need Landlock
> auditing, to what extent would users of such environments have to pay
> a "hidden cost" of auditing because we can't do such "data structure
> flattening" optimizations any more?

In such environments, users can disable audit, and we could have a
dedicated type for this case, but I'm not convinced such optimization
and potential increased complexity would be worth it wrt other "slow"
paths.  Anyway, we should first start optimizing by using a hash table.

> 
> Do you have thoughts on how you want to strike the balance between
> Landlock performance and logging accuracy?

The initial versions of this audit support patch series were much more
verbose.  With the current version I think we found the right balance
between the minimal useful information, verbosity, and complexity.

One important point to keep in mind is that the vast majority of this
new code is only executed for denied access requests.  The approach is
for processes to only pay (a bit) when they request a denied access
(which should be rare).

However, I though the audit-specific variables (e.g. struct
landlock_request) initialization would be moveed near the
landlock_log_denial() calls (i.e. only initialized for denied
requests), but even with compiler optimizations, neither GCC nor clang
do that, so I'll do it manually in the next series.

For now, the two main potential slow paths for Landlock are the backward
path walks for filesystem access [1], and the use of red-black trees for
domains [2].  These slow paths are already difficult to see, so the
impact of audit support is negligible comparatively, especially for
legitimate use cases.

[1] https://github.com/landlock-lsm/linux/issues/9
[2] https://github.com/landlock-lsm/linux/issues/1

> 
> –Günther
> 
> > # Samples
> > 
> > Here are two examples of log events (see serial numbers):
> > 
> > $ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1
> > 
> >   type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
> >   type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"
> >   type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
> >   type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
> >   type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f status=deallocated denials=1
> > 
> > $ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"
> > 
> >   type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
> >   type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"
> >   type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
> >   type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
> >   type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
> >   type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
> >   type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
> >   type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 status=deallocated denials=2
> > 
> > # Future changes
> > 
> > I'll add more tests to check each kind of denied access.
> > 
> > # Previous versions
> > 
> > v4: https://lore.kernel.org/r/20250108154338.1129069-1-mic@digikod.net
> > v3: https://lore.kernel.org/r/20241122143353.59367-1-mic@digikod.net
> > v2: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
> > v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net
> > 
> > Regards,
> > 
> > Mickaël Salaün (24):
> >   lsm: Add audit_log_lsm_data() helper
> >   landlock: Add unique ID generator
> >   landlock: Move domain hierarchy management
> >   landlock: Prepare to use credential instead of domain for filesystem
> >   landlock: Prepare to use credential instead of domain for network
> >   landlock: Prepare to use credential instead of domain for scope
> >   landlock: Prepare to use credential instead of domain for fowner
> >   landlock: Identify domain execution crossing
> >   landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials
> >   landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status
> >   landlock: Log mount-related denials
> >   landlock: Log file-related denials
> >   landlock: Log truncate and IOCTL denials
> >   landlock: Log TCP bind and connect denials
> >   landlock: Log scoped denials
> >   landlock: Add LANDLOCK_RESTRICT_SELF_QUIET
> >   landlock: Add LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
> >   landlock: Add LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC
> >   samples/landlock: Enable users to log sandbox denials
> >   selftests/landlock: Extend tests for landlock_restrict_self()'s flags
> >   selftests/landlock: Add tests for audit and
> >     LANDLOCK_RESTRICT_SELF_QUIET
> >   selftests/landlock: Test audit with restrict flags
> >   selftests/landlock: Add audit tests for ptrace
> >   landlock: Add audit documentation
> > 
> >  Documentation/admin-guide/LSM/index.rst       |   1 +
> >  Documentation/admin-guide/LSM/landlock.rst    | 157 ++++++
> >  Documentation/security/landlock.rst           |   7 +
> >  Documentation/userspace-api/landlock.rst      |   9 +-
> >  MAINTAINERS                                   |   1 +
> >  include/linux/lsm_audit.h                     |   8 +
> >  include/uapi/linux/audit.h                    |   4 +-
> >  include/uapi/linux/landlock.h                 |  31 ++
> >  samples/landlock/sandboxer.c                  |  37 +-
> >  security/landlock/.kunitconfig                |   2 +
> >  security/landlock/Makefile                    |   5 +
> >  security/landlock/access.h                    |  23 +
> >  security/landlock/audit.c                     | 513 ++++++++++++++++++
> >  security/landlock/audit.h                     |  77 +++
> >  security/landlock/cred.c                      |  26 +-
> >  security/landlock/cred.h                      |  65 +++
> >  security/landlock/domain.c                    | 264 +++++++++
> >  security/landlock/domain.h                    | 158 ++++++
> >  security/landlock/fs.c                        | 279 ++++++++--
> >  security/landlock/fs.h                        |  21 +-
> >  security/landlock/id.c                        | 249 +++++++++
> >  security/landlock/id.h                        |  25 +
> >  security/landlock/limits.h                    |   4 +
> >  security/landlock/net.c                       |  74 ++-
> >  security/landlock/ruleset.c                   |  33 +-
> >  security/landlock/ruleset.h                   |  47 +-
> >  security/landlock/setup.c                     |   2 +
> >  security/landlock/syscalls.c                  |  50 +-
> >  security/landlock/task.c                      | 232 ++++++--
> >  security/lsm_audit.c                          |  27 +-
> >  tools/testing/kunit/configs/all_tests.config  |   2 +
> >  tools/testing/selftests/landlock/Makefile     |   6 +-
> >  tools/testing/selftests/landlock/audit.h      | 358 ++++++++++++
> >  tools/testing/selftests/landlock/audit_test.c | 425 +++++++++++++++
> >  tools/testing/selftests/landlock/base_test.c  |  43 +-
> >  tools/testing/selftests/landlock/common.h     |   3 +
> >  tools/testing/selftests/landlock/config       |   1 +
> >  .../testing/selftests/landlock/ptrace_test.c  |  67 ++-
> >  .../selftests/landlock/wait-pipe-sandbox.c    | 131 +++++
> >  39 files changed, 3244 insertions(+), 223 deletions(-)
> >  create mode 100644 Documentation/admin-guide/LSM/landlock.rst
> >  create mode 100644 security/landlock/audit.c
> >  create mode 100644 security/landlock/audit.h
> >  create mode 100644 security/landlock/domain.c
> >  create mode 100644 security/landlock/domain.h
> >  create mode 100644 security/landlock/id.c
> >  create mode 100644 security/landlock/id.h
> >  create mode 100644 tools/testing/selftests/landlock/audit.h
> >  create mode 100644 tools/testing/selftests/landlock/audit_test.c
> >  create mode 100644 tools/testing/selftests/landlock/wait-pipe-sandbox.c
> > 
> > 
> > base-commit: 69e858e0b8b2ea07759e995aa383e8780d9d140c
> > -- 
> > 2.48.1
> > 
> 
