Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD57C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4D322280
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGNNbe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:31:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48418 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNbd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 09:31:33 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL1w-0007RF-BS; Tue, 14 Jul 2020 07:31:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL1v-0006Xu-HX; Tue, 14 Jul 2020 07:31:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
Date:   Tue, 14 Jul 2020 08:28:42 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87v9iq6x9x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL1v-0006Xu-HX;;;mid=<87v9iq6x9x.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+L9NFh+ZPsxXvjHVAolHu7lSRa9Zwp4L0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/7] exec: Remove unnecessary spaces from binfmts.h
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The general convention in the linux kernel is to define a pointer
member as "type *name".  The declaration of struct linux_binprm has
several pointer defined as "type * name".  Update them to the
form of "type *name" for consistency.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/binfmts.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 7c27d7b57871..eb5cb8df5485 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -45,15 +45,15 @@ struct linux_binprm {
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-	struct file * executable; /* Executable to pass to the interpreter */
-	struct file * interpreter;
-	struct file * file;
+	struct file *executable; /* Executable to pass to the interpreter */
+	struct file *interpreter;
+	struct file *file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
 	unsigned int per_clear;	/* bits to clear in current->personality */
 	int argc, envc;
-	const char * filename;	/* Name of binary as seen by procps */
-	const char * interp;	/* Name of the binary really executed. Most
+	const char *filename;	/* Name of binary as seen by procps */
+	const char *interp;	/* Name of the binary really executed. Most
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	unsigned interp_flags;
-- 
2.25.0

