Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F917BD9;
	Tue, 20 May 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747779225; cv=none; b=jwriRCvxgXJKBBOedj17fkdWkZakTl7ZvL6yoI3vVQ3BQz+LLpTHR7UJmC7vCvX84RfzQe5Am5MeL3EKO46aVCYcWK9/Zx6wukMETtJsN/nLk6JDDHG5F1bUbt01BwXFqjla4kCooK6Lbk70ZQ99U4wyMl3Dijwq4Mn7ExpGveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747779225; c=relaxed/simple;
	bh=DzyYPcLCcu1IXyfK/LqIzUtOaKUrN2d5F9zVfxrTNI0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Tb/GQSaOCVf8LxQi8dnW+DYQILpiJfGUPgpCYgmtaj0ELklBiz14LE0zf5tB5cpz6VmoQ1grde79LyNpnPXxVx7wHvo7p7tBlw3u68xIKlKhGoGy5CfXMbpJjpnVPkZ1CB0+10hBKNMuNHnbKpcD++j4qgM0gixLTj6GcFTsv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:36422)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uHVDL-0051Fv-6u; Tue, 20 May 2025 16:13:35 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:53164 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uHVDJ-003BfQ-Vr; Tue, 20 May 2025 16:13:34 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
Cc: Jann Horn <jannh@google.com>,  Max Kellermann
 <max.kellermann@ionos.com>,  "Serge E. Hallyn" <serge@hallyn.com>,
  paul@paul-moore.com,  jmorris@namei.org,  Andy Lutomirski
 <luto@kernel.org>,  morgan@kernel.org,  Christian Brauner
 <christian@brauner.io>,  linux-security-module@vger.kernel.org,
  linux-kernel@vger.kernel.org
References: <20250306082615.174777-1-max.kellermann@ionos.com>
	<878qmxsuy8.fsf@email.froward.int.ebiederm.org>
	<202505151451.638C22B@keescook>
	<87ecwopofp.fsf@email.froward.int.ebiederm.org>
	<CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
	<87wmagnnhq.fsf@email.froward.int.ebiederm.org>
	<202505201319.D57FDCB2A@keescook>
Date: Tue, 20 May 2025 17:13:03 -0500
In-Reply-To: <202505201319.D57FDCB2A@keescook> (Kees Cook's message of "Tue,
	20 May 2025 13:20:28 -0700")
Message-ID: <87frgznd74.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uHVDJ-003BfQ-Vr;;;mid=<87frgznd74.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18YkB7NqbPeto0y+cnfH1t7CLa1d66YwdQ=
X-Spam-Level: *****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.7 FUZZY_CREDIT BODY: Attempt to obfuscate words in spam
	*  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Kees Cook <kees@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 730 ms - load_scoreonly_sql: 0.15 (0.0%),
	signal_user_changed: 13 (1.8%), b_tie_ro: 11 (1.6%), parse: 1.15
	(0.2%), extract_message_metadata: 19 (2.6%), get_uri_detail_list: 3.0
	(0.4%), tests_pri_-2000: 27 (3.8%), tests_pri_-1000: 2.5 (0.3%),
	tests_pri_-950: 1.45 (0.2%), tests_pri_-900: 1.29 (0.2%),
	tests_pri_-90: 130 (17.9%), check_bayes: 124 (16.9%), b_tokenize: 12
	(1.6%), b_tok_get_all: 13 (1.8%), b_comp_prob: 3.1 (0.4%),
	b_tok_touch_all: 91 (12.4%), b_finish: 1.13 (0.2%), tests_pri_0: 514
	(70.5%), check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 7 (0.9%),
	poll_dns_idle: 0.87 (0.1%), tests_pri_10: 4.0 (0.6%), tests_pri_500:
	10 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2] exec: Correct the permission check for unsafe exec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, christian@brauner.io, morgan@kernel.org, luto@kernel.org, jmorris@namei.org, paul@paul-moore.com, serge@hallyn.com, max.kellermann@ionos.com, jannh@google.com, kees@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false


Max Kellerman recently experienced a problem[1] when calling exec with
differing uid and euid's and he triggered the logic that is supposed
to only handle setuid executables.

When exec isn't changing anything in struct cred it doesn't make sense
to go into the code that is there to handle the case when the
credentials change.

When looking into the history of the code I discovered that this issue
was not present in Linux-2.4.0-test12 and was introduced in
Linux-2.4.0-prerelease when the logic for handling this case was moved
from prepare_binprm to compute_creds in fs/exec.c.

The bug introdused was to comparing euid in the new credentials with
uid instead of euid in the old credentials, when testing if setuid
had changed the euid.

Since triggering the keep ptrace limping along case for setuid
executables makes no sense when it was not a setuid exec revert back
to the logic present in Linux-2.4.0-test12.

This removes the confusingly named and subtlety incorrect helpers
is_setuid and is_setgid, that helped this bug to persist.

The varaiable is_setid is renamed to id_changed (it's Linux-2.4.0-test12)
as the old name describes what matters rather than it's cause.

The code removed in Linux-2.4.0-prerelease was:
-       /* Set-uid? */
-       if (mode & S_ISUID) {
-               bprm->e_uid = inode->i_uid;
-               if (bprm->e_uid != current->euid)
-                       id_change = 1;
-       }
-
-       /* Set-gid? */
-       /*
-        * If setgid is set but no group execute bit then this
-        * is a candidate for mandatory locking, not a setgid
-        * executable.
-        */
-       if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-               bprm->e_gid = inode->i_gid;
-               if (!in_group_p(bprm->e_gid))
-                       id_change = 1;

Linux-2.4.0-prerelease added the current logic as:
+       if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
+           !cap_issubset(new_permitted, current->cap_permitted)) {
+                current->dumpable = 0;
+
+               lock_kernel();
+               if (must_not_trace_exec(current)
+                   || atomic_read(&current->fs->count) > 1
+                   || atomic_read(&current->files->count) > 1
+                   || atomic_read(&current->sig->count) > 1) {
+                       if(!capable(CAP_SETUID)) {
+                               bprm->e_uid = current->uid;
+                               bprm->e_gid = current->gid;
+                       }
+                       if(!capable(CAP_SETPCAP)) {
+                               new_permitted = cap_intersect(new_permitted,
+                                                       current->cap_permitted);
+                       }
+               }
+               do_unlock = 1;
+       }

I have condenced the logic from Linux-2.4.0-test12 to just:
	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);

This change is userspace visible, but I don't expect anyone to care.

For the bug that is being fixed to trigger bprm->unsafe has to be set.
The variable bprm->unsafe is set when ptracing an executable, when
sharing a working directory, or when no_new_privs is set.  Properly
testing for cases that are safe even in those conditions and doing
nothing special should not affect anyone.  Especially if they were
previously ok with their credentials getting munged

To minimize behavioural changes the code continues to set secureexec
when euid != uid or when egid != gid.

Reported-by: Max Kellermann <max.kellermann@ionos.com>
Fixes: 64444d3d0d7f ("Linux version 2.4.0-prerelease")
[1] https://lkml.kernel.org/r/20250306082615.174777-1-max.kellermann@ionos.com
v1: https://lkml.kernel.org/r/878qmxsuy8.fsf@email.froward.int.ebiederm.org
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 security/commoncap.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 28d4248bf001..6bd4adeb4795 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -856,12 +856,6 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 #define __cap_full(field, cred) \
 	cap_issubset(CAP_FULL_SET, cred->cap_##field)
 
-static inline bool __is_setuid(struct cred *new, const struct cred *old)
-{ return !uid_eq(new->euid, old->uid); }
-
-static inline bool __is_setgid(struct cred *new, const struct cred *old)
-{ return !gid_eq(new->egid, old->gid); }
-
 /*
  * 1) Audit candidate if current->cap_effective is set
  *
@@ -891,7 +885,7 @@ static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
 	    (root_privileged() &&
 	     __is_suid(root, new) &&
 	     !__cap_full(effective, new)) ||
-	    (!__is_setuid(new, old) &&
+	    (uid_eq(new->euid, old->euid) &&
 	     ((has_fcap &&
 	       __cap_gained(permitted, new, old)) ||
 	      __cap_gained(ambient, new, old))))
@@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 	/* Process setpcap binaries and capabilities for uid 0 */
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
-	bool effective = false, has_fcap = false, is_setid;
+	bool effective = false, has_fcap = false, id_changed;
 	int ret;
 	kuid_t root_uid;
 
@@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 	 *
 	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
 	 */
-	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
+	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
 
-	if ((is_setid || __cap_gained(permitted, new, old)) &&
+	if ((id_changed || __cap_gained(permitted, new, old)) &&
 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
 	     !ptracer_capable(current, new->user_ns))) {
 		/* downgrade; they get no more than they had, and maybe less */
@@ -960,7 +954,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 	new->sgid = new->fsgid = new->egid;
 
 	/* File caps or setid cancels ambient. */
-	if (has_fcap || is_setid)
+	if (has_fcap || id_changed)
 		cap_clear(new->cap_ambient);
 
 	/*
@@ -993,7 +987,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 		return -EPERM;
 
 	/* Check for privilege-elevated exec. */
-	if (is_setid ||
+	if (id_changed ||
+	    !uid_eq(new->euid, old->uid) ||
+	    !gid_eq(new->egid, old->gid) ||
 	    (!__is_real(root_uid, new) &&
 	     (effective ||
 	      __cap_grew(permitted, ambient, new))))
-- 
2.41.0

