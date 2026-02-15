Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A22DCF57
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152757; cv=none; b=QzURLWkD0K4uY7o4FzFmWyPNB44WBYTzuaW/TOjNw+RQAc+LhL5ngTYBWslux1wqxVMipBMKIUENxVdvhRT0aq5H8yjgI9Iu2MpFS12AAVzzqSnIBCJDIfl+2q068L1/brMNltU91jo2ikMdePq6pyT+eBaDXxqg0ENSTyLWgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152757; c=relaxed/simple;
	bh=ty+rtqvzOWPRvuvhEhSkRdb+4hlwcZKDsYzvf5BfSfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJTQm4fh7XI67U+jPLmCyIWkT6N+1yC8WVPkvFF78LsBw7SjsWrz02mSIFEnkM0ABhJ/9usoJSQcpgUvyFjhVWLP38J3mNbCn0oi/sXMaY9exvRosg7b+Qb04YpvpzfXlvqA/2xmxdgKfHXbjvmYU3RP9Sl5OTthDOwc5mNu5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJX67sOP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJX67sOP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436309f1ad7so1842730f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152754; x=1771757554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMXN5hY9ROxiuwTTDIvPDVBLL5VUUXelIfap9w5Vinc=;
        b=FJX67sOPGHtaUlGAjnpv6jXWXKGF6Hl0GxMUYwGZas+SOBi5iFFJ5xGifos+LymMWr
         xNr8w6XGzeiof1z32gkdDryexlfXLM+4sM21pIh4+kwswv2zEEbNe/3XbTQtT2/BPk7H
         ooU5CWYSTOty3fYXZQ3gDpyqLf8spLniHJTzhhCZvoq/LbR0/xqY+wfxB7wKI2l9QlwL
         m4QhuavO4tHF+1aLj0jsWtHdIZbe/3FzBrvjo8nxsdPCzRyBEBqYxsdcLg+7uyKnxLC4
         r9Vyd+pgMsW0ubFMiSicxevYgLCSsL88G/xFyR6oEQ/+4hyjcK4TiGiPhqX3GPV1GksO
         PL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152754; x=1771757554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aMXN5hY9ROxiuwTTDIvPDVBLL5VUUXelIfap9w5Vinc=;
        b=fHjvdzg42iQ2xsEm7RjP3qjaMoQpkOdR9KXkHt2GB9Kub2MZQZ6mUgHebRKlwrX1TA
         nAc3gRWgKEHgHrO/kqhYvpR4vKINnOKlt6dJqNkOD6Mlv44NkQQ8JP4JpGyFjC8XzC4D
         pdVmtxrHedG0UlCUvvjmoiaCSdf0PUjE8/ZmwaXYFImi/lxaatn7QXdF0mL7CcwrqRPl
         /yewXIWs6SQtNkshTOex2wlyyEVyT+uuGM4VvYAT0L/d//XKyKUYXkj8mYxSuM++CPfW
         WBrzkkGz1TebD8TQFmf7YfpTMv8jwCikG79BydEWU1oXYG0Hbn+wGFQeh2vJlaC8Aa5l
         0qow==
X-Forwarded-Encrypted: i=1; AJvYcCVteJheMgtQRvRRkFHKlbxm4xKP2EAbezJC18VhyC2+mQQNZZLrGUnqVTaohHUN77Mt6O1lNEw1NzT9LktPDtJEO2CjBR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuq/NQlvMhBN1IONM+yfUhrLJpKwuRutvB4za/A1AsTbVVRPoV
	w4efcG54YX2Mp0BEML2SbwlLZpDV34R8/ztyrw2UiNwQrxdF/ltxq4EX
X-Gm-Gg: AZuq6aJupjn51ju+uBkDVHEOqnb7Jjkmg2jlaXQsFYj2a18En/LQRY+SBa7d4JKkoIQ
	tR+4I8FcF9Z/oQ4ZhaNzJDK3dZTnDF+rzqrk0zBCdFCV9ZaVSBjeFxxyd/YOE5DtZE8TOnwpsEQ
	HMz7XvaxZ3OlQEmP+1Y1QUgyxpE9z++kH6m6IkfuessvZ3YsipL061T/WGRZWBlZEq/BWVVF0aj
	aRT8VzVZbDnjDeIr1mMyft8xJcklhUIyL33uuZHdX6DxOboNPXIkxrFho5yTKUMSQicSGn6O0qQ
	KY0uhZuydoJya6TpTiRCIg3ggoGT3MbH/O1vKepcaWsFvhFu65MqXNOPGlq5SmpafPGNRUpg8a2
	RkBp7TuL8go1ORgLQIhYDiJ7w4m6MugJAhLGn5XfS7ebDAccdMVcaEtiMXIv+gk1wm7ewUtwRjv
	JiE7uyRL0Rh53BaU/y0Ie5ZO4W3UqGEKaX8AhvcvcKM8dh3hOf
X-Received: by 2002:a05:6000:24ca:b0:435:e3fe:7409 with SMTP id ffacd0b85a97d-4379dba6985mr7855742f8f.44.1771152754297;
        Sun, 15 Feb 2026 02:52:34 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad112bsm19259741f8f.36.2026.02.15.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:34 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket resolution by path
Date: Sun, 15 Feb 2026 11:51:50 +0100
Message-ID: <20260215105158.28132-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
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

With this access right, access is granted if either of the following
conditions is met:

* The target socket's filesystem path was allow-listed using a
  LANDLOCK_RULE_PATH_BENEATH rule, *or*:
* The target socket was created in the same Landlock domain in which
  LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.

In case of a denial, connect() and sendmsg() return EACCES, which is
the same error as it is returned if the user does not have the write
bit in the traditional Unix file system permissions of that file.

This feature was created with substantial discussion and input from
Justin Suess, Tingmao Wang and Mickaël Salaün.

Cc: Tingmao Wang <m@maowtm.org>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Suggested-by: Jann Horn <jannh@google.com>
Link: https://github.com/landlock-lsm/linux/issues/36
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                |  10 ++
 security/landlock/access.h                   |  11 +-
 security/landlock/audit.c                    |   1 +
 security/landlock/fs.c                       | 102 ++++++++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   5 +-
 8 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..3a8fc3af0d64 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -248,6 +248,15 @@ struct landlock_net_port_attr {
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
+ *   servers within the same Landlock domain continue to be accessible.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -333,6 +342,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 42c95747d7bd..9a2991688835 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -34,7 +34,7 @@
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
-typedef u16 access_mask_t;
+typedef u32 access_mask_t;
 
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
@@ -76,6 +76,15 @@ struct layer_access_masks {
 	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
 };
 
+static inline bool
+layer_access_masks_empty(const struct layer_access_masks *masks)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++)
+		if (masks->access[i])
+			return false;
+	return true;
+}
+
 /*
  * Tracks domains responsible of a denied access.  This avoids storing in each
  * object the full matrix of per-layer unfulfilled access rights, which is
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
index e764470f588c..76035c6f2bf1 100644
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
@@ -314,7 +315,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 /* clang-format on */
 
 /*
@@ -1561,6 +1563,103 @@ static int hook_path_truncate(const struct path *const path)
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
+	if (WARN_ON_ONCE(!client))
+		return; /* should not happen */
+
+	if (!server)
+		return; /* server has no Landlock domain; nothing to clear */
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
+	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
+			     fs_resolve_unix.fs);
+
+	if (layer_access_masks_empty(&layer_masks))
+		return 0;
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
@@ -1838,6 +1937,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
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
index 0d66a68677b7..933902d43241 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -164,7 +164,7 @@ static const struct file_operations ruleset_fops = {
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
2.52.0

