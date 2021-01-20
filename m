Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5AC43217
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Jan 2021 00:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9924823730
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Jan 2021 00:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbhAUAHR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:07:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49396 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbhATV3R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Jan 2021 16:29:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l2L1M-0033EK-MM; Wed, 20 Jan 2021 14:28:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l2L1L-00GTsr-HM; Wed, 20 Jan 2021 14:28:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-security-module@vger.kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 15:26:56 -0600
Message-ID: <87lfcn5mfz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l2L1L-00GTsr-HM;;;mid=<87lfcn5mfz.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zAIKo2/H39lizTedLFYbGqIxscrEV5Lo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH] apparmor: Enforce progressively tighter permissions for no_new_privs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


The current understanding of apparmor with respect to no_new_privs is at
odds with how no_new_privs is implemented and understood by the rest of
the kernel.

The documentation of no_new_privs states:
> With ``no_new_privs`` set, ``execve()`` promises not to grant the
> privilege to do anything that could not have been done without the
> execve call.

And reading through the kernel except for apparmor that description
matches what is implemented.

There are two major divergences of apparmor from this definition:
- proc_setattr enforces limitations when no_new_privs are set.
- the limitation is enforced from the apparent time when no_new_privs is
  set instead of guaranteeing that each execve has progressively more
  narrow permissions.

The code in apparmor that attempts to discover the apparmor label at the
point where no_new_privs is set is not robust.  The capture happens a
long time after no_new_privs is set.

Capturing the label at the point where no_new_privs is set is
practically impossible to implement robustly.  Today the rule is struct
cred can only be changed by it's current task.  Today
SECCOMP_FILTER_FLAG_TSYNC sets no_new_privs from another thread.  A
robust implementation would require changing something fundamental in
how creds are managed for SECCOMP_FILTER_FLAG_TSYNC to be able to
capture the cred at the point it is set.

Futhermore given the consistent documentation and how everything else
implements no_new_privs, not having the permissions get progressively
tighter is a footgun aimed at userspace.  I fully expect it to break any
security sensitive software that uses no_new_privs and was not
deliberately designed and tested against apparmor.

Avoid the questionable and hard to fix implementation and the
potential to confuse userspace by having no_new_privs enforce
progressinvely tighter permissions.

Fixes: 9fcf78cca198 ("apparmor: update domain transitions that are subsets of confinement at nnp")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

I came accross this while examining the places cred_guard_mutex is
used and trying to find a way to make those code paths less insane.

If it would be more pallatable I would not mind removing the
task_no_new_privs test entirely from aa_change_hat and aa_change_profile
as those are not part of exec, so arguably no_new_privs should not care
about them at all.

Can we please get rid of the huge semantic wart and pain in the implementation?

 security/apparmor/domain.c       | 39 ++++----------------------------
 security/apparmor/include/task.h |  4 ----
 security/apparmor/task.c         |  7 ------
 3 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f919ebd042fd..8f77059bf890 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -869,17 +869,6 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 
 	label = aa_get_newest_label(cred_label(bprm->cred));
 
-	/*
-	 * Detect no new privs being set, and store the label it
-	 * occurred under. Ideally this would happen when nnp
-	 * is set but there isn't a good way to do that yet.
-	 *
-	 * Testing for unconfined must be done before the subset test
-	 */
-	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) && !unconfined(label) &&
-	    !ctx->nnp)
-		ctx->nnp = aa_get_label(label);
-
 	/* buffer freed below, name is pointer into buffer */
 	buffer = aa_get_buffer(false);
 	if (!buffer) {
@@ -915,7 +904,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 */
 	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) &&
 	    !unconfined(label) &&
-	    !aa_label_is_unconfined_subset(new, ctx->nnp)) {
+	    !aa_label_is_unconfined_subset(new, label)) {
 		error = -EPERM;
 		info = "no new privs";
 		goto audit;
@@ -1158,16 +1147,6 @@ int aa_change_hat(const char *hats[], int count, u64 token, int flags)
 	label = aa_get_newest_cred_label(cred);
 	previous = aa_get_newest_label(ctx->previous);
 
-	/*
-	 * Detect no new privs being set, and store the label it
-	 * occurred under. Ideally this would happen when nnp
-	 * is set but there isn't a good way to do that yet.
-	 *
-	 * Testing for unconfined must be done before the subset test
-	 */
-	if (task_no_new_privs(current) && !unconfined(label) && !ctx->nnp)
-		ctx->nnp = aa_get_label(label);
-
 	if (unconfined(label)) {
 		info = "unconfined can not change_hat";
 		error = -EPERM;
@@ -1193,7 +1172,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, int flags)
 		 * reduce restrictions.
 		 */
 		if (task_no_new_privs(current) && !unconfined(label) &&
-		    !aa_label_is_unconfined_subset(new, ctx->nnp)) {
+		    !aa_label_is_unconfined_subset(new, label)) {
 			/* not an apparmor denial per se, so don't log it */
 			AA_DEBUG("no_new_privs - change_hat denied");
 			error = -EPERM;
@@ -1214,7 +1193,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, int flags)
 		 * reduce restrictions.
 		 */
 		if (task_no_new_privs(current) && !unconfined(label) &&
-		    !aa_label_is_unconfined_subset(previous, ctx->nnp)) {
+		    !aa_label_is_unconfined_subset(previous, label)) {
 			/* not an apparmor denial per se, so don't log it */
 			AA_DEBUG("no_new_privs - change_hat denied");
 			error = -EPERM;
@@ -1303,16 +1282,6 @@ int aa_change_profile(const char *fqname, int flags)
 
 	label = aa_get_current_label();
 
-	/*
-	 * Detect no new privs being set, and store the label it
-	 * occurred under. Ideally this would happen when nnp
-	 * is set but there isn't a good way to do that yet.
-	 *
-	 * Testing for unconfined must be done before the subset test
-	 */
-	if (task_no_new_privs(current) && !unconfined(label) && !ctx->nnp)
-		ctx->nnp = aa_get_label(label);
-
 	if (!fqname || !*fqname) {
 		aa_put_label(label);
 		AA_DEBUG("no profile name");
@@ -1409,7 +1378,7 @@ int aa_change_profile(const char *fqname, int flags)
 		 * reduce restrictions.
 		 */
 		if (task_no_new_privs(current) && !unconfined(label) &&
-		    !aa_label_is_unconfined_subset(new, ctx->nnp)) {
+		    !aa_label_is_unconfined_subset(new, label)) {
 			/* not an apparmor denial per se, so don't log it */
 			AA_DEBUG("no_new_privs - change_hat denied");
 			error = -EPERM;
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index f13d12373b25..8a9c258e2018 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -17,13 +17,11 @@ static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
 
 /*
  * struct aa_task_ctx - information for current task label change
- * @nnp: snapshot of label at time of no_new_privs
  * @onexec: profile to transition to on next exec  (MAY BE NULL)
  * @previous: profile the task may return to     (MAY BE NULL)
  * @token: magic value the task must know for returning to @previous_profile
  */
 struct aa_task_ctx {
-	struct aa_label *nnp;
 	struct aa_label *onexec;
 	struct aa_label *previous;
 	u64 token;
@@ -42,7 +40,6 @@ struct aa_label *aa_get_task_label(struct task_struct *task);
 static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
 {
 	if (ctx) {
-		aa_put_label(ctx->nnp);
 		aa_put_label(ctx->previous);
 		aa_put_label(ctx->onexec);
 	}
@@ -57,7 +54,6 @@ static inline void aa_dup_task_ctx(struct aa_task_ctx *new,
 				   const struct aa_task_ctx *old)
 {
 	*new = *old;
-	aa_get_label(new->nnp);
 	aa_get_label(new->previous);
 	aa_get_label(new->onexec);
 }
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index d17130ee6795..4b9ec370a171 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -41,7 +41,6 @@ struct aa_label *aa_get_task_label(struct task_struct *task)
 int aa_replace_current_label(struct aa_label *label)
 {
 	struct aa_label *old = aa_current_raw_label();
-	struct aa_task_ctx *ctx = task_ctx(current);
 	struct cred *new;
 
 	AA_BUG(!label);
@@ -56,12 +55,6 @@ int aa_replace_current_label(struct aa_label *label)
 	if (!new)
 		return -ENOMEM;
 
-	if (ctx->nnp && label_is_stale(ctx->nnp)) {
-		struct aa_label *tmp = ctx->nnp;
-
-		ctx->nnp = aa_get_newest_label(tmp);
-		aa_put_label(tmp);
-	}
 	if (unconfined(label) || (labels_ns(old) != labels_ns(label)))
 		/*
 		 * if switching to unconfined or a different label namespace
-- 
2.20.1

Eric
