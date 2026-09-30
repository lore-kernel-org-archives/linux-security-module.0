Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD3340A6A;
	Wed, 30 Sep 2026 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775877; cv=none; b=DYoxweP7xxc2t5ZGo2TPIEpvGGuLkRdXhU311JnxgTUjfRPBrq4EQbl+BQNMDXz5gM+ZSANE0YvDNpX8qcYkjdVq9mFZMtGjPFqh28xa7drTr+ntFUkdUl1PytcFNXsmK3yZIk/NhfsNSFfC+wfNUjAFl+kCzm9ktunMRPCVywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775877; c=relaxed/simple;
	bh=WEicB4D5YyI+tjiM5xOW0IJVdZ3kiHRmlpVO33u6hfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBL2s+kLUU8AC9K0GMQOaJLjcSssU32dcvitIqruN13X2FE2NWi84cM7FgObV/CDfiVy9adugjF36vMoogvfhT4eguiuquD0gyh9KpA5tx/b3gJCoJszBCDTvtVGq2bMfq90LzFgT9U9Cq/I5O4HjDmDVAnNqtLv6tuHepnreJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N+vVfa/V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N+vVfa/V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D697A497;
	Wed, 30 Sep 2026 06:44:17 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 639003FA32;
	Wed, 30 Sep 2026 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790775861; bh=WEicB4D5YyI+tjiM5xOW0IJVdZ3kiHRmlpVO33u6hfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+vVfa/VETfQ6CnxK+iHwHXrzvhr0IAV5zgjH0UwLU71DDZTZxzoNuK9rgcmEyHyG
	 WQa0GocZgeej5A7zea1j8ywTk+SCKjvQB8oIpVZxL4gO4wVgslzUIXcs+cKijXaZxy
	 /u+hyW3G5idFYq+KV99R4/0Mj0S8cnBLA8YxK9uo=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 30 Sep 2026 14:43:59 +0100
Subject: [PATCH RFC 1/3] virt: coco: introduce tsm_default_tm() and
 tsm_mr_read()/write()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ima_tgx_integration_v2-v1-1-722c35370548@arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
In-Reply-To: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
To: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org
Cc: Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8185; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=WEicB4D5YyI+tjiM5xOW0IJVdZ3kiHRmlpVO33u6hfo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqvRIt8Mxt71dVCSHmWjAp5jGB+I/t7XkPkEXo1
 0LV2s/+P1uJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCar0SLQAKCRBt1cPRWsUx
 M/LmDADbYL0xj3Ethqs859DOZxMpDYCDOYBIgvT+C+dUVpOZvmcKXj52TtV4WVmd1QZSGlLdwqW
 sROyctxupihKK+PDBq8XiJ+JGufjNY1ilwQZLv8BzfXLSAcBCUiAIIL6gcWlD0E81OE3bh848DP
 CMkct3RGs5bHtv60CG+D9Boq7dnBeeYLh0FggraSQE9tDdbuoK4cWCoQF/7Gs9N/OBmFhz5zpRp
 NtywCw347RN4k0SJ3/aAyUJ0UwfcUYEKjFKZlaOirc54sW6HPK/EEFEidlVxK1noJsegxgS49S/
 scnDo32mv+JjZyaRR58qftjtL4gukrw9uTC3ErBPWY064rq9uNYKC3DfHQV0dh8b3IjAfxYfvoc
 dxSFILAStIQpgsCImuFHu3i+D+yd+7TkZ/T2/ctRJqAVQEKx+8kAdsq1HwPDyNQ6t0j8luP21ks
 vla0QJK1UMulpl+kb0mza5c+ymwWPt7dqSTg4akGQ7kvJKLnTtZrKj6uA8kLiUKGwird4=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

This is preparatory patch to use tsm measurement registers in IMA.
Introduce tsm_default_tm() and tsm_mr_read()/write() APIs
to read and extend the tsm measurement registers in IMA.

Since IMA is supported only when it's built as built-in,
export those symbols only tsm-mr is built as built-in.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/virt/coco/guest/tsm-mr.c | 159 +++++++++++++++++++++++++++++++++------
 include/linux/tsm-mr.h           |  26 +++++++
 2 files changed, 161 insertions(+), 24 deletions(-)

diff --git a/drivers/virt/coco/guest/tsm-mr.c b/drivers/virt/coco/guest/tsm-mr.c
index 657b9c5739d0..9e721348be8d 100644
--- a/drivers/virt/coco/guest/tsm-mr.c
+++ b/drivers/virt/coco/guest/tsm-mr.c
@@ -7,9 +7,15 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/tsm_mr.h>
 
+#define TM_NUM_CTX	(64 * HASH_ALGO__LAST)
+
+DEFINE_IDR(tm_ctx_idr);
+static DEFINE_MUTEX(idr_lock);
+
 /*
  * struct tm_context - contains everything necessary to implement sysfs
  * attributes for MRs.
@@ -42,21 +48,16 @@ struct tm_context {
 	struct bin_attribute mrs[];
 };
 
-static ssize_t tm_digest_read(struct file *filp, struct kobject *kobj,
-			      const struct bin_attribute *attr, char *buffer,
-			      loff_t off, size_t count)
+static ssize_t __tsm_mr_read(struct tm_context *ctx,
+			 const struct tsm_measurement_register *mr,
+			 char *buffer, loff_t off, size_t count)
 {
-	struct tm_context *ctx;
-	const struct tsm_measurement_register *mr;
 	int rc;
 
-	ctx = attr->private;
 	rc = down_read_interruptible(&ctx->rwsem);
 	if (rc)
 		return rc;
 
-	mr = &ctx->tm->mrs[attr - ctx->mrs];
-
 	/*
 	 * @ctx->in_sync indicates if the MR cache is stale. It is a global
 	 * instead of a per-MR flag for simplicity, as most (if not all) archs
@@ -88,20 +89,11 @@ static ssize_t tm_digest_read(struct file *filp, struct kobject *kobj,
 	return rc ?: count;
 }
 
-static ssize_t tm_digest_write(struct file *filp, struct kobject *kobj,
-			       const struct bin_attribute *attr, char *buffer,
-			       loff_t off, size_t count)
+static ssize_t __tsm_mr_write(struct tm_context *ctx,
+			 const struct tsm_measurement_register *mr,
+			 char *buffer, size_t count)
 {
-	struct tm_context *ctx;
-	const struct tsm_measurement_register *mr;
-	ssize_t rc;
-
-	/* partial writes are not supported */
-	if (off != 0 || count != attr->size)
-		return -EINVAL;
-
-	ctx = attr->private;
-	mr = &ctx->tm->mrs[attr - ctx->mrs];
+	int rc;
 
 	rc = down_write_killable(&ctx->rwsem);
 	if (rc)
@@ -119,6 +111,36 @@ static ssize_t tm_digest_write(struct file *filp, struct kobject *kobj,
 	return rc ?: count;
 }
 
+static ssize_t tm_digest_read(struct file *filp, struct kobject *kobj,
+			      const struct bin_attribute *attr, char *buffer,
+			      loff_t off, size_t count)
+{
+	struct tm_context *ctx;
+	const struct tsm_measurement_register *mr;
+
+	ctx = attr->private;
+	mr = &ctx->tm->mrs[attr - ctx->mrs];
+
+	return __tsm_mr_read(ctx, mr, buffer, off, count);
+}
+
+static ssize_t tm_digest_write(struct file *filp, struct kobject *kobj,
+			       const struct bin_attribute *attr, char *buffer,
+			       loff_t off, size_t count)
+{
+	struct tm_context *ctx;
+	const struct tsm_measurement_register *mr;
+
+	/* partial writes are not supported */
+	if (off != 0 || count != attr->size)
+		return -EINVAL;
+
+	ctx = attr->private;
+	mr = &ctx->tm->mrs[attr - ctx->mrs];
+
+	return __tsm_mr_write(ctx, mr, buffer, count);
+}
+
 /**
  * tsm_mr_create_attribute_group() - creates an attribute group for measurement
  * registers (MRs)
@@ -138,8 +160,7 @@ static ssize_t tm_digest_write(struct file *filp, struct kobject *kobj,
  * * %-ENOMEM - Out of memory.
  */
 const struct attribute_group *
-tsm_mr_create_attribute_group(const struct tsm_measurements *tm)
-{
+tsm_mr_create_attribute_group(const struct tsm_measurements *tm) {
 	size_t nlen;
 
 	if (!tm || !tm->mrs)
@@ -230,6 +251,15 @@ tsm_mr_create_attribute_group(const struct tsm_measurements *tm)
 	ctx->agrp.name = "measurements";
 	ctx->agrp.bin_attrs = no_free_ptr(attrs);
 	ctx->tm = tm;
+
+	guard(mutex)(&idr_lock);
+	((struct tsm_measurements *)tm)->ctx_id = idr_alloc(&tm_ctx_idr, ctx, 0,
+							    TM_NUM_CTX, GFP_KERNEL);
+	if (tm->ctx_id < 0) {
+		kfree(ctx->agrp.bin_attrs);
+		return ERR_PTR(tm->ctx_id);
+	}
+
 	return &no_free_ptr(ctx)->agrp;
 }
 EXPORT_SYMBOL_GPL(tsm_mr_create_attribute_group);
@@ -243,9 +273,90 @@ EXPORT_SYMBOL_GPL(tsm_mr_create_attribute_group);
  */
 void tsm_mr_free_attribute_group(const struct attribute_group *attr_grp)
 {
+	struct tm_context *ctx;
+
 	if (!IS_ERR_OR_NULL(attr_grp)) {
+		ctx = container_of(attr_grp, struct tm_context, agrp);
+		scoped_guard(mutex, &idr_lock)
+			idr_remove(&tm_ctx_idr, ctx->tm->ctx_id);
 		kfree(attr_grp->bin_attrs);
-		kfree(container_of(attr_grp, struct tm_context, agrp));
+		kfree(ctx);
 	}
 }
 EXPORT_SYMBOL_GPL(tsm_mr_free_attribute_group);
+
+#if defined(CONFIG_TSM_MEASUREMENTS)
+const struct tsm_measurements *tsm_default_tm(void)
+{
+	struct tm_context *ctx;
+	int next_id = 0;
+
+	guard(mutex)(&idr_lock);
+
+	ctx = idr_get_next(&tm_ctx_idr, &next_id);
+	if (!ctx)
+		return NULL;
+
+	return ctx->tm;
+}
+EXPORT_SYMBOL_GPL(tsm_default_tm);
+
+int tsm_mr_read(const struct tsm_measurements *tm, int idx,
+		u8 *digest, u32 digest_size)
+{
+	struct tm_context *ctx;
+	const struct tsm_measurement_register *mr;
+	int rc;
+
+	scoped_guard(mutex, &idr_lock)
+		ctx = idr_find(&tm_ctx_idr, tm->ctx_id);
+
+	if (IS_ERR_OR_NULL(ctx))
+		return -ENODEV;
+
+	if (!digest || (idx >= ctx->tm->nr_mrs) ||
+	    (ctx->tm->mrs[idx].mr_size > digest_size) ||
+	    !(ctx->tm->mrs[idx].mr_flags & TSM_MR_F_READABLE))
+		return -EINVAL;
+
+	mr = &ctx->tm->mrs[idx];
+
+	rc = __tsm_mr_read(ctx, mr, (char *)digest, 0, mr->mr_size);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_mr_read);
+
+int tsm_mr_write(const struct tsm_measurements *tm, int idx,
+		 u8 *digest, u32 digest_size)
+{
+	struct tm_context *ctx;
+	const struct tsm_measurement_register *mr;
+	int rc;
+
+	scoped_guard(mutex, &idr_lock)
+		ctx = idr_find(&tm_ctx_idr, tm->ctx_id);
+
+	if (IS_ERR_OR_NULL(ctx))
+		return -ENODEV;
+
+	if (!digest || (idx >= ctx->tm->nr_mrs) ||
+	    !(ctx->tm->mrs[idx].mr_flags & TSM_MR_F_WRITABLE))
+		return -EINVAL;
+
+	/* partial writes are not supported */
+	if (ctx->tm->mrs[idx].mr_size != digest_size)
+		return -EINVAL;
+
+	mr = &ctx->tm->mrs[idx];
+
+	rc = __tsm_mr_write(ctx, mr, (char *)digest, mr->mr_size);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_mr_write);
+#endif
diff --git a/include/linux/tsm-mr.h b/include/linux/tsm-mr.h
index 50a521f4ac97..43a0f761cd96 100644
--- a/include/linux/tsm-mr.h
+++ b/include/linux/tsm-mr.h
@@ -80,10 +80,36 @@ struct tsm_measurements {
 	int (*refresh)(const struct tsm_measurements *tm);
 	int (*write)(const struct tsm_measurements *tm,
 		     const struct tsm_measurement_register *mr, const u8 *data);
+	int ctx_id;
 };
 
 const struct attribute_group *
 tsm_mr_create_attribute_group(const struct tsm_measurements *tm);
 void tsm_mr_free_attribute_group(const struct attribute_group *attr_grp);
 
+#if defined(CONFIG_TSM_MEASUREMENTS)
+const struct tsm_measurements *tsm_default_tm(void);
+int tsm_mr_read(const struct tsm_measurements *tm, int idx,
+		u8 *digest, u32 digest_size);
+int tsm_mr_write(const struct tsm_measurements *tm, int idx,
+		 u8 *digest, u32 digest_size);
+#else
+static inline const struct tsm_measurements *tsm_default_tm(void)
+{
+	return NULL;
+}
+
+static inline int tsm_mr_read(const struct tsm_measurements *tm, int idx,
+			      u8 *digest, u32 digest_size)
+{
+	return 0;
+}
+
+static inline int tsm_mr_write(const struct tsm_measurements *tm, int idx,
+			       u8 *digest, u32 digest_size)
+{
+	return 0;
+}
+#endif
+
 #endif

-- 
2.43.0

