Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3629A2;
	Wed, 29 Jan 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183240; cv=none; b=VY5aT8NAp0uiqH1LQv7xKJd7qjqEWFvhcn7CsVVV6qHUYJWU6CDWsGepORxX86Xu7wDEhWaJrWPhZTXncmUJEHxbzWW4nDE9N84KquQKLqr1pMwok/Gqhi43JynGy53PNXy8R88VCEMs5g64nTw6pEpG0c4urt5bTxuH2uYW4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183240; c=relaxed/simple;
	bh=rNSXy9Sct5j7fuWxOAUzXWDDz8RBbrqWcCcnTgGXcZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRHf64FKO9+pNrvkwnBu/EooyeQP5FkAGIVOwfaLxxfshh1fMOdBP/1iaAeEdd2l8OBIzCV+Lin/n+CgH7tookHJkgPzqmQms4Pe/0fwcQJSPovfy1FM8FHbXXPREEm4VqOkCAfGStzlQGxwb7noIGlqGat2wl+wltESXc+sJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBFQfTpr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBFQfTpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11CAC4CEE6;
	Wed, 29 Jan 2025 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738183239;
	bh=rNSXy9Sct5j7fuWxOAUzXWDDz8RBbrqWcCcnTgGXcZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBFQfTprdHiKPbOv4p1kJ3C0ty/oxBMjnxUI5cW4VE8S1bpnZP76xYfCQM3QHg5da
	 K9iMXgtQ7duBEnsiR9P7Gi3YOHEyQh24jkpMeKCSfwsw2qKOk3KQKtfm4QqFs9QXrz
	 R/BcO9DSXOEwd5lGGmgqtB97B1PQ78AtJ0UdZcDJO9E0R0ns4vYKYHzozi2OfFPyaQ
	 +Lp/gn4l9XVN2VgUztxLYBH9W4g2AXyXSfrzpzp2v7rhqxR3WgxNsZyUZPAn0Tl6/p
	 fzFXT0JkwmVIih4UUOvVCu+doUoHFgiQuPnFcohGDrY0QvVS+7lX6QQ1NQef07zegz
	 Ab0cXtwNuL4zg==
From: wufan@kernel.org
To: corbet@lwn.net,
	jmorris@namei.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	akpm@linux-foundation.org
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@kernel.org>
Subject: [RFC PATCH v2 1/2] memfd,lsm: add a security hook to memfd_create()
Date: Wed, 29 Jan 2025 20:39:31 +0000
Message-Id: <20250129203932.22165-2-wufan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129203932.22165-1-wufan@kernel.org>
References: <20250129203932.22165-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <wufan@kernel.org>

This patch adds a new LSM hook that notifies the security subsystem
whenever a new memfd is created by memfd_create(). The hook is invoked
before fd_install() inside memfd_create(), allowing the LSM to
differentiate memfd files from regular shmemfs or hugetlbfs files that
share the same superblock.

Upon receiving this notification, the security system can label
the memfd files thereafter the lsms can make security decision
specifically for them.

Signed-off-by: Fan Wu <wufan@kernel.org>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      |  8 ++++++++
 mm/memfd.c                    |  2 ++
 security/security.c           | 11 +++++++++++
 4 files changed, 24 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e2f1ce37c41e..1c0a9953c924 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -463,3 +463,6 @@ LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
 LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
 LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
 	 enum lsm_integrity_type type, const void *value, size_t size)
+
+LSM_HOOK(void, 0, memfd_created, struct file *file)
+
diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cad..40ae79270eaf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2386,4 +2386,12 @@ static inline void security_initramfs_populated(void)
 }
 #endif /* CONFIG_SECURITY */
 
+#ifdef CONFIG_SECURITY
+extern void security_memfd_created(struct file *file);
+#else
+static inline void security_memfd_created(struct file *file)
+{
+}
+#endif /* CONFIG_SECURITY */
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/mm/memfd.c b/mm/memfd.c
index 37f7be57c2f5..597d27ccb0b6 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -19,6 +19,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/memfd.h>
 #include <linux/pid_namespace.h>
+#include <linux/security.h>
 #include <uapi/linux/memfd.h>
 
 /*
@@ -483,6 +484,7 @@ SYSCALL_DEFINE2(memfd_create,
 		goto err_fd;
 	}
 
+	security_memfd_created(file);
 	fd_install(fd, file);
 	kfree(name);
 	return fd;
diff --git a/security/security.c b/security/security.c
index 143561ebc3e8..daa9e0e0e879 100644
--- a/security/security.c
+++ b/security/security.c
@@ -6010,3 +6010,14 @@ void security_initramfs_populated(void)
 {
 	call_void_hook(initramfs_populated);
 }
+
+/**
+ * security_memfd_created() - Notify LSMs that a memfd has been created
+ *
+ * Tells the LSMs that a memfd has been created.
+ */
+void security_memfd_created(struct file *file)
+{
+	call_void_hook(memfd_created, file);
+}
+
-- 
2.47.1

