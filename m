Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57950366042
	for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696987; cv=none; b=mLauGINV20EFFmXEMuBAN9fwySobQ4Z3zoHpGHh6IfNHL4EJAasuyZdcDfQ1OpOZwLRpmN9HDqvvnxe+gL/EegC7cYEvUu/J/FWhdrX9Dh3dbYk7Ya1Mga5sPuYEEHbq/sxfuH0PKTd9eIfQmSoaP8sFhI1vCDaMGWy2YjoJ0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696987; c=relaxed/simple;
	bh=dX3vSVluZ2sVFC8E0ytSSXIe/yQh8rLeBSsPIlH/scU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfy0ZzvyTVfCmAuCWl9ruSIPRSsOBBP+O6N1F1x3QW5xLcQ5oo3v1Zso05EYnflad24Fcxp8hwP0mS7Ncsadp2hsva3E+Tf7QEugnFekQqsVnDYQLxT/TLE4jxmmAFyRFE4+4NFxJ49+ovJyV9VaRMce/M3pdWNf/sjx8DYkzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YoFjP/vR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YoFjP/vR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5c9ba82bso682984385a.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696984; x=1774301784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K65XnocK8kG+6tfBdzIF+tZj3LHNhmW0Q9HX3G1TK3M=;
        b=YoFjP/vRg4GbwmZpAMpyVyGhtaI1y0P+VUP7nue/0rB/DSOZuJbdDSwC3tfXX19yzC
         JeftJmSGDlEKE0nI/X52UH43pXKhyJgrN/Xqr5OnQho8juWBvn3+xpMoaq+ck9Bu7fUu
         FNorIcDvW4y7sThn0l5HCBEk3PXHowaztFykL3vsXthKbzNAONyxNJe0GcMyt9eBXZvq
         Qn8a+ktKb03FiNSr5lWK0tPzTLxKGyHllp5s3NQN1VA0wiwWh8Eaj+Hx2CnM1a7y1xwd
         Bz795ZkXsdq5p7ronPzlEo4aNquC14xT0eSoR427+BzK4VhELJMEYvfGtMtD+BlG36YM
         AbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696984; x=1774301784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K65XnocK8kG+6tfBdzIF+tZj3LHNhmW0Q9HX3G1TK3M=;
        b=TTZK9SQv0k8WbFBjsRjsTCSSACxBog3uAz604FPhZrIKgBxfS+PpfM2BkoiXXcl+IG
         MKQLRwxeXY3JgtAQHajIYn3B2OSQGLiWMYlb/6hcuwqtlp/Hya2qBi/S92vu7dtTx0aL
         nK7Kf4Uk+sjqiVR5wPUpN6qN+o6EXzcgCnDQ9etCMzBV6tztKUQAUf7Dh1qvAkjlLQ2W
         HKK1j6OAro0K2VR0j5K8D0Gw0jY741+XJd148jhtd67DXmXDH872toy5NZDPKgVGfyU1
         BqNZiql5NdEw6LZYNNoNC3XE8/wjZIgyDxJT9o0LdgoUNsqYBKhus9Jj5cVcDhSOJoXN
         2WFw==
X-Gm-Message-State: AOJu0YyTkWA9aH0kerQefv2E6coWFN3+N21hDA3u3detYIyMsjT2h1ah
	+iafMARCOkxx2aQDnh238A7sLjH9Lyy0YJzdvWXrWBOopCw+RuERjBnCUYNEDsTxPkLdprIBbhh
	3u3g=
X-Gm-Gg: ATEYQzyhrskQUWkErANHGQuDW6/FaKLpMUxJ9wQf1l2ECABm80KXZ3n/8x1pFPlZjDQ
	19BDU7ZLPIY7nRYDAJFAWJMiKyiiDjs1VRuEmGRLqm9i5ug5D+iUkkOAwTahAxJ1RwpY6/NfnOB
	jpGOWpW+n8BpXZFYhU0gcs9WiLxF+Yh/zYmREOh2+Db8n1SThL4OwrOvdhhtPAKJGaTfLUNrCyP
	tXkzFvJFcSRHzTqDFEV3xHN0aS0jdHW7Y+Orkj1q6+wzAir81CCpZptJtSXDI2hCJSX57KOSKia
	hJ/qmgBs8grVScpPMcWBGdv5h+Uu4ygiygImpbmKAndS94PgnjBQkB6MAwvn6OIMxIYyska0ofS
	4E1kKF8XmNFvgpkOHtJNDq6OUHjZLeffb9QxAxG+FNrv8bFyDUi0d5ovr3nMWtW+mTHHWTM6Xsh
	tyha3wT5dSnqxmK0Bc95XWJnKjfAcdN88at6KZ9gNDo5SxArtoKhYRDyd2q1s6WbY/ORLLHXgyp
	Ka4rOY=
X-Received: by 2002:a05:620a:4713:b0:8cd:92c5:b3e5 with SMTP id af79cd13be357-8cdb5a76411mr1964899185a.20.1773696984421;
        Mon, 16 Mar 2026 14:36:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc09efsm1371730385a.2.2026.03.16.14.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 2/3] lsm: add the security_mmap_backing_file() hook
Date: Mon, 16 Mar 2026 17:35:57 -0400
Message-ID: <20260316213606.374109-7-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
References: <20260316213606.374109-5-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6049; i=paul@paul-moore.com; h=from:subject; bh=dX3vSVluZ2sVFC8E0ytSSXIe/yQh8rLeBSsPIlH/scU=; b=kA0DAAoB6iDy2pc3iXMByyZiAGm4d8rIUmXCtbyU0o7TJ7z5uf6AVXhPQq3cnyUX5r9tfC3LR YkCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJpuHfKAAoJEOog8tqXN4lzt/AQAJQ4 93OpEdrzoe5s8FEXqefSpadTyy9aCf1lD2hYDQom/uhTtgtFk0ejVnnNHEd3BH5Ahabe1zTSkiU xFVqhuFscJLhMnMyFn0LbSScm5RLHoeG1F6FeX5eP7sA1lAIvT/mGqcwmCgl9xjVo/jHmUJNejf uBJ+Evjm6HhsjwF6PTnUUq2PPe6rIw19nBXe4kdVYPJRvA5448OWAoilV/wKyZCkwDNUom1/hQL olnRSWOw3kJrAJOh4foNnttrL3ioEghpuR86GghSrDQN/NTXwGkJ+3saoBxs0O6XAGDIdN97gHQ Q3tsRKj976wEgQmgdHGlmB3wJ32QQeYwgf8czLMeUtmH0uGnnYoeqqpKJB6Ki5yaK73ShIHWe4M a5ipcP2h4n8EfLjMiWBYTrpnlB47cvROjFTw2jguEyx4pc//qH0Tx/UzTQQaXnSv7MCsKrQQJdc 0t1aYYB+P/n56XVxbBT3irEdG4YzrR5tay6NaZwFSRNobPS+ndq3uzQJuJDR1+OC3OcfJVbKhNb fFH+nEDz0XvTvIlt95afWFahx0/brtnNXNLPII8WqXW2NVLWuyS5v+TP9ovgUkRBHpd/TBIRgJa n26i59ei9ei7tEFlHVG7ADkfVx3UHbwn5hJ4YhRtZGvpPaE/TI8yluMVcr2t7oFr0GVX1tYRN74 SLbqr
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add the security_mmap_backing_file() hook to allow LSMs to properly
enforce access controls on mmap() operations on stacked filesystems
such as overlayfs.

The existing security_mmap_file() hook exists as an access control point
for mmap() but on stacked filesystems it only provides a way to enforce
access controls on the user visible file.  In order to enforce access
controls on the underlying backing file, the new
security_mmap_backing_file() hook is needed.

In addition the LSM hook additions, this patch also constifies the file
struct field in the LSM common_audit_data struct to better support LSMs
that will likely need to pass a const file struct pointer from the new
backing_file_user_path_file() API into the common LSM audit code.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/backing-file.c             |  8 +++++++-
 fs/erofs/ishare.c             |  6 ++++++
 include/linux/lsm_audit.h     |  2 +-
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index acabeea7efff..cfc7f6611313 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -13,6 +13,7 @@
 #include <linux/splice.h>
 #include <linux/uio.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -338,8 +339,13 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	scoped_with_creds(ctx->cred)
+	scoped_with_creds(ctx->cred) {
+		ret = security_mmap_backing_file(vma, file, user_file);
+		if (ret)
+			return ret;
+
 		ret = vfs_mmap(vma->vm_file, vma);
+	}
 
 	if (ctx->accessed)
 		ctx->accessed(user_file);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 17a4941d4518..d66c3a935d83 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -150,8 +150,14 @@ static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
 static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
+	int err;
 
 	vma_set_file(vma, realfile);
+
+	err = security_mmap_backing_file(vma, realfile, file);
+	if (err)
+		return err;
+
 	return generic_file_readonly_mmap(file, vma);
 }
 
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 382c56a97bba..584db296e43b 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -94,7 +94,7 @@ struct common_audit_data {
 #endif
 		char *kmod_name;
 		struct lsm_ioctlop_audit *op;
-		struct file *file;
+		const struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..4150c50a0482 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -198,6 +198,8 @@ LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
+LSM_HOOK(int, 0, mmap_backing_file, struct vm_area_struct *vma,
+	 struct file *backing_file, struct file *user_file)
 LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
 LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..4017361d8cba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -476,6 +476,9 @@ int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file);
 int security_mmap_addr(unsigned long addr);
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot);
@@ -1159,6 +1162,13 @@ static inline int security_mmap_file(struct file *file, unsigned long prot,
 	return 0;
 }
 
+static inline int security_mmap_backing_file(struct vm_area_struct *vma,
+					     struct file *backing_file,
+					     struct file *user_file)
+{
+	return 0;
+}
+
 static inline int security_mmap_addr(unsigned long addr)
 {
 	return cap_mmap_addr(addr);
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..8d10b184ce25 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2505,6 +2505,31 @@ int security_mmap_file(struct file *file, unsigned long prot,
 			     flags);
 }
 
+/**
+ * security_mmap_backing_file - Check if mmap'ing a backing file is allowed
+ * @vma: the vm_area_struct for the mmap'd region
+ * @backing_file: the backing file being mmap'd
+ * @user_file: the user file being mmap'd
+ *
+ * Check permissions for a mmap operation on a stacked filesystem.  This hook
+ * is called after the security_mmap_file() and is responsible for authorizing
+ * the mmap on @backing_file.  It is important to note that the mmap operation
+ * on @user_file has already been authorized and the @vma->vm_file has been
+ * set to @backing_file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file)
+{
+	/* recommended by the stackable filesystem devs */
+	if (WARN_ON_ONCE(!(backing_file->f_mode & FMODE_BACKING)))
+		return -EIO;
+
+	return call_int_hook(mmap_backing_file, vma, backing_file, user_file);
+}
+
 /**
  * security_mmap_addr() - Check if mmap'ing an address is allowed
  * @addr: address
-- 
2.53.0

