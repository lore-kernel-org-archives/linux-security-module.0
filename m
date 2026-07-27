Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563C3F8241
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193726; cv=none; b=j3shDIrR7H4Q8MpltokssInPBL2kgrHMfJYyBP2PFL+iXwSUKZH2Ix8dC8IaRDqSk5N0pvMZ3wYIpeX9UXsN/atvScXF8aINZXokD6NlorMWvwbyn5D2wsqKzJYziWdVTy0IA96u5FeBq30r5YUhlhN3Y2LxzK6cXIKcZTi3kM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193726; c=relaxed/simple;
	bh=O1rV5+A8Iy4Vmlyl5t+KcvFOG45mXBBJOijcHDozpVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6KCBy+VGEWahWmszzJqhw4kvarMeF1unUk1SlOTRpr9Ke9BfEWTjRxscj/RBqmum7jEE7lcXQoccCkzYp3rSz46eKWxAuw74ZEfpVlOKawyew5x82MuCNTSqTt+H9B+5snm3qBwTAsHpke5D+bsKmoP0wa6D1j23m4CbIlW/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILtjgYaU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILtjgYaU"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dbcb505578so29856997b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193723; x=1785798523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzAMCAgjp9hGIu+mckhxdDFv3Qi0g9QLb7n7aNYS+iE=;
        b=ILtjgYaUHH1xe9dBKl9ZlkVsVShpMXIoACXwSKwXItQWbVO+dVtsH23vhAyzYWKbCl
         /z+ZLch+njXTb0MBWGT08HfuLhbEWb63MvAZtMJkwqcoxbLAEWmrLjzMR1H9h4x1lBxw
         nCO9cEKPqmM0jP1yIOdgoSfTaVTQvuXRUPzrWqWiThOsW6gM2Jiv72FcDErTkRpLD3zQ
         fr1tnHBwPt8GZaUuu89P768JKiE2q0Jt8MCUdXUXFs253Uwi1U1I5ON98IgVczCa1QgA
         O9UkTVZPXtX82bs32B2Skkb61KkMI3qEGPHmXN+Qd7r9PJPYgSglgROCG7IWQu5LdLHT
         26oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193723; x=1785798523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzAMCAgjp9hGIu+mckhxdDFv3Qi0g9QLb7n7aNYS+iE=;
        b=hBf/UrPoBPUXNCHRJsBe7aZktVXizqfVsuA634L4StSBE1BKCaXEXtAYwmttKC4Qi0
         DytbVO6jD+aYA4VhGhcAaQ3dtwUC0qgInTmHhQJLnVNKnfRhRgZ/wxJ7WKTaaDguFyNl
         G49VNB8omp22lwWFulLfEWEtrGwvuLw0BsVl23O1w5+SLaHNA2FahhiDj4r/dzJ3JYU9
         NksF6M8ABm8OQsV0g4Aolq2+Ox5HdqB2YGQZw5UgeMhiKqBxyQkPKGKUI8WKHtUfmpfr
         YmBmoXB+LzTunKy+/GqW6P2pV5vws+Kr8STZ7Brg3nL/BNy3gazfXQNlCatVjcgQSECs
         RtuA==
X-Forwarded-Encrypted: i=1; AHgh+RrescSN/ykIS05z9nw0d2GEx5sk/InS/n7FysJJH+ny6C5r1ipBDbjgmqzUOQiDjKuqtWQU4oWqiDnaMnm+yXNEA/7meEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykrpeRKns0qXsSQmkTDCrA26j99jcAnWEt2jTC1PnLDIxXog+H
	VS9IKN9qQYEy4yKxY0P467dki81p+dA7EvWuGSPloPyOs+KbxS3P3uiCYqmAnzWp
X-Gm-Gg: AR+sD12HPXAg87iUJ4gb9fNEtPpXjCLO2dKAaxrLsu0CNgW6eSAEM4jUL+Ymb4jQlln
	odn+pf9qWZBpOSchgNWyIMcbUZoJcT4zCVVxfgBH7TJE1TjUSxpifSAROQQNSJ/LEhfBa4v8UYq
	pHaFznWliNpVpMmvmBSe9zQgCBqxttghMNdjE9ak7Wd7MSyBL9aMJiXxbGTDN3U6eIfrij5Ksli
	BPv2pu3vpUzGP9L8owrJiCyuhdD/je9Iv+Wd0vfJtBugJ38IOWEFC9Hwxqau1AqVzf3cEkS3vr1
	NgawnQg4a4VgpfVKkD3DTulGsJrNSvWc/x/lpyblL98bHRHjhCmwoHC7FxfwKjWQZmId2LiVxnX
	ZRc9a3RnHrizpDOrIFqzZaS/CaxRExET6eTim+b4WljHrqHoUyvUwDJ7Oa+gEsE1xqf+om8191N
	Cv1lxrB89pq7aeGEYPhg2NJRNYikKNyoy15+d1
X-Received: by 2002:a05:690c:3604:b0:81e:9ba9:d37a with SMTP id 00721157ae682-81f69e690e0mr36397057b3.50.1785193723450;
        Mon, 27 Jul 2026 16:08:43 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:43 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 1/6] landlock: Add kern_ipc_perm credential blob structs
Date: Mon, 27 Jul 2026 19:08:28 -0400
Message-ID: <20260727230833.138165-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
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
2.54.0

