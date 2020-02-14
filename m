Return-Path: <SRS0=+399=4C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF9C35242
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 03:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA78217F4
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 03:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzDiW3Ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgBND1N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:27:13 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52099 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgBND1E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Feb 2020 22:27:04 -0500
Received: by mail-pg1-f201.google.com with SMTP id m18so5174533pgn.18
        for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2020 19:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X6QDL8gBNzuj73VK08XhwQEnv+QGpLeB+NeJs2q4QiA=;
        b=VzDiW3Ve5NoPwulQ9rACsUE+AdCGz6Tn8fOk5PdfosKG5duRJWKXexptHG1OP1BTd5
         Q8dLm9zHjbIffhKpoCxnc8ZoOwvhmWOVRYosD0TnaUqTZFbjLOanPLZJplOKFfmZZTDs
         iPtf/9w7LFn/S2gyhwropV9Dp93tZriB7rKaiVtVtMuJzRzaQQROMU2wBM4U9wX9W6oy
         ypNt/ZXRwHDutyyBxAC5ojUNhte+sGzh8OqpSF1VnDQfNls0eCeiY7VIM9Wss4vVsmmx
         fN0cjYxc9Cc76lZ7iIaxqTj61i4fKabo8qGxQWkHAFUHWS8sreT34/OEMKCLq6MVi9Am
         PKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X6QDL8gBNzuj73VK08XhwQEnv+QGpLeB+NeJs2q4QiA=;
        b=g1KibesS7Fk7Yj25Ub7vEMGTNelQzJgchdZwawryoinMz5KmjK3etqnWhA5qj+VXr/
         +c2gPAAkSRbKHM5J3d9ItCtqSwYcNyuwvMzyv41LhVimjHUSCe0PHxp5dtcGm+Sqx+m1
         cMpeyeu63UcfS9YD2LE32bzBoHzJPtVONbUfpJOsOI0wk1fucpC9UFGbv4FucEg/TQV8
         qRrzqKu4H4So6JkoOKcYRKyG97Zp48Ksx+jAjdK/JFOpvC7kT+noNgMxBY5FplQ9t16z
         HKfOLQ3iX8g/7js9LXtoTndsXi91t2bvQaG/sUG3oX3fKgSQwOGOzaxzm+XFqRjWHH3Z
         IICA==
X-Gm-Message-State: APjAAAVEJV/i8y27K4fsTvuqPY/nqWaArgrhp6SwJj3gU8m/FdIxo40w
        KzkM+dZiAQhlVcyCv517aZ3MVoEHVF8=
X-Google-Smtp-Source: APXvYqy7rl57xlhtajkcJd4uTbrfB+y+koGz7h3kInZETsBrWQXUhiqIBocYjR8QCz0K4KyBhGjBdPj4ijU=
X-Received: by 2002:a63:d041:: with SMTP id s1mr1169428pgi.363.1581650823887;
 Thu, 13 Feb 2020 19:27:03 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:26:35 -0800
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200214032635.75434-4-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 3/3] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
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
index 07b0f6e03849..06e92697aba4 100644
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
@@ -1020,8 +1022,10 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
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
 
@@ -1943,6 +1947,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	struct file *file;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1972,8 +1977,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
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
2.25.0.265.gbab2e86ba0-goog

