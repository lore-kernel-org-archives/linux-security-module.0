Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDACC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F06F213A2
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNA62/jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfB0U1Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:27:25 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:34719 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfB0U1L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 15:27:11 -0500
Received: by mail-ot1-f74.google.com with SMTP id r22so8595429otk.1
        for <linux-security-module@vger.kernel.org>; Wed, 27 Feb 2019 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3L31ImPCYlGPP1bi5DAr6zYqB9pcQjRPEOMnQpUbHhA=;
        b=ZNA62/jNwS7RcVm9H6hzc7NWWtLy85D0rnemhDxSo6HfSbOy8zsXqJcYo5REUQdv1M
         BuaZxCiydYSlLaw8S0O9XxMj6t7XLbNy7DQHxt1fzMHg+Mww/7OhTiokSM9JdWX4bInW
         dkW9ioWtQvm1MFf1IMWMMul9pvs3Dh+ixFIFVe+5XL7iKpQIjSVk0wZb8FVx2ZDhYz0x
         vuNknPrk1/GR4sFtoQygEJRfIQXXymafLkqqnAubteY6G51Hi/HpJILtSDC3dzmhMKs1
         3PWi8z7WV/QGh93WgO855GgcFsFgY2yqfS5gByzoIMYoTvC0afEHLTSVXdP6DDDZfgQE
         2kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3L31ImPCYlGPP1bi5DAr6zYqB9pcQjRPEOMnQpUbHhA=;
        b=QvGHeAd0/RsyOaWamv80ONNCKnYt7G8ugQ40MBnZNVDf/Zj+5zmBtaz4150dEtoJ7M
         /Hw0HgDxSB5BBxyLi+uyWjaYmEpTSvdhMLCPtOeuB4LX/Aa0kd/bmygvAlL7fH2N9c58
         rPScoQ7qewDr7gEtPs019KTWst8acIT5F7C4ZxgjLsOFsZcassy6CrCoM4rw2tWdxjAj
         nhDMgbUZMFlNXnM7wXNBdMD/cCNZ+8cnC3oyOs6xdEsOidKY0g7hWZ+4c9WBo74pPxWN
         jFQ5N8gkxyubEITjJBE0Bl9RIcra4HzR6dN9gf8l57ATJUm0RH1Ko/p8Hfw911vx2thN
         n3+A==
X-Gm-Message-State: AHQUAuZqlvSnvwSyOs7gBsznXdIayUbAn4lQy1UbUfKjcNn1yCrRFHAq
        Bej2n+zW7eXPnB/MhPqx9evTHmO/JIc2q2iWqcM63g==
X-Google-Smtp-Source: AHgI3Ib8gnfrdLV62veuKkodl6J5yrYM59d84uMSZ0SXecQKIMY0t1QuXK0rebBjyHl7gchg0yBdPAFNIWplOpq/9zfz2g==
X-Received: by 2002:a9d:7d88:: with SMTP id j8mr3017930otn.44.1551299230762;
 Wed, 27 Feb 2019 12:27:10 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:26:57 -0800
In-Reply-To: <20190227202658.197113-1-matthewgarrett@google.com>
Message-Id: <20190227202658.197113-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH V5 3/4] tpm: Append the final event log to the TPM event log
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
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
2.21.0.352.gf09ad66450-goog

