Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F20BC43217
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKBRMT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKBRLi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683C186FE
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:35 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAvah021893;
        Thu, 3 Nov 2022 02:10:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkJ021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 08/10] CaitSith: Add pathname calculation functions.
Date:   Thu,  3 Nov 2022 02:10:23 +0900
Message-Id: <20221102171025.126961-8-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This file implements similar functions provided by
security/tomoyo/realpath.c file.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/caitsith/realpath.c | 415 +++++++++++++++++++++++++++++++++++
 1 file changed, 415 insertions(+)
 create mode 100644 security/caitsith/realpath.c

diff --git a/security/caitsith/realpath.c b/security/caitsith/realpath.c
new file mode 100644
index 000000000000..ed6b1407a54d
--- /dev/null
+++ b/security/caitsith/realpath.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * realpath.c
+ *
+ * Copyright (C) 2005-2012  NTT DATA CORPORATION
+ *
+ * Version: 0.2.10   2021/06/06
+ */
+
+#include "caitsith.h"
+
+#include <linux/proc_fs.h>
+
+/***** SECTION1: Constants definition *****/
+
+/***** SECTION2: Structure definition *****/
+
+/***** SECTION3: Prototype definition section *****/
+
+static char *cs_get_absolute_path(const struct path *path, char * const buffer,
+				  const int buflen);
+static char *cs_get_dentry_path(struct dentry *dentry, char * const buffer,
+				const int buflen);
+static char *cs_get_local_path(struct dentry *dentry, char * const buffer,
+			       const int buflen);
+static int cs_const_part_length(const char *filename);
+
+/***** SECTION4: Standalone functions section *****/
+
+/**
+ * cs_realpath_lock - Take locks for __d_path().
+ *
+ * Returns nothing.
+ */
+static inline void cs_realpath_lock(void)
+{
+	/* dcache_lock is locked by __d_path(). */
+	/* vfsmount_lock is locked by __d_path(). */
+}
+
+/**
+ * cs_realpath_unlock - Release locks for __d_path().
+ *
+ * Returns nothing.
+ */
+static inline void cs_realpath_unlock(void)
+{
+	/* vfsmount_lock is unlocked by __d_path(). */
+	/* dcache_lock is unlocked by __d_path(). */
+}
+
+/***** SECTION5: Variables definition section *****/
+
+/***** SECTION6: Dependent functions section *****/
+
+/**
+ * cs_get_absolute_path - Get the path of a dentry but ignores chroot'ed root.
+ *
+ * @path:   Pointer to "struct path".
+ * @buffer: Pointer to buffer to return value in.
+ * @buflen: Sizeof @buffer.
+ *
+ * Returns the buffer on success, an error code otherwise.
+ *
+ * Caller holds the dcache_lock and vfsmount_lock.
+ * Based on __d_path() in fs/dcache.c
+ */
+static char *cs_get_absolute_path(const struct path *path, char * const buffer,
+				  const int buflen)
+{
+	if (buflen < 256)
+		return ERR_PTR(-ENOMEM);
+	return d_absolute_path(path, buffer, buflen - 1);
+}
+
+/**
+ * cs_get_dentry_path - Get the path of a dentry.
+ *
+ * @dentry: Pointer to "struct dentry".
+ * @buffer: Pointer to buffer to return value in.
+ * @buflen: Sizeof @buffer.
+ *
+ * Returns the buffer on success, an error code otherwise.
+ *
+ * Based on dentry_path() in fs/dcache.c
+ */
+static char *cs_get_dentry_path(struct dentry *dentry, char * const buffer,
+				const int buflen)
+{
+	if (buflen < 256)
+		return ERR_PTR(-ENOMEM);
+	/* rename_lock is locked/unlocked by dentry_path_raw(). */
+	return dentry_path_raw(dentry, buffer, buflen - 1);
+}
+
+/**
+ * cs_get_local_path - Get the path of a dentry.
+ *
+ * @dentry: Pointer to "struct dentry".
+ * @buffer: Pointer to buffer to return value in.
+ * @buflen: Sizeof @buffer.
+ *
+ * Returns the buffer on success, an error code otherwise.
+ */
+static char *cs_get_local_path(struct dentry *dentry, char * const buffer,
+			       const int buflen)
+{
+	struct super_block *sb = dentry->d_sb;
+	char *pos = cs_get_dentry_path(dentry, buffer, buflen);
+
+	if (IS_ERR(pos))
+		return pos;
+	/* Convert from $PID to self if $PID is current thread. */
+	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
+		char *ep;
+		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
+
+		if (*ep == '/' && pid && pid ==
+		    task_tgid_nr_ns(current, proc_pid_ns(sb))) {
+			pos = ep - 5;
+			if (pos < buffer)
+				goto out;
+			memmove(pos, "/self", 5);
+		}
+		goto prepend_filesystem_name;
+	}
+	/* Use filesystem name for unnamed devices. */
+	if (!MAJOR(sb->s_dev))
+		goto prepend_filesystem_name;
+	{
+		struct inode *inode = d_backing_inode(sb->s_root);
+
+		/*
+		 * Use filesystem name if filesystems does not support rename()
+		 * operation.
+		 */
+		if (!inode->i_op->rename)
+			goto prepend_filesystem_name;
+	}
+	/* Prepend device name. */
+	{
+		char name[64];
+		int name_len;
+		const dev_t dev = sb->s_dev;
+
+		name[sizeof(name) - 1] = '\0';
+		snprintf(name, sizeof(name) - 1, "dev(%u,%u):", MAJOR(dev),
+			 MINOR(dev));
+		name_len = strlen(name);
+		pos -= name_len;
+		if (pos < buffer)
+			goto out;
+		memmove(pos, name, name_len);
+		return pos;
+	}
+	/* Prepend filesystem name. */
+prepend_filesystem_name:
+	{
+		const char *name = sb->s_type->name;
+		const int name_len = strlen(name);
+
+		pos -= name_len + 1;
+		if (pos < buffer)
+			goto out;
+		memmove(pos, name, name_len);
+		pos[name_len] = ':';
+	}
+	return pos;
+out:
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * cs_realpath - Returns realpath(3) of the given pathname but ignores chroot'ed root.
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns the realpath of the given @path on success, NULL otherwise.
+ *
+ * This function uses kzalloc(), so caller must kfree() if this function
+ * didn't return NULL.
+ */
+char *cs_realpath(const struct path *path)
+{
+	char *buf = NULL;
+	char *name = NULL;
+	unsigned int buf_len = PAGE_SIZE / 2;
+	struct dentry *dentry = path->dentry;
+	struct super_block *sb;
+
+	if (!dentry)
+		return NULL;
+	sb = dentry->d_sb;
+	while (1) {
+		char *pos;
+		struct inode *inode;
+
+		buf_len <<= 1;
+		kfree(buf);
+		buf = kmalloc(buf_len, GFP_NOFS);
+		if (!buf)
+			break;
+		/* To make sure that pos is '\0' terminated. */
+		buf[buf_len - 1] = '\0';
+		/* For "pipe:[\$]" and "socket:[\$]". */
+		if (dentry->d_op && dentry->d_op->d_dname) {
+			pos = dentry->d_op->d_dname(dentry, buf, buf_len - 1);
+			goto encode;
+		}
+		inode = d_backing_inode(sb->s_root);
+		/*
+		 * Use local name for "filesystems without rename() operation
+		 * and device file" or "path without vfsmount" or "absolute
+		 * name is unavailable" cases.
+		 */
+		if (!path->mnt ||
+		    (!inode->i_op->rename &&
+		     !(sb->s_type->fs_flags & FS_REQUIRES_DEV)))
+			pos = ERR_PTR(-EINVAL);
+		else
+			pos = cs_get_absolute_path(path, buf, buf_len - 1);
+		if (pos == ERR_PTR(-EINVAL))
+			pos = cs_get_local_path(path->dentry, buf,
+						buf_len - 1);
+encode:
+		if (IS_ERR(pos))
+			continue;
+		name = cs_encode(pos);
+		break;
+	}
+	kfree(buf);
+	if (!name)
+		cs_warn_oom(__func__);
+	return name;
+}
+
+/**
+ * cs_encode2 - Encode binary string to ascii string.
+ *
+ * @str:     String in binary format. Maybe NULL.
+ * @str_len: Size of @str in byte.
+ *
+ * Returns pointer to @str in ascii format on success, NULL otherwise.
+ *
+ * This function uses kzalloc(), so caller must kfree() if this function
+ * didn't return NULL.
+ */
+char *cs_encode2(const char *str, int str_len)
+{
+	int i;
+	int len;
+	const char *p = str;
+	char *cp;
+	char *cp0;
+
+	if (!p)
+		return NULL;
+	len = str_len;
+	for (i = 0; i < str_len; i++) {
+		const unsigned char c = p[i];
+
+		if (!(c > ' ' && c < 127 && c != '\\'))
+			len += 3;
+	}
+	len++;
+	cp = kzalloc(len, GFP_NOFS);
+	if (!cp)
+		return NULL;
+	cp0 = cp;
+	p = str;
+	for (i = 0; i < str_len; i++) {
+		const unsigned char c = p[i];
+
+		if (c > ' ' && c < 127 && c != '\\') {
+			*cp++ = c;
+		} else {
+			*cp++ = '\\';
+			*cp++ = (c >> 6) + '0';
+			*cp++ = ((c >> 3) & 7) + '0';
+			*cp++ = (c & 7) + '0';
+		}
+	}
+	return cp0;
+}
+
+/**
+ * cs_encode - Encode binary string to ascii string.
+ *
+ * @str: String in binary format. Maybe NULL.
+ *
+ * Returns pointer to @str in ascii format on success, NULL otherwise.
+ *
+ * This function uses kzalloc(), so caller must kfree() if this function
+ * didn't return NULL.
+ */
+char *cs_encode(const char *str)
+{
+	return str ? cs_encode2(str, strlen(str)) : NULL;
+}
+
+/**
+ * cs_const_part_length - Evaluate the initial length without a pattern in a token.
+ *
+ * @filename: The string to evaluate. Maybe NULL.
+ *
+ * Returns the initial length without a pattern in @filename.
+ */
+static int cs_const_part_length(const char *filename)
+{
+	char c;
+	int len = 0;
+
+	if (!filename)
+		return 0;
+	while (1) {
+		c = *filename++;
+		if (!c)
+			break;
+		if (c != '\\') {
+			len++;
+			continue;
+		}
+		c = *filename++;
+		switch (c) {
+		case '0':   /* "\ooo" */
+		case '1':
+		case '2':
+		case '3':
+			c = *filename++;
+			if (c < '0' || c > '7')
+				break;
+			c = *filename++;
+			if (c < '0' || c > '7')
+				break;
+			len += 4;
+			continue;
+		}
+		break;
+	}
+	return len;
+}
+
+/**
+ * cs_fill_path_info - Fill in "struct cs_path_info" members.
+ *
+ * @ptr: Pointer to "struct cs_path_info" to fill in.
+ *
+ * Returns nothing.
+ *
+ * The caller sets "struct cs_path_info"->name.
+ */
+void cs_fill_path_info(struct cs_path_info *ptr)
+{
+	const char *name = ptr->name;
+	const int len = strlen(name);
+
+	ptr->total_len = len;
+	ptr->const_len = cs_const_part_length(name);
+	ptr->hash = full_name_hash(NULL, name, len);
+}
+
+/**
+ * cs_get_exe - Get cs_realpath() of current process.
+ *
+ * Returns the cs_realpath() of current process on success, NULL otherwise.
+ *
+ * This function uses kzalloc(), so the caller must kfree()
+ * if this function didn't return NULL.
+ */
+char *cs_get_exe(void)
+{
+	struct mm_struct *mm;
+	struct file *exe_file;
+
+	if (current->flags & PF_KTHREAD)
+		return kstrdup("<kernel>", GFP_NOFS);
+	mm = current->mm;
+	if (!mm)
+		goto task_has_no_mm;
+	/* Not using get_mm_exe_file() as it is not exported. */
+	rcu_read_lock();
+	exe_file = rcu_dereference(mm->exe_file);
+	if (exe_file && !get_file_rcu(exe_file))
+		exe_file = NULL;
+	rcu_read_unlock();
+	if (exe_file) {
+		char *cp = cs_realpath(&exe_file->f_path);
+
+		fput(exe_file);
+		return cp;
+	}
+task_has_no_mm:
+	/* I'don't know. */
+	return kstrdup("<unknown>", GFP_NOFS);
+}
+
+/**
+ * cs_get_exename - Get cs_realpath() of current process.
+ *
+ * @buf: Pointer to "struct cs_path_info".
+ *
+ * Returns true on success, false otherwise.
+ *
+ * This function uses kzalloc(), so the caller must kfree()
+ * if this function returned true.
+ */
+bool cs_get_exename(struct cs_path_info *buf)
+{
+	buf->name = cs_get_exe();
+	if (buf->name) {
+		cs_fill_path_info(buf);
+		return true;
+	}
+	return false;
+}
-- 
2.18.4

