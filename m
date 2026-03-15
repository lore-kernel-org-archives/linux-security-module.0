Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63F37AA9C
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613378; cv=none; b=TaL8ux3JWfhOHybkc8a9g/pE3ztfLT4uG+PT1FXy4R6Eohm1jW9SM6ci2d7cSvChzuQchDFtHu0KO1atSxibmz+Rumye736jY6LdPVGptPtInnclgaSV/Ec42T4IclG+1mp4l+u4/s1rbUKW/mDaKBU3sXN5ag08MM7eqtUbNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613378; c=relaxed/simple;
	bh=S9papzAR/xMnPdrUbPEIoa0GwsONPsqbCHRizeyzu20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHVs9YxLKjKcfeaSOcDK/1O0Rf5rFOzK3mwx7NwnXxKLgnQt8oG0oqdBsMk224I75tSaWsGtZ6VmQxFl9uxSOfuaDt5iJ2Lj9nv50wehNZP/dm9neRk82xS2MKUJI9+cYVk7Ql2wzHuAb7Pms4G4Frr01cxmaZE3oHQevrTGcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjG5DzeE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjG5DzeE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so4483897f8f.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613375; x=1774218175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuIwvLPZfqilpOpq4fg3bDkHI91AXs9YiTHnMimjON8=;
        b=JjG5DzeEGsogAQz1pBaB4ZdyhBnYMPnpS7RNK4eNBHFGIKNOBjbN2nvIhVCcmy2imD
         S1fFD2IkGiBxXT0PUQGwG8C5mX5MxLTGcRh7cj+E3cFF+1WH8QOjVxhxt5Q4KbCQOlhS
         dcqoBS6QyB9PQkMbvPE+4xUEaz8WCDL+GAXZffoutpq7hTDOth3E/82hX/cugOBhN859
         v8THeWRqcVoE2aEEtdQgSKIxIJ8HBk2pAy81geCnPM2RFbYUSXtsRnie84MWTFVXhSfN
         C5y8Yt27CkVN/+zSwyYH4oTsthX6N3c+Z/E1znLOuK6b6ddCF9t1MPF0BXCKGgoLRUzf
         e8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613375; x=1774218175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuIwvLPZfqilpOpq4fg3bDkHI91AXs9YiTHnMimjON8=;
        b=gvUIRHHWix+bKs4sJcnFf9wmNLoS50AITvKVb6gBzV1QzGvDsUpnrnOUTtXCYO1TNf
         fDxWCMDR1xP84Kv09bjxYUnKWgaiQHFg/UcEi7q86LCB2PBJ8Ve5rEGZ/qTgSNwnVxAl
         sYM7C6E+33eN4mPeUum2j+HHzdE+pj32Diu9bZeZ/2Mx2oWfNaHqHjNclDIWdVBgiDKn
         22Ky0NwsfB5CAemEx4ZErLJpkKcVFuwm2C1YpO/LEE9ZCqYwVW20RiIIdLpJfDV/+OQZ
         P7bA3swdNx6Ebt/ic5PZfMK1z+nn+pxCtip+w2+WHYwpYcUj21EpERSvBYCDSaKuB7cv
         cMFw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+GbqZvdoslV0gcwzp4J/CardIUDpg0cHJnybKtW4QVCFkDxZHFe2QOLoR79fgm0MernGXWLYsUyxg7nqbjE4+/hTvts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1vsFOjZ5almGy0IFNYRCYIYqW/d6l/Zj7nA5AHTrw7YEHtKt
	49GLwR4Y3C6uEcH/7H6sTuz+b3H2jkXe20uutrwIoWufvR8f6Q7Dv1tU
X-Gm-Gg: ATEYQzyUv7izjMUUY0MRA8aX7wAK2/6P3Kahbc73RmrTiLl7sEwJ8U8FNZmVwRJ7TvA
	IDg4FIulpyLXsFKUCX2WFwMvONzIDaS6/9qfAv9H6r4civ48vY5eltj86udPS8RsjOLFLySAMMA
	HV3MZSpQi+Cwxrawlw29KwgKcW0mob7wt1Y+Aa8ZZxld82KrBdba4VTqT93vtnhuazPsiIsLOIT
	9M3wXtNV1CH1z/aqH8DbA1wLHrLDa9Bwi1RenUqMK65AyLNr6LhvVXlDqvzyJeGYo0JHSdYAXfl
	oVWCZEzpw1/YhFAmhpdP1ZDBUsj/kQbFi+wfTchd5uW6BJSCzn5CPKBsuy1sTVJispqN6y/eril
	3vbdBrFvhGQpApLnD7I0IUKwldOxvdcgb/hkoIk9DtPoaesTzPtt+WlkfSPOU5hBA7LX0Gvwurf
	1Rg5RoC2CyWUP2hDDtyfk+QE+owXOobc2VYCPRHzF8y10RMZ8u
X-Received: by 2002:a5d:5f53:0:b0:439:b624:5ce1 with SMTP id ffacd0b85a97d-43a04db6580mr19527436f8f.33.1773613374940;
        Sun, 15 Mar 2026 15:22:54 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm26479202f8f.36.2026.03.15.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:22:54 -0700 (PDT)
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
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket resolution by path
Date: Sun, 15 Mar 2026 23:21:44 +0100
Message-ID: <20260315222150.121952-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
  controls the look up operations for named UNIX domain sockets.  The
  resolution happens during connect() and sendmsg() (depending on
  socket type).
* Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
  LSM hook.  Make policy decisions based on the new access rights
* Increment the Landlock ABI version.
* Minor test adaptions to keep the tests working.
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
bit in the traditional Unix file system permissions of that file.

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
 Documentation/security/landlock.rst          |  40 +++++++
 include/uapi/linux/landlock.h                |  19 ++++
 security/landlock/access.h                   |   2 +-
 security/landlock/audit.c                    |   1 +
 security/landlock/fs.c                       | 110 ++++++++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   5 +-
 9 files changed, 176 insertions(+), 7 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3e4d4d04cfae..4bbe250a6829 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
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
 
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..751e3c143cba 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -248,6 +248,24 @@ struct landlock_net_port_attr {
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
+ *   regard, %LANDLOCK_ACCESS_RESOLVE_UNIX has the same semantics as the
+ *   ``LANDLOCK_SCOPE_*`` flags.
+ *
+ *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
+ *   in line with other filesystem access rights (but different to denials for
+ *   abstract UNIX domain sockets).
+ *
+ *   The rationale for this design is described in
+ *   :ref:`Documentation/security/landlock.rst <scoped-flags-interaction>`.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -333,6 +351,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 42c95747d7bd..89dc8e7b93da 100644
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
index 97065d51685a..0486f5ab06c9 100644
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
@@ -1557,6 +1560,110 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+/**
+ * unmask_scoped_access - Remove access right bits in @masks in all layers
+ *                        where @client and @server have the same domain
+ *
+ * This does the same as domain_is_scoped(), but unmasks bits in @masks.
+ * It can not return early as domain_is_scoped() does.
+ *
+ * @client: Client domain
+ * @server: Server domain
+ * @masks: Layer access masks to unmask
+ * @access: Access bit that controls scoping
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
+	/* Access to the same (or a lower) domain is always allowed. */
+	subject = landlock_get_applicable_subject(current_cred(),
+						  fs_resolve_unix, NULL);
+
+	if (!subject)
+		return 0;
+
+	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
+				       &layer_masks, LANDLOCK_KEY_INODE))
+		return 0;
+
+	/* Checks the layers in which we are connecting within the same domain. */
+	unix_state_lock(other);
+	if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
+		     !other->sk_socket->file)) {
+		unix_state_unlock(other);
+		return 0;
+	}
+	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+	unix_state_unlock(other);
+
+	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
+			     fs_resolve_unix.fs);
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
@@ -1834,6 +1941,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
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

