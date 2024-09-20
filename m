Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131995D915;
	Fri, 20 Sep 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726876532; cv=none; b=UA33kXoKajmKcMkpjJhhzA2IRzgNr+5N+e9zOzVsDcK6EAeUJTXxIogVbqXAJZILen9Yww5Zq9PxFKvBbMH/d8nh+3S+2RX4IUlNhwunoXE4rxIUMA2M1k3yxYOIO4fkY2L8t/ZzcILI0PAiO8YVpO8RwYxSoJNzbp/dH+PRM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726876532; c=relaxed/simple;
	bh=ijrbY3ZZ7HoBDDhAhtuhLWl0QOxopBz+m40Hi/DkfPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCwK6bGupEVckzhKaQvQPLz0E8s6bVoQVApf+7ndk+m50XT41XUiDNMp34KUeixetFS1DmqueElXmgSOYv7e908AOZmDd4To78Mbjl0aau/KTb+Qj1BVCjtfyAoorWpRdsXvZLdvIpuCxHajYPYVDBbaZs2xC6R8m9/yVkAoNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=M10M5avL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="M10M5avL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=RVpptJYwvyg0fb6+nU4iNmMhoQWwZ5J0eYvDJ7HEuD0=; b=M10M5avLZBngZGup
	5/2gLhZ7FHOuMj1sp8pB8h3R4SkOE4wP5VDi9xpAo9cYgZimDEX0jJVUffjv5EfLL8OUe1RO/rant
	j3uR3fS3iJD/ELJ8WiPNs1Puy7lU4stGsbgHu2BhFt7QnFvXqyaSY3a23B9fb3/s7Q17CI8QsAHTn
	d7MGEC/KdKUWfPXJY/0DF3Ox4XaqRFF8upCL8jLhPCHvYaXONuEVfTOXsa8M/mmSoQo5wTRJ75yxR
	UCFcNiKDXHQ36FOoXxM64LRmQ1fmA6fVK3liqgm7Mb8f2ADXNbopnKG06VVofIBtXRZcqV/n7mRXt
	wKGEcrHEMCB/kqD39g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1srnT4-006btn-0i;
	Fri, 20 Sep 2024 23:55:18 +0000
From: linux@treblig.org
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] apparmor: Remove deadcode
Date: Sat, 21 Sep 2024 00:55:17 +0100
Message-ID: <20240920235517.615309-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

aa_label_audit, aa_label_find, aa_label_seq_print and aa_update_label_name
were added by commit
f1bd904175e8 ("apparmor: add the base fns() for domain labels")
but never used.

aa_profile_label_perm was added by commit
637f688dc3dc ("apparmor: switch from profiles to using labels on contexts")
but never used.

aa_secid_update was added by commit
c092921219d2 ("apparmor: add support for mapping secids and using secctxes")
but never used.

aa_split_fqname has been unused since commit
3664268f19ea ("apparmor: add namespace lookup fns()")

aa_lookup_profile has been unused since commit
93c98a484c49 ("apparmor: move exec domain mediation to using labels")

aa_audit_perms_cb was only used by aa_profile_label_perm (see above).

All of these commits are from around 2017.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 security/apparmor/include/label.h  |  4 --
 security/apparmor/include/lib.h    |  1 -
 security/apparmor/include/perms.h  |  3 --
 security/apparmor/include/policy.h |  1 -
 security/apparmor/include/secid.h  |  1 -
 security/apparmor/label.c          | 33 ------------
 security/apparmor/lib.c            | 84 ------------------------------
 security/apparmor/policy.c         |  5 --
 security/apparmor/secid.c          | 14 -----
 9 files changed, 146 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 2a72e6b17d68..83a840d935bc 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -291,8 +291,6 @@ bool aa_label_replace(struct aa_label *old, struct aa_label *new);
 bool aa_label_make_newest(struct aa_labelset *ls, struct aa_label *old,
 			  struct aa_label *new);
 
-struct aa_label *aa_label_find(struct aa_label *l);
-
 struct aa_profile *aa_label_next_in_merge(struct label_it *I,
 					  struct aa_label *a,
 					  struct aa_label *b);
@@ -320,8 +318,6 @@ void aa_label_seq_xprint(struct seq_file *f, struct aa_ns *ns,
 			 struct aa_label *label, int flags, gfp_t gfp);
 void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
 		      gfp_t gfp);
-void aa_label_audit(struct audit_buffer *ab, struct aa_label *label, gfp_t gfp);
-void aa_label_seq_print(struct seq_file *f, struct aa_label *label, gfp_t gfp);
 void aa_label_printk(struct aa_label *label, gfp_t gfp);
 
 struct aa_label *aa_label_strn_parse(struct aa_label *base, const char *str,
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index d7a894b1031f..f11a0db7f51d 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -59,7 +59,6 @@ extern int apparmor_initialized;
 
 /* fn's in lib */
 const char *skipn_spaces(const char *str, size_t n);
-char *aa_split_fqname(char *args, char **ns_name);
 const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
 			     size_t *ns_len);
 void aa_info_message(const char *str);
diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
index 0f7e913c3fc2..bbaa7d39a39a 100644
--- a/security/apparmor/include/perms.h
+++ b/security/apparmor/include/perms.h
@@ -213,9 +213,6 @@ void aa_perms_accum_raw(struct aa_perms *accum, struct aa_perms *addend);
 void aa_profile_match_label(struct aa_profile *profile,
 			    struct aa_ruleset *rules, struct aa_label *label,
 			    int type, u32 request, struct aa_perms *perms);
-int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
-			  u32 request, int type, u32 *deny,
-			  struct apparmor_audit_data *ad);
 int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
 		   u32 request, struct apparmor_audit_data *ad,
 		   void (*cb)(struct audit_buffer *, void *));
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 75088cc310b6..757e3c232c57 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -264,7 +264,6 @@ void aa_free_profile(struct aa_profile *profile);
 struct aa_profile *aa_find_child(struct aa_profile *parent, const char *name);
 struct aa_profile *aa_lookupn_profile(struct aa_ns *ns, const char *hname,
 				      size_t n);
-struct aa_profile *aa_lookup_profile(struct aa_ns *ns, const char *name);
 struct aa_profile *aa_fqlookupn_profile(struct aa_label *base,
 					const char *fqname, size_t n);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index a912a5d5d04f..b49dd0253118 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -32,6 +32,5 @@ void apparmor_release_secctx(char *secdata, u32 seclen);
 
 int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
 void aa_free_secid(u32 secid);
-void aa_secid_update(u32 secid, struct aa_label *label);
 
 #endif /* __AA_SECID_H */
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index c71e4615dd46..91483ecacc16 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -899,23 +899,6 @@ struct aa_label *aa_vec_find_or_create_label(struct aa_profile **vec, int len,
 	return vec_create_and_insert_label(vec, len, gfp);
 }
 
-/**
- * aa_label_find - find label @label in label set
- * @label: label to find (NOT NULL)
- *
- * Requires: caller to hold a valid ref on l
- *
- * Returns: refcounted @label if @label is in tree
- *          refcounted label that is equiv to @label in tree
- *     else NULL if @label or equiv is not in tree
- */
-struct aa_label *aa_label_find(struct aa_label *label)
-{
-	AA_BUG(!label);
-
-	return vec_find(label->vec, label->size);
-}
-
 
 /**
  * aa_label_insert - insert label @label into @ls or return existing label
@@ -1811,22 +1794,6 @@ void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
 		pr_info("%s", label->hname);
 }
 
-void aa_label_audit(struct audit_buffer *ab, struct aa_label *label, gfp_t gfp)
-{
-	struct aa_ns *ns = aa_get_current_ns();
-
-	aa_label_xaudit(ab, ns, label, FLAG_VIEW_SUBNS, gfp);
-	aa_put_ns(ns);
-}
-
-void aa_label_seq_print(struct seq_file *f, struct aa_label *label, gfp_t gfp)
-{
-	struct aa_ns *ns = aa_get_current_ns();
-
-	aa_label_seq_xprint(f, ns, label, FLAG_VIEW_SUBNS, gfp);
-	aa_put_ns(ns);
-}
-
 void aa_label_printk(struct aa_label *label, gfp_t gfp)
 {
 	struct aa_ns *ns = aa_get_current_ns();
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index cd569fbbfe36..7db62213e352 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -45,44 +45,6 @@ void aa_free_str_table(struct aa_str_table *t)
 	}
 }
 
-/**
- * aa_split_fqname - split a fqname into a profile and namespace name
- * @fqname: a full qualified name in namespace profile format (NOT NULL)
- * @ns_name: pointer to portion of the string containing the ns name (NOT NULL)
- *
- * Returns: profile name or NULL if one is not specified
- *
- * Split a namespace name from a profile name (see policy.c for naming
- * description).  If a portion of the name is missing it returns NULL for
- * that portion.
- *
- * NOTE: may modify the @fqname string.  The pointers returned point
- *       into the @fqname string.
- */
-char *aa_split_fqname(char *fqname, char **ns_name)
-{
-	char *name = strim(fqname);
-
-	*ns_name = NULL;
-	if (name[0] == ':') {
-		char *split = strchr(&name[1], ':');
-		*ns_name = skip_spaces(&name[1]);
-		if (split) {
-			/* overwrite ':' with \0 */
-			*split++ = 0;
-			if (strncmp(split, "//", 2) == 0)
-				split += 2;
-			name = skip_spaces(split);
-		} else
-			/* a ns name without a following profile is allowed */
-			name = NULL;
-	}
-	if (name && *name == 0)
-		name = NULL;
-
-	return name;
-}
-
 /**
  * skipn_spaces - Removes leading whitespace from @str.
  * @str: The string to be stripped.
@@ -275,33 +237,6 @@ void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
 	audit_log_format(ab, "\"");
 }
 
-/**
- * aa_audit_perms_cb - generic callback fn for auditing perms
- * @ab: audit buffer (NOT NULL)
- * @va: audit struct to audit values of (NOT NULL)
- */
-static void aa_audit_perms_cb(struct audit_buffer *ab, void *va)
-{
-	struct common_audit_data *sa = va;
-	struct apparmor_audit_data *ad = aad(sa);
-
-	if (ad->request) {
-		audit_log_format(ab, " requested_mask=");
-		aa_audit_perm_mask(ab, ad->request, aa_file_perm_chrs,
-				   PERMS_CHRS_MASK, aa_file_perm_names,
-				   PERMS_NAMES_MASK);
-	}
-	if (ad->denied) {
-		audit_log_format(ab, "denied_mask=");
-		aa_audit_perm_mask(ab, ad->denied, aa_file_perm_chrs,
-				   PERMS_CHRS_MASK, aa_file_perm_names,
-				   PERMS_NAMES_MASK);
-	}
-	audit_log_format(ab, " peer=");
-	aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
-				      FLAGS_NONE, GFP_ATOMIC);
-}
-
 /**
  * aa_apply_modes_to_perms - apply namespace and profile flags to perms
  * @profile: that perms where computed from
@@ -349,25 +284,6 @@ void aa_profile_match_label(struct aa_profile *profile,
 }
 
 
-/* currently unused */
-int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
-			  u32 request, int type, u32 *deny,
-			  struct apparmor_audit_data *ad)
-{
-	struct aa_ruleset *rules = list_first_entry(&profile->rules,
-						    typeof(*rules), list);
-	struct aa_perms perms;
-
-	ad->peer = &target->label;
-	ad->request = request;
-
-	aa_profile_match_label(profile, rules, &target->label, type, request,
-			       &perms);
-	aa_apply_modes_to_perms(profile, &perms);
-	*deny |= request & perms.deny;
-	return aa_check_perms(profile, &perms, request, ad, aa_audit_perms_cb);
-}
-
 /**
  * aa_check_perms - do audit mode selection based on perms set
  * @profile: profile being checked
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 14df15e35695..74c854e8889f 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -580,11 +580,6 @@ struct aa_profile *aa_lookupn_profile(struct aa_ns *ns, const char *hname,
 	return profile;
 }
 
-struct aa_profile *aa_lookup_profile(struct aa_ns *ns, const char *hname)
-{
-	return aa_lookupn_profile(ns, hname, strlen(hname));
-}
-
 struct aa_profile *aa_fqlookupn_profile(struct aa_label *base,
 					const char *fqname, size_t n)
 {
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 83d3d1e6d9dc..a52c789d4f18 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -39,20 +39,6 @@ int apparmor_display_secid_mode;
  * TODO: use secid_update in label replace
  */
 
-/**
- * aa_secid_update - update a secid mapping to a new label
- * @secid: secid to update
- * @label: label the secid will now map to
- */
-void aa_secid_update(u32 secid, struct aa_label *label)
-{
-	unsigned long flags;
-
-	xa_lock_irqsave(&aa_secids, flags);
-	__xa_store(&aa_secids, secid, label, 0);
-	xa_unlock_irqrestore(&aa_secids, flags);
-}
-
 /*
  * see label for inverse aa_label_to_secid
  */
-- 
2.46.1

