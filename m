Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630855;
	b=qA3kHoVrZVmLXVTJzekWP7bLBASQZVKVEVN/h8FNAS2EiAun+wDkNj8nH8ODxCw9hSyI
	 bN+08avIVU0UgfYp0fbiyybCQvTmtosnrO1xumivg8jojns2/E8U3h96XEqe5FPZTwzUc
	 ThzjDx9xB9s3V9SBM4Uoj8cxwbn0eUwEVewaaxUDLjCYZCMu92zpHMch9+if+me6Arr+f
	 +uldpwo41T8eHfy7pWBc56PErEMKPfB8cQwCIf7xrv4oHFDaLy0H72H4gqpETR/dF0ssR
	 w5pghD3FDl0CwxO8W8bIyYDWNFJf4r+38Ddv1fuAFrd+VvAUSAGmHijieP2pyirl+Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pXy5GHogXvLHlpIU9w8T5R2VSIYiM1bQSKyxxyzdROQ=;
	b=QOCfwOJUtc2C6yy1faObjefuu7gKR0ZdNMBrFMyhUlL+xWne9oUZLT5W2cxPQ5xkne3x
	 OKbWR1WaxfspskU7bnDGdOSxQA7XBwC09cdB0ZZEYpjeXs7BfMO8WqjIYP2WDGp8bEVKS
	 tdWGhY+jndpzg0gZmlir3N4IxdBZuYtmXnj54lnChdbkSCYbwWe9Cp4oBykYI8cfwbp3k
	 BKJ4nqawJCBbG+Wb1L5ShCaFgsi4iP2n5hJKX7VVZNRy7GxZXYcrMWF1XAp3xSMnZP73O
	 R6A6z15YxTIlnMa/jld5d7f/iAwIo382JZ0MCeZC0xgFoKrBAvyOK61BS1abMmGF7hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jp/OKYpx";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D960716CB
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D7D960716CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jp/OKYpx
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so23907855e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630852; x=1794235652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXy5GHogXvLHlpIU9w8T5R2VSIYiM1bQSKyxxyzdROQ=;
        b=jp/OKYpxyopJX1v6P+NkhTAElWsYZn49ORDA9J7Vd3DQoXlm2D9bWXDzDmFl/9KYLA
         3fMeBFra+M25mdoukIlHOU7LIACdt+rQ1K2vL8rclurqh+G8h2cBMoI6J3dpVZoc99iL
         4UWAafiuKDQMWKq/fJslpfooi2JrTpI9EyHuY+JBBiT55LlHbH1/yzlZdT2Vj6liJ49m
         dvJkqcwo+oSHtHsUivSQnJrqlk9d1szc4Cd/Qj34Rzb9dmeXVs0zOAy3iHPVWLmCEKmM
         6rdmctYzX5fwYwrgdN/rB+r/QbUR/kwK2J9j0Jald2A/ek5CxwS0zR/rl0AIVNaEILTY
         /Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630852; x=1794235652;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pXy5GHogXvLHlpIU9w8T5R2VSIYiM1bQSKyxxyzdROQ=;
        b=LOJT82TIusiy8r4y3QgC7QibVhvLWDagDNg/+VKAEwMDSqf/bWmrWBcHmxL2bAxyIW
         p8EtocjqRBz/XvV6wcjkOzJ5tvaKzWNmGI8djrolZ2FvdJfBy0wdvnChyIOyZCQ0mwzX
         EcEMNjQLRuMT33vBIqZ7EYZmytoWZIhbUk0BKHXz5oTF+rBqnByZ1MbaxviHuOWTbPS2
         20xQM/i1Jo7uwdmdGi7RXZ8dIDa25dlkqqPoHC2Ty547x5So04idEkC5Xw49XpoUzKaZ
         1F/Ivt0igdXKspFRE2FkWUFK+r/UIC0X8pp+B2//vqIS17g9gb5RAK4ZqOnbNwl5DEgE
         AVGA==
X-Gm-Message-State: AFq9FYKdXhIj8zDpC6g1BVnIRd/TZQcw9hCOmkA0Wa+xJsaYLQTgSwQL
	qRRyvJPkJnOOb/DAzXd0fDaUoqNlYrT6L0dJwlKgrItHi1Miz76tyMJB
X-Gm-Gg: AYBFou2YedNfB/CU9yFNpJ34rQYtMOCYIKiDRdvf2fJ6Z0/RoCga9kwSBNy/VfcZ5NP
	xPNLq19BvQA0WbRlZ1bZv3PkGOZ0pr7aFaPfm8LPHsmaaHcO03wv3vOXWl+oVpJUkLcMXdKq1Et
	s06pLzZv2UDoud57qDc2Wc0b+DkACUeUztUrPUJmsnhJ825NgDbNGTfFmC29oOSFVWrywj1ss59
	l2U9VGNiu6/2t1KdvdCq3VcM3nTJiHK4PiksJU5cSMmtZtJQEFwUAHFJl1gtqf+6Wt57LrB2DHQ
	lQZUuCN5+slVGVEgfuHGrAmMCUDq28CJTJl8aRhZbi5HlTC8Gf+7pj1kt2sIGwayzv9+DHiE0NG
	ybBK7AW5SL1S0EhsKVL9jBDQq4fFpVEoxuWM6hgrB8RCeeoMDjdQzcDaJ+X4hH0AAbPhizS4HNS
	Re23kUcD7FUgNNwuHYFHM9XnRHwXiYB4DeN9yEj7fJ93tntHf/Puh75VWvXMkBOmDWDo4F5ckM5
	erQ9JTh3BQheHoKEDlOSgJIBaaeEN42JQKX0TxhpY4YZGGDBGvQrudtFtjN2mL2bUvXZaUCaU9L
	i38T7V1pHYOzp+ACRDy/7s18JM7xD/2cRxYzZj7HnwnqO1eX131GKhlIVqA6GA==
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id 5b1f17b1804b1-4ac182dca8emr228763095e9.23.1793630852206;
        Mon, 02 Nov 2026 06:47:32 -0800 (PST)
Received: from penguin-ubuntu.lan ([2a00:23c6:6410:5d01:8464:9a6f:2d42:8827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm254289965e9.0.2026.11.02.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:31 -0800 (PST)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	gnoack@google.com,
	utilityemal77@gmail.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: [PATCH v2 0/4] Landlock: Restrict POSIX message queue creation and access
Date: Mon,  2 Nov 2026 14:45:56 +0000
Message-ID: <20261102144708.920232-1-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Christian and Al, could you please review the mqueue-specific changes,
particularly the shared MQUEUE_MAGIC definition in patch 1?

Mickaël, Günther, and Justin, thank you for your feedback. I have revised
the changes and split the series into two parts: patches 1 and 2 enforce
the existing MAKE_REG permission, while patches 3 and 4 introduce and
expose the new scope. The first two patches can be applied without the
latter two.

The new scope adds control based on the queue creator's Landlock domain,
allowing sandboxes with shared filesystem access to isolate their queues.
However, I am unsure how useful this additional isolation would be in
practice.

The scope cannot replace the existing filesystem permission checks
without changing behavior, because applications may already rely on
them to restrict queue access. Both mechanisms therefore remain in
place. When READ_FILE is handled and queue scoping is enabled, the
checks combine as follows for opening an existing queue read-only,
assuming other access controls permit the operation:

Filesystem read access | Queue scope | Expected result
-----------------------+-------------+----------------
Denied                 | Allowed     | EACCES
Denied                 | Denied      | EPERM
Allowed                | Allowed     | Success
Allowed                | Denied      | EPERM

Selftests cover all four combinations.

I would welcome feedback on whether this domain-based isolation provides
enough practical value to justify the additional logic needed to track
creator domains and manage their lifetimes.

Queue creation
==============

POSIX message queues are represented by files in the mqueue filesystem.
Landlock's existing READ_FILE and WRITE_FILE restrictions can deny
mq_open(), but these checks occur after queue creation. Consequently,
mq_open() with O_CREAT may create a queue before access is denied,
leaving the queue behind despite the failed call.

Patch 2 adds an inode_create hook to enforce MAKE_REG before queue
creation. When this right is handled, creation requires an applicable
rule allowing MAKE_REG on the queue's parent directory. Opening an
existing queue does not require MAKE_REG.

Queue scoping
=============

Patch 3 adds LANDLOCK_SCOPE_POSIX_MSG_QUEUE through Landlock ABI 13.
It restricts opening queues to those created within the domain enabling
the scope or its descendants.

The restriction applies to mq_open() and opens through a mounted mqueue
filesystem. Existing, inherited, and passed descriptors remain usable.
Filesystem read/write restrictions continue to apply alongside the
scope.

The implementation includes audit logging, audit quieting, and a
dedicated denial trace event. Patch 4 exposes the scope and quieting
options through the sandboxer sample.

Unlink and queue lifetime
========================

A queue's lifetime is independent of its creator. While its IPC
namespace exists, the queue remains until its name is unlinked and all
open descriptors are closed.

The scope leaves mq_unlink() unrestricted, subject to other access
controls, so that an application can clean up stale queues from previous
runs.

A process permitted to unlink and recreate a queue can replace its name,
including from another Landlock domain. Existing descriptors continue
to refer to the original queue, while subsequent opens refer to the
replacement and undergo its scope check. The scope therefore does not
guarantee the identity or availability of queues by name. These
limitations are documented.

Changes since v1
================

- Separate MAKE_REG enforcement from the proposed queue scope.
- Store the creator-domain reference in landlock_object rather than
  directly in landlock_inode_security.
- Add an inode_create hook to enforce MAKE_REG before queue creation.
- Expand documentation of filesystem permissions, scoping, descriptor
  reuse, and unlink/name-replacement limitations.
- Extend selftest coverage, including audit logging and quieting,
  path-based opens, inherited descriptors, and descriptor passing.
- Enable CONFIG_POSIX_MQUEUE=y in the Landlock selftest configuration.

Oxana Kharitonova (4):
  ipc: Move MQUEUE_MAGIC to a shared header
  Landlock: Enforce MAKE_REG for POSIX message queue creation
  Landlock: Add POSIX message queue scoping
  samples/landlock: Add POSIX message queue scoping to sandboxer

 Documentation/trace/events-landlock.rst       |   1 +
 Documentation/userspace-api/landlock.rst      |  80 +-
 include/linux/ipc_namespace.h                 |   2 +
 include/linux/landlock.h                      |   3 +-
 include/trace/events/landlock.h               |  46 +
 include/uapi/linux/landlock.h                 |   5 +
 ipc/mqueue.c                                  |   1 -
 samples/landlock/sandboxer.c                  |  26 +-
 security/landlock/audit.c                     |   5 +
 security/landlock/fs.c                        | 133 ++-
 security/landlock/fs.h                        |  12 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/log.c                       |   4 +
 security/landlock/log.h                       |   1 +
 security/landlock/object.c                    |   2 +
 security/landlock/object.h                    |   7 +
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      |  66 ++
 security/landlock/task.h                      |   4 +
 security/landlock/trace.c                     |   7 +
 tools/testing/selftests/landlock/Makefile     |   4 +-
 tools/testing/selftests/landlock/audit_test.c | 114 +++
 tools/testing/selftests/landlock/base_test.c  |  40 +-
 tools/testing/selftests/landlock/config       |   1 +
 .../selftests/landlock/posix_mqueue_test.c    | 233 +++++
 .../landlock/scoped_posix_msg_queue_test.c    | 846 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 27 files changed, 1634 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/posix_mqueue_test.c
 create mode 100644 tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c

-- 
2.43.0

