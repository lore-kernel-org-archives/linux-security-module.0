Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5502FF144
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723401; cv=none; b=nDx2LSRr5/VRi7ikxE+rXft32qTMPVzr8bWHdmyfpFp6l51uUuDUoEp2XcA3ksiu5oxMwVXXDGM9EmQ/86mJ9cNDGDmpU//6c4xOfrZUPaS6iJHyisDqxdHmgVQS4xrSIvhbFukqLS0cN5K/pYIROiN091JVptabGDQ7R2ghOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723401; c=relaxed/simple;
	bh=BGaFEx/f8mWLlH9deEEI1cp74nO5obRywMCSftusmHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pX9HVRvK7uhKy02O9TaoN7NRZcgq1fkOuCDQhR2PRGMdMr/7uZavkMDSAZU4r6p2BD2N7Byrw/m+n3YTyP+ZbcsBiD6iWQzyl7kbCWQDzfgZuu5jEexjrzn/qOWysJsdwjud3jbQ23aTqEUFWk3sOzoIuqZ8hL/7sLZs5R6s6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T5B0zMsG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T5B0zMsG"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so17050928a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723398; x=1785328198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGBJ0cI+WS5k0v0KKJxbb2IZYZWx9jLy469rhtaxBA8=;
        b=T5B0zMsGhDp8h/zU5gSGORVftzSWVKFuYjh/YSM4glmpHM4g+CX6YzH/741YKaJFCJ
         g/vX7bcMf7i9Yt7SsL/7nqIGzxdSMb1EbwIrzlW5bgRCcdRCUdLg+ZX9tfiZ0yTY+daI
         YFS9OTpvj2qOJ1JOJoZTOlS+o0W/WbBFOHqwkQpi6tUpcjs9sTAnS5O7zX7Sveng/Xd8
         ic/wWn0rAqorlT3KxyQDyYcsbaLcx4tOWzrlJg7OIMxsiM7+c5nX8rBMYlEG6Fes/AnZ
         HOhN5Xg/RtgsvscSGRIf6t3aWH1YEx/iDn+BkNbs3aHgtUcvESgFc6asLETy+qN8eDn7
         Zomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723398; x=1785328198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGBJ0cI+WS5k0v0KKJxbb2IZYZWx9jLy469rhtaxBA8=;
        b=k8/HMsiZUvHi7O8lSBKa9C+dz4NqRe6bCuLffq8ghc89lCRRfotZ+I8k2oTTxHlMAk
         CIdjiwcWTG3luQpkfWKP0RhYczA0LaGhdKPa7mIe5jqV35bJ6qmomDL9X699kPlitzJL
         SDi1MJBgzt9P4UKPDBPY/Wj/bVFPxLOJjpky24yXJsy2xil59QLQu8KBukZN7ZlKtUzg
         i3lt/B3A5cGYyAMtDqc2cpCTRALQTIX45Xe+FosbiGAoNO2AlMfhh0mIj+ZBmkj+9lCw
         Te8leH/5ngK48oHub0R7W3yGlZd3ql2yqXRo6hnmd1yIuP5tIX8xiyMFufnJQIKbizKL
         Z6Hg==
X-Forwarded-Encrypted: i=1; AHgh+RpvFViyCHFBBJOvuGVk56qI3yYzCteHw+JA1fonPeXdr4La8pZowIIrJXM4XsyyXzI7Dcj2zBiTaZQCcnc/42GdLCMcOjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7h8MuHZ0cNElkYnJw9wuTQPRyy/akMAlphHYO4eraBYnlrr9
	zT1SAFSkVqcMKYcDQ0oAdeJnsq5iu7WVSYIw0mW9G2QkDTHxakzb9XHrUp9lzLiEgyPWDRyrCoY
	4mZcPc4zXWg==
X-Gm-Gg: AR+sD10Msb5SKrNBMLongR0Hv+cl8a8tpusMSa5VqxRvnIIpGaLD7uIOfrWfuOkcCOu
	VHAEZ54IDH5fEUguvZaEehOht+NjYn4eEkiNRqNu522FHN126+MQOBScXkLc4I37jZws9g6EX1x
	Kc7zZtoStWtrzM+nIlFoBVn6PlCaUZs6MyQcyE4g0hf6k/hVIzcYbZm/0NoqlxVgEvHQFu6odEW
	ygxe7HvuVJmeJK/2G8r4ZUlw+5jBLud81N3wsglSgBt+JFOwt5lM9ZGudcituqhwMJsIJ3581O1
	sak+liTLLVLHwIRMqYis+WwzZfQQzNb37DBn31/pymyv4Y5G62L+wUqgBgd2BemoqDhGni8zxbA
	i+c7g3XEL4DT7JoR+1v2sqihsEgUhF+s2p5f4RAg7YpXJdgRrhP0ZOP6boiY9bzU=
X-Received: by 2002:a05:6402:324c:b0:69a:9c4a:3d63 with SMTP id 4fb4d7f45d1cf-69e652995cfmr5743320a12.17.1784723398316;
        Wed, 22 Jul 2026 05:29:58 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:29:57 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 0/6] landlock: Add POSIX message queue scoping
Date: Wed, 22 Jul 2026 13:29:36 +0100
Message-ID: <20260722122952.42149-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds landlock support for scoping POSIX message queuesi [1].
 
Landlock already supports scoped IPC restrictions for signals and abstract
UNIX sockets. These restrictions make it possible to prevent a sandboxed
task from interacting with IPC objects outside of its Landlock domain,
while still allowing communication within the same domain or with nested
domains.
 
This series extends the same model to POSIX message queues with a new
LANDLOCK_SCOPE_POSIX_MSG_QUEUE scope. When this scope is enforced, a task
can only open POSIX message queues that were created by a task in the same
landlock domain or in a nested domain.
 
The implementation tags mqueuefs inodes at creation time with the creator's
landlock domain. This domain is kept alive for the lifetime of the inode
and is checked when the queue is opened.
 
The series also exposes the mqueuefs magic number through the shared UAPI
magic header, bumps the Landlock ABI, updates documentation, adds sandboxer
support, and adds selftests.
 
The new behavior is:
 
- a task restricted with LANDLOCK_SCOPE_POSIX_MSG_QUEUE cannot open a queue
  created outside of its Landlock scope;
- a task can still open a queue created within its own Landlock domain;
- queues created outside of any Landlock domain are treated as outside the
  scope for a scoped opener.

[1] https://man7.org/linux/man-pages/man7/mq_overview.7.html

Oxana Kharitonova (6):
  ipc: Move mqueue fs magic to uapi magic header
  landlock: Scope POSIX message queue opens
  landlock: Bump ABI for LANDLOCK_SCOPE_POSIX_MSG_QUEUE
  selftests/landlock: Test POSIX message queue scoping
  samples/landlock: Support POSIX message queue scoping
  landlock: Document POSIX message queue scoping

 Documentation/admin-guide/LSM/landlock.rst    |   6 +-
 Documentation/userspace-api/landlock.rst      |  11 +-
 include/uapi/linux/landlock.h                 |   7 +-
 include/uapi/linux/magic.h                    |   2 +
 ipc/mqueue.c                                  |   2 +-
 samples/landlock/sandboxer.c                  |  16 +-
 security/landlock/audit.c                     |   9 +
 security/landlock/audit.h                     |   1 +
 security/landlock/fs.c                        |  35 +++
 security/landlock/fs.h                        |  15 ++
 security/landlock/limits.h                    |   2 +-
 security/landlock/ruleset.c                   |   1 -
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      |  43 ++++
 security/landlock/task.h                      |   4 +
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 .../landlock/scoped_posix_msg_queue_test.c    | 223 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 18 files changed, 371 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c

-- 
2.50.1 (Apple Git-155)

