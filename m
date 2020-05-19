Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69410C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C1120657
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgESAgA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 20:36:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59490 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgESAgA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 20:36:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqEh-0002js-2Y; Mon, 18 May 2020 18:35:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqEg-0004V7-2k; Mon, 18 May 2020 18:35:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 18 May 2020 19:32:18 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqEg-0004V7-2k;;;mid=<87d070zrvx.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9roiBo9Zi8ekR3M2JucjX1nO39mpsBoU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 5/8] exec: Move the call of prepare_binprm into search_binary_handler
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The code in prepare_binary_handler needs to be run every time
search_binary_handler is called so move the call into search_binary_handler
itself to make the code simpler and easier to understand.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/binfmt_loader.c |  3 ---
 fs/binfmt_em86.c                  |  4 ----
 fs/binfmt_misc.c                  |  4 ----
 fs/binfmt_script.c                |  3 ---
 fs/exec.c                         | 12 +++++-------
 include/linux/binfmts.h           |  1 -
 6 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/kernel/binfmt_loader.c b/arch/alpha/kernel/binfmt_loader.c
index a8d0d6e06526..d712ba51d15a 100644
--- a/arch/alpha/kernel/binfmt_loader.c
+++ b/arch/alpha/kernel/binfmt_loader.c
@@ -35,9 +35,6 @@ static int load_binary(struct linux_binprm *bprm)
 
 	bprm->file = file;
 	bprm->loader = loader;
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		return retval;
 	return search_binary_handler(bprm);
 }
 
diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index 466497860c62..cedde2341ade 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -91,10 +91,6 @@ static int load_em86(struct linux_binprm *bprm)
 
 	bprm->file = file;
 
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		return retval;
-
 	return search_binary_handler(bprm);
 }
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 264829745d6f..50a73afdf9b7 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -221,10 +221,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
 		bprm->preserve_creds = 1;
 
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		goto error;
-
 	retval = search_binary_handler(bprm);
 	if (retval < 0)
 		goto error;
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index e9e6a6f4a35f..8d718d8fd0fe 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -143,9 +143,6 @@ static int load_script(struct linux_binprm *bprm)
 		return PTR_ERR(file);
 
 	bprm->file = file;
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		return retval;
 	return search_binary_handler(bprm);
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 028e0e323af5..5fc458460e44 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1629,7 +1629,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
  *
  * This may be called multiple times for binary chains (scripts for example).
  */
-int prepare_binprm(struct linux_binprm *bprm)
+static int prepare_binprm(struct linux_binprm *bprm)
 {
 	loff_t pos = 0;
 
@@ -1650,8 +1650,6 @@ int prepare_binprm(struct linux_binprm *bprm)
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
 }
 
-EXPORT_SYMBOL(prepare_binprm);
-
 /*
  * Arguments are '\0' separated strings found at the location bprm->p
  * points to; chop off the first by relocating brpm->p to right after
@@ -1707,6 +1705,10 @@ int search_binary_handler(struct linux_binprm *bprm)
 	if (bprm->recursion_depth > 5)
 		return -ELOOP;
 
+	retval = prepare_binprm(bprm);
+	if (retval < 0)
+		return retval;
+
 	retval = security_bprm_check(bprm);
 	if (retval)
 		return retval;
@@ -1864,10 +1866,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval)
 		goto out;
 
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		goto out;
-
 	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0)
 		goto out;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index dbb5614d62a2..8c7779d6bf19 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -116,7 +116,6 @@ static inline void insert_binfmt(struct linux_binfmt *fmt)
 
 extern void unregister_binfmt(struct linux_binfmt *);
 
-extern int prepare_binprm(struct linux_binprm *);
 extern int __must_check remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *);
 extern int begin_new_exec(struct linux_binprm * bprm);
-- 
2.25.0

