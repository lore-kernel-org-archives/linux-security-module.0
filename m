Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73E1C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A232C2053B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404778AbgE1Pye (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:54:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49760 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404774AbgE1Pyc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:54:32 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKrU-0004Y0-Lc; Thu, 28 May 2020 09:54:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKrT-0008Bp-Qq; Thu, 28 May 2020 09:54:28 -0600
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
Date:   Thu, 28 May 2020 10:50:36 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87mu5svz1v.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKrT-0008Bp-Qq;;;mid=<87mu5svz1v.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MHtH6hLkB3oWNuRodn+5tMsim9ktuu6s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 11/11] exec: Remove the label after_setid from bprm_fill_uid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


There is nothing past the label after_setid in bprm_fill_uid so
replace code that jumps to it with return, and delete
the label entirely.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fc4edc7517a6..ccb552fcdcff 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1598,15 +1598,15 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	kgid_t gid;
 
 	if (!mnt_may_suid(bprm->file->f_path.mnt))
-		goto after_setid;
+		return;
 
 	if (task_no_new_privs(current))
-		goto after_setid;
+		return;
 
 	inode = bprm->file->f_path.dentry->d_inode;
 	mode = READ_ONCE(inode->i_mode);
 	if (!(mode & (S_ISUID|S_ISGID)))
-		goto after_setid;
+		return;
 
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
@@ -1620,7 +1620,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!kuid_has_mapping(new->user_ns, uid) ||
 	    !kgid_has_mapping(new->user_ns, gid))
-		goto after_setid;
+		return;
 
 	/*
 	 * Is the root directory and working directory shared or is
@@ -1647,9 +1647,6 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		bprm->secureexec = 1;
 		new->sgid = new->fsgid = new->egid = gid;
 	}
-
-after_setid:
-	;
 }
 
 /*
-- 
2.25.0

