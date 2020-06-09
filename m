Return-Path: <SRS0=DAbT=7W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09ADC433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jun 2020 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E64206D5
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jun 2020 22:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ByJPGZ0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgFIW6f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgFIW5p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3DC08C5D1
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 15:57:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so214211pfx.8
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cM+rCpZobNDrkDN9s+cJ/Q1XgGFeWXzm3UzYtFYpyy4=;
        b=ByJPGZ0fwC+pHYx4+jr86EPnUJT03kDN80FFAKD7I5rX+wsF2f7csCPEgbu0Vv5JXD
         ZyLWQTOAA/02+ZV08uuMrd6LxZHpZq8t+zpNoZQcJEL4vViRm5Z4Qrylf4XzyxMH9i+e
         6RPwx+6tj/r3KDMiIgbqsv1cvcx5htVk6ttBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cM+rCpZobNDrkDN9s+cJ/Q1XgGFeWXzm3UzYtFYpyy4=;
        b=dyVTkujIJ37V2Kgl+pdOD6DRAXMhnWUkYWIN3M06177rADVUUNo1M9muM3NLnGvMXH
         10NMV5v8t91rlhKC0CuwehK2yvQGl0OYq81PKgvDVcUVrxstGriPm5xauXuHBHNQlChk
         dsONWwK9GY62quioDDwC0IFyxR3tHAAfttQrASrtRyq7I+p88gzytqsvKkvA6ITDlRZW
         zoVMCeVY80h1OWrPSUeT/ojtz5kY8f9Lod6jHLpqT1WUTYPb0xqGpsi97VF0KyBjffqc
         blAhXmKqxjhQ7bTHS5qhHMMnNhueXG+jDA1QKESuRfM7ueeLP/lOPWjims66I/8Z+zUh
         Bqkg==
X-Gm-Message-State: AOAM533DVoZYmftRDBq5CFK8gl6fWmKDPFrXOIiZZfqzbW4kLKDK+Hha
        T9uWEBNAVuOHS0qKh3ErbCu7Qw==
X-Google-Smtp-Source: ABdhPJzt2on8TT/VRipqTfFNR4O9ShRqcpSzbecmhCO8fd5EePg4uWMnzAa84LqTYB4Rh0Gh65kwjA==
X-Received: by 2002:a63:145f:: with SMTP id 31mr212923pgu.383.1591743455670;
        Tue, 09 Jun 2020 15:57:35 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v8 8/8] ima: add FIRMWARE_PARTIAL_READ support
Date:   Tue,  9 Jun 2020 15:56:56 -0700
Message-Id: <20200609225656.18663-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609225656.18663-1-scott.branden@broadcom.com>
References: <20200609225656.18663-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add FIRMWARE_PARTIAL_READ support for integrity
measurement on partial reads of firmware files.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 security/integrity/ima/ima_main.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 800fb3bba418..fc5134807acf 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -609,6 +609,9 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	enum ima_hooks func;
+	u32 secid;
+
 	/*
 	 * READING_FIRMWARE_PREALLOC_BUFFER
 	 *
@@ -617,11 +620,27 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	 * of IMA's signature verification any more than when using two
 	 * buffers?
 	 */
-	return 0;
+	if (read_id != READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
+	if (!file) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
+
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PARTIAL_READ] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
@@ -648,6 +667,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
+	if (read_id == READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.17.1

