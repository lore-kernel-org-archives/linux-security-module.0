Return-Path: <SRS0=4lEG=AM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199AFC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BD9207F9
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgGANqi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:46:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60748 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgGANqi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 09:46:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jqd4M-0001xc-W8; Wed, 01 Jul 2020 13:46:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: remove redundant initialization of variable ret
Date:   Wed,  1 Jul 2020 14:46:34 +0100
Message-Id: <20200701134634.549399-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/integrity/digsig_asymmetric.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 4e0d6778277e..cfa4127d0518 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -79,7 +79,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
 	struct key *key;
-	int ret = -ENOMEM;
+	int ret;
 
 	if (siglen <= sizeof(*hdr))
 		return -EBADMSG;
-- 
2.27.0

