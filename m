Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29501C433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0503B22280
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGNNcu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:32:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48882 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNct (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 09:32:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL2q-0007X5-Qj; Tue, 14 Jul 2020 07:32:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL2n-0005PK-GW; Tue, 14 Jul 2020 07:32:26 -0600
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
Date:   Tue, 14 Jul 2020 08:29:36 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87k0z66x8f.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL2n-0005PK-GW;;;mid=<87k0z66x8f.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/bTuLU7Jd4S+t/5VVrYMEsOQfOiE6Q7Uk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/7] exec: Move initialization of bprm->filename into alloc_bprm
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Currently it is necessary for the usermode helper code and the code
that launches init to use set_fs so that pages coming from the kernel
look like they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument
copying from userspace needs to happen earlier.  Move the computation
of bprm->filename and possible allocation of a name in the case
of execveat into alloc_bprm to make that possible.

The exectuable name, the arguments, and the environment are
copied into the new usermode stack which is stored in bprm
until exec passes the point of no return.

As the executable name is copied first onto the usermode stack
it needs to be known.  As there are no dependencies to computing
the executable name, compute it early in alloc_bprm.

As an implementation detail if the filename needs to be generated
because it embeds a file descriptor store that filename in a new field
bprm->fdpath, and free it in free_bprm.  Previously this was done in
an independent variable pathbuf.  I have renamed pathbuf fdpath
because fdpath is more suggestive of what kind of path is in the
variable.  I moved fdpath into struct linux_binprm because it is
tightly tied to the other variables in struct linux_binprm, and as
such is needed to allow the call alloc_binprm to move.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 61 ++++++++++++++++++++++-------------------
 include/linux/binfmts.h |  1 +
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 526156d6461d..7e8af27dd199 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1557,15 +1557,37 @@ static void free_bprm(struct linux_binprm *bprm)
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
+	kfree(bprm->fdpath);
 	kfree(bprm);
 }
 
-static struct linux_binprm *alloc_bprm(void)
+static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 {
 	struct linux_binprm *bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
+	int retval = -ENOMEM;
 	if (!bprm)
-		return ERR_PTR(-ENOMEM);
+		goto out;
+
+	if (fd == AT_FDCWD || filename->name[0] == '/') {
+		bprm->filename = filename->name;
+	} else {
+		if (filename->name[0] == '\0')
+			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
+		else
+			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
+						  fd, filename->name);
+		if (!bprm->fdpath)
+			goto out_free;
+
+		bprm->filename = bprm->fdpath;
+	}
+	bprm->interp = bprm->filename;
 	return bprm;
+
+out_free:
+	free_bprm(bprm);
+out:
+	return ERR_PTR(retval);
 }
 
 int bprm_change_interp(const char *interp, struct linux_binprm *bprm)
@@ -1831,7 +1853,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 			      struct user_arg_ptr envp,
 			      int flags)
 {
-	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
 	struct file *file;
 	struct files_struct *displaced;
@@ -1856,7 +1877,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	bprm = alloc_bprm();
+	bprm = alloc_bprm(fd, filename);
 	if (IS_ERR(bprm)) {
 		retval = PTR_ERR(bprm);
 		goto out_ret;
@@ -1881,28 +1902,14 @@ static int do_execveat_common(int fd, struct filename *filename,
 	sched_exec();
 
 	bprm->file = file;
-	if (fd == AT_FDCWD || filename->name[0] == '/') {
-		bprm->filename = filename->name;
-	} else {
-		if (filename->name[0] == '\0')
-			pathbuf = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
-		else
-			pathbuf = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
-					    fd, filename->name);
-		if (!pathbuf) {
-			retval = -ENOMEM;
-			goto out_unmark;
-		}
-		/*
-		 * Record that a name derived from an O_CLOEXEC fd will be
-		 * inaccessible after exec. Relies on having exclusive access to
-		 * current->files (due to unshare_files above).
-		 */
-		if (close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
-			bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
-		bprm->filename = pathbuf;
-	}
-	bprm->interp = bprm->filename;
+	/*
+	 * Record that a name derived from an O_CLOEXEC fd will be
+	 * inaccessible after exec. Relies on having exclusive access to
+	 * current->files (due to unshare_files above).
+	 */
+	if (bprm->fdpath &&
+	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
+		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
 	retval = bprm_mm_init(bprm);
 	if (retval)
@@ -1941,7 +1948,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	free_bprm(bprm);
-	kfree(pathbuf);
 	putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
@@ -1970,7 +1976,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 		reset_files_struct(displaced);
 out_free:
 	free_bprm(bprm);
-	kfree(pathbuf);
 
 out_ret:
 	putname(filename);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index eb5cb8df5485..8e9e1b0c8eb8 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -56,6 +56,7 @@ struct linux_binprm {
 	const char *interp;	/* Name of the binary really executed. Most
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
+	const char *fdpath;	/* generated filename for execveat */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
 	unsigned long loader, exec;
-- 
2.25.0

