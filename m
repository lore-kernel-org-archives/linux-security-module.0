Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3421CBEB9
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592284; cv=none; b=Q3Wq+OK66fjuo6QeLBm9MoXV8/Uenz+jMzi4ooAPBVexr34BceU9M43n/4M+4gjdvWnnC96NoTCBv4Iuo6oOGKCw77lLJAaBDZvPZQe03uq4XV91wKCFLpAoydRI45tNuEnWtffYCsJTPddYVTPa7nnnOWbbRS6p/2+lAD9RnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592284; c=relaxed/simple;
	bh=K761dMRzZwW/UySHt6MutWsigvXkUjQioyrsWEzSVIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifi1ZQk8SPmdIAFThkZLDGEo7rB8lgndp3OcO9lzKLhf0kUPJASWq8mCvcw/CsxrgnHaTrnBVBzxROimHIFglkPc1q6YTPxruP+lMZskJ2yFCc6L5tsbM8VvKib+OcggMvMxOiXCyyvcqr8jlryE9hiBwWWG76FfBvKa1xa9c7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE9wORmw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE9wORmw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4805ef35864so32108385e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592282; x=1771197082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeNIVB/o2HnnOIKy2M/YKP61gC4WPLtyl9kauMPaFrg=;
        b=CE9wORmwEAjS8KdbYpTly0JCg2dm8nyPJV4MmsgVoNLN2Vevzo5rXqmFkGZ9d3hElg
         ev1Txfg8h6IFP87XfOb1Bwl4cb22cE1WKeR4zZh5qM7QB+XQahLDUU4/ecOICWN2T/Xq
         V9BaxPyLC+8FnSH1xBktlBOtzWE8k42fPNvIMMBs5TgNo2adKwHbGFmWJQMv3oFBJT2w
         9Mgpkfm1yg+PwdbAxgy20/80OlaQaeYCJz9pNyLP+w5P4WeCnoJXMtvL7n4Fal8VTzmu
         nAf+znBpvwchMutnuaeDBueJ7jDpwnbLobbeQ1C5O87eWKgoRwTgRdVxo4yUovnco9XZ
         /GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592282; x=1771197082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeNIVB/o2HnnOIKy2M/YKP61gC4WPLtyl9kauMPaFrg=;
        b=uWBOrmPIbl+jow9fwpDrI0b6/3Hi+ckk2j2WGOIEClShketg3u02+JunvqZUpwR+7M
         +TtvVx0enilrmqANhB8gHu91oX+izzbxQsfYA/lKovacYRdLOknr0PP5DuRrfF+HsqOO
         9ErRvCLMNIQzL0QcKFbagAg6/RyNMHXLYXPQuswO8HvYQ4rdJT1Tnv/q6ch3GVtK4g74
         ZfnixiTwu54HBP68Xfz9eR9uMx8OdM5N35WUWu7aXFV5Q3LvnLU6hIrxhWWfyUSMbeFp
         lSqT5mOQornWUB6zjtro2hjhynobsSLs/rNlMAEKYOKMGNJWWiyJt8KW0XJypOOYYcnZ
         Eb1g==
X-Forwarded-Encrypted: i=1; AJvYcCXME8jYFhItHDp1CoXnooBsD6GtYJ8QaE/ZLitOARVBC6MX7QTv7v1drd/9G4ImHLVMh33AFTKB8WlZpzsqAsq3vvMu3pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJIVgsx1N4CCoGBx09PhYk9/VlW9K3StHGfRtiYzaVdrR/T9Xa
	K/6yJM1ZXt8A5NQEFG01aU2CHUkguboDwhNRbH2cksBEFDcFhxX2yBuO
X-Gm-Gg: AZuq6aLcigeprQtmoyGXwJjFthBAB+O22YzCLdq9Tke9f2X7EyD0bASfnAtnjJ4/Qrj
	5CEanV6DRRan0X7RunMRQ8oIYe6NHruVFf64Ay6S8ZGU08EbE0FkLXkPzUNj/HtQo64Zpt+3ikP
	aOYLtMn5BN0g75P9LAzWL8IiiKP0pgx6ykZhjXwe+ZAlOETMEo8jCdkeoLxwFS49+LoTVNYxlUc
	RjI1WP24F4llmslrx4tIWKaEIIu8pzwkZfV+VuNjmcmLkAryKbRwzGEzURhMBmQg0oxoe21NgqS
	Bwp+HCI7pyR2A8B14JaDKpDo+5OAtoIrSCY6DIJTp0xPDoi5b8+AJdPLoA+f+AE0DHUXn1CefAb
	v2tbA4+dMQb1p1CtF01Ai1W3u+VqLqks8S7HQZy8V+Q7RJrAp/TLaXbnP+/Vuw96lxR6NsWvnAi
	poEuz7Brm7Un1Vha7iGsJkhYRLqCpPTqD5z7ak
X-Received: by 2002:a05:600c:5489:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483202280fcmr145262195e9.34.1770592281814;
        Sun, 08 Feb 2026 15:11:21 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm266254145e9.2.2026.02.08.15.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:21 -0800 (PST)
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
Subject: [PATCH v4 2/6] landlock: Control pathname UNIX domain socket resolution by path
Date: Mon,  9 Feb 2026 00:10:12 +0100
Message-ID: <20260208231017.114343-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
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
 security/landlock/fs.c                       | 107 ++++++++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   5 +-
 8 files changed, 133 insertions(+), 7 deletions(-)

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
index e764470f588c..053217048ac9 100644
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
@@ -1561,6 +1563,108 @@ static int hook_path_truncate(const struct path *const path)
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
+	int type = other->sk_type;
+
+	/* Lookup for the purpose of saving coredumps is OK. */
+	if (flags & SOCK_COREDUMP)
+		return 0;
+
+	/* Only stream, dgram and seqpacket sockets are restricted. */
+	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
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
@@ -1838,6 +1942,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
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

