Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E535CC433E3
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B8622280
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGNNdA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:33:00 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48954 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNc7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 09:32:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3F-0007ZZ-1S; Tue, 14 Jul 2020 07:32:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3E-0006ij-1l; Tue, 14 Jul 2020 07:32:52 -0600
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
Date:   Tue, 14 Jul 2020 08:30:02 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87eepe6x7p.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL3E-0006ij-1l;;;mid=<87eepe6x7p.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Tp8T+D0arIMZhfUhTvULP2xEom+axBvw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 4/7] exec: Move bprm_mm_init into alloc_bprm
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Currently it is necessary for the usermode helper code and the code that
launches init to use set_fs so that pages coming from the kernel look like
they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument copying
from userspace needs to happen earlier.  Move the allocation and
initialization of bprm->mm into alloc_bprm so that the bprm->mm is
available early to store the new user stack into.  This is a prerequisite
for copying argv and envp into the new user stack early before ther rest of
exec.

To keep the things consistent the cleanup of bprm->mm is moved into
free_bprm.  So that bprm->mm will be cleaned up whenever bprm->mm is
allocated and free_bprm are called.

Moving bprm_mm_init earlier is safe as it does not depend on any files,
current->in_execve, current->fs->in_exec, bprm->unsafe, or the if the file
table is shared. (AKA bprm_mm_init does not depend on any of the code that
happens between alloc_bprm and where it was previously called.)

This moves bprm->mm cleanup after current->fs->in_exec is set to 0.  This
is safe because current->fs->in_exec is only used to preventy taking an
additional reference on the fs_struct.

This moves bprm->mm cleanup after current->in_execve is set to 0.  This is
safe because current->in_execve is only used by the lsms (apparmor and
tomoyou) and always for LSM specific functions, never for anything to do
with the mm.

This adds bprm->mm cleanup into the successful return path.  This is safe
because being on the successful return path implies that begin_new_exec
succeeded and set brpm->mm to NULL.  As bprm->mm is NULL bprm cleanup I am
moving into free_bprm will do nothing.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7e8af27dd199..afb168bf5e23 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1543,6 +1543,10 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 
 static void free_bprm(struct linux_binprm *bprm)
 {
+	if (bprm->mm) {
+		acct_arg_size(bprm, 0);
+		mmput(bprm->mm);
+	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
 		mutex_unlock(&current->signal->cred_guard_mutex);
@@ -1582,6 +1586,10 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 		bprm->filename = bprm->fdpath;
 	}
 	bprm->interp = bprm->filename;
+
+	retval = bprm_mm_init(bprm);
+	if (retval)
+		goto out_free;
 	return bprm;
 
 out_free:
@@ -1911,10 +1919,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
-	retval = bprm_mm_init(bprm);
-	if (retval)
-		goto out_unmark;
-
 	retval = prepare_arg_pages(bprm, argv, envp);
 	if (retval < 0)
 		goto out;
@@ -1962,10 +1966,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 */
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_sigsegv(SIGSEGV);
-	if (bprm->mm) {
-		acct_arg_size(bprm, 0);
-		mmput(bprm->mm);
-	}
 
 out_unmark:
 	current->fs->in_exec = 0;
-- 
2.25.0

