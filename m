Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E8C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Feb 2021 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E3264DDF
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Feb 2021 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhBIQux (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:50:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:60761 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233096AbhBIQsv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Feb 2021 11:48:51 -0500
IronPort-SDR: +Z8Fj6Z3WzxqWAu0V+F2XPXURXALfcQx3ZIwOwIyXlgTHGURwpVS9dbznZyG6Pu7PNzCV4tIqL
 Ay/vSbJZB7KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="243407805"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="243407805"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 08:45:13 -0800
IronPort-SDR: /IKosY9bZhDcmdE+JWoWbtT9VPqODlD2tx9Nmp4rHoBvimkPi8Jw27Dl0k9t8N4ku5aUH2M7DH
 yAaMu0U7jxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="398836519"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2021 08:45:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B98D11C7; Tue,  9 Feb 2021 18:45:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
Date:   Tue,  9 Feb 2021 18:45:06 +0200
Message-Id: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
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
2.30.0

