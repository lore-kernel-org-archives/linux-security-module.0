Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0936C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB77D20657
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESAhE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 20:37:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45682 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgESAhE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 20:37:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqFi-0003xR-52; Mon, 18 May 2020 18:37:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqFh-0004a3-3C; Mon, 18 May 2020 18:37:01 -0600
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
Date:   Mon, 18 May 2020 19:33:21 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <874ksczru6.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqFh-0004a3-3C;;;mid=<874ksczru6.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1973r7WyKjyu1LuSucdEGRqDGPfyMVGYww=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 6/8] exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The return code -ENOEXEC serves to tell search_binary_handler that it
should continue searching for the binfmt to handle a given file.  This
makes return -ENOEXEC with a bprm->buf that is needed to continue the
search problematic.

The current binfmt_script manages to escape problems as it closes and
clears bprm->file before return -ENOEXEC with bprm->buf modified.
This prevents search_binary_handler from looping as it explicitly
handles a NULL bprm->file.

I plan on moving all of the bprm->file managment into fs/exec.c and out
of the binary handlers so this will become a problem.

Move closing bprm->file and the test for BINPRM_PATH_INACCESSIBLE
down below the last return of -ENOEXEC.

Introduce i_sep and i_end to track the end of the first argument and
the end of the parameters respectively.  Using those, constification
of all char * pointers, and the helpers next_terminator and
next_non_spacetab guarantee the parameter parsing will not modify
bprm->buf.

Only modify bprm->buf to terminate the strings i_arg and i_name with
'\0' for passing to copy_strings_kernel.

When replacing loops with next_non_spacetab and next_terminator care
has been take that the logic of the parsing code (short of replacing
characters by '\0') remains the same.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_script.c | 80 ++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 8d718d8fd0fe..85e0ef86eb11 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -16,14 +16,14 @@
 #include <linux/fs.h>
 
 static inline bool spacetab(char c) { return c == ' ' || c == '\t'; }
-static inline char *next_non_spacetab(char *first, const char *last)
+static inline const char *next_non_spacetab(const char *first, const char *last)
 {
 	for (; first <= last; first++)
 		if (!spacetab(*first))
 			return first;
 	return NULL;
 }
-static inline char *next_terminator(char *first, const char *last)
+static inline const char *next_terminator(const char *first, const char *last)
 {
 	for (; first <= last; first++)
 		if (spacetab(*first) || !*first)
@@ -33,8 +33,7 @@ static inline char *next_terminator(char *first, const char *last)
 
 static int load_script(struct linux_binprm *bprm)
 {
-	const char *i_arg, *i_name;
-	char *cp, *buf_end;
+	const char *i_name, *i_sep, *i_arg, *i_end, *buf_end;
 	struct file *file;
 	int retval;
 
@@ -42,20 +41,6 @@ static int load_script(struct linux_binprm *bprm)
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
 		return -ENOEXEC;
 
-	/*
-	 * If the script filename will be inaccessible after exec, typically
-	 * because it is a "/dev/fd/<fd>/.." path against an O_CLOEXEC fd, give
-	 * up now (on the assumption that the interpreter will want to load
-	 * this file).
-	 */
-	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
-		return -ENOENT;
-
-	/* Release since we are not mapping a binary into memory. */
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
-
 	/*
 	 * This section handles parsing the #! line into separate
 	 * interpreter path and argument strings. We must be careful
@@ -71,39 +56,48 @@ static int load_script(struct linux_binprm *bprm)
 	 * parse them on its own.
 	 */
 	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
-	cp = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
-	if (!cp) {
-		cp = next_non_spacetab(bprm->buf + 2, buf_end);
-		if (!cp)
+	i_end = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
+	if (!i_end) {
+		i_end = next_non_spacetab(bprm->buf + 2, buf_end);
+		if (!i_end)
 			return -ENOEXEC; /* Entire buf is spaces/tabs */
 		/*
 		 * If there is no later space/tab/NUL we must assume the
 		 * interpreter path is truncated.
 		 */
-		if (!next_terminator(cp, buf_end))
+		if (!next_terminator(i_end, buf_end))
 			return -ENOEXEC;
-		cp = buf_end;
+		i_end = buf_end;
 	}
-	/* NUL-terminate the buffer and any trailing spaces/tabs. */
-	*cp = '\0';
-	while (cp > bprm->buf) {
-		cp--;
-		if ((*cp == ' ') || (*cp == '\t'))
-			*cp = '\0';
-		else
-			break;
-	}
-	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
-	if (*cp == '\0')
+	/* Trim any trailing spaces/tabs from i_end */
+	while (spacetab(i_end[-1]))
+		i_end--;
+
+	/* Skip over leading spaces/tabs */
+	i_name = next_non_spacetab(bprm->buf+2, i_end);
+	if (!i_name || (i_name == i_end))
 		return -ENOEXEC; /* No interpreter name found */
-	i_name = cp;
+
+	/* Is there an optional argument? */
 	i_arg = NULL;
-	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
-		/* nothing */ ;
-	while ((*cp == ' ') || (*cp == '\t'))
-		*cp++ = '\0';
-	if (*cp)
-		i_arg = cp;
+	i_sep = next_terminator(i_name, i_end);
+	if (i_sep && (*i_sep != '\0'))
+		i_arg = next_non_spacetab(i_sep, i_end);
+
+	/*
+	 * If the script filename will be inaccessible after exec, typically
+	 * because it is a "/dev/fd/<fd>/.." path against an O_CLOEXEC fd, give
+	 * up now (on the assumption that the interpreter will want to load
+	 * this file).
+	 */
+	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
+		return -ENOENT;
+
+	/* Release since we are not mapping a binary into memory. */
+	allow_write_access(bprm->file);
+	fput(bprm->file);
+	bprm->file = NULL;
+
 	/*
 	 * OK, we've parsed out the interpreter name and
 	 * (optional) argument.
@@ -121,7 +115,9 @@ static int load_script(struct linux_binprm *bprm)
 	if (retval < 0)
 		return retval;
 	bprm->argc++;
+	*((char *)i_end) = '\0';
 	if (i_arg) {
+		*((char *)i_sep) = '\0';
 		retval = copy_strings_kernel(1, &i_arg, bprm);
 		if (retval < 0)
 			return retval;
-- 
2.25.0

