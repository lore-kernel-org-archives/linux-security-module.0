Return-Path: <SRS0=fDLm=5R=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4FCC43331
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Apr 2020 21:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049B9206E9
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Apr 2020 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeWGGGhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbgDAVjW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:39:22 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37618 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733252AbgDAVjW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Apr 2020 17:39:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id n28so916701pfq.4
        for <linux-security-module@vger.kernel.org>; Wed, 01 Apr 2020 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DdrdrRerOMvkv7vzgvI3ttukeUZ2OpdhnLu+un2eV2s=;
        b=FeWGGGhwmXwPYJI7fgk1nXVyU38RCP6BF6eOwbkfauA5Lh/S0K7Nc0SIi0FDfzLZf/
         bBZtA01Z+mycAmiPQF6sdgjk5IWYb+EIHKaBqeFr9fpHlHKvNDviHMxgwnRIyxJ2QR+m
         FhGsIQS2Qu6FM71Bw7dEx5OsIbtQDambyY4fI9IepQU+Cs0Psa6YkBsLcX8FD8WIcBtp
         vBLKQP3cpYILo3x9L44bcB2+wn09ds8LLHXl7JYuY3kZHmAMRAlkc7Jl2jKOzPh1N4mo
         qnZvGI1i19BxSMYD89r0zKAZ5tBFZPiVCrcqrSEvreR+Eu5kKl7jbxfQkEj6DqoueZO0
         AaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DdrdrRerOMvkv7vzgvI3ttukeUZ2OpdhnLu+un2eV2s=;
        b=MrKVV0A2/qSoYAhxo8OQwVo660tQCqTZbCTomB3ehymtW8XC+hFg4jZgPhq0FxE+5q
         DVZmlQ1svSeR2PvgvNBuhx+fw+XsNpqJ4Q8qAaeHSOLasaRiBg65ECEWBaysKPdD9FVo
         7+m2SDpHmBTHBjoIKTHVbYgKJ/22MOPLoj8jSkYLmfm56M5CkIHaHXOoMm4aJH6XOyjg
         +DDvyQwBYfni/Xr7fenzruxEX1ngbu5D0F20VVDsvoRXDn3vv9V8N6ydnb9HV/HE1YOv
         WvuI7DBJhHeuBnni0/h8Ez6AkBCg7Qjpooli/5Y5l8iiUk1egAbvsH97puoXziU+Z+M/
         qcDw==
X-Gm-Message-State: AGi0PuaqZzWjGLjsMTsGkRfKfyB7DzuurlPdud+A6XVYOWQSAeMNtnWq
        pcseSc8vtbMAT/LpihQHSgqDM+ZYeuM=
X-Google-Smtp-Source: APiQypJjIzb/5kmrh3RqCS3HOgTi/GT8cY+ji3kV8XKRQ+4eFtBDnifNrAYKZFtkDdm/KNfMZ+0y3mX+CAA=
X-Received: by 2002:a17:90a:2147:: with SMTP id a65mr41318pje.176.1585777160964;
 Wed, 01 Apr 2020 14:39:20 -0700 (PDT)
Date:   Wed,  1 Apr 2020 14:39:03 -0700
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
Message-Id: <20200401213903.182112-4-dancol@google.com>
Mime-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v5 3/3] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 37df7c9eedb1..78ff5d898733 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -76,6 +76,8 @@ struct userfaultfd_ctx {
 	bool mmap_changing;
 	/* mm with one ore more vmas attached to this userfaultfd_ctx */
 	struct mm_struct *mm;
+	/* The inode that owns this context --- not a strong reference.  */
+	const struct inode *owner;
 };
 
 struct userfaultfd_fork_ctx {
@@ -1022,8 +1024,10 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 {
 	int fd;
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
-			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd_secure(
+		"[userfaultfd]", &userfaultfd_fops, new,
+		O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS),
+		ctx->owner);
 	if (fd < 0)
 		return fd;
 
@@ -1945,6 +1949,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	struct file *file;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1974,8 +1979,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	file = anon_inode_getfile_secure(
+		"[userfaultfd]", &userfaultfd_fops, ctx,
+		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+		NULL);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		goto out;
+	}
+
+	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		fput(file);
+		goto out;
+	}
+
+	ctx->owner = file_inode(file);
+	fd_install(fd, file);
+
+out:
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.26.0.rc2.310.g2932bb562d-goog

