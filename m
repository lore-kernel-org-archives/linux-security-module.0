Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA5384CCD
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379634; cv=none; b=GroGbSOM3minHiwQWRlBPfFdZzHRa+O4gmR05V9OKKqi6C/zIPk+FYhkFvG1pIbMU5F2ZE9MskAj39pTebRmHXh7/OuZyTKVzJaYsJGNXR+dik+EM6qj7Cx4xTpcDEA3F6SP15bFSF2AfsGFRfOu3dHXkv+UKViY3i/OGK0eWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379634; c=relaxed/simple;
	bh=nGhsmtgWyFPjr/aq1yL0y+wlRu69TvN1tcwIESDlxZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYKsfSdgZDGI7KvbHnt5ZlMhmvnNroRKj1Hy6W6Xo9wW7AI1w2tATRf3zgv+b8F0lc6oV/InoXlzOgBvpoBx5yQSc2Yl7Za7mMBv3nW0hCh2lCu/kF4HFvmgZ1ulCxwFsYFC7b/2tWaiKXxoqIh7lFt8n/epZDsyjvPo8ngia10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2pPvKIj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2pPvKIj"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7b41fdf9de2so45832557b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379632; x=1779984432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpCxEzWYsgGR14o06zRZo2uJlStV20Rqwj1IODcyfdc=;
        b=G2pPvKIjkUj57Pgrp1NTxwuwJOPd4gZJFmZAVqZ63lNOaD2oIk7GYdVr57vmd+NU66
         Trf7TpuQ3ehueGLtcRCyEdrryjVQkMlNIJPAl7KckASzKy40HzpSWzOyTIJZVlGvmEY1
         aYHs0r1fEHz6e0MiW4DxbVAieO4Ujc05olMnGqspvEZ5Q6gCUsklgZUr6U+DMABo7aQj
         t+dZoPcm+jjpW0ETb764GWfaPsUsmQL+nDoiO77jfJ4FCa1vw/Fa1JAkQN+pfvHfmiyN
         ckMlMK8UWhdcZz0/Uh4P3meYGk73vNCIWJImLCaUS1eVl6yl7sQyscX7zEZ8jR5o3lEN
         5seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379632; x=1779984432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpCxEzWYsgGR14o06zRZo2uJlStV20Rqwj1IODcyfdc=;
        b=aCUsbKVJhAB78g+NStBRZVEzrXKvpWGXbpOgtXXh3Zx8ZQX6B8v2YRbw12WRbopjOY
         YLN38ZKUvu+5EsYBBVAFfQfXGdlwyxaEYlh9LrKgUY+ngweKXbBJpbILX/w+a2Y3nC3Z
         iBpdp2/xz5hbl5cv7FfZAOpKkqVJ0cFoKDXrP1oGje39M3F0NgP0JG9KbUuCklASRr1b
         lcMB1ZUBhD5M8HyeiJYbgewtvEJdSoEmEu34oq3es0be4UbLXLuV9G25l7rRiEx/wwTN
         S7rNWID2lJmUUDoVVVFeAUIsuD0YNkBF5fBr/ayh9zg/chUENnXWHjEgKonbLcBObjJ9
         9JQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VD7WlLBYsHOKvjV08QG1RpksphQppxoyI6rk5i1u5aJotv+wDG7hUZ9HN3gAe5aTnh/64ahldayNoBIu4xz6qOn826dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCAjMyX2gkHlm2ZbW9qhxhFOkQvcKOPvpmp8XxxTL0Di+S9YH
	e/K4OMy5o9SVoLjAjJ+3jONjIzNafTuPxpCKwskH02OJROfLZbbBamZk
X-Gm-Gg: Acq92OE6BpSan8pleVXBQFU9nA9pUyuBpoolUKtnI+CzQaVVmBLhl9FmrQkHv1drTJR
	g0Hv8bZ3v0C3jhmIg6CXfi3hkQyScTUNKl65Jkp0/FMcPtno7LlcHInwBN6BG+4vINbj7vFxKny
	dUlqKGTl0WxAXRrkrthm1ybv4jZE/2tGrqeu5aZcQuuFKasRXiDN9PymxbWtW3hXu92NU6DswJq
	hwRbIf0W55KRhUZJt37TLLQhk1rWZ1TuDhI2n07CMd9ht0g6ak65bGKHv/LR0ntDsSW5VT7fzMi
	rvvqoIQCf7od2YybtKt1JluW7JyY8x3y9IG1i1hf0G7dneAnltuficI3Q29vgTuhNSANZ3Tl9lw
	yR2VkIgB9+imWYoYB2QLUiQUxq8S6c0Fo7mgswCXqD9b9BLMBuppn3G5QAw/EyKfZC2U2ER6Bd1
	3d6Y5TIjYoOONwk78A/0J6WUt3SQ6vvsX+htiNZHazkjPcmGhhLOvHZo/fATXR9ov12xQu7g4=
X-Received: by 2002:a05:690c:4442:b0:7d1:cd93:c8e4 with SMTP id 00721157ae682-7d20ad8f545mr36338967b3.18.1779379631731;
        Thu, 21 May 2026 09:07:11 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:07:11 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 6/6] landlock: Document LANDLOCK_SCOPE_SYSV_MESSAGE_QUEUE
Date: Thu, 21 May 2026 12:06:40 -0400
Message-ID: <20260521160640.1716746-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521160640.1716746-1-utilityemal77@gmail.com>
References: <20260521160640.1716746-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new SysV message queue scope restriction.  Make clear
that because these queues do not use persistent handles, subsequent
operations on a queue already obtained via msgget (or any other
means) may be restricted once this right is enforced.  Also note
that denials surface as -EACCES rather than -EPERM, since the
generic SysV IPC permission path maps every LSM denial to -EACCES.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/admin-guide/LSM/landlock.rst |  1 +
 Documentation/userspace-api/landlock.rst   | 30 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9923874e2156..e983d903bdf9 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -58,6 +58,7 @@ AUDIT_LANDLOCK_ACCESS
     **scope.*** - IPC scoping restrictions (ABI 6+):
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
         - scope.signal - Signal sending denied
+        - scope.sysv_msg_queue - SysV message queue operation denied (ABI 10+)
 
     Multiple blockers can appear in a single event (comma-separated) when
     multiple access rights are missing. For example, creating a regular file
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 45861fa75685..933b2994fec4 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -84,7 +84,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-            LANDLOCK_SCOPE_SIGNAL,
+            LANDLOCK_SCOPE_SIGNAL |
+            LANDLOCK_SCOPE_SYSV_MSG_QUEUE,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -132,6 +133,10 @@ version, and only use the available subset of access rights:
     case 6 ... 8:
         /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+        __attribute__((fallthrough));
+    case 9:
+        /* Removes LANDLOCK_SCOPE_SYSV_MSG_QUEUE for ABI < 10 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -380,6 +385,22 @@ The operations which can be scoped are:
     A :manpage:`sendto(2)` on a socket which was previously connected will not
     be restricted.  This works for both datagram and stream sockets.
 
+``LANDLOCK_SCOPE_SYSV_MSG_QUEUE``
+    This limits the set of System V message queues to which we can perform
+    :manpage:`msgget(2)`, :manpage:`msgrcv(2)`, :manpage:`msgsnd(2)`, and
+    :manpage:`msgctl(2)` calls to only message queues which were created by a
+    process in the same or a nested Landlock domain.
+
+    Since System V message queues are IPC namespace global constructs and do
+    not use file descriptors, enforcement of a ruleset with this scoping may
+    cause subsequent operations on an msqid that were allowed prior to
+    enforcement to be denied.
+
+    Denials are reported as ``EACCES``.  Unlike other Landlock scopes,
+    the check shares the generic SysV IPC permission path
+    (``ipcperms(3)``), which maps every denial to ``EACCES`` before it
+    reaches user space.
+
 IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
 If an operation is scoped within a domain, no rules can be added to allow access
 to resources or processes outside of the scope.
@@ -722,6 +743,13 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+System V message queue (ABI < 10)
+---------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to restrict
+operations on System V message queues by setting
+``LANDLOCK_SCOPE_SYSV_MSG_QUEUE`` to the ``scoped`` ruleset attribute.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0

