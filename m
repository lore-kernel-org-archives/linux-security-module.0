Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAB29408
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724590204; cv=none; b=iYqGPjZtDmZpiTuY1eI3WvczMuqAxnIWd8ROZULhaaGQdNvaxi9QeCaHwq8l5zM63QiJj3Equn9fHmQOmkzR738/4CpDpVuRTZ11n60PavnbNCT4bbtVlf461ivmwKlLk2qAh5w0cu2mPYwYyyZ5e1HFZz6vxLgsuXCqEtdBMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724590204; c=relaxed/simple;
	bh=zOpCAk/2d1doIX0Oljekew3LS9zQ13RBy0And2qZi8o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=L8v/o9GXr7RToa+fYm1myNWXVK3YwX5SWyDxhiQ1ghtre8BLlc52S3GEf7VEb1SIyX2kBuuVkpxtvL5nkySmSNp46xp2mn3OVMqZDlxYIwhDnwRUiri9umqX64Nq+zAxRIhFyZndw3RjKxr7iXvamGMYrJEO2hDSWASA4EllC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 47PCnsjO076168
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 21:49:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sun, 25 Aug 2024 21:49:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 47PCnsGs076163
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 21:49:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <678aa43f-28b6-410d-8890-b8d4e3261807@I-love.SAKURA.ne.jp>
Date: Sun, 25 Aug 2024 21:49:52 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH] lsm: make SECURITY_PATH always enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Only TOMOYO needed CONFIG_SECURITY_PATH when it was introduced. But now,
AppArmor, EVM, IMA and LandLock also need it. And kernels are likely built
with at least one of these enabled if CONFIG_SECURITY is enabled. Let's
simplify the dependency.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 arch/mips/configs/loongson2k_defconfig |  1 -
 arch/mips/configs/loongson3_defconfig  |  1 -
 include/linux/lsm_hook_defs.h          |  2 -
 include/linux/security.h               | 70 --------------------------
 kernel/bpf/bpf_lsm.c                   |  2 -
 kernel/trace/bpf_trace.c               |  2 -
 security/Kconfig                       |  9 ----
 security/apparmor/Kconfig              |  1 -
 security/integrity/evm/Kconfig         |  1 -
 security/integrity/ima/Kconfig         |  1 -
 security/landlock/Kconfig              |  1 -
 security/security.c                    |  2 -
 security/tomoyo/Kconfig                |  1 -
 13 files changed, 94 deletions(-)

diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 4b7f914d01d0f..fb149d2f3ef5d 100644
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
index 78f4987520664..072b655f05601 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -388,7 +388,6 @@ CONFIG_NLS_UTF8=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_PATH=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9eca013aa5e1f..dc1ee162994af 100644
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
index b86ec2afc6910..50504cfd6d427 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1953,7 +1953,6 @@ static inline void security_skb_classify_flow(struct sk_buff *skb,
 
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
-#ifdef CONFIG_SECURITY_PATH
 int security_path_unlink(const struct path *dir, struct dentry *dentry);
 int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode);
 int security_path_rmdir(const struct path *dir, struct dentry *dentry);
@@ -1971,75 +1970,6 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 int security_path_chmod(const struct path *path, umode_t mode);
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid);
 int security_path_chroot(const struct path *path);
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
 
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 6292ac5f9bd13..70ad2c9ccadd9 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -327,7 +327,6 @@ BTF_ID(func, bpf_lsm_kernel_module_request)
 BTF_ID(func, bpf_lsm_kernel_read_file)
 BTF_ID(func, bpf_lsm_kernfs_init_security)
 
-#ifdef CONFIG_SECURITY_PATH
 BTF_ID(func, bpf_lsm_path_unlink)
 BTF_ID(func, bpf_lsm_path_mkdir)
 BTF_ID(func, bpf_lsm_path_rmdir)
@@ -337,7 +336,6 @@ BTF_ID(func, bpf_lsm_path_link)
 BTF_ID(func, bpf_lsm_path_rename)
 BTF_ID(func, bpf_lsm_path_chmod)
 BTF_ID(func, bpf_lsm_path_chown)
-#endif /* CONFIG_SECURITY_PATH */
 
 #ifdef CONFIG_KEYS
 BTF_ID(func, bpf_lsm_key_free)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1807c2966a89e..47dcb02acf35e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -916,9 +916,7 @@ BTF_ID(func, security_file_permission)
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
index 28e685f53bd1a..541c76d239a3c 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -103,15 +103,6 @@ config SECURITY_NETWORK_XFRM
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
index 64cc3044a42ce..f7c196ffbf935 100644
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
index 861b3bacab821..fba9ee359bc9f 100644
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
index 475c326150067..b98bfe9efd0c8 100644
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
index 3f1493402052e..b7bb224718675 100644
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
index c30e8348c9e12..04a86dd06f0ac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1901,7 +1901,6 @@ int security_inode_init_security_anon(struct inode *inode,
 			     context_inode);
 }
 
-#ifdef CONFIG_SECURITY_PATH
 /**
  * security_path_mknod() - Check if creating a special file is allowed
  * @dir: parent directory
@@ -2115,7 +2114,6 @@ int security_path_chroot(const struct path *path)
 {
 	return call_int_hook(path_chroot, path);
 }
-#endif /* CONFIG_SECURITY_PATH */
 
 /**
  * security_inode_create() - Check if creating a file is allowed
diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index 1e0dd1a6d0b0e..ab8a5aaa301b0 100644
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
2.43.5

