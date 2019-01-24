Return-Path: <SRS0=u3U2=QA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E244C282C3
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565EF218D3
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 20:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAXUhG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:37:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:6195 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfAXUhG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Jan 2019 15:37:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 12:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="132839973"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2019 12:37:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F1C2055; Thu, 24 Jan 2019 22:37:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] evm: Use defined constant for UUID representation
Date:   Thu, 24 Jan 2019 22:37:02 +0200
Message-Id: <20190124203702.42417-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Instead of sizeof use pre-defined constant for UUID representation.

While here, drop the implementation details of uuid_t type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 security/integrity/evm/evm_crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 43e2dc3a60d0..c37d08118af5 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -173,8 +173,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
 	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
-				    sizeof(inode->i_sb->s_uuid));
+		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
 	crypto_shash_final(desc, digest);
 }
 
-- 
2.20.1

