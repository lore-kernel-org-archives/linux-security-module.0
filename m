Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C5EC433E2
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F382020872
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VyjLGizp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgIPSD2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgIPSCt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 14:02:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98FC06174A
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 11:02:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so3987963wmi.0
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPwhusTWYDQ4QjD+ev8+QjSTTu6T0Fu2+n0uxDZxjos=;
        b=VyjLGizpCp6P2PFqz82TtrO43roEou9wcLjw9UHR3RZ+XQ0Jgur0rvXmT4ZVZBFMef
         SceMXRAdAgYQ4Py0eZcOdoBSnRsQScHAH1e65lTujVJGlW1AzE4AweL06S5/wx1oUhec
         vRHL13BNVcF1qAcUApaT2VrpOQNS+9LTYNZHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPwhusTWYDQ4QjD+ev8+QjSTTu6T0Fu2+n0uxDZxjos=;
        b=sf77/6gVzjckJvGoD3BlQiDq3BJpx7sxfQe7BwZRfsAkXoz9evk5WBUXtIfzCvJ+nx
         /1ZY7wFv4EPIXWhLjgpnUvEJh0kruzix75dXU4htN5dRnQXbjq4P/KUFwfp7s01G8x2s
         1taBRmTgK62efPi8Bb9KTQ9a/EjgZRQ1fMM24ksLxeAqQKwkIgUxB3BUZfIBkjxQX5fr
         6xcfl0USGXhqFJOK26W6fC+7wwh7Wx3mtzY+Jc6PwTQI1McDVK5tzrC+waE9IC2WzLjD
         /nlSte1q1Tp4mO2pFzHFabAjEuSWtKfia0G0kMwpS1jsYxtYip5ZTtjkcCIuJPR2Qk97
         4lBw==
X-Gm-Message-State: AOAM533miFu5R44BT+LuMMsQXQ22FAPxlNyqqAdxNfFwcdY2kc4JthqA
        yxUrLXPz3bFFlGLozKYD98aOpg==
X-Google-Smtp-Source: ABdhPJwVNH/jhFaJjqOw4YY09k+qaa4JgESdF9XioxXnqexJSIWHzIQiPqBw2Ugj/jiIFesx3LvRnA==
X-Received: by 2002:a05:600c:210c:: with SMTP id u12mr6434238wml.185.1600279366269;
        Wed, 16 Sep 2020 11:02:46 -0700 (PDT)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id v17sm36702944wrc.23.2020.09.16.11.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:02:45 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Florent Revest <revest@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v3] ima: Fix NULL pointer dereference in ima_file_hash
Date:   Wed, 16 Sep 2020 18:02:42 +0000
Message-Id: <20200916180242.430668-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

ima_file_hash can be called when there is no iint->ima_hash available
even though the inode exists in the integrity cache. It is fairly
common for a file to not have a hash. (e.g. an mknodat, prior to the
file being closed).

Another example where this can happen (suggested by Jann Horn):

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

Changelog:

v2 -> v3

- Updated commit description.

v1 -> v2

- Added Review Tags, attempt to get the patch on the lists somehow.

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

