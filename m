Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A9C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C3C2053B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbgE1Pwi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:52:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52566 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404565AbgE1Pwi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:52:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKpg-0005EG-KT; Thu, 28 May 2020 09:52:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKpf-00033R-Pz; Thu, 28 May 2020 09:52:36 -0600
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
Date:   Thu, 28 May 2020 10:48:44 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87a71sxdpf.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKpf-00033R-Pz;;;mid=<87a71sxdpf.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19L2GQX5s9eCjNWe4gHmrLWVMHrvsxnIhk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 07/11] exec: Set saved, fs, and effective ids together in bprm_fill_uid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Now that there is only one place in bprm_fill_uid where the
euid and the egid are set, move setting of the saved, and the
fs ids to that place.

This makes it clear that this is the only location in the function
that changes these ids.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 123402f218fe..8dd7254931dc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1639,23 +1639,20 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		if (!need_cap ||
 		    (ns_capable(new->user_ns, CAP_SETUID) &&
 		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
-			new->euid = uid;
+			new->suid = new->fsuid = new->euid = uid;
 	}
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
 		if (!need_cap ||
 		    (ns_capable(new->user_ns, CAP_SETGID) &&
 		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
-			new->egid = gid;
+			new->sgid = new->fsgid = new->egid = gid;
 	}
 
 after_setid:
 	/* Will the new creds have multiple uids or gids? */
 	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid))
 		bprm->secureexec = 1;
-
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
 }
 
 /*
-- 
2.25.0

