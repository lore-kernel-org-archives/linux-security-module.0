Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3737268A
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379619; cv=none; b=rVCIOszdNrdqpkrIZTnY5Rfm+bSAjUGQfMvKVA055EMojtxcpyhD3+StSC4vfGRw2rnqzxaMQrGdm/Gl9lsPphF8dJhxRLpNJ0RoNEdYBrw70eDK81vcYjHylhQog405b7r3k1+G0wIGFJh6My73ZdBIXBtupxak9F7wpXP+5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379619; c=relaxed/simple;
	bh=BU308g11FtLppIAB/aDcWxQuNwgPLrw8nrpt0uybx18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di/Nc1/TrCe0wJVJfkoS0rk2y2K5NsGJNVo52zVLdTVOjEPZGcni/Uk/qhjQnb4X5Q9IUxxbVqERSsANbG8UMPlBs0diOkek/Jlp6zb7u5mf1kSgoUjHGdANoen6+8+txG5N+1h27PY/nx/oErfI6HdO6o4cRTASdnRxjYPtm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU9RvFuA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU9RvFuA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bb0d18c7f9so57095747b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379616; x=1779984416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hdgfN+G4et8ibY6iXu0zvGvxBXNyZHs8s+cU+ttE2o=;
        b=PU9RvFuAnzPfWcAz6zit6qNVxwWsV8TgMRcINpvOEnueBAObjFNRvUu98SizdW3/nX
         C8pdc75DSOW16NRhdfNO1TDQySCU92wfpEcxsFZ04rM+clH5V7BalUmZkzWFlMkUWTOM
         d1ubVH1rDhQyScdJdI3fZ3V6CP9apCQ+pAuV9m8/qmrcqo3Gr6lRzZYYSALpp1dDAXff
         2x5BfihaRtxWN7m/cfBT6/KnB7bEYR7KKbD5pfPYT/JHNxe+bovu9TQ3dDTMo3WLWOc1
         va8t9CHl8D/Fei6y6jeFlQPy5S7ol4ECz7Dm90+IWREQfB7ZLX5yQyG2UzIPGFqh/b/P
         KMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379616; x=1779984416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6hdgfN+G4et8ibY6iXu0zvGvxBXNyZHs8s+cU+ttE2o=;
        b=l+tR8Hgk6sqyF6onglQF89cnhpbdhLTlt/sE4RrfIEHKglLP3NFosvTz2+SyZN4lh2
         CsU/eM9gU4VN9ZKvF0j4lsRGd2wYzsGbLt+VNElVweXCAY3YefZ6q6Ibe8EOUDT4FADp
         CjqL7nhaMENzbeyIBfLQtt71e5YjdqeBnwuE8F+iZthu7kmX/1xnr5RFr5YKqJIT+NEc
         l6Ybnc5CAzEMJJYoiuxaiT0Nw4+bDY1yD0RKk+ccTNBB2bYbdHUPdCIf7hdD/EP8m5gE
         kWMSby27+wMrkbaI1FUrvhK3GOtM31pu/nuOIz9lEweBsSJyEpti1RlpEVaEzxCYkErv
         HjhQ==
X-Forwarded-Encrypted: i=1; AFNElJ89uTabwnpxAAawRee+J/VZGlT1BKNQsXjlP0ZDkybRYlbaU08/uMi6tk4MSue27VYEi6WodQXw2bUuT58ZnExpqh99m/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhvBOE2jRF//voaBWMJu7zJTObqUwFoQKQMSEBBIY+YJLn6j8
	ALzepVFRt9LkLSLWIC0AuAUr/G5g0iF0wnjG3NLY2T+37MOQYeohfo2v
X-Gm-Gg: Acq92OFNQN7ims/iGtkI8HVbfTx2oQq6UIg4A+uxC385PozbhU4IWne1fIHb3AeGG4a
	VvFWXyKApyQujR+HDJD5PFL0am0z161QHsLdNvn2wDT04mdAMipeVbY6YvYJE0IGhOCmMJVZUeI
	m3YmquCHkr0zMs1iXHEAPgqO63raAyHvujPEy3uEzl7E6i2+Y8SBA/webzrF6xnGQX7kq/6SIX8
	3YskGO4+XeKiXqGEKSVS8Nyuimq2NRbvGIC+uqWwALPB6z5BUSc2KM5zjgJv7mPKFXUWvu59ATz
	saMzXU5UjCyt8LHds4TyMi4MHs7bj5/uva87GWOoUaFkpE9nXra62xWjfwxm1nhijm9C0A0+45Z
	08l01mfL66NY67j2h1kNCXt/vnn5RVTfcy83panDO70MswzQchFAjs0R+sYSl/akT/GzqvdsAxS
	voqiKEpl6awRCRB9EOFTpRaoqDmPJBg5alebtbVkYPfYB4d9doPlmpWYPHppySH+5xWDc1CgBSO
	fZjwwZc6Q==
X-Received: by 2002:a05:690c:4d46:b0:7bd:5d03:dc1a with SMTP id 00721157ae682-7d20a6ab26emr36274407b3.1.1779379616568;
        Thu, 21 May 2026 09:06:56 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:06:56 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 1/6] landlock: Add kern_ipc_perm credential blob structs
Date: Thu, 21 May 2026 12:06:35 -0400
Message-ID: <20260521160640.1716746-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521160640.1716746-1-utilityemal77@gmail.com>
References: <20260521160640.1716746-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add landlock_kern_ipc_perm_security, tracking ownership of SysV IPC
objects.

The struct contains the creating task's Landlock credential
(@owner_subject) and a @kind enum identifying which SysV IPC object
this blob describes.  The LSM core allocates the IPC blob for every
kern_ipc_perm regardless of object kind, so the generic
ipc_permission hook needs to be able to tell which objects it should
enforce a given scope on.  An enum makes it straightforward to extend
Landlock to sem and shm scoping later without revisiting the blob
layout.

Define the size of this struct in the lbs_ipc field for the Landlock
blob sizes.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/setup.c |  1 +
 security/landlock/task.h  | 50 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 47dac1736f10..44aff2d734e9 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -32,6 +32,7 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct landlock_file_security),
 	.lbs_inode = sizeof(struct landlock_inode_security),
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
+	.lbs_ipc = sizeof(struct landlock_kern_ipc_perm_security),
 };
 
 int landlock_errata __ro_after_init;
diff --git a/security/landlock/task.h b/security/landlock/task.h
index 7c00360219a2..0fb82e5e347c 100644
--- a/security/landlock/task.h
+++ b/security/landlock/task.h
@@ -9,6 +9,56 @@
 #ifndef _SECURITY_LANDLOCK_TASK_H
 #define _SECURITY_LANDLOCK_TASK_H
 
+#include <linux/ipc.h>
+#include <linux/types.h>
+
+#include "cred.h"
+#include "setup.h"
+
+/**
+ * enum landlock_sysv_ipc_kind - Kind of SysV IPC object backed by a blob
+ *
+ * @LANDLOCK_SYSV_IPC_UNSET: Blob has not been tagged by a Landlock IPC
+ *	allocation hook.  This is the zero value used for sem and shm
+ *	objects that Landlock does not currently scope, as well as for
+ *	any future kind that has not yet been wired up.
+ * @LANDLOCK_SYSV_IPC_MSG_QUEUE: Blob belongs to a SysV message queue.
+ */
+enum landlock_sysv_ipc_kind {
+	LANDLOCK_SYSV_IPC_UNSET = 0,
+	LANDLOCK_SYSV_IPC_MSG_QUEUE,
+};
+
+/**
+ * struct landlock_kern_ipc_perm_security - IPC object security blob
+ *
+ * Enable provenance tracking of SysV IPC objects to scope IPC accesses.
+ * The LSM core allocates a blob for every kern_ipc_perm regardless of the
+ * underlying object kind (msg queue, semaphore, shared memory), so callers
+ * that act on a subset of object kinds must consult @kind before
+ * interpreting @owner_subject.
+ */
+struct landlock_kern_ipc_perm_security {
+	/**
+	 * @owner_subject: Landlock credential of the task that created the
+	 * kernel IPC object.  Only meaningful when @kind is not
+	 * %LANDLOCK_SYSV_IPC_UNSET.
+	 */
+	struct landlock_cred_security owner_subject;
+	/**
+	 * @kind: Kind of SysV IPC object this blob describes.  Set by the
+	 * matching alloc hook; %LANDLOCK_SYSV_IPC_UNSET for objects whose
+	 * kind Landlock does not currently track.
+	 */
+	enum landlock_sysv_ipc_kind kind;
+};
+
+static inline struct landlock_kern_ipc_perm_security *
+landlock_kern_ipc_perm(const struct kern_ipc_perm *const perm)
+{
+	return perm->security + landlock_blob_sizes.lbs_ipc;
+}
+
 __init void landlock_add_task_hooks(void);
 
 #endif /* _SECURITY_LANDLOCK_TASK_H */
-- 
2.53.0

