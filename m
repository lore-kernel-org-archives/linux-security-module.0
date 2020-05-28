Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1E9C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D260620888
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404643AbgE1PqC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:46:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47054 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1PqB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:46:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKjH-0003Zc-Mm; Thu, 28 May 2020 09:45:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKjF-0006q8-Rr; Thu, 28 May 2020 09:45:59 -0600
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
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 28 May 2020 10:42:06 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <878shcyskx.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKjF-0006q8-Rr;;;mid=<878shcyskx.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Bo5/YnCMJYnYnBAcEfoRXNYXUapdUns8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 02/11] exec: Introduce active_per_clear the per file version of per_clear
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


When the credentials have been recomputed per file the per_clear
status has not been recomputed.  Update the per file calcuations to
recompute per_clear on a per file basis in a separate variable and to
combine that variable into the final per_clear value.

This makes which personality bits are clear not depend on the
permissions of shell scripts with interpreters, but instead only on
the final bprm->file that bprm_fill_uid and
security_bprm_repopulate_creds are called upon.

History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                 | 7 ++++---
 include/linux/binfmts.h   | 3 +++
 include/linux/lsm_hooks.h | 2 +-
 security/commoncap.c      | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 51fab62b9fca..221d12dcaa3e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1354,7 +1354,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
-	if (bprm->per_clear)
+	if (bprm->per_clear || bprm->active_per_clear)
 		me->personality &= ~PER_CLEAR_ON_SETID;
 
 	/*
@@ -1629,12 +1629,12 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		return;
 
 	if (mode & S_ISUID) {
-		bprm->per_clear = 1;
+		bprm->active_per_clear = 1;
 		bprm->cred->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-		bprm->per_clear = 1;
+		bprm->active_per_clear = 1;
 		bprm->cred->egid = gid;
 	}
 }
@@ -1655,6 +1655,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
 
 		/* Recompute parts of bprm->cred based on bprm->file */
 		bprm->active_secureexec = 0;
+		bprm->active_per_clear = 0;
 		bprm_fill_uid(bprm);
 		retval = security_bprm_repopulate_creds(bprm);
 		if (retval)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index e7959a6a895a..89231a689957 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,6 +26,9 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
+		/* Does bprm->file warrant clearing personality bits? */
+		active_per_clear:1,
+
 		/* Should unsafe personality bits be cleared? */
 		per_clear:1,
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0ca68ad53592..62e60e55cb99 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -57,7 +57,7 @@
  *	transitions between security domains).
  *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
- *	The hook must set @bprm->per_clear to 1 if the dangerous personality
+ *	The hook must set @bprm->active_per_clear to 1 if the dangerous personality
  *	bits must be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
diff --git a/security/commoncap.c b/security/commoncap.c
index 48b556046483..0b72d7bf23e1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -826,7 +826,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (__cap_gained(permitted, new, old))
-		bprm->per_clear = 1;
+		bprm->active_per_clear = 1;
 
 	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
-- 
2.25.0

