Return-Path: <SRS0=PbfF=BR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83026C433E0
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Aug 2020 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507E32224D
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Aug 2020 22:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bF2xJUIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHGWue (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHGWu1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Aug 2020 18:50:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F6AC061757
        for <linux-security-module@vger.kernel.org>; Fri,  7 Aug 2020 15:50:27 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mu14so2643284pjb.7
        for <linux-security-module@vger.kernel.org>; Fri, 07 Aug 2020 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3/owlDjeUst/VUedKaOlenkrtf0ajk2+sX2cL13a7vo=;
        b=bF2xJUIl3GYrWMv7joU4DxGYXczwSg+carS7d5v9vBaVDCqwtrswyCeuZi2vDCcn1I
         VfxkmmJsSr5GAGY4Io7yRwj1aQEOarVNDrLpe4iRBtm5RPlnT84dETARkWpF+dQaQCMN
         5T8vnTYMrgJL9sC33YSONqohFwtuf6X7xukqpNxQUOfDrs0fBb4hpKYXBNg6umB1IKjS
         14csky7oxpKje8br+jEYf2jnlTjk8+dToAc31ep9at/aQX8aw1chNbLU28aszzE1DtuZ
         T2j+ZD8fJ4FjC/jVIcjQeG+sTNq4rzL6UtFg4Ii1dyaOWZND0gaDs+vw6ScUJlHmewbQ
         m5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3/owlDjeUst/VUedKaOlenkrtf0ajk2+sX2cL13a7vo=;
        b=jbM+ag9UfbsIFUmpON6HDUkuUQUt9MXAdAGrNJTx1bzgcgXmhwg1PadaBVEUaE4XT6
         zG/MG7GVAavhk1SNZdQH6Zygcouz/xHY6FELWtRg6M02IkbaflpYLIs9iXxRQWfr2PU5
         OvVRkVqrt6oEuVl23Dvc/iuR45AZmICYj5tiTRpYHVcAi7OrUxQRUVdqrD+tqkN7Bt4Z
         z77zP6rFxSkveag9lk4C3z168UtaRwCzKSx+/JiSvJKoKsFDBobw0KTladX6+OFAxQQz
         0H3gDXyXBVQBl0ZRlQ0Cu4i8Y5MQ5/ebT2J2nc9UUA4aIZagjRDBnKo0bVAVIVRemB/E
         V3/Q==
X-Gm-Message-State: AOAM532iyMysRDCh3T8bypkF6ZlanAyhLWyf+J4Y0dKCXRBc3oUAOX4n
        pw2Qz31vztGP02nGv47pILQlcbmykjZLhGtu6Q==
X-Google-Smtp-Source: ABdhPJzxKLo54fvW6D1u9bvhmmERMULl1i/OzpJh+BMKFG/junntW18h4IfaT+t8b+Ofl6BrLf0D1SQ/CC6dzKxqyw==
X-Received: by 2002:a17:90b:3807:: with SMTP id mq7mr16155471pjb.13.1596840626464;
 Fri, 07 Aug 2020 15:50:26 -0700 (PDT)
Date:   Fri,  7 Aug 2020 15:49:41 -0700
In-Reply-To: <20200807224941.3440722-1-lokeshgidra@google.com>
Message-Id: <20200807224941.3440722-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200807224941.3440722-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v6 3/3] Wire UFFD up to SELinux
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Daniel Colascione <dancol@google.com>

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>

[Remove owner inode from userfaultfd_ctx]
[Use anon_inode_getfd_secure() instead of anon_inode_getfile_secure()
 in userfaultfd syscall]
[Use inode of file in userfaultfd_read() in resolve_userfault_fork()]

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6e264dded46e..23c8618ebe35 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -978,14 +978,16 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations userfaultfd_fops;
 
-static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
-				  struct userfaultfd_ctx *new,
+static int resolve_userfault_fork(struct userfaultfd_ctx *new,
+				  struct inode *inode,
 				  struct uffd_msg *msg)
 {
 	int fd;
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
-			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure(
+		"[userfaultfd]", &userfaultfd_fops, new,
+		O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS),
+		inode);
 	if (fd < 0)
 		return fd;
 
@@ -995,7 +997,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 }
 
 static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
-				    struct uffd_msg *msg)
+				    struct uffd_msg *msg, struct inode *inode)
 {
 	ssize_t ret;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1106,7 +1108,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	spin_unlock_irq(&ctx->fd_wqh.lock);
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
-		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
+		ret = resolve_userfault_fork(fork_nctx, inode, msg);
 		spin_lock_irq(&ctx->event_wqh.lock);
 		if (!list_empty(&fork_event)) {
 			/*
@@ -1166,6 +1168,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
 	int no_wait = file->f_flags & O_NONBLOCK;
+	struct inode *inode = file_inode(file);
 
 	if (ctx->state == UFFD_STATE_WAIT_API)
 		return -EINVAL;
@@ -1173,7 +1176,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	for (;;) {
 		if (count < sizeof(msg))
 			return ret ? ret : -EINVAL;
-		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg);
+		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
 		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
@@ -1995,8 +1998,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure("[userfaultfd]",
+		&userfaultfd_fops, ctx,
+		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+		NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.28.0.236.gb10cc79966-goog

