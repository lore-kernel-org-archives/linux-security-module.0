Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF8374E67
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193724; cv=none; b=sVCH53DGdJ2i92//KNz99H9ajQhzL/3OqL50V5uLHPG5q1Ti+9GezZakZSRdHyo43oZRWUwVhKzCcOlDsI3Rynh5vAQBRd54ayz5ZkApRdrdiBImZ6njwNUyne37szQgtZFOtoanSvZG63RR0n3hYWYMVhf9Vp1GGYIim1OMdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193724; c=relaxed/simple;
	bh=Y0k6xLY/0wbkKVSiLRM2fplStSzqiLrFfg+dIaAf/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPO92j3J0lgFkoMiHBAZVgSipR3oR2sDWXZLM3w0os6FFn1G+O5hrUAcFtFsBa/AJ5sug7gcZHDSwQrxl7BZ8+WUjxvrm3+8+DcTaspfS9+h81Te9UPi5C+WhYGT24bSoY8IcVSE1OpH5FLUEvmSJhXdcNua9g3aVQpD55Hykjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIn6T5aq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIn6T5aq"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81062fdeaf5so6466027b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193722; x=1785798522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVwbhzO9gGX5b6tRW7uZkko+4y4EgfjAbaRkkNPkQJQ=;
        b=LIn6T5aqsDkYhSn/SXHdisoPVC4lm7Mn49yk2Nep3z6H2WytYr2dfcX2HSD2MWAhE2
         /cnbl+H4Q5CCpHe4NCEcnkTx1B9qtDFJHpezMwHq1ED3FX9lMaKEpJblIWfZkMmYABzG
         WbmDYQudxf6+sLOO+rZqM5tMFsk18UTaNEzE0+t6JFIWDJ9rgC3rEvzAUTaU20LXE5+t
         ToyKVZlB/NTdH0u5XTF357+FzY39G39zP+fg9v5IpmtAjlAISMh/Ie2dN1PRvr/WHfuu
         l6okBg/tiNuHOoj2X6LTXwHRQ2Zq8hP2wD8zpeNEQbRKK4WQZoIV4pnVokgg5SplkRrx
         9M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193722; x=1785798522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVwbhzO9gGX5b6tRW7uZkko+4y4EgfjAbaRkkNPkQJQ=;
        b=NJYOrsPyZf6b+EyNRUCdfMnpUQ8IN/3ybb6Xll8/b3ar5JXWqZZkrkcPG835S1q+G2
         40MqamSelNUXwrrumxWfqprxjD1g1HjZuN7j/KY+TTfchgQMUnD5WK2wAn7dPwtB7/hI
         qt0a3qHoUu8fnQFaur6XdrwO8/0LgSGEuR0mg9sb8Ky8JQbfap97og7X1dFkp4LFTmyG
         k8wHrxvw9Gc/oOKNHGqzvC8NnxweTP9f9MIk5QyD0m6pnXSMK9/QPty/lPG+pCxS2eCj
         JhA7IIIbaGt3l4esvIalbPgkKw93bkuacHyyy9i9DGZnXxT+3GHjiLuS8UqcaK+sZ9Nh
         Gbzw==
X-Forwarded-Encrypted: i=1; AHgh+RrsNbS6FXHyDozKDBd+f5ovJ1W7edpWff/9A3BzIKVVjUnVo9xi2o0SJ8JB/K6+ScTbl5jYYJBaw1akW8fOXa3fA0suW4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEUD9HWusZ9Ptk7lfjbFs60WQoWy3BaEhCnddVwMabgd0EgJL
	hroBpJMMgYw1W+xg9urCWJvVs6phiqQnuSctkvm6qDw5o91mcLMrrWDR+OLBobRP
X-Gm-Gg: AR+sD12ty0WtrW5dgPKeaW8ZKvIpZwvoxmFe1UMakRBXqJB71N1izRG86XQ65Z7zUTn
	UGq9/r1r+aXqKiAr7tAYqedGDEMMXJHQgoNiLJ8WR2oCBYy1ckr4ZYIyjYS289zxSlz38TpnKmR
	q6BE0n5XV7149nl1pcou0mf1eaOl9rhTmjN2EoxVzwLkjYOFFGbH4yWSnCR9g7KVnY7tBNXR6P7
	jTdszByMQmG5EnIfpiwOEZJIXT17XhD0a+SWXo4NaSlwkg5jysqoSQRgiE3A6mysP83xVF/eLE4
	C8lkW8s/0+uacz4yjwJ1XOWAHSwJBKtw/SeSJSuc6nxsm5P13jmdIy3OxpitShE1gwcLxiqNeXT
	RLw+Z9oM9A0pQClBosIBfHUIPEot9E1lu83qb7qRc8mHm50uZ5hDivecZthuxqI6eztMTyFpUNZ
	yDB1xIlJ94/OmrOla3PSbS+LxMxnv33br/K7k8
X-Received: by 2002:a05:690c:884:b0:81e:d60b:ecc4 with SMTP id 00721157ae682-81f9623961emr3034287b3.17.1785193721741;
        Mon, 27 Jul 2026 16:08:41 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:41 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message queues
Date: Mon, 27 Jul 2026 19:08:27 -0400
Message-ID: <20260727230833.138165-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
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
SysV message queues have no FD or process-local handle.  A msqid is
valid IPC-namespace-wide and can be obtained without calling
msgget(), so simply hooking msgget() is insufficient.  Domain
provenance has to be tracked on the queue itself and checked on
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

Changes since v1
================
- Rebased on mic/next.
- Fixed the kernel-doc Return descriptions of hook_ipc_permission()
  and hook_msg_queue_msgctl().
- Renamed the internal audit request type to
  LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE for consistency with the
  UAPI macro and the "scope.sysv_msg_queue" audit blocker string.
- Integrated the new scope with the sandboxer's quiet access
  support added in ABI 10 (new "sysv_msg_queue" LL_QUIET_ACCESS
  token).
- Selftests: track the created msqid in the fixture and remove it in
  FIXTURE_TEARDOWN_PARENT() so queues are reclaimed even when a failed
  assertion aborts a test (and never subject to the scoping under
  test); use IPC_PRIVATE where the key is not needed.
- Added CONFIG_SYSVIPC=y to the selftest config fragment.
- Fixed the patch 6 subject typo (LANDLOCK_SCOPE_SYSV_MESSAGE_QUEUE)
  and replaced an incorrect ipcperms(3) manpage reference with the
  kernel helper ipcperms().
- Reworded the LANDLOCK_SCOPE_SYSV_MSG_QUEUE UAPI comment and the
  in-code comment explaining the -EACCES mapping.

v1: https://lore.kernel.org/all/20260521160640.1716746-1-utilityemal77@gmail.com/

Kind Regards,
Justin Suess

Justin Suess (6):
  landlock: Add kern_ipc_perm credential blob structs
  landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
  landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
  selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
  samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
  landlock: Document LANDLOCK_SCOPE_SYSV_MSG_QUEUE

 Documentation/admin-guide/LSM/landlock.rst    |   1 +
 Documentation/userspace-api/landlock.rst      |  30 +-
 include/uapi/linux/landlock.h                 |   4 +
 samples/landlock/sandboxer.c                  |  24 +-
 security/landlock/audit.c                     |   4 +
 security/landlock/audit.h                     |   1 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/setup.c                     |   1 +
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      | 137 +++++++++
 security/landlock/task.h                      |  50 ++++
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/config       |   1 +
 .../landlock/scoped_sysv_msg_queue_test.c     | 265 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 15 files changed, 517 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c


base-commit: 28ca6f6f271d47253c240e64cc88a72c89456d74
-- 
2.54.0

