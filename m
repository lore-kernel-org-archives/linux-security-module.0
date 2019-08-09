Return-Path: <SRS0=aXoK=WF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7ABC31E40
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Aug 2019 15:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6540D2089E
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Aug 2019 15:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436723AbfHIPwN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:52:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54021 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436646AbfHIPwN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Aug 2019 11:52:13 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x79Fpqlc029853;
        Sat, 10 Aug 2019 00:51:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 10 Aug 2019 00:51:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x79FpmiY029822
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 10 Aug 2019 00:51:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
Subject: [PATCH v2] tomoyo: Don't check open/getattr permission on sockets.
Date:   Sat, 10 Aug 2019 00:51:43 +0900
Message-Id: <1565365903-7239-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <alpine.LRH.2.21.1907061949040.2662@namei.org>
References: <alpine.LRH.2.21.1907061949040.2662@namei.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot is reporting that use of SOCKET_I()->sk from open() can result in
use after free problem [1], for socket's inode is still reachable via
/proc/pid/fd/n despite destruction of SOCKET_I()->sk already completed.

But there is no point with calling security_file_open() on sockets
because open("/proc/pid/fd/n", !O_PATH) on sockets fails with -ENXIO.

There is some point with calling security_inode_getattr() on sockets
because stat("/proc/pid/fd/n") and fstat(open("/proc/pid/fd/n", O_PATH))
are valid. If we want to access "struct sock"->sk_{family,type,protocol}
fields, we will need to use security_socket_post_create() hook and
security_inode_free() hook in order to remember these fields because
security_sk_free() hook is called before the inode is destructed. But
since information which can be protected by checking
security_inode_getattr() on sockets is trivial, let's not be bothered by
"struct inode"->i_security management.

There is point with calling security_file_ioctl() on sockets. Since
ioctl(open("/proc/pid/fd/n", O_PATH)) is invalid, security_file_ioctl()
on sockets should remain safe.

[1] https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
---
 security/tomoyo/tomoyo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92e..8ea3f5d 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -126,6 +126,9 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
  */
 static int tomoyo_inode_getattr(const struct path *path)
 {
+	/* It is not safe to call tomoyo_get_socket_name(). */
+	if (S_ISSOCK(d_inode(path->dentry)->i_mode))
+		return 0;
 	return tomoyo_path_perm(TOMOYO_TYPE_GETATTR, path, NULL);
 }
 
@@ -316,6 +319,9 @@ static int tomoyo_file_open(struct file *f)
 	/* Don't check read permission here if called from do_execve(). */
 	if (current->in_execve)
 		return 0;
+	/* Sockets can't be opened by open(). */
+	if (S_ISSOCK(file_inode(f)->i_mode))
+		return 0;
 	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
 					    f->f_flags);
 }
-- 
1.8.3.1
