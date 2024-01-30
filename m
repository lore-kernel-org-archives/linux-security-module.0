Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841436A03B
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619431; cv=none; b=W56F56c7+nk8KesYMIaump0PuLhISfz99TMF9k0nxFVc18NGK/TKNZgvlJ/laJ5Sl4Qs/GiS5ACWICH0WiJbEoEgzQLYWZ9RkoKYhMpWynusRuPV9LLYbXcFoa9zik/YbPgt/J07zRUiOfMzdE3MpFoU+JulnON+6rSnwEZoFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619431; c=relaxed/simple;
	bh=Yc0yL9C3eBRHke7ReGYZUGvV3MGMt0APQ37jB4h2ktk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=riyt8myFMj/n9WWp/hBcG2WBTMEEo6A/19VJdR9O96f+61kKUq5/78S2NC0vOiL9614T+kMcJgqMXkjYfL5+y/KhGVZpuxCFVLeQm6d20ziAPGFiThE0IJ6M5ZxGPMGpLjnuOhP2gxymv1feElUt/7s/nEmrV3KQ23twdKraIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mnbh9xg6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mnbh9xg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706619426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YBULUDgleE5Ym8YHvxfvTNByWpegEK8uSeurrhKuR6k=;
	b=Mnbh9xg6yuBiEG5PFfrywYaCiFUYgA6S3hYHJYFEBKF8YNcxxRUXebatvt987us82dA4dY
	XnBWQo8k/+/LkeB2LJyxmUeao5jS4CgUgXxYoL3cxKxwmLMXoGwfIslBwWWDuVxbs3DdVR
	jVwUMD3E4075lxWd6KE5v9LVNlcaa2g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-TRIExuQJOpSlCwzhy3i9mA-1; Tue, 30 Jan 2024 07:57:03 -0500
X-MC-Unique: TRIExuQJOpSlCwzhy3i9mA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a35ef7abe08so84496666b.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 04:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619422; x=1707224222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBULUDgleE5Ym8YHvxfvTNByWpegEK8uSeurrhKuR6k=;
        b=SK/4XULEuB9SgI926z43L/JT/LmYp/S6/H6DHCfJF9beaKCe8vuYR95sna+oD1Hb3t
         /bVedya5WAwXNnmJUf9k41pM7l+mA1A2IjcvjQvARqbVE1v61ONbJk72l6hkIVbIHhpQ
         AplH7h5GKElkUWJcGid5SHQREByNzhyINuXpnt/EEMY2EQrBzM5+fJQriMNVP8TkDctg
         DDC3272H2s17hZDXmnSzxePjbhalH2d2e2guxrvwztOqH8/RrfUVlUB/QsfsrNx6jomg
         eNZbo8BcEpZZOB1udEzwH9hlDjil6ZARydivhZbsNPRp7mozlNyoV3/34FqVEwYx79FH
         Q0Hg==
X-Gm-Message-State: AOJu0YyJ0nK0OzWz1htwI3omQZvNjIi2K0sVBVnU7wIBkHJ4mLnEJo0v
	8K4pexMulZE0US6WpfRACRrXv8U+CMQK+6mZcX3bUXS1RUsEHdieaKBcZ73iG7Y3G/V7Fim/as5
	Fg8MKhlr9H1WUMOmKbVh1I5Uh9vrgB0DL1sdU351Bar0g1ZjwYj0Ws/8Br3xOMccUUz3KY/LysA
	==
X-Received: by 2002:a17:906:e15:b0:a30:e17e:67ee with SMTP id l21-20020a1709060e1500b00a30e17e67eemr6584604eji.18.1706619422096;
        Tue, 30 Jan 2024 04:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENSELH25krIN4hbI6lpYXFSw4gENtOoVPlyTWAv7QF1dApL3JBuPQkgvnoLrkBsL9tCoJOTw==
X-Received: by 2002:a17:906:e15:b0:a30:e17e:67ee with SMTP id l21-20020a1709060e1500b00a30e17e67eemr6584585eji.18.1706619421536;
        Tue, 30 Jan 2024 04:57:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906784600b00a30e1f233b4sm5056435ejm.128.2024.01.30.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:57:00 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] security: use default hook return value in call_int_hook()
Date: Tue, 30 Jan 2024 13:56:59 +0100
Message-ID: <20240130125659.1709410-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Change the definition of call_int_hook() to treat LSM_RET_DEFAULT(...)
as the "continue" value instead of 0. To further simplify this macro,
also drop the IRC argument and replace it with LSM_RET_DEFAULT(...).

After this the macro can be used in a couple more hooks, where similar
logic is currently open-coded. At the same time, some other existing
call_int_hook() users now need to be open-coded, but overall it's still
a net simplification.

There should be no functional change resulting from this patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/security.c | 525 +++++++++++++++++++-------------------------
 1 file changed, 221 insertions(+), 304 deletions(-)

diff --git a/security/security.c b/security/security.c
index cedd6c150bdd..11012dcfd68e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -855,14 +855,14 @@ out:
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
+#define call_int_hook(FUNC, ...) ({				\
+	int RC = LSM_RET_DEFAULT(FUNC);				\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
+			if (RC != LSM_RET_DEFAULT(FUNC))	\
 				break;				\
 		}						\
 	} while (0);						\
@@ -881,7 +881,7 @@ out:
  */
 int security_binder_set_context_mgr(const struct cred *mgr)
 {
-	return call_int_hook(binder_set_context_mgr, 0, mgr);
+	return call_int_hook(binder_set_context_mgr, mgr);
 }
 
 /**
@@ -896,7 +896,7 @@ int security_binder_set_context_mgr(const struct cred *mgr)
 int security_binder_transaction(const struct cred *from,
 				const struct cred *to)
 {
-	return call_int_hook(binder_transaction, 0, from, to);
+	return call_int_hook(binder_transaction, from, to);
 }
 
 /**
@@ -911,7 +911,7 @@ int security_binder_transaction(const struct cred *from,
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to)
 {
-	return call_int_hook(binder_transfer_binder, 0, from, to);
+	return call_int_hook(binder_transfer_binder, from, to);
 }
 
 /**
@@ -927,7 +927,7 @@ int security_binder_transfer_binder(const struct cred *from,
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file)
 {
-	return call_int_hook(binder_transfer_file, 0, from, to, file);
+	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
 /**
@@ -946,7 +946,7 @@ int security_binder_transfer_file(const struct cred *from,
  */
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
-	return call_int_hook(ptrace_access_check, 0, child, mode);
+	return call_int_hook(ptrace_access_check, child, mode);
 }
 
 /**
@@ -961,7 +961,7 @@ int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
  */
 int security_ptrace_traceme(struct task_struct *parent)
 {
-	return call_int_hook(ptrace_traceme, 0, parent);
+	return call_int_hook(ptrace_traceme, parent);
 }
 
 /**
@@ -983,8 +983,7 @@ int security_capget(const struct task_struct *target,
 		    kernel_cap_t *inheritable,
 		    kernel_cap_t *permitted)
 {
-	return call_int_hook(capget, 0, target,
-			     effective, inheritable, permitted);
+	return call_int_hook(capget, target, effective, inheritable, permitted);
 }
 
 /**
@@ -1005,8 +1004,8 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted)
 {
-	return call_int_hook(capset, 0, new, old,
-			     effective, inheritable, permitted);
+	return call_int_hook(capset, new, old, effective, inheritable,
+			     permitted);
 }
 
 /**
@@ -1027,7 +1026,7 @@ int security_capable(const struct cred *cred,
 		     int cap,
 		     unsigned int opts)
 {
-	return call_int_hook(capable, 0, cred, ns, cap, opts);
+	return call_int_hook(capable, cred, ns, cap, opts);
 }
 
 /**
@@ -1043,7 +1042,7 @@ int security_capable(const struct cred *cred,
  */
 int security_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
-	return call_int_hook(quotactl, 0, cmds, type, id, sb);
+	return call_int_hook(quotactl, cmds, type, id, sb);
 }
 
 /**
@@ -1056,7 +1055,7 @@ int security_quotactl(int cmds, int type, int id, const struct super_block *sb)
  */
 int security_quota_on(struct dentry *dentry)
 {
-	return call_int_hook(quota_on, 0, dentry);
+	return call_int_hook(quota_on, dentry);
 }
 
 /**
@@ -1071,7 +1070,7 @@ int security_quota_on(struct dentry *dentry)
  */
 int security_syslog(int type)
 {
-	return call_int_hook(syslog, 0, type);
+	return call_int_hook(syslog, type);
 }
 
 /**
@@ -1086,7 +1085,7 @@ int security_syslog(int type)
  */
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 {
-	return call_int_hook(settime, 0, ts, tz);
+	return call_int_hook(settime, ts, tz);
 }
 
 /**
@@ -1141,7 +1140,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
  */
 int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	return call_int_hook(bprm_creds_for_exec, 0, bprm);
+	return call_int_hook(bprm_creds_for_exec, bprm);
 }
 
 /**
@@ -1165,7 +1164,7 @@ int security_bprm_creds_for_exec(struct linux_binprm *bprm)
  */
 int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 {
-	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
+	return call_int_hook(bprm_creds_from_file, bprm, file);
 }
 
 /**
@@ -1184,7 +1183,7 @@ int security_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 
-	ret = call_int_hook(bprm_check_security, 0, bprm);
+	ret = call_int_hook(bprm_check_security, bprm);
 	if (ret)
 		return ret;
 	return ima_bprm_check(bprm);
@@ -1234,7 +1233,7 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
  */
 int security_fs_context_submount(struct fs_context *fc, struct super_block *reference)
 {
-	return call_int_hook(fs_context_submount, 0, fc, reference);
+	return call_int_hook(fs_context_submount, fc, reference);
 }
 
 /**
@@ -1250,7 +1249,7 @@ int security_fs_context_submount(struct fs_context *fc, struct super_block *refe
  */
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
-	return call_int_hook(fs_context_dup, 0, fc, src_fc);
+	return call_int_hook(fs_context_dup, fc, src_fc);
 }
 
 /**
@@ -1299,7 +1298,7 @@ int security_sb_alloc(struct super_block *sb)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(sb_alloc_security, 0, sb);
+	rc = call_int_hook(sb_alloc_security, sb);
 	if (unlikely(rc))
 		security_sb_free(sb);
 	return rc;
@@ -1357,7 +1356,7 @@ EXPORT_SYMBOL(security_free_mnt_opts);
  */
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
-	return call_int_hook(sb_eat_lsm_opts, 0, options, mnt_opts);
+	return call_int_hook(sb_eat_lsm_opts, options, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
@@ -1374,7 +1373,7 @@ EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 int security_sb_mnt_opts_compat(struct super_block *sb,
 				void *mnt_opts)
 {
-	return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
+	return call_int_hook(sb_mnt_opts_compat, sb, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_mnt_opts_compat);
 
@@ -1391,7 +1390,7 @@ EXPORT_SYMBOL(security_sb_mnt_opts_compat);
 int security_sb_remount(struct super_block *sb,
 			void *mnt_opts)
 {
-	return call_int_hook(sb_remount, 0, sb, mnt_opts);
+	return call_int_hook(sb_remount, sb, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_remount);
 
@@ -1405,7 +1404,7 @@ EXPORT_SYMBOL(security_sb_remount);
  */
 int security_sb_kern_mount(const struct super_block *sb)
 {
-	return call_int_hook(sb_kern_mount, 0, sb);
+	return call_int_hook(sb_kern_mount, sb);
 }
 
 /**
@@ -1419,7 +1418,7 @@ int security_sb_kern_mount(const struct super_block *sb)
  */
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return call_int_hook(sb_show_options, 0, m, sb);
+	return call_int_hook(sb_show_options, m, sb);
 }
 
 /**
@@ -1433,7 +1432,7 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb)
  */
 int security_sb_statfs(struct dentry *dentry)
 {
-	return call_int_hook(sb_statfs, 0, dentry);
+	return call_int_hook(sb_statfs, dentry);
 }
 
 /**
@@ -1456,7 +1455,7 @@ int security_sb_statfs(struct dentry *dentry)
 int security_sb_mount(const char *dev_name, const struct path *path,
 		      const char *type, unsigned long flags, void *data)
 {
-	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
+	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
 }
 
 /**
@@ -1470,7 +1469,7 @@ int security_sb_mount(const char *dev_name, const struct path *path,
  */
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
-	return call_int_hook(sb_umount, 0, mnt, flags);
+	return call_int_hook(sb_umount, mnt, flags);
 }
 
 /**
@@ -1485,7 +1484,7 @@ int security_sb_umount(struct vfsmount *mnt, int flags)
 int security_sb_pivotroot(const struct path *old_path,
 			  const struct path *new_path)
 {
-	return call_int_hook(sb_pivotroot, 0, old_path, new_path);
+	return call_int_hook(sb_pivotroot, old_path, new_path);
 }
 
 /**
@@ -1504,9 +1503,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 			     unsigned long kern_flags,
 			     unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-			     mnt_opts ? -EOPNOTSUPP : 0, sb,
-			     mnt_opts, kern_flags, set_kern_flags);
+	struct security_hook_list *hp;
+	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_set_mnt_opts,
+			     list) {
+		rc = hp->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
+					      set_kern_flags);
+		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
@@ -1526,7 +1533,7 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 			       unsigned long kern_flags,
 			       unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_clone_mnt_opts, 0, oldsb, newsb,
+	return call_int_hook(sb_clone_mnt_opts, oldsb, newsb,
 			     kern_flags, set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
@@ -1543,7 +1550,7 @@ EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 int security_move_mount(const struct path *from_path,
 			const struct path *to_path)
 {
-	return call_int_hook(move_mount, 0, from_path, to_path);
+	return call_int_hook(move_mount, from_path, to_path);
 }
 
 /**
@@ -1560,7 +1567,7 @@ int security_move_mount(const struct path *from_path,
 int security_path_notify(const struct path *path, u64 mask,
 			 unsigned int obj_type)
 {
-	return call_int_hook(path_notify, 0, path, mask, obj_type);
+	return call_int_hook(path_notify, path, mask, obj_type);
 }
 
 /**
@@ -1579,7 +1586,7 @@ int security_inode_alloc(struct inode *inode)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(inode_alloc_security, 0, inode);
+	rc = call_int_hook(inode_alloc_security, inode);
 	if (unlikely(rc))
 		security_inode_free(inode);
 	return rc;
@@ -1637,20 +1644,8 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const char **xattr_name, void **ctx,
 				  u32 *ctxlen)
 {
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Only one module will provide a security context.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
-			     list) {
-		rc = hp->hook.dentry_init_security(dentry, mode, name,
-						   xattr_name, ctx, ctxlen);
-		if (rc != LSM_RET_DEFAULT(dentry_init_security))
-			return rc;
-	}
-	return LSM_RET_DEFAULT(dentry_init_security);
+	return call_int_hook(dentry_init_security, dentry, mode, name,
+			     xattr_name, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
@@ -1673,7 +1668,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 				    struct qstr *name,
 				    const struct cred *old, struct cred *new)
 {
-	return call_int_hook(dentry_create_files_as, 0, dentry, mode,
+	return call_int_hook(dentry_create_files_as, dentry, mode,
 			     name, old, new);
 }
 EXPORT_SYMBOL(security_dentry_create_files_as);
@@ -1774,7 +1769,7 @@ int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode)
 {
-	return call_int_hook(inode_init_security_anon, 0, inode, name,
+	return call_int_hook(inode_init_security_anon, inode, name,
 			     context_inode);
 }
 
@@ -1796,7 +1791,7 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_mknod, 0, dir, dentry, mode, dev);
+	return call_int_hook(path_mknod, dir, dentry, mode, dev);
 }
 EXPORT_SYMBOL(security_path_mknod);
 
@@ -1815,7 +1810,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_mkdir, 0, dir, dentry, mode);
+	return call_int_hook(path_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
@@ -1832,7 +1827,7 @@ int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_rmdir, 0, dir, dentry);
+	return call_int_hook(path_rmdir, dir, dentry);
 }
 
 /**
@@ -1848,7 +1843,7 @@ int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_unlink, 0, dir, dentry);
+	return call_int_hook(path_unlink, dir, dentry);
 }
 EXPORT_SYMBOL(security_path_unlink);
 
@@ -1867,7 +1862,7 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_symlink, 0, dir, dentry, old_name);
+	return call_int_hook(path_symlink, dir, dentry, old_name);
 }
 
 /**
@@ -1885,7 +1880,7 @@ int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
-	return call_int_hook(path_link, 0, old_dentry, new_dir, new_dentry);
+	return call_int_hook(path_link, old_dentry, new_dir, new_dentry);
 }
 
 /**
@@ -1909,7 +1904,7 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 		      IS_PRIVATE(d_backing_inode(new_dentry)))))
 		return 0;
 
-	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
+	return call_int_hook(path_rename, old_dir, old_dentry, new_dir,
 			     new_dentry, flags);
 }
 EXPORT_SYMBOL(security_path_rename);
@@ -1928,7 +1923,7 @@ int security_path_truncate(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_truncate, 0, path);
+	return call_int_hook(path_truncate, path);
 }
 
 /**
@@ -1946,7 +1941,7 @@ int security_path_chmod(const struct path *path, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_chmod, 0, path, mode);
+	return call_int_hook(path_chmod, path, mode);
 }
 
 /**
@@ -1963,7 +1958,7 @@ int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_chown, 0, path, uid, gid);
+	return call_int_hook(path_chown, path, uid, gid);
 }
 
 /**
@@ -1976,7 +1971,7 @@ int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
  */
 int security_path_chroot(const struct path *path)
 {
-	return call_int_hook(path_chroot, 0, path);
+	return call_int_hook(path_chroot, path);
 }
 #endif /* CONFIG_SECURITY_PATH */
 
@@ -1995,7 +1990,7 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_create, 0, dir, dentry, mode);
+	return call_int_hook(inode_create, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
@@ -2014,7 +2009,7 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
-	return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
+	return call_int_hook(inode_link, old_dentry, dir, new_dentry);
 }
 
 /**
@@ -2030,7 +2025,7 @@ int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_unlink, 0, dir, dentry);
+	return call_int_hook(inode_unlink, dir, dentry);
 }
 
 /**
@@ -2048,7 +2043,7 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_symlink, 0, dir, dentry, old_name);
+	return call_int_hook(inode_symlink, dir, dentry, old_name);
 }
 
 /**
@@ -2066,7 +2061,7 @@ int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_mkdir, 0, dir, dentry, mode);
+	return call_int_hook(inode_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
@@ -2083,7 +2078,7 @@ int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_rmdir, 0, dir, dentry);
+	return call_int_hook(inode_rmdir, dir, dentry);
 }
 
 /**
@@ -2105,7 +2100,7 @@ int security_inode_mknod(struct inode *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_mknod, 0, dir, dentry, mode, dev);
+	return call_int_hook(inode_mknod, dir, dentry, mode, dev);
 }
 
 /**
@@ -2130,13 +2125,13 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = call_int_hook(inode_rename, 0, new_dir, new_dentry,
+		int err = call_int_hook(inode_rename, new_dir, new_dentry,
 					old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return call_int_hook(inode_rename, 0, old_dir, old_dentry,
+	return call_int_hook(inode_rename, old_dir, old_dentry,
 			     new_dir, new_dentry);
 }
 
@@ -2152,7 +2147,7 @@ int security_inode_readlink(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_readlink, 0, dentry);
+	return call_int_hook(inode_readlink, dentry);
 }
 
 /**
@@ -2171,7 +2166,7 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_follow_link, 0, dentry, inode, rcu);
+	return call_int_hook(inode_follow_link, dentry, inode, rcu);
 }
 
 /**
@@ -2192,7 +2187,7 @@ int security_inode_permission(struct inode *inode, int mask)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_permission, 0, inode, mask);
+	return call_int_hook(inode_permission, inode, mask);
 }
 
 /**
@@ -2215,7 +2210,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, dentry, attr);
+	ret = call_int_hook(inode_setattr, dentry, attr);
 	if (ret)
 		return ret;
 	return evm_inode_setattr(idmap, dentry, attr);
@@ -2234,7 +2229,7 @@ int security_inode_getattr(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(inode_getattr, 0, path);
+	return call_int_hook(inode_getattr, path);
 }
 
 /**
@@ -2305,8 +2300,7 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
-			    kacl);
+	ret = call_int_hook(inode_set_acl, idmap, dentry, acl_name, kacl);
 	if (ret)
 		return ret;
 	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
@@ -2331,7 +2325,7 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_get_acl, 0, idmap, dentry, acl_name);
+	return call_int_hook(inode_get_acl, idmap, dentry, acl_name);
 }
 
 /**
@@ -2352,7 +2346,7 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
+	ret = call_int_hook(inode_remove_acl, idmap, dentry, acl_name);
 	if (ret)
 		return ret;
 	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
@@ -2394,7 +2388,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_getxattr, 0, dentry, name);
+	return call_int_hook(inode_getxattr, dentry, name);
 }
 
 /**
@@ -2410,7 +2404,7 @@ int security_inode_listxattr(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_listxattr, 0, dentry);
+	return call_int_hook(inode_listxattr, dentry);
 }
 
 /**
@@ -2470,7 +2464,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
  */
 int security_inode_need_killpriv(struct dentry *dentry)
 {
-	return call_int_hook(inode_need_killpriv, 0, dentry);
+	return call_int_hook(inode_need_killpriv, dentry);
 }
 
 /**
@@ -2487,7 +2481,7 @@ int security_inode_need_killpriv(struct dentry *dentry)
 int security_inode_killpriv(struct mnt_idmap *idmap,
 			    struct dentry *dentry)
 {
-	return call_int_hook(inode_killpriv, 0, idmap, dentry);
+	return call_int_hook(inode_killpriv, idmap, dentry);
 }
 
 /**
@@ -2510,21 +2504,11 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc)
 {
-	struct security_hook_list *hp;
-	int rc;
-
 	if (unlikely(IS_PRIVATE(inode)))
 		return LSM_RET_DEFAULT(inode_getsecurity);
-	/*
-	 * Only one module will provide an attribute with a given name.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(idmap, inode, name, buffer,
-						alloc);
-		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
-			return rc;
-	}
-	return LSM_RET_DEFAULT(inode_getsecurity);
+
+	return call_int_hook(inode_getsecurity, idmap, inode, name, buffer,
+			     alloc);
 }
 
 /**
@@ -2545,21 +2529,11 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 int security_inode_setsecurity(struct inode *inode, const char *name,
 			       const void *value, size_t size, int flags)
 {
-	struct security_hook_list *hp;
-	int rc;
-
 	if (unlikely(IS_PRIVATE(inode)))
 		return LSM_RET_DEFAULT(inode_setsecurity);
-	/*
-	 * Only one module will provide an attribute with a given name.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
-		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-						flags);
-		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
-			return rc;
-	}
-	return LSM_RET_DEFAULT(inode_setsecurity);
+
+	return call_int_hook(inode_setsecurity, inode, name, value, size,
+			     flags);
 }
 
 /**
@@ -2580,7 +2554,7 @@ int security_inode_listsecurity(struct inode *inode,
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, 0, inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
@@ -2611,7 +2585,7 @@ void security_inode_getsecid(struct inode *inode, u32 *secid)
  */
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	return call_int_hook(inode_copy_up, 0, src, new);
+	return call_int_hook(inode_copy_up, src, new);
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
@@ -2629,21 +2603,15 @@ EXPORT_SYMBOL(security_inode_copy_up);
  */
 int security_inode_copy_up_xattr(const char *name)
 {
-	struct security_hook_list *hp;
-	int rc;
-
 	/*
 	 * The implementation can return 0 (accept the xattr), 1 (discard the
 	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
 	 * any other error code in case of an error.
 	 */
-	hlist_for_each_entry(hp,
-			     &security_hook_heads.inode_copy_up_xattr, list) {
-		rc = hp->hook.inode_copy_up_xattr(name);
-		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
-			return rc;
-	}
+	int rc = call_int_hook(inode_copy_up_xattr, name);
 
+	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
+		return rc;
 	return evm_inode_copy_up_xattr(name);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
@@ -2661,7 +2629,7 @@ EXPORT_SYMBOL(security_inode_copy_up_xattr);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn)
 {
-	return call_int_hook(kernfs_init_security, 0, kn_dir, kn);
+	return call_int_hook(kernfs_init_security, kn_dir, kn);
 }
 
 /**
@@ -2685,7 +2653,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
  */
 int security_file_permission(struct file *file, int mask)
 {
-	return call_int_hook(file_permission, 0, file, mask);
+	return call_int_hook(file_permission, file, mask);
 }
 
 /**
@@ -2703,7 +2671,7 @@ int security_file_alloc(struct file *file)
 
 	if (rc)
 		return rc;
-	rc = call_int_hook(file_alloc_security, 0, file);
+	rc = call_int_hook(file_alloc_security, file);
 	if (unlikely(rc))
 		security_file_free(file);
 	return rc;
@@ -2743,7 +2711,7 @@ void security_file_free(struct file *file)
  */
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return call_int_hook(file_ioctl, 0, file, cmd, arg);
+	return call_int_hook(file_ioctl, file, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
@@ -2761,7 +2729,7 @@ EXPORT_SYMBOL_GPL(security_file_ioctl);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg)
 {
-	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+	return call_int_hook(file_ioctl_compat, file, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
 
@@ -2815,7 +2783,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
 	unsigned long prot_adj = mmap_prot(file, prot);
 	int ret;
 
-	ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
+	ret = call_int_hook(mmap_file, file, prot, prot_adj, flags);
 	if (ret)
 		return ret;
 	return ima_file_mmap(file, prot, prot_adj, flags);
@@ -2831,7 +2799,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
  */
 int security_mmap_addr(unsigned long addr)
 {
-	return call_int_hook(mmap_addr, 0, addr);
+	return call_int_hook(mmap_addr, addr);
 }
 
 /**
@@ -2849,7 +2817,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 {
 	int ret;
 
-	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	ret = call_int_hook(file_mprotect, vma, reqprot, prot);
 	if (ret)
 		return ret;
 	return ima_file_mprotect(vma, prot);
@@ -2867,7 +2835,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
  */
 int security_file_lock(struct file *file, unsigned int cmd)
 {
-	return call_int_hook(file_lock, 0, file, cmd);
+	return call_int_hook(file_lock, file, cmd);
 }
 
 /**
@@ -2886,7 +2854,7 @@ int security_file_lock(struct file *file, unsigned int cmd)
  */
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return call_int_hook(file_fcntl, 0, file, cmd, arg);
+	return call_int_hook(file_fcntl, file, cmd, arg);
 }
 
 /**
@@ -2920,7 +2888,7 @@ void security_file_set_fowner(struct file *file)
 int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig)
 {
-	return call_int_hook(file_send_sigiotask, 0, tsk, fown, sig);
+	return call_int_hook(file_send_sigiotask, tsk, fown, sig);
 }
 
 /**
@@ -2934,7 +2902,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
  */
 int security_file_receive(struct file *file)
 {
-	return call_int_hook(file_receive, 0, file);
+	return call_int_hook(file_receive, file);
 }
 
 /**
@@ -2950,7 +2918,7 @@ int security_file_open(struct file *file)
 {
 	int ret;
 
-	ret = call_int_hook(file_open, 0, file);
+	ret = call_int_hook(file_open, file);
 	if (ret)
 		return ret;
 
@@ -2969,7 +2937,7 @@ int security_file_open(struct file *file)
  */
 int security_file_truncate(struct file *file)
 {
-	return call_int_hook(file_truncate, 0, file);
+	return call_int_hook(file_truncate, file);
 }
 
 /**
@@ -2987,7 +2955,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 
 	if (rc)
 		return rc;
-	rc = call_int_hook(task_alloc, 0, task, clone_flags);
+	rc = call_int_hook(task_alloc, task, clone_flags);
 	if (unlikely(rc))
 		security_task_free(task);
 	return rc;
@@ -3025,7 +2993,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (rc)
 		return rc;
 
-	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	rc = call_int_hook(cred_alloc_blank, cred, gfp);
 	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
@@ -3069,7 +3037,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 	if (rc)
 		return rc;
 
-	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
+	rc = call_int_hook(cred_prepare, new, old, gfp);
 	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
@@ -3114,7 +3082,7 @@ EXPORT_SYMBOL(security_cred_getsecid);
  */
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	return call_int_hook(kernel_act_as, new, secid);
 }
 
 /**
@@ -3130,7 +3098,7 @@ int security_kernel_act_as(struct cred *new, u32 secid)
  */
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	return call_int_hook(kernel_create_files_as, 0, new, inode);
+	return call_int_hook(kernel_create_files_as, new, inode);
 }
 
 /**
@@ -3146,7 +3114,7 @@ int security_kernel_module_request(char *kmod_name)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_module_request, 0, kmod_name);
+	ret = call_int_hook(kernel_module_request, kmod_name);
 	if (ret)
 		return ret;
 	return integrity_kernel_module_request(kmod_name);
@@ -3167,7 +3135,7 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
+	ret = call_int_hook(kernel_read_file, file, id, contents);
 	if (ret)
 		return ret;
 	return ima_read_file(file, id, contents);
@@ -3192,7 +3160,7 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
+	ret = call_int_hook(kernel_post_read_file, file, buf, size, id);
 	if (ret)
 		return ret;
 	return ima_post_read_file(file, buf, size, id);
@@ -3212,7 +3180,7 @@ int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_load_data, 0, id, contents);
+	ret = call_int_hook(kernel_load_data, id, contents);
 	if (ret)
 		return ret;
 	return ima_load_data(id, contents);
@@ -3239,7 +3207,7 @@ int security_kernel_post_load_data(char *buf, loff_t size,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
+	ret = call_int_hook(kernel_post_load_data, buf, size, id,
 			    description);
 	if (ret)
 		return ret;
@@ -3264,7 +3232,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return call_int_hook(task_fix_setuid, 0, new, old, flags);
+	return call_int_hook(task_fix_setuid, new, old, flags);
 }
 
 /**
@@ -3284,7 +3252,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return call_int_hook(task_fix_setgid, 0, new, old, flags);
+	return call_int_hook(task_fix_setgid, new, old, flags);
 }
 
 /**
@@ -3301,7 +3269,7 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
  */
 int security_task_fix_setgroups(struct cred *new, const struct cred *old)
 {
-	return call_int_hook(task_fix_setgroups, 0, new, old);
+	return call_int_hook(task_fix_setgroups, new, old);
 }
 
 /**
@@ -3316,7 +3284,7 @@ int security_task_fix_setgroups(struct cred *new, const struct cred *old)
  */
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return call_int_hook(task_setpgid, 0, p, pgid);
+	return call_int_hook(task_setpgid, p, pgid);
 }
 
 /**
@@ -3330,7 +3298,7 @@ int security_task_setpgid(struct task_struct *p, pid_t pgid)
  */
 int security_task_getpgid(struct task_struct *p)
 {
-	return call_int_hook(task_getpgid, 0, p);
+	return call_int_hook(task_getpgid, p);
 }
 
 /**
@@ -3343,7 +3311,7 @@ int security_task_getpgid(struct task_struct *p)
  */
 int security_task_getsid(struct task_struct *p)
 {
-	return call_int_hook(task_getsid, 0, p);
+	return call_int_hook(task_getsid, p);
 }
 
 /**
@@ -3386,7 +3354,7 @@ EXPORT_SYMBOL(security_task_getsecid_obj);
  */
 int security_task_setnice(struct task_struct *p, int nice)
 {
-	return call_int_hook(task_setnice, 0, p, nice);
+	return call_int_hook(task_setnice, p, nice);
 }
 
 /**
@@ -3400,7 +3368,7 @@ int security_task_setnice(struct task_struct *p, int nice)
  */
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return call_int_hook(task_setioprio, 0, p, ioprio);
+	return call_int_hook(task_setioprio, p, ioprio);
 }
 
 /**
@@ -3413,7 +3381,7 @@ int security_task_setioprio(struct task_struct *p, int ioprio)
  */
 int security_task_getioprio(struct task_struct *p)
 {
-	return call_int_hook(task_getioprio, 0, p);
+	return call_int_hook(task_getioprio, p);
 }
 
 /**
@@ -3430,7 +3398,7 @@ int security_task_getioprio(struct task_struct *p)
 int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
 			  unsigned int flags)
 {
-	return call_int_hook(task_prlimit, 0, cred, tcred, flags);
+	return call_int_hook(task_prlimit, cred, tcred, flags);
 }
 
 /**
@@ -3448,7 +3416,7 @@ int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 			    struct rlimit *new_rlim)
 {
-	return call_int_hook(task_setrlimit, 0, p, resource, new_rlim);
+	return call_int_hook(task_setrlimit, p, resource, new_rlim);
 }
 
 /**
@@ -3462,7 +3430,7 @@ int security_task_setrlimit(struct task_struct *p, unsigned int resource,
  */
 int security_task_setscheduler(struct task_struct *p)
 {
-	return call_int_hook(task_setscheduler, 0, p);
+	return call_int_hook(task_setscheduler, p);
 }
 
 /**
@@ -3475,7 +3443,7 @@ int security_task_setscheduler(struct task_struct *p)
  */
 int security_task_getscheduler(struct task_struct *p)
 {
-	return call_int_hook(task_getscheduler, 0, p);
+	return call_int_hook(task_getscheduler, p);
 }
 
 /**
@@ -3488,7 +3456,7 @@ int security_task_getscheduler(struct task_struct *p)
  */
 int security_task_movememory(struct task_struct *p)
 {
-	return call_int_hook(task_movememory, 0, p);
+	return call_int_hook(task_movememory, p);
 }
 
 /**
@@ -3509,7 +3477,7 @@ int security_task_movememory(struct task_struct *p)
 int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 		       int sig, const struct cred *cred)
 {
-	return call_int_hook(task_kill, 0, p, info, sig, cred);
+	return call_int_hook(task_kill, p, info, sig, cred);
 }
 
 /**
@@ -3567,7 +3535,7 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
  */
 int security_create_user_ns(const struct cred *cred)
 {
-	return call_int_hook(userns_create, 0, cred);
+	return call_int_hook(userns_create, cred);
 }
 
 /**
@@ -3581,7 +3549,7 @@ int security_create_user_ns(const struct cred *cred)
  */
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	return call_int_hook(ipc_permission, 0, ipcp, flag);
+	return call_int_hook(ipc_permission, ipcp, flag);
 }
 
 /**
@@ -3613,7 +3581,7 @@ int security_msg_msg_alloc(struct msg_msg *msg)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(msg_msg_alloc_security, 0, msg);
+	rc = call_int_hook(msg_msg_alloc_security, msg);
 	if (unlikely(rc))
 		security_msg_msg_free(msg);
 	return rc;
@@ -3647,7 +3615,7 @@ int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(msg_queue_alloc_security, 0, msq);
+	rc = call_int_hook(msg_queue_alloc_security, msq);
 	if (unlikely(rc))
 		security_msg_queue_free(msq);
 	return rc;
@@ -3679,7 +3647,7 @@ void security_msg_queue_free(struct kern_ipc_perm *msq)
  */
 int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 {
-	return call_int_hook(msg_queue_associate, 0, msq, msqflg);
+	return call_int_hook(msg_queue_associate, msq, msqflg);
 }
 
 /**
@@ -3694,7 +3662,7 @@ int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
  */
 int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 {
-	return call_int_hook(msg_queue_msgctl, 0, msq, cmd);
+	return call_int_hook(msg_queue_msgctl, msq, cmd);
 }
 
 /**
@@ -3711,7 +3679,7 @@ int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
 			      struct msg_msg *msg, int msqflg)
 {
-	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
+	return call_int_hook(msg_queue_msgsnd, msq, msg, msqflg);
 }
 
 /**
@@ -3732,7 +3700,7 @@ int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
 int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 			      struct task_struct *target, long type, int mode)
 {
-	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
+	return call_int_hook(msg_queue_msgrcv, msq, msg, target, type, mode);
 }
 
 /**
@@ -3750,7 +3718,7 @@ int security_shm_alloc(struct kern_ipc_perm *shp)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(shm_alloc_security, 0, shp);
+	rc = call_int_hook(shm_alloc_security, shp);
 	if (unlikely(rc))
 		security_shm_free(shp);
 	return rc;
@@ -3783,7 +3751,7 @@ void security_shm_free(struct kern_ipc_perm *shp)
  */
 int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
-	return call_int_hook(shm_associate, 0, shp, shmflg);
+	return call_int_hook(shm_associate, shp, shmflg);
 }
 
 /**
@@ -3798,7 +3766,7 @@ int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
  */
 int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
-	return call_int_hook(shm_shmctl, 0, shp, cmd);
+	return call_int_hook(shm_shmctl, shp, cmd);
 }
 
 /**
@@ -3816,7 +3784,7 @@ int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 int security_shm_shmat(struct kern_ipc_perm *shp,
 		       char __user *shmaddr, int shmflg)
 {
-	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
+	return call_int_hook(shm_shmat, shp, shmaddr, shmflg);
 }
 
 /**
@@ -3834,7 +3802,7 @@ int security_sem_alloc(struct kern_ipc_perm *sma)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(sem_alloc_security, 0, sma);
+	rc = call_int_hook(sem_alloc_security, sma);
 	if (unlikely(rc))
 		security_sem_free(sma);
 	return rc;
@@ -3866,7 +3834,7 @@ void security_sem_free(struct kern_ipc_perm *sma)
  */
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
 {
-	return call_int_hook(sem_associate, 0, sma, semflg);
+	return call_int_hook(sem_associate, sma, semflg);
 }
 
 /**
@@ -3881,7 +3849,7 @@ int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
  */
 int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 {
-	return call_int_hook(sem_semctl, 0, sma, cmd);
+	return call_int_hook(sem_semctl, sma, cmd);
 }
 
 /**
@@ -3899,7 +3867,7 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 		       unsigned nsops, int alter)
 {
-	return call_int_hook(sem_semop, 0, sma, sops, nsops, alter);
+	return call_int_hook(sem_semop, sma, sops, nsops, alter);
 }
 
 /**
@@ -4128,7 +4096,7 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
  */
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return call_int_hook(netlink_send, 0, sk, skb);
+	return call_int_hook(netlink_send, sk, skb);
 }
 
 /**
@@ -4141,7 +4109,7 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb)
  */
 int security_ismaclabel(const char *name)
 {
-	return call_int_hook(ismaclabel, 0, name);
+	return call_int_hook(ismaclabel, name);
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
@@ -4160,20 +4128,7 @@ EXPORT_SYMBOL(security_ismaclabel);
  */
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Currently, only one LSM can implement secid_to_secctx (i.e this
-	 * LSM hook is not "stackable").
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
-	}
-
-	return LSM_RET_DEFAULT(secid_to_secctx);
+	return call_int_hook(secid_to_secctx, secid, secdata, seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
@@ -4190,7 +4145,7 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -4237,7 +4192,7 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
  */
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	return call_int_hook(inode_notifysecctx, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
@@ -4259,7 +4214,7 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
  */
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	return call_int_hook(inode_setsecctx, dentry, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
@@ -4276,19 +4231,7 @@ EXPORT_SYMBOL(security_inode_setsecctx);
  */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Only one module will provide a security context.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
-		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
-		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
-			return rc;
-	}
-
-	return LSM_RET_DEFAULT(inode_getsecctx);
+	return call_int_hook(inode_getsecctx, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -4307,7 +4250,7 @@ int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
 			       struct watch_notification *n)
 {
-	return call_int_hook(post_notification, 0, w_cred, cred, n);
+	return call_int_hook(post_notification, w_cred, cred, n);
 }
 #endif /* CONFIG_WATCH_QUEUE */
 
@@ -4323,7 +4266,7 @@ int security_post_notification(const struct cred *w_cred,
  */
 int security_watch_key(struct key *key)
 {
-	return call_int_hook(watch_key, 0, key);
+	return call_int_hook(watch_key, key);
 }
 #endif /* CONFIG_KEY_NOTIFICATIONS */
 
@@ -4352,7 +4295,7 @@ int security_watch_key(struct key *key)
 int security_unix_stream_connect(struct sock *sock, struct sock *other,
 				 struct sock *newsk)
 {
-	return call_int_hook(unix_stream_connect, 0, sock, other, newsk);
+	return call_int_hook(unix_stream_connect, sock, other, newsk);
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
@@ -4378,7 +4321,7 @@ EXPORT_SYMBOL(security_unix_stream_connect);
  */
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
-	return call_int_hook(unix_may_send, 0, sock, other);
+	return call_int_hook(unix_may_send, sock, other);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
@@ -4395,7 +4338,7 @@ EXPORT_SYMBOL(security_unix_may_send);
  */
 int security_socket_create(int family, int type, int protocol, int kern)
 {
-	return call_int_hook(socket_create, 0, family, type, protocol, kern);
+	return call_int_hook(socket_create, family, type, protocol, kern);
 }
 
 /**
@@ -4419,7 +4362,7 @@ int security_socket_create(int family, int type, int protocol, int kern)
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
-	return call_int_hook(socket_post_create, 0, sock, family, type,
+	return call_int_hook(socket_post_create, sock, family, type,
 			     protocol, kern);
 }
 
@@ -4435,7 +4378,7 @@ int security_socket_post_create(struct socket *sock, int family,
  */
 int security_socket_socketpair(struct socket *socka, struct socket *sockb)
 {
-	return call_int_hook(socket_socketpair, 0, socka, sockb);
+	return call_int_hook(socket_socketpair, socka, sockb);
 }
 EXPORT_SYMBOL(security_socket_socketpair);
 
@@ -4454,7 +4397,7 @@ EXPORT_SYMBOL(security_socket_socketpair);
 int security_socket_bind(struct socket *sock,
 			 struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_bind, 0, sock, address, addrlen);
+	return call_int_hook(socket_bind, sock, address, addrlen);
 }
 
 /**
@@ -4471,7 +4414,7 @@ int security_socket_bind(struct socket *sock,
 int security_socket_connect(struct socket *sock,
 			    struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_connect, 0, sock, address, addrlen);
+	return call_int_hook(socket_connect, sock, address, addrlen);
 }
 
 /**
@@ -4485,7 +4428,7 @@ int security_socket_connect(struct socket *sock,
  */
 int security_socket_listen(struct socket *sock, int backlog)
 {
-	return call_int_hook(socket_listen, 0, sock, backlog);
+	return call_int_hook(socket_listen, sock, backlog);
 }
 
 /**
@@ -4501,7 +4444,7 @@ int security_socket_listen(struct socket *sock, int backlog)
  */
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
-	return call_int_hook(socket_accept, 0, sock, newsock);
+	return call_int_hook(socket_accept, sock, newsock);
 }
 
 /**
@@ -4516,7 +4459,7 @@ int security_socket_accept(struct socket *sock, struct socket *newsock)
  */
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
+	return call_int_hook(socket_sendmsg, sock, msg, size);
 }
 
 /**
@@ -4533,7 +4476,7 @@ int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
-	return call_int_hook(socket_recvmsg, 0, sock, msg, size, flags);
+	return call_int_hook(socket_recvmsg, sock, msg, size, flags);
 }
 
 /**
@@ -4547,7 +4490,7 @@ int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
  */
 int security_socket_getsockname(struct socket *sock)
 {
-	return call_int_hook(socket_getsockname, 0, sock);
+	return call_int_hook(socket_getsockname, sock);
 }
 
 /**
@@ -4560,7 +4503,7 @@ int security_socket_getsockname(struct socket *sock)
  */
 int security_socket_getpeername(struct socket *sock)
 {
-	return call_int_hook(socket_getpeername, 0, sock);
+	return call_int_hook(socket_getpeername, sock);
 }
 
 /**
@@ -4576,7 +4519,7 @@ int security_socket_getpeername(struct socket *sock)
  */
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
-	return call_int_hook(socket_getsockopt, 0, sock, level, optname);
+	return call_int_hook(socket_getsockopt, sock, level, optname);
 }
 
 /**
@@ -4591,7 +4534,7 @@ int security_socket_getsockopt(struct socket *sock, int level, int optname)
  */
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
-	return call_int_hook(socket_setsockopt, 0, sock, level, optname);
+	return call_int_hook(socket_setsockopt, sock, level, optname);
 }
 
 /**
@@ -4606,7 +4549,7 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname)
  */
 int security_socket_shutdown(struct socket *sock, int how)
 {
-	return call_int_hook(socket_shutdown, 0, sock, how);
+	return call_int_hook(socket_shutdown, sock, how);
 }
 
 /**
@@ -4623,7 +4566,7 @@ int security_socket_shutdown(struct socket *sock, int how)
  */
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return call_int_hook(socket_sock_rcv_skb, 0, sk, skb);
+	return call_int_hook(socket_sock_rcv_skb, sk, skb);
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
@@ -4645,20 +4588,8 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Only one module will provide a security context.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
-			     list) {
-		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
-						       len);
-		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
-			return rc;
-	}
-	return LSM_RET_DEFAULT(socket_getpeersec_stream);
+	return call_int_hook(socket_getpeersec_stream, sock, optval, optlen,
+			     len);
 }
 
 /**
@@ -4678,19 +4609,7 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Only one module will provide a security context.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
-			     list) {
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
-		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
-			return rc;
-	}
-	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
+	return call_int_hook(socket_getpeersec_dgram, sock, skb, secid);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
@@ -4707,7 +4626,7 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
  */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	return call_int_hook(sk_alloc_security, sk, family, priority);
 }
 
 /**
@@ -4788,7 +4707,7 @@ EXPORT_SYMBOL(security_sock_graft);
 int security_inet_conn_request(const struct sock *sk,
 			       struct sk_buff *skb, struct request_sock *req)
 {
-	return call_int_hook(inet_conn_request, 0, sk, skb, req);
+	return call_int_hook(inet_conn_request, sk, skb, req);
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
@@ -4829,7 +4748,7 @@ EXPORT_SYMBOL(security_inet_conn_established);
  */
 int security_secmark_relabel_packet(u32 secid)
 {
-	return call_int_hook(secmark_relabel_packet, 0, secid);
+	return call_int_hook(secmark_relabel_packet, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -4866,7 +4785,7 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
  */
 int security_tun_dev_alloc_security(void **security)
 {
-	return call_int_hook(tun_dev_alloc_security, 0, security);
+	return call_int_hook(tun_dev_alloc_security, security);
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
@@ -4891,7 +4810,7 @@ EXPORT_SYMBOL(security_tun_dev_free_security);
  */
 int security_tun_dev_create(void)
 {
-	return call_int_hook(tun_dev_create, 0);
+	return call_int_hook(tun_dev_create);
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
@@ -4905,7 +4824,7 @@ EXPORT_SYMBOL(security_tun_dev_create);
  */
 int security_tun_dev_attach_queue(void *security)
 {
-	return call_int_hook(tun_dev_attach_queue, 0, security);
+	return call_int_hook(tun_dev_attach_queue, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach_queue);
 
@@ -4921,7 +4840,7 @@ EXPORT_SYMBOL(security_tun_dev_attach_queue);
  */
 int security_tun_dev_attach(struct sock *sk, void *security)
 {
-	return call_int_hook(tun_dev_attach, 0, sk, security);
+	return call_int_hook(tun_dev_attach, sk, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
@@ -4936,7 +4855,7 @@ EXPORT_SYMBOL(security_tun_dev_attach);
  */
 int security_tun_dev_open(void *security)
 {
-	return call_int_hook(tun_dev_open, 0, security);
+	return call_int_hook(tun_dev_open, security);
 }
 EXPORT_SYMBOL(security_tun_dev_open);
 
@@ -4952,7 +4871,7 @@ EXPORT_SYMBOL(security_tun_dev_open);
 int security_sctp_assoc_request(struct sctp_association *asoc,
 				struct sk_buff *skb)
 {
-	return call_int_hook(sctp_assoc_request, 0, asoc, skb);
+	return call_int_hook(sctp_assoc_request, asoc, skb);
 }
 EXPORT_SYMBOL(security_sctp_assoc_request);
 
@@ -4973,8 +4892,7 @@ EXPORT_SYMBOL(security_sctp_assoc_request);
 int security_sctp_bind_connect(struct sock *sk, int optname,
 			       struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(sctp_bind_connect, 0, sk, optname,
-			     address, addrlen);
+	return call_int_hook(sctp_bind_connect, sk, optname, address, addrlen);
 }
 EXPORT_SYMBOL(security_sctp_bind_connect);
 
@@ -5008,7 +4926,7 @@ EXPORT_SYMBOL(security_sctp_sk_clone);
 int security_sctp_assoc_established(struct sctp_association *asoc,
 				    struct sk_buff *skb)
 {
-	return call_int_hook(sctp_assoc_established, 0, asoc, skb);
+	return call_int_hook(sctp_assoc_established, asoc, skb);
 }
 EXPORT_SYMBOL(security_sctp_assoc_established);
 
@@ -5026,7 +4944,7 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
  */
 int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 {
-	return call_int_hook(mptcp_add_subflow, 0, sk, ssk);
+	return call_int_hook(mptcp_add_subflow, sk, ssk);
 }
 
 #endif	/* CONFIG_SECURITY_NETWORK */
@@ -5044,7 +4962,7 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
  */
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey)
 {
-	return call_int_hook(ib_pkey_access, 0, sec, subnet_prefix, pkey);
+	return call_int_hook(ib_pkey_access, sec, subnet_prefix, pkey);
 }
 EXPORT_SYMBOL(security_ib_pkey_access);
 
@@ -5061,8 +4979,7 @@ EXPORT_SYMBOL(security_ib_pkey_access);
 int security_ib_endport_manage_subnet(void *sec,
 				      const char *dev_name, u8 port_num)
 {
-	return call_int_hook(ib_endport_manage_subnet, 0, sec,
-			     dev_name, port_num);
+	return call_int_hook(ib_endport_manage_subnet, sec, dev_name, port_num);
 }
 EXPORT_SYMBOL(security_ib_endport_manage_subnet);
 
@@ -5076,7 +4993,7 @@ EXPORT_SYMBOL(security_ib_endport_manage_subnet);
  */
 int security_ib_alloc_security(void **sec)
 {
-	return call_int_hook(ib_alloc_security, 0, sec);
+	return call_int_hook(ib_alloc_security, sec);
 }
 EXPORT_SYMBOL(security_ib_alloc_security);
 
@@ -5109,7 +5026,7 @@ int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			       struct xfrm_user_sec_ctx *sec_ctx,
 			       gfp_t gfp)
 {
-	return call_int_hook(xfrm_policy_alloc_security, 0, ctxp, sec_ctx, gfp);
+	return call_int_hook(xfrm_policy_alloc_security, ctxp, sec_ctx, gfp);
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
@@ -5126,7 +5043,7 @@ EXPORT_SYMBOL(security_xfrm_policy_alloc);
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			       struct xfrm_sec_ctx **new_ctxp)
 {
-	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
+	return call_int_hook(xfrm_policy_clone_security, old_ctx, new_ctxp);
 }
 
 /**
@@ -5151,7 +5068,7 @@ EXPORT_SYMBOL(security_xfrm_policy_free);
  */
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return call_int_hook(xfrm_policy_delete_security, 0, ctx);
+	return call_int_hook(xfrm_policy_delete_security, ctx);
 }
 
 /**
@@ -5168,7 +5085,7 @@ int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 int security_xfrm_state_alloc(struct xfrm_state *x,
 			      struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return call_int_hook(xfrm_state_alloc, 0, x, sec_ctx);
+	return call_int_hook(xfrm_state_alloc, x, sec_ctx);
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
@@ -5187,7 +5104,7 @@ EXPORT_SYMBOL(security_xfrm_state_alloc);
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
+	return call_int_hook(xfrm_state_alloc_acquire, x, polsec, secid);
 }
 
 /**
@@ -5200,7 +5117,7 @@ int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
  */
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return call_int_hook(xfrm_state_delete_security, 0, x);
+	return call_int_hook(xfrm_state_delete_security, x);
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
@@ -5229,7 +5146,7 @@ void security_xfrm_state_free(struct xfrm_state *x)
  */
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 {
-	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid);
+	return call_int_hook(xfrm_policy_lookup, ctx, fl_secid);
 }
 
 /**
@@ -5277,12 +5194,12 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
  */
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+	return call_int_hook(xfrm_decode_session, skb, secid, 1);
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
-	int rc = call_int_hook(xfrm_decode_session, 0, skb, &flic->flowic_secid,
+	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
 			       0);
 
 	BUG_ON(rc);
@@ -5305,7 +5222,7 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, 0, key, cred, flags);
+	return call_int_hook(key_alloc, key, cred, flags);
 }
 
 /**
@@ -5332,7 +5249,7 @@ void security_key_free(struct key *key)
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm)
 {
-	return call_int_hook(key_permission, 0, key_ref, cred, need_perm);
+	return call_int_hook(key_permission, key_ref, cred, need_perm);
 }
 
 /**
@@ -5351,7 +5268,7 @@ int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 int security_key_getsecurity(struct key *key, char **buffer)
 {
 	*buffer = NULL;
-	return call_int_hook(key_getsecurity, 0, key, buffer);
+	return call_int_hook(key_getsecurity, key, buffer);
 }
 #endif	/* CONFIG_KEYS */
 
@@ -5370,7 +5287,7 @@ int security_key_getsecurity(struct key *key, char **buffer)
  */
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule);
 }
 
 /**
@@ -5384,7 +5301,7 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
  */
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return call_int_hook(audit_rule_known, 0, krule);
+	return call_int_hook(audit_rule_known, krule);
 }
 
 /**
@@ -5414,7 +5331,7 @@ void security_audit_rule_free(void *lsmrule)
  */
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
@@ -5433,7 +5350,7 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
  */
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-	return call_int_hook(bpf, 0, cmd, attr, size);
+	return call_int_hook(bpf, cmd, attr, size);
 }
 
 /**
@@ -5448,7 +5365,7 @@ int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
  */
 int security_bpf_map(struct bpf_map *map, fmode_t fmode)
 {
-	return call_int_hook(bpf_map, 0, map, fmode);
+	return call_int_hook(bpf_map, map, fmode);
 }
 
 /**
@@ -5462,7 +5379,7 @@ int security_bpf_map(struct bpf_map *map, fmode_t fmode)
  */
 int security_bpf_prog(struct bpf_prog *prog)
 {
-	return call_int_hook(bpf_prog, 0, prog);
+	return call_int_hook(bpf_prog, prog);
 }
 
 /**
@@ -5475,7 +5392,7 @@ int security_bpf_prog(struct bpf_prog *prog)
  */
 int security_bpf_map_alloc(struct bpf_map *map)
 {
-	return call_int_hook(bpf_map_alloc_security, 0, map);
+	return call_int_hook(bpf_map_alloc_security, map);
 }
 
 /**
@@ -5488,7 +5405,7 @@ int security_bpf_map_alloc(struct bpf_map *map)
  */
 int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 {
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
+	return call_int_hook(bpf_prog_alloc_security, aux);
 }
 
 /**
@@ -5525,7 +5442,7 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
  */
 int security_locked_down(enum lockdown_reason what)
 {
-	return call_int_hook(locked_down, 0, what);
+	return call_int_hook(locked_down, what);
 }
 EXPORT_SYMBOL(security_locked_down);
 
@@ -5541,7 +5458,7 @@ EXPORT_SYMBOL(security_locked_down);
  */
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
-	return call_int_hook(perf_event_open, 0, attr, type);
+	return call_int_hook(perf_event_open, attr, type);
 }
 
 /**
@@ -5554,7 +5471,7 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
  */
 int security_perf_event_alloc(struct perf_event *event)
 {
-	return call_int_hook(perf_event_alloc, 0, event);
+	return call_int_hook(perf_event_alloc, event);
 }
 
 /**
@@ -5578,7 +5495,7 @@ void security_perf_event_free(struct perf_event *event)
  */
 int security_perf_event_read(struct perf_event *event)
 {
-	return call_int_hook(perf_event_read, 0, event);
+	return call_int_hook(perf_event_read, event);
 }
 
 /**
@@ -5591,7 +5508,7 @@ int security_perf_event_read(struct perf_event *event)
  */
 int security_perf_event_write(struct perf_event *event)
 {
-	return call_int_hook(perf_event_write, 0, event);
+	return call_int_hook(perf_event_write, event);
 }
 #endif /* CONFIG_PERF_EVENTS */
 
@@ -5607,7 +5524,7 @@ int security_perf_event_write(struct perf_event *event)
  */
 int security_uring_override_creds(const struct cred *new)
 {
-	return call_int_hook(uring_override_creds, 0, new);
+	return call_int_hook(uring_override_creds, new);
 }
 
 /**
@@ -5620,7 +5537,7 @@ int security_uring_override_creds(const struct cred *new)
  */
 int security_uring_sqpoll(void)
 {
-	return call_int_hook(uring_sqpoll, 0);
+	return call_int_hook(uring_sqpoll);
 }
 
 /**
@@ -5633,6 +5550,6 @@ int security_uring_sqpoll(void)
  */
 int security_uring_cmd(struct io_uring_cmd *ioucmd)
 {
-	return call_int_hook(uring_cmd, 0, ioucmd);
+	return call_int_hook(uring_cmd, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
-- 
2.43.0

