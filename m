Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A4FC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C90206C0
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJr9K5Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfCYWKi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:38 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45819 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731037AbfCYWKh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id u78so10584038pfa.12
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hmYNaFdsLzMxO/YCEIEvJsYLVrtmlenBIeDGJtGu3OM=;
        b=WJr9K5NgaEvPnAiYcVXgNCci/FaQmP1mLDAruGRbuoJYCIIIAIHCe8AoJ7Kr/r7XTQ
         GQw08DDyEUVpKvHTAEIb+sEPYXaATnoEYcMU6RUM1j1Tho9BRATvED8dklQVfey1WoCS
         5Zw2P9yQRsZ3CfcPkjLEJGSVsIfKaucUb4rie3Em8mgNadzfJUISMHz/jGWDE1Fa8RBq
         AE2BTFqdLHnL2BpGCs/nUCP1iEIBaaePrRAiduat/JTEYNX3z9pzJ+ITXdHdNLZkF0N4
         S8pT0CxX6x4PrXc7LM2QN3tHBFsDnMAzcAJRZmMLq007lOBsanWryVyF2DgZD6WVGgwW
         Iyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hmYNaFdsLzMxO/YCEIEvJsYLVrtmlenBIeDGJtGu3OM=;
        b=n6T7SnZpam4b6p4LdwpQDnR4eeuAMoahahLowcWONWqcWaWj+fVI5eNQS2cbhbwnt0
         9W0BdseJ7fen3dZG0n/MccTjbt3ronqqQ7QMk8SpQSvij/d+GsLywEmE3wlls6CFYEVi
         WIWF6Bte8BLfl0XzjlErsbULv934wEUcqwXEvNXXC5XlQawMV3LZ5P+KFMjFlEtLLP9q
         Yix7x3iJ+615i53DoYOUfftJFR3mMdfKB59+Jo2+aWgSQoo5dI+GguTj0eGzs4c+RC47
         XyOxcZVEtvBjMBipCXwMFKL9/+uj2mYJcwwKSWLtCQurMUZi2Odac7P629k+9SL9S7ZB
         XtKA==
X-Gm-Message-State: APjAAAVwEDrvd08rM4XTf95YMT2/BMGCGjfKq8dAWAa2hg9ZRNxTSqn0
        rpJ2GvN0w7AtScgBcgLy1RnSPnRcsZNjHnfZkTHGnA==
X-Google-Smtp-Source: APXvYqzfY5QZCxd8HlRriXAgwGnuI2xGeE8bqzN/WGpaom6jdlIsf/syZMyYGJEMLS58QanuSd8SJG/TxwADifrWkLpwHg==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr26146963pgb.302.1553551836682;
 Mon, 25 Mar 2019 15:10:36 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:42 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 15/27] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Linn Crosetto <linn@hpe.com>, linux-acpi@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When securelevel is set, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/tables.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6c2d4f..f3b4117cd8f3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -531,6 +531,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override")) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.21.0.392.gf8f6787159e-goog

