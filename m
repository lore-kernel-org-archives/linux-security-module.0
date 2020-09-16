Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB8C433E2
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4D121974
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NzuEqJEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgIPSX3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgIPSW5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 14:22:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E1C035435
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:06:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so6601637wrl.12
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rp7Xhs/bBt9D8tUMlvjIoqHMOsBqD8IYyxiK/2FKKG8=;
        b=NzuEqJEaQL8fg8E+ugG0EvQ+ISnYy96VOTeyqJ2H4egEbK1//gM37ymiqQDoNLVucw
         ZHKgF8zoZS4sE+eFUY5nU3d0PGYihU3kowLoGaEPHhj2oy4IPrVBPyh1462yd5rznFvZ
         2PtEI+LhLapu6mgrPLWGZVRDWX7X4PLtZb42I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rp7Xhs/bBt9D8tUMlvjIoqHMOsBqD8IYyxiK/2FKKG8=;
        b=oX+pQqhb4lK/CZ2MNc2K/HdEGyMGAaUYTW0UuGG16QzK2YNaLoTPTTFPxXxsP1SUDb
         G9HzfeDjEic7bPPWSzTpyh2Ofc5jO+4qak0oUiDd/axAakC5SXUuFAydsGjgihMwDYOm
         XEHQuZ/v842W6QtA9CJdRy7+1KMWpjsTK0AJDFSrogIqr3YCAJeiUa1QWT3EEey7Twwp
         w2N/CCFHqmRgrFtJWXqN9Sfc7IUkumXBNqBpEiFU4wjoPaN5SqJ6/Mpp2t3YVJqDWEJ1
         i7eWdmycqB6wt1NiOfmEcOVvK8A6xH5KZOZ2oBvTTbYxFtMXR2/waIkIjFRIHRfk1089
         qW6A==
X-Gm-Message-State: AOAM533QCnVLUfE89+fNYvsYVsdo5pAWBs4KppqXl9AV7mc/Wfj3ZsJ3
        4V8NeWGM1o+B9oF7kNp7pUxo7Q==
X-Google-Smtp-Source: ABdhPJwhEX5BY4LjbmOas8IFcM0+VybB2aJZphWqZuuk3BYpd+O+YeVNh7I4lfx7jWld+B+H8VyF6w==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr25833458wrm.422.1600258018090;
        Wed, 16 Sep 2020 05:06:58 -0700 (PDT)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id h8sm32042888wrw.68.2020.09.16.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:06:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH] ima: Fix NULL pointer dereference in ima_file_hash
Date:   Wed, 16 Sep 2020 12:05:48 +0000
Message-Id: <20200916120548.364892-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
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
2.28.0.618.gf4bc123cb7-goog

