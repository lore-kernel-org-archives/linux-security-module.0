Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC021FF45
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856097; cv=none; b=ir1Jo+CoiybQawKixDIUiD3zWjRbQqHoO4V+fnx4RZAZ9F063sb0vEDH9F0851qd4Q0Ltw4skg8jT2KrlVtY2i5B1W9QSI5A0dDt2divbdONtGn7kPWtPc9UCK6x7CBh4gkw/UFB3nZe77tRuF1KFZH3qmmsaWUoNx6F3dqtfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856097; c=relaxed/simple;
	bh=uruy/AHWeZhfclOem85W1DdAp3QAuY8msfi1vNeCnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwuR9PrCtWAm0U0kR8C0Mf5iYut1Nue6Pp/tPw0rmGJi8wh/ZZqZufY8HkUHCff6FESOWrBg0Ky1XESazPEh4E6BDEPtgd+uAiCm8X0M6YgZYdwz1NdKBdaM2OuUhRIa5DsYknNQwl3HWX1KjtwIZvIcNg/WbEv+ZhC2KEhwLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=R+FK2pF+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCeDRD43; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="R+FK2pF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCeDRD43"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4C721140145;
	Wed, 21 May 2025 15:34:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 15:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856094; x=
	1747942494; bh=vAZ8t6wG4MQoQ3Ii+G88IhYb3PbaLpKExM9qXDXHWw0=; b=R
	+FK2pF+IlCiIMTYADY69712NSHTDIhPQ/yus1VwXhA/GkIQF94zqAlW9qqKEw9Bf
	fmMUt6x5XJoAmAW0spJNocu7AQVE7yNNyHRYMD+2CRPJawaVucN4pLiQtUx/QlQ5
	EQ9MWbhKRt1KrFsZfPoPYROVZZPauCtIUNIgRcnhu42SLXltvvsZoth3eVjYPMu3
	Tir1CEsIYfP4Lu2iVnSCNFF95mcQGsVlBiRI8recFmh0TeFksPffuRe+tITDfDU5
	EgdgSAfEVaPZsMqxZm6L7EwvZex4Hn+mj64eNkIXl1fcpWMPgmzbp+5osvGuAmzT
	fTB4XKNYLlLFHBhSG6pWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856094; x=1747942494; bh=v
	AZ8t6wG4MQoQ3Ii+G88IhYb3PbaLpKExM9qXDXHWw0=; b=mCeDRD439ELFevu2Y
	kComFbQwY4FKz2LI9igyoPbEzMVW2+6mQW51xUjsAgz9SBuaz95OlIkdq8dmGfrX
	gLfHn0FNcx7lIIcqwkuUIkRdBsh5UxMoc8lFKi2/IbDhxQzr1TRSA/Ze5bz6VFSU
	5hqqRD3Uh9PqVImuceSGjFCYThDTf3SFbqlqUl6bm26QN5prkCKUo9IFW42UmJ8d
	tB8pW85/iLV5wjVWDtgXx9m9LWBkcqOV0xY1ou7fV7E4tNxuRnBdtuX/XT3/qFzx
	eGojKzgluRjxDhgwKGCrXHA0aoUczOUQAUm2fz7ZyakmoDWWYgFejpbjTemJ/ERw
	Ggc3A==
X-ME-Sender: <xms:3iouaInecHYKWltIUcZ-FsllNRC_MfSeWA3cm85EpTSpZQJqbQ5Ywg>
    <xme:3iouaH3yPxI7mBYEA89NF4zX_b_owO0zzRIdFGn6F1MFuL3DXnztyTp77Oioo-RSD
    Hz7tc7e4Xtzsgzq_hc>
X-ME-Received: <xmr:3iouaGrlsiFgoE7-WLsamKIeM_ZtkmhDR7xAeeGD7Qt_OtiyxfVhuRYbzDyzk7XVeiuV--g4ogohPbkrtyNVXKR7OZye-j8r3XeHgGvuDdBAz9vaJ_-M4g>
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
X-ME-Proxy: <xmx:3iouaElW5MH5f_8S1jxFe4GPmUFZ6y3OGBff9NCHMf1eVy0EEclQqg>
    <xmx:3iouaG0XTsnLCX7ulgzZMDRxcsJbTMd7tj8Ph-gjh2C5-oZph10pAA>
    <xmx:3iouaLuDrn7ZMqqPx5zsHTkZSmHT1l9av07P_ekUfehSlfymINs8Lw>
    <xmx:3iouaCWqqccEJnqNXDZiuCoUXBpk1fcj_tEWqC909u7vIiqjQXHmEA>
    <xmx:3iouaD1OM6iTrpqLll2P05RPkUgjeeBdRMd8P73ympCwoIGl9__ZWDsA>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:53 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 10/10] landlock: Debug print inode hashtable in landlock_merge_ruleset2
Date: Wed, 21 May 2025 20:32:06 +0100
Message-ID: <b9c8109a0a04f8b1866218898f28066c7afd57c1.1747836146.git.m@maowtm.org>
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

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c |  5 +++
 security/landlock/hash.h   | 62 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index fae21b260591..9c82f5c1bdb9 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -161,6 +161,11 @@ landlock_merge_ruleset2(const struct landlock_domain *curr_domain,
 		return ERR_PTR(err);
 	}
 
+#ifdef DEBUG
+	pr_debug("landlock_merge_ruleset2: inode hash table:\n");
+	landlock_hash_debug_print(&new_domain->inode_table, LANDLOCK_KEY_INODE);
+#endif /* DEBUG */
+
 	return new_domain;
 }
 
diff --git a/security/landlock/hash.h b/security/landlock/hash.h
index 8208944c309e..0c41cd8a102b 100644
--- a/security/landlock/hash.h
+++ b/security/landlock/hash.h
@@ -229,4 +229,66 @@ static inline int landlock_hash_upsert(struct landlock_hashtable *const ht,
 	return 0;
 }
 
+static inline void
+landlock_hash_debug_print(const struct landlock_hashtable *ht,
+			  const enum landlock_key_type key_type)
+{
+	size_t max_hlist_len = 0, slot_index = 0, num_rules = 0;
+
+	for (slot_index = 0; slot_index < (1ULL << ht->hash_bits);
+	     slot_index += 1) {
+		struct hlist_head *head = &ht->hlist[slot_index];
+		struct landlock_rule *rule;
+		size_t rule_index = 0;
+		spinlock_t *lock;
+
+		pr_debug("  [%zu]: first = %p\n", slot_index, head->first);
+
+		hlist_for_each_entry(rule, head, hlist) {
+			size_t j;
+
+			switch (key_type) {
+			case LANDLOCK_KEY_INODE:
+				lock = &rule->key.object->lock;
+				spin_lock(lock);
+				struct inode *inode =
+					((struct inode *)
+						 rule->key.object->underobj);
+				if (inode) {
+					pr_debug(
+						"    [%zu] rule: ino %lu (%p), %d layers\n",
+						rule_index, inode->i_ino, inode,
+						rule->num_layers);
+				} else {
+					pr_debug(
+						"    [%zu] rule: inode released, %d layers\n",
+						rule_index, rule->num_layers);
+				}
+				spin_unlock(lock);
+				break;
+			case LANDLOCK_KEY_NET_PORT:
+				pr_debug(
+					"    [%zu] rule: port %lu, %d layers\n",
+					rule_index, rule->key.data,
+					rule->num_layers);
+				break;
+			}
+			for (j = 0; j < rule->num_layers; j++) {
+				pr_debug("      layer %u: access %x\n",
+					 rule->layers[j].level,
+					 rule->layers[j].access);
+			}
+			rule_index += 1;
+			num_rules += 1;
+		}
+
+		if (rule_index > max_hlist_len)
+			max_hlist_len = rule_index;
+	}
+
+	pr_debug("  summary: %zu rules, %llu hash slots, "
+		 "%zu max hlist chain len\n",
+		 num_rules, (1ULL << ht->hash_bits), max_hlist_len);
+}
+
 #endif /* _SECURITY_LANDLOCK_HASH_H */
-- 
2.49.0

