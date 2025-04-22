Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF02820C6
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347455; cv=none; b=bmnn6c3YtIjEcgBm7OOkFIEB4b4CXwzeBjmidL6ah7fWEBRvus/EhoTx9QmotD6WBMV/+v61zjxQjdVchbTQ1DVv2fdLjFJ025V/BYPtHPMhZlcxCaM+Nbrbc6g3zQfJ3TdUvpNRX0NFRg349zcLzJpqGdpLs+Z6CSOOw4YqJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347455; c=relaxed/simple;
	bh=TaFOTeoZkL5EIyVhT1ePQUIeah6tp+xL/udcy4t3JrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+3SgInyyE9mgB5pwUMI5uXsVTZKsn/N45TAssp2Yulllb6J5Rc9+GNijVylzAcy1rus7lIDHwT8lQPLBsvt9o3lsGLVdj6MDu1yOH1AfEof5mK+oiz+NPg+DvMKYbt6fcPtY7BfJP5kga31+8W5B3TZbCocJ6bNVzperA4YA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmA6Mfxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmA6Mfxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA23CC4CEE9;
	Tue, 22 Apr 2025 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745347454;
	bh=TaFOTeoZkL5EIyVhT1ePQUIeah6tp+xL/udcy4t3JrE=;
	h=From:To:Cc:Subject:Date:From;
	b=hmA6MfxfzWCTdgUIxA1pZuHExIivPyKCb8lwBdzt0n6/P3DEPIV+Y/ltVHDGmznsd
	 5iXFAsxXqHEI54gHXDfENL00oBVJoethEv71ROx9zUTTjp7kyRDq24RuLbPZqAOEMQ
	 rRm0NqkmhK38tcVBlaYs9iMRSzq88k2ydwxL8/VVIWxGqc1uTiAyWtPTqVP2tU2Av/
	 XhNbnLqxorDemUCq5iAcUxvrmcVP4Tz1bsZYllhId45ATzpZPUre+C6KbBmQVKP4l5
	 t0mdJuYK57Ve+lD5w/pm5G4sYdIE8z5xUkACFXtNxwg/1rHg7/y1pr6MczDN0DUxko
	 eMA2dVNsq7TAw==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kernel-team@meta.com,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Song Liu <song@kernel.org>
Subject: [PATCH] lsm: make SECURITY_PATH always enabled
Date: Tue, 22 Apr 2025 11:44:07 -0700
Message-ID: <20250422184407.3257964-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Only TOMOYO needed CONFIG_SECURITY_PATH when it was introduced. But now,
AppArmor, EVM, IMA and LandLock also need it. And kernels are likely built
with at least one of these enabled if CONFIG_SECURITY is enabled. Let's
simplify the dependency.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Song Liu <song@kernel.org>

---

This was initially proposed in [1], but got Nacked by Paul. However, I
still think this change makes sense. This is because the definition of
"pathname based access control" is not clear. For example,
security_path_notify, security_sb_mount, security_move_mount are enabled
by CONFIG_SECURITY, but they all use struct path, and thus are "path
based access control". Yes, there is a difference between "path based"
and "pathname based", but it is really up to the LSMs to decide how
they use struct path. TOMOYO uses d_abosolute_path on security_sb_mount,
while LandLock does path walk with dget_parent() and follow_up().

The separation of CONFIG_SECURITY and CONFIG_SECURITY_PATH has actually
caused confusion. In some of our early kernels, we enabled CONFIG_SECURITY
but not CONFIG_SECURITY_PATH. Now, we have to add separate logic in user
space to deal with missing CONFIG_SECURITY_PATH in these systems.

Given the vague definition and real world issue, I think we should just
merge CONFIG_SECURITY and CONFIG_SECURITY_PATH.

PS: [1] doesn't build with CONFIG_SECURITY=n case. This issue is fixed in
this version.

[1] https://lore.kernel.org/linux-security-module/678aa43f-28b6-410d-8890-b8d4e3261807@I-love.SAKURA.ne.jp/
---
 arch/mips/configs/loongson2k_defconfig |   1 -
 arch/mips/configs/loongson3_defconfig  |   1 -
 include/linux/lsm_hook_defs.h          |   2 -
 include/linux/security.h               | 174 ++++++++++++-------------
 kernel/bpf/bpf_lsm.c                   |   2 -
 kernel/trace/bpf_trace.c               |   2 -
 security/Kconfig                       |   9 --
 security/apparmor/Kconfig              |   1 -
 security/integrity/evm/Kconfig         |   1 -
 security/integrity/ima/Kconfig         |   1 -
 security/landlock/Kconfig              |   1 -
 security/security.c                    |   2 -
 security/tomoyo/Kconfig                |   1 -
 13 files changed, 86 insertions(+), 112 deletions(-)

diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 4b7f914d01d0..fb149d2f3ef5 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -325,7 +325,6 @@ CONFIG_NLS_UTF8=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_PATH=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 98844b457b7f..84fdbc6fdace 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -376,7 +376,6 @@ CONFIG_NLS_UTF8=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_PATH=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_DEFAULT_SECURITY_DAC=y
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..b2c21e5f6fbd 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -87,7 +87,6 @@ LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
 LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
 	 struct qstr *name, const struct cred *old, struct cred *new)
 
-#ifdef CONFIG_SECURITY_PATH
 LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
 LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
 	 umode_t mode)
@@ -107,7 +106,6 @@ LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
 LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
 LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
 LSM_HOOK(int, 0, path_chroot, const struct path *path)
-#endif /* CONFIG_SECURITY_PATH */
 
 /* Needed for inode based security check */
 LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..5012a1926f57 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -581,6 +581,24 @@ void security_bdev_free(struct block_device *bdev);
 int security_bdev_setintegrity(struct block_device *bdev,
 			       enum lsm_integrity_type type, const void *value,
 			       size_t size);
+int security_path_unlink(const struct path *dir, struct dentry *dentry);
+int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode);
+int security_path_rmdir(const struct path *dir, struct dentry *dentry);
+int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
+			unsigned int dev);
+void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
+int security_path_truncate(const struct path *path);
+int security_path_symlink(const struct path *dir, struct dentry *dentry,
+			  const char *old_name);
+int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
+		       struct dentry *new_dentry);
+int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
+			 const struct path *new_dir, struct dentry *new_dentry,
+			 unsigned int flags);
+int security_path_chmod(const struct path *path, umode_t mode);
+int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid);
+int security_path_chroot(const struct path *path);
+
 #else /* CONFIG_SECURITY */
 
 /**
@@ -1603,6 +1621,74 @@ static inline int security_bdev_setintegrity(struct block_device *bdev,
 	return 0;
 }
 
+static inline int security_path_unlink(const struct path *dir, struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_path_mkdir(const struct path *dir, struct dentry *dentry,
+				      umode_t mode)
+{
+	return 0;
+}
+
+static inline int security_path_rmdir(const struct path *dir, struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_path_mknod(const struct path *dir, struct dentry *dentry,
+				      umode_t mode, unsigned int dev)
+{
+	return 0;
+}
+
+static inline void security_path_post_mknod(struct mnt_idmap *idmap,
+					    struct dentry *dentry)
+{ }
+
+static inline int security_path_truncate(const struct path *path)
+{
+	return 0;
+}
+
+static inline int security_path_symlink(const struct path *dir, struct dentry *dentry,
+					const char *old_name)
+{
+	return 0;
+}
+
+static inline int security_path_link(struct dentry *old_dentry,
+				     const struct path *new_dir,
+				     struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static inline int security_path_rename(const struct path *old_dir,
+				       struct dentry *old_dentry,
+				       const struct path *new_dir,
+				       struct dentry *new_dentry,
+				       unsigned int flags)
+{
+	return 0;
+}
+
+static inline int security_path_chmod(const struct path *path, umode_t mode)
+{
+	return 0;
+}
+
+static inline int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
+{
+	return 0;
+}
+
+static inline int security_path_chroot(const struct path *path)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
@@ -2029,94 +2115,6 @@ static inline void security_skb_classify_flow(struct sk_buff *skb,
 
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
-#ifdef CONFIG_SECURITY_PATH
-int security_path_unlink(const struct path *dir, struct dentry *dentry);
-int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode);
-int security_path_rmdir(const struct path *dir, struct dentry *dentry);
-int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
-			unsigned int dev);
-void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
-int security_path_truncate(const struct path *path);
-int security_path_symlink(const struct path *dir, struct dentry *dentry,
-			  const char *old_name);
-int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
-		       struct dentry *new_dentry);
-int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
-			 const struct path *new_dir, struct dentry *new_dentry,
-			 unsigned int flags);
-int security_path_chmod(const struct path *path, umode_t mode);
-int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid);
-int security_path_chroot(const struct path *path);
-#else	/* CONFIG_SECURITY_PATH */
-static inline int security_path_unlink(const struct path *dir, struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_path_mkdir(const struct path *dir, struct dentry *dentry,
-				      umode_t mode)
-{
-	return 0;
-}
-
-static inline int security_path_rmdir(const struct path *dir, struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_path_mknod(const struct path *dir, struct dentry *dentry,
-				      umode_t mode, unsigned int dev)
-{
-	return 0;
-}
-
-static inline void security_path_post_mknod(struct mnt_idmap *idmap,
-					    struct dentry *dentry)
-{ }
-
-static inline int security_path_truncate(const struct path *path)
-{
-	return 0;
-}
-
-static inline int security_path_symlink(const struct path *dir, struct dentry *dentry,
-					const char *old_name)
-{
-	return 0;
-}
-
-static inline int security_path_link(struct dentry *old_dentry,
-				     const struct path *new_dir,
-				     struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static inline int security_path_rename(const struct path *old_dir,
-				       struct dentry *old_dentry,
-				       const struct path *new_dir,
-				       struct dentry *new_dentry,
-				       unsigned int flags)
-{
-	return 0;
-}
-
-static inline int security_path_chmod(const struct path *path, umode_t mode)
-{
-	return 0;
-}
-
-static inline int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
-{
-	return 0;
-}
-
-static inline int security_path_chroot(const struct path *path)
-{
-	return 0;
-}
-#endif	/* CONFIG_SECURITY_PATH */
-
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0a59df1c550a..e4b00a8897b1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -329,7 +329,6 @@ BTF_ID(func, bpf_lsm_kernel_module_request)
 BTF_ID(func, bpf_lsm_kernel_read_file)
 BTF_ID(func, bpf_lsm_kernfs_init_security)
 
-#ifdef CONFIG_SECURITY_PATH
 BTF_ID(func, bpf_lsm_path_unlink)
 BTF_ID(func, bpf_lsm_path_mkdir)
 BTF_ID(func, bpf_lsm_path_rmdir)
@@ -339,7 +338,6 @@ BTF_ID(func, bpf_lsm_path_link)
 BTF_ID(func, bpf_lsm_path_rename)
 BTF_ID(func, bpf_lsm_path_chmod)
 BTF_ID(func, bpf_lsm_path_chown)
-#endif /* CONFIG_SECURITY_PATH */
 
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 187dc37d61d4..e93f77c086ba 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -936,9 +936,7 @@ BTF_ID(func, security_file_permission)
 BTF_ID(func, security_inode_getattr)
 BTF_ID(func, security_file_open)
 #endif
-#ifdef CONFIG_SECURITY_PATH
 BTF_ID(func, security_path_truncate)
-#endif
 BTF_ID(func, vfs_truncate)
 BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
diff --git a/security/Kconfig b/security/Kconfig
index 4816fc74f81e..07b3c74981a6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -129,15 +129,6 @@ config SECURITY_NETWORK_XFRM
 	  IPSec.
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_PATH
-	bool "Security hooks for pathname based access control"
-	depends on SECURITY
-	help
-	  This enables the security hooks for pathname based access control.
-	  If enabled, a security module can use these hooks to
-	  implement pathname based access controls.
-	  If you are unsure how to answer this question, answer N.
-
 config INTEL_TXT
 	bool "Enable Intel(R) Trusted Execution Technology (Intel(R) TXT)"
 	depends on HAVE_INTEL_TXT
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 64cc3044a42c..f7c196ffbf93 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -3,7 +3,6 @@ config SECURITY_APPARMOR
 	bool "AppArmor support"
 	depends on SECURITY && NET
 	select AUDIT
-	select SECURITY_PATH
 	select SECURITYFS
 	select SECURITY_NETWORK
 	default n
diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
index 861b3bacab82..fba9ee359bc9 100644
--- a/security/integrity/evm/Kconfig
+++ b/security/integrity/evm/Kconfig
@@ -6,7 +6,6 @@ config EVM
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select SECURITY_PATH
 	default n
 	help
 	  EVM protects a file's security extended attributes against
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..b98bfe9efd0c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,6 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select SECURITY_PATH
 	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index 3f1493402052..b7bb22471867 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -4,7 +4,6 @@ config SECURITY_LANDLOCK
 	bool "Landlock support"
 	depends on SECURITY
 	select SECURITY_NETWORK
-	select SECURITY_PATH
 	help
 	  Landlock is a sandboxing mechanism that enables processes to restrict
 	  themselves (and their future children) by gradually enforcing
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..dbfe95eb3064 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1878,7 +1878,6 @@ int security_inode_init_security_anon(struct inode *inode,
 			     context_inode);
 }
 
-#ifdef CONFIG_SECURITY_PATH
 /**
  * security_path_mknod() - Check if creating a special file is allowed
  * @dir: parent directory
@@ -2092,7 +2091,6 @@ int security_path_chroot(const struct path *path)
 {
 	return call_int_hook(path_chroot, path);
 }
-#endif /* CONFIG_SECURITY_PATH */
 
 /**
  * security_inode_create() - Check if creating a file is allowed
diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index 1e0dd1a6d0b0..ab8a5aaa301b 100644
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@ -4,7 +4,6 @@ config SECURITY_TOMOYO
 	depends on SECURITY
 	depends on NET
 	select SECURITYFS
-	select SECURITY_PATH
 	select SECURITY_NETWORK
 	default n
 	help
-- 
2.47.1

