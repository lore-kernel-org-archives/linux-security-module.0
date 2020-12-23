Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C36BC43331
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Dec 2020 02:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCE22222D
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Dec 2020 02:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgLWCYg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbgLWCYf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Dec 2020 21:24:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D10523159;
        Wed, 23 Dec 2020 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690260;
        bh=hpmLo2gwFJoOcqxhGr7HjqPMo/CMAsYlWleo0VkfY30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPFIM2BcHnoOuz44mbfyx2j7ihreNEBHvgrzjoDRCcRZZ5SxQx5xPx0XdektNtvNf
         b6hb78y4WoyZ5dvzBDoItP+GHweg+jsHBxjsFOJKeCMK7jBKtgVxcyzy2ODjZ2rRiV
         Ey9Ck1HoUSKeAc0KRPIMEJNFBpOcwPyHvI80DUZmhuwx96x8MSN72mRDlO/sTyR0IP
         hc8zWXGcoHBvxvPg2bdfe9aDLObuCOQ9kSi4UvYDIQvR/S18Z1TrInJKcpxqiSpAlJ
         Mm9lxQ1egN2/z1MfUaw7yofvfc9wSkbcWnaGQ56P5r2NrPnPGld1dcJeQpdWSHce1H
         rY7bsovGIJMzg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 02/48] tomoyo: fix clang pointer arithmetic warning
Date:   Tue, 22 Dec 2020 21:23:30 -0500
Message-Id: <20201223022417.2794032-2-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022417.2794032-1-sashal@kernel.org>
References: <20201223022417.2794032-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d9594e0409651a237903a13c9718df889f43d43b ]

clang warns about additions on NULL pointers being undefined in C:

security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
        securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,

Change the code to instead use a cast through uintptr_t to avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/securityfs_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 06ab41b1ff286..7590dee59f02f 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -130,8 +130,8 @@ static const struct file_operations tomoyo_self_operations = {
  */
 static int tomoyo_open(struct inode *inode, struct file *file)
 {
-	const int key = ((u8 *) file_inode(file)->i_private)
-		- ((u8 *) NULL);
+	const u8 key = (uintptr_t) file_inode(file)->i_private;
+
 	return tomoyo_open_control(key, file);
 }
 
@@ -222,7 +222,7 @@ static const struct file_operations tomoyo_operations = {
 static void __init tomoyo_create_entry(const char *name, const umode_t mode,
 				       struct dentry *parent, const u8 key)
 {
-	securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
+	securityfs_create_file(name, mode, parent, (void *) (uintptr_t) key,
 			       &tomoyo_operations);
 }
 
-- 
2.27.0

