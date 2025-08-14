Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BF283FDA
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212075; cv=none; b=VLR8yDBTf49rUavIp5B+VQsUy54y1subkM/92j0RBQ8illIQor/fBzeXOmHgxgO2Lyu6+Gt4bRGsKdkK202EcRFXGU1rtAUVTA3oEnugKEkYnOQxJwcGTbjlDzJJYhlM8np0ycsvGewUh5C2vQfPLFbH0PlOBhmJ/gc5Pnc1W8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212075; c=relaxed/simple;
	bh=iRVF+xEWfqXJbI7sAP87mt7RMtwKEgN9MdoWayDEog8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLHzW502kNRlhfrNN75NnVL1Dta5YUJr/kKqtiHPgptoMZPIjfuhY3l+BNctarRYHVROpNtrNAXNJTSKXyUZDDAvscHYRk7yhIpLkuuF47x7OFFVc5RryeG6a3V1xXDppPsEWP6hGVdf/AOeD5aY5jP4BprR9z/YJNC58HhDSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d8w/0XFF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d8w/0XFF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e870636870so139799385a.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212072; x=1755816872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpenjMuo7Sc6NJRPsD7JHoZWrUfjH+eq6PW9etyz+XM=;
        b=d8w/0XFFOtFIJUTDsiAlS3VsTePw3jH8gAMIY1qHWHCg3fW2eshnf7Im1RGJ2aKCel
         oT9+1NxfWHBoJhOVFpwnTFzdN3mG5utvcfcp6nyuynxideFzIuMtQmHZ4HAxANp8Culv
         X1lYytoUgbNrHYbMzsOQTyS/xIqhjx4VOttSi44zx858xt46yNO9d6qq3/RLLWuwowJY
         Lc4V0wPgRwZDkVWQK3FfMVTW6KkXnOx5UmLUcCj/MD5SHqAS/R5fcZyjWTHkYm880KaG
         7pUhUmFtEH3rL5omAMClqUFh4A9/6xjvb45Vo3vrLlcC+dYBasNu2nPgME11UxDWRgtf
         L0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212072; x=1755816872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpenjMuo7Sc6NJRPsD7JHoZWrUfjH+eq6PW9etyz+XM=;
        b=lBMVhaDY7YgXlIjeRlQI11KnLP/kxY3RymKUKH37fXbLBd6+ONm9TX9Yl1XPlD0p5I
         EK8C+Q7OR/vfv4Nq0xOXmLIDaHcFE3pW/Mz1zjGt/WFsg4N3Vg5I2byvIc5j3YEqzaT2
         Gf87Y3/EcxvdUYGpHf0bxR9S8NoGY6eI9bQEiK0ZIMO/0ZjTXDR+zk1gDZW97+e78X3C
         /9SNvLA+OT1Ys6sGFzr7t6P1utUQci7gYkl9qIPEYOOCGm2v1APW45KOtoYhhNh3FPWX
         9hcMCIUMbjbBZOq+7Qez/QL9JVd8rK/USzGc7ECOsOh+ASxa8d68xp/0lpJILntv5HDn
         1QAQ==
X-Gm-Message-State: AOJu0YyoKQzLvvxz+o7/vI9tqVFgnYZwZO3MfGMXLZjt9gtvKi6fXzgs
	xSfv36oxnmt/cph5HkPvBASV7l6b78pZ2LjAQ/ioleaJbl6FZ3L5jNvng/eq+lvHqATKx2GWNCy
	HYX0=
X-Gm-Gg: ASbGnctCMIFKKaCjMsVAAnSqP2k6Pih34ebyU5BNu/cjMVHBbMeZgrkZGejfuweLJtk
	61fuI0eyFWQZxGtQeT4vso9T0Uj9/g8voskuF3sDOLFELXbxyv32vW88tBXE/eF4OBA9A/80RIl
	boiflzSIg7xO009DQkurrctKsVzLpmz/uLlvOuxLELSllP9KadIL9m3WAoOfe8ZOoDOY6FM/zpi
	FLrpquY7uwI4xAo/D5NZU41XJlPS+uaTPzY3jZVsA07hgvMg9ZPoZfwNT1pJAs3/It9bxcbe7e4
	EDvPl6soOH25CiufaL4OzVU6jIdHMPkf0nqzS8IgHqJzP+hFA8zv3zhKJEcnPAxUAaJpEMlczJy
	8WTK+Smqc5ZCIpv8Vgt1BI88ycAkGgCcZndWBlpi0L9RnVESu9XR3b7hXM+hiWOHsGvw=
X-Google-Smtp-Source: AGHT+IGrT0Q3QuP+/VewGYOnaQRFcP1EgaRxcCxaEqXrFX20fAQOduQGqYztMGHm7U73uOCWz/XiNA==
X-Received: by 2002:a05:620a:aa03:b0:7e3:6a01:e6ba with SMTP id af79cd13be357-7e8703d4be7mr618870385a.8.1755212072387;
        Thu, 14 Aug 2025 15:54:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4f3f9asm41984085a.66.2025.08.14.15.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:30 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 16/34] lsm: cleanup the LSM blob size code
Date: Thu, 14 Aug 2025 18:50:25 -0400
Message-ID: <20250814225159.275901-52-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=paul@paul-moore.com; h=from:subject; bh=iRVF+xEWfqXJbI7sAP87mt7RMtwKEgN9MdoWayDEog8=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjAVqcKekGsxdwEpFZ+R851tyjFUIv6kJFTE eleO+7BQFuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5owAAKCRDqIPLalzeJ c/+MD/9JJFLjWjyaEFpILy7cW/H/cQCsAR+P+X1Vo8gZ6uHhHdbC6rbAgddrwwN1p+6kleeociy W6+02O95eq5traXDIzNPx06or8sDt5zj4pFP6XZsKSDiH5RAfNigGfXNbBX3wd3rCe1+KDIqSvd KXJyEZTwTUx5klGu1jXzMS5nxTTGysgyfTL+Og/SgazK0go93Nzc6wLZdBMYZZANE02BYRj0rRI cNjuBI9vxmzab3mcsS6SGygo9DGRIbi8Z7KUk0tojDdQR2/DC5W//vY3sCbaaIDzR5rUySsdMjx +nwEBtCskJGR7HKOmCFMh2Op9dRfQlkrKulnSGvdhCIKdto21+KA0bIiTiFAf+njpq0+BYs5anI d7nETlQ/VrBSg1dwwVqbB6hYG3pq4AranrI3n2ayu01O8jpIWS9Ta5fSGXvWjsDwws2bXf6OP/Y yAFn7yRF+OKhLZNFGfZaXqLgrmfJeeseYVRxBtuqkR00znXDnD3lnBIbBMbVJRevL/EdWEL5TO3 SxtQGLScXMXIf8RjXUndof9rgBJS5jY4sqWHwr+27WLyVaSR7xoz8mx+FICRsLTuDHgGOjLtPBs 4boYqelSn4xWoQHQVMCL1qpBegx2u4YejCu/HTUWkW33Lv+RASGxMY2IiTnsIwl1sS9rptkDQb3 VaRrifnrTkHWdAw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Convert the lsm_blob_size fields to unsigned integers as there is no
current need for them to be negative, change "lsm_set_blob_size()" to
"lsm_blob_size_update()" to better reflect reality, and perform some
other minor cleanups to the associated code.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 34 +++++++++++------------
 security/lsm_init.c       | 57 ++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 65a8227bece7..86e457aa8809 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -102,23 +102,23 @@ struct security_hook_list {
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
-	int lbs_cred;
-	int lbs_file;
-	int lbs_ib;
-	int lbs_inode;
-	int lbs_sock;
-	int lbs_superblock;
-	int lbs_ipc;
-	int lbs_key;
-	int lbs_msg_msg;
-	int lbs_perf_event;
-	int lbs_task;
-	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
-	int lbs_tun_dev;
-	int lbs_bdev;
-	int lbs_bpf_map;
-	int lbs_bpf_prog;
-	int lbs_bpf_token;
+	unsigned int lbs_cred;
+	unsigned int lbs_file;
+	unsigned int lbs_ib;
+	unsigned int lbs_inode;
+	unsigned int lbs_sock;
+	unsigned int lbs_superblock;
+	unsigned int lbs_ipc;
+	unsigned int lbs_key;
+	unsigned int lbs_msg_msg;
+	unsigned int lbs_perf_event;
+	unsigned int lbs_task;
+	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
+	unsigned int lbs_tun_dev;
+	unsigned int lbs_bdev;
+	unsigned int lbs_bpf_map;
+	unsigned int lbs_bpf_prog;
+	unsigned int lbs_bpf_token;
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7b2491120fc8..5249aa044d9d 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,16 +169,22 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-static void __init lsm_set_blob_size(int *need, int *lbs)
+/**
+ * lsm_blob_size_update - Update the LSM blob size and offset information
+ * @sz_req: the requested additional blob size
+ * @sz_cur: the existing blob size
+ */
+static void __init lsm_blob_size_update(unsigned int *sz_req,
+					unsigned int *sz_cur)
 {
-	int offset;
+	unsigned int offset;
 
-	if (*need <= 0)
+	if (*sz_req == 0)
 		return;
 
-	offset = ALIGN(*lbs, sizeof(void *));
-	*lbs = offset + *need;
-	*need = offset;
+	offset = ALIGN(*sz_cur, sizeof(void *));
+	*sz_cur = offset + *sz_req;
+	*sz_req = offset;
 }
 
 /**
@@ -193,27 +199,30 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 		return;
 
 	/* Register the LSM blob sizes. */
-	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	blobs = lsm->blobs;
+	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
 	/* inode blob gets an rcu_head in addition to LSM blobs. */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&blobs->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
-	lsm_set_blob_size(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
-	lsm_set_blob_size(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
-	lsm_set_blob_size(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
+	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_perf_event,
+			     &blob_sizes.lbs_perf_event);
+	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_blob_size_update(&blobs->lbs_superblock,
+			     &blob_sizes.lbs_superblock);
+	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_blob_size_update(&blobs->lbs_xattr_count,
+			     &blob_sizes.lbs_xattr_count);
+	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
+	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
+	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
 /* Initialize a given LSM, if it is enabled. */
-- 
2.50.1

