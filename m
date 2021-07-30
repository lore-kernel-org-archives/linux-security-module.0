Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CEAC4338F
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jul 2021 05:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F72960EC0
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jul 2021 05:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhG3FZT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:25:19 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:36116 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhG3FZP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Jul 2021 01:25:15 -0400
Received: from MTA-15-3.privateemail.com (MTA-15-1.privateemail.com [198.54.118.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id B32F18021A;
        Fri, 30 Jul 2021 01:25:09 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 59CA718000BB;
        Fri, 30 Jul 2021 01:25:07 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.210])
        by mta-15.privateemail.com (Postfix) with ESMTPA id 8E7D118000AD;
        Fri, 30 Jul 2021 01:25:06 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] apparmor: use per file locks for transactional queries
Date:   Fri, 30 Jul 2021 01:23:55 -0400
Message-Id: <20210730052355.77289-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As made mention of in commit 1dea3b41e84c5 ("apparmor: speed up
transactional queries"), a single lock is currently used to synchronize
transactional queries. We can, use the lock allocated for each file by
VFS instead.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 security/apparmor/apparmorfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2ee3b3d29f10..c0b626a271a0 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -812,8 +812,6 @@ struct multi_transaction {
 };
 
 #define MULTI_TRANSACTION_LIMIT (PAGE_SIZE - sizeof(struct multi_transaction))
-/* TODO: replace with per file lock */
-static DEFINE_SPINLOCK(multi_transaction_lock);
 
 static void multi_transaction_kref(struct kref *kref)
 {
@@ -847,10 +845,10 @@ static void multi_transaction_set(struct file *file,
 	AA_BUG(n > MULTI_TRANSACTION_LIMIT);
 
 	new->size = n;
-	spin_lock(&multi_transaction_lock);
+	spin_lock(&file->f_lock);
 	old = (struct multi_transaction *) file->private_data;
 	file->private_data = new;
-	spin_unlock(&multi_transaction_lock);
+	spin_unlock(&file->f_lock);
 	put_multi_transaction(old);
 }
 
@@ -879,9 +877,10 @@ static ssize_t multi_transaction_read(struct file *file, char __user *buf,
 	struct multi_transaction *t;
 	ssize_t ret;
 
-	spin_lock(&multi_transaction_lock);
+	spin_lock(&file->f_lock);
 	t = get_multi_transaction(file->private_data);
-	spin_unlock(&multi_transaction_lock);
+	spin_unlock(&file->f_lock);
+
 	if (!t)
 		return 0;
 
-- 
2.32.0

