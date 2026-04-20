Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9D35F18F
	for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697603; cv=none; b=AigpNcEmZRU2aj/QZScnStVtMXpzX6ddnvsBJ5iqv4YKgFbvMYvtNU5H5ROk7NQ72dXN/oYCo/2vnMJHsUArjuCNFgGbXC0iH8sSjpJdK6ZFAmXcW1iXLcGdpW9TfkT33QN8TPxVp6m/tnvJDxCbA8w8qlIQQWwEBzNaLyWuGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697603; c=relaxed/simple;
	bh=LRjEwHW7zD5Q32957gtwpXILq8M118wzPW1fnBTCSZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz23dWwGCOrn8PERmVPBGsmwkV/Yet8KbHLV45qODed1lUAZ7DxfBU26m0gsRjVLIVxOH+10tTyivudMFuPOb6QQ3H69oIu1GL1pYRzrocsyD/6bKJA7ewn8WmS5jMsmj9JrEimA1D7Q99ORmPs9YE3LZ/Z2Yt7MaI7U3mN75+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGklSX5C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGklSX5C"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so563434166b.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697599; x=1777302399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yhdlhUK19Vk8JRVgTy/e3sNLolS2Bic7wgwwPDzPJt4=;
        b=YGklSX5CQ8blxNa4fTpy+bo+DwV6cV0JM+mVQK8k5Qb7CuklKTGdLdT2pa5/sYu2PL
         yzh9nB3gsDHEV+my0ezNnV5GJ7Uw2zmJYBzNqhjMECWvnEQWS96W2LbZCBUQWuzcHFmi
         QzyHd1WozEwJlhrUzjDHA5K36BQPToZ1Etzc5tM0/TYvAilXLij8on7xV42g26vfLRa+
         8dfjzcFODcxQLruJdh5vphcz1mbK4GBzMMPlCvUFyt0E6Whn3o0JUCWFQiIf4Tj4ruOo
         2dnvCFT9V2vd5qaJbdqc9kamKuHQorGIknuJh2v2uo0uR4+k866yLWMqWDNjrifd+3m3
         DpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697599; x=1777302399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhdlhUK19Vk8JRVgTy/e3sNLolS2Bic7wgwwPDzPJt4=;
        b=Fy9q8dVMMlMhcygltQPbjducAS88MPZOXxL2uWfEWhad5JCaM5c+TAqL4qnD7DtS4N
         uyPyDzM+fMMBZsk9w18rRL9WiEXspek/h0zNEVAQF3jR85/TX4iuRq64kJV7jL6LScHX
         sZg8bl7XSLlSVtK4/BC8xKSWWnY3IB0p6/SSNWnNj3uwaqHT63vrp7cursTPqwmtiVxz
         ILLHbxZm9isI+pAC+rUUpP+QeKuRceV02yJTBvBL3+HeRFs0rmwDHzY66SwT00/rB3Pi
         G5oOLE3Vy1fzCtpKLre14cGqhMmyoUwbiKQOL5dvPRJWFtORmUNVsy/3NjNOR+j3E2WR
         Ozrw==
X-Forwarded-Encrypted: i=1; AFNElJ+wlp6iEFjdBMWvQGPjA26aCzmh1TC5tcvNjpq67Z9CamH4JKMHwvbKWltTM7XKxJqtujR+xhdQPiEyiP1GmY+FKJRfyts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uaw8cZwzwmhip7b2NTowIP3XZe1vm+fqe6Dfa47RBTPOOZwY
	ox7enFBuD+R5i6CmzeUhV6Jgqa1Qfgn7M5rm/Ug/aagqz8zi7FFDL16R
X-Gm-Gg: AeBDievua8s7GsM9RNSkVwqte1DrJf6vOksk+PWyeZ1NaU4EOJnLInPSdjBVditOhc2
	4adjlKAyu7ytI8xuEu2bPztE3DmfMkB06z90xDSdLUzZW19TQb/JbKvKfJHMIAOLHtXrzvGnpKG
	Y1qDyq20xIkfLARiScyCS+evNBSQ72lRG6BRXXm0DmsYyscdyMvTZZh+ZDP5MVLxkk1FZr38iG9
	qUvAdaNwJ82Kfwgy4xAntPs+gynU5LGCh2DsV55RmOwMa6m3p6IiYlT1Sky/FY5pM8a8HvOMe/o
	/+D133gIsyzjVVygUkb1LS7nRpfG4lfOBmFDJK52ORwzpJnIMcrJjtzKSay6WeRGSLfAtlCMvoX
	bq4hzlPAO/OTbWNR4kzG4teHB/BMWzLRJIDqZChiH7WUB1W/k3Y7FzUbQitmMYSvs67lPMLU63K
	k2N3NX+JEy9R/JIQ5umx4BRm0qEr0qjBPb9rpJ4yU3eKoZONLjMmHlP0Bk2to=
X-Received: by 2002:a17:907:b815:b0:b9d:3b68:954c with SMTP id a640c23a62f3a-ba41a044056mr632325066b.24.1776697598916;
        Mon, 20 Apr 2026 08:06:38 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm33337490f8f.29.2026.04.20.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:06:38 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:06:32 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/11] Landlock: Namespace and capability control
Message-ID: <20260420.aaab9bf39ef8@gnoack.org>
References: <20260312100444.2609563-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>

Hello!

On Thu, Mar 12, 2026 at 11:04:33AM +0100, Mickaël Salaün wrote:
> Namespaces are a fundamental building block for containers and
> application sandboxes, but user namespace creation significantly widens
> the kernel attack surface.  CVE-2022-0185 (filesystem mount parsing),
> CVE-2022-25636 and CVE-2023-32233 (netfilter), and CVE-2022-0492 (cgroup
> v1 release_agent) all demonstrate vulnerabilities exploitable only
> through capabilities gained via user namespaces.  Some distributions
> block user namespace creation entirely, but this removes a useful
> isolation primitive.  Fine-grained control allows trusted programs to
> use namespaces while preventing unnecessary exposure for programs that
> do not need them.
> 
> Existing mechanisms (user.max_*_namespaces sysctls, userns_create LSM
> hook, PR_SET_NO_NEW_PRIVS, and capset) each address part of this threat
> but none provides per-process, fine-grained control over both namespace
> types and capabilities.  Container runtimes resort to seccomp-based
> clone/unshare filtering, but seccomp cannot dereference clone3's flag
> structure, forcing runtimes to block clone3 entirely.
> 
> Landlock's composable layer model enables several patterns: a user
> session manager can restrict namespace types and capabilities broadly
> while allowing trusted programs to create the namespaces they need, and
> each deeper layer can further restrict the allowed set.  Container
> runtimes can similarly deny namespace creation inside managed
> containers.

I assume we are talking about an unrestricted systemd user session
manager, which would not itself be restricted?  (If the entire user
session were running under Landlock, users couldn't change their
passwords with "passwd" any more, because of the no_new_privs
requirement.)


> This series adds two new permission categories to Landlock:
> 
> - LANDLOCK_PERM_NAMESPACE_ENTER: Restricts which namespace types a
>   sandboxed process can acquire: both creation (unshare/clone) and entry
>   (setns).  User namespace creation has no capability check in the
>   kernel, so this is the only enforcement mechanism for that entry
>   point.
> 
> - LANDLOCK_PERM_CAPABILITY_USE: Restricts which Linux capabilities a
>   sandboxed process can use, regardless of how they were obtained
>   (including through user namespace creation).

Given that you already went through multiple iterations here, I fully
expect that I am overlooking something here, but based on the
explanation, it's not clear to me why the capability control is needed
in addition to the namespace control, to reduce the kernel attack
surface.

In my understanding the "attack surface" problem with user namespaces
is that they allow unprivileged processes to gain CAP_SYS_ADMIN within
that namespace, which unlocks access to code paths which were
traditionally reserved for the (top level) root user.

But then, to prevent that from happening, it seems that restricting
access to user namespace creation would be sufficient?

(Also, in some cases, I suspect it might be possible to break
assumptions that more privileged processes make about filesystem
layout if the user can change the mount layout.  But that is not an
issue with Landlock, as we forbid changes to mounts and also require
no_new_privs.)


> Both use new handled_perm and LANDLOCK_RULE_* constants following the
> existing allow-list model.  The UAPI uses raw CAP_* and CLONE_NEW*
> values directly; unknown values are silently accepted for forward
> compatibility (the allow-list denies them by default).  The Landlock ABI
> version is bumped from 8 to 9.

Compatibility question:

For both permission categories, when they are "handled" in the
ruleset, they default to denying *all* types of namespaces, and *all*
types of capabilities.

This is different to the handled_access_* rights, where we are
requiring users to explicitly list all restricted rights as "handled",
because the full list of available operations might be a moving
target.

Why is this not a problem for capabilities and for namespaces?  Both
the list of capabilities and the list of namespaces has been expanded
in the past.  What happens if a new capability or namespace is
invented?  If these are evolved, is that backwards compatible for the
existing users of these Landlock permission categories?


> The handled_perm infrastructure is designed to be reusable by future
> permission categories.  The last patch documents the design rationale
> for the permission model and the criteria for choosing between
> handled_access_*, handled_perm, and scoped.  A patch series to add
> socket creation control is under review [2]; it could benefit from the
> same permission model to achieve complete deny-by-default coverage of
> socket creation.
> 
> This series builds on Christian Brauner's namespace LSM blob RFC [1],
> included as patch 1.
> 
> Christian, could you please review patch 3?  It adds a FOR_EACH_NS_TYPE
> X-macro to ns_common_types.h and derives CLONE_NS_ALL, replacing inline
> CLONE_NEW* flag enumerations in nsproxy.c and fork.c.
> 
> Paul, could you please review patch 2?  It adds LSM_AUDIT_DATA_NS, a new
> audit record type that logs namespace_type and inum for
> namespace-related LSM denials.
> 
> All four example vulnerabilities follow the same pattern: an
> unprivileged user creates a user namespace to obtain capabilities, then
> creates a second namespace to exercise them against vulnerable code.
> LANDLOCK_PERM_NAMESPACE_ENTER prevents this by denying the user
> namespace (eliminating the capability grant) or the specific namespace
> type needed to exercise it.  LANDLOCK_PERM_CAPABILITY_USE independently
> prevents it by denying the required capability.

Here, it is also not clear to me why LANDLOCK_PERM_CAPABILITY_USE is
needed in addition to LANDLOCK_PERM_NAMESPACE_ENTER.

Looking at capabilities(7), my understanding is that capabilities can
only be acquired through:

(1) user namespaces (prevented with LANDLOCK_PERM_NAMESPACE_ENTER)
(2) execve (setuid or individual capabilities, prevented using
    PR_SET_NO_NEW_PRIVS)

...so if a process were to start out with no such capabilities,
wouldn't that be enough to prevent it from gaining more?  Am I
overlooking another way through which these can be acquired?

The Landlock capability support adds a "filter" for the use of
capabilities, but my understanding of the capability system was that
it already *is* that filter.  As long as we prevent the acquisition of
new capabilities, shouldn't that be sufficient?


> Namespace restriction is enforced at two hook sites: namespace_alloc
> (unshare/clone) and namespace_install (setns).  Together, these ensure a
> process denied a namespace type cannot circumvent the restriction by
> entering a pre-existing namespace via setns() on an inherited or passed
> file descriptor.  When a domain handles both permissions, both must
> independently allow the operation (e.g., unshare(CLONE_NEWNET) requires
> both CAP_SYS_ADMIN to be allowed and CLONE_NEWNET to be allowed).
> 
> Design evolution:
> 
> The first approach added CAP_OPT flags to security_capable() to
> distinguish namespace creation contexts.  This was too invasive and
> would have required capability splitting (a dedicated CAP_NAMESPACE)
> which does not help because the CAP_SYS_ADMIN fallback for backward
> compatibility undermines the distinction.
> 
> The second stored the namespace creator's domain in the LSM blob and
> used domain ancestry comparison in hook_capable() to bypass capability
> checks for namespace management operations.  A SCOPE_NAMESPACE flag
> restricted setns() by the namespace creator's domain, like SCOPE_SIGNAL.
> Both were dropped: scopes should only concern Landlock properties
> (domain relationships), not kernel namespace state; and the
> cross-namespace heuristic (ns != cred->user_ns) did not accurately
> identify namespace management operations.
> 
> The final design drops all of this.  The key insight is that
> capabilities gained through user namespace creation are only exercisable
> against namespaces of a specific type: creating a network namespace is
> what makes CAP_NET_ADMIN exercisable.  LANDLOCK_PERM_NAMESPACE_ENTER
> controls where capabilities are exercisable by restricting which
> namespace types can be acquired.  LANDLOCK_PERM_CAPABILITY_USE controls
> which capabilities are available, as a pure per-layer bitmask check with
> no namespace awareness.  The two are independently enforced at their own
> hook sites, with no interaction in hook_capable().  No scope flag is
> added in this series.
> 
> Note that when Landlock filesystem restrictions are in use, mount
> namespace creation has an inherent limitation: all mount topology
> changes are denied when any filesystem right is handled, which is
> optional.  A dedicated mount access control type is left for future work
> [3].
> 
> https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org [1]
> https://lore.kernel.org/r/20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com [2]
> https://github.com/landlock-lsm/linux/issues/14 [3]
> 
> Christian Brauner (1):
>   security: add LSM blob and hooks for namespaces
> 
> Mickaël Salaün (10):
>   security: Add LSM_AUDIT_DATA_NS for namespace audit records
>   nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL
>   landlock: Wrap per-layer access masks in struct layer_rights
>   landlock: Enforce namespace entry restrictions
>   landlock: Enforce capability restrictions
>   selftests/landlock: Drain stale audit records on init
>   selftests/landlock: Add namespace restriction tests
>   selftests/landlock: Add capability restriction tests
>   samples/landlock: Add capability and namespace restriction support
>   landlock: Add documentation for capability and namespace restrictions
> 
>  Documentation/admin-guide/LSM/landlock.rst    |   19 +-
>  Documentation/security/landlock.rst           |   80 +-
>  Documentation/userspace-api/landlock.rst      |  156 +-
>  include/linux/lsm_audit.h                     |    5 +
>  include/linux/lsm_hook_defs.h                 |    3 +
>  include/linux/lsm_hooks.h                     |    1 +
>  include/linux/ns/ns_common_types.h            |   47 +-
>  include/linux/security.h                      |   20 +
>  include/uapi/linux/landlock.h                 |   89 +-
>  kernel/fork.c                                 |    7 +-
>  kernel/nscommon.c                             |   12 +
>  kernel/nsproxy.c                              |   21 +-
>  samples/landlock/sandboxer.c                  |  164 +-
>  security/landlock/Makefile                    |    2 +
>  security/landlock/access.h                    |   72 +-
>  security/landlock/audit.c                     |    8 +
>  security/landlock/audit.h                     |    2 +
>  security/landlock/cap.c                       |  142 ++
>  security/landlock/cap.h                       |   49 +
>  security/landlock/cred.h                      |   47 +-
>  security/landlock/limits.h                    |    9 +
>  security/landlock/ns.c                        |  188 +++
>  security/landlock/ns.h                        |   74 +
>  security/landlock/ruleset.c                   |   23 +-
>  security/landlock/ruleset.h                   |   53 +-
>  security/landlock/setup.c                     |    4 +
>  security/landlock/syscalls.c                  |  124 +-
>  security/lsm_audit.c                          |    4 +
>  security/lsm_init.c                           |    2 +
>  security/security.c                           |   76 +
>  tools/testing/selftests/landlock/audit.h      |   29 +-
>  tools/testing/selftests/landlock/audit_test.c |    2 -
>  tools/testing/selftests/landlock/base_test.c  |   20 +-
>  tools/testing/selftests/landlock/cap_test.c   |  614 ++++++++
>  tools/testing/selftests/landlock/common.h     |   23 +
>  tools/testing/selftests/landlock/config       |    5 +
>  tools/testing/selftests/landlock/ns_test.c    | 1379 +++++++++++++++++
>  tools/testing/selftests/landlock/wrappers.h   |    6 +
>  38 files changed, 3487 insertions(+), 94 deletions(-)
>  create mode 100644 security/landlock/cap.c
>  create mode 100644 security/landlock/cap.h
>  create mode 100644 security/landlock/ns.c
>  create mode 100644 security/landlock/ns.h
>  create mode 100644 tools/testing/selftests/landlock/cap_test.c
>  create mode 100644 tools/testing/selftests/landlock/ns_test.c
> 
> 
> base-commit: 5dfb8077be2bbe2c3b9477da759e80fa9f98da42
> -- 
> 2.53.0
> 

FWIW, I have also skimmed through some of the code and documentation
and the code seemed very clean so far.

–Günther
