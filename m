Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80340D57B
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766917; cv=none; b=qGssLGNog53m+Ljq004723cAM12c5rRmVKi29Y9A0kQnvTT6Kcp9aYMANrsRt8LYFgWUmc/CgSWkUhgMk2OEgGGE+69Sv3H+GodfYFBYGr/hc8LNgv0FcFyBnlFBFh7tTsEhB1TuQdy0RU3Kb6rMFJdmCiielDbzGiA3oQyyaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766917; c=relaxed/simple;
	bh=C2YGbhi3Y2t3x0w+mHAnTed9FAdGCeE9k5Eoa/x6/vU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N22Z5YhnBOcGoEBM7CDtOS+5PhLgQ04YdcHMIAjpQbDIxvGQieogX/w0IrfUqQ+lC79LDZ7pm2uaR0YAUJve3u8OgIndw+581Q5Xr7Gif6h7wPyA7dWoDBHcgQ3E1hdSrUPQyh01sXcwdaqH7kDW/vn40Zx84r98KwAH8x04bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iH7PyU57; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iH7PyU57"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-697498c701eso3397663a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2026 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782766914; x=1783371714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfP0fAETurhoFPtENyPIigELG2eoUP9uole+f4i6y0w=;
        b=iH7PyU57o99zDAMaYeWyya5N2v7ehUw34k2zDsgSI7pZaCBmXdPnurjCVcm6BJx+Li
         PjFt1DKIQD73bopjwGAGijn2mphvMBO00XOdT7Wf21th19H8rPuHt3DS7RvwkPkJmYZL
         wzduZ+JwUeyaA23isbww/YzTSTWjq8D6ePvcjEVhc39sdsd7l1jKOvyGa+92RAoH1O7V
         YsD39h6/SllwxTECVJ6HqCs+QR6ehJ5rZigcaRLBP9jIoQ9Ic6eM2y6eSM9NF2YnPZjg
         ll4fJ0xaG9B8iXIhBT1gWClzADtlFNubCrmhx/vT1z3MHuEBlGXczXmc2xu9PN/B2jbp
         5XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782766914; x=1783371714;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfP0fAETurhoFPtENyPIigELG2eoUP9uole+f4i6y0w=;
        b=L735LO5Cg+zqv6Q9oaqkmSXYn3m48sl46Ivs0VONkReRMMnEcq9hikY/ixCD20yax/
         dq9wFXgLbGOo1oK4ycjZS6t9lWFm3ioWxB/I9ou1HdnJbDj1uZRAo+F8COHBe5Y3sXpK
         CiOYIzKPxyKiHuZDahGvHLoD770gAWrayixJ5d0LDldWz6W9ri6ZVDhic3VafE0+GUWn
         KhY5Lj2SAWHcOSAXlsf+TmbwgC1UIpIlMonda0a8mKGBf/9epj0OBA/E/53kZqk5M3Wk
         QnXQSO++FQRIhRD/yIhXAr1QPpJlP64ggeZND0sr3XN49iiTTWAWQCdx7AfNtnkvbwy3
         +PuQ==
X-Gm-Message-State: AOJu0YzgZOs2WpGdeUYc2RNfYfVm5bjRD2b6yghYCAHUarNPFft4DDal
	DTtYITtgZdBLgOH1peHVJwdYnOpP3ebD/wXBDxXcVWbrsjJ2g6Ylygut1+YkmcImprpg3xDL4QK
	a4aRYsQkexR/5IIw8LvCbxwHwwZKH+Zly1NyOM3dkwQDifTFoL2FMKPPttWaAmFT8NKuxz+koLy
	lwaNvHK+TAn8lXIfzKa9equLBsuIYFPVBaaW7SAMo1XXUxU1saVkwFOTXJoLJzlGIuaIWdpJQna
	1J1L+HQK7uWpcCBYX1Y8g==
X-Received: from edsx3.prod.google.com ([2002:aa7:dac3:0:b0:698:3db8:b4])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:390a:b0:697:7f6a:254b with SMTP id 4fb4d7f45d1cf-69879e31c34mr324995a12.24.1782766914030;
 Mon, 29 Jun 2026 14:01:54 -0700 (PDT)
Date: Mon, 29 Jun 2026 21:01:50 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629210150.832576-1-mattbobrowski@google.com>
Subject: [PATCH] lsm: cleanup repeated lsm_blob_size_update() calls in lsm_prepare()
From: Matt Bobrowski <mattbobrowski@google.com>
To: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Centralize the definition of LSM security blob fields using an X-macro
(LSM_BLOBS_LIST). This reduces repetitive boilerplate code across
struct lsm_blob_sizes, blob size registration in lsm_prepare(), and
debug log printing in security_init().

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 include/linux/lsm_hooks.h | 42 ++++++++++++++++------------
 security/lsm_init.c       | 59 ++++++++++-----------------------------
 2 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..0e73b22bdeea 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -98,28 +98,34 @@ struct security_hook_list {
 	const struct lsm_id *lsmid;
 } __randomize_layout;
 
+#define LSM_BLOBS_LIST(X) \
+	X(cred)          \
+	X(file)          \
+	X(backing_file)  \
+	X(ib)            \
+	X(inode)         \
+	X(sock)          \
+	X(superblock)    \
+	X(ipc)           \
+	X(key)           \
+	X(msg_msg)       \
+	X(perf_event)    \
+	X(task)          \
+	X(tun_dev)       \
+	X(xattr_count)   \
+	X(bdev)          \
+	X(bpf_map)       \
+	X(bpf_prog)      \
+	X(bpf_token)
+
 /*
  * Security blob size or offset data.
+ * Note: lbs_xattr_count is the number of xattr slots in new_xattrs array.
  */
 struct lsm_blob_sizes {
-	unsigned int lbs_cred;
-	unsigned int lbs_file;
-	unsigned int lbs_backing_file;
-	unsigned int lbs_ib;
-	unsigned int lbs_inode;
-	unsigned int lbs_sock;
-	unsigned int lbs_superblock;
-	unsigned int lbs_ipc;
-	unsigned int lbs_key;
-	unsigned int lbs_msg_msg;
-	unsigned int lbs_perf_event;
-	unsigned int lbs_task;
-	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
-	unsigned int lbs_tun_dev;
-	unsigned int lbs_bdev;
-	unsigned int lbs_bpf_map;
-	unsigned int lbs_bpf_prog;
-	unsigned int lbs_bpf_token;
+#define LSM_BLOB_SIZE(name) unsigned int lbs_##name;
+	LSM_BLOBS_LIST(LSM_BLOB_SIZE);
+#undef LSM_BLOB_SIZE
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7c0fd17f1601..c256f1c33efa 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -282,40 +282,24 @@ static void __init lsm_blob_size_update(unsigned int *sz_req,
  * lsm_prepare - Prepare the LSM framework for a new LSM
  * @lsm: LSM definition
  */
-static void __init lsm_prepare(struct lsm_info *lsm)
+static void __init lsm_prepare(const struct lsm_info *lsm)
 {
 	struct lsm_blob_sizes *blobs = lsm->blobs;
 
 	if (!blobs)
 		return;
 
-	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
-	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
-	lsm_blob_size_update(&blobs->lbs_backing_file,
-			     &blob_sizes.lbs_backing_file);
-	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
-	/* inode blob gets an rcu_head in addition to LSM blobs. */
+	/* The inode blob (inode->i_security) gets an rcu_head in addition to
+	 * LSM blobs.
+	 */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
-	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_blob_size_update(&blobs->lbs_perf_event,
-			     &blob_sizes.lbs_perf_event);
-	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_blob_size_update(&blobs->lbs_superblock,
-			     &blob_sizes.lbs_superblock);
-	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
-	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_blob_size_update(&blobs->lbs_xattr_count,
-			     &blob_sizes.lbs_xattr_count);
-	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
-	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
-	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
-	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
+
+	/* Register the LSM blob sizes. */
+#define UPDATE_LSM_BLOB_SIZE(name) \
+	lsm_blob_size_update(&blobs->lbs_##name, &blob_sizes.lbs_##name);
+	LSM_BLOBS_LIST(UPDATE_LSM_BLOB_SIZE);
+#undef UPDATE_LSM_BLOB_SIZE
 }
 
 /**
@@ -441,25 +425,10 @@ int __init security_init(void)
 		lsm_prepare(*lsm);
 
 	if (lsm_debug) {
-		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
-		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
-		lsm_pr("blob(backing_file) size %d\n",
-		       blob_sizes.lbs_backing_file);
-		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
-		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
-		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
-		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
-		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
-		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
-		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
-		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
-		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
-		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
-		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
-		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
-		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
-		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
-		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
+#define PRINT_LSM_BLOB_SIZE(name) \
+	lsm_pr("blob(" #name ") size %d\n", blob_sizes.lbs_##name);
+		LSM_BLOBS_LIST(PRINT_LSM_BLOB_SIZE);
+#undef PRINT_LSM_BLOB_SIZE
 	}
 
 	if (blob_sizes.lbs_file)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

