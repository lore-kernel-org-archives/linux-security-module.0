Return-Path: <SRS0=AbGf=V5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B19DC19759
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 11:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13C20838
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 11:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfHALgU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:36:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61908 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbfHALgU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Aug 2019 07:36:20 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x71BaAkm090675;
        Thu, 1 Aug 2019 20:36:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 01 Aug 2019 20:36:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x71BZxCO090624
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 20:36:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Takeshi Misawa <jeliantsurux@gmail.com>
Subject: [PATCH] tomoyo: Use error code from kern_path() rather than -ENOENT.
Date:   Thu,  1 Aug 2019 20:35:55 +0900
Message-Id: <1564659355-12826-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20190801030323.GA1958@DESKTOP>
References: <20190801030323.GA1958@DESKTOP>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Takeshi Misawa has pointed out that tomoyo_find_next_domain() is returning
-ENOENT when tomoyo_realpath_nofollow() failed [1]. That error code was
chosen based on an assumption that when tomoyo_realpath_nofollow() fails,
the cause of failure is kern_path() failure due to a race window that
the pathname used for do_open_execat() from __do_execve_file() was removed
before tomoyo_find_next_domain() is called.

Since tomoyo_realpath_nofollow() is called by tomoyo_find_next_domain()
only, and __do_execve_file() makes sure that bprm->filename != NULL, let's
inline tomoyo_realpath_nofollow() into tomoyo_find_next_domain().

It seems that tomoyo_realpath_nofollow() is currently broken by
commit 449325b52b7a6208 ("umh: introduce fork_usermode_blob() helper")
when do_execve_file() is used. To fix it, we will need to know whether
do_open_execat() was called before tomoyo_find_next_domain() is called.
To fix it in a more accurate and race-free way, we will need to calculate
both LOOKUP_FOLLOW pathname and !LOOKUP_FOLLOW pathname at the same time.

[1] https://lkml.kernel.org/r/20190801030323.GA1958@DESKTOP

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Takeshi Misawa <jeliantsurux@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 security/tomoyo/common.h   |  1 -
 security/tomoyo/domain.c   | 18 ++++++++++++++----
 security/tomoyo/realpath.c | 20 --------------------
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 050473df5809..58b51a21cf9c 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -957,7 +957,6 @@ char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
 		      va_list args);
 char *tomoyo_read_token(struct tomoyo_acl_param *param);
 char *tomoyo_realpath_from_path(const struct path *path);
-char *tomoyo_realpath_nofollow(const char *pathname);
 const char *tomoyo_get_exe(void);
 const char *tomoyo_yesno(const unsigned int value);
 const struct tomoyo_path_info *tomoyo_compare_name_union
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 8526a0a74023..5cd06bfd46c7 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -721,10 +721,20 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	ee->r.obj = &ee->obj;
 	ee->obj.path1 = bprm->file->f_path;
 	/* Get symlink's pathname of program. */
-	retval = -ENOENT;
-	exename.name = tomoyo_realpath_nofollow(original_name);
-	if (!exename.name)
-		goto out;
+	{
+		struct path path;
+		int ret = kern_path(original_name, 0, &path);
+
+		if (ret) {
+			retval = ret;
+			exename.name = NULL;
+			goto out;
+		}
+		exename.name = tomoyo_realpath_from_path(&path);
+		path_put(&path);
+		if (!exename.name) /* retval was initialized with -ENONEM */
+			goto out;
+	}
 	tomoyo_fill_path_info(&exename);
 retry:
 	/* Check 'aggregator' directive. */
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index e7832448d721..70d456348e1c 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -321,23 +321,3 @@ char *tomoyo_realpath_from_path(const struct path *path)
 		tomoyo_warn_oom(__func__);
 	return name;
 }
-
-/**
- * tomoyo_realpath_nofollow - Get realpath of a pathname.
- *
- * @pathname: The pathname to solve.
- *
- * Returns the realpath of @pathname on success, NULL otherwise.
- */
-char *tomoyo_realpath_nofollow(const char *pathname)
-{
-	struct path path;
-
-	if (pathname && kern_path(pathname, 0, &path) == 0) {
-		char *buf = tomoyo_realpath_from_path(&path);
-
-		path_put(&path);
-		return buf;
-	}
-	return NULL;
-}
-- 
2.16.5

