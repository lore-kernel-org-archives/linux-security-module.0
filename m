Return-Path: <SRS0=EupR=RE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B42CC43381
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 11:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1820851
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 11:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfCALac (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:30:32 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:53580 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCALac (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Mar 2019 06:30:32 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gzgN2-0001w9-K9; Fri, 01 Mar 2019 11:30:28 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92-RC6)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gzgN2-0004cZ-4F; Fri, 01 Mar 2019 11:30:28 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
Date:   Fri,  1 Mar 2019 11:30:26 +0000
Message-Id: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
it as it is a user pointer. This clears the following sparse warning
for this:

security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 security/keys/keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 7bbe03593e58..3e4053a217c3 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1752,7 +1752,7 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		return keyctl_pkey_query((key_serial_t)arg2,
 					 (const char __user *)arg4,
-					 (struct keyctl_pkey_query *)arg5);
+					 (struct keyctl_pkey_query __user *)arg5);
 
 	case KEYCTL_PKEY_ENCRYPT:
 	case KEYCTL_PKEY_DECRYPT:
-- 
2.20.1

