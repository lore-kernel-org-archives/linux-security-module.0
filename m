Return-Path: <SRS0=aSrS=7A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E942C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 18 May 2020 05:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50030206D4
	for <linux-security-module@archiver.kernel.org>; Mon, 18 May 2020 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kdpre7Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgERFzH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgERFzG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 01:55:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD3C05BD09
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f4so4308163pgi.10
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPKPZdLWYhVxpx5jrV/H8h0jtqWmPX7wH6A62qnOkus=;
        b=Kdpre7Exr/pMZGU8QiObZ4ZYPthvQzzf5UzH9ShzOMaqB7qV271cLqRWRlDhna2jMb
         DVm/UT04r0HB83+/3jJJjOf0vEXktU3iLJWXT+ixvegZsUIA5oFmKv2L6Qos/AG5/Kr4
         NUb7howiZnwR14Y8/i+ox9g0yzgIzizw7d/L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPKPZdLWYhVxpx5jrV/H8h0jtqWmPX7wH6A62qnOkus=;
        b=WeTq4dEYY+sRmKl2yL24kUvS4nS+frI2wvQpNwyu9lZgutgoqDGCVTpU76LsAafufL
         YQYf/G09f052+8VCewx5G/RDslBGbDmw3WgdVbXTc4vmLcd0xugDHZ6B4WSgqdMvs7SA
         rHpXrte+FH6uX/Ze4AzKz2r08c16YZNwX+/c/IfGRYiYGwEDNsJW6lLMYKEImRHnXPF6
         VOh7OLGBK+BjwLWbGfDFv4+auUbHK/qSwck74Y4HU6tkNEoKUZ2wts+rTP2E7MdtGm9l
         /cIQyej/3Q7Qx0tL3ZyGaMj04Wi9sNAlEyzuiM6FNqI+AuVTDc37FJ2k1rpT/K12F4uN
         uddA==
X-Gm-Message-State: AOAM532CAQfG2FMzD1Ku+Q9eTr6utyIX9u0z7ubaP0QWQ8lEazZpFWSZ
        tKNuSru6JyXpOcEC+f+mBk4m5Q==
X-Google-Smtp-Source: ABdhPJxhtS996OCWMkgpeKohWlQufYcB+/tWiUrVycuLTEmz6Rc2lRetBKELSdXVfqF4RuGByiW3Pw==
X-Received: by 2002:a63:2bd3:: with SMTP id r202mr13454738pgr.130.1589781306161;
        Sun, 17 May 2020 22:55:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm7490235pjl.32.2020.05.17.22.55.03
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
Subject: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
Date:   Sun, 17 May 2020 22:54:54 -0700
Message-Id: <20200518055457.12302-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518055457.12302-1-keescook@chromium.org>
References: <20200518055457.12302-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Change uselib(2)' S_ISREG() error return to EACCES instead of EINVAL so
the behavior matches execve(2), and the seemingly documented value.
The "not a regular file" failure mode of execve(2) is explicitly
documented[1], but it is not mentioned in uselib(2)[2] which does,
however, say that open(2) and mmap(2) errors may apply. The documentation
for open(2) does not include a "not a regular file" error[3], but mmap(2)
does[4], and it is EACCES.

[1] http://man7.org/linux/man-pages/man2/execve.2.html#ERRORS
[2] http://man7.org/linux/man-pages/man2/uselib.2.html#ERRORS
[3] http://man7.org/linux/man-pages/man2/open.2.html#ERRORS
[4] http://man7.org/linux/man-pages/man2/mmap.2.html#ERRORS

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..30735ce1dc0e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -139,11 +139,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
-	error = -EINVAL;
+	error = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
 
-	error = -EACCES;
 	if (path_noexec(&file->f_path))
 		goto exit;
 
-- 
2.20.1

