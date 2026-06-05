Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E52358D37;
	Fri,  5 Jun 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680210; cv=none; b=d0nzRbhrRnVIALBOZc5GJA518CSdx8pXuckLfNJsn9ILYEbXBckuq157I75i90Rka30yDElwEdOYaKoiPKQbUA1M0yTGzmZEfIPWhewdAtuKJrVivr7eXvmqf3cuconod9GHyOFHRSuDp8lPQ1MoH8DDudedeQGZ6S9yzf0knVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680210; c=relaxed/simple;
	bh=4/6LxwemWIJEVDRbaimDYysPEMgUmc1fzvqAja04k0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNq3oh+2ubq04I9oWid/5RNNccExenjrVtIM0V1majRzttzYJZP/L36IdJoE408o8b3OuyuaRpdwQCmr1hoRg9EV95B6Q4jtTB2AJigg1zHgM1Dt3jUlyEYqvPtx+lQMy8/M370lXe86SZ4NVClZxiZJbHuTJBXrRJMqLEqyAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gX7Ry2X5hz1HCm5;
	Sat,  6 Jun 2026 01:18:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 384B24056C;
	Sat,  6 Jun 2026 01:23:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHV43pBSNqZAhlAA--.46721S5;
	Fri, 05 Jun 2026 18:23:24 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 03/12] ima: Introduce per binary measurements list type ima_num_records counter
Date: Fri,  5 Jun 2026 19:22:27 +0200
Message-ID: <20260605172236.2042045-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBHV43pBSNqZAhlAA--.46721S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxGFyDAFyDKw1ktFyfCrg_yoWrWw1fpa
	9Ig3WUGr40qFy2kF95Cay3AayFg3yYkrWUW398JwnakFsrXr1UXF1YyF129F1fGF95tr1S
	qrn0qr45Ca1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGoiOzcKjwACsK

From: Roberto Sassu <roberto.sassu@huawei.com>

Make ima_num_records as an array, to have separate counters per binary
measurements list type. Currently, define the BINARY type for the existing
binary measurements list.

No functional change: the BINARY type is equivalent to the value without
the array.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h       | 9 ++++++++-
 security/integrity/ima/ima_fs.c    | 2 +-
 security/integrity/ima/ima_kexec.c | 2 +-
 security/integrity/ima/ima_queue.c | 6 ++++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0e41c2113efd..8f457f2c7b79 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -28,6 +28,13 @@ enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
+/*
+ * BINARY: current binary measurements list
+ */
+enum binary_lists {
+	BINARY, BINARY__LAST
+};
+
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
 #define IMA_EVENT_NAME_LEN_MAX	255
@@ -326,7 +333,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 extern spinlock_t ima_queue_lock;
 
 /* Total number of measurement list records since hard boot. */
-extern atomic_long_t ima_num_records;
+extern atomic_long_t ima_num_records[BINARY__LAST];
 /* Total number of violations since hard boot. */
 extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 523d3e81f631..fcfcf7b6eae2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -63,7 +63,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_counter(buf, count, ppos, &ima_num_records);
+	return ima_show_counter(buf, count, ppos, &ima_num_records[BINARY]);
 }
 
 static const struct file_operations ima_measurements_count_ops = {
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 77ad370dbc37..1a0211a12ea4 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -43,7 +43,7 @@ void ima_measure_kexec_event(const char *event_name)
 	int n;
 
 	buf_size = ima_get_binary_runtime_size();
-	len = atomic_long_read(&ima_num_records);
+	len = atomic_long_read(&ima_num_records[BINARY]);
 
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a31b75d9302b..012e725ed4fc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -32,7 +32,9 @@ static unsigned long binary_runtime_size;
 static unsigned long binary_runtime_size = ULONG_MAX;
 #endif
 
-atomic_long_t ima_num_records = ATOMIC_LONG_INIT(0);
+atomic_long_t ima_num_records[BINARY__LAST] = {
+	[0 ... BINARY__LAST - 1] = ATOMIC_LONG_INIT(0)
+};
 atomic_long_t ima_num_violations = ATOMIC_LONG_INIT(0);
 
 /* key: inode (before secure-hashing a file) */
@@ -152,7 +154,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	htable = rcu_dereference_protected(ima_htable,
 				lockdep_is_held(&ima_extend_list_mutex));
 
-	atomic_long_inc(&ima_num_records);
+	atomic_long_inc(&ima_num_records[BINARY]);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &htable[key]);
-- 
2.43.0

