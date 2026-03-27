Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EF361656
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630158; cv=none; b=LgzH2mFmaOus3fjs8KSjhMHIeZ98pW2oR0rX/J62yYkwM2Va9tZkNeVNw6e+csZrm7hmOHNDy0GtnVTXrt6gUbtlwW3SJdrUZ9QIgpcu+NV18Fozt39ozTAdDPpgldnHcncuMsbY5L61vQu3POgiSA9zMiT5gCa7nSIlilaybD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630158; c=relaxed/simple;
	bh=YwlX9yTROiihLrAsbyQysQJuG37/IzOElTXnA3l23J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzGqdOJilU+fGadgrH3ax0tFytH+LCjsd9gt0EBIasOi/14PuqGPLQMwrLXoAa8gAKH7n4gaQR4WmrLJRHyW0+wwkzIAANd0q+D69bPg0rRGUyjGKYNdWIRl8sg2Wp3UE1vpMxhn6BdjGeh6moT0xpNpomoeMLrVfQkRrVDG8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+A36+7l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+A36+7l"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20503425e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630155; x=1775234955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a4He9JWI2Txrib2tiNJDB0I2+MSMlO67oxHzFZloUs=;
        b=c+A36+7l4iplvs5bM5q0u3NRsrPelaO3BulLKaIitWIfo01opsC2bZXMzBY/uyiTX3
         3riDH1JIm4244hvB+wejcouIfDmNGEVxRSbDEAgWOVtGAvNh1Znrq1rCtI/K3YSwicAd
         2hV7GUzHGEZtCC6wuwEopv+Yq3jcVBGix4I0M761nG/z9doMr4OF/yxUf7RnRun9sows
         54DRVA75+zPW7HAv9ZEiviaswDHcEm/IYfMhIgJrmV5wYuGFhkZ5l+breu5jZX5FF3/m
         +ZQpXFE7Hxo6m+ULkJdsT8n7UEd+eT1F3Mu0I4HX6ArGgpGWytTSGQd7K9JzumTyCQqZ
         vpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630155; x=1775234955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8a4He9JWI2Txrib2tiNJDB0I2+MSMlO67oxHzFZloUs=;
        b=YAGjhrDBKPepcQ8spy9aAFoitY749ZlZBV37lfwlv0G+2cPbcQ1VnwzkYgNuiRUQr6
         XsgrOUNAK65xLw5mYVNwGLOtO5EKOLBR8qelCJlyaoboDoND756X6hj7KyhiqjdhLt8z
         cfeZyNoMWXnOehCMHk2GIcFFoAaVC5C3nKatQKu6I1q3Xta1HQGO3XJ8EvAhFrW4HFmY
         9bQQzCoaijR9D0NsbETVzxxlGT2pasFgrLbpJvvcz60MTyUb0nB90dtS2kuFQ98PNU4A
         BN117F9JBwsll4ukGUNts2bv67lKN5dUUaJ0mfgx222IHhaQCpor6zr2hFICxnSASxBX
         zTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYS72ZWaBQbihjKi9fZtP5mw0lGQgrdKyUINLmWxbmxmBWKOIU/oAaxAL6mPLUuZu9WtZ9Kq2FJjHmX5sSsNdhLLXaj68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdNoMdxJk/Be4aa9bxWMWbSKLkMn0Qqx/zgyrmin5qEQU1fVU
	Go3xYTvOA5oht/1igEBKfTa00t08WnAhIbthH1NacyEuB2TnusQyV/MP
X-Gm-Gg: ATEYQzyr+mC+tGYGy7NVFYWKOwk7d+rZdUah3aDCns4wd/s7Nz8azSDFRquXvexia+i
	5JPW6CG/aIzR2d9TRpdP3jGyL7O0GzjBiOKbWgLjQoIyT5ttKUtHLxwOLlVdv2s7m/0IOzNc1UT
	HK3PgSYSexGgAKZOAsxpRaqlF6y29qR61be8kwmgWl0/ROs3cG2zJltZZ8LOBjtM5KVaAb36+ds
	/wk80sgldgdW6GG7UJFToNr/a6fD8DOoKlUq/BxbwSC3pPhUc6BES4a/bRcjS374u3W8RRtF+t8
	mF5iT5N1/aXsAk0GLtPos8w21VGLqW10vH1Jo7cAZqLW7FFFSZTBqGeJ9IbxwnAB0+JoDhxgzBU
	2kB12pRhtthIorvNDBXs+RLD91BqTibPUrh+D9L20SF+E1saevwgi6FLfJ8ExFYV7//2IUqWXzk
	ZOnRLt3c5bPWVsSWhR0jWEscRYtBPfCucNp5JAB+ozexGILRs6FKPOwQ+HF2A=
X-Received: by 2002:a05:600c:1d8c:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48727efabf6mr62464455e9.24.1774630154812;
        Fri, 27 Mar 2026 09:49:14 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm202121495e9.9.2026.03.27.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:14 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 04/12] landlock: Control pathname UNIX domain socket resolution by path
Date: Fri, 27 Mar 2026 17:48:29 +0100
Message-ID: <20260327164838.38231-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
  controls the lookup operations for named UNIX domain sockets.  The
  resolution happens during connect() and sendmsg() (depending on
  socket type).
* Change access_mask_t from u16 to u32 (see below)
* Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
  LSM hook.  Make policy decisions based on the new access rights
* Increment the Landlock ABI version.
* Minor test adaptations to keep the tests working.
* Document the design rationale for scoped access rights,
  and cross-reference it from the header documentation.

With this access right, access is granted if either of the following
conditions is met:

* The target socket's filesystem path was allow-listed using a
  LANDLOCK_RULE_PATH_BENEATH rule, *or*:
* The target socket was created in the same Landlock domain in which
  LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.

In case of a denial, connect() and sendmsg() return EACCES, which is
the same error as it is returned if the user does not have the write
bit in the traditional UNIX file system permissions of that file.

The access_mask_t type grows from u16 to u32 to make space for the new
access right.  This also doubles the size of struct layer_access_masks
from 32 byte to 64 byte.

Document the (possible future) interaction between scoped flags and
other access rights in struct landlock_ruleset_attr, and summarize the
rationale, as discussed in code review leading up to [2].

This feature was created with substantial discussion and input from
Justin Suess, Tingmao Wang and Mickaël Salaün.

Cc: Tingmao Wang <m@maowtm.org>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Suggested-by: Jann Horn <jannh@google.com>
Link[1]: https://github.com/landlock-lsm/linux/issues/36
Link[2]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/security/landlock.rst          |  42 +++++-
 Documentation/userspace-api/landlock.rst     |   2 +-
 include/uapi/linux/landlock.h                |  21 +++
 security/landlock/access.h                   |   2 +-
 security/landlock/audit.c                    |   1 +
 security/landlock/fs.c                       | 130 ++++++++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   5 +-
 10 files changed, 200 insertions(+), 9 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3e4d4d04cfae..c3f8f43073a7 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: September 2025
+:Date: March 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -89,6 +89,46 @@ this is required to keep access controls consistent over the whole system, and
 this avoids unattended bypasses through file descriptor passing (i.e. confused
 deputy attack).
 
+.. _scoped-flags-interaction:
+
+Interaction between scoped flags and other access rights
+--------------------------------------------------------
+
+The ``scoped`` flags in ``struct landlock_ruleset_attr`` restrict the
+use of *outgoing* IPC from the created Landlock domain, while they
+permit reaching out to IPC endpoints *within* the created Landlock
+domain.
+
+In the future, scoped flags *may* interact with other access rights,
+e.g. so that abstract UNIX sockets can be allow-listed by name, or so
+that signals can be allow-listed by signal number or target process.
+
+When introducing ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``, we defined it to
+implicitly have the same scoping semantics as a
+``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` flag would have: connecting to
+UNIX sockets within the same domain (where
+``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` is used) is unconditionally
+allowed.
+
+The reasoning is:
+
+* Like other IPC mechanisms, connecting to named UNIX sockets in the
+  same domain should be expected and harmless.  (If needed, users can
+  further refine their Landlock policies with nested domains or by
+  restricting ``LANDLOCK_ACCESS_FS_MAKE_SOCK``.)
+* We reserve the option to still introduce
+  ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the future.  (This would
+  be useful if we wanted to have a Landlock rule to permit IPC access
+  to other Landlock domains.)
+* But we can postpone the point in time when users have to deal with
+  two interacting flags visible in the userspace API.  (In particular,
+  it is possible that it won't be needed in practice, in which case we
+  can avoid the second flag altogether.)
+* If we *do* introduce ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the
+  future, setting this scoped flag in a ruleset does *not reduce* the
+  restrictions, because access within the same scope is already
+  allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
+
 Tests
 =====
 
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39..1490f879f621 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: January 2026
+:Date: March 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..3157d257555b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -248,6 +248,26 @@ struct landlock_net_port_attr {
  *
  *   This access right is available since the fifth version of the Landlock
  *   ABI.
+ * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sockets
+ *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both calls to
+ *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
+ *   explicit recipient address.
+ *
+ *   This access right only applies to connections to UNIX server sockets which
+ *   were created outside of the newly created Landlock domain (e.g. from within
+ *   a parent domain or from an unrestricted process).  Newly created UNIX
+ *   servers within the same Landlock domain continue to be accessible.  In this
+ *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as the
+ *   ``LANDLOCK_SCOPE_*`` flags.
+ *
+ *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
+ *   in line with other filesystem access rights (but different to denials for
+ *   abstract UNIX domain sockets).
+ *
+ *   This access right is available since the ninth version of the Landlock ABI.
+ *
+ *   The rationale for this design is described in
+ *   :ref:`Documentation/security/landlock.rst <scoped-flags-interaction>`.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -333,6 +353,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 277b6ed7f7bb..99c709f7979e 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -34,7 +34,7 @@
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
-typedef u16 access_mask_t;
+typedef u32 access_mask_t;
 
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 60ff217ab95b..8d0edf94037d 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
 };
 
 static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97065d51685a..fcf69b3d734d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -27,6 +27,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/net.h>
 #include <linux/path.h>
 #include <linux/pid.h>
 #include <linux/rcupdate.h>
@@ -36,6 +37,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue.h>
+#include <net/af_unix.h>
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
 
@@ -314,7 +316,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 /* clang-format on */
 
 /*
@@ -1557,6 +1560,130 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+/**
+ * unmask_scoped_access - Remove access right bits in @masks in all layers
+ *                        where @client and @server have the same domain
+ *
+ * This does the same as domain_is_scoped(), but unmasks bits in @masks.
+ * It can not return early as domain_is_scoped() does.
+ *
+ * A scoped access for a given access right bit is allowed iff, for all layer
+ * depths where the access bit is set, the client and server domain are the
+ * same.  This function clears the access rights @access in @masks at all layer
+ * depths where the client and server domain are the same, so that, when they
+ * are all cleared, the access is allowed.
+ *
+ * @client: Client domain
+ * @server: Server domain
+ * @masks: Layer access masks to unmask
+ * @access: Access bits that control scoping
+ */
+static void unmask_scoped_access(const struct landlock_ruleset *const client,
+				 const struct landlock_ruleset *const server,
+				 struct layer_access_masks *const masks,
+				 const access_mask_t access)
+{
+	int client_layer, server_layer;
+	const struct landlock_hierarchy *client_walker, *server_walker;
+
+	/* This should not happen. */
+	if (WARN_ON_ONCE(!client))
+		return;
+
+	/* Server has no Landlock domain; nothing to clear. */
+	if (!server)
+		return;
+
+	/*
+	 * client_layer must be a signed integer with greater capacity
+	 * than client->num_layers to ensure the following loop stops.
+	 */
+	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+
+	client_layer = client->num_layers - 1;
+	client_walker = client->hierarchy;
+	server_layer = server->num_layers - 1;
+	server_walker = server->hierarchy;
+
+	/*
+	 * Clears the access bits at all layers where the client domain is the
+	 * same as the server domain.  We start the walk at min(client_layer,
+	 * server_layer).  The layer bits until there can not be cleared because
+	 * either the client or the server domain is missing.
+	 */
+	for (; client_layer > server_layer; client_layer--)
+		client_walker = client_walker->parent;
+
+	for (; server_layer > client_layer; server_layer--)
+		server_walker = server_walker->parent;
+
+	for (; client_layer >= 0; client_layer--) {
+		if (masks->access[client_layer] & access &&
+		    client_walker == server_walker)
+			masks->access[client_layer] &= ~access;
+
+		client_walker = client_walker->parent;
+		server_walker = server_walker->parent;
+	}
+}
+
+static int hook_unix_find(const struct path *const path, struct sock *other,
+			  int flags)
+{
+	const struct landlock_ruleset *dom_other;
+	const struct landlock_cred_security *subject;
+	struct layer_access_masks layer_masks;
+	struct landlock_request request = {};
+	static const struct access_masks fs_resolve_unix = {
+		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	};
+
+	/* Lookup for the purpose of saving coredumps is OK. */
+	if (unlikely(flags & SOCK_COREDUMP))
+		return 0;
+
+	subject = landlock_get_applicable_subject(current_cred(),
+						  fs_resolve_unix, NULL);
+
+	if (!subject)
+		return 0;
+
+	/*
+	 * Ignoring return value: that the domains apply was already checked in
+	 * landlock_get_applicable_subject() above.
+	 */
+	landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
+				  &layer_masks, LANDLOCK_KEY_INODE);
+
+	/* Checks the layers in which we are connecting within the same domain. */
+	unix_state_lock(other);
+	if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
+		     !other->sk_socket->file)) {
+		unix_state_unlock(other);
+		/*
+		 * We rely on the caller to catch the (non-reversible) SOCK_DEAD
+		 * condition and retry the lookup.  If we returned an error
+		 * here, the lookup would not get retried.
+		 */
+		return 0;
+	}
+	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+
+	/* Access to the same (or a lower) domain is always allowed. */
+	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
+			     fs_resolve_unix.fs);
+	unix_state_unlock(other);
+
+	/* Checks the connections to allow-listed paths. */
+	if (is_access_to_paths_allowed(subject->domain, path,
+				       fs_resolve_unix.fs, &layer_masks,
+				       &request, NULL, 0, NULL, NULL, NULL))
+		return 0;
+
+	landlock_log_denial(subject, &request);
+	return -EACCES;
+}
+
 /* File hooks */
 
 /**
@@ -1834,6 +1961,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(unix_find, hook_unix_find),
 
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index eb584f47288d..b454ad73b15e 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -19,7 +19,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 3b33839b80c7..a6e23657f3ce 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 8;
+const int landlock_abi_version = 9;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 0fea236ef4bd..30d37234086c 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 968a91c927a4..b318627e7561 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -575,9 +575,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
-- 
2.53.0

