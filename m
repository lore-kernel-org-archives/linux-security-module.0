Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A62C433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 22:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB71C6108B
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 22:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhKJXCF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhKJXCC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Nov 2021 18:02:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45130C061767
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 14:59:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x3-20020a17090a1f8300b001a285b9f2cbso1796521pja.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=p1cUwGeUQEoJHf6xV2cI3doT5ZXMV67Wi7GVtUTV4SQ=;
        b=OUzrqS4gMaapy3MUtH5lYIQp3NZRI7ZMZWiBxjefaOKXav7J0oDqev/jUipr14Zp8M
         8p6OEgK5TTKJ1nYhAEb9krLQ2AgxnESBejstYj7qa/RlTQeIqfM7zHSmLZ9lGYNmRVFn
         eWjhAl0bvZ3rhYG8LxZn+F4lLJw/4ib0WdDpydux216zEXMhOuMohzCins0Y/K91L/8R
         GDNSJ8Asfbp63BEq/XySRIF9tuZbHlPGjcIjwZgOXe+Vqc58cbdqPw60cZj/vAZrLvzo
         L5JMaci9MrCophJR6GffVcY6lEuEFpnd2Q04gKB8O8JMF+5v2iwaReFBWCoMs6afCyP5
         IRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=p1cUwGeUQEoJHf6xV2cI3doT5ZXMV67Wi7GVtUTV4SQ=;
        b=YwIMDyRtaHzc6Gqy5XBH4MjN0D3i+micrlfOYLy0sf2ZaN5LFzouG7FOKZk6Z4M/3E
         EHVWBGhReaN9MM1Qb5mgH5otteX8r+Gx5ihdTQPk/UbgarH4M/g52+jdVZ95oSuHC4Pe
         pqYF6OgZuZ05N3LVcdxkyOI93nb7hrwHBu/L7KJsDnQ5Kya7jKbOFtqvOHJlCsWI8sIi
         7YhAZuCLmJnTsNbjkSr9GzWgN30ctwBKzbN7moZJJdEMRDtx6FKJHuYjf/qudJlKrhp9
         mPdIAPbPecuB4T0ylWS/sTZIyC//yikT8cd+H6QyIG/XUqIDuBwN4C+huTHCTsjhIDk6
         hlsg==
X-Gm-Message-State: AOAM531IoIo0/LO//VkO0br4SvFQGuYDAsEjt/lHRRjdDHXM4U/ov1uj
        4K3aptDPFd68gNoHyPzyFABZEig8eA==
X-Google-Smtp-Source: ABdhPJx8OM9lbwEHeee/6MmNE9uSeAsDUzkWj+Kh/NMxddkxbhM/xrWica1uv/CKrpAZRNhmuTexqemMjA==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a05:6a00:99e:b0:49f:f9e2:c116 with SMTP id
 u30-20020a056a00099e00b0049ff9e2c116mr2608493pfg.83.1636585153738; Wed, 10
 Nov 2021 14:59:13 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:59:09 -0800
Message-Id: <20211110225910.3268106-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 4.4 1/2] binder: use euid from cred instead of using task
From:   Todd Kjos <tkjos@google.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit 29bc22ac5e5bc63275e850f0c8fc549e3d0e306b upstream.

Save the 'struct cred' associated with a binder process
at initial open to avoid potential race conditions
when converting to an euid.

Set a transaction's sender_euid from the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Cc: stable@vger.kernel.org # 4.4+
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Suggested-by: Jann Horn <jannh@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Change-Id: I91922e7f359df5901749f1b09094c3c68d45aed4
---
 drivers/android/binder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 3bc5a7caccbf..0b27238b42c7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -303,6 +303,7 @@ struct binder_proc {
 	struct mm_struct *vma_vm_mm;
 	struct task_struct *tsk;
 	struct files_struct *files;
+	const struct cred *cred;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	void *buffer;
@@ -1493,7 +1494,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -3015,6 +3016,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 		return -ENOMEM;
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
+	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	init_waitqueue_head(&proc->wait);
 	proc->default_priority = task_nice(current);
@@ -3220,6 +3222,7 @@ static void binder_deferred_release(struct binder_proc *proc)
 	}
 
 	put_task_struct(proc->tsk);
+	put_cred(proc->cred);
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%s: %d threads %d, nodes %d (ref %d), refs %d, active transactions %d, buffers %d, pages %d\n",
-- 
2.34.0.rc0.344.g81b53c2807-goog

