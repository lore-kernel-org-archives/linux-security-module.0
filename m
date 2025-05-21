Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0B28F955
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856095; cv=none; b=oA7xPNkZg8a12eO4vRJU2CKMqVDw0GQXVvpjmzBYNzP8Hb+mJ1OxwfHQC+OZVYbSTqDeJ+Q9Plzf7GndOdWb0P8RDtu8l3fdk++ouYfOMmvahNQR35W3Ki4PJj1QGMIPQoVudla8Tlv6tdSjOQF775Xw9V00SR8i0gjHVrEWCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856095; c=relaxed/simple;
	bh=9Egqjwe1R5YjJeGxfS4fx+d6TZzbgWSmeWy27LpH1do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WghglS+sE3IqkYXQaxtr8UXq4madOV7BrzjmnQ0qXAV2oitfdfWmJ64a/ps6kWiP+pnGhtKMlnW2liC01hgs0NEd42Rw5A8KFWr6PZHUXIRlSirJ/+YZyggqMF5xQkqzuvntb8xQTv9j7flUp1IlCp1OkZIMISmjikNO1tm/WSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=vSJDwavk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKQJldXR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="vSJDwavk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKQJldXR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3728114013F;
	Wed, 21 May 2025 15:34:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 21 May 2025 15:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856092; x=
	1747942492; bh=TTkHes3P+At9TK3TwtambVEVASINbXMZi7l2N46hEgg=; b=v
	SJDwavkQrTkbIMcszhoiYZQDQb0tbRJkhiGv8zk4m70MFyWSDrQWiwOJCfSL1tKH
	qRPDzCCUwnmrcmy6NaMU6N9oQ505Pe9SvY5by5xhn3El9JqVASDJ5DidskhsjRR7
	p7wVEsh8GLyAGPMCMs30dTLNgqKk2O42OzTyYSa3sn6kI9M0RhxI/5Z9CoHPZTWw
	eHhZVKOTLS0/KZdmllXViGcQnQfDzZuWo4aftwrR+2uBAeP5VBngwxZkKk86Ty2l
	SFyP0WfKRfL+/AWru2YO8QmKC8N7qTcMPkqA/nprgLOZerOaHmrK5ZGNOH7Hhbbr
	6gcia1gEhA4LxvsoHZj0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856092; x=1747942492; bh=T
	TkHes3P+At9TK3TwtambVEVASINbXMZi7l2N46hEgg=; b=hKQJldXRoWAw0hiTa
	bleC068m5S/GANSkAMfPIiKGMruz3nO9QTfHxyo4coU0N1Am+D0MI2+p63snZ6FL
	dtBo07AB/GquDYjoCDpM19yOhK7qdWhxsbs7hb+k9L31bgIK1EO+J8ebzvJLpv2v
	6cG5ms2Lyeax7d/k5PZR1/MzZFkrUAp/1gDNIRnD0+MeKdRXF1pGiByNo7kjQ0yO
	01+Wyy5Mr8z8GpN7fSRLkGwd49nw2VQvbmjHW+W99HC9y2xKcpljlQ/h+zEOMEOD
	Sa6SL+VEV0JZwxNO5ceBDhuOjNnN8Yi2wPS5ob0g6GXET7OfIqcYEw5KReYWMykH
	zuWIA==
X-ME-Sender: <xms:3CouaLq6LKaoX5Ju2vNxfSfFCNgZGWGE0h2O1T66fCUWby7ucuit3Q>
    <xme:3CouaFq5PKgCvL5elBT6jdHKaaa0GzS8Wet5nTxbM1SOviAHc8pPNe6CLY47XOF9P
    cosqvqAWGxY4CrZSTs>
X-ME-Received: <xmr:3CouaIMfuhI047T-ZnGQcKmKPRtnBGy3WfR1jnWIbp_fvnoCXjrZU831zIcMO5yH8weMf6aj5tWB4buhF2fQYOy4XvisSd4-0G7WhpGuG99pQTAaPP-AYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleegucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmh
    grohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddv
    teefffegteetueegueeljeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurh
    hithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3CouaO6INh1-Sn3VkQRr86-K2iQz_LB9hwbZMBeYO9s2pCPq9U2YrA>
    <xmx:3CouaK7l6Up9QsRjHoSQ9_3z1AvihBQ8mjvM34wWgElDSTG7Sgj-EQ>
    <xmx:3CouaGi7PytCrqjXLne5qEkTN8ts2hnZykaSTEDu4erZ8VtH_yCX6g>
    <xmx:3CouaM7M_xISO6UPRTFtdck643PVvEx9xP2akHydZHkcEw-HfPnuCg>
    <xmx:3CouaIbVNakvt3lXfLRIqywElyHNyjOmkGiCLdd54cvyUB5DrncRB0WB>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:51 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 08/10] landlock: Construct the inode hashtable in the new landlock_domain
Date: Wed, 21 May 2025 20:32:04 +0100
Message-ID: <e0fcfb45accc387fb0c6a4deca2724fc531b7bd0.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we can't get rid of the old landlock_merge_ruleset yet, we call our
new thing landlock_merge_ruleset2.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c   |  87 +++++++++++++++++++++++++++++
 security/landlock/domain.h   |   4 ++
 security/landlock/hash.h     | 105 +++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.h  |   2 +-
 security/landlock/syscalls.c |   9 +++
 5 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 321c52b275fc..fae21b260591 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -77,6 +77,93 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 	}
 }
 
+/**
+ * @curr_table may be NULL.
+ */
+static int merge_domain_table(const enum landlock_key_type key_type,
+			      const struct landlock_hashtable *const curr_table,
+			      struct landlock_hashtable *const new_table,
+			      struct landlock_layer new_layer,
+			      const struct rb_root *ruleset_rb_root)
+{
+	int err;
+	struct landlock_rule *iter, *iter2;
+
+	if (curr_table) {
+		err = landlock_hash_clone(new_table, curr_table, key_type);
+		if (err) {
+			return err;
+		}
+	}
+
+	/* Merge in new rules */
+	rbtree_postorder_for_each_entry_safe(iter, iter2, ruleset_rb_root,
+					     node) {
+		WARN_ON_ONCE(iter->layers[0].level != 0);
+		WARN_ON_ONCE(iter->num_layers != 1);
+		new_layer.access = iter->layers[0].access;
+
+		err = landlock_hash_upsert(new_table, iter->key, key_type,
+					   new_layer);
+		if (err) {
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * @landlock_merge_ruleset2 - Merge a ruleset with a (possibly NULL)
+ * domain, and return a new merged domain.
+ */
+struct landlock_domain *
+landlock_merge_ruleset2(const struct landlock_domain *curr_domain,
+			const struct landlock_ruleset *next_ruleset)
+{
+	size_t num_inodes = 0;
+	int err;
+	struct landlock_domain *new_domain;
+	struct landlock_layer new_layer = {
+		.level = 1,
+	};
+	struct landlock_rule *iter, *iter2;
+
+	if (WARN_ON_ONCE(!next_ruleset)) {
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (curr_domain) {
+		new_layer.level = curr_domain->num_layers + 1;
+		num_inodes = landlock_hash_count(&curr_domain->inode_table);
+	}
+
+	/* Find new expected size of inode table */
+	rbtree_postorder_for_each_entry_safe(iter, iter2,
+					     &next_ruleset->root_inode, node) {
+		if (!curr_domain ||
+		    landlock_hash_find(&curr_domain->inode_table, iter->key) ==
+			    NULL) {
+			num_inodes += 1;
+		}
+	}
+
+	new_domain = landlock_alloc_domain(num_inodes, new_layer.level);
+	if (!new_domain)
+		return ERR_PTR(-ENOMEM);
+
+	err = merge_domain_table(LANDLOCK_KEY_INODE,
+				 curr_domain ? &curr_domain->inode_table : NULL,
+				 &new_domain->inode_table, new_layer,
+				 &next_ruleset->root_inode);
+	if (err) {
+		landlock_put_domain(new_domain);
+		return ERR_PTR(err);
+	}
+
+	return new_domain;
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 944420231040..e52b32d8dd2b 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -62,6 +62,10 @@ void landlock_put_domain(struct landlock_domain *const domain);
 
 void landlock_put_domain_deferred(struct landlock_domain *const domain);
 
+struct landlock_domain *
+landlock_merge_ruleset2(const struct landlock_domain *curr_domain,
+			const struct landlock_ruleset *new_ruleset);
+
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
diff --git a/security/landlock/hash.h b/security/landlock/hash.h
index 8393593cfe7b..8208944c309e 100644
--- a/security/landlock/hash.h
+++ b/security/landlock/hash.h
@@ -10,6 +10,7 @@
 
 #include <linux/slab.h>
 #include <linux/hash.h>
+#include <linux/rculist.h>
 
 #include "ruleset.h"
 
@@ -125,3 +126,107 @@ static inline size_t landlock_hash_count(const struct landlock_hashtable *ht)
 	}
 	return num_entries;
 }
+
+/**
+ * @landlock_hash_insert - Insert a rule in the hashtable, taking
+ * ownership of the passed in struct landlock_rule. This function assumes
+ * that the rule is already in the hash table.
+ */
+static inline void landlock_hash_insert(const struct landlock_hashtable *ht,
+					struct landlock_rule *const new_rule)
+{
+	struct hlist_head *head =
+		&ht->hlist[landlock_hash_key(new_rule->key, ht->hash_bits)];
+
+	hlist_add_head(&new_rule->hlist, head);
+}
+
+static inline int
+landlock_hash_clone(struct landlock_hashtable *const dst,
+		    const struct landlock_hashtable *const src,
+		    const enum landlock_key_type key_type)
+{
+	struct landlock_rule *curr_rule, *new_rule;
+	struct landlock_id id = {
+		.type = key_type,
+	};
+	size_t i;
+
+	landlock_hash_for_each(curr_rule, src, i)
+	{
+		id.key = curr_rule->key;
+		new_rule = landlock_create_rule(id, &curr_rule->layers,
+						curr_rule->num_layers, NULL);
+
+		if (IS_ERR(new_rule)) {
+			return PTR_ERR(new_rule);
+		}
+
+		/*
+		 * new_rule->hlist is invalid, but should still be safe to pass to
+		 * hlist_add_head().
+		 */
+		landlock_hash_insert(dst, new_rule);
+	}
+
+	return 0;
+}
+
+/**
+ * @landlock_hash_upsert - Either insert a new rule with the new layer in
+ * the hashtable, or update an existing one, adding the new layer.
+ *
+ * Hash table must have at least one slot.  This function doesn't take any
+ * locks - it's only valid to call this on a newly created (not yet
+ * committed to creds) domain.
+ *
+ * May error with -ENOMEM.
+ */
+static inline int landlock_hash_upsert(struct landlock_hashtable *const ht,
+				       union landlock_key key,
+				       const enum landlock_key_type key_type,
+				       struct landlock_layer new_layer)
+{
+	size_t index = landlock_hash_key(key, ht->hash_bits);
+	struct hlist_head *head = &ht->hlist[index];
+	struct landlock_rule *curr_rule, *new_rule;
+	const struct landlock_id id = {
+		.type = key_type,
+		.key = key,
+	};
+
+	hlist_for_each_entry(curr_rule, head, hlist) {
+		if (curr_rule->key.data != key.data)
+			continue;
+
+		new_rule = landlock_create_rule(id, &curr_rule->layers,
+						curr_rule->num_layers,
+						&new_layer);
+		if (IS_ERR(new_rule))
+			return PTR_ERR(new_rule);
+
+		/*
+		 * Replace curr_rule with new_rule in place within the hlist
+		 * We don't really care about RCU... but there's no "hlist_replace"
+		 * We should be safe to call hlist_replace_rcu() without first
+		 * initializing new_rule->hlist
+		 */
+		hlist_replace_rcu(&curr_rule->hlist, &new_rule->hlist);
+		free_rule(curr_rule, key_type);
+		return 0;
+	}
+
+	/* No existing rules found, insert new one. */
+	new_rule = landlock_create_rule(id, NULL, 0, &new_layer);
+	if (IS_ERR(new_rule))
+		return PTR_ERR(new_rule);
+
+	/*
+	 * new_rule->hlist is invalid, but should still be safe to pass to
+	 * hlist_add_head().
+	 */
+	hlist_add_head(&new_rule->hlist, head);
+	return 0;
+}
+
+#endif /* _SECURITY_LANDLOCK_HASH_H */
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 07823771b402..ac91d4a865b9 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -27,7 +27,7 @@ struct landlock_hierarchy;
  */
 struct landlock_layer {
 	/**
-	 * @level: Position of this layer in the layer stack.
+	 * @level: Position of this layer in the layer stack. Starts from 1.
 	 */
 	u16 level;
 	/**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 38eb8287f73d..57ac3ee02f22 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -483,6 +483,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
+	struct landlock_domain *new_domain2;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
 		prev_log_subdomains;
 
@@ -551,6 +552,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		abort_creds(new_cred);
 		return PTR_ERR(new_dom);
 	}
+	new_domain2 = landlock_merge_ruleset2(new_llcred->domain2, ruleset);
+	if (IS_ERR(new_domain2)) {
+		landlock_put_ruleset(new_dom);
+		abort_creds(new_cred);
+		return PTR_ERR(new_domain2);
+	}
 
 #ifdef CONFIG_AUDIT
 	new_dom->hierarchy->log_same_exec = log_same_exec;
@@ -588,6 +595,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	/* Replaces the old (prepared) domain. */
 	landlock_put_ruleset(new_llcred->domain);
 	new_llcred->domain = new_dom;
+	landlock_put_domain(new_llcred->domain2);
+	new_llcred->domain2 = new_domain2;
 
 #ifdef CONFIG_AUDIT
 	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
-- 
2.49.0

