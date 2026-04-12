Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30811369981
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988521; cv=none; b=dRHvsbezrDYM1gLqlU4Ygof7/sTZMyvv3lD6FjiU+J7WK57BNUoP4vPtD2W7IBKK0z4TfQ6uHU2zqRkBzUOHFWNbYYvz/lYjeN5zuiIbgyArjyi9XaRdUJ9vxL8pf21uZKrthlZQ9JDLBtySf38laHmjBN71InxsX0EsmEzbK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988521; c=relaxed/simple;
	bh=LYWFJ20V2Nblb5y2klMFGI9PeBwew2RPDckfqRZzR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL/7yFi9tI7cVGOFztia93oJ5yMiirOH6Q98IJRvgd4ugGCRh10S/UEzUU/1JaooX9Nm70dgH5xP2Uvacw6z5nLORW0fWPrjg5aK5Mzn//dS5GaAu41N/zydAp0W4CFZ4iyaXHHfWv1//Qow9Wj2lNENGswwaTuKbF9Ml/hdmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=fG+hg+Zb; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="fG+hg+Zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1775988107; bh=LYWFJ20V2Nblb5y2klMFGI9PeBwew2RPDckfqRZzR3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fG+hg+Zb1fPDDtvxTjMs2CwpZMxNsHML6d1X9RetKo2pfZoq5zGwq9Uy+66Q1KkBE
	 GHH0gbU08JyFrz5f5aNFXr43prvAY/7kAdrtbM5T1bsOE3eK5dNS7REYmQukX6dqjI
	 f0zFngOXeDOhB6vTqSky2MD7VGq+m73HhNoq4PGg=
Received: from localhost (lfbn-idf3-1-911-123.w90-3.abo.wanadoo.fr [90.3.226.123])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 9B2D84032E;
	Sun, 12 Apr 2026 12:01:47 +0200 (CEST)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	jeff@bencteux.fr
Subject: [PATCH 2/5] landlock: add support for chmod and chown
Date: Sun, 12 Apr 2026 11:50:41 +0200
Message-ID: <20260412095233.34306-3-jeff@bencteux.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412095233.34306-1-jeff@bencteux.fr>
References: <20260412095233.34306-1-jeff@bencteux.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modifying file permissions and owner are operation of interest when
exploiting applications. This patch adds support for both chmod and
chown system calls family in landlock, allowing one to restrict it for
a given userland application.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 include/uapi/linux/landlock.h | 13 ++++++++++---
 security/landlock/access.h    |  2 +-
 security/landlock/audit.c     |  2 ++
 security/landlock/fs.c        | 17 ++++++++++++++++-
 security/landlock/limits.h    |  2 +-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..815577bda274 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -248,6 +248,12 @@ struct landlock_net_port_attr {
  *
  *   This access right is available since the fifth version of the Landlock
  *   ABI.
+ * - %LANDLOCK_ACCESS_FS_CHMOD: Modify permissions on a file with
+ *   :manpage:`chmod(2)` family system calls (:manpage:`fchmod(2)`,
+ *   :manpage:`fchmodat(2)`, :manpage:`fchmodat2(2)`).
+ * - %LANDLOCK_ACCESS_FS_CHOWN: Change owner of a file with
+ *   :manpage:`chown(2)` family system calls (:manpage:`fchown(2)`,
+ *   :manpage:`fchownat(2)`, :manpage:`lchown(2)`).
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -311,9 +317,8 @@ struct landlock_net_port_attr {
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
- *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
- *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`setxattr(2)`,
+ *   :manpage:`utime(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -333,6 +338,8 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_CHMOD			(1ULL << 16)
+#define LANDLOCK_ACCESS_FS_CHOWN			(1ULL << 17)
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
index 60ff217ab95b..a4dec40d5395 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -37,6 +37,8 @@ static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_CHMOD)] = "fs.chmod",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_CHOWN)] = "fs.chown",
 };
 
 static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e764470f588c..b32d91b733b9 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -314,7 +314,9 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CHMOD | \
+	LANDLOCK_ACCESS_FS_CHOWN)
 /* clang-format on */
 
 /*
@@ -1561,6 +1563,17 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+static int hook_path_chmod(const struct path *const path, umode_t mode)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_CHMOD);
+}
+
+static int hook_path_chown(const struct path *const path, kuid_t uid,
+			    kgid_t gid)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_CHOWN);
+}
+
 /* File hooks */
 
 /**
@@ -1838,6 +1851,8 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(path_chmod, hook_path_chmod),
+	LSM_HOOK_INIT(path_chown, hook_path_chown),
 
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index eb584f47288d..231d60d5bf8b 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -19,7 +19,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CHOWN
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-- 
2.53.0

