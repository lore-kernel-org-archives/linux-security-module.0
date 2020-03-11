Return-Path: <SRS0=VYj3=44=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55CC10F27
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Mar 2020 09:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685E221655
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Mar 2020 09:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgCKJgb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKJga (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Mar 2020 05:36:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F20CAC5C;
        Wed, 11 Mar 2020 09:36:28 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH] tomoyo: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:36:27 +0100
Message-Id: <20200311093627.25409-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 security/tomoyo/audit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index 3c96e8402e94..aedc93959067 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -162,7 +162,7 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 
 	tomoyo_convert_time(ktime_get_real_seconds(), &stamp);
 
-	pos = snprintf(buffer, tomoyo_buffer_len - 1,
+	pos = scnprintf(buffer, tomoyo_buffer_len - 1,
 		       "#%04u/%02u/%02u %02u:%02u:%02u# profile=%u mode=%s granted=%s (global-pid=%u) task={ pid=%u ppid=%u uid=%u gid=%u euid=%u egid=%u suid=%u sgid=%u fsuid=%u fsgid=%u }",
 		       stamp.year, stamp.month, stamp.day, stamp.hour,
 		       stamp.min, stamp.sec, r->profile, tomoyo_mode[r->mode],
@@ -193,7 +193,7 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 		dev = stat->dev;
 		mode = stat->mode;
 		if (i & 1) {
-			pos += snprintf(buffer + pos,
+			pos += scnprintf(buffer + pos,
 					tomoyo_buffer_len - 1 - pos,
 					" path%u.parent={ uid=%u gid=%u ino=%lu perm=0%o }",
 					(i >> 1) + 1,
@@ -203,7 +203,7 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 					stat->mode & S_IALLUGO);
 			continue;
 		}
-		pos += snprintf(buffer + pos, tomoyo_buffer_len - 1 - pos,
+		pos += scnprintf(buffer + pos, tomoyo_buffer_len - 1 - pos,
 				" path%u={ uid=%u gid=%u ino=%lu major=%u minor=%u perm=0%o type=%s",
 				(i >> 1) + 1,
 				from_kuid(&init_user_ns, stat->uid),
@@ -213,12 +213,12 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 				mode & S_IALLUGO, tomoyo_filetype(mode));
 		if (S_ISCHR(mode) || S_ISBLK(mode)) {
 			dev = stat->rdev;
-			pos += snprintf(buffer + pos,
+			pos += scnprintf(buffer + pos,
 					tomoyo_buffer_len - 1 - pos,
 					" dev_major=%u dev_minor=%u",
 					MAJOR(dev), MINOR(dev));
 		}
-		pos += snprintf(buffer + pos, tomoyo_buffer_len - 1 - pos,
+		pos += scnprintf(buffer + pos, tomoyo_buffer_len - 1 - pos,
 				" }");
 	}
 no_obj_info:
@@ -276,17 +276,17 @@ char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
 	if (!buf)
 		goto out;
 	len--;
-	pos = snprintf(buf, len, "%s", header);
+	pos = scnprintf(buf, len, "%s", header);
 	if (realpath) {
 		struct linux_binprm *bprm = r->ee->bprm;
 
-		pos += snprintf(buf + pos, len - pos,
+		pos += scnprintf(buf + pos, len - pos,
 				" exec={ realpath=\"%s\" argc=%d envc=%d %s }",
 				realpath, bprm->argc, bprm->envc, bprm_info);
 	} else if (symlink)
-		pos += snprintf(buf + pos, len - pos, " symlink.target=\"%s\"",
+		pos += scnprintf(buf + pos, len - pos, " symlink.target=\"%s\"",
 				symlink);
-	pos += snprintf(buf + pos, len - pos, "\n%s\n", domainname);
+	pos += scnprintf(buf + pos, len - pos, "\n%s\n", domainname);
 	vsnprintf(buf + pos, len - pos, fmt, args);
 out:
 	kfree(realpath);
-- 
2.16.4

