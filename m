Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF03C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27062087E
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfB1Xy5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:54:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:46172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfB1Xy5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:54:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0920AC43
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 23:54:55 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-security-module@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
Subject: [PATCH] LSM: Update list of SECURITYFS users in Kconfig
Date:   Fri,  1 Mar 2019 00:54:48 +0100
Message-Id: <20190228235448.14279-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

+ Remove modules not using it (SELinux and SMACK aren't
the only ones not using it).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 9555f4914492..1d6463fb1450 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -40,8 +40,7 @@ config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
 	  This will build the securityfs filesystem.  It is currently used by
-	  the TPM bios character driver and IMA, an integrity provider.  It is
-	  not used by SELinux or SMACK.
+	  various security modules (AppArmor, IMA, SafeSetID, TOMOYO, TPM).
 
 	  If you are unsure how to answer this question, answer N.
 
-- 
2.20.1

