Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF255C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BC02053B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404687AbgE1Pxj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:53:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33472 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1Pxh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:53:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKqe-0001Zi-I4; Thu, 28 May 2020 09:53:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKqd-00085a-M7; Thu, 28 May 2020 09:53:36 -0600
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
Date:   Thu, 28 May 2020 10:49:44 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKqd-00085a-M7;;;mid=<87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Uao3hKNmbCnTKyFSqtDONOkhIC5W+4JQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/11] exec: In bprm_fill_uid only set per_clear when honoring suid or sgid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


It makes no sense to set active_per_clear when the kernel decides not
to honor the executables setuid or or setgid bits.  Instead set
active_per_clear when the kernel actually decides to honor the suid or
sgid permission bits of an executable.

As far as I can tell this was the intended behavior but with the
ptrace logic hiding out in security/commcap.c:cap_bprm_apply_creds I
believe it was just overlooked that the setuid or setgid operation
could be cancelled.

History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index af108ecf9632..347dade4bc54 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1634,15 +1634,16 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
 		!ptracer_capable(current, new->user_ns);
 
-	if (mode & S_ISUID) {
+	if ((mode & S_ISUID) &&
+	    (!need_cap || ns_capable(new->user_ns, CAP_SETUID))) {
 		bprm->per_clear = 1;
-		if (!need_cap || ns_capable(new->user_ns, CAP_SETUID))
-			new->suid = new->fsuid = new->euid = uid;
+		new->suid = new->fsuid = new->euid = uid;
 	}
-	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+
+	if (((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) &&
+	    (!need_cap || ns_capable(new->user_ns, CAP_SETGID))) {
 		bprm->per_clear = 1;
-		if (!need_cap || ns_capable(new->user_ns, CAP_SETGID))
-			new->sgid = new->fsgid = new->egid = gid;
+		new->sgid = new->fsgid = new->egid = gid;
 	}
 
 after_setid:
-- 
2.25.0

