Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B7C433ED
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024EF22280
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGNNdX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:33:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37604 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgGNNdX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 09:33:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3h-0006vp-3b; Tue, 14 Jul 2020 07:33:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3f-0005XQ-Pc; Tue, 14 Jul 2020 07:33:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
Date:   Tue, 14 Jul 2020 08:30:30 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <878sfm6x6x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL3f-0005XQ-Pc;;;mid=<878sfm6x6x.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+OY/NvhT3MYjHsTJQkDJtTncWPgQJQ95w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 5/7] exec: Factor bprm_execve out of do_execve_common
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Currently it is necessary for the usermode helper code and the code
that launches init to use set_fs so that pages coming from the kernel
look like they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument
copying from userspace needs to happen earlier.  Factor bprm_execve
out of do_execve_common to separate out the copying of arguments
to the newe stack, and the rest of exec.

In separating bprm_execve from do_execve_common the copying
of the arguments onto the new stack happens earlier.

As the copying of the arguments does not depend any security hooks,
files, the file table, current->in_execve, current->fs->in_exec,
bprm->unsafe, or creds this is safe.

Likewise the security hook security_creds_for_exec does not depend upon
preventing the argument copying from happening.

In addition to making it possible to implement kernel_execve that
performs the copying differently, this separation of bprm_execve from
do_execve_common makes for a nice separation of responsibilities making
the exec code easier to navigate.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 108 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index afb168bf5e23..50508892fa71 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1856,44 +1856,16 @@ static int exec_binprm(struct linux_binprm *bprm)
 /*
  * sys_execve() executes a new program.
  */
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
+static int bprm_execve(struct linux_binprm *bprm,
+		       int fd, struct filename *filename, int flags)
 {
-	struct linux_binprm *bprm;
 	struct file *file;
 	struct files_struct *displaced;
 	int retval;
 
-	if (IS_ERR(filename))
-		return PTR_ERR(filename);
-
-	/*
-	 * We move the actual failure in case of RLIMIT_NPROC excess from
-	 * set*uid() to execve() because too many poorly written programs
-	 * don't check setuid() return code.  Here we additionally recheck
-	 * whether NPROC limit is still exceeded.
-	 */
-	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    atomic_read(&current_user()->processes) > rlimit(RLIMIT_NPROC)) {
-		retval = -EAGAIN;
-		goto out_ret;
-	}
-
-	/* We're below the limit (still or again), so we don't want to make
-	 * further execve() calls fail. */
-	current->flags &= ~PF_NPROC_EXCEEDED;
-
-	bprm = alloc_bprm(fd, filename);
-	if (IS_ERR(bprm)) {
-		retval = PTR_ERR(bprm);
-		goto out_ret;
-	}
-
 	retval = unshare_files(&displaced);
 	if (retval)
-		goto out_free;
+		return retval;
 
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
@@ -1919,28 +1891,11 @@ static int do_execveat_common(int fd, struct filename *filename,
 	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
-	retval = prepare_arg_pages(bprm, argv, envp);
-	if (retval < 0)
-		goto out;
-
 	/* Set the unchanging part of bprm->cred */
 	retval = security_bprm_creds_for_exec(bprm);
 	if (retval)
 		goto out;
 
-	retval = copy_string_kernel(bprm->filename, bprm);
-	if (retval < 0)
-		goto out;
-
-	bprm->exec = bprm->p;
-	retval = copy_strings(bprm->envc, envp, bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = copy_strings(bprm->argc, argv, bprm);
-	if (retval < 0)
-		goto out;
-
 	retval = exec_binprm(bprm);
 	if (retval < 0)
 		goto out;
@@ -1951,8 +1906,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
-	free_bprm(bprm);
-	putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
 	return retval;
@@ -1974,6 +1927,61 @@ static int do_execveat_common(int fd, struct filename *filename,
 out_files:
 	if (displaced)
 		reset_files_struct(displaced);
+
+	return retval;
+}
+
+static int do_execveat_common(int fd, struct filename *filename,
+			      struct user_arg_ptr argv,
+			      struct user_arg_ptr envp,
+			      int flags)
+{
+	struct linux_binprm *bprm;
+	int retval;
+
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
+
+	/*
+	 * We move the actual failure in case of RLIMIT_NPROC excess from
+	 * set*uid() to execve() because too many poorly written programs
+	 * don't check setuid() return code.  Here we additionally recheck
+	 * whether NPROC limit is still exceeded.
+	 */
+	if ((current->flags & PF_NPROC_EXCEEDED) &&
+	    atomic_read(&current_user()->processes) > rlimit(RLIMIT_NPROC)) {
+		retval = -EAGAIN;
+		goto out_ret;
+	}
+
+	/* We're below the limit (still or again), so we don't want to make
+	 * further execve() calls fail. */
+	current->flags &= ~PF_NPROC_EXCEEDED;
+
+	bprm = alloc_bprm(fd, filename);
+	if (IS_ERR(bprm)) {
+		retval = PTR_ERR(bprm);
+		goto out_ret;
+	}
+
+	retval = prepare_arg_pages(bprm, argv, envp);
+	if (retval < 0)
+		goto out_free;
+
+	retval = copy_string_kernel(bprm->filename, bprm);
+	if (retval < 0)
+		goto out_free;
+	bprm->exec = bprm->p;
+
+	retval = copy_strings(bprm->envc, envp, bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = copy_strings(bprm->argc, argv, bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = bprm_execve(bprm, fd, filename, flags);
 out_free:
 	free_bprm(bprm);
 
-- 
2.25.0

