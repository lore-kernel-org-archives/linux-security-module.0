Return-Path: <SRS0=478F=TU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24078C072A4
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4C2171F
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 20:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oy4ecePB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfETUzX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 May 2019 16:55:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56153 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfETUzO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 May 2019 16:55:14 -0400
Received: by mail-pg1-f201.google.com with SMTP id g38so10468620pgl.22
        for <linux-security-module@vger.kernel.org>; Mon, 20 May 2019 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aAD72H50ABa7i4hUmGTaWeMcxOGiBgmrF/zB0iTqZPc=;
        b=oy4ecePBsvz9xac0sPq5+vZj/9DPsHi82imiGV3JXteI2ZIAgaQBj5lIBG6QRT7Pwb
         JDCFVI8HELF3U8vUxaYayffHsPJmwS+V5pA5EM0kHV+BtF5CrZDr8WKsebDQKfJePJ1U
         VRp5JL+s0h20lcmBB9keY28+iGuLquVMetdMhqk5NzKXJUjlIb5UWHt3tBEefJ4BVQZk
         EqPYQ9dO7jAmi2kUrMfB6cGrkhG7Hy27QAJ7NphhR2soj/A+Ae1hUeh3RrBSbnyaZShU
         OICSHoL+cttN6/XUpBvv0K3X3GLs1y0aS/M7lZHBvclCcp61I0eQv8ZJjpJMeZTDaPVV
         UW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aAD72H50ABa7i4hUmGTaWeMcxOGiBgmrF/zB0iTqZPc=;
        b=M1HgWJzBeiqYtz1aoPyf1ZFFSY7BpQ0OzgDfaAXaEPjq3KoUcsloZ3AHQB6Ib/csSW
         pqOCo31RDIhOyGwWVm3rEakOVQ2Zdh6vpuJnuWrjutQNSmeKGaC3EGHyyNRpr/8DcyZC
         /5wCvgjMFhreywVghisTHMrYFojv5bN6b/FU8aLgB4da0DsiiYKJFU3MPia5ETOXawNP
         8ksgYU0/XyPJNazkDRNhNq1CmcH1CqKxNV2xRr5IiKScZ1ZqbWMVhqlj6hFLUW8Kg5AO
         8gUY+oUVYw1y3vP6vV+91l8y4q76j1fl84TF9K9PfV/pIMTLl0synIwdhtLHdvRoaqfc
         CkiA==
X-Gm-Message-State: APjAAAWkuBIgei0y0T+wYeXgkzWx1YoX2/T57IQtaDYiyw5qtsxBr6iP
        V7NcRkDaa59GdVpmKOPw69Xq8T7DuJtC0uJoqwQSGg==
X-Google-Smtp-Source: APXvYqx75zjpUcQWvw9WxMc9l5hCExHXJMIe9nadtcG8JTTEN8h5aDc/zRJjwAMciCjy8pxxh8N9mOQ4lXQ6Ys5tGDb96g==
X-Received: by 2002:a65:4c07:: with SMTP id u7mr75208395pgq.93.1558385713378;
 Mon, 20 May 2019 13:55:13 -0700 (PDT)
Date:   Mon, 20 May 2019 13:55:00 -0700
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
Message-Id: <20190520205501.177637-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 3/4] tpm: Append the final event log to the TPM event log
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@google.com>

Any events that are logged after GetEventsLog() is called are logged to
the EFI Final Events table. These events are defined as being in the
crypto agile log format, so we can just append them directly to the
existing log if it's in the same format. In theory we can also construct
old-style SHA1 log entries for devices that only return logs in that
format, but EDK2 doesn't generate the final event log in that case so
it doesn't seem worth it at the moment.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/efi.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 3e673ab22cb4..9179cf6bdee9 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -21,10 +21,13 @@
 int tpm_read_log_efi(struct tpm_chip *chip)
 {
 
+	struct efi_tcg2_final_events_table *final_tbl = NULL;
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct tpm_bios_log *log;
 	u32 log_size;
 	u8 tpm_log_version;
+	void *tmp;
+	int ret;
 
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
@@ -52,15 +55,48 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 
 	/* malloc EventLog space */
 	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
-	if (!log->bios_event_log)
-		goto err_memunmap;
-	log->bios_event_log_end = log->bios_event_log + log_size;
+	if (!log->bios_event_log) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
+	log->bios_event_log_end = log->bios_event_log + log_size;
 	tpm_log_version = log_tbl->version;
-	memunmap(log_tbl);
-	return tpm_log_version;
 
-err_memunmap:
+	ret = tpm_log_version;
+
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
+	    efi_tpm_final_log_size == 0 ||
+	    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		goto out;
+
+	final_tbl = memremap(efi.tpm_final_log,
+			     sizeof(*final_tbl) + efi_tpm_final_log_size,
+			     MEMREMAP_WB);
+	if (!final_tbl) {
+		pr_err("Could not map UEFI TPM final log\n");
+		kfree(log->bios_event_log);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tmp = krealloc(log->bios_event_log,
+		       log_size + efi_tpm_final_log_size,
+		       GFP_KERNEL);
+	if (!tmp) {
+		kfree(log->bios_event_log);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	log->bios_event_log = tmp;
+	memcpy((void *)log->bios_event_log + log_size,
+	       final_tbl->events, efi_tpm_final_log_size);
+	log->bios_event_log_end = log->bios_event_log +
+		log_size + efi_tpm_final_log_size;
+
+out:
+	memunmap(final_tbl);
 	memunmap(log_tbl);
-	return -ENOMEM;
+	return ret;
 }
-- 
2.21.0.1020.gf2820cf01a-goog

