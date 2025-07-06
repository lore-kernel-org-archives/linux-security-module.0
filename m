Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1D13D891
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815121; cv=none; b=uIWtdVTNk0AUVfadLRgkfKKRA6MFvpU90bJbi0CmaY5zSr3VzSPltxbpRK6PDRsQIzydA61AJWUJ8OFV+RLRCrNqt/6NeNKtiIILCtFMXsxGVTxALd6SauGiCYb5JAZStw+erBpN54rxj9Lrnwbd1kW+OD/nm1Kp/uLuBuufv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815121; c=relaxed/simple;
	bh=sKzgJX8tfnwGCfYQaiLWbZaTDfX1HWvO3se1A+7pMu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud4KC2/tZqOLfnZeskyUrm/hZNM3l9LlTOIooRRoaTvStrqzyIFFavYejMgJMCu3CDzYNU/HnOooGVIcO+hPavI09uSjNps8c+WXL+MDXrmEpWTkXtgrNNwbWJbUIQPQo131Nh6CYR5DRvs9MU6XIwdMNwmacSzhYs2Mt9LW+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=BM+WTF5Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eHaCHcwJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="BM+WTF5Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eHaCHcwJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39FA17A015B;
	Sun,  6 Jul 2025 11:18:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 06 Jul 2025 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815118; x=
	1751901518; bh=omngVa2iwqYOGM2CWoDC+ijUNNH2xO04wog7rrRwVbg=; b=B
	M+WTF5ZO3OF/wKXf5EzfRo4rMwmYaRzYRuhYjwHLv3h8Wdtz8JwcCzuWGn4LpHAt
	rCqLBjI8qBjO7aenPF/r6gEf+Kh64jHf9kZTDVDq2fEwcrqPHidpqcbfJ0IVGCo0
	ylDA3TDofRcz2cCEFiUy6VaVUc3/e3+5BLsai+gpQ5xXxlhGu25BrWOFPuH5sTAb
	rESHMUzSix7BAA0cUbsWcaUPiQX+Bk7sGbfjMgLaMan6PENmCGd+NtzgkupFAxT3
	b5wTKIYp/QL9bEDBaxy9Rl21dQp6uRMlhntcMq/8Wd1inAuO6e/sV/ucF5dSuEwA
	mbwAhvisR/IUkb2G9erUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815118; x=1751901518; bh=o
	mngVa2iwqYOGM2CWoDC+ijUNNH2xO04wog7rrRwVbg=; b=eHaCHcwJpm7vTw5FQ
	T5f2UEgk4bngMf973AP7NjyczUnliqnj46XoIx/nz/60bCtZCBkKIK1C9A3xBIXG
	tt1YYEtWKUC36/RBnkpBceAx3E9CDmR8PKa9VIy0qLyX9kSRt4XWyc59kAVZxk4b
	NpqhejzwDgI6Ol9wXn/JbrBsxgskY4tT7cs0UtZJcWgvlvs574i2JVrPR8nql9Pd
	f4fB03cxSo6ppgWQXM4PGiUUw7TbdDIc3HsuZVBEEyvd6dT9gfjk3U5BtocwHWCO
	C/zxFrjLM6tefNe5dabvAeyiePeJIWgh98vH2IWjIzhC9vnjBMK8OspNSx3P2Vup
	S0aRw==
X-ME-Sender: <xms:zZNqaP4HhYC59CYQf3FJD4l21Hd0awvPqn7wW2c3kVWZ5oxSL4lg_g>
    <xme:zZNqaE638CeZgYPWJhDX9NT6Mrq8LvMZuH1Q_b2eJsanD_EZpgi6yZo0L4kD_ENP9
    osEP0-msflPmv0IgBw>
X-ME-Received: <xmr:zZNqaGd4dt1ycvK9LBcdE9rI8t2iBu0HPf47KVaFlY0DQP0UXYh3pj7I9CEu_yFvbvg_1Fw8G58Mm11A1ZmlCqpVHqtGrkYsLjAFGpecqOXgYhMO6KS5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepgfekge
    euleevieeglefgudehveffhfethedvhfeuiefhkeelteehleelffeuueffnecuffhomhgr
    ihhnpehlrgihvghrpghlvghvvghlrdhnvghtpdhmrghskhhsrdhnvghtpdhkvgihrdgurg
    htrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    sehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhho
    rggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehivhgrnhhovhdrmhhikhhhrghilhdusehhuh
    grfigvihdqphgrrhhtnhgvrhhsrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhg
    lhgvrdgtohhm
X-ME-Proxy: <xmx:zZNqaAI6dVHs3mgxv1fCTIciw0rsM225Bo7rbldl-dqYtbhhtKxbLA>
    <xmx:zZNqaDJDI3MNplJulE4QB2ZrEdzTkP7NcqKW9Le39yU1TuQ-30CDAA>
    <xmx:zZNqaJwkYYPaLN4t_Bxfmidkfv8Nz-jjr7Jf2g-OPJzJxVW0rnXf6Q>
    <xmx:zZNqaPJPrrEwclWrDx_7rJIsYYDYbUwYGTKQqBJ1M1DgZ9j4LHYiuw>
    <xmx:zpNqaJRSqOBsFCGtDP1jf_keOXYdLmIfT2x6HZ487qAA0s1DjUf98V35>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:36 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 09/12] landlock: Update various code to use landlock_domain
Date: Sun,  6 Jul 2025 16:16:50 +0100
Message-ID: <8f0e3c5c8e102c33c7fad175c3cd37288fd9a0e9.1751814658.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751814658.git.m@maowtm.org>
References: <cover.1751814658.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Replace domain in landlock_cred with landlock_domain.
- Replace landlock_merge_ruleset with landlock_domain_merge_ruleset.
- Pull landlock_put_hierarchy out of domain.h.
  This allows domain.h to not depend on audit.h, as audit.h -> cred.h will
  need to depend on domain.h instead of ruleset.h after changing it to use
  the new domain struct.
- Update uses of landlock_ruleset-domains to landlock_domain

checkpath seems to not like the `layer_mask_t (*const layer_masks)[]` argument:

	WARNING: function definition argument 'layer_mask_t' should also have an identifier name
	#171: FILE: security/landlock/domain.h:397:
	+bool landlock_unmask_layers(const struct landlock_found_rule rule,

	WARNING: function definition argument 'layer_mask_t' should also have an identifier name
	#176: FILE: security/landlock/domain.h:402:
	+access_mask_t

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/audit.c    |  8 ++--
 security/landlock/cred.c     | 12 +++---
 security/landlock/cred.h     | 14 +++----
 security/landlock/domain.c   | 74 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h   | 64 +++++++++++++++++++++++++++----
 security/landlock/fs.c       | 34 ++++++++---------
 security/landlock/net.c      | 12 +++---
 security/landlock/ruleset.c  | 66 +++-----------------------------
 security/landlock/ruleset.h  | 43 ---------------------
 security/landlock/syscalls.c |  8 ++--
 security/landlock/task.c     | 24 ++++++------
 11 files changed, 190 insertions(+), 169 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77..1ac4a97e5ae0 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -134,7 +134,7 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
 }
 
 static struct landlock_hierarchy *
-get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
+get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
 {
 	struct landlock_hierarchy *hierarchy = domain->hierarchy;
 	ssize_t i;
@@ -167,7 +167,7 @@ static void test_get_hierarchy(struct kunit *const test)
 		.parent = &dom1_hierarchy,
 		.id = 30,
 	};
-	struct landlock_ruleset dom2 = {
+	struct landlock_domain dom2 = {
 		.hierarchy = &dom2_hierarchy,
 		.num_layers = 3,
 	};
@@ -180,7 +180,7 @@ static void test_get_hierarchy(struct kunit *const test)
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
-static size_t get_denied_layer(const struct landlock_ruleset *const domain,
+static size_t get_denied_layer(const struct landlock_domain *const domain,
 			       access_mask_t *const access_request,
 			       const layer_mask_t (*const layer_masks)[],
 			       const size_t layer_masks_size)
@@ -218,7 +218,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 
 static void test_get_denied_layer(struct kunit *const test)
 {
-	const struct landlock_ruleset dom = {
+	const struct landlock_domain dom = {
 		.num_layers = 5,
 	};
 	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..a90b5b895dc0 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -13,7 +13,7 @@
 
 #include "common.h"
 #include "cred.h"
-#include "ruleset.h"
+#include "domain.h"
 #include "setup.h"
 
 static void hook_cred_transfer(struct cred *const new,
@@ -23,7 +23,7 @@ static void hook_cred_transfer(struct cred *const new,
 		landlock_cred(old);
 
 	if (old_llcred->domain) {
-		landlock_get_ruleset(old_llcred->domain);
+		landlock_get_domain(old_llcred->domain);
 		*landlock_cred(new) = *old_llcred;
 	}
 }
@@ -37,10 +37,10 @@ static int hook_cred_prepare(struct cred *const new,
 
 static void hook_cred_free(struct cred *const cred)
 {
-	struct landlock_ruleset *const dom = landlock_cred(cred)->domain;
-
-	if (dom)
-		landlock_put_ruleset_deferred(dom);
+	/*
+	 * landlock_put_domain_deferred does nothing if domain is NULL
+	 */
+	landlock_put_domain_deferred(landlock_cred(cred)->domain);
 }
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c82fe63ec598..2e8aceeed8fe 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -17,7 +17,7 @@
 
 #include "access.h"
 #include "limits.h"
-#include "ruleset.h"
+#include "domain.h"
 #include "setup.h"
 
 /**
@@ -29,9 +29,9 @@
  */
 struct landlock_cred_security {
 	/**
-	 * @domain: Immutable ruleset enforced on a task.
+	 * @domain: Immutable domain enforced on a task.
 	 */
-	struct landlock_ruleset *domain;
+	struct landlock_domain *domain;
 
 #ifdef CONFIG_AUDIT
 	/**
@@ -65,7 +65,7 @@ landlock_cred(const struct cred *cred)
 	return cred->security + landlock_blob_sizes.lbs_cred;
 }
 
-static inline struct landlock_ruleset *landlock_get_current_domain(void)
+static inline struct landlock_domain *landlock_get_current_domain(void)
 {
 	return landlock_cred(current_cred())->domain;
 }
@@ -73,7 +73,7 @@ static inline struct landlock_ruleset *landlock_get_current_domain(void)
 /*
  * The call needs to come from an RCU read-side critical section.
  */
-static inline const struct landlock_ruleset *
+static inline const struct landlock_domain *
 landlock_get_task_domain(const struct task_struct *const task)
 {
 	return landlock_cred(__task_cred(task))->domain;
@@ -114,7 +114,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	const union access_masks_all masks_all = {
 		.masks = masks,
 	};
-	const struct landlock_ruleset *domain;
+	const struct landlock_domain *domain;
 	ssize_t layer_level;
 
 	if (!cred)
@@ -127,7 +127,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	for (layer_level = domain->num_layers - 1; layer_level >= 0;
 	     layer_level--) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = dom_access_masks(domain)[layer_level],
 		};
 
 		if (layer.all & masks_all.all) {
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index da8f1bf00db1..4091e80e45df 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -21,6 +21,7 @@
 #include <linux/uidgid.h>
 
 #include "access.h"
+#include "audit.h"
 #include "common.h"
 #include "domain.h"
 #include "id.h"
@@ -771,6 +772,79 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 	return deny_masks;
 }
 
+void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
+		const struct landlock_hierarchy *const freeme = hierarchy;
+
+		landlock_log_drop_domain(hierarchy);
+		landlock_free_hierarchy_details(hierarchy);
+		hierarchy = hierarchy->parent;
+		kfree(freeme);
+	}
+}
+
+/*
+ * @layer_masks is read and may be updated according to the access request and
+ * the matching rule.
+ * @masks_array_size must be equal to ARRAY_SIZE(*layer_masks).
+ *
+ * Returns true if the request is allowed (i.e. relevant layer masks for the
+ * request are empty).
+ */
+bool landlock_unmask_layers(const struct landlock_found_rule rule,
+			    const access_mask_t access_request,
+			    layer_mask_t (*const layer_masks)[],
+			    const size_t masks_array_size)
+{
+	const struct landlock_layer *layer;
+
+	if (!access_request || !layer_masks)
+		return true;
+
+	if (rule.layers_start == rule.layers_end)
+		return false;
+
+	if (WARN_ON_ONCE(rule.layers_start > rule.layers_end))
+		return false;
+
+	/* We should not have layers_start being NULL but layers_end not */
+	if (WARN_ON_ONCE(rule.layers_start == NULL))
+		return false;
+
+	/*
+	 * An access is granted if, for each policy layer, at least one rule
+	 * encountered on the pathwalk grants the requested access,
+	 * regardless of its position in the layer stack.  We must then check
+	 * the remaining layers for each inode, from the first added layer to
+	 * the last one.  When there is multiple requested accesses, for each
+	 * policy layer, the full set of requested accesses may not be granted
+	 * by only one rule, but by the union (binary OR) of multiple rules.
+	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
+	 */
+	dom_rule_for_each_layer(rule, layer)
+	{
+		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
+		const unsigned long access_req = access_request;
+		unsigned long access_bit;
+		bool is_empty;
+
+		/*
+		 * Records in @layer_masks which layer grants access to each
+		 * requested access.
+		 */
+		is_empty = true;
+		for_each_set_bit(access_bit, &access_req, masks_array_size) {
+			if (layer->access & BIT_ULL(access_bit))
+				(*layer_masks)[access_bit] &= ~layer_bit;
+			is_empty = is_empty && !(*layer_masks)[access_bit];
+		}
+		if (is_empty)
+			return true;
+	}
+	return false;
+}
+
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
 static void test_landlock_get_deny_masks(struct kunit *const test)
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 1d9608439781..ac820903ccb6 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 
 #include "access.h"
-#include "audit.h"
 #include "ruleset.h"
 #include "coalesced_hash.h"
 
@@ -393,16 +392,65 @@ landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
 		refcount_inc(&hierarchy->usage);
 }
 
-static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
+void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy);
+
+bool landlock_unmask_layers(const struct landlock_found_rule rule,
+			    const access_mask_t access_request,
+			    layer_mask_t (*const layer_masks)[],
+			    const size_t masks_array_size);
+
+access_mask_t
+landlock_init_layer_masks(const struct landlock_domain *const domain,
+			  const access_mask_t access_request,
+			  layer_mask_t (*const layer_masks)[],
+			  const enum landlock_key_type key_type);
+
+static inline access_mask_t
+landlock_dom_get_fs_access_mask(const struct landlock_domain *const domain,
+				const u16 layer_level)
+{
+	/* Handles all initially denied by default access rights. */
+	return dom_access_masks(domain)[layer_level].fs |
+	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+}
+
+static inline access_mask_t
+landlock_dom_get_net_access_mask(const struct landlock_domain *const domain,
+				 const u16 layer_level)
+{
+	return dom_access_masks(domain)[layer_level].net;
+}
+
+static inline access_mask_t
+landlock_dom_get_scope_mask(const struct landlock_domain *const domain,
+			    const u16 layer_level)
 {
-	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
-		const struct landlock_hierarchy *const freeme = hierarchy;
+	return dom_access_masks(domain)[layer_level].scope;
+}
 
-		landlock_log_drop_domain(hierarchy);
-		landlock_free_hierarchy_details(hierarchy);
-		hierarchy = hierarchy->parent;
-		kfree(freeme);
+/**
+ * landlock_dom_union_access_masks - Return all access rights handled in
+ * the domain
+ *
+ * @domain: Landlock domain
+ *
+ * Returns: an access_masks result of the OR of all the domain's access masks.
+ */
+static inline struct access_masks
+landlock_dom_union_access_masks(const struct landlock_domain *const domain)
+{
+	union access_masks_all matches = {};
+	size_t layer_level;
+
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
+		union access_masks_all layer = {
+			.masks = dom_access_masks(domain)[layer_level],
+		};
+
+		matches.all |= layer.all;
 	}
+
+	return matches.masks;
 }
 
 #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 51f03eb82069..4e18936eecbd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -360,26 +360,24 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
  *
  * Returns NULL if no rule is found or if @dentry is negative.
  */
-static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
+static struct landlock_found_rule
+find_rule(const struct landlock_domain *const domain,
 	  const struct dentry *const dentry)
 {
-	const struct landlock_rule *rule;
 	const struct inode *inode;
-	struct landlock_id id = {
-		.type = LANDLOCK_KEY_INODE,
-	};
+	union landlock_key key;
+	struct landlock_found_rule found_rule = {};
 
 	/* Ignores nonexistent leafs. */
 	if (d_is_negative(dentry))
-		return NULL;
+		return found_rule;
 
 	inode = d_backing_inode(dentry);
 	rcu_read_lock();
-	id.key.object = rcu_dereference(landlock_inode(inode)->object);
-	rule = landlock_find_rule(domain, id);
+	key.object = rcu_dereference(landlock_inode(inode)->object);
+	found_rule = dom_find_index_fs(domain, key);
 	rcu_read_unlock();
-	return rule;
+	return found_rule;
 }
 
 /*
@@ -752,7 +750,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  * - false otherwise.
  */
 static bool is_access_to_paths_allowed(
-	const struct landlock_ruleset *const domain,
+	const struct landlock_domain *const domain,
 	const struct path *const path,
 	const access_mask_t access_request_parent1,
 	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
@@ -800,7 +798,7 @@ static bool is_access_to_paths_allowed(
 		 * a superset of the meaningful requested accesses).
 		 */
 		access_masked_parent1 = access_masked_parent2 =
-			landlock_union_access_masks(domain).fs;
+			landlock_dom_union_access_masks(domain).fs;
 		is_dom_check = true;
 		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
 		       sizeof(_layer_masks_parent2_bkp));
@@ -844,7 +842,7 @@ static bool is_access_to_paths_allowed(
 	 */
 	while (true) {
 		struct dentry *parent_dentry;
-		const struct landlock_rule *rule;
+		struct landlock_found_rule rule;
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -1102,7 +1100,7 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * - false if the walk reached @mnt_root.
  */
 static bool collect_domain_accesses(
-	const struct landlock_ruleset *const domain,
+	const struct landlock_domain *const domain,
 	const struct path *const mnt_dir, struct dentry *dir,
 	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
 {
@@ -1881,7 +1879,7 @@ static bool control_current_fowner(struct fown_struct *const fown)
 
 static void hook_file_set_fowner(struct file *file)
 {
-	struct landlock_ruleset *prev_dom;
+	struct landlock_domain *prev_dom;
 	struct landlock_cred_security fown_subject = {};
 	size_t fown_layer = 0;
 
@@ -1893,7 +1891,7 @@ static void hook_file_set_fowner(struct file *file)
 			landlock_get_applicable_subject(
 				current_cred(), signal_scope, &fown_layer);
 		if (new_subject) {
-			landlock_get_ruleset(new_subject->domain);
+			landlock_get_domain(new_subject->domain);
 			fown_subject = *new_subject;
 		}
 	}
@@ -1905,12 +1903,12 @@ static void hook_file_set_fowner(struct file *file)
 #endif /* CONFIG_AUDIT*/
 
 	/* May be called in an RCU read-side critical section. */
-	landlock_put_ruleset_deferred(prev_dom);
+	landlock_put_domain_deferred(prev_dom);
 }
 
 static void hook_file_free_security(struct file *file)
 {
-	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
+	landlock_put_domain_deferred(landlock_file(file)->fown_subject.domain);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1f3915a90a80..411b810dd695 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -48,10 +48,8 @@ static int current_check_access_socket(struct socket *const sock,
 {
 	__be16 port;
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
-	const struct landlock_rule *rule;
-	struct landlock_id id = {
-		.type = LANDLOCK_KEY_NET_PORT,
-	};
+	struct landlock_found_rule rule;
+	union landlock_key key;
 	const struct access_masks masks = {
 		.net = access_request,
 	};
@@ -171,10 +169,10 @@ static int current_check_access_socket(struct socket *const sock,
 			return -EINVAL;
 	}
 
-	id.key.data = (__force uintptr_t)port;
-	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
+	key.data = (__force uintptr_t)port;
+	BUILD_BUG_ON(sizeof(port) > sizeof(key.data));
 
-	rule = landlock_find_rule(subject->domain, id);
+	rule = dom_find_index_net(subject->domain, key);
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 12fcea6a2a99..6bea1cc16b62 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -591,63 +591,9 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 	return landlock_find_in_tree(root, id.key);
 }
 
-/*
- * @layer_masks is read and may be updated according to the access request and
- * the matching rule.
- * @masks_array_size must be equal to ARRAY_SIZE(*layer_masks).
- *
- * Returns true if the request is allowed (i.e. relevant layer masks for the
- * request are empty).
- */
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    const access_mask_t access_request,
-			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size)
-{
-	size_t layer_level;
-
-	if (!access_request || !layer_masks)
-		return true;
-	if (!rule)
-		return false;
-
-	/*
-	 * An access is granted if, for each policy layer, at least one rule
-	 * encountered on the pathwalk grants the requested access,
-	 * regardless of its position in the layer stack.  We must then check
-	 * the remaining layers for each inode, from the first added layer to
-	 * the last one.  When there is multiple requested accesses, for each
-	 * policy layer, the full set of requested accesses may not be granted
-	 * by only one rule, but by the union (binary OR) of multiple rules.
-	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
-	 */
-	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
-		const struct landlock_layer *const layer =
-			&rule->layers[layer_level];
-		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
-		const unsigned long access_req = access_request;
-		unsigned long access_bit;
-		bool is_empty;
-
-		/*
-		 * Records in @layer_masks which layer grants access to each
-		 * requested access.
-		 */
-		is_empty = true;
-		for_each_set_bit(access_bit, &access_req, masks_array_size) {
-			if (layer->access & BIT_ULL(access_bit))
-				(*layer_masks)[access_bit] &= ~layer_bit;
-			is_empty = is_empty && !(*layer_masks)[access_bit];
-		}
-		if (is_empty)
-			return true;
-	}
-	return false;
-}
-
 typedef access_mask_t
-get_access_mask_t(const struct landlock_ruleset *const ruleset,
-		  const u16 layer_level);
+get_dom_access_mask_t(const struct landlock_domain *const domain,
+		      const u16 layer_level);
 
 /**
  * landlock_init_layer_masks - Initialize layer masks from an access request
@@ -665,24 +611,24 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
  * in any of the active layers in @domain.
  */
 access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+landlock_init_layer_masks(const struct landlock_domain *const domain,
 			  const access_mask_t access_request,
 			  layer_mask_t (*const layer_masks)[],
 			  const enum landlock_key_type key_type)
 {
 	access_mask_t handled_accesses = 0;
 	size_t layer_level, num_access;
-	get_access_mask_t *get_access_mask;
+	get_dom_access_mask_t *get_access_mask;
 
 	switch (key_type) {
 	case LANDLOCK_KEY_INODE:
-		get_access_mask = landlock_get_fs_access_mask;
+		get_access_mask = landlock_dom_get_fs_access_mask;
 		num_access = LANDLOCK_NUM_ACCESS_FS;
 		break;
 
 #if IS_ENABLED(CONFIG_INET)
 	case LANDLOCK_KEY_NET_PORT:
-		get_access_mask = landlock_get_net_access_mask;
+		get_access_mask = landlock_dom_get_net_access_mask;
 		num_access = LANDLOCK_NUM_ACCESS_NET;
 		break;
 #endif /* IS_ENABLED(CONFIG_INET) */
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index e45abff968c5..418d18869916 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -238,31 +238,6 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
-/**
- * landlock_union_access_masks - Return all access rights handled in the
- *				 domain
- *
- * @domain: Landlock ruleset (used as a domain)
- *
- * Returns: an access_masks result of the OR of all the domain's access masks.
- */
-static inline struct access_masks
-landlock_union_access_masks(const struct landlock_ruleset *const domain)
-{
-	union access_masks_all matches = {};
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
-		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
-		};
-
-		matches.all |= layer.all;
-	}
-
-	return matches.masks;
-}
-
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -314,22 +289,4 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].net;
 }
 
-static inline access_mask_t
-landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
-			const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].scope;
-}
-
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    const access_mask_t access_request,
-			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size);
-
-access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-			  const access_mask_t access_request,
-			  layer_mask_t (*const layer_masks)[],
-			  const enum landlock_key_type key_type);
-
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 33eafb71e4f3..2b148cbff456 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -479,8 +479,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
 {
-	struct landlock_ruleset *new_dom,
-		*ruleset __free(landlock_put_ruleset) = NULL;
+	struct landlock_domain *new_dom;
+	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
@@ -546,7 +546,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	 * There is no possible race condition while copying and manipulating
 	 * the current credentials because they are dedicated per thread.
 	 */
-	new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
+	new_dom = landlock_domain_merge_ruleset(new_llcred->domain, ruleset);
 	if (IS_ERR(new_dom)) {
 		abort_creds(new_cred);
 		return PTR_ERR(new_dom);
@@ -560,7 +560,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 #endif /* CONFIG_AUDIT */
 
 	/* Replaces the old (prepared) domain. */
-	landlock_put_ruleset(new_llcred->domain);
+	landlock_put_domain(new_llcred->domain);
 	new_llcred->domain = new_dom;
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..d79919c1fec3 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -38,8 +38,8 @@
  * Checks if the @parent domain is less or equal to (i.e. an ancestor, which
  * means a subset of) the @child domain.
  */
-static bool domain_scope_le(const struct landlock_ruleset *const parent,
-			    const struct landlock_ruleset *const child)
+static bool domain_scope_le(const struct landlock_domain *const parent,
+			    const struct landlock_domain *const child)
 {
 	const struct landlock_hierarchy *walker;
 
@@ -60,8 +60,8 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
 	return false;
 }
 
-static int domain_ptrace(const struct landlock_ruleset *const parent,
-			 const struct landlock_ruleset *const child)
+static int domain_ptrace(const struct landlock_domain *const parent,
+			 const struct landlock_domain *const child)
 {
 	if (domain_scope_le(parent, child))
 		return 0;
@@ -86,7 +86,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
 	const struct landlock_cred_security *parent_subject;
-	const struct landlock_ruleset *child_dom;
+	const struct landlock_domain *child_dom;
 	int err;
 
 	/* Quick return for non-landlocked tasks. */
@@ -135,7 +135,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
 	const struct landlock_cred_security *parent_subject;
-	const struct landlock_ruleset *child_dom;
+	const struct landlock_domain *child_dom;
 	int err;
 
 	child_dom = landlock_get_current_domain();
@@ -176,8 +176,8 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
  * Returns: True if the @client domain is scoped to access the @server,
  * unless the @server is also scoped in the same domain as @client.
  */
-static bool domain_is_scoped(const struct landlock_ruleset *const client,
-			     const struct landlock_ruleset *const server,
+static bool domain_is_scoped(const struct landlock_domain *const client,
+			     const struct landlock_domain *const server,
 			     access_mask_t scope)
 {
 	int client_layer, server_layer;
@@ -204,7 +204,7 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 	 * parent domains are scoped.
 	 */
 	for (; client_layer > server_layer; client_layer--) {
-		if (landlock_get_scope_mask(client, client_layer) & scope)
+		if (landlock_dom_get_scope_mask(client, client_layer) & scope)
 			return true;
 
 		client_walker = client_walker->parent;
@@ -217,7 +217,7 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 		server_walker = server_walker->parent;
 
 	for (; client_layer >= 0; client_layer--) {
-		if (landlock_get_scope_mask(client, client_layer) & scope) {
+		if (landlock_dom_get_scope_mask(client, client_layer) & scope) {
 			/*
 			 * Client and server are at the same level in the
 			 * hierarchy. If the client is scoped, the request is
@@ -233,9 +233,9 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 }
 
 static bool sock_is_scoped(struct sock *const other,
-			   const struct landlock_ruleset *const domain)
+			   const struct landlock_domain *const domain)
 {
-	const struct landlock_ruleset *dom_other;
+	const struct landlock_domain *dom_other;
 
 	/* The credentials will not change. */
 	lockdep_assert_held(&unix_sk(other)->lock);
-- 
2.49.0

