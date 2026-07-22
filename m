Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395F2C0F6D
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723406; cv=none; b=QQ4sk6/rpxFDaNnaHPpyjM3IJ+gecuCC8aOQrzZWe7DPLBWSjFj7b5OX3yn9VEOe3N7GSYnuhsYA3Ne7lAFb46RB+I8sNHGjmo5uBOW1M7TvmfFqb0IcmNkWGMpRdmxYhwUo/RSCFnyx7Mp+kGD1MDRjNafaqfzWq/uiccxaxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723406; c=relaxed/simple;
	bh=vX8NKo3tbkJYOQsFzvM0VcQFAQ/YMO+PXjFya3Ljz74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvJNg8JxCjBey2oJwWPvaZ+Fs0oZdTfkjx6iYJFj+S2cTglhmHx0I78DeQv5RgSajOozFKAASygbFU6336A25piMkPbLUyCi/fPxa0+8JtiZ0WV42ztSLTpiBcp+ZBU1rfj880DQUToOVgoqqg/lMN861xYcQ+IVVTT/7Ms0xeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aR9fo65Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aR9fo65Y"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69e5f8a193bso7545042a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723403; x=1785328203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFGI0FiCjKbyURDhEKHwGm5SarWbwG22EAg474C66q0=;
        b=aR9fo65YM5ZdSIDWrOKneGwLsXypNxJXRp3ihz9CVUZ8pbF7w0/DN6nYiuxi8dUmLJ
         rSdi42VHktrsFNxq+gVyWBTfTWYbvqJm5EooLsT6wSUK+j11G3EoRPYuvS7K7qymcdv9
         v5MB8UDuGAQcCJeSF7z9LUx2HSrbgRTO2H5NgjUlxIHdVGMkBYsTWwSqBzQdUfS9g/B8
         of1vmNpdgBEC6DipzYU/Mm86CqAejRxRzXRPnAFQ/vRLc4MbF3qXPFMpafuCbRyycbgk
         3ZzOLXOGUHLvWmOtOiql90UQKkKCsVQyIjL5pcta7CbvrFOtG0mqt9IcmWugzHmaDkR8
         +PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723403; x=1785328203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KFGI0FiCjKbyURDhEKHwGm5SarWbwG22EAg474C66q0=;
        b=Ib+rLFfK43rn2phZgo9yHIoenE3Z5XIxWmzHyAGO4hLCzhu1dQfbpNFSi/0J3eC5Xm
         dZAx2K9Jvuw6RbdujLZ7ttxk/KjVo4EMh93FdGzPNEkwtMovRdNp0aPWWbhQF4ELW+rX
         wNBnABSF9fvIYlCNLElVv/Nz1BLCywoqo5/IArlVMDtu0XWm9c441fYpmBpleKbqdSWq
         zzTtMEuKOfWfLM+tKpI5MdYbKFmo/SE9xBh18biA2OQEgDXZz4Dpu4kfImFXdnb2SDJX
         nMRiVtTG8RvvjG2BmUox/0nqP1SVZU1duNy/I/fHB74czL0+TXsgvbkoH5uB9iZIrURG
         4XNQ==
X-Forwarded-Encrypted: i=1; AHgh+RphRSb/nqwUceuuOjffhXL3/t+ENGUKXTWR6gMKJYp+HF/GWKl5tmaT5AAZ+Q1/pevvuqEdZ8/iD35r0cCXXBywlwabN6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOybWfiupwc9pHybSD6RCd8Ey2WuAGV1a+orPTwMJkU9dAiE8E
	Umzw/dR7GJr3ml0yuOmGM98DHE25jtC2ZLqkAog28rZCdgixipTiwHt5OcvQQzdP4HI=
X-Gm-Gg: AR+sD11lya85f9FVK/ZC8n0otr1/YCsNxJOikz2UnS/u0We/gWWkWrrrUQqGrSdxzBv
	t1vx1uN2meNEqTXwgVudXpVUm3teO7wxE3AKFD3BPf4km/+dI57m1YYCr3sLkhPiD50WiEd9taD
	Sjsyv80F14YWWOl7aiEo2YtEoK5cianiVWpqnxPvW00dSed7Ql9tjl3sljh8GBnR3U33GCf0M9a
	XDmHQoXtXxiZN4Xz9g9BA72ZBpmrpjVLe8nsqwxRDeOmnFX6ZdCQGJcD2QjuK3TULNJHUdAQGSq
	aCRUOfmkjkUFUqnOprS7GommiRq0lvEuQSXZ7eGK+qShUp3vbEOgu3RKWDZG01+h6a9cNsEuFeA
	95KlixOJpx5bzvqXlRAiOP1d/dY8Lvy1ew126RuDT7tSqpoHgpH4WdA6p63t5nic=
X-Received: by 2002:a17:907:3f8b:b0:c12:5e3d:4023 with SMTP id a640c23a62f3a-c16b457b127mr1033077166b.10.1784723402875;
        Wed, 22 Jul 2026 05:30:02 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.30.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:30:01 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 2/6] landlock: Scope POSIX message queue opens
Date: Wed, 22 Jul 2026 13:29:38 +0100
Message-ID: <20260722122952.42149-3-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for enforcing LANDLOCK_SCOPE_POSIX_MSG_QUEUE when opening
POSIX message queues.

Tag mqueuefs inodes at instantiation time with the landlock domain of
the task that created the queue. This domain is stored in the landlock
inode security blob and kept alive until the inode security blob is
released.

On file open, detect mqueuefs regular files and compare the queue
creator's domain with the opener's scoped domain. Deny the open when
the opener is restricted by LANDLOCK_SCOPE_POSIX_MSG_QUEUE and the queue
was created outside of an allowed parent domain.

This makes POSIX message queues follow the same scoped-domain model as
the existing landlock IPC restrictions, while keeping the queue creator
domain tied to the lifetime of the queue inode.

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 include/uapi/linux/landlock.h |  1 +
 security/landlock/audit.c     |  9 ++++++++
 security/landlock/audit.h     |  1 +
 security/landlock/fs.c        | 35 ++++++++++++++++++++++++++++
 security/landlock/fs.h        | 15 ++++++++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/ruleset.c   |  1 -
 security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
 security/landlock/task.h      |  4 ++++
 9 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 272f047df438..96d0c3b423ac 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -491,6 +491,7 @@ struct landlock_net_port_attr {
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
+#define LANDLOCK_SCOPE_POSIX_MSG_QUEUE		        (1ULL << 2)
 /* clang-format on*/
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 50536c568526..895397b5cbca 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -82,6 +82,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.signal";
+
+	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.posix_msg_queue";
 	}
 
 	WARN_ON_ONCE(1);
@@ -646,6 +650,11 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 				!!(quiet_mask &
 				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 			break;
+		case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
+			quiet_applicable_to_access =
+				!!(quiet_mask &
+				   LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+			break;
 		/*
 		 * Leave LANDLOCK_REQUEST_PTRACE and
 		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 620f8a24291d..ce85417548fa 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -21,6 +21,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
 };
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f7e5e4ef9eac..c6558b448a06 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -51,6 +51,7 @@
 #include "object.h"
 #include "ruleset.h"
 #include "setup.h"
+#include "task.h"
 
 /* Underlying object management */
 
@@ -1268,6 +1269,33 @@ static void hook_inode_free_security_rcu(void *inode_security)
 	 */
 	inode_sec = inode_security + landlock_blob_sizes.lbs_inode;
 	WARN_ON_ONCE(inode_sec->object);
+
+	landlock_put_ruleset_deferred(inode_sec->mq_domain);
+}
+
+/*
+ * Tag a newly created POSIX message queue with its creator's domain.
+ *
+ * This is the earliest reachable point with both the creator's context and a
+ * fully initialized inode.
+ */
+static void hook_d_instantiate(struct dentry *const dentry,
+			       struct inode *const inode)
+{
+	struct landlock_ruleset *dom;
+
+	if (!landlock_is_posix_mqueue_inode(inode))
+		return;
+
+	dom = landlock_get_current_domain();
+	if (!dom)
+		return;
+
+	if (WARN_ON_ONCE(landlock_inode(inode)->mq_domain))
+		return;
+
+	landlock_get_ruleset(dom);
+	landlock_inode(inode)->mq_domain = dom;
 }
 
 /* Super-block hooks */
@@ -1756,6 +1784,12 @@ static int hook_file_open(struct file *const file)
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
 	struct landlock_request request = {};
+	int err;
+
+	/* POSIX message queue scoping is independent of FS access rights. */
+	err = landlock_check_posix_mqueue_open(file);
+	if (err)
+		return err;
 
 	if (!subject)
 		return 0;
@@ -1979,6 +2013,7 @@ static void hook_file_free_security(struct file *file)
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
+	LSM_HOOK_INIT(d_instantiate, hook_d_instantiate),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index b4421d9df68f..aefe078845fa 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
+#include <uapi/linux/magic.h>
 
 #include "access.h"
 #include "cred.h"
@@ -38,6 +39,14 @@ struct landlock_inode_security {
 	 * performed by get_inode_object().
 	 */
 	struct landlock_object __rcu *object;
+	/**
+	 * @mq_domain: Domain of the task that created POSIX message queue.
+	 * Only set for mqueuefs inodes (i.e. s_magic == MQUEUE_MAGIC) at
+	 * creation time by hook_d_instantiate(), never modified afterwards.
+	 * Used to check LANDLOCK_SCOPE_POSIX_MSG_QUEUE against the
+	 * accessing task's domain.
+	 */
+	struct landlock_ruleset *mq_domain;
 };
 
 /**
@@ -141,6 +150,12 @@ landlock_inode(const struct inode *const inode)
 	return inode->i_security + landlock_blob_sizes.lbs_inode;
 }
 
+static inline bool
+landlock_is_posix_mqueue_inode(const struct inode *const inode)
+{
+	return S_ISREG(inode->i_mode) && inode->i_sb->s_magic == MQUEUE_MAGIC;
+}
+
 static inline struct landlock_superblock_security *
 landlock_superblock(const struct super_block *const superblock)
 {
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 08d5f2f6d321..70a7c5c7af85 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -27,7 +27,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_POSIX_MSG_QUEUE
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 4dd09ea22c84..aa37d50ead87 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -520,7 +520,6 @@ static void free_ruleset_work(struct work_struct *const work)
 	free_ruleset(ruleset);
 }
 
-/* Only called by hook_cred_free(). */
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 55522a601367..d65e43550b26 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -453,6 +453,49 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	return -EPERM;
 }
 
+static const struct access_masks posix_mqueue_scope = {
+	.scope = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
+};
+
+/**
+ * landlock_check_posix_mqueue_open - Deny opening a POSIX message queue
+ * created by a task from a different (non-ancestor) domain
+ *
+ * @file: The mqueuefs file being opened.
+ *
+ * Return: -EPERM if the open must be denied, 0 otherwise.
+ */
+int landlock_check_posix_mqueue_open(struct file *const file)
+{
+	const struct inode *const inode = file_inode(file);
+	const struct landlock_cred_security *subject;
+	size_t handle_layer;
+
+	if (!landlock_is_posix_mqueue_inode(inode))
+		return 0;
+
+	subject = landlock_get_applicable_subject(file->f_cred,
+						  posix_mqueue_scope,
+						  &handle_layer);
+	if (!subject)
+		return 0;
+
+	if (!domain_is_scoped(subject->domain,
+			      landlock_inode(inode)->mq_domain,
+			      LANDLOCK_SCOPE_POSIX_MSG_QUEUE))
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_FILE,
+			.u.file = file,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	return -EPERM;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
diff --git a/security/landlock/task.h b/security/landlock/task.h
index 7c00360219a2..0b031dc17bbf 100644
--- a/security/landlock/task.h
+++ b/security/landlock/task.h
@@ -9,6 +9,10 @@
 #ifndef _SECURITY_LANDLOCK_TASK_H
 #define _SECURITY_LANDLOCK_TASK_H
 
+#include <linux/fs.h>
+
 __init void landlock_add_task_hooks(void);
 
+int landlock_check_posix_mqueue_open(struct file *const file);
+
 #endif /* _SECURITY_LANDLOCK_TASK_H */
-- 
2.50.1 (Apple Git-155)

