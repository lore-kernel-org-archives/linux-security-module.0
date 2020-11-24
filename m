Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF68C2D0E4
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Nov 2020 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BA3206D4
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Nov 2020 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibCi5X8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbgKXPMQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbgKXPMQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Nov 2020 10:12:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC892C0617A6
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 07:12:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so22633042wrw.10
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EcEA95lNa5ZZ+4yTLKOmHZRpqe2owrp9tTkgwACEiM=;
        b=ibCi5X8Jr3TncJq/YRtxicrO73AYf22K1o+IetPSD2hZZqoLFnXj4rZ9EU7AI5GcfD
         p1hLH3tYLKfG4l2BLazi3w4HwIoqZeSG5jYi/WeR1uV8A4j6SVqDNyS5S4L/yExAP05U
         Z0KANTbHysLXx2RsH0ZNKTICnEWqjOVyfxb6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EcEA95lNa5ZZ+4yTLKOmHZRpqe2owrp9tTkgwACEiM=;
        b=RwLKChWUgR/f5Pt3uFuOnMBbiNWhIRh8rSpn7avJ57XKSVMdPPU3HlnonM/f+B1BHm
         yBWJe0Pv+A7grLqC2bJiWZMnePGRNvmHoLN3B2jMZXBMjnrBbTGhRc0WRqt7zamm2b4Q
         Ac3sJ5r3P/ioVpELqkp6oMLaC6L3vU/5c8hT0D91RjiN4u3u3ts/qMe4LnoGRUTrWY+U
         w7Nea1YpPMcLDqha6PGxUfJLkzt+Tz62tVGn8YoaDIlKuQgySrRY2kCdJgIxkEIbvkWo
         WSxxYRJ2s9Aehq6rIc3AMvHweW0N36ilEVDvkiSpWvXg2z4vNONKH1pzCR1Pw5s37uLJ
         7VtQ==
X-Gm-Message-State: AOAM531KFDuhqKaaqViUg9Ox7ZU+y0nKVr5rTOCfOXePFrvSsn7M3BVB
        XwLL5+vqZDdyS5e4N++Jdc8SgA==
X-Google-Smtp-Source: ABdhPJy02kMVLnJkpuZyn2yL397Z2qctTyaciVDRACl/mjeQe14qrgcSahQ5IJCwkiUL2A4SszOUIw==
X-Received: by 2002:a5d:690a:: with SMTP id t10mr5955851wru.203.1606230733342;
        Tue, 24 Nov 2020 07:12:13 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id g131sm6353127wma.35.2020.11.24.07.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:12:12 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v3 1/3] ima: Implement ima_inode_hash
Date:   Tue, 24 Nov 2020 15:12:08 +0000
Message-Id: <20201124151210.1081188-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201124151210.1081188-1-kpsingh@chromium.org>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

This is in preparation to add a helper for BPF LSM programs to use
IMA hashes when attached to LSM hooks. There are LSM hooks like
inode_unlink which do not have a struct file * argument and cannot
use the existing ima_file_hash API.

An inode based API is, therefore, useful in LSM based detections like an
executable trying to delete itself which rely on the inode_unlink LSM
hook.

Moreover, the ima_file_hash function does nothing with the struct file
pointer apart from calling file_inode on it and converting it to an
inode.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/ima.h               |  6 +++
 security/integrity/ima/ima_main.c | 78 +++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8fa7bcfb2da2..7233a2751754 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -29,6 +29,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
+extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
@@ -115,6 +116,11 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2d1af8899cab..cb2deaa188e7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -501,37 +501,14 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
-/**
- * ima_file_hash - return the stored measurement if a file has been hashed and
- * is in the iint cache.
- * @file: pointer to the file
- * @buf: buffer in which to store the hash
- * @buf_size: length of the buffer
- *
- * On success, return the hash algorithm (as defined in the enum hash_algo).
- * If buf is not NULL, this function also outputs the hash into buf.
- * If the hash is larger than buf_size, then only buf_size bytes will be copied.
- * It generally just makes sense to pass a buffer capable of holding the largest
- * possible hash: IMA_MAX_DIGEST_SIZE.
- * The file hash returned is based on the entire file, including the appended
- * signature.
- *
- * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
- * If the parameters are incorrect, return -EINVAL.
- */
-int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
-	struct inode *inode;
 	struct integrity_iint_cache *iint;
 	int hash_algo;
 
-	if (!file)
-		return -EINVAL;
-
 	if (!ima_policy_flag)
 		return -EOPNOTSUPP;
 
-	inode = file_inode(file);
 	iint = integrity_iint_find(inode);
 	if (!iint)
 		return -EOPNOTSUPP;
@@ -558,8 +535,61 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 
 	return hash_algo;
 }
+
+/**
+ * ima_file_hash - return the stored measurement if a file has been hashed and
+ * is in the iint cache.
+ * @file: pointer to the file
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, return the hash algorithm (as defined in the enum hash_algo).
+ * If buf is not NULL, this function also outputs the hash into buf.
+ * If the hash is larger than buf_size, then only buf_size bytes will be copied.
+ * It generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE.
+ * The file hash returned is based on the entire file, including the appended
+ * signature.
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	if (!file)
+		return -EINVAL;
+
+	return __ima_inode_hash(file_inode(file), buf, buf_size);
+}
 EXPORT_SYMBOL_GPL(ima_file_hash);
 
+/**
+ * ima_inode_hash - return the stored measurement if the inode has been hashed
+ * and is in the iint cache.
+ * @inode: pointer to the inode
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, return the hash algorithm (as defined in the enum hash_algo).
+ * If buf is not NULL, this function also outputs the hash into buf.
+ * If the hash is larger than buf_size, then only buf_size bytes will be copied.
+ * It generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE.
+ * The hash returned is based on the entire contents, including the appended
+ * signature.
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
+{
+	if (!inode)
+		return -EINVAL;
+
+	return __ima_inode_hash(inode, buf, buf_size);
+}
+EXPORT_SYMBOL_GPL(ima_inode_hash);
+
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @file : newly created tmpfile
-- 
2.29.2.454.gaff20da3a2-goog

