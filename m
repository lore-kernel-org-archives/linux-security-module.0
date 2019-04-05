Return-Path: <SRS0=2koH=SH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E48C4360F
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3B2184B
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 13:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDENfI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:35:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDENfH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Apr 2019 09:35:07 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hCOzk-0002tV-75; Fri, 05 Apr 2019 15:35:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-security-module@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] apparmor: Switch to GFP_KERNEL where possible
Date:   Fri,  5 Apr 2019 15:34:58 +0200
Message-Id: <20190405133458.4809-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405133458.4809-1-bigeasy@linutronix.de>
References: <20190405133458.4809-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

After removing preempt_disable() from get_buffers() it is possible to
replace a few GFP_ATOMIC allocations with GFP_KERNEL.

Replace GFP_ATOMIC allocations with GFP_KERNEL where the context looks
to bee preepmtible.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 security/apparmor/domain.c | 20 ++++++++++----------
 security/apparmor/file.c   |  2 +-
 security/apparmor/mount.c  |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 1f4a6e420b6d3..b8114d9988bac 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -524,7 +524,7 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
 				label = &new_profile->label;
 			continue;
 		}
-		label = aa_label_parse(&profile->label, *name, GFP_ATOMIC,
+		label = aa_label_parse(&profile->label, *name, GFP_KERNEL,
 				       true, false);
 		if (IS_ERR(label))
 			label = NULL;
@@ -604,7 +604,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 		/* base the stack on post domain transition */
 		struct aa_label *base = new;
 
-		new = aa_label_parse(base, stack, GFP_ATOMIC, true, false);
+		new = aa_label_parse(base, stack, GFP_KERNEL, true, false);
 		if (IS_ERR(new))
 			new = NULL;
 		aa_put_label(base);
@@ -712,7 +712,7 @@ static struct aa_label *profile_transition(struct aa_profile *profile,
 		if (DEBUG_ON) {
 			dbg_printk("apparmor: scrubbing environment variables"
 				   " for %s profile=", name);
-			aa_label_printk(new, GFP_ATOMIC);
+			aa_label_printk(new, GFP_KERNEL);
 			dbg_printk("\n");
 		}
 		*secure_exec = true;
@@ -788,7 +788,7 @@ static int profile_onexec(struct aa_profile *profile, struct aa_label *onexec,
 		if (DEBUG_ON) {
 			dbg_printk("apparmor: scrubbing environment "
 				   "variables for %s label=", xname);
-			aa_label_printk(onexec, GFP_ATOMIC);
+			aa_label_printk(onexec, GFP_KERNEL);
 			dbg_printk("\n");
 		}
 		*secure_exec = true;
@@ -822,7 +822,7 @@ static struct aa_label *handle_onexec(struct aa_label *label,
 					       bprm, buffer, cond, unsafe));
 		if (error)
 			return ERR_PTR(error);
-		new = fn_label_build_in_ns(label, profile, GFP_ATOMIC,
+		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
 				aa_get_newest_label(onexec),
 				profile_transition(profile, bprm, buffer,
 						   cond, unsafe));
@@ -834,9 +834,9 @@ static struct aa_label *handle_onexec(struct aa_label *label,
 					       buffer, cond, unsafe));
 		if (error)
 			return ERR_PTR(error);
-		new = fn_label_build_in_ns(label, profile, GFP_ATOMIC,
+		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
 				aa_label_merge(&profile->label, onexec,
-					       GFP_ATOMIC),
+					       GFP_KERNEL),
 				profile_transition(profile, bprm, buffer,
 						   cond, unsafe));
 	}
@@ -902,7 +902,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		new = handle_onexec(label, ctx->onexec, ctx->token,
 				    bprm, buffer, &cond, &unsafe);
 	else
-		new = fn_label_build(label, profile, GFP_ATOMIC,
+		new = fn_label_build(label, profile, GFP_KERNEL,
 				profile_transition(profile, bprm, buffer,
 						   &cond, &unsafe));
 
@@ -946,7 +946,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		if (DEBUG_ON) {
 			dbg_printk("scrubbing environment variables for %s "
 				   "label=", bprm->filename);
-			aa_label_printk(new, GFP_ATOMIC);
+			aa_label_printk(new, GFP_KERNEL);
 			dbg_printk("\n");
 		}
 		bprm->secureexec = 1;
@@ -957,7 +957,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		if (DEBUG_ON) {
 			dbg_printk("apparmor: clearing unsafe personality "
 				   "bits. %s label=", bprm->filename);
-			aa_label_printk(new, GFP_ATOMIC);
+			aa_label_printk(new, GFP_KERNEL);
 			dbg_printk("\n");
 		}
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index e422a3f59e80c..3eb2c5369711c 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -80,7 +80,7 @@ static void file_audit_cb(struct audit_buffer *ab, void *va)
 	if (aad(sa)->peer) {
 		audit_log_format(ab, " target=");
 		aa_label_xaudit(ab, labels_ns(aad(sa)->label), aad(sa)->peer,
-				FLAG_VIEW_SUBNS, GFP_ATOMIC);
+				FLAG_VIEW_SUBNS, GFP_KERNEL);
 	} else if (aad(sa)->fs.target) {
 		audit_log_format(ab, " target=");
 		audit_log_untrustedstring(ab, aad(sa)->fs.target);
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 8a6cf1c14e82a..d73bc3ceaf9f5 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -679,7 +679,7 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 
 	old_buffer = aa_get_buffer();
 	new_buffer = aa_get_buffer();
-	target = fn_label_build(label, profile, GFP_ATOMIC,
+	target = fn_label_build(label, profile, GFP_KERNEL,
 			build_pivotroot(profile, new_path, new_buffer,
 					old_path, old_buffer));
 	if (!target) {
-- 
2.20.1

