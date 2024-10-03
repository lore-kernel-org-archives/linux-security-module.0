Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712881AB506
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989724; cv=none; b=NPtnb9xGRzWA6JXW8Bi8On9vpXRRKuda7My/7Rwwtl/c/HKyODV7S88/LQbf8okAN4U9jp8KON6yC2NwpOZn9I0G5tQE4b0sUKBccTJu18Kb+nTIbveWuU0mES96cGSZCoFJifsWqRcITBusqHyuPsiyx4zU6/Hz0ODoQnAUAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989724; c=relaxed/simple;
	bh=S7Vh2coaVs8gphAG5DKOMQqJ9GSj6oVBk6fHwx2eMNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAuZMMuXuXEtsdAf+QQ2bWIwQO11vwTX8MiV12GGwRtouZ5eVW0vc099BGq4zIZmTfA9gPIN5dnlBDdXJXWyJ86GK34uAP7qw4rQEMb2qHS8Yw5P4L7KQWxEDQQfdzfuu7UGTHV3kPU1zYqyy08G1KgYCBcNl1qGI1JiOFiTokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NBiMPDA3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NBiMPDA3"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99de9beb2so78275785a.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Oct 2024 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727989720; x=1728594520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sShC+PvpfgALGwAOccsVZPYEVJC7kpbFkqhzKSmrzjw=;
        b=NBiMPDA3EmkoNNIxcHz2Dj8y7XiOehQFsOB/uHfSJubS+78+P6SeNn6eGt8+LOujSA
         5mbsADd7anah7IVubgDvh6hxikeVR0lKfTJA9938vxSGJhyfcQsWpdM+2TAcu3X8mVf3
         CvBm8PTAbDQpbULT0oCER5TOgHGOUzrnBsFxlu7gdZrmKuc5mO+pb6jMJrrDQI2e+7KN
         hjnp4U2GkORlthHZb5oqaztFcWZ0XiqvlP6LYFtC+OCo5GRSigueKZH699xwlLy8ybsi
         tRDnyCyR1+/EVMdXxUxO5G7ahqL+7J9fc3HQzY+Fii2ogPZ3EZBWQWc5GaJC/ZmpsIiM
         eg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989720; x=1728594520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sShC+PvpfgALGwAOccsVZPYEVJC7kpbFkqhzKSmrzjw=;
        b=C5ZL13H6T2LuUhjSEv/LnKQaeCYJ4WEPEsAHGPaFsZ7Zs6BsiHEbQd+0N/2c3jyeEm
         syvln3fQFz7xJkr/KMOBgQ54bwEZzrT6aUgC32xPfcboIK0ivNqu/sH8a2W9O5GyLO7j
         VmtgWIG1ALnisdqVhnGNZ8BAi2ppVuraPWdKvonLQDnBVIjjgDkaLxswI2iaxSO6FQZP
         2MW0WKFFYK/dHKr5Kv5ZlFp9ohlHhe4geHpOmZNIbp/OanwANCtRbpGLse1nwofExuMT
         bszMmpEiR8wU9kvqq9xf82owM+8aBM8+WeBwZH3CXHBXVMmgM7x1NU/w0UvOy0dr3meZ
         uxJg==
X-Gm-Message-State: AOJu0YyhOzsM7KAJuytqkXxlyH/QUjX2IxxAfjCcuAe7VIKT49pvJs1k
	uXFLEPy/cTtjCeQbIvqPIMVXZNqIKBeFX4FF577ikR1COGTWr77TSGLrciLQH3nHt8BL4KHaT6A
	=
X-Google-Smtp-Source: AGHT+IF4Nz3PUqwaNFl+RexlDEOvya906HKTTgC7lGyN8xkbqm07J2pSDtkQdU8ev3luidy8w01Scw==
X-Received: by 2002:a05:620a:1793:b0:7a9:c13d:6e5c with SMTP id af79cd13be357-7ae6f44c5c3mr65836585a.29.1727989719713;
        Thu, 03 Oct 2024 14:08:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e1e3sm80149785a.16.2024.10.03.14.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:08:39 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	tomoyo-dev-en@lists.osdn.me
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH] tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support
Date: Thu,  3 Oct 2024 17:08:32 -0400
Message-ID: <20241003210831.387261-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31638; i=paul@paul-moore.com; h=from:subject; bh=S7Vh2coaVs8gphAG5DKOMQqJ9GSj6oVBk6fHwx2eMNc=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBm/wfPRgpYv/iPpB2Cs6wTRv2MG+61G/NOfFyaQ xfQYeOmyEOJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZv8HzwAKCRDqIPLalzeJ c18uD/4nWGafTjVL9YEafPHBiuGC47jptkj+uy8dFqJ6/7T0CjBjJl5OjLEu6YKzRzK7YCBCFku 0+LzMoZBH9SaebKYaqsJ5dj8W8HzZ8kFZFx54ZmtbZruIwqbSfqgLrIlnL3+Vpyxn2sbb0vDj95 GcykdSL9xIDP3y9xu911QdwQY06V6/KQLkaYbqKzwadrBw+4f8QeXxVoISn5Q3veyFhyMPo3c0U zJYUF1FertZ/M3WnI8/wLvW9qeSAgb54MRaDf3Z3+4bnSuw/MI/Kbsw6g1KvSo7iC5ntVK4F7iA oy6amjwzzrwHtCDiMEaWLwyZF1LUciYZaxaHxATpCbPDs+x5kSsxxKOALcz0sg0PR8l9BwkJSZH d/fRUHw9wYlRUPstts5M84FibgvU2FaH23iZZOI/pN0osrPcDaiBAW4iGZ/S+7R9n9JrQPsiVzr 47qGeoz2idCbi+Xg1jYFiEwaUUAlqk5JBRwtIJ3ZNU9pJDTOU9Px7dZ3TCAFYG4/l3I3nerd/WF Fh/tLOe2MXee+o2PJJT4Y/RTVHWpz2y1C/cLsfrFNuQWEXPxS8BH+K2dZG+ccXWUZvyi86vRowg SwN7hlNAqYEECnhGLweXlkvV2MlceVcy/xa3+PIXlTOiTh25tvoMpYZ85xmwVjGHPpNJ7ctSarJ 8s4a3XKOtgdriGg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This patch reverts two TOMOYO patches that were merged into Linus' tree
during the v6.12 merge window:

8b985bbfabbe ("tomoyo: allow building as a loadable LSM module")
268225a1de1a ("tomoyo: preparation step for building as a loadable LSM module")

Together these two patches introduced the CONFIG_SECURITY_TOMOYO_LKM
Kconfig build option which enabled a TOMOYO specific dynamic LSM loading
mechanism (see the original commits for more details).  Unfortunately,
this approach was widely rejected by the LSM community as well as some
members of the general kernel community.  Objections included concerns
over setting a bad precedent regarding individual LSMs managing their
LSM callback registrations as well as general kernel symbol exporting
practices.  With little to no support for the CONFIG_SECURITY_TOMOYO_LKM
approach outside of Tetsuo, and multiple objections, we need to revert
these changes.

Link: https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp
Link: https://lore.kernel.org/all/CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com
Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/tomoyo/Kconfig               |  15 --
 security/tomoyo/Makefile              |   8 +-
 security/tomoyo/common.c              |  14 +-
 security/tomoyo/common.h              |  72 -----
 security/tomoyo/gc.c                  |   3 -
 security/tomoyo/init.c                | 366 --------------------------
 security/tomoyo/load_policy.c         |  12 -
 security/tomoyo/proxy.c               |  82 ------
 security/tomoyo/securityfs_if.c       |  10 +-
 security/tomoyo/{hooks.h => tomoyo.c} | 110 +++++++-
 security/tomoyo/util.c                |   3 +
 11 files changed, 118 insertions(+), 577 deletions(-)
 delete mode 100644 security/tomoyo/init.c
 delete mode 100644 security/tomoyo/proxy.c
 rename security/tomoyo/{hooks.h => tomoyo.c} (79%)

diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index 90eccc6cd464..1e0dd1a6d0b0 100644
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@ -13,21 +13,6 @@ config SECURITY_TOMOYO
 	  found at <https://tomoyo.sourceforge.net/>.
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_TOMOYO_LKM
-	bool "Cut out most of TOMOYO's code to a loadable kernel module"
-	default n
-	depends on SECURITY_TOMOYO
-	depends on MODULES
-	help
-	  Say Y here if you want to include TOMOYO without bloating
-	  vmlinux file. If you say Y, most of TOMOYO code is cut out to
-	  a loadable kernel module named tomoyo.ko . This option will be
-	  useful for kernels built by Linux distributors where TOMOYO is
-	  included but TOMOYO is not enabled by default. Please be sure
-	  to explicitly load tomoyo.ko if you want to activate TOMOYO
-	  without calling userspace policy loader, for tomoyo.ko is
-	  loaded immediately before calling userspace policy loader.
-
 config SECURITY_TOMOYO_MAX_ACCEPT_ENTRY
 	int "Default maximal count for learning mode"
 	default 2048
diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index 287a7d16fa15..55c67b9846a9 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -1,11 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-tomoyo-objs := audit.o common.o condition.o domain.o environ.o file.o gc.o group.o memory.o mount.o network.o proxy.o realpath.o securityfs_if.o util.o
-obj-y += init.o load_policy.o
-ifdef CONFIG_SECURITY_TOMOYO_LKM
-obj-m += tomoyo.o
-else
-obj-y += tomoyo.o
-endif
+obj-y = audit.o common.o condition.o domain.o environ.o file.o gc.o group.o load_policy.o memory.o mount.o network.o realpath.o securityfs_if.o tomoyo.o util.o
 
 targets += builtin-policy.h
 
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index c0ef014f8009..5c7b059a332a 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -998,13 +998,8 @@ static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
 			p = find_task_by_pid_ns(pid, &init_pid_ns);
 		else
 			p = find_task_by_vpid(pid);
-		if (p) {
+		if (p)
 			domain = tomoyo_task(p)->domain_info;
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-			if (!domain)
-				domain = &tomoyo_kernel_domain;
-#endif
-		}
 		rcu_read_unlock();
 	} else if (!strncmp(data, "domain=", 7)) {
 		if (tomoyo_domain_def(data + 7))
@@ -1715,13 +1710,8 @@ static void tomoyo_read_pid(struct tomoyo_io_buffer *head)
 		p = find_task_by_pid_ns(pid, &init_pid_ns);
 	else
 		p = find_task_by_vpid(pid);
-	if (p) {
+	if (p)
 		domain = tomoyo_task(p)->domain_info;
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-		if (!domain)
-			domain = &tomoyo_kernel_domain;
-#endif
-	}
 	rcu_read_unlock();
 	if (!domain)
 		return;
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 4f6c52a9f478..0e8e2e959aef 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -978,7 +978,6 @@ int tomoyo_get_mode(const struct tomoyo_policy_namespace *ns, const u8 profile,
 int tomoyo_init_request_info(struct tomoyo_request_info *r,
 			     struct tomoyo_domain_info *domain,
 			     const u8 index);
-int __init tomoyo_interface_init(void);
 int tomoyo_mkdev_perm(const u8 operation, const struct path *path,
 		      const unsigned int mode, unsigned int dev);
 int tomoyo_mount_permission(const char *dev_name, const struct path *path,
@@ -1215,14 +1214,10 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  *
  * Returns pointer to "struct tomoyo_task" for specified thread.
  */
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-extern struct tomoyo_task *tomoyo_task(struct task_struct *task);
-#else
 static inline struct tomoyo_task *tomoyo_task(struct task_struct *task)
 {
 	return task->security + tomoyo_blob_sizes.lbs_task;
 }
-#endif
 
 /**
  * tomoyo_same_name_union - Check for duplicated "struct tomoyo_name_union" entry.
@@ -1289,71 +1284,4 @@ static inline struct tomoyo_policy_namespace *tomoyo_current_namespace(void)
 		pos =  srcu_dereference((head)->next, &tomoyo_ss);	\
 	for ( ; pos != (head); pos = srcu_dereference(pos->next, &tomoyo_ss))
 
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-
-#define LSM_HOOK(RET, DEFAULT, NAME, ...) typedef RET (NAME##_t)(__VA_ARGS__);
-#include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
-
-struct tomoyo_hooks {
-	cred_prepare_t *cred_prepare;
-	bprm_committed_creds_t *bprm_committed_creds;
-	task_alloc_t *task_alloc;
-	task_free_t *task_free;
-	bprm_check_security_t *bprm_check_security;
-	file_fcntl_t *file_fcntl;
-	file_open_t *file_open;
-	file_truncate_t *file_truncate;
-	path_truncate_t *path_truncate;
-	path_unlink_t *path_unlink;
-	path_mkdir_t *path_mkdir;
-	path_rmdir_t *path_rmdir;
-	path_symlink_t *path_symlink;
-	path_mknod_t *path_mknod;
-	path_link_t *path_link;
-	path_rename_t *path_rename;
-	inode_getattr_t *inode_getattr;
-	file_ioctl_t *file_ioctl;
-	file_ioctl_compat_t *file_ioctl_compat;
-	path_chmod_t *path_chmod;
-	path_chown_t *path_chown;
-	path_chroot_t *path_chroot;
-	sb_mount_t *sb_mount;
-	sb_umount_t *sb_umount;
-	sb_pivotroot_t *sb_pivotroot;
-	socket_bind_t *socket_bind;
-	socket_connect_t *socket_connect;
-	socket_listen_t *socket_listen;
-	socket_sendmsg_t *socket_sendmsg;
-};
-
-extern void tomoyo_register_hooks(const struct tomoyo_hooks *tomoyo_hooks);
-
-struct tomoyo_operations {
-	void (*check_profile)(void);
-	int enabled;
-};
-
-extern struct tomoyo_operations tomoyo_ops;
-
-/*
- * Temporary hack: functions needed by tomoyo.ko . This will be removed
- * after all functions are marked as EXPORT_STMBOL_GPL().
- */
-struct tomoyo_tmp_exports {
-	struct task_struct * (*find_task_by_vpid)(pid_t nr);
-	struct task_struct * (*find_task_by_pid_ns)(pid_t nr, struct pid_namespace *ns);
-	void (*put_filesystem)(struct file_system_type *fs);
-	struct file * (*get_mm_exe_file)(struct mm_struct *mm);
-	char * (*d_absolute_path)(const struct path *path, char *buf, int buflen);
-};
-extern const struct tomoyo_tmp_exports tomoyo_tmp_exports;
-#define find_task_by_vpid tomoyo_tmp_exports.find_task_by_vpid
-#define find_task_by_pid_ns tomoyo_tmp_exports.find_task_by_pid_ns
-#define put_filesystem tomoyo_tmp_exports.put_filesystem
-#define get_mm_exe_file tomoyo_tmp_exports.get_mm_exe_file
-#define d_absolute_path tomoyo_tmp_exports.d_absolute_path
-
-#endif /* defined(CONFIG_SECURITY_TOMOYO_LKM) */
-
 #endif /* !defined(_SECURITY_TOMOYO_COMMON_H) */
diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
index 6eccca150839..026e29ea3796 100644
--- a/security/tomoyo/gc.c
+++ b/security/tomoyo/gc.c
@@ -9,9 +9,6 @@
 #include <linux/kthread.h>
 #include <linux/slab.h>
 
-/* Lock for GC. */
-DEFINE_SRCU(tomoyo_ss);
-
 /**
  * tomoyo_memory_free - Free memory for elements.
  *
diff --git a/security/tomoyo/init.c b/security/tomoyo/init.c
deleted file mode 100644
index 034e7db22d4e..000000000000
--- a/security/tomoyo/init.c
+++ /dev/null
@@ -1,366 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * security/tomoyo/init.c
- *
- * Copyright (C) 2005-2011  NTT DATA CORPORATION
- */
-
-#include <linux/lsm_hooks.h>
-#include <uapi/linux/lsm.h>
-#include "common.h"
-
-#ifndef CONFIG_SECURITY_TOMOYO_LKM
-
-#include "hooks.h"
-
-#else
-
-#define DEFINE_STATIC_CALL_PROXY(NAME)				\
-	static NAME##_t tomoyo_##NAME;				\
-	DEFINE_STATIC_CALL_RET0(tomoyo_##NAME, tomoyo_##NAME);
-DEFINE_STATIC_CALL_PROXY(cred_prepare)
-DEFINE_STATIC_CALL_PROXY(bprm_committed_creds)
-DEFINE_STATIC_CALL_PROXY(bprm_check_security)
-DEFINE_STATIC_CALL_PROXY(inode_getattr)
-DEFINE_STATIC_CALL_PROXY(path_truncate)
-DEFINE_STATIC_CALL_PROXY(file_truncate)
-DEFINE_STATIC_CALL_PROXY(path_unlink)
-DEFINE_STATIC_CALL_PROXY(path_mkdir)
-DEFINE_STATIC_CALL_PROXY(path_rmdir)
-DEFINE_STATIC_CALL_PROXY(path_symlink)
-DEFINE_STATIC_CALL_PROXY(path_mknod)
-DEFINE_STATIC_CALL_PROXY(path_link)
-DEFINE_STATIC_CALL_PROXY(path_rename)
-DEFINE_STATIC_CALL_PROXY(file_fcntl)
-DEFINE_STATIC_CALL_PROXY(file_open)
-DEFINE_STATIC_CALL_PROXY(file_ioctl)
-DEFINE_STATIC_CALL_PROXY(path_chmod)
-DEFINE_STATIC_CALL_PROXY(path_chown)
-DEFINE_STATIC_CALL_PROXY(path_chroot)
-DEFINE_STATIC_CALL_PROXY(sb_mount)
-DEFINE_STATIC_CALL_PROXY(sb_umount)
-DEFINE_STATIC_CALL_PROXY(sb_pivotroot)
-DEFINE_STATIC_CALL_PROXY(socket_listen)
-DEFINE_STATIC_CALL_PROXY(socket_connect)
-DEFINE_STATIC_CALL_PROXY(socket_bind)
-DEFINE_STATIC_CALL_PROXY(socket_sendmsg)
-DEFINE_STATIC_CALL_PROXY(task_alloc)
-DEFINE_STATIC_CALL_PROXY(task_free)
-#undef DEFINE_STATIC_CALL_PROXY
-
-static int tomoyo_cred_prepare(struct cred *new, const struct cred *old, gfp_t gfp)
-{
-	return static_call(tomoyo_cred_prepare)(new, old, gfp);
-}
-
-static void tomoyo_bprm_committed_creds(const struct linux_binprm *bprm)
-{
-	static_call(tomoyo_bprm_committed_creds)(bprm);
-}
-
-static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
-{
-	return static_call(tomoyo_bprm_check_security)(bprm);
-}
-
-static int tomoyo_inode_getattr(const struct path *path)
-{
-	return static_call(tomoyo_inode_getattr)(path);
-}
-
-static int tomoyo_path_truncate(const struct path *path)
-{
-	return static_call(tomoyo_path_truncate)(path);
-}
-
-static int tomoyo_file_truncate(struct file *file)
-{
-	return static_call(tomoyo_file_truncate)(file);
-}
-
-static int tomoyo_path_unlink(const struct path *parent, struct dentry *dentry)
-{
-	return static_call(tomoyo_path_unlink)(parent, dentry);
-}
-
-static int tomoyo_path_mkdir(const struct path *parent, struct dentry *dentry, umode_t mode)
-{
-	return static_call(tomoyo_path_mkdir)(parent, dentry, mode);
-}
-
-static int tomoyo_path_rmdir(const struct path *parent, struct dentry *dentry)
-{
-	return static_call(tomoyo_path_rmdir)(parent, dentry);
-}
-
-static int tomoyo_path_symlink(const struct path *parent, struct dentry *dentry,
-			       const char *old_name)
-{
-	return static_call(tomoyo_path_symlink)(parent, dentry, old_name);
-}
-
-static int tomoyo_path_mknod(const struct path *parent, struct dentry *dentry,
-			     umode_t mode, unsigned int dev)
-{
-	return static_call(tomoyo_path_mknod)(parent, dentry, mode, dev);
-}
-
-static int tomoyo_path_link(struct dentry *old_dentry, const struct path *new_dir,
-			    struct dentry *new_dentry)
-{
-	return static_call(tomoyo_path_link)(old_dentry, new_dir, new_dentry);
-}
-
-static int tomoyo_path_rename(const struct path *old_parent, struct dentry *old_dentry,
-			      const struct path *new_parent, struct dentry *new_dentry,
-			      const unsigned int flags)
-{
-	return static_call(tomoyo_path_rename)(old_parent, old_dentry, new_parent, new_dentry, flags);
-}
-
-static int tomoyo_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return static_call(tomoyo_file_fcntl)(file, cmd, arg);
-}
-
-static int tomoyo_file_open(struct file *f)
-{
-	return static_call(tomoyo_file_open)(f);
-}
-
-static int tomoyo_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return static_call(tomoyo_file_ioctl)(file, cmd, arg);
-}
-
-static int tomoyo_path_chmod(const struct path *path, umode_t mode)
-{
-	return static_call(tomoyo_path_chmod)(path, mode);
-}
-
-static int tomoyo_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
-{
-	return static_call(tomoyo_path_chown)(path, uid, gid);
-}
-
-static int tomoyo_path_chroot(const struct path *path)
-{
-	return static_call(tomoyo_path_chroot)(path);
-}
-
-static int tomoyo_sb_mount(const char *dev_name, const struct path *path,
-			   const char *type, unsigned long flags, void *data)
-{
-	return static_call(tomoyo_sb_mount)(dev_name, path, type, flags, data);
-}
-
-static int tomoyo_sb_umount(struct vfsmount *mnt, int flags)
-{
-	return static_call(tomoyo_sb_umount)(mnt, flags);
-}
-
-static int tomoyo_sb_pivotroot(const struct path *old_path, const struct path *new_path)
-{
-	return static_call(tomoyo_sb_pivotroot)(old_path, new_path);
-}
-
-static int tomoyo_socket_listen(struct socket *sock, int backlog)
-{
-	return static_call(tomoyo_socket_listen)(sock, backlog);
-}
-
-static int tomoyo_socket_connect(struct socket *sock, struct sockaddr *addr, int addr_len)
-{
-	return static_call(tomoyo_socket_connect)(sock, addr, addr_len);
-}
-
-static int tomoyo_socket_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
-{
-	return static_call(tomoyo_socket_bind)(sock, addr, addr_len);
-}
-
-static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
-{
-	return static_call(tomoyo_socket_sendmsg)(sock, msg, size);
-}
-
-static int tomoyo_task_alloc(struct task_struct *task, unsigned long clone_flags)
-{
-	return static_call(tomoyo_task_alloc)(task, clone_flags);
-}
-
-static void tomoyo_task_free(struct task_struct *task)
-{
-	static_call(tomoyo_task_free)(task);
-}
-
-void tomoyo_register_hooks(const struct tomoyo_hooks *tomoyo_hooks)
-{
-	static void *registered;
-
-	if (cmpxchg(&registered, NULL, &registered))
-		panic("%s was called twice!\n", __func__);
-	static_call_update(tomoyo_task_free, tomoyo_hooks->task_free);
-	static_call_update(tomoyo_task_alloc, tomoyo_hooks->task_alloc);
-	static_call_update(tomoyo_cred_prepare, tomoyo_hooks->cred_prepare);
-	static_call_update(tomoyo_bprm_committed_creds, tomoyo_hooks->bprm_committed_creds);
-	static_call_update(tomoyo_bprm_check_security, tomoyo_hooks->bprm_check_security);
-	static_call_update(tomoyo_inode_getattr, tomoyo_hooks->inode_getattr);
-	static_call_update(tomoyo_path_truncate, tomoyo_hooks->path_truncate);
-	static_call_update(tomoyo_file_truncate, tomoyo_hooks->file_truncate);
-	static_call_update(tomoyo_path_unlink, tomoyo_hooks->path_unlink);
-	static_call_update(tomoyo_path_mkdir, tomoyo_hooks->path_mkdir);
-	static_call_update(tomoyo_path_rmdir, tomoyo_hooks->path_rmdir);
-	static_call_update(tomoyo_path_symlink, tomoyo_hooks->path_symlink);
-	static_call_update(tomoyo_path_mknod, tomoyo_hooks->path_mknod);
-	static_call_update(tomoyo_path_link, tomoyo_hooks->path_link);
-	static_call_update(tomoyo_path_rename, tomoyo_hooks->path_rename);
-	static_call_update(tomoyo_file_fcntl, tomoyo_hooks->file_fcntl);
-	static_call_update(tomoyo_file_open, tomoyo_hooks->file_open);
-	static_call_update(tomoyo_file_ioctl, tomoyo_hooks->file_ioctl);
-	static_call_update(tomoyo_path_chmod, tomoyo_hooks->path_chmod);
-	static_call_update(tomoyo_path_chown, tomoyo_hooks->path_chown);
-	static_call_update(tomoyo_path_chroot, tomoyo_hooks->path_chroot);
-	static_call_update(tomoyo_sb_mount, tomoyo_hooks->sb_mount);
-	static_call_update(tomoyo_sb_umount, tomoyo_hooks->sb_umount);
-	static_call_update(tomoyo_sb_pivotroot, tomoyo_hooks->sb_pivotroot);
-	static_call_update(tomoyo_socket_listen, tomoyo_hooks->socket_listen);
-	static_call_update(tomoyo_socket_connect, tomoyo_hooks->socket_connect);
-	static_call_update(tomoyo_socket_bind, tomoyo_hooks->socket_bind);
-	static_call_update(tomoyo_socket_sendmsg, tomoyo_hooks->socket_sendmsg);
-}
-EXPORT_SYMBOL_GPL(tomoyo_register_hooks);
-
-/*
- * Temporary hack: functions needed by tomoyo.ko . This hack will be removed
- * after all functions are marked as EXPORT_STMBOL_GPL().
- */
-#undef find_task_by_vpid
-#undef find_task_by_pid_ns
-#undef put_filesystem
-#undef get_mm_exe_file
-#undef d_absolute_path
-const struct tomoyo_tmp_exports tomoyo_tmp_exports = {
-	.find_task_by_vpid = find_task_by_vpid,
-	.find_task_by_pid_ns = find_task_by_pid_ns,
-	.put_filesystem = put_filesystem,
-	.get_mm_exe_file = get_mm_exe_file,
-	.d_absolute_path = d_absolute_path,
-};
-EXPORT_SYMBOL_GPL(tomoyo_tmp_exports);
-
-#endif
-
-#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
-static int tomoyo_bprm_creds_for_exec(struct linux_binprm *bprm)
-{
-	/*
-	 * Load policy if /sbin/tomoyo-init exists and /sbin/init is requested
-	 * for the first time.
-	 */
-	if (!tomoyo_policy_loaded)
-		tomoyo_load_policy(bprm->filename);
-	return 0;
-}
-#endif
-
-struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
-	.lbs_task = sizeof(struct tomoyo_task),
-};
-
-static const struct lsm_id tomoyo_lsmid = {
-	.name = "tomoyo",
-	.id = LSM_ID_TOMOYO,
-};
-
-/* tomoyo_hooks is used for registering TOMOYO. */
-static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
-	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
-	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
-	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
-	LSM_HOOK_INIT(task_free, tomoyo_task_free),
-#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
-	LSM_HOOK_INIT(bprm_creds_for_exec, tomoyo_bprm_creds_for_exec),
-#endif
-	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
-	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
-	LSM_HOOK_INIT(file_open, tomoyo_file_open),
-	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
-	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
-	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
-	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),
-	LSM_HOOK_INIT(path_rmdir, tomoyo_path_rmdir),
-	LSM_HOOK_INIT(path_symlink, tomoyo_path_symlink),
-	LSM_HOOK_INIT(path_mknod, tomoyo_path_mknod),
-	LSM_HOOK_INIT(path_link, tomoyo_path_link),
-	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
-	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
-	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
-	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
-	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
-	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
-	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
-	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
-	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
-	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
-	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
-	LSM_HOOK_INIT(socket_connect, tomoyo_socket_connect),
-	LSM_HOOK_INIT(socket_listen, tomoyo_socket_listen),
-	LSM_HOOK_INIT(socket_sendmsg, tomoyo_socket_sendmsg),
-};
-
-int tomoyo_enabled __ro_after_init = 1;
-
-/* Has /sbin/init started? */
-bool tomoyo_policy_loaded;
-
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-EXPORT_SYMBOL_GPL(tomoyo_blob_sizes);
-EXPORT_SYMBOL_GPL(tomoyo_policy_loaded);
-
-struct tomoyo_operations tomoyo_ops;
-EXPORT_SYMBOL_GPL(tomoyo_ops);
-
-/**
- * tomoyo_init - Reserve hooks for TOMOYO Linux.
- *
- * Returns 0.
- */
-static int __init tomoyo_init(void)
-{
-	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), &tomoyo_lsmid);
-	tomoyo_ops.enabled = tomoyo_enabled;
-	pr_info("Hooks for initializing TOMOYO Linux are ready\n");
-	return 0;
-}
-#else
-/**
- * tomoyo_init - Register TOMOYO Linux as a LSM module.
- *
- * Returns 0.
- */
-static int __init tomoyo_init(void)
-{
-	struct tomoyo_task *s = tomoyo_task(current);
-
-	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
-			   &tomoyo_lsmid);
-	pr_info("TOMOYO Linux initialized\n");
-	s->domain_info = &tomoyo_kernel_domain;
-	atomic_inc(&tomoyo_kernel_domain.users);
-	s->old_domain_info = NULL;
-	tomoyo_mm_init();
-
-	return 0;
-}
-#endif
-
-DEFINE_LSM(tomoyo) = {
-	.name = "tomoyo",
-	.enabled = &tomoyo_enabled,
-	.flags = LSM_FLAG_LEGACY_MAJOR,
-	.blobs = &tomoyo_blob_sizes,
-	.init = tomoyo_init,
-};
diff --git a/security/tomoyo/load_policy.c b/security/tomoyo/load_policy.c
index 6a2a72354a64..363b65be87ab 100644
--- a/security/tomoyo/load_policy.c
+++ b/security/tomoyo/load_policy.c
@@ -97,14 +97,6 @@ void tomoyo_load_policy(const char *filename)
 	if (!tomoyo_policy_loader_exists())
 		return;
 	done = true;
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-	/* Load tomoyo.ko if not yet loaded. */
-	if (!tomoyo_ops.check_profile)
-		request_module("tomoyo");
-	/* Check if tomoyo.ko was successfully loaded. */
-	if (!tomoyo_ops.check_profile)
-		panic("Failed to load tomoyo module.");
-#endif
 	pr_info("Calling %s to load policy. Please wait.\n", tomoyo_loader);
 	argv[0] = (char *) tomoyo_loader;
 	argv[1] = NULL;
@@ -112,11 +104,7 @@ void tomoyo_load_policy(const char *filename)
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[2] = NULL;
 	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-	tomoyo_ops.check_profile();
-#else
 	tomoyo_check_profile();
-#endif
 }
 
 #endif
diff --git a/security/tomoyo/proxy.c b/security/tomoyo/proxy.c
deleted file mode 100644
index 1618cc0f2af8..000000000000
--- a/security/tomoyo/proxy.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * security/tomoyo/proxy.c
- *
- * Copyright (C) 2005-2011  NTT DATA CORPORATION
- */
-
-#include <linux/security.h>
-#include "common.h"
-
-#ifdef CONFIG_SECURITY_TOMOYO_LKM
-
-struct tomoyo_task *tomoyo_task(struct task_struct *task)
-{
-	struct tomoyo_task *s = task->security + tomoyo_blob_sizes.lbs_task;
-
-	if (unlikely(!s->domain_info)) {
-		if (likely(task == current)) {
-			s->domain_info = &tomoyo_kernel_domain;
-			atomic_inc(&tomoyo_kernel_domain.users);
-		} else {
-			/* Caller handles s->domain_info == NULL case. */
-		}
-	}
-	return s;
-}
-
-#include "hooks.h"
-
-/**
- * tomoyo_runtime_init - Register TOMOYO Linux as a loadable LSM module.
- *
- * Returns 0 if TOMOYO is enabled, -EINVAL otherwise.
- */
-static int __init tomoyo_runtime_init(void)
-{
-	const struct tomoyo_hooks tomoyo_hooks = {
-		.cred_prepare = tomoyo_cred_prepare,
-		.bprm_committed_creds = tomoyo_bprm_committed_creds,
-		.task_alloc = tomoyo_task_alloc,
-		.task_free = tomoyo_task_free,
-		.bprm_check_security = tomoyo_bprm_check_security,
-		.file_fcntl = tomoyo_file_fcntl,
-		.file_open = tomoyo_file_open,
-		.file_truncate = tomoyo_file_truncate,
-		.path_truncate = tomoyo_path_truncate,
-		.path_unlink = tomoyo_path_unlink,
-		.path_mkdir = tomoyo_path_mkdir,
-		.path_rmdir = tomoyo_path_rmdir,
-		.path_symlink = tomoyo_path_symlink,
-		.path_mknod = tomoyo_path_mknod,
-		.path_link = tomoyo_path_link,
-		.path_rename = tomoyo_path_rename,
-		.inode_getattr = tomoyo_inode_getattr,
-		.file_ioctl = tomoyo_file_ioctl,
-		.file_ioctl_compat = tomoyo_file_ioctl,
-		.path_chmod = tomoyo_path_chmod,
-		.path_chown = tomoyo_path_chown,
-		.path_chroot = tomoyo_path_chroot,
-		.sb_mount = tomoyo_sb_mount,
-		.sb_umount = tomoyo_sb_umount,
-		.sb_pivotroot = tomoyo_sb_pivotroot,
-		.socket_bind = tomoyo_socket_bind,
-		.socket_connect = tomoyo_socket_connect,
-		.socket_listen = tomoyo_socket_listen,
-		.socket_sendmsg = tomoyo_socket_sendmsg,
-	};
-
-	if (!tomoyo_ops.enabled)
-		return -EINVAL;
-	tomoyo_ops.check_profile = tomoyo_check_profile;
-	pr_info("TOMOYO Linux initialized\n");
-	tomoyo_task(current);
-	tomoyo_mm_init();
-	tomoyo_interface_init();
-	tomoyo_register_hooks(&tomoyo_hooks);
-	return 0;
-}
-module_init(tomoyo_runtime_init);
-MODULE_LICENSE("GPL");
-
-#endif
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index a3b821b7f477..a2705798476f 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -229,19 +229,17 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
 }
 
 /**
- * tomoyo_interface_init - Initialize /sys/kernel/security/tomoyo/ interface.
+ * tomoyo_initerface_init - Initialize /sys/kernel/security/tomoyo/ interface.
  *
  * Returns 0.
  */
-int __init tomoyo_interface_init(void)
+static int __init tomoyo_initerface_init(void)
 {
 	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
 
-#ifndef CONFIG_SECURITY_TOMOYO_LKM
 	if (!tomoyo_enabled)
 		return 0;
-#endif
 	domain = tomoyo_domain();
 	/* Don't create securityfs entries unless registered. */
 	if (domain != &tomoyo_kernel_domain)
@@ -272,6 +270,4 @@ int __init tomoyo_interface_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SECURITY_TOMOYO_LKM
-fs_initcall(tomoyo_interface_init);
-#endif
+fs_initcall(tomoyo_initerface_init);
diff --git a/security/tomoyo/hooks.h b/security/tomoyo/tomoyo.c
similarity index 79%
rename from security/tomoyo/hooks.h
rename to security/tomoyo/tomoyo.c
index 58929bb71477..04a92c3d65d4 100644
--- a/security/tomoyo/hooks.h
+++ b/security/tomoyo/tomoyo.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * security/tomoyo/hooks.h
+ * security/tomoyo/tomoyo.c
  *
  * Copyright (C) 2005-2011  NTT DATA CORPORATION
  */
 
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -16,6 +18,10 @@ struct tomoyo_domain_info *tomoyo_domain(void)
 {
 	struct tomoyo_task *s = tomoyo_task(current);
 
+	if (s->old_domain_info && !current->in_execve) {
+		atomic_dec(&s->old_domain_info->users);
+		s->old_domain_info = NULL;
+	}
 	return s->domain_info;
 }
 
@@ -56,6 +62,26 @@ static void tomoyo_bprm_committed_creds(const struct linux_binprm *bprm)
 	s->old_domain_info = NULL;
 }
 
+#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
+/**
+ * tomoyo_bprm_creds_for_exec - Target for security_bprm_creds_for_exec().
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ *
+ * Returns 0.
+ */
+static int tomoyo_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	/*
+	 * Load policy if /sbin/tomoyo-init exists and /sbin/init is requested
+	 * for the first time.
+	 */
+	if (!tomoyo_policy_loaded)
+		tomoyo_load_policy(bprm->filename);
+	return 0;
+}
+#endif
+
 /**
  * tomoyo_bprm_check_security - Target for security_bprm_check().
  *
@@ -475,6 +501,10 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
 
+struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
+	.lbs_task = sizeof(struct tomoyo_task),
+};
+
 /**
  * tomoyo_task_alloc - Target for security_task_alloc().
  *
@@ -513,3 +543,81 @@ static void tomoyo_task_free(struct task_struct *task)
 		s->old_domain_info = NULL;
 	}
 }
+
+static const struct lsm_id tomoyo_lsmid = {
+	.name = "tomoyo",
+	.id = LSM_ID_TOMOYO,
+};
+
+/*
+ * tomoyo_security_ops is a "struct security_operations" which is used for
+ * registering TOMOYO.
+ */
+static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
+	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
+	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
+	LSM_HOOK_INIT(task_free, tomoyo_task_free),
+#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
+	LSM_HOOK_INIT(bprm_creds_for_exec, tomoyo_bprm_creds_for_exec),
+#endif
+	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
+	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
+	LSM_HOOK_INIT(file_open, tomoyo_file_open),
+	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
+	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
+	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
+	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),
+	LSM_HOOK_INIT(path_rmdir, tomoyo_path_rmdir),
+	LSM_HOOK_INIT(path_symlink, tomoyo_path_symlink),
+	LSM_HOOK_INIT(path_mknod, tomoyo_path_mknod),
+	LSM_HOOK_INIT(path_link, tomoyo_path_link),
+	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
+	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
+	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
+	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
+	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
+	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
+	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
+	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
+	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
+	LSM_HOOK_INIT(socket_connect, tomoyo_socket_connect),
+	LSM_HOOK_INIT(socket_listen, tomoyo_socket_listen),
+	LSM_HOOK_INIT(socket_sendmsg, tomoyo_socket_sendmsg),
+};
+
+/* Lock for GC. */
+DEFINE_SRCU(tomoyo_ss);
+
+int tomoyo_enabled __ro_after_init = 1;
+
+/**
+ * tomoyo_init - Register TOMOYO Linux as a LSM module.
+ *
+ * Returns 0.
+ */
+static int __init tomoyo_init(void)
+{
+	struct tomoyo_task *s = tomoyo_task(current);
+
+	/* register ourselves with the security framework */
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
+	pr_info("TOMOYO Linux initialized\n");
+	s->domain_info = &tomoyo_kernel_domain;
+	atomic_inc(&tomoyo_kernel_domain.users);
+	s->old_domain_info = NULL;
+	tomoyo_mm_init();
+
+	return 0;
+}
+
+DEFINE_LSM(tomoyo) = {
+	.name = "tomoyo",
+	.enabled = &tomoyo_enabled,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.blobs = &tomoyo_blob_sizes,
+	.init = tomoyo_init,
+};
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index b851ff377382..6799b1122c9d 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -13,6 +13,9 @@
 /* Lock for protecting policy. */
 DEFINE_MUTEX(tomoyo_policy_lock);
 
+/* Has /sbin/init started? */
+bool tomoyo_policy_loaded;
+
 /*
  * Mapping table from "enum tomoyo_mac_index" to
  * "enum tomoyo_mac_category_index".
-- 
2.46.2

