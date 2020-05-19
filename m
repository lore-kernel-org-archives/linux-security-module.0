Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02838C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82642070A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgESAfe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 20:35:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37512 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESAfd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 20:35:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqEG-0000Vb-7M; Mon, 18 May 2020 18:35:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqEF-0003a2-Dh; Mon, 18 May 2020 18:35:32 -0600
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
Date:   Mon, 18 May 2020 19:31:51 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqEF-0003a2-Dh;;;mid=<87imgszrwo.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+zSDC+oPj2CKUq9mJvOsL3qCDQjL7cYcM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 4/8] exec: Allow load_misc_binary to call prepare_binfmt unconditionally
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Add a flag preserve_creds that binfmt_misc can set to prevent
credentials from being updated.  This allows binfmt_misc to always
call prepare_binfmt.  Allowing the credential computation logic to be
consolidated.

Not replacing the credentials with the interpreters credentials is
safe because because an open file descriptor to the executable is
passed to the interpreter.   As the interpreter does not need to
reopen the executable it is guaranteed to see the same file that
exec sees.

Ref: c407c033de84 ("[PATCH] binfmt_misc: improve calculation of interpreter's credentials")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_misc.c        | 15 +++------------
 fs/exec.c               | 19 ++++++++++++-------
 include/linux/binfmts.h |  2 ++
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d..264829745d6f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -218,19 +218,10 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		goto error;
 
 	bprm->file = interp_file;
-	if (fmt->flags & MISC_FMT_CREDENTIALS) {
-		loff_t pos = 0;
-
-		/*
-		 * No need to call prepare_binprm(), it's already been
-		 * done.  bprm->buf is stale, update from interp_file.
-		 */
-		memset(bprm->buf, 0, BINPRM_BUF_SIZE);
-		retval = kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE,
-				&pos);
-	} else
-		retval = prepare_binprm(bprm);
+	if (fmt->flags & MISC_FMT_CREDENTIALS)
+		bprm->preserve_creds = 1;
 
+	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		goto error;
 
diff --git a/fs/exec.c b/fs/exec.c
index 8e3b93d51d31..028e0e323af5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1631,15 +1631,20 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
  */
 int prepare_binprm(struct linux_binprm *bprm)
 {
-	int retval;
 	loff_t pos = 0;
 
-	/* Recompute parts of bprm->cred based on bprm->file */
-	bprm->active_secureexec = 0;
-	bprm_fill_uid(bprm);
-	retval = security_bprm_repopulate_creds(bprm);
-	if (retval)
-		return retval;
+	/* Can the interpreter get to the executable without races? */
+	if (!bprm->preserve_creds) {
+		int retval;
+
+		/* Recompute parts of bprm->cred based on bprm->file */
+		bprm->active_secureexec = 0;
+		bprm_fill_uid(bprm);
+		retval = security_bprm_repopulate_creds(bprm);
+		if (retval)
+			return retval;
+	}
+	bprm->preserve_creds = 0;
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8605ab4a0f89..dbb5614d62a2 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,6 +26,8 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
+		/* It is safe to use the creds of a script (see binfmt_misc) */
+		preserve_creds:1,
 		/*
 		 * True if most recent call to security_bprm_set_creds
 		 * resulted in elevated privileges.
-- 
2.25.0

