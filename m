Return-Path: <SRS0=WVaQ=3C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41405C33CAA
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jan 2020 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135C12075B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jan 2020 09:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfnB1nq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgAMJnV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:43:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35587 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMJnV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jan 2020 04:43:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so8830724wmb.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2020 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHx6WmDbUjJ36Jl+g3c5bGGBL+IPquArbpNqxaiK16s=;
        b=EfnB1nq4V68FEsTjQCUQnWpZE9rQyBa/cUPWKvQou1+R2njQCVYQzJbBt1ZPRu1rAe
         wY+lQNDa01pAkV0/0BAX3kRz187MIvZdfkqw3tk8tZzczQwXgbjSa0GpVYhJmh5zp6cG
         2XIrvqlhqgnReKjnEqvDRvXR7EsmpHi/NFzwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHx6WmDbUjJ36Jl+g3c5bGGBL+IPquArbpNqxaiK16s=;
        b=K6oUfm2z+yKxci25wMSUqdINsW/yF50nQrEKSVT/ud0HO5Qb7nyLOLnPGXY5PJdIy0
         7PB5YkE22IRKDeiyKXj1HhBqDJHULbRJUrN/opXYEAMe0yUTpEjmFeGog+tUQ3ZmZPta
         ldopcR/OtrsUQggac0ZSjMRCK8bsnp2Alq6oyUYegf0kHOHydI7UCQaGFIGsHTYaFpUO
         akBdtcB1qLD05yl0+aA3TvwYQhtjrHvc3waQ70CVEnvLzZ9Pwa0hrNwxghlb7bUVYPdh
         ifc9nq7TTYIHo025LJJOv8RgLi8rZKz3c+t6LBJczkT0ebEGb0Nxjwc0SXRyRxgRsKm1
         Kzyg==
X-Gm-Message-State: APjAAAU6LB+TechO0z+Qgjg24o/BotFR0govt/AL+ndDkUNNWS6nIc0c
        MTfw9laf4GBgPzRzU/QvHDEDkA==
X-Google-Smtp-Source: APXvYqyDB1HygQVzeq7b71coPvKzhzZ5OHSFXJXnQ+tWJRnTwXMu3t3bcqlFiLsONGC54SCkJyIWnQ==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr18991444wmq.65.1578908599336;
        Mon, 13 Jan 2020 01:43:19 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id m126sm13919276wmf.7.2020.01.13.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 01:43:18 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, zohar@linux.ibm.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: [PATCH v3] ima: add the ability to query the cached hash of a given file
Date:   Mon, 13 Jan 2020 10:42:44 +0100
Message-Id: <20200113094244.26678-1-revest@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Florent Revest <revest@google.com>

This allows other parts of the kernel (perhaps a stacked LSM allowing
system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
of a given file from IMA if it's present in the iint cache.

It's true that the existence of the hash means that it's also in the
audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
but it can be difficult to pull that information out for every
subsequent exec. This is especially true if a given host has been up
for a long time and the file was first measured a long time ago.

It should be kept in mind that this function gives access to cached
entries which can be removed, for instance on security_inode_free().

This is based on Peter Moody's patch:
 https://sourceforge.net/p/linux-ima/mailman/message/33036180/

[1] https://lkml.org/lkml/2019/9/10/393

Signed-off-by: Florent Revest <revest@google.com>
---
 include/linux/ima.h               |  6 ++++
 security/integrity/ima/ima_main.c | 49 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index f4644c54f648..1659217e9b60 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
+extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
@@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2272c3255c7d..9fe949c6a530 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -445,6 +445,55 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
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
+	struct inode *inode;
+	struct integrity_iint_cache *iint;
+	int hash_algo;
+
+	if (!file)
+		return -EINVAL;
+
+	if (!ima_policy_flag)
+		return -EOPNOTSUPP;
+
+	inode = file_inode(file);
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&iint->mutex);
+	if (buf) {
+		size_t copied_size;
+
+		copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
+		memcpy(buf, iint->ima_hash->digest, copied_size);
+	}
+	hash_algo = iint->ima_hash->algo;
+	mutex_unlock(&iint->mutex);
+
+	return hash_algo;
+}
+EXPORT_SYMBOL_GPL(ima_file_hash);
+
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @file : newly created tmpfile
-- 
2.25.0.rc1.283.g88dfdc4193-goog

