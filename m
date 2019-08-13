Return-Path: <SRS0=o9Ra=WJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE47C32750
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB61B205F4
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slazxnn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHMTVj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:21:39 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42551 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMTVj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 15:21:39 -0400
Received: by mail-ua1-f73.google.com with SMTP id h45so161133uae.9
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bm7tpjWVOUDYZx97BncdSkZ9NvRhZO8YSsPPBr5vkok=;
        b=slazxnn157c/8d5NLixGKQHNLN7VTx1GaxxgepSJpk+EhBUjfJoNCOjXNoBlzwtTgz
         ATQMg1/p6wmxCiwn3NqDaSdbn0sOCgj18C/YAUSAxFH1lVQCg5+UIR6idPpfaL02EAZH
         IIEIw4YVgw2HCssS06onnz1SgWi3wxL7U0JMJr/iDDouwY06MoWIPdhHHDmKOO16YIkx
         j5G4kkndQqP76ENddQHpPGQGcFOITR7tjSD3KkUsaWPXuqX9KcbxTR2w0/9BFBqYyGaY
         8WoBEUCB9UM2pRs0iCKC8r+peYhTnubEAyqgJUXHJQvwP1KZzcqzE6ODHz9/GnNc2FLx
         LSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bm7tpjWVOUDYZx97BncdSkZ9NvRhZO8YSsPPBr5vkok=;
        b=pcCw6Km8RbPvRa5BMoEsSTdsKnBi4vNO30MWb/mO2CYaS3TSAn1wMzAvYniWbBeVah
         AKCHTfiQrH5R6cE65g/XUCNl+9XuMNRDI/Q2UZvSMzkpMtnNCIMFyoxSwCnyHYnkr8mV
         HZl8JNqnLQtQ4qhNw3OPEeKIrN3WLiHhjSPeUv5SUtd5gEw4Y5ZdvQ9N75r5hGBFP3tE
         TV1eXG/Y4M/y9Bs6DYwNauyn/cV5FGK+svHVefwAKDXJ6rKlrcDYUyBaAfbYsX9BnpXC
         P2vtH5pl2JJ68qxfff0zyx7hSGZq7M9p/PRMj9FMmpqchiYHQFzH18IJSWZgliUj4/Ri
         qzTA==
X-Gm-Message-State: APjAAAWJg/nyeOHJn8q5HR78UIrZSjXgEZ8yeZK4O45e1UnJBv3NKzDB
        nn4VLQWYD/k8hyFI/0muu2mPpsaktmIcI5efTtES4w==
X-Google-Smtp-Source: APXvYqzRVkooHVUD52Jj7apoZc5mIoEhdYnVm95g08oervUdSjOgObCJlOhYCdmCQD7I3YQEPRfXBlAg4kq7Nznq8SGZ4Q==
X-Received: by 2002:a1f:ec41:: with SMTP id k62mr7315266vkh.32.1565724098096;
 Tue, 13 Aug 2019 12:21:38 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:21:23 -0700
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-Id: <20190813192126.122370-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 3/6] Avoid build warning when !CONFIG_KEXEC_SIG
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jiri Bohac <jbohac@suse.cz>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Refactor the signature validation and lockdown integration a little in
order to avoid an unused variable.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 72 ++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index be0c13076056..e878587715b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -177,36 +177,13 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
-/*
- * In file mode list of segments is prepared by kernel. Copy relevant
- * data from user space, do error checking, prepare segment list
- */
+#ifdef CONFIG_KEXEC_SIG
 static int
-kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
-			     const char __user *cmdline_ptr,
-			     unsigned long cmdline_len, unsigned flags)
+kimage_validate_signature(struct kimage *image)
 {
 	const char *reason;
 	int ret;
-	void *ldata;
-	loff_t size;
-
-	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
-				       &size, INT_MAX, READING_KEXEC_IMAGE);
-	if (ret)
-		return ret;
-	image->kernel_buf_len = size;
-
-	/* IMA needs to pass the measurement list to the next kernel. */
-	ima_add_kexec_buffer(image);
 
-	/* Call arch image probe handlers */
-	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
-					    image->kernel_buf_len);
-	if (ret)
-		goto out;
-
-#ifdef CONFIG_KEXEC_SIG
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
 	switch (ret) {
@@ -228,7 +205,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	decide:
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
 			pr_notice("%s rejected\n", reason);
-			goto out;
+			break;
 		}
 
 		ret = 0;
@@ -251,9 +228,44 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		 */
 	default:
 		pr_notice("kernel signature verification failed (%d).\n", ret);
-		goto out;
+		break;
 	}
+
+	return ret;
+}
+#endif
+
+/*
+ * In file mode list of segments is prepared by kernel. Copy relevant
+ * data from user space, do error checking, prepare segment list
+ */
+static int
+kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
+			     const char __user *cmdline_ptr,
+			     unsigned long cmdline_len, unsigned flags)
+{
+	int ret;
+	void *ldata;
+	loff_t size;
+
+	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+				       &size, INT_MAX, READING_KEXEC_IMAGE);
+	if (ret)
+		return ret;
+	image->kernel_buf_len = size;
+
+	/* Call arch image probe handlers */
+	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
+					    image->kernel_buf_len);
+	if (ret)
+		goto out;
+
+#ifdef CONFIG_KEXEC_SIG
+	ret = kimage_validate_signature(image);
+	if (ret)
+		goto out;
 #endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
@@ -279,8 +291,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_kexec_cmdline(image->cmdline_buf,
+				  image->cmdline_buf_len - 1);
 	}
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

