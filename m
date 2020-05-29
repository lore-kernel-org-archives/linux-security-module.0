Return-Path: <SRS0=ngOM=7L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3140C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 29 May 2020 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC0A2077D
	for <linux-security-module@archiver.kernel.org>; Fri, 29 May 2020 16:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE2Qug (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 May 2020 12:50:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53838 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Quf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 May 2020 12:50:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeiDK-0002HE-5T; Fri, 29 May 2020 10:50:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeiDJ-0003BZ-3L; Fri, 29 May 2020 10:50:34 -0600
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
        <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 29 May 2020 11:46:40 -0500
In-Reply-To: <87d06mr8ps.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 29 May 2020 11:45:19 -0500")
Message-ID: <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeiDJ-0003BZ-3L;;;mid=<877dwur8nj.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wzHLdNs+aLSYbLN06mIAw8Mq8RcEUPeg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/2] exec: Add a per bprm->file version of per_clear
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


There is a small bug in the code that recomputes parts of bprm->cred
for every bprm->file.  The code never recomputes the part of
clear_dangerous_personality_flags it is responsible for.

Which means that in practice if someone creates a sgid script
the interpreter will not be able to use any of:
	READ_IMPLIES_EXEC
	ADDR_NO_RANDOMIZE
	ADDR_COMPAT_LAYOUT
	MMAP_PAGE_ZERO.

This accentially clearing of personality flags probably does
not matter in practice because no one has complained
but it does make the code more difficult to understand.

Further remaining bug compatible prevents the recomputation from being
removed and replaced by simply computing bprm->cred once from the
final bprm->file.

Making this change removes the last behavior difference between
computing bprm->creds from the final file and recomputing
bprm->cred several times.  Which allows this behavior change
to be justified for it's own reasons, and for any but hunts
looking into why the behavior changed to wind up here instead
of in the code that will follow that computes bprm->cred
from the final bprm->file.

This small logic bug appears to have existed since the code
started clearing dangerous personality bits.

History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                 | 6 ++++--
 include/linux/binfmts.h   | 5 +++++
 include/linux/lsm_hooks.h | 2 ++
 security/commoncap.c      | 2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c3c879a55d65..0f793536e393 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1354,6 +1354,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
+	bprm->per_clear |= bprm->pf_per_clear;
 	me->personality &= ~bprm->per_clear;
 
 	/*
@@ -1628,12 +1629,12 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		return;
 
 	if (mode & S_ISUID) {
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->pf_per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->pf_per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->egid = gid;
 	}
 }
@@ -1654,6 +1655,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
 
 		/* Recompute parts of bprm->cred based on bprm->file */
 		bprm->active_secureexec = 0;
+		bprm->pf_per_clear = 0;
 		bprm_fill_uid(bprm);
 		retval = security_bprm_repopulate_creds(bprm);
 		if (retval)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 7fc05929c967..50025ead0b72 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -55,6 +55,11 @@ struct linux_binprm {
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
+	/*
+	 * bits to clear in current->personality
+	 * recalculated for each bprm->file.
+	 */
+	unsigned int pf_per_clear;
 	unsigned int per_clear;	/* bits to clear in current->personality */
 	int argc, envc;
 	const char * filename;	/* Name of binary as seen by procps */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d618ecc4d660..cd3dd0afceb5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -55,6 +55,8 @@
  *	transitions between security domains).
  *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
+ *	The hook must set @bprm->pf_per_clear to the personality flags that
+ *	should be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_check_security:
diff --git a/security/commoncap.c b/security/commoncap.c
index 77b04cb6feac..6de72d22dc6c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -826,7 +826,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (__cap_gained(permitted, new, old))
-		bprm->per_clear |= PER_CLEAR_ON_SETID;
+		bprm->pf_per_clear |= PER_CLEAR_ON_SETID;
 
 	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
-- 
2.25.0
