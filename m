Return-Path: <SRS0=34bQ=6X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BEC28CBC
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 19:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AD8208DB
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 19:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEIToY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 May 2020 15:44:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53380 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEIToX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 15:44:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVOY-0000ls-R6; Sat, 09 May 2020 13:44:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVOX-0006Xr-QE; Sat, 09 May 2020 13:44:22 -0600
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
Date:   Sat, 09 May 2020 14:40:53 -0500
In-Reply-To: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 09 May 2020 14:40:17 -0500")
Message-ID: <87pnbczyka.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVOX-0006Xr-QE;;;mid=<87pnbczyka.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19q9NmVU84Mw9oy22ZcRjrINLYW7zrSIoA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/5] exec: Call cap_bprm_set_creds directly from prepare_binprm
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The function cap_bprm_set_creds is the only instance of
security_bprm_set_creds that does something for the primary executable
file and for every interpreter the rest of the implementations of
security_bprm_set_creds do something only for the primary executable
file even if that file is a shell script.

The function cap_bprm_set_creds is also special in that it is called
even when CONFIG_SECURITY is unset.

So calling cap_bprm_set_creds separately to make these two cases explicit,
and allow future changes to take advantages of these differences
to simplify the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                | 4 ++++
 include/linux/security.h | 2 +-
 security/commoncap.c     | 1 -
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b0620d5ebc66..765bfd51a546 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1641,6 +1641,10 @@ int prepare_binprm(struct linux_binprm *bprm)
 		return retval;
 	bprm->called_set_creds = 1;
 
+	retval = cap_bprm_set_creds(bprm);
+	if (retval)
+		return retval;
+
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d9310472df..c1aa1638429a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -571,7 +571,7 @@ static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 
 static inline int security_bprm_set_creds(struct linux_binprm *bprm)
 {
-	return cap_bprm_set_creds(bprm);
+	return 0;
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..3757988abe42 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1346,7 +1346,6 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, cap_ptrace_traceme),
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
-	LSM_HOOK_INIT(bprm_set_creds, cap_bprm_set_creds),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
-- 
2.25.0

