Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3CC433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49F420870
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGBQsQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:48:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49616 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgGBQsH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:07 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2Na-0005oh-HP; Thu, 02 Jul 2020 10:48:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NZ-0007up-F8; Thu, 02 Jul 2020 10:48:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu,  2 Jul 2020 11:41:34 -0500
Message-Id: <20200702164140.4468-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NZ-0007up-F8;;;mid=<20200702164140.4468-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19I2zv1ELlhLqv1GXWB9t4A7j0C1O9/nC0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 10/16] exec: Remove do_execve_file
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Now that the last callser has been removed remove this code from exec.

For anyone thinking of resurrecing do_execve_file please note that
the code was buggy in several fundamental ways.

- It did not ensure the file it was passed was read-only and that
  deny_write_access had been called on it.  Which subtlely breaks
  invaniants in exec.

- The caller of do_execve_file was expected to hold and put a
  reference to the file, but an extra reference for use by exec was
  not taken so that when exec put it's reference to the file an
  underflow occured on the file reference count.

- The point of the interface was so that a pathname did not need to
  exist.  Which breaks pathname based LSMs.

Tetsuo Handa originally reported these issues[1].  While it was clear
that deny_write_access was missing the fundamental incompatibility
with the passed in O_RDWR filehandle was not immediately recognized.

All of these issues were fixed by modifying the usermode driver code
to have a path, so it did not need this hack.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
v1: https://lkml.kernel.org/r/871rm2f0hi.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87lfk54p0m.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 38 +++++++++-----------------------------
 include/linux/binfmts.h |  1 -
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..23dfbb820626 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1818,13 +1818,14 @@ static int exec_binprm(struct linux_binprm *bprm)
 /*
  * sys_execve() executes a new program.
  */
-static int __do_execve_file(int fd, struct filename *filename,
-			    struct user_arg_ptr argv,
-			    struct user_arg_ptr envp,
-			    int flags, struct file *file)
+static int do_execveat_common(int fd, struct filename *filename,
+			      struct user_arg_ptr argv,
+			      struct user_arg_ptr envp,
+			      int flags)
 {
 	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
+	struct file *file;
 	struct files_struct *displaced;
 	int retval;
 
@@ -1863,8 +1864,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	if (!file)
-		file = do_open_execat(fd, filename, flags);
+	file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_unmark;
@@ -1872,9 +1872,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	sched_exec();
 
 	bprm->file = file;
-	if (!filename) {
-		bprm->filename = "none";
-	} else if (fd == AT_FDCWD || filename->name[0] == '/') {
+	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
 		if (filename->name[0] == '\0')
@@ -1935,8 +1933,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	task_numa_free(current, false);
 	free_bprm(bprm);
 	kfree(pathbuf);
-	if (filename)
-		putname(filename);
+	putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
 	return retval;
@@ -1967,27 +1964,10 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (displaced)
 		reset_files_struct(displaced);
 out_ret:
-	if (filename)
-		putname(filename);
+	putname(filename);
 	return retval;
 }
 
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
-{
-	return __do_execve_file(fd, filename, argv, envp, flags, NULL);
-}
-
-int do_execve_file(struct file *file, void *__argv, void *__envp)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-
-	return __do_execve_file(AT_FDCWD, NULL, argv, envp, 0, file);
-}
-
 int do_execve(struct filename *filename,
 	const char __user *const __user *__argv,
 	const char __user *const __user *__envp)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 4a20b7517dd0..7c27d7b57871 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -141,6 +141,5 @@ extern int do_execveat(int, struct filename *,
 		       const char __user * const __user *,
 		       const char __user * const __user *,
 		       int);
-int do_execve_file(struct file *file, void *__argv, void *__envp);
 
 #endif /* _LINUX_BINFMTS_H */
-- 
2.25.0

