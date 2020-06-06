Return-Path: <SRS0=zBV4=7T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4AC433E0
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Jun 2020 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F9B207DF
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Jun 2020 05:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NqhsiYCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgFFFGX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Jun 2020 01:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgFFFGX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jun 2020 01:06:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD69C08C5C5
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 22:06:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so6179047pgk.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gg1sREv3Ue3EZE+6zkyi5qJPu78iqur1/sq1nVKs7fQ=;
        b=NqhsiYCBsApk8OQ4euwL1rW2HjfJPC1Sy1xR+9ldSuzjoKc6Nu2ddFNV21WKA7/5mH
         C02pc5FP67c7R5zzbVozj76JVELrzZnvpZtLQjouyW87qQrkjB7xHbEsS6EKNbjOBa3/
         ECBqPJtfEyIP9XlGdoVbV1EWjogPxcvxLga48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gg1sREv3Ue3EZE+6zkyi5qJPu78iqur1/sq1nVKs7fQ=;
        b=FK4kVQO97ToVnEk52iR8vUSEncR3y9VqBSw3Nmooc57dPoVL90kan2uXtWS57A6rr0
         UA3z/GXg9gjMUl3Wiwg3UUFjfi8ROnhxpHAXjOCzBoGimHLfSmSIiB9mygcSIr3Yy+a2
         vr5me8IEMRN6Dh2H4FtAnUbvMpRl9EsN4b9fUTkzrR8MHgJDjCq8eVTqqG104qmrol+O
         9txadh28pA6eoSX9OsqtVME1E10Kq26E+XDwqnlUADvzaBXi3ROM7SI5ioCjWNZtCBYC
         gksyMcqhbUCpMkJOGLfIoPSjin7s9SzdOf7560dGQk68ALzXlRU4C+BtTgShCfJ1rBve
         UV5g==
X-Gm-Message-State: AOAM532BqdO3uQu3usnpKhbU46VCDI/lcr2y8/Gr+KuBipaChBC0+SED
        AWc9Pt+ymZ5ucPdJrM97PzD4wQ==
X-Google-Smtp-Source: ABdhPJy/TtikU056t8ThlFAFRmngK1twf8Q1YhN6UjEALP4EUWcFONXjw+kyA6y6IlHWOfQCQSk0HA==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr10164853pgk.237.1591419982381;
        Fri, 05 Jun 2020 22:06:22 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:06:21 -0700 (PDT)
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
Subject: [PATCH v7 3/8] test_firmware: add partial read support for request_firmware_into_buf
Date:   Fri,  5 Jun 2020 22:04:53 -0700
Message-Id: <20200606050458.17281-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606050458.17281-1-scott.branden@broadcom.com>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add additional hooks to test_firmware to pass in support
for partial file read using request_firmware_into_buf.
buf_size: size of buffer to request firmware into
partial: indicates that a partial file request is being made
file_offset: to indicate offset into file to request

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 lib/test_firmware.c | 146 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 10 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index af747660fe29..1a79611cae78 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -50,6 +50,9 @@ struct test_batched_req {
  * @name: the name of the firmware file to look for
  * @into_buf: when the into_buf is used if this is true
  *	request_firmware_into_buf() will be used instead.
+ * @buf_size: size of buf to allocate when into_buf is true
+ * @file_offset: file offset to request when calling request_firmware_into_buf
+ * @partial: partial read opt when calling request_firmware_into_buf
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
@@ -89,6 +92,9 @@ struct test_batched_req {
 struct test_config {
 	char *name;
 	bool into_buf;
+	size_t buf_size;
+	size_t file_offset;
+	bool partial;
 	bool sync_direct;
 	bool send_uevent;
 	u8 num_requests;
@@ -183,6 +189,9 @@ static int __test_firmware_config_init(void)
 	test_fw_config->num_requests = TEST_FIRMWARE_NUM_REQS;
 	test_fw_config->send_uevent = true;
 	test_fw_config->into_buf = false;
+	test_fw_config->buf_size = TEST_FIRMWARE_BUF_SIZE;
+	test_fw_config->file_offset = 0;
+	test_fw_config->partial = false;
 	test_fw_config->sync_direct = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
@@ -236,28 +245,35 @@ static ssize_t config_show(struct device *dev,
 			dev_name(dev));
 
 	if (test_fw_config->name)
-		len += scnprintf(buf+len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"name:\t%s\n",
 				test_fw_config->name);
 	else
-		len += scnprintf(buf+len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"name:\tEMTPY\n");
 
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"num_requests:\t%u\n", test_fw_config->num_requests);
 
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"send_uevent:\t\t%s\n",
 			test_fw_config->send_uevent ?
 			"FW_ACTION_HOTPLUG" :
 			"FW_ACTION_NOHOTPLUG");
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"into_buf:\t\t%s\n",
 			test_fw_config->into_buf ? "true" : "false");
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			"buf_size:\t%zu\n", test_fw_config->buf_size);
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			"file_offset:\t%zu\n", test_fw_config->file_offset);
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			"partial:\t\t%s\n",
+			test_fw_config->partial ? "true" : "false");
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
-	len += scnprintf(buf+len, PAGE_SIZE - len,
+	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 
 	mutex_unlock(&test_fw_mutex);
@@ -315,6 +331,30 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
+static int test_dev_config_update_size_t(const char *buf,
+					 size_t size,
+					 size_t *cfg)
+{
+	int ret;
+	long new;
+
+	ret = kstrtol(buf, 10, &new);
+	if (ret)
+		return ret;
+
+	mutex_lock(&test_fw_mutex);
+	*(size_t *)cfg = new;
+	mutex_unlock(&test_fw_mutex);
+
+	/* Always return full write size even if we didn't consume all */
+	return size;
+}
+
+static ssize_t test_dev_config_show_size_t(char *buf, size_t val)
+{
+	return snprintf(buf, PAGE_SIZE, "%zu\n", val);
+}
+
 static ssize_t test_dev_config_show_int(char *buf, int val)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
@@ -400,6 +440,83 @@ static ssize_t config_into_buf_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_into_buf);
 
+static ssize_t config_buf_size_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int rc;
+
+	mutex_lock(&test_fw_mutex);
+	if (test_fw_config->reqs) {
+		pr_err("Must call release_all_firmware prior to changing config\n");
+		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
+		goto out;
+	}
+	mutex_unlock(&test_fw_mutex);
+
+	rc = test_dev_config_update_size_t(buf, count,
+					   &test_fw_config->buf_size);
+
+out:
+	return rc;
+}
+
+static ssize_t config_buf_size_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return test_dev_config_show_size_t(buf, test_fw_config->buf_size);
+}
+static DEVICE_ATTR_RW(config_buf_size);
+
+static ssize_t config_file_offset_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	int rc;
+
+	mutex_lock(&test_fw_mutex);
+	if (test_fw_config->reqs) {
+		pr_err("Must call release_all_firmware prior to changing config\n");
+		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
+		goto out;
+	}
+	mutex_unlock(&test_fw_mutex);
+
+	rc = test_dev_config_update_size_t(buf, count,
+					   &test_fw_config->file_offset);
+
+out:
+	return rc;
+}
+
+static ssize_t config_file_offset_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return test_dev_config_show_size_t(buf, test_fw_config->file_offset);
+}
+static DEVICE_ATTR_RW(config_file_offset);
+
+static ssize_t config_partial_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf,
+					   count,
+					   &test_fw_config->partial);
+}
+
+static ssize_t config_partial_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->partial);
+}
+static DEVICE_ATTR_RW(config_partial);
+
 static ssize_t config_sync_direct_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -645,18 +762,24 @@ static int test_fw_run_batch_request(void *data)
 
 	if (test_fw_config->into_buf) {
 		void *test_buf;
+		enum kernel_pread_opt pread_opt;
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
 			return -ENOSPC;
 
+		if (test_fw_config->partial)
+			pread_opt = KERNEL_PREAD_PART;
+		else
+			pread_opt = KERNEL_PREAD_WHOLE;
+
 		req->rc = request_firmware_into_buf(&req->fw,
 						    req->name,
 						    req->dev,
 						    test_buf,
-						    TEST_FIRMWARE_BUF_SIZE,
-						    0,
-						    KERNEL_PREAD_WHOLE);
+						    test_fw_config->buf_size,
+						    test_fw_config->file_offset,
+						    pread_opt);
 		if (!req->fw)
 			kfree(test_buf);
 	} else {
@@ -929,6 +1052,9 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config_name),
 	TEST_FW_DEV_ATTR(config_num_requests),
 	TEST_FW_DEV_ATTR(config_into_buf),
+	TEST_FW_DEV_ATTR(config_buf_size),
+	TEST_FW_DEV_ATTR(config_file_offset),
+	TEST_FW_DEV_ATTR(config_partial),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
-- 
2.17.1

