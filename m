Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D6C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171D8207BC
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404701AbgE1PrS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:47:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50642 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404679AbgE1PrF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:47:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKkJ-0004Qw-2N; Thu, 28 May 2020 09:47:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKkH-00024D-UJ; Thu, 28 May 2020 09:47:02 -0600
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
Date:   Thu, 28 May 2020 10:43:09 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87wo4wxdyq.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKkH-00024D-UJ;;;mid=<87wo4wxdyq.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4yct8JYeIUy8W9FZXXCz8gjMVFKhpUuQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 04/11] exec: Move uid/gid handling from creds_from_file into bprm_fill_uid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The logic in cap_bprm_creds_from_file is difficult to follow in part
because it handles both uids/gids and capabilities.  That difficulty
in following the code has resulted in several small bugs.  Move the
handling of uids/gids into bprm_fill_uid to make the code clearer.

A small bug is fixed where the ambient capabilities were unnecessarily
cleared when the presence of a ptracer or a shared fs_struct resulted
in the setuid or setgid not being honored.  This bug was not possible
to leave in place with the movement of the uids and gids handling
out of cap_bprm_repopultate_creds.

The rest of the bugs I have tried to make more apparent but left
in tact when moving the code into bprm_fill_uid.

Ref: ee67ae7ef6ff ("commoncap: Move cap_elevated calculation into bprm_set_creds")
Fixes: 58319057b784 ("capabilities: ambient capabilities")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c            | 49 ++++++++++++++++++++++++++++++++++++--------
 security/commoncap.c | 25 +++++++---------------
 2 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 091ff6269610..956ee3a0d824 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1590,21 +1590,23 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 static void bprm_fill_uid(struct linux_binprm *bprm)
 {
 	/* Handle suid and sgid on files */
+	struct cred *new = bprm->cred;
 	struct inode *inode;
 	unsigned int mode;
+	bool need_cap;
 	kuid_t uid;
 	kgid_t gid;
 
 	if (!mnt_may_suid(bprm->file->f_path.mnt))
-		return;
+		goto after_setid;
 
 	if (task_no_new_privs(current))
-		return;
+		goto after_setid;
 
 	inode = bprm->file->f_path.dentry->d_inode;
 	mode = READ_ONCE(inode->i_mode);
 	if (!(mode & (S_ISUID|S_ISGID)))
-		return;
+		goto after_setid;
 
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
@@ -1616,19 +1618,50 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	inode_unlock(inode);
 
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
-	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
-		 !kgid_has_mapping(bprm->cred->user_ns, gid))
-		return;
+	if (!kuid_has_mapping(new->user_ns, uid) ||
+	    !kgid_has_mapping(new->user_ns, gid))
+		goto after_setid;
 
 	if (mode & S_ISUID) {
 		bprm->per_clear = 1;
-		bprm->cred->euid = uid;
+		new->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
-		bprm->cred->egid = gid;
+		new->egid = gid;
+	}
+
+after_setid:
+	/* Will the new creds have multiple uids or gids? */
+	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid)) {
+		bprm->secureexec = 1;
+
+		/*
+		 * Is the root directory and working directory shared or is
+		 * the process traced and the tracing process does not have
+		 * CAP_SYS_PTRACE?
+		 *
+		 * In either case it is not safe to change the euid or egid
+		 * unless the current process has the appropriate cap and so
+		 * chaning the euid or egid was already possible.
+		 */
+		need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
+			!ptracer_capable(current, new->user_ns);
+		if (need_cap && !uid_eq(new->euid, new->uid) &&
+		    (!ns_capable(new->user_ns, CAP_SETUID) ||
+		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
+			new->euid = new->uid;
+		}
+		if (need_cap && !gid_eq(new->egid, new->gid) &&
+		    (!ns_capable(new->user_ns, CAP_SETUID) ||
+		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
+			new->egid = new->gid;
+		}
 	}
+
+	new->suid = new->fsuid = new->euid;
+	new->sgid = new->fsgid = new->egid;
 }
 
 /*
diff --git a/security/commoncap.c b/security/commoncap.c
index 2bd1f24f3796..b39c7511862e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -809,7 +809,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 	/* Process setpcap binaries and capabilities for uid 0 */
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
-	bool effective = false, has_fcap = false, is_setid;
+	bool effective = false, has_fcap = false;
 	int ret;
 	kuid_t root_uid;
 
@@ -828,31 +828,21 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 	if (__cap_gained(permitted, new, old))
 		bprm->per_clear = 1;
 
-	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
+	/* Don't let someone trace a setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
 	 *
 	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
 	 */
-	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
-
-	if ((is_setid || __cap_gained(permitted, new, old)) &&
+	if (__cap_gained(permitted, new, old) &&
 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
 	     !ptracer_capable(current, new->user_ns))) {
 		/* downgrade; they get no more than they had, and maybe less */
-		if (!ns_capable(new->user_ns, CAP_SETUID) ||
-		    (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)) {
-			new->euid = new->uid;
-			new->egid = new->gid;
-		}
 		new->cap_permitted = cap_intersect(new->cap_permitted,
 						   old->cap_permitted);
 	}
 
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
-
 	/* File caps or setid cancels ambient. */
-	if (has_fcap || is_setid)
+	if (has_fcap || __is_setuid(new, old) || __is_setgid(new, old))
 		cap_clear(new->cap_ambient);
 
 	/*
@@ -885,10 +875,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 		return -EPERM;
 
 	/* Check for privilege-elevated exec. */
-	if (is_setid ||
-	    (!__is_real(root_uid, new) &&
-	     (effective ||
-	      __cap_grew(permitted, ambient, new))))
+	if (!__is_real(root_uid, new) &&
+	    (effective ||
+	     __cap_grew(permitted, ambient, new)))
 		bprm->secureexec = 1;
 
 	return 0;
-- 
2.25.0

