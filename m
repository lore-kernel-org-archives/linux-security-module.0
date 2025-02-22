Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C013B58A;
	Sat, 22 Feb 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740253683; cv=none; b=jkd2E1zMAAYTie6GCqNFbFIKCJxQkdQ9wK4gPEHZEOQCfyE9Y+C5msUtLx55YAB28se3F8j5gEiKXjTo1RIUanWHK8jBOyxz8s2kA0ls0TQDaUdZdl/UcLxLBhX0kUHVZU+QNHhNiBCFpK4pZ/6ObZmN0zQSopjnzNhiDFL4pyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740253683; c=relaxed/simple;
	bh=GSSL9WURNukCtmHPIvrJndVUgEqS+IurAIIg+d+KSn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T49IznPf2u+ZeSm80kWE5o8FzunmyQ8El8PRGW7il8DzqJ0lgtPTkb1CWRq9ZrcvsceapauNwEoo6pzGrruIEC5wVc9Lq4e+qG7jayXbRuKlr6BT2h0c8qlRytxiBxbtNgLQr6S4wE0Tn27DFMz9wUQzkk+m9wYqLxozlWoYKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY7d6xT+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY7d6xT+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f22fe889aso2726941f8f.3;
        Sat, 22 Feb 2025 11:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740253680; x=1740858480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k74eRZ9dzu/ozgkVvl8FCs1arPr3tSEztc+1v3LM2i8=;
        b=eY7d6xT+ysEvRMa5NEWj3PtwsTk3pEBnWFkLpwAUpQ0juQ3/xVroYUdSQaUsJGIQXC
         UcKzmr0hWJIkWoPwhsha6ZjEM3Kv1jgcTcDzYmvOXBPwubG+Czsp0jE3GQzN/CgOLmJ+
         NvutA5dUHckwp+k8mdv6Ibgi4ZDH6rgefNOnBa4/rGmhZfeYYOmoHqn5WIM8nxkazDau
         VkwkeSujfIDNF7FTalkzoALcxZfq0GJ7P05iBjvA/ciAlUtGXg3MpUIovsLAZQd0+fhD
         ZdUKeiM1hbeHrDi8YX+yo6BlxWvYGBQGdE9/g8JBOHNulDp1DEsO6JPq9/rRdfzbvfue
         yxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740253680; x=1740858480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k74eRZ9dzu/ozgkVvl8FCs1arPr3tSEztc+1v3LM2i8=;
        b=OnEhY/LdO3TQhOwvJ73G2DVMzXA0OekBaaBaGrWwZBRGo4cirgw6n3tm0DiS7Xt9q1
         usIcjowP3IAyB04zUGFn97JD/RDdRrviUrMwjRCRonSCe7Pi5QpNEsKxCvoY7Ge5CUny
         fIt02O6vWumINKkWeL+9pgfEmCdxZMGSe/PckE2xgbthfIlxO7dUg/ZmGqYG+jVh0tAa
         n8iFaKv5X/25ZxGkj/zpdIPJQxcphXQB440va+qulbNP5kaBWLW/xs+8Tj2hqCWCsJE+
         sxrhpPzbvSt3SEN043CmKB8XRDjdPDrDfNhAc83OH13Gq7l+49+1MoUXBU7IaAJWclaW
         iqBw==
X-Forwarded-Encrypted: i=1; AJvYcCVqq+35NuwYmU0olxBfrklsB/5ws+O0KKEGP21zFXzDJfJH+4HrCJkuwHgyzCWgUO61PF7AEg==@vger.kernel.org, AJvYcCWgKiL3vbRsU9gOA7W6fSk53bfWm1muXbDualyzZe3aCFy00MdHrvt3ZGOBX6mNXMkKmReaW7QaH4X89Fti@vger.kernel.org, AJvYcCXOJsD6XTunKATx16sQwr7ApqJc7XH8V7wMA+l8eru5+tWHX22bKH3HQ5Qjme77W9owwfbfhyFdSIPI9zfdKA3kZ/88Njam@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxfnT+mybfwr0192nsEYu10ZIDo7b8+GmezSEM/dx+m7EE7e/
	xW/DJKC43xvyke9dHMjlFKQh9BA/GkYl+PTqrwu0o+cRZneE/4JD
X-Gm-Gg: ASbGncsLsW6M+XCwGdk2HOrII5aUdfar5Pmy2WhyM5cB5b5rSNAc2jv5cylafzJuto6
	n1dDlQOVN4WVYF/Jf/wLUfqJBk8YssbHr65UcJYW8tsedBrmzAIbusALlBUC36W+OMYy07kEEBv
	EX3a7yZtGT9LPMQeqybpZreFg40TL2ZJ7yaynWWlO4UDcth08EvYQQQPjkEuwVK1AK42MnM0lPZ
	h68MgFZOecMcfJJdlYnqOXvsrtyg+qa9ecRSp33HSi1z52Ebe9VJ4nXGOKyHRsXwPEnjsMJs+RN
	fo+Hv5s3eMHtyPOGa6LPUh8=
X-Google-Smtp-Source: AGHT+IFXPA5CwrvBfpW+3dDuNHGyj8bPzZDVesd+4AvKSUQ7qkBsUmzvqVffkUzaZSbxeLmfG3IRew==
X-Received: by 2002:a05:6000:1842:b0:38d:af14:cb1 with SMTP id ffacd0b85a97d-38f6f0c7880mr7503792f8f.54.1740253679881;
        Sat, 22 Feb 2025 11:47:59 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258eb141sm26478829f8f.41.2025.02.22.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:47:59 -0800 (PST)
Date: Sat, 22 Feb 2025 20:47:40 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 00/24] Landlock audit support
Message-ID: <20250222.0cd761da0d19@gnoack.org>
References: <20250131163059.1139617-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>

On Fri, Jan 31, 2025 at 05:30:35PM +0100, Mickaël Salaün wrote:
> Hi,
> 
> This patch series adds audit support to Landlock.
> 
> Logging denied requests is useful for different use cases:
> - sysadmins: to look for users' issues,
> - security experts: to detect attack attempts,
> - power users: to understand denials,
> - developers: to ease sandboxing support and get feedback from users.
> 
> Because of its unprivileged nature, Landlock can compose standalone
> security policies (i.e. domains).  To make logs useful, they need to
> contain the most relevant Landlock domain that denied an action, and the
> reason of such denial.  This translates to the latest nested domain and
> the related blockers: missing access rights or other kind of
> restrictions.
> 
> # Changes from previous version
> 
> Remove the AUDIT_EXE_LANDLOCK_DENY audit rule and add 2 new
> landlock_restrict_self(2) flags to filter Landlock audit events, which
> makes 3 flags:
> - LANDLOCK_RESTRICT_SELF_QUIET: do not log any denied access because of
>   this new domain.
> - LANDLOCK_RESTRICT_SELF_QUIET_DESCENDENTS: do not log denied access
>   from child domains.
> - LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC: log denied access for processes
>   resulting from an execve(2), which is not the case by default anymore.
> 
> One patch was merged in mainline: 7ccbe076d987 ("lsm: Only build
> lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are set").
> 
> # Design
> 
> Log records are created for any denied actions caused by a Landlock
> policy, which means that a well-sandboxed applications should not log
> anything except for unattended access requests that might be the result
> of attacks or bugs.
> 
> However, sandbox tools creating restricted environments could lead to
> abundant log entries because the sandboxed processes may not be aware of
> the related restrictions.  To avoid log spam, the
> landlock_restrict_self(2) syscall gets a new
> LANDLOCK_RESTRICT_SELF_QUIET flag to not log denials related to this
> specific domain.  Except for well-understood exceptions, this flag
> should not be set.  Indeed, applications sandboxing themselves should
> only try to bypass their own sandbox if they are compromised, which
> should ring a bell thanks to log events.
> 
> When an action is denied, the related Landlock domain ID is specified.
> If this domain was not previously described in a log record, one is
> created.  This record contains the domain ID, its creation time, and
> informations about the process that enforced the restriction (at the
> time of the call to landlock_restrict_self): PID, UID, executable path,
> and name (comm).
> 
> This new approach also brings building blocks for an upcoming
> unprivileged introspection interface.  The unique Landlock IDs will be
> useful to tie audit log entries to running processes, and to get
> properties of the related Landlock domains.  This will replace the
> previously logged ruleset properties.

What implications does this patch set have for Landlock's performance?

For some aspects of Landlock domains, when domains get merged, their
rules can potentially get merged into simpler "flattened"
representations at the cost of losing track about the original domain
for individual denials.

For instance, when a process enforces the following two rulesets
nested in each other:

 * RS1 allowed to only connect to TCP ports {1, 2, 3}
 * RS2 allowed to only connect to TCP ports {2, 3, 4}

Then the resulting merged domain could build the intersection of these
two sets {2, 3}, and store a smaller set of port numbers than the two
rulesets individually.  Similar tricks would likely also be possible
for the rules for socket type restriction, as well as for
IOCTL-per-command allow-lists, if we had done that at that level of
granularity.

I realize that we are not doing this right now for ports, so it is
slightly speculative, but it would be an option in the future.
However, when we want to attribute each denial to the original domain
which caused it, that kind of optimization does not work any more.

In performance-sensitive environments that don't need Landlock
auditing, to what extent would users of such environments have to pay
a "hidden cost" of auditing because we can't do such "data structure
flattening" optimizations any more?

Do you have thoughts on how you want to strike the balance between
Landlock performance and logging accuracy?

–Günther

> # Samples
> 
> Here are two examples of log events (see serial numbers):
> 
> $ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1
> 
>   type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
>   type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"
>   type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
>   type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
>   type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f status=deallocated denials=1
> 
> $ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"
> 
>   type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
>   type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"
>   type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
>   type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
>   type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
>   type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
>   type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
>   type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 status=deallocated denials=2
> 
> # Future changes
> 
> I'll add more tests to check each kind of denied access.
> 
> # Previous versions
> 
> v4: https://lore.kernel.org/r/20250108154338.1129069-1-mic@digikod.net
> v3: https://lore.kernel.org/r/20241122143353.59367-1-mic@digikod.net
> v2: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (24):
>   lsm: Add audit_log_lsm_data() helper
>   landlock: Add unique ID generator
>   landlock: Move domain hierarchy management
>   landlock: Prepare to use credential instead of domain for filesystem
>   landlock: Prepare to use credential instead of domain for network
>   landlock: Prepare to use credential instead of domain for scope
>   landlock: Prepare to use credential instead of domain for fowner
>   landlock: Identify domain execution crossing
>   landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials
>   landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status
>   landlock: Log mount-related denials
>   landlock: Log file-related denials
>   landlock: Log truncate and IOCTL denials
>   landlock: Log TCP bind and connect denials
>   landlock: Log scoped denials
>   landlock: Add LANDLOCK_RESTRICT_SELF_QUIET
>   landlock: Add LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
>   landlock: Add LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC
>   samples/landlock: Enable users to log sandbox denials
>   selftests/landlock: Extend tests for landlock_restrict_self()'s flags
>   selftests/landlock: Add tests for audit and
>     LANDLOCK_RESTRICT_SELF_QUIET
>   selftests/landlock: Test audit with restrict flags
>   selftests/landlock: Add audit tests for ptrace
>   landlock: Add audit documentation
> 
>  Documentation/admin-guide/LSM/index.rst       |   1 +
>  Documentation/admin-guide/LSM/landlock.rst    | 157 ++++++
>  Documentation/security/landlock.rst           |   7 +
>  Documentation/userspace-api/landlock.rst      |   9 +-
>  MAINTAINERS                                   |   1 +
>  include/linux/lsm_audit.h                     |   8 +
>  include/uapi/linux/audit.h                    |   4 +-
>  include/uapi/linux/landlock.h                 |  31 ++
>  samples/landlock/sandboxer.c                  |  37 +-
>  security/landlock/.kunitconfig                |   2 +
>  security/landlock/Makefile                    |   5 +
>  security/landlock/access.h                    |  23 +
>  security/landlock/audit.c                     | 513 ++++++++++++++++++
>  security/landlock/audit.h                     |  77 +++
>  security/landlock/cred.c                      |  26 +-
>  security/landlock/cred.h                      |  65 +++
>  security/landlock/domain.c                    | 264 +++++++++
>  security/landlock/domain.h                    | 158 ++++++
>  security/landlock/fs.c                        | 279 ++++++++--
>  security/landlock/fs.h                        |  21 +-
>  security/landlock/id.c                        | 249 +++++++++
>  security/landlock/id.h                        |  25 +
>  security/landlock/limits.h                    |   4 +
>  security/landlock/net.c                       |  74 ++-
>  security/landlock/ruleset.c                   |  33 +-
>  security/landlock/ruleset.h                   |  47 +-
>  security/landlock/setup.c                     |   2 +
>  security/landlock/syscalls.c                  |  50 +-
>  security/landlock/task.c                      | 232 ++++++--
>  security/lsm_audit.c                          |  27 +-
>  tools/testing/kunit/configs/all_tests.config  |   2 +
>  tools/testing/selftests/landlock/Makefile     |   6 +-
>  tools/testing/selftests/landlock/audit.h      | 358 ++++++++++++
>  tools/testing/selftests/landlock/audit_test.c | 425 +++++++++++++++
>  tools/testing/selftests/landlock/base_test.c  |  43 +-
>  tools/testing/selftests/landlock/common.h     |   3 +
>  tools/testing/selftests/landlock/config       |   1 +
>  .../testing/selftests/landlock/ptrace_test.c  |  67 ++-
>  .../selftests/landlock/wait-pipe-sandbox.c    | 131 +++++
>  39 files changed, 3244 insertions(+), 223 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/landlock.rst
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
>  create mode 100644 security/landlock/domain.c
>  create mode 100644 security/landlock/domain.h
>  create mode 100644 security/landlock/id.c
>  create mode 100644 security/landlock/id.h
>  create mode 100644 tools/testing/selftests/landlock/audit.h
>  create mode 100644 tools/testing/selftests/landlock/audit_test.c
>  create mode 100644 tools/testing/selftests/landlock/wait-pipe-sandbox.c
> 
> 
> base-commit: 69e858e0b8b2ea07759e995aa383e8780d9d140c
> -- 
> 2.48.1
> 
