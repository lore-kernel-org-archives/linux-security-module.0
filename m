Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E8FC4151A
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146372082C
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693533;
	bh=vozAf9uuLtgzOx1YZ7GWZTlL7G1QF5MSzZEKVuTv/BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lq6NMi0m6gM9n33WmfSpBzejY+OqOqN70Twi1Syv2NopnocWjrabCm4yFxW/tOUsu
	 4vRgfo1rvLTNKCrsUBalPiespu812zd0B9IW4M7h/77Nmb3ry/RRNldnF0iHk5tAXj
	 kMg2qQx6W+HvJa11E2xWI5rVGU2ndtN5YHybg7aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfA1Qiq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389285AbfA1QYv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49A321741;
        Mon, 28 Jan 2019 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692690;
        bh=vozAf9uuLtgzOx1YZ7GWZTlL7G1QF5MSzZEKVuTv/BA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWCLXXjRFbqVc6FkiibAKXYZYrMIG8ZedvPWk6MEY3hcee6/yTom4XzF4lJcgNmC1
         pgWCsGf84yshNAtw+2TXl7EZa3+SBcWRX3kYFyRXY2GFQLS1VZ3r+OCHqqlL+J2kSK
         /JUHulMJ3EL6xalrx9kMea9TGoPR7ly70mFyMUjQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zoran Markovic <zmarkovic@sierrawireless.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 29/80] smack: fix access permissions for keyring
Date:   Mon, 28 Jan 2019 11:23:10 -0500
Message-Id: <20190128162401.58841-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Zoran Markovic <zmarkovic@sierrawireless.com>

[ Upstream commit 5b841bfab695e3b8ae793172a9ff7990f99cc3e2 ]

Function smack_key_permission() only issues smack requests for the
following operations:
 - KEY_NEED_READ (issues MAY_READ)
 - KEY_NEED_WRITE (issues MAY_WRITE)
 - KEY_NEED_LINK (issues MAY_WRITE)
 - KEY_NEED_SETATTR (issues MAY_WRITE)
A blank smack request is issued in all other cases, resulting in
smack access being granted if there is any rule defined between
subject and object, or denied with -EACCES otherwise.

Request MAY_READ access for KEY_NEED_SEARCH and KEY_NEED_VIEW.
Fix the logic in the unlikely case when both MAY_READ and
MAY_WRITE are needed. Validate access permission field for valid
contents.

Signed-off-by: Zoran Markovic <zmarkovic@sierrawireless.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c73361859d11..9db7c80a74aa 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4311,6 +4311,12 @@ static int smack_key_permission(key_ref_t key_ref,
 	int request = 0;
 	int rc;
 
+	/*
+	 * Validate requested permissions
+	 */
+	if (perm & ~KEY_NEED_ALL)
+		return -EINVAL;
+
 	keyp = key_ref_to_ptr(key_ref);
 	if (keyp == NULL)
 		return -EINVAL;
@@ -4330,10 +4336,10 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	if (perm & KEY_NEED_READ)
-		request = MAY_READ;
+	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
+		request |= MAY_READ;
 	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
-		request = MAY_WRITE;
+		request |= MAY_WRITE;
 	rc = smk_access(tkp, keyp->security, request, &ad);
 	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
 	return rc;
-- 
2.19.1

