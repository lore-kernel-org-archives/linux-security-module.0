Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C923183D
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856087; cv=none; b=VW957s17MNs8Z2fzDryYTXDinEVXOj8wo6sRAdv3a6nRQD+xvfi8jnflCyOFegECvxt0auOVXD3qRhYIsw6ca77yc6FTpiN3jePhrTuSYSvrGdZ/fCzJ4lIVI7/3nLXU0U1AyRaJ1qwxblYOlnnbBKouLTgeIuaRd1i6wshs+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856087; c=relaxed/simple;
	bh=hJ0f3G7ilr5A11+Z/LdAntyTDbOmVdiCcOCdz1kROIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRPeh87GNSfVrW5hS60Qbt+WBqxhajPDre0VRpU73vEwbpWMtABBMgEdZalg3Ei/cOcwzBI5Gle/22rQPptI1utvhsArX5SILD6GwUx2Py0WfPm0rF8H8ZZQkyavlI6IkofqVxqCXi2Cpdv+daS8phE0eT3Z1B4jlS6mkmQY7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Ijw+aXLd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWaZBgpd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Ijw+aXLd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWaZBgpd"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CACF1140131;
	Wed, 21 May 2025 15:34:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 21 May 2025 15:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856084; x=
	1747942484; bh=wtNcOrreGNCKeax6ky3ziy+IOJOEvvraj7WmEieaF9o=; b=I
	jw+aXLdH9wO/rsqvJOKWVLeYU4qIqPeV4jM2VPzbsZjx8SWayLTdR4/PxmRq91TY
	dpi1CrfQ9yV1jKyOG5e31AObdPHVICX0XENKrno41KpjEP7iSHvNc/PrUL+DbwoN
	Gpb3X8DWTAwM/IQ/3O1k9LoCi5OI8WfoUQgD+VuvMYOxxhtolv40li12Kpcaj6MG
	Rkb1t1SLnUKobduvNb7Yf0wQW3oLDOvFvDSBYTEqxQY50McklB/vgLiqTR17bPc/
	rz8F9UqISqf/o9/Kyt7Negtb2SsK4jVIHIYdfLUF71tIMRA+IS1idT1yn83pIlnz
	KFyDsPTF3M8KjMrx/oQHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856084; x=1747942484; bh=w
	tNcOrreGNCKeax6ky3ziy+IOJOEvvraj7WmEieaF9o=; b=UWaZBgpdZm3As5uV0
	AYZx4apZQo4ypiKUhSEoh0puRs9JQErxucfVX5rlvPD9yAkQyDI93Jirb5q3fSCB
	u4/Sz7wRtxLWnzeamcSPVl4Uk23zJzOb4Wh2aBR42Y99AbGGCMtd55PXsB5NAqtv
	W6mIQtUh/V+RuuZjUJ/nj9HXa2z9/vdGfu14g/gs4NUWFu7vF1Err0vCino18VQI
	M+hd3jvu2aE7kjxU9Tna617hDmFNfUFCaMA/myiy0rEDJxKYtynOg0E8eL4E7Y/0
	dh0DskfEnQDLh+rpan/D/wTEc8TOoOLXaB1gWebAKOaKOIJpapOk8uAFPJW2W1PF
	1YNOg==
X-ME-Sender: <xms:1CouaNGSWTEdUuHmMUCvnBEBeaXaxGL8ziSHJCsj1Z1ul8KgiFQmgg>
    <xme:1CouaCVlrVul0XtstMBUUgi8-E4ZK-2TmQyJuqNOc-ahBKRB117MIvEdMaqYG0MtT
    BBDS8RRwUecYUHp2ic>
X-ME-Received: <xmr:1CouaPKmLx3xIIwmWOLc3eeEE_aFycZputHAv0lB3ue_Jrg5HQtrnExhQ01LJZJZp9kN6Sqs4vNA0bdb56SA_QSMu2liEWcvPPhBj66JHiUN2Za1hlzUPg>
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
X-ME-Proxy: <xmx:1CouaDHtQkXfI-Sy8CU6Ve1j5AsyEEwcy-IP_3ZIDNaMiIti9GPCZg>
    <xmx:1CouaDXICAICA30CYhuDRBIxt-6xfnbtnf57fxXvA24YSfQlsJqdCQ>
    <xmx:1CouaON4X8nHoBiSQ2-QbKU-byA34PH3HNiqKydqBpylBiYryAX1Lg>
    <xmx:1CouaC38I0L8a6EOZE7-TAOO0RYdQzwcwd2akkZ1qH3HvjOXn9REqg>
    <xmx:1CouaEX9HKvUCxtFhpCeq8sQtP_Warz12eKJqG45L3i7jU8m4OTo75Wk>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:43 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 01/10] landlock: Add some debug output
Date: Wed, 21 May 2025 20:31:57 +0100
Message-ID: <b0d0ae5318c8eee922783299651cde5c4e7b6a3a.1747836146.git.m@maowtm.org>
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

They are behind #ifdef DEBUG for now as iterating over all the rules /
each access bits might make it slower (even if dynamic pr_debug makes the
print itself nop).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c       | 47 ++++++++++++++++++++++++++++++++++++
 security/landlock/fs.h       |  1 +
 security/landlock/syscalls.c | 26 ++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..b407c644ac65 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -772,6 +772,10 @@ static bool is_access_to_paths_allowed(
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
 
+#ifdef DEBUG
+	layer_mask_t all_layers = (1 << domain->num_layers) - 1;
+#endif
+
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
 
@@ -800,6 +804,14 @@ static bool is_access_to_paths_allowed(
 		access_masked_parent1 = access_masked_parent2 =
 			landlock_union_access_masks(domain).fs;
 		is_dom_check = true;
+
+#ifdef DEBUG
+		pr_debug(
+			"check access to path %pd4 for access request p1 %x p2 %x:\n",
+			path->dentry, access_request_parent1,
+			access_request_parent2);
+#endif
+
 	} else {
 		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
 			return false;
@@ -807,7 +819,15 @@ static bool is_access_to_paths_allowed(
 		access_masked_parent1 = access_request_parent1;
 		access_masked_parent2 = access_request_parent2;
 		is_dom_check = false;
+
+#ifdef DEBUG
+		pr_debug("check access to path %pd4 for access request %x:\n",
+			 path->dentry, access_request_parent1);
+#endif
 	}
+#ifdef DEBUG
+	pr_debug("  (need layer mask %x)", all_layers);
+#endif
 
 	if (unlikely(dentry_child1)) {
 		landlock_unmask_layers(
@@ -892,6 +912,33 @@ static bool is_access_to_paths_allowed(
 					  layer_masks_parent2,
 					  ARRAY_SIZE(*layer_masks_parent2));
 
+#ifdef DEBUG
+		{
+			rcu_read_lock();
+			pr_debug("  %pd: ino %lu (%p), rule: %s, allow: %s\n",
+				 walker_path.dentry,
+				 walker_path.dentry->d_inode->i_ino,
+				 walker_path.dentry->d_inode,
+				 rule ? "exists" : "does not exist",
+				 allowed_parent1 ? "yes" : "no");
+			unsigned long access_masked = access_masked_parent1;
+			unsigned long access_bit;
+			if (rule) {
+				for_each_set_bit(
+					access_bit, &access_masked,
+					ARRAY_SIZE(*layer_masks_parent1)) {
+					pr_debug(
+						"    access %x allowed by layer mask %d\n",
+						(1 << access_bit),
+						(~(*layer_masks_parent1)
+							 [access_bit]) &
+							all_layers);
+				}
+			}
+			rcu_read_unlock();
+		}
+#endif
+
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index bf9948941f2f..bedf61c15cd4 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 
+#include "common.h"
 #include "access.h"
 #include "cred.h"
 #include "ruleset.h"
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 33eafb71e4f3..38eb8287f73d 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -559,6 +559,32 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
 #endif /* CONFIG_AUDIT */
 
+#ifdef DEBUG
+	pr_debug("%s[%d] restricting self with landlock\n", current->comm,
+		 current->pid);
+	struct rb_node *node;
+	pr_debug("inode tree:\n");
+	for (node = rb_first(&new_dom->root_inode); node;
+	     node = rb_next(node)) {
+		const struct landlock_rule *rule =
+			rb_entry(node, struct landlock_rule, node);
+		spinlock_t *lock = &rule->key.object->lock;
+		rcu_read_lock();
+		spin_lock(lock);
+		struct inode *inode = rule->key.object->underobj;
+		if (inode)
+			pr_debug("  rule: ino %lu (%p)\n", inode->i_ino, inode);
+		else
+			pr_debug("  rule: inode released\n");
+		for (size_t i = 0; i < rule->num_layers; i++) {
+			pr_debug("    layer %u: access %x\n",
+				 rule->layers[i].level, rule->layers[i].access);
+		}
+		spin_unlock(lock);
+		rcu_read_unlock();
+	}
+#endif /* DEBUG */
+
 	/* Replaces the old (prepared) domain. */
 	landlock_put_ruleset(new_llcred->domain);
 	new_llcred->domain = new_dom;
-- 
2.49.0

