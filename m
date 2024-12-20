Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A52163B1;
	Fri, 20 Dec 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705408; cv=none; b=dhmxFeBWir/2fyzfEgVS4JLaWBy9PQJaLv5UVOqZxKBrM0zJB52/EpHkEEqxvpSYdwArIaKHpIC0hXnzxl6K4NcOWmyXDbQAEj7FZZoAe0DQRdHsgJI8CKGCg9G4isQAImndj7UmU6jlGrTlhNLqh4LW/Kq0ajtcZAQcPbJU4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705408; c=relaxed/simple;
	bh=G/oj7FC8Qun0O1fpVEDQI20+GN0l1iAqxNZdwwmdZ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSsztCS+KyGuidshr3D2huDzXObtk4ZV1/9UJzRCS2lctqPK8CFwNTTi+gQxyBJGZ4/OVugEmLYgCBFzktl0sJqh/FC2vPTuBjKspF0T3N2Jq9hSiqC46jT1O/dG+eSu4B+ygbpucFaO8giNTc8FSBCmsCDllGETjV7xfZD3Zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VUrqnv4K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VUrqnv4K"
Received: from pwmachine.localnet (230.60.66.37.rev.sfr.net [37.66.60.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB61920DF168;
	Fri, 20 Dec 2024 06:36:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB61920DF168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734705406;
	bh=nkMT909OpJbpn+Hb3NGkzcslPwAKuboOCPSYuoBxtXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUrqnv4KR8EMkO6fAwc7jAa6KhasHYKyeRLCfRw5pPDUeMfk9JkbNS+QVEKSAlYE2
	 ZaEhg7WytxNLi1zY3H/1TXM1/9XkINXOUNpPXlDuTguad78wjtWX5JmcHLBYw5OI6P
	 Bz9xqWFnvOvCYg3lLdLdfOzlJjAikCn6iHyGd7iE=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 00/23] Landlock audit support
Date: Fri, 20 Dec 2024 15:36:40 +0100
Message-ID: <3327371.aeNJFYEL58@pwmachine>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!

Le vendredi 22 novembre 2024, 15:33:30 CET Micka=EBl Sala=FCn a =E9crit :
> Hi,
>=20
> This patch series adds audit support to Landlock.
>=20
> Logging denied requests is useful for different use cases:
> - sysadmins: to look for users' issues
> - security experts: to detect attack attempts
> - power users: to understand denials
> - app developers: to ease and speed up sandboxing support
>=20
> To make logs useful, they need to contain the most relevant Landlock
> domain that denied an action, and the reason of such denial.  This
> translates to the latest nested domain and the related blockers: missing
> access rights or other kind of constraints (e.g. scoped domain).
>=20
> # Changes from previous version
>=20
> This third patch series reduces the amount of domain information
> records: instead of creating a record for a domain hierarchy, only the
> domain that denied the request is logged, which is enough.
>=20
> The log format for domain information don't include the parent anymore
> but the creation time instead, which is useful to know how old a domain
> is relative to a first denial.  We also now use hexadecimal numbers for
> domain IDs.
>=20
> Another major addition of this patch series are the new tests.  The new
> syscall flag is tested, and all the ptrace tests are extended to check
> the source of the denials (e.g. Landlock or Yama).  This greatly improve
> test consistency and I plan to extend all Landlock tests with these
> audit checks.
>=20
> The sandboxer sample is also updated to not generate logs by default.
>=20
> # Design
>=20
> Log records are created for any denied actions caused by a Landlock
> policy, which means that a well-sandboxed applications should not log
> anything except for unattended access requests that might be the result
> of attacks or bugs.
>=20
> However, sandbox tools creating restricted environments could lead to
> abundant log entries because the sandboxed processes may not be aware of
> the related restrictions.  To avoid log spam, the
> landlock_restrict_self(2) syscall gets a new
> LANDLOCK_RESTRICT_SELF_LOGLESS flag to not log denials related to this
> specific domain.  Except for well-understood exceptions, this flag
> should not be set.  Indeed, applications sandboxing themselves should
> only try to bypass their own sandbox if they are compromised, which
> should ring a bell thanks to log events.
>=20
> When an action is denied, the related Landlock domain ID is specified.
> If this domain was not previously described in a log record, one is
> created.  This record contains the domain ID, its creation time, and
> informations about the process that enforced the restriction (at the
> time of the call to landlock_restrict_self): PID, UID, executable path,
> and name (comm).
>=20
> This new approach also brings building blocks for an upcoming
> unprivileged introspection interface.  The unique Landlock IDs will be
> useful to tie audit log entries to running processes, and to get
> properties of the related Landlock domains.  This will replace the
> previously logged ruleset properties.
>=20
> # Samples
>=20
> Here are two examples of log events:
>=20
> $ LL_FS_RO=3D/ LL_FS_RW=3D/ LL_SCOPED=3Ds LL_FORCE_LOG=3D1 ./sandboxer ki=
ll 1
>=20
>   type=3DUNKNOWN[1423] msg=3Daudit(1732186800.268:30): domain=3D1a6fdc66f
> blockers=3Dscope_signal opid=3D1 ocomm=3D"systemd" type=3DUNKNOWN[1424]
> msg=3Daudit(1732186800.268:30): domain=3D1a6fdc66f creation=3D1732186800.=
264
> pid=3D286 uid=3D0 exe=3D"/root/sandboxer" comm=3D"sandboxer"UID=3D"root" =
type=3DSYSCALL
> msg=3Daudit(1732186800.268:30): arch=3Dc000003e syscall=3D62 success=3Dno=
 exit=3D-1
> [..] ppid=3D272 pid=3D286 auid=3D0 uid=3D0 gid=3D0 [...] comm=3D"kill" [.=
=2E.]
> type=3DPROCTITLE msg=3Daudit(1732186800.268:30): proctitle=3D6B696C6C0031
> type=3DUNKNOWN[1425] msg=3Daudit(1732186800.324:31): domain=3D1a6fdc66f
>=20
> $ LL_FS_RO=3D/ LL_FS_RW=3D/tmp LL_FORCE_LOG=3D1 ./sandboxer sh -c "echo >
> /etc/passwd"
>=20
>   type=3DUNKNOWN[1423] msg=3Daudit(1732186800.221:33): domain=3D1a6fdc679
> blockers=3Dfs_write_file path=3D"/dev/tty" dev=3D"devtmpfs" ino=3D9
> type=3DUNKNOWN[1424] msg=3Daudit(1732186800.221:33): domain=3D1a6fdc679
> creation=3D1732186800.221 pid=3D289 uid=3D0 exe=3D"/root/sandboxer"
> comm=3D"sandboxer"UID=3D"root" type=3DSYSCALL msg=3Daudit(1732186800.221:=
33):
> arch=3Dc000003e syscall=3D257 success=3Dno exit=3D-13 [...] ppid=3D272 pi=
d=3D289 auid=3D0
> uid=3D0 gid=3D0 [...] comm=3D"sh" [...] type=3DPROCTITLE
> msg=3Daudit(1732186800.221:33):
> proctitle=3D7368002D63006563686F203E202F6574632F706173737764
> type=3DUNKNOWN[1423] msg=3Daudit(1732186800.221:34): domain=3D1a6fdc679
> blockers=3Dfs_write_file path=3D"/etc/passwd" dev=3D"vda2" ino=3D143821
> type=3DSYSCALL msg=3Daudit(1732186800.221:34): arch=3Dc000003e syscall=3D=
257
> success=3Dno exit=3D-13 [...] ppid=3D272 pid=3D289 auid=3D0 uid=3D0 gid=
=3D0 [...]
> comm=3D"sh" [...] type=3DPROCTITLE msg=3Daudit(1732186800.221:34):
> proctitle=3D7368002D63006563686F203E202F6574632F706173737764
> type=3DUNKNOWN[1425] msg=3Daudit(1732186800.261:35): domain=3D1a6fdc679
>=20
> # Future changes
>=20
> It would be interesting to enhance audit with the ability to filter on
> the executable path that created a sandbox, or to filter on a Landlock
> domain ID.
>=20

Thank you for this series, I tested with a sandboxed program trying to=20
fstatat("/proc/1/ns/pid") and I indeed got audit logs:
root@vm-amd64:~# uname -r
6.12.0-00023-gab1009f970a0
root@vm-amd64:~# ./share/kinvolk/landlock/landlock=20
=46ailed to fstatat: Permission denied
root@vm-amd64:~# grep 'domain=3D' /var/log/audit/audit.log
type=3DUNKNOWN[1423] msg=3Daudit(1734704806.184:61): domain=3D1e925333c=20
blockers=3Dptrace opid=3D1 ocomm=3D"systemd"
type=3DUNKNOWN[1424] msg=3Daudit(1734704806.184:61): domain=3D1e925333c=20
creation=3D1734704806.184 pid=3D288 uid=3D0 exe=3D"/root/share/kinvolk/land=
lock/
landlock" comm=3D"landlock"UID=3D"root"
type=3DUNKNOWN[1425] msg=3Daudit(1734704806.191:62): domain=3D1e925333c
=20
>=20
> Previous versions:
> v1: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net
>=20
> Regards,
>=20
> Micka=EBl Sala=FCn (23):
>   lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are
>     set
>   lsm: Add audit_log_lsm_data() helper
>   landlock: Factor out check_access_path()
>   landlock: Add unique ID generator
>   landlock: Move access types
>   landlock: Simplify initially denied access rights
>   landlock: Move domain hierarchy management
>   landlock: Log ptrace denials
>   audit: Add a new audit_get_ctime() helper
>   landlock: Log domain properties and release
>   landlock: Log mount-related denials
>   landlock: Align partial refer access checks with final ones
>   selftests/landlock: Add test to check partial access in a mount tree
>   landlock: Optimize file path walks and prepare for audit support
>   landlock: Log file-related denials
>   landlock: Log truncate and ioctl denials
>   landlock: Log TCP bind and connect denials
>   landlock: Log scoped denials
>   landlock: Control log events with LANDLOCK_RESTRICT_SELF_LOGLESS
>   samples/landlock: Do not log denials from the sandboxer by default
>   selftests/landlock: Extend tests for landlock_restrict_self()'s flags
>   selftests/landlock: Add tests for audit
>   selftests/landlock: Add audit tests for ptrace
>=20
>  Documentation/userspace-api/landlock.rst      |   2 +-
>  include/linux/audit.h                         |   8 +
>  include/linux/lsm_audit.h                     |  22 +
>  include/uapi/linux/audit.h                    |   5 +-
>  include/uapi/linux/landlock.h                 |  14 +
>  kernel/auditsc.c                              |  21 +-
>  samples/landlock/sandboxer.c                  |  35 +-
>  security/Kconfig                              |   5 +
>  security/Makefile                             |   2 +-
>  security/landlock/.kunitconfig                |   2 +
>  security/landlock/Makefile                    |   2 +
>  security/landlock/access.h                    | 100 ++++
>  security/landlock/audit.c                     | 495 ++++++++++++++++++
>  security/landlock/audit.h                     |  76 +++
>  security/landlock/domain.c                    | 195 +++++++
>  security/landlock/domain.h                    | 117 +++++
>  security/landlock/fs.c                        | 279 +++++++---
>  security/landlock/fs.h                        |  10 +
>  security/landlock/id.c                        | 242 +++++++++
>  security/landlock/id.h                        |  25 +
>  security/landlock/net.c                       |  51 +-
>  security/landlock/ruleset.c                   |  35 +-
>  security/landlock/ruleset.h                   |  96 ++--
>  security/landlock/setup.c                     |   2 +
>  security/landlock/syscalls.c                  |  26 +-
>  security/landlock/task.c                      | 150 +++++-
>  security/lsm_audit.c                          |  27 +-
>  tools/testing/kunit/configs/all_tests.config  |   2 +
>  tools/testing/selftests/landlock/audit.h      | 308 +++++++++++
>  tools/testing/selftests/landlock/audit_test.c | 168 ++++++
>  tools/testing/selftests/landlock/base_test.c  |  18 +-
>  tools/testing/selftests/landlock/common.h     |   2 +
>  tools/testing/selftests/landlock/config       |   1 +
>  tools/testing/selftests/landlock/fs_test.c    |  54 +-
>  .../testing/selftests/landlock/ptrace_test.c  |  62 ++-
>  35 files changed, 2454 insertions(+), 205 deletions(-)
>  create mode 100644 security/landlock/access.h
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
>  create mode 100644 security/landlock/domain.c
>  create mode 100644 security/landlock/domain.h
>  create mode 100644 security/landlock/id.c
>  create mode 100644 security/landlock/id.h
>  create mode 100644 tools/testing/selftests/landlock/audit.h
>  create mode 100644 tools/testing/selftests/landlock/audit_test.c
>=20
>=20
> base-commit: adc218676eef25575469234709c2d87185ca223a



