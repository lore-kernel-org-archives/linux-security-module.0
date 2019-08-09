Return-Path: <SRS0=aXoK=WF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12308C433FF
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Aug 2019 15:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DA0208C4
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Aug 2019 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436655AbfHIPpT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:45:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49621 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436646AbfHIPpT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Aug 2019 11:45:19 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x79Fisw8025565;
        Sat, 10 Aug 2019 00:44:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Sat, 10 Aug 2019 00:44:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x79Fimus025479
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 10 Aug 2019 00:44:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH] LSM: Disable move_mount() syscall when TOMOYO or AppArmor is enabled.
Date:   Sat, 10 Aug 2019 00:44:38 +0900
Message-Id: <1565365478-6550-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <16ae946d-dbbe-9be9-9b22-866b3cd1cd7e@i-love.sakura.ne.jp>
References: <16ae946d-dbbe-9be9-9b22-866b3cd1cd7e@i-love.sakura.ne.jp>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 2db154b3ea8e14b0 ("vfs: syscall: Add move_mount(2) to move mounts
around") introduced security_move_mount() LSM hook, but we missed that
TOMOYO and AppArmor did not implement hooks for checking move_mount(2).
For pathname based access controls like TOMOYO and AppArmor, unchecked
mount manipulation is not acceptable. Therefore, until TOMOYO and AppArmor
implement hooks, in order to avoid unchecked mount manipulation, pretend
as if move_mount(2) is unavailable when either TOMOYO or AppArmor is
enabled.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: John Johansen <john.johansen@canonical.com>
Fixes: 2db154b3ea8e14b0 ("vfs: syscall: Add move_mount(2) to move mounts around")
Cc: stable@vger.kernel.org # 5.2
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/apparmor/lsm.c   | 1 +
 security/tomoyo/tomoyo.c  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cf..cd411b7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2142,4 +2142,10 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+static inline int no_move_mount(const struct path *from_path,
+				const struct path *to_path)
+{
+	return -ENOSYS;
+}
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ec3a928..5cdf63b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1158,6 +1158,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
 	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
+	LSM_HOOK_INIT(move_mount, no_move_mount),
 	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
 
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92e..be1b1a1 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -558,6 +558,7 @@ static void tomoyo_task_free(struct task_struct *task)
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
 	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
+	LSM_HOOK_INIT(move_mount, no_move_mount),
 	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
 	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
-- 
1.8.3.1
