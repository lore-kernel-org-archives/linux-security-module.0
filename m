Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6337207F
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379617; cv=none; b=Ga3ehErEFS9B3aE4Ot5iRXB4E0EtACTWiuI0Y7hX0tPy/aROuxHw0XruJLVvx5zthPx+o+ypmXbVD5rVlr1cyWzyhYDB0W64uCFG66Txr20vJ2jejNtHD7nXYJ4kUYXGjtE6b8TW/x9sncIVrDMwaoybMPYW8QE+FLRTBEhMjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379617; c=relaxed/simple;
	bh=khWmooEg087b7SmVBAd+sEhZEHodzQNRIpH+OOn4wi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPSd+LEVH9eoKRqKYYWMKcPzz4JGSxftlFTRV+Y3JI6GOcEOrCUd1G/ELZsRYUgNQuEgCfSc6d+R+pBj3aFxm3d2BLBX+0yrTSsUpkA1DVShhVSnwGo0HRz185WKDPsb67WQucDVonB99K+xyJ4EQyjvONM9+oxMulP068jzlYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z199oCef; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z199oCef"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so63348437b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379614; x=1779984414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7i3h7yC1z4islTPU/5JKiDY3m5Oj5w6V5X1AGvkDkc=;
        b=Z199oCefb5k9DUTNnMtvcw7fATP/DfV9PEo1B0FLf1Wnc9iWCOI/PdYytY3hIZUlKj
         IJ6Spo/+a490H26uHwPGWyr4bFUIbnRkLXEW//GZ04364NtuqIPMs3JaSbw5tGKyXHnm
         Y7vGEPCI6Wd/eFUkRgsExKNBp7VE7dUna471aYAEEVPV9fikX9uujWBI5pGwJHVg/1TU
         m51jMWWXh1gs2gu/Rwml4C/NaQg0Zl58hdqquwvlEZiM4zdrYqf0GTh1jbBMJlT2MfqE
         7nTavZpQ4kINe+MOnZeYpiIVJ/Zt6waD/060AbDrBCqr7SZMvYuakev8rp9/JbIJ3Gis
         DJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379614; x=1779984414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7i3h7yC1z4islTPU/5JKiDY3m5Oj5w6V5X1AGvkDkc=;
        b=ljn/NGO/jb6AlxIhZlkbMmsPURzV5s5vCMz2KsndtVH+xSKUBBWX7CALd7UnbJBfnI
         6jKcpMT+eJuSORDu/1zPxE//lHLT/aYJxZqTsUtNCD+YUJ1xRoXdbI6XPloAD+TtmxUe
         7J3CkUuTQR2FigqkgncezS77kg0OCwH2eU02YybQbA6KdIqzPh5cumrKy1k8wCLiWl0F
         pOk19cxo3JLdp+hhnYIPbWSkrgU9pRMf6Gql3dOUqdaKlq7jWW60wmDIXuroEE6KYFWE
         vlT9/0BFgDcxTMASDr1wRSYYh3e2yN/I3XS1EsOmJ1juJ9OG09ldSbNsC+a6DKIAPdDM
         QeVA==
X-Forwarded-Encrypted: i=1; AFNElJ8vGeyxkkmhHTolC0xY4JdD1XuCVilbRoyQs6KOwIjSc+SvCuhodvjAaW7WF/57PRRv2gej7AuC3hk9r5BjXFQjBBx0AD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAICNzd9IoOB9fynD6Y9DuJDM0YfwnGcEstmidnJop8w3CAId
	2KF86MrhEkQmssBIyLLzQvUEiybO5MQeS3XnmOuLsm/h2/Pk13Pz6XTA
X-Gm-Gg: Acq92OH52KPu1QJlgg7RzX9frxg5dOg4hly6z/ljv99+9JJ9VWCCyzYFBb9wBUIc/5r
	Xx2ce6/9Kg+U9CZ5xXbAf+EHrRHZgNQ0ayKU0Yre2Fj96ed/1L34M/vzBDsF9NVDRkapSD2h8vG
	SsxiR8s4esLBNeMXyJG52v5CK7kraTzWmPPeO9t6CQvtGLRvPzPIdoKS5KoL69rrIYVTjZm6hWe
	R14WKRNmlH6w1EwyMOlJd6kL1wxxXaXZHCyjZ5Tjuvhxic1EzQxptsSPYy3JyAyZ5EvpWwl2eDk
	2GTC4K1HNWvSeJasi5L5eBgUnrBc2euRMmsvMA5VaxERY17pULnVg2R21w/p7XASDTRUsN2nd1C
	6FmeSgXj7onHtYrLAPCU/ylDut2dUugBfaWc2/aFIDuBw9IY24ZcGoCY2rOG43Yg4enH9eUPq17
	rByAFzjFbtgYPubavq8NpEAs8b0p9OX3U/sPZOXwDUGSznpipt3O+YSy2SWB14WyXmb820jHM=
X-Received: by 2002:a05:690c:4b83:b0:7d0:4824:6413 with SMTP id 00721157ae682-7d20d60aabfmr36799447b3.39.1779379614432;
        Thu, 21 May 2026 09:06:54 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:06:53 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 0/6] landlock: Add scoped access bit for SysV message queues
Date: Thu, 21 May 2026 12:06:34 -0400
Message-ID: <20260521160640.1716746-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends Landlock with a new scoped access right,
LANDLOCK_SCOPE_SYSV_MSG_QUEUE, allowing a sandboxed process to be
restricted from interacting with SysV message queues created outside
of its Landlock domain (or a nested domain).

While use of SysV message queues is less common than other IPC types,
they are commonly used in older applications which may be vulnerable
to exploitation, so they are a meaningful attack surface to restrict.

Background
==========
SysV message queues differ from the IPC mechanisms Landlock already
scopes (UNIX sockets and signals): they have no FD or process-local
handle.  A msqid is valid IPC-namespace-wide and can be obtained
without calling msgget(), so simply hooking msgget() is insufficient.
Domain provenance has to be tracked on the queue itself and checked on
every operation against it.

Approach
========
A new credential blob is attached to each kern_ipc_perm at creation
time, recording the creating task's Landlock domain and a @kind
tag identifying the IPC object type.  The @kind tag is required
because the LSM core allocates an IPC blob for every kern_ipc_perm
regardless of kind, and the generic ipc_permission hook fires for
semaphores and shared memory as well as message queues.

The enum also leaves room to extend scoping to sem/shm later
without changing the blob layout.

Enforcement is done from security_ipc_permission(), which is the
single choke point for msgget() on an existing queue, msgsnd(),
msgrcv(), and the msgctl() variants that go through ipcperms()
(IPC_STAT, MSG_STAT, MSG_STAT_ANY).  msgctl_down() (IPC_RMID and
IPC_SET) bypasses ipcperms(), so the per-call msg_queue_msgctl
hook is kept for those cases.  msg_queue_msgctl also covers the
IPC_INFO / MSG_INFO case where no specific queue exists.

Quirks
======
- Denials surface as -EACCES rather than -EPERM because the generic
  ipcperms() path maps every LSM denial to -EACCES before returning
  to userspace.  This is documented and the selftests check for
  -EACCES accordingly.
- Because there is no persistent handle, a msqid already obtained
  by a process before it enforces this scope can become unusable
  once the restriction is in place; this is intentional and
  documented.

Patch layout
============
  1. Add the kern_ipc_perm credential blob and @kind enum.
  2. Implement LANDLOCK_SCOPE_SYSV_MSG_QUEUE, the ipc_permission
     hook, and msg_queue_msgctl coverage for IPC_RMID/IPC_SET and
     IPC_INFO/MSG_INFO.
  3. Bump the Landlock ABI.
  4. Selftests covering msgget plus a separate fixture for msgsnd,
     msgrcv, and msgctl using a pre-created msqid.
  5. sandboxer sample support for the new scope.
  6. Documentation updates covering the new scope, the -EACCES
     return code, and the implications of non-persistent handles.

Test coverage
=============
Selftests exercise denial and allow paths for msgget, msgsnd,
msgrcv, and msgctl(IPC_STAT) across domain boundaries, including
nested-domain inheritance.  All existing and added tests are
passing.

Kind Regards,
Justin Suess

Justin Suess (6):
  landlock: Add kern_ipc_perm credential blob structs
  landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
  landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
  selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
  samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
  landlock: Document LANDLOCK_SCOPE_SYSV_MESSAGE_QUEUE

 Documentation/admin-guide/LSM/landlock.rst    |   1 +
 Documentation/userspace-api/landlock.rst      |  30 +-
 include/uapi/linux/landlock.h                 |   3 +
 samples/landlock/sandboxer.c                  |  20 +-
 security/landlock/audit.c                     |   4 +
 security/landlock/audit.h                     |   1 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/setup.c                     |   1 +
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      | 137 ++++++++++
 security/landlock/task.h                      |  50 ++++
 tools/testing/selftests/landlock/base_test.c  |   4 +-
 .../landlock/scoped_sysv_msg_queue_test.c     | 256 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 14 files changed, 503 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c


base-commit: 9c5b83756e7b7eab35335da0d5c02a8854bbf416
-- 
2.53.0

