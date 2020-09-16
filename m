Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A4C43461
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DB4223BE
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 17:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="InxUCSWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIPRAU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgIPQ6x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 12:58:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C115C0A888F
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:49:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so6747393wrw.11
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTfO3goFQ53jX3wxtR/mPL0APiItMgxITG7tSdcSODo=;
        b=InxUCSWP1Ix4941Y8ZuonBPbJv4JjOVbjAheCgW+waNMMd7sdM8tnn83rP/Q3lIBOu
         cNGgA5Ck6dD3KYpWWh3MEhjBrcJOQ6hHc6D6assuxadGdhCp3hVfg+ro0XP99ZoMKGW8
         YxiMmAQBKSNQJjLGe/hD5UInswPyTpclk5Hyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTfO3goFQ53jX3wxtR/mPL0APiItMgxITG7tSdcSODo=;
        b=jbFRXnXHvVVFTMzl7W05YrP1tyF5Md4oDvyjZrmo0geOhagRt6UrmYfJiq44vt0/a1
         +u2RBESgLw+qanirz2yULmIx3C2BGyCHjMWPqmQqZUL7twTdBvSJhRgpTASupQBtH7rz
         0j2i04RVHMqyEW2P+WRE48Hy6/N8hExam8610zxqyluC4PEqsX6drO4bsSJlWJRCae9p
         pfyPdOYpf0RoCp61/vT2AMxKY/jCiKB3C/nWRql7OGgI+JK6HaZoaiOUAuFGEZreB7dl
         QLxufjLrNBUPES22G1XvnBW+sD1AvgOER0myca5V8LQtwiNQTCpyrf0859daG33wTmGu
         vstg==
X-Gm-Message-State: AOAM531Yn323wfwy4hXDjkkcgy7H59zN20mIYOhhjPuUbZgHwLRP3G9T
        mj7PI2QuxODeqMjDEtWKfR3+mQ==
X-Google-Smtp-Source: ABdhPJzrTeYUbCd54+0I1gVq1atLgahupxaCLEXDOXN7T+1M8VUhQQ/vYXMuOg/L/e5xhT7ssBFurQ==
X-Received: by 2002:adf:81e6:: with SMTP id 93mr26429889wra.412.1600260574156;
        Wed, 16 Sep 2020 05:49:34 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a11sm5242066wmm.18.2020.09.16.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:49:33 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Florent Revest <revest@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v2] ima: Fix NULL pointer dereference in ima_file_hash
Date:   Wed, 16 Sep 2020 14:49:31 +0200
Message-Id: <20200916124931.1254990-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

ima_file_hash can be called when there is no iint->ima_hash available
even though the inode exists in the integrity cache.

An example where this can happen (suggested by Jann Horn):

Process A does:

	while(1) {
		unlink("/tmp/imafoo");
		fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
		if (fd == -1) {
			perror("open");
			continue;
		}
		write(fd, "A", 1);
		close(fd);
	}

and Process B does:

	while (1) {
		int fd = open("/tmp/imafoo", O_RDONLY);
		if (fd == -1)
			continue;
    		char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
			 	     MAP_PRIVATE, fd, 0);
		if (mapping != MAP_FAILED)
			munmap(mapping, 0x1000);
		close(fd);
  	}

Due to the race to get the iint->mutex between ima_file_hash and
process_measurement iint->ima_hash could still be NULL.

Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash of a given file")
Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Florent Revest <revest@chromium.org>
---
 security/integrity/ima/ima_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..4c86cd4eece0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&iint->mutex);
+
+	/*
+	 * ima_file_hash can be called when ima_collect_measurement has still
+	 * not been called, we might not always have a hash.
+	 */
+	if (!iint->ima_hash) {
+		mutex_unlock(&iint->mutex);
+		return -EOPNOTSUPP;
+	}
+
 	if (buf) {
 		size_t copied_size;
 
-- 
2.28.0.526.ge36021eeef-goog

