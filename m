Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74785C433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A42078C
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594239485;
	bh=K5Lg+VMXda9w1UJGY2IYhWtxKTo+Uepce6z7xUkDdpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lqqyz4t5o0y+Ikl3Sdtq6wormn+iFpMnHqfpR2xpKKrLFXrAo/fTH3xihG4JXnqgB
	 9Obfuyx1YBeWcoEN7fy6UhlHuvLd09QbYiEGTvFL6xtHJ7utg6z8e9YyWRPo8r55U5
	 AcY/a7vFsCCGq3wn0lWskkN8yTAua2yqOtci8yX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGHUSE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgGHUSE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 16:18:04 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8C820672;
        Wed,  8 Jul 2020 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594239483;
        bh=K5Lg+VMXda9w1UJGY2IYhWtxKTo+Uepce6z7xUkDdpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqi2sw4jvjVXqJNUckduzP/bJGnZLr0IpJ8RS18LE8x4iSXUc6sPS/bF9Chpy4svu
         2wpfLl28X3KkiZOxjrragrPUpUnTRSVbf0zqBlYmFCr9tFtMyBSODjD9DUkwbW0sIq
         /mfMIbEfZBj2f5fvzvKHGuqxptv+gp/Ne7VWX0oA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+e6416dabb497a650da40@syzkaller.appspotmail.com
Subject: [PATCH] Smack: fix use-after-free in smk_write_relabel_self()
Date:   Wed,  8 Jul 2020 13:15:20 -0700
Message-Id: <20200708201520.140376-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0000000000000279c705a799ae31@google.com>
References: <0000000000000279c705a799ae31@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

smk_write_relabel_self() frees memory from the task's credentials with
no locking, which can easily cause a use-after-free because multiple
tasks can share the same credentials structure.

Fix this by using prepare_creds() and commit_creds() to correctly modify
the task's credentials.

Reproducer for "BUG: KASAN: use-after-free in smk_write_relabel_self":

	#include <fcntl.h>
	#include <pthread.h>
	#include <unistd.h>

	static void *thrproc(void *arg)
	{
		int fd = open("/sys/fs/smackfs/relabel-self", O_WRONLY);
		for (;;) write(fd, "foo", 3);
	}

	int main()
	{
		pthread_t t;
		pthread_create(&t, NULL, thrproc, NULL);
		thrproc(NULL);
	}

Reported-by: syzbot+e6416dabb497a650da40@syzkaller.appspotmail.com
Fixes: 38416e53936e ("Smack: limited capability for changing process label")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/smack/smackfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index c21b656b3263..840a192e9337 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2720,7 +2720,6 @@ static int smk_open_relabel_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = smack_cred(current_cred());
 	char *data;
 	int rc;
 	LIST_HEAD(list_tmp);
@@ -2745,11 +2744,21 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 	kfree(data);
 
 	if (!rc || (rc == -EINVAL && list_empty(&list_tmp))) {
+		struct cred *new;
+		struct task_smack *tsp;
+
+		new = prepare_creds();
+		if (!new) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		tsp = smack_cred(new);
 		smk_destroy_label_list(&tsp->smk_relabel);
 		list_splice(&list_tmp, &tsp->smk_relabel);
+		commit_creds(new);
 		return count;
 	}
-
+out:
 	smk_destroy_label_list(&list_tmp);
 	return rc;
 }
-- 
2.27.0

