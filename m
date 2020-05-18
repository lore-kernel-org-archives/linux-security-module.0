Return-Path: <SRS0=aSrS=7A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5EC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 18 May 2020 05:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8DC206D4
	for <linux-security-module@archiver.kernel.org>; Mon, 18 May 2020 05:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lSJ7AfkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgERFzG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 01:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERFzF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 01:55:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF53C05BD09
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so4318863pgn.5
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV8qUKmPjPOnYpALDdM3pvEx9LC9/D7hmFTEiazZWxM=;
        b=lSJ7AfkVTX/INK1Va1FrJ2kRFSu0fwD/uapRFZ9DRii0sw6g+NoXZWHhKtBbWpBcE5
         0cLn8ZEEnWXC5gy/csZhcuB1SVSxhXahc11dUroiH8AJmGVzNsYsk2QjmIm4N/cI1gfm
         StZfWJtCQfcN+Z1gF/FJEU19a8a30PEC1YQEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV8qUKmPjPOnYpALDdM3pvEx9LC9/D7hmFTEiazZWxM=;
        b=lSK8PYR55wo7iL41Vbj5eX0ICVW1gbNdeM2JkVNttL6P1tv5fJHMLlL22/jejWnAr1
         s3tUDiwcO/koQr4EOcwXbsPGxhzrfjQU4h3NI9sae0kzixKOO1d5XmFYfortWC/MEhI7
         SbbY1EqlyvDQzbjMbDy/iIPnc3SRQDpoUXfbUnBUvH3hSYSe2wnd4NQ7izsD0anSL6sN
         5O/0UJU2Qip3G35DwMZWUW9kXVBmMMtdBQa1+jRCjkeCwOEDLQ6l5Yedx1lSa2r6u//1
         Ksch6Uo6DeK9f2phkh3B2XraUyeWHAIzM2zRU8fDD9YpECO5RsY2CWgWI3DhR/WgCDzV
         z2GQ==
X-Gm-Message-State: AOAM533GHHoQDmPXeI5KFY0nubHJJ8lL0zlAai+av3LguxVVLIkzcF8T
        6+F1to2mtMVWxwdvDNbUPdGXQQ==
X-Google-Smtp-Source: ABdhPJylh2Csr4xNvbU/rUwWgmLGkcLWZZ4FMBQXDpqTwiArqXNcE09IOv1f3hXX5PJlXakQZnXDlg==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr15271317pfp.237.1589781304828;
        Sun, 17 May 2020 22:55:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x66sm7653474pfb.173.2020.05.17.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] fs: Include FMODE_EXEC when converting flags to f_mode
Date:   Sun, 17 May 2020 22:54:57 -0700
Message-Id: <20200518055457.12302-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518055457.12302-1-keescook@chromium.org>
References: <20200518055457.12302-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Include FMODE_EXEC when building the f_mode field, so that code can
actually test the correct field and values. Only three places actually
examine f_flags for FMODE_EXEC:

fs/open.c:      if (unlikely((f->f_mode & FMODE_EXEC) && !S_ISREG(inode->i_mode))) {
include/linux/fsnotify.h:               if (file->f_mode & FMODE_EXEC) {
include/linux/fsnotify.h:       if (file->f_mode & FMODE_EXEC)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I assume there must be some reason for FMODE_EXEC not being pulled into
f_mode, but I couldn't find it. I guess this is my attempt to either fix
an oversight or to learn by flames. :)
---
 fs/namei.c               | 4 ++--
 include/linux/fs.h       | 3 ++-
 include/linux/fsnotify.h | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6bb1b6624bad..362b1cc75f5c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3213,8 +3213,8 @@ static int do_open(struct nameidata *nd,
 		return -ENOTDIR;
 
 	/* Opening for execution requires a regular file on an exec mnt. */
-	if ((file->f_flags & FMODE_EXEC) && (!d_is_reg(nd->path.dentry) ||
-					     path_noexec(&nd->path)))
+	if ((file->f_mode & FMODE_EXEC) && (!d_is_reg(nd->path.dentry) ||
+					    path_noexec(&nd->path)))
 		return -EACCES;
 
 	do_truncate = false;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..8a2cabdcf531 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3545,10 +3545,11 @@ int __init get_filesystem_list(char *buf);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
 #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
+#define __SMUGGLED_FMODE_FLAGS	(__FMODE_EXEC | __FMODE_NONOTIFY)
 
 #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
 #define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
-					    (flag & __FMODE_NONOTIFY)))
+					    (flag & __SMUGGLED_FMODE_FLAGS)))
 
 static inline bool is_sxid(umode_t mode)
 {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 5ab28f6c7d26..86761ed4b434 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -90,7 +90,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
 	if (mask & MAY_OPEN) {
 		fsnotify_mask = FS_OPEN_PERM;
 
-		if (file->f_flags & __FMODE_EXEC) {
+		if (file->f_mode & FMODE_EXEC) {
 			ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
 
 			if (ret)
@@ -264,7 +264,7 @@ static inline void fsnotify_open(struct file *file)
 {
 	__u32 mask = FS_OPEN;
 
-	if (file->f_flags & __FMODE_EXEC)
+	if (file->f_mode & FMODE_EXEC)
 		mask |= FS_OPEN_EXEC;
 
 	fsnotify_file(file, mask);
-- 
2.20.1

