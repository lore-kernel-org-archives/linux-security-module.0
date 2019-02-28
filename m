Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C83C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B402133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9mbo5KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfB1XMm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:42 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:46418 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbfB1XMm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:42 -0500
Received: by mail-oi1-f201.google.com with SMTP id v138so9728902oie.13
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mp70BzDzYljwrYd25Lt2UYdTDnlpZHVvwxSHppwzPMQ=;
        b=d9mbo5KRuX/RDzSfaF9z9U/JVALls/m/pz/TIR77Q8r3FIN9dJSFVDfe7as12j9CYg
         qdZsexqPqnAnxNUev6Df6+SU06uOFjwvNupM5qThkzxUC15WeMpr/ddVBIPpUk/sshgT
         Yi5w8NjP8cW20UyrwtFhz2TyseSwRojDZ/w/dlGj8GGMfifKP/4bOXm+K2rOU8mgi9Cq
         APHC6H3pa3BlkFIFnpQhlTRcgtn6Jp9jwLbfbnead8KChCcHOpGUiD4PlmqMesuMwi2j
         FXGWgUQvqdOBu7336UXlYA4jKK7YzGfa7nW2nwCbZbMRZw9MYFvHqpRhaK7UJesHPJJz
         QcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mp70BzDzYljwrYd25Lt2UYdTDnlpZHVvwxSHppwzPMQ=;
        b=TapbBYi17YQr8cl+JDt7Va8+HdDVX1Y6CLkHbSd/mBXx2kTFFBEIwyWGVm9V02nR0V
         bdKSeputAiiCXSwj1v1xlJiQHkhdMe91/u7awLiciRkbZ716A+yKAhCr+AK6IwET5K0O
         beyH9/IfSf6z7QkbwjJ3PQ2iKDg9HZg5qkBwTycSv5x7PFZcbYQjmUPeaSdAyHrg1ND8
         Ka6AWTtMpC2oZWP1khVH7rMIfM+k+feSEWNSwOBzUt5N2valepJh6kRzap3bEVLYkh0T
         c+t9rsnOP4o5Cu4T0/+mUIaEZRFljY6clYtB5rTjycDfUBmVCz7t0uPKJ8LH7fcgQTyP
         9UoQ==
X-Gm-Message-State: AHQUAuZl17NjbVPYxyDXgwLMx3GmtZ9y9aKQfYXKDA99QxYmm6JLPc87
        vbw2fgXmLqQA5vCG9l57L44k+lLE4vZUaX3INjarmA==
X-Google-Smtp-Source: AHgI3Ia5usj8LcdFU5Loh4aKXUNg08MNR91CW+JW/r9yGIg2PlSZhi9WN17w46ruHiIg35AKXfCS9vIsXAqcsDrlO7E+sQ==
X-Received: by 2002:aca:4b97:: with SMTP id y145mr1322685oia.19.1551395561327;
 Thu, 28 Feb 2019 15:12:41 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:50 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 14/27] ACPI: Limit access to custom_method when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..ac8a90dc7096 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods"))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
-- 
2.21.0.352.gf09ad66450-goog

