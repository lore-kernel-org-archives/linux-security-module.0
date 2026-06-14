Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514CD283C82
	for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781449250; cv=none; b=haLhW901+wfOwFrhPheOMVQXFMc40hXrnhb+7nYy9O5zLGxkmiJGLKkkoa8aX23TJVlhxCjtB0VMAW/tLW4w32NRynXjflVd4q4Ru1UC/gLHQcpIuCdaYSw0eA41+7tZN4tcxStPwfdVW6gIgm63OUJ41k7vBXKU6M0HeM00DME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781449250; c=relaxed/simple;
	bh=2npXpHQkXqKbu9W/ajkzv5o/gKk6GeI+UO27XdxLb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnJw4l/GC2W66TgKQHdyuRSrG2BOkhOUAP6k+xssRqoX3JlhlhdkpzaVteut2iT9/L2dvM2m72RN8SJvv13L/vZmJEUi3TR4En+EzsScCaHcmVUMLYRCdWxXn+FZHpz8sYZEc9rQBQPcuVljOhEzlu8DDStfCy32rcZUysPgOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyNMNTb4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyNMNTb4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a76757e5so17419655e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2026 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781449247; x=1782054047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK+mjRbLPH8mzNxWadw+RKrJrBeJDqrl1whghjB/rRU=;
        b=HyNMNTb4JGX/CxJwc/0aheo0/NzEnu/M8ngz3H9G5mRhBUdAEL4uoCL0Suk+Edu2yN
         d5ZF+WKOLnzwUq+BsajzmqHZ4Q525SBelsZ0FyRK+JfXmSePiYPzFkWIaZYLVeYoXu1m
         cRa6RQR1dXzpDDAC16tNSyZ7g7HCyfQSTjvckfrXY9T/76E9S4Ekk8O/lO8lC9gOQRR+
         ouMNpXZjYVmKi9DLZkUdcHu/hzqI0dHFbwztGx70SJBIAC2KNgbzGWjWKxSR1Le5gJmE
         sgdZRBrPmXeyk8YN6Mmvm8c1ykQmHdPvM121SiaK4FBeP/QL4DKZCekyA+onuMg0rolh
         Cr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781449247; x=1782054047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK+mjRbLPH8mzNxWadw+RKrJrBeJDqrl1whghjB/rRU=;
        b=cA1nFCdhNsfTlE8iXW/O9dinp1T9cHGbkUgOyy8fIrrjDM/ZHk8Cwv7Dfevl41CRQd
         lY3mptUwGnxJjU9YnKIgTPCLwSMAHTR2/nhg7V2tYNDQM/pAxwHm1mD/1C1ChuQMDHbK
         DGxSLHewvbdXWi0BEN+rySHxIzA/K5KTfQW7Bab0QNyptZynIGZ14859FYF0dWIPHvgf
         peDilXx5uT/Jcsf+mksW7+pzWHo78YYz1lqw8zLepLhUAjIbKH5cF4ln9l5CTuQf4QOE
         rSd37Bhhw3hyPBGRRPpUFuxZuYNQUbKsrUGsyI2kOdaKNL6bvPULIBffvQSbgxjtNeP6
         w7Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8htafSlm796yBpo2lo9isquR+AxmBUy4J4c5o0UDJSO1F7+QsGZfzzg0rLxD/RLOprIYBMh9bl79ZIbAqydLDG/ZwLbfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLrZXUzFgh4FHgj7qcaKZ9+InxfOtPSdvI7SELhXMgEJ8M4gp
	PjesGNe2gVdXQaKmnHJg6QkRl6rs+coFUuZMtBJ8W7FYSjoVjvdPXtU=
X-Gm-Gg: Acq92OHu7WB95gUGltoIV1C0GgyoJocUtTDm1Oh0sg6W6Fma5poy9uk3Cj6RP8SKnnj
	U/pDSOCJ0E67gODMgBndK9y7gQWGwiwos8uU4RCGqg3ecgJntFW4BpFT35CuhhO4t1rwqUsB2WY
	HTcO4TPBc41ylppRr4r8aNPUGhsl9OJLvoALln3VPQ2C7scRyDEkzXN7ruH/rKSPjvQmzFDOU4k
	05tDmqNhVXpCXfc9AVnJIYBGVWTHezKJCIw9eCGmY44k8UsnZgOlZQ2NBbNb7AVn73Vrya4esj3
	jLpgfCgllnSlt7uIcTNqute4P8XWdnUyQyXkwcT76gwus/1khaL1rzkzggzfhAVPmjZCoLcF04U
	sNkIRGiHK/hgFxfyLucSBOB/69SMLtx0eLz0MCyCCjI4nyF4eN9LOGOoimExBSqiDh16GOOAlSI
	QHkx2j/c2YTB8TNz54gXJop5F5zauupkpK1qZzQgAtzYE2lPtOTGbVSjdlRAe1ZCQ+euhuvhUv7
	N4UPhUYQewnr+aUP3UMVU/uEXP2eXqvh6tKqD0+iQ==
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-4922006283cmr59149455e9.14.1781449246441;
        Sun, 14 Jun 2026 08:00:46 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.127.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922032ae56sm165261205e9.7.2026.06.14.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:00:45 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	ebiggers@google.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Subject: [PATCH] KEYS: avoid filesystem reclaim while holding keyring->sem
Date: Sun, 14 Jun 2026 16:00:41 +0100
Message-ID: <20260614150041.21172-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__key_link_begin() runs with keyring->sem held and calls
assoc_array_insert(), which does GFP_KERNEL allocations.  Those
allocations may enter filesystem reclaim, evict an fscrypt-protected
inode, and reach keyring_clear() via fscrypt_put_master_key() --
taking a keyring semaphore of the same lockdep class and closing a
keyring->sem -> fs_reclaim -> keyring->sem cycle reported by syzbot.

Wrap the assoc_array_insert() call with memalloc_nofs_save() /
memalloc_nofs_restore() so reclaim cannot recurse into the keys
subsystem while keyring->sem is held.

Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5a9887d6b7be..21bb2e7e7cca 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/sched/mm.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
 #include <keys/keyring-type.h>
@@ -1298,6 +1299,7 @@ int __key_link_begin(struct key *keyring,
 		     struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	unsigned int nofs_flags;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1315,10 +1317,12 @@ int __key_link_begin(struct key *keyring,
 	/* Create an edit script that will insert/replace the key in the
 	 * keyring tree.
 	 */
+	nofs_flags = memalloc_nofs_save();
 	edit = assoc_array_insert(&keyring->keys,
 				  &keyring_assoc_array_ops,
 				  index_key,
 				  NULL);
+	memalloc_nofs_restore(nofs_flags);
 	if (IS_ERR(edit)) {
 		ret = PTR_ERR(edit);
 		goto error;
-- 
2.43.0

