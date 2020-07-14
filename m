Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F84C433E4
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C596224D1
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGNNb5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:31:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48594 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNb4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 09:31:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL2J-0007Tv-Ik; Tue, 14 Jul 2020 07:31:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL2I-0005L6-SL; Tue, 14 Jul 2020 07:31:55 -0600
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
Date:   Tue, 14 Jul 2020 08:29:05 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87pn8y6x9a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL2I-0005L6-SL;;;mid=<87pn8y6x9a.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SB46uFkLNkWWJuV08LWp9w9461KO6n04=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 2/7] exec: Factor out alloc_bprm
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Currently it is necessary for the usermode helper code and the code
that launches init to use set_fs so that pages coming from the kernel
look like they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument
copying from userspace needs to happen earlier.  Move the allocation
of the bprm into it's own function (alloc_bprm) and move the call of
alloc_bprm before unshare_files so that bprm can ultimately be
allocated, the arguments can be placed on the new stack, and then the
bprm can be passed into the core of exec.

Neither the allocation of struct binprm nor the unsharing depend upon each
other so swapping the order in which they are called is trivially safe.

To keep things consistent the order of cleanup at the end of
do_execve_common swapped to match the order of initialization.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 23dfbb820626..526156d6461d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1560,6 +1560,14 @@ static void free_bprm(struct linux_binprm *bprm)
 	kfree(bprm);
 }
 
+static struct linux_binprm *alloc_bprm(void)
+{
+	struct linux_binprm *bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
+	if (!bprm)
+		return ERR_PTR(-ENOMEM);
+	return bprm;
+}
+
 int bprm_change_interp(const char *interp, struct linux_binprm *bprm)
 {
 	/* If a binfmt changed the interp, free it first. */
@@ -1848,18 +1856,19 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	retval = unshare_files(&displaced);
-	if (retval)
+	bprm = alloc_bprm();
+	if (IS_ERR(bprm)) {
+		retval = PTR_ERR(bprm);
 		goto out_ret;
+	}
 
-	retval = -ENOMEM;
-	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
-	if (!bprm)
-		goto out_files;
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out_free;
 
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
-		goto out_free;
+		goto out_files;
 
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
@@ -1956,13 +1965,13 @@ static int do_execveat_common(int fd, struct filename *filename,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
+out_files:
+	if (displaced)
+		reset_files_struct(displaced);
 out_free:
 	free_bprm(bprm);
 	kfree(pathbuf);
 
-out_files:
-	if (displaced)
-		reset_files_struct(displaced);
 out_ret:
 	putname(filename);
 	return retval;
-- 
2.25.0

