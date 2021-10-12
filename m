Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E2C43219
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2429D604DC
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 16:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJLQ61 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhJLQ6Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 12:58:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D805C061746
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 09:56:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x15-20020a056902102f00b005ba71cd7dbfso17721305ybt.8
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mwae8Ejzsmbhdp150195SP11OIoOnZHvR8wRYQamjXg=;
        b=RZ/VZBHl1HvOJwMNfn/wyOhkRQ7x7ZEERi3vIgiH1zWADtTrwOSu3msb+uBQ5z/+zo
         3SRgiJvV5Bx+HU9qQk24SooKq+aeGWwJss5ZPBHS18wTHIs5bVhCRZepq/qdObdMRKhb
         L1wunp82irR9mtPFWffaUV6KsDXII0nGdD20NleN0KqbzWVC0208pZOT4d+D6JotJ37o
         UPIzghFGIDn7oYQl0tpPAzhBjUOcRPP9Kw9hiNXU/AnPuXDgVwQKx2bRncxoSta3kYEd
         Vx9wTcnVuNVEYNH+hD6dM+xkjcqPgRqRdXv15pXgw/bjcpW3pwF2Tj7rlUe6rXYhVq4a
         10uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mwae8Ejzsmbhdp150195SP11OIoOnZHvR8wRYQamjXg=;
        b=xkhRRhrYQe9/Gb/BpJfX7hRtXrK60G6HZu+XXFs7JhjudY8Ou4nwvoyqbood9sb5H1
         T6u433nCbU7tLFzoePQs5RjO8g5tbm6xxJbcknclRSUgtVNQ0SHKLlk0XWERPhKiJNJX
         35fGZU2mAfAarMXQdE4Y7gsVJwXMgvnpAe/jjQ52z4Ofh1nmZnWDzcIzrkaREOlsHHO+
         43gGvTMj4Q0WTqhA0cT7BeLsVaskuHPu0zV9ubD/23UiDbA3sonUGvG876cPnxFFP31i
         cJC6OrY4FX/jhAjryu4l6VdPiKAjHMmOTYUVnAMyZdfAU9xAeQHKkXoFH0QPyWgMz0Lu
         EnTg==
X-Gm-Message-State: AOAM530mM/KsOm2A5XtMDESVzYpJuJvE2biNPx1ipnrfIvj9ScAt9J7I
        LP2gNryA4A1dr3REFwOPDjHRWpfY6g==
X-Google-Smtp-Source: ABdhPJzyTWT16jc0uAEpzHgNTjY8P3Cae43hy5GOBsxaWT1o4sIRwdkN+OAgexPrM9Wj0PqxVQ4ruuYa6g==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:39c7:8168:c0b2:b46e])
 (user=tkjos job=sendgmr) by 2002:a25:d94d:: with SMTP id q74mr29250835ybg.196.1634057781619;
 Tue, 12 Oct 2021 09:56:21 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:56:12 -0700
In-Reply-To: <20211012165614.2873369-1-tkjos@google.com>
Message-Id: <20211012165614.2873369-2-tkjos@google.com>
Mime-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v5 1/3] binder: use euid from cred instead of using task
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Save the 'struct cred' associated with a binder process
at initial open to avoid potential race conditions
when converting to an euid.

Set a transaction's sender_euid from the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Suggested-by: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org # 4.4+
---
v3: added this patch to series (as 3/3)
v5:
- combined with saving of 'struct cred' during binder_open()
- reordered to 1/1 as suggested by Stephen Smalley

 drivers/android/binder.c          | 4 +++-
 drivers/android/binder_internal.h | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9edacc8b9768..a396015e874a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2711,7 +2711,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -4353,6 +4353,7 @@ static void binder_free_proc(struct binder_proc *proc)
 	}
 	binder_alloc_deferred_release(&proc->alloc);
 	put_task_struct(proc->tsk);
+	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
 	kfree(proc);
 }
@@ -5055,6 +5056,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	spin_lock_init(&proc->outer_lock);
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
+	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	init_waitqueue_head(&proc->freeze_wait);
 	proc->default_priority = task_nice(current);
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 402c4d4362a8..d6b6b8cb7346 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -364,6 +364,9 @@ struct binder_ref {
  *                        (invariant after initialized)
  * @tsk                   task_struct for group_leader of process
  *                        (invariant after initialized)
+ * @cred                  struct cred associated with the `struct file`
+ *                        in binder_open()
+ *                        (invariant after initialized)
  * @deferred_work_node:   element for binder_deferred_list
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
@@ -426,6 +429,7 @@ struct binder_proc {
 	struct list_head waiting_threads;
 	int pid;
 	struct task_struct *tsk;
+	const struct cred *cred;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	int outstanding_txns;
-- 
2.33.0.882.g93a45727a2-goog

