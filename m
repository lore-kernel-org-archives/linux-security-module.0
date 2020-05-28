Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C1C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC522053B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404620AbgE1PwL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:52:11 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49102 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404518AbgE1PwK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:52:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKpA-0004Mo-Cr; Thu, 28 May 2020 09:52:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKp9-0007rJ-31; Thu, 28 May 2020 09:52:04 -0600
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
Date:   Thu, 28 May 2020 10:48:11 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87ftbkxdqc.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKp9-0007rJ-31;;;mid=<87ftbkxdqc.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19acW7gYINIOd1UYM//vzVBWHHd36D56kw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 06/11] exec: Don't set secureexec when the uid or gid changes are abandoned
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


When the is_secureexec test was removed from cap_bprm_set_creds the
test was modified so that it based the status of secureexec on a
version of the euid and egid before ptrace and shared fs tests
possibly reverted them.

The effect of which is that secureexec continued to be set when the
euid and egid change were abandoned because the executable was being
ptraced to secureexec being set in that same situation.

As far as I can tell it is just an oversight and very poor quality of
implementation to set AT_SECURE when it is not ncessary.  So improve
the quality of the implementation by only setting secureexec when there
will be multiple uids or gids in the final cred structure.

Fixes: ee67ae7ef6ff ("commoncap: Move cap_elevated calculation into bprm_set_creds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index bac8db14f30d..123402f218fe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1622,44 +1622,38 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	    !kgid_has_mapping(new->user_ns, gid))
 		goto after_setid;
 
+	/*
+	 * Is the root directory and working directory shared or is
+	 * the process traced and the tracing process does not have
+	 * CAP_SYS_PTRACE?
+	 *
+	 * In either case it is not safe to change the euid or egid
+	 * unless the current process has the appropriate cap and so
+	 * chaning the euid or egid was already possible.
+	 */
+	need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
+		!ptracer_capable(current, new->user_ns);
+
 	if (mode & S_ISUID) {
 		bprm->per_clear = 1;
-		new->euid = uid;
+		if (!need_cap ||
+		    (ns_capable(new->user_ns, CAP_SETUID) &&
+		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
+			new->euid = uid;
 	}
-
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
-		new->egid = gid;
+		if (!need_cap ||
+		    (ns_capable(new->user_ns, CAP_SETGID) &&
+		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
+			new->egid = gid;
 	}
 
 after_setid:
 	/* Will the new creds have multiple uids or gids? */
-	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid)) {
+	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid))
 		bprm->secureexec = 1;
 
-		/*
-		 * Is the root directory and working directory shared or is
-		 * the process traced and the tracing process does not have
-		 * CAP_SYS_PTRACE?
-		 *
-		 * In either case it is not safe to change the euid or egid
-		 * unless the current process has the appropriate cap and so
-		 * chaning the euid or egid was already possible.
-		 */
-		need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
-			!ptracer_capable(current, new->user_ns);
-		if (need_cap && !uid_eq(new->euid, new->uid) &&
-		    (!ns_capable(new->user_ns, CAP_SETUID) ||
-		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
-			new->euid = new->uid;
-		}
-		if (need_cap && !gid_eq(new->egid, new->gid) &&
-		    (!ns_capable(new->user_ns, CAP_SETGID) ||
-		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
-			new->egid = new->gid;
-		}
-	}
-
 	new->suid = new->fsuid = new->euid;
 	new->sgid = new->fsgid = new->egid;
 }
-- 
2.25.0

