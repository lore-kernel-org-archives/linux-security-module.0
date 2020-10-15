Return-Path: <SRS0=3ULx=DW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A3C43457
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EBC212CC
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 11:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgJOLyd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 07:54:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:30479 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgJOLvJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 07:51:09 -0400
IronPort-SDR: awrGrhFq3bLkfZ/8oM9MpYUsyHNiMkZZ9hjaUtcUCt0xelzMqaYo4+lMgxKPmXnP+6o4XxJf4I
 YbOfMLD0TZAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="227974480"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="227974480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 04:50:30 -0700
IronPort-SDR: 0iHbdXvvEp4TY5M5iECt1suWmz50f/BTnDXYkB061r858IraoLzC3njImmXBfcfJ2cxql9E+Bq
 Lxtqzh0u6qcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="346825992"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2020 04:50:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B103E163; Thu, 15 Oct 2020 14:50:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
Date:   Thu, 15 Oct 2020 14:50:28 +0300
Message-Id: <20201015115028.81857-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
its internal members.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 security/integrity/platform_certs/efi_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/efi_parser.c b/security/integrity/platform_certs/efi_parser.c
index 18f01f36fe6a..d98260f8402a 100644
--- a/security/integrity/platform_certs/efi_parser.c
+++ b/security/integrity/platform_certs/efi_parser.c
@@ -55,7 +55,7 @@ int __init parse_efi_signature_list(
 		memcpy(&list, data, sizeof(list));
 		pr_devel("LIST[%04x] guid=%pUl ls=%x hs=%x ss=%x\n",
 			 offs,
-			 list.signature_type.b, list.signature_list_size,
+			 &list.signature_type, list.signature_list_size,
 			 list.signature_header_size, list.signature_size);
 
 		lsize = list.signature_list_size;
-- 
2.28.0

