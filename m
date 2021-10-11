Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC0C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FD060F21
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhJKNjP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Oct 2021 09:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237061AbhJKNjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Oct 2021 09:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC1E660551;
        Mon, 11 Oct 2021 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633959433;
        bh=XKO3LiuJj8DgefFwiJxIPYOvisoP7j6O+k6qVn+L2cA=;
        h=From:To:Cc:Subject:Date:From;
        b=VwY4D94AiZ4xEiWtCHWdhdhgejDFScgJXGegPMpYQ4QWiR3Au8QhOFs1w1GHtxWGR
         bRgE9KL85bso+b9uz649hSrtd7TE31fN5wnB74XW6mcSgMOBl6Vm12rIFoBjyZ/ejJ
         N6Yn+we5rl+OQl6ul8yIAYHOPKtaZYkyxmU5PHX5KvQxFV6yE7CcnoxkxbMkZkfspM
         dUYPyoViZPyasVbbQ3vyDqdqJ42G5mdluavQDB84rLZhD4Evk+nslZ2AGAzLmx2m5O
         M+vO6v3uNy/OgApiEIz+v2Zf4Xa9G345kQfMkXdTal0ZcRQBzrDDrGidPTBqEje4Lw
         a+RMJLG2X3xnA==
From:   Christian Brauner <brauner@kernel.org>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] security/landlock: use square brackets around "landlock-ruleset"
Date:   Mon, 11 Oct 2021 15:37:04 +0200
Message-Id: <20211011133704.1704369-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; h=from:subject; bh=ucJWxYJd1kyro1LLC/sCj7pGwHraVd1WKTUy1gC45mI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSm2P7dGfXw+snvmraRL1et/OiseSmiwPPver5ZYkn6DB+/ KvMd6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIoR2MDCvlQvMsdoaylioFJk6vPf X4Xlbe5jrPH0yNIuWnWA+U6DL8le+VP2K0nu2+CENPeo+vsVppc/Tpy9e+PnX13zp9rmsBDwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Christian Brauner <christian.brauner@ubuntu.com>

Make the name of the anon inode fd "[landlock-ruleset]" instead of
"landlock-ruleset". This is minor but most anon inode fds already
carry square brackets around their name:

    [eventfd]
    [eventpoll]
    [fanotify]
    [fscontext]
    [io_uring]
    [pidfd]
    [signalfd]
    [timerfd]
    [userfaultfd]

For the sake of consistency lets do the same for the landlock-ruleset anon
inode fd that comes with landlock. We did the same in
1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontext" [ver #2]")
for the new mount api.

Cc: Mickaël Salaün <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 security/landlock/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 32396962f04d..7e27ce394020 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -192,7 +192,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return PTR_ERR(ruleset);
 
 	/* Creates anonymous FD referring to the ruleset. */
-	ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
+	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 			ruleset, O_RDWR | O_CLOEXEC);
 	if (ruleset_fd < 0)
 		landlock_put_ruleset(ruleset);

base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
2.30.2

