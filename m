Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263241F12E0
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152753; cv=none; b=L4EhYU+wc34SzlJLGsXn75WNdPA+FuNdY+3QoUigk4nkkPavdPN1us5yRgLYEz3Y5U2nqbhHdi6Xfd4kcBJpZgwojDo7ABtxFBzixu7yGR9ErKVJDTps1n826XXEoBnj1FHyjKlQhaGFhCmPkSCnfv9CLmPme/krOR4ZbV/mlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152753; c=relaxed/simple;
	bh=wQuYZonEityn8PlExbzzBrW46hHoaJy6JwsTaQiJkyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kog3XAQb7pRKiFQbmJzE49APs61b/zV0mqeq/YJDDmTzXwlPdGmp13OA/ni8LdoBvGsK5YsHsNodx8L3vH7MnKcpNTPsIKthHduhBTI7n4nY2JSJtqhbBHDGz/3Nly+MzP1BIeqRzkT4xdQ7SLmABmhQXNbcxwKDMpu5rvgezY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RStWDGb2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RStWDGb2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4377174e1ebso1621760f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152750; x=1771757550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZI0LjX6XMnvD2HmZqsxyHHzFAJmwROlDjLzHkLvEUk=;
        b=RStWDGb2oYBRKhQ7WYujNb5AIMA7kPvyYVKAKJZx1Ps061Afat+a6qC0whPI0Npctt
         pQWLfReKYMhHbNx21dpmgqmwDhs/LYJR68MK7c3OqIzubG17gdqr2Jh85WbYhKyQZaqb
         HMdBql8EwvM/fw2M3hobFrc14Ynryov2WDtRtb7LEd9ft1XbL/HkFGVIKKMe4VVa7Yo1
         lvmq8tFzEtm7EuqeSr1UhShzbwXGbkQ+HhAYA8WaPP4NkPY5Nx2qFaamjZWX8Jyjugeu
         6TVmgQAX4jUdoWRJky2XRWkgP8dwEDPaBXW2cXkwbXb1ZqdiVDouRctL2AeVK4/Syqlq
         fEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152750; x=1771757550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZI0LjX6XMnvD2HmZqsxyHHzFAJmwROlDjLzHkLvEUk=;
        b=HaRuocEScAliLk6g0JA+y/qmE1QBdSQXjsE1Y+f80H2O8Bw/xx2y4rK9P9f/JeaPkR
         ybZwJqJoBRvmJ6PItOlDfiOgqyuPJkieJxHdKRj8VpMcTEnaqG/tBrSBXQV1I6wu9CcB
         I2l+QTCCW25WiR1AZuKXHu5HsjhXqA9CsQIDMrO7epZyYQRtOOXuf5jCO/HKOdfRSI1u
         nSzaQJ24jY/FXYeIG3QYv0ZI/xgRz7Lo2LZYMrQa89yiHlCYFyxjHZfo2SLM7t8Ynod4
         XBiTPJ+RmQVssqYKM8I4RBtY1c8VEMC/0T9ukxW5duhrpq+u28IHxvS/6wdVgpVNBWRs
         yOsg==
X-Forwarded-Encrypted: i=1; AJvYcCUzkMiqTmVD1q/xSOvvKNqdzsqEssY3uauv6sQR3yi/uBe9oCTjJWxo4fNWpJs2QUy62R/tU0UzL+sdRRAHWGcsoElJyjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Hu8gjs7Z3kraslYNWopuukQP6DehxGCeJYUpzUPipL3kygJ1
	Guann52BCBB0Vp2SfdzfrUjbaX/9ivx3eHTkxW+pH+0JKmFWNF4Wyx8Z
X-Gm-Gg: AZuq6aKgJr1YwqV8vFjpEtrFWsxwADXAgYHTj5mrtNbVC43c1Z+8Gh3coPCShn1KrMg
	3ZSSyHcL9n8M2N1/2CsT4Pv21BiX2LwTsEGhmnEeVNpO7XKzSZVAoprTcMsYH/370O7URuFN20S
	dmiDzb4ARvPWh+QBUsGgcQV97RqGuz7MdqaIu5WLLh5yIer7hG2cRMR/1El9iHv3U4EyGovnzJo
	q1TkAKTHID3F6fzJ9fofsViQ2r1KLYvCHdoaGB70kh/8mbKnZVptnkYbWcmmDxKrHbPjxBXzjG9
	Ngfj8+zSehaXlCxg+/kE3yJFZD+zoabD2QvRIV2vP27umFjwJk+b+MrBVvuudWZwRIc8x+OcP1W
	c9vZtRFjDa4yVL3ev2GhCIeXeOqFoonh5wB28Gur7Az0XfWII1GDg79iyt6bbWRDH8fBETpJwKm
	N8MszUujC5EW3ydyoxOQGCpVLJfHOruKr215NxEgkg6G0FLd0edPzCI1mfGDo=
X-Received: by 2002:a05:6000:1447:b0:436:42cc:25ef with SMTP id ffacd0b85a97d-437978c19a0mr12316116f8f.13.1771152750163;
        Sun, 15 Feb 2026 02:52:30 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm16733231f8f.7.2026.02.15.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:29 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>,
	"Paul Moore" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v5 0/9] landlock: UNIX connect() control by pathname and scope
Date: Sun, 15 Feb 2026 11:51:48 +0100
Message-ID: <20260215105158.28132-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch set introduces a filesystem-based Landlock restriction
mechanism for connecting to UNIX domain sockets (or addressing them
with sendmsg(2)).  It introduces the filesystem access right
LANDLOCK_ACCESS_FS_RESOLVE_UNIX.

For the connection-oriented SOCK_STREAM and SOCK_SEQPACKET type
sockets, the access right makes the connect(2) operation fail with
EACCES, if denied.

SOCK_DGRAM-type UNIX sockets can be used both with connect(2), or by
passing an explicit recipient address with every sendmsg(2)
invocation.  In the latter case, the Landlock check is done when an
explicit recipient address is passed to sendmsg(2) and can make
sendmsg(2) return EACCES.  When UNIX datagram sockets are connected
with connect(2), a fixed recipient address is associated with the
socket and the check happens during connect(2) and may return EACCES.

When LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled within a Landlock
domain, this domain will only allow connect(2) and sendmsg(2) to
server sockets that were created within the same domain.  Or, to
phrase it the other way around: Unless it is allow-listed with a
LANDLOCK_PATH_BENEATH rule, the newly created domain denies connect(2)
and sendmsg(2) actions that are directed *outwards* of that domain.
In that regard, LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics
as one of the "scoped" access rights.

== Motivation

Currently, landlocked processes can connect to named UNIX sockets
through the BSD socket API described in unix(7), by invoking socket(2)
followed by connect(2) with a suitable struct sockname_un holding the
socket's filename.  This is a surprising gap in Landlock's sandboxing
capabilities for users (e.g. in [1]) and it can be used to escape a
sandbox when a Unix service offers command execution (various such
scenarios were listed by Tingmao Wang in [2]).

The original feature request is at [4].

== Alternatives and Related Work

=== Alternative: Use existing LSM hooks

We have carefully and seriously considered the use of existing LSM
hooks, but still came to the conclusion that a new LSM hook is better
suited in this case:

The existing hooks security_unix_stream_connect(),
security_unix_may_send() and security_socket_connect() do not give
access to the resolved filesystem path.

* Resolving the filesystem path in the struct sockaddr_un again within
  a Landlock would produce a TOCTOU race, so this is not an option.
* We would therefore need to wire through the resolved struct path
  from unix_find_bsd() to one of the existing LSM hooks which get
  called later.  This would be a more substantial change to af_unix.c.

The struct path that is available in the listening-side struct sock is
can be read through the existing hooks, but it is not an option to use
this information: As the listening socket may have been bound from
within a different namespace, the path that was used for that can is
in the general case not meaningful for a sandboxed process.  In
particular, it is not possible to use this path (or prefixes thereof)
when constructing a sandbox policy in the client-side process.

Paul Moore also chimed in in support of adding a new hook, with the
rationale that the simplest change to the LSM hook interface has
traditionally proven to be the most robust. [11]

More details are on the Github issue at [6] and on the LKML at [9].

In a the discussion of the V2 review, started by Christian Brauner
[10], we have further explored the approach of reusing the existing
LSM hooks but still ended up leaning on the side of introducing a new
hook, with Paul Moore and me (gnoack) arguing for that option.

Further insights about the LSM hook were shared in the V3 review by
Tingmao Wang [12], who spotted additional requirements due to the two
approaches being merged into one patch set.  The summary of that
discussion is in [13].

=== Related work: Scope Control for Pathname Unix Sockets

The motivation for this patch is the same as in Tingmao Wang's patch
set for "scoped" control for pathname Unix sockets [2], originally
proposed in the Github feature request [5].

In [14], we have settled on the decision to merge the two patch sets
into this one, whose primary way of controlling connect(2) is
LANDLOCK_ACCESS_FS_RESOLVE_UNIX, but where this flag additionally has
the semantics of only restricting this unix(7) IPC *outwards* of the
created Landlock domain, in line with the logic that exists for the
existing "scoped" flags already.

By having LANDLOCK_ACCESS_FS_RESOLVE_UNIX implement "scoping"
semantics, we can avoid introducing two separate interacting flags for
now, but we retain the option of introducing
LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET at a later point in time, should
such a flag be needed to express additional rules.

== Credits

The feature was originally suggested by Jann Horn in [7].

Tingmao Wang and Demi Marie Obenour have taken the initiative to
revive this discussion again in [1], [4] and [5].

Tingmao Wang has sent the patch set for the scoped access control for
pathname Unix sockets [2] and has contributed substantial insights
during the code review, shaping the form of the LSM hook and agreeing
to merge the pathname and scoped-flag patch sets.

Justin Suess has sent the patch for the LSM hook in [8] and
subsequently through this patch set.

Christian Brauner and Paul Moore have contributed to the design of the
new LSM hook, discussing the tradeoffs in [10].

Ryan Sullivan has started on an initial implementation and has brought
up relevant discussion points on the Github issue at [4].

As maintainer of Landlock, Mickaël Salaün has done the main review so
far and particularly pointed out ways in which the UNIX connect()
patch sets interact with each other and what we need to look for with
regards to UAPI consistency as Landlock evolves.

[1] https://lore.kernel.org/landlock/515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com/
[2] Tingmao Wang's "Implement scope control for pathname Unix sockets"
    https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
[3] https://lore.kernel.org/all/20251230.bcae69888454@gnoack.org/
[4] Github issue for FS-based control for named Unix sockets:
    https://github.com/landlock-lsm/linux/issues/36
[5] Github issue for scope-based restriction of named Unix sockets:
    https://github.com/landlock-lsm/linux/issues/51
[6] https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
[7] https://lore.kernel.org/linux-security-module/CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com/
[8] Patch for the LSM hook:
    https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/
[9] https://lore.kernel.org/all/20260108.64bd7391e1ae@gnoack.org/
[10] https://lore.kernel.org/all/20260113-kerngesund-etage-86de4a21da24@brauner/
[11] https://lore.kernel.org/all/CAHC9VhQHZCe0LMx4xzSo-h1SWY489U4frKYnxu4YVrcJN3x7nA@mail.gmail.com/
[12] https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/
[13] https://lore.kernel.org/all/aYMenaSmBkAsFowd@google.com/
[14] https://lore.kernel.org/all/20260205.Kiech3gupee1@digikod.net/

---

== Patch set history

V1: https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20260110143300.71048-2-gnoack3000@gmail.com/
V3: https://lore.kernel.org/all/20260119203457.97676-2-gnoack3000@gmail.com/
V4: https://lore.kernel.org/all/20260208231017.114343-1-gnoack3000@gmail.com/

Changes in V5:

This change primarily adds tests, changing the testing approach for
the main test to use the scoped_domains fixture as in Tingmao's patch
set [2], and adding tests for the audit and coredump cases.

* Selftests:
  * Replaced the main selftest with one based on scoped_domains
  * Added audit test
  * Added test for the coredump case
  * Added a follow-up commit that simplifies ruleset enforcement
* Kernel code:
  * Mark coredump check as unlikely (per Justin's review)
  * Drop check for socket type (per Mickaël's review)

Changes in V4:

Since this version, this patch set subsumes the scoping semantics from
Tingmao Wang's "Scope Control" patch set [2], per discussion with
Tingmao Wang and Mickaël Salaün in [14] and in the thread leading up
to it.

Now, LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET only restricts connect(2) and
sendmsg(2) *outwards* of the domain where it is restricted, *with the
same semantics as a "scoped" flag*.

 * Implement a layer-mask based version of domain_is_scoped():
   unmask_scoped_access().  Rationale: domain_is_scoped() returns
   early, which we can't do in the layer masks based variant.  The two
   variants are similar enough.
 * LSM hook: Replace 'type' argument with 'sk' argument,
   per discussion in [12] and [13].
 * Bump ABI version to 9 (pessimistically assuming that we won't make
   it for 7.0)
 * Documentation fixes in header file and in Documentation/
 * selftests: more test variants, now also parameterizing whether the
   server socket gets created within the Landlock domain or before that
 * selftests: use EXPECT_EQ() for test cleanup

Changes in V3:
 * LSM hook: rename it to security_unix_find() (Justin Suess)
   (resolving the previously open question about the LSM hook name)
   Related discussions:
   https://lore.kernel.org/all/20260112.Wufar9coosoo@digikod.net/
   https://lore.kernel.org/all/CAHC9VhSRiHwLEWfFkQdPEwgB4AXKbXzw_+3u=9hPpvUTnu02Bg@mail.gmail.com/
 * Reunite the three UNIX resolving access rights back into one
   (resolving the previously open question about the access right
   structuring) Related discussion:
   https://lore.kernel.org/all/20260112.Wufar9coosoo@digikod.net/)
 * Sample tool: Add new UNIX lookup access rights to ACCESS_FILE

Changes in V2:
 * Send Justin Suess's LSM hook patch together with the Landlock
   implementation
 * LSM hook: Pass type and flags parameters to the hook, to make the
   access right more generally usable across LSMs, per suggestion from
   Paul Moore (Implemented by Justin)
 * Split the access right into the three types of UNIX domain sockets:
   SOCK_STREAM, SOCK_DGRAM and SOCK_SEQPACKET.
 * selftests: More exhaustive tests.
 * Removed a minor commit from V1 which adds a missing close(fd) to a
   test (it is already in the mic-next branch)

Günther Noack (8):
  landlock: Control pathname UNIX domain socket resolution by path
  samples/landlock: Add support for named UNIX domain socket
    restrictions
  landlock/selftests: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  landlock/selftests: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  landlock/selftests: Check that coredump sockets stay unrestricted
  landlock/selftests: fs_test: Simplify ruleset creation and enforcement
  landlock: Document FS access right for pathname UNIX sockets
  landlock: Document design rationale for scoped access rights

Justin Suess (1):
  lsm: Add LSM hook security_unix_find

 Documentation/security/landlock.rst          |   38 +
 Documentation/userspace-api/landlock.rst     |   16 +-
 include/linux/lsm_hook_defs.h                |    5 +
 include/linux/security.h                     |   11 +
 include/uapi/linux/landlock.h                |   10 +
 net/unix/af_unix.c                           |    8 +
 samples/landlock/sandboxer.c                 |   15 +-
 security/landlock/access.h                   |   11 +-
 security/landlock/audit.c                    |    1 +
 security/landlock/fs.c                       |  102 +-
 security/landlock/limits.h                   |    2 +-
 security/landlock/syscalls.c                 |    2 +-
 security/security.c                          |   20 +
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/fs_test.c   | 1301 ++++++++++--------
 15 files changed, 942 insertions(+), 602 deletions(-)

-- 
2.52.0

