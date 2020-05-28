Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD3C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B2E2053B
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404743AbgE1PyI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:54:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53032 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1PyD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:54:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKr3-0005Lz-CC; Thu, 28 May 2020 09:54:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKr2-0003Dg-EH; Thu, 28 May 2020 09:54:01 -0600
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
Date:   Thu, 28 May 2020 10:50:09 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87sgfkvz2m.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKr2-0003Dg-EH;;;mid=<87sgfkvz2m.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+noWZXFqvq+oA4X8eGsRDwP21udiMjpIw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 10/11] exec: In bprm_fill_uid set secureexec at same time as per_clear
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


We currently have two different policies for setting per_clear and for
setting secureexec.  For per_clear the policy is if the setxid bits on
a file are honored.  For secureexec the policy is if the resulting
credentials will have multiple uids or gids.

Looking closely the policy for setting AT_SECURE and asking userspace
not to trust our caller in all cases where we have multiple uids or
gids does not make sense.   In some of those cases it is the caller
of exec that provides multiple uids and gids.

The point of setting AT_SECURE is so that the called application or
it's libraries can take defensive measures to guard against a lesser
privileged program which calls it via exec.  If all of your privilege
comes from your caller there is no point in taking defensive measures,
against them.

Further the only way that libc or other userspace can know that the
privilege came from the caller of exec and not from the exec being
suid or sgid is by the kernel telling it.  As userspace does not
have enough information to distinguish between these two cases.

So set secureexec when the exec itself results in multiple uids
or gids, not when we happen to have mulitple ids because the
binary was called that way.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 347dade4bc54..fc4edc7517a6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1637,19 +1637,19 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	if ((mode & S_ISUID) &&
 	    (!need_cap || ns_capable(new->user_ns, CAP_SETUID))) {
 		bprm->per_clear = 1;
+		bprm->secureexec = 1;
 		new->suid = new->fsuid = new->euid = uid;
 	}
 
 	if (((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) &&
 	    (!need_cap || ns_capable(new->user_ns, CAP_SETGID))) {
 		bprm->per_clear = 1;
+		bprm->secureexec = 1;
 		new->sgid = new->fsgid = new->egid = gid;
 	}
 
 after_setid:
-	/* Will the new creds have multiple uids or gids? */
-	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid))
-		bprm->secureexec = 1;
+	;
 }
 
 /*
-- 
2.25.0

