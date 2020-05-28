Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1337AC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC136207BC
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404587AbgE1Ppe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:45:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58144 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404617AbgE1Pp2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:45:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKic-0000P5-1Z; Thu, 28 May 2020 09:45:18 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKiZ-0006cv-J1; Thu, 28 May 2020 09:45:17 -0600
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
Date:   Thu, 28 May 2020 10:41:22 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87eer4ysm5.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKiZ-0006cv-J1;;;mid=<87eer4ysm5.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18haYcbIQZKo6eWp1tkySil7Dv2wO8d9Cs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 01/11] exec: Reduce bprm->per_clear to a single bit
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The bprm->per_clear field only takes the values 0 and
PER_CLEAR_ON_SETID.  Reduce the field to a signle bit to make it clear
that the only question is should the dangerous personality bits be
cleared or not.

Update the documentation of the security lsm hooks.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                  | 7 ++++---
 include/linux/binfmts.h    | 4 +++-
 include/linux/lsm_hooks.h  | 4 ++++
 security/apparmor/domain.c | 2 +-
 security/commoncap.c       | 2 +-
 security/selinux/hooks.c   | 2 +-
 security/smack/smack_lsm.c | 2 +-
 7 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c3c879a55d65..51fab62b9fca 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1354,7 +1354,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
-	me->personality &= ~bprm->per_clear;
+	if (bprm->per_clear)
+		me->personality &= ~PER_CLEAR_ON_SETID;
 
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
@@ -1628,12 +1629,12 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		return;
 
 	if (mode & S_ISUID) {
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear = 1;
 		bprm->cred->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear = 1;
 		bprm->cred->egid = gid;
 	}
 }
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 7fc05929c967..e7959a6a895a 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,6 +26,9 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
+		/* Should unsafe personality bits be cleared? */
+		per_clear:1,
+
 		/* Should an execfd be passed to userspace? */
 		have_execfd:1,
 
@@ -55,7 +58,6 @@ struct linux_binprm {
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
-	unsigned int per_clear;	/* bits to clear in current->personality */
 	int argc, envc;
 	const char * filename;	/* Name of binary as seen by procps */
 	const char * interp;	/* Name of the binary really executed. Most
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d618ecc4d660..0ca68ad53592 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -42,6 +42,8 @@
  *	(e.g. for transitions between security domains).
  *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
+ *	The hook must set @bprm->per_clear to 1 if the dangerous personality
+ *	bits must be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_repopulate_creds:
@@ -55,6 +57,8 @@
  *	transitions between security domains).
  *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
+ *	The hook must set @bprm->per_clear to 1 if the dangerous personality
+ *	bits must be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_check_security:
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 0b870a647488..c6d00735a40a 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -962,7 +962,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 			aa_label_printk(new, GFP_KERNEL);
 			dbg_printk("\n");
 		}
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear = 1;
 	}
 	aa_put_label(cred_label(bprm->cred));
 	/* transfer reference, released when cred is freed */
diff --git a/security/commoncap.c b/security/commoncap.c
index 77b04cb6feac..48b556046483 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -826,7 +826,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (__cap_gained(permitted, new, old))
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear = 1;
 
 	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 718345dd76bb..6bea1b879fdb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2385,7 +2385,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		}
 
 		/* Clear any possibly unsafe personality bits on exec: */
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear = 1;
 
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0ac8f4518d07..a0d2fad27b33 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -933,7 +933,7 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
 		return -EPERM;
 
 	bsp->smk_task = isp->smk_task;
-	bprm->per_clear |= PER_CLEAR_ON_SETID;
+	bprm->per_clear = 1;
 
 	/* Decide if this is a secure exec. */
 	if (bsp->smk_task != bsp->smk_forked)
-- 
2.25.0

