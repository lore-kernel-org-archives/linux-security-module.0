Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074725A321
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856088; cv=none; b=nGPL9rjmrJYfHMFHflDTdFSQZrmqGFvhQjg9vp1e1lHnvTcdO5Q1Emhr7dymNDuafxYjFnWhiYmeU82ifta1pMGQ5ugq92fzZBVre9MjRW67wu681ZXpmXfN9L+3IHezWtdQgBKdWHv6IUPh0N9ZwvKntSS0Z1FNTjYCXq2HIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856088; c=relaxed/simple;
	bh=N/GL/CdpDjIXIhHTqiovWxZ5+ImVtQ0S2RBtZKVYpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZGa/4gQUkT0cIAMZtk1itq06tCYuQq1w+gvl/uKyhtRMx3tYcsoGtSFRNnWdHt+gF+1Nnr9F/kIN/BPk0k/aLWUrDO8SobwXcFViDSRMM5IYyysZ3E4v1+v2bBW95UGM8Z75ODc3mliM5jA+JaLje4Hflbu64kdAhVHl5q/dTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=EJ3vsNfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r7sKods6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="EJ3vsNfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r7sKods6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D03671380425;
	Wed, 21 May 2025 15:34:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 15:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747856085;
	 x=1747942485; bh=nP/Cmv4SNAIqjSENCMBwj5U0wXKNe2E3TGSorXUesEU=; b=
	EJ3vsNfVTGlpaF56Znrfn2nGD21CGBhru7+ZTu4MF2RaGdMZsJmwe4UhjHWAp1ZR
	1U05EX+VJ6qjUeqXkaZVYOK+7fsBBPuOfUR/4iQq/kS6/MWhymBntzsu64CvSmKv
	vCR5LzGiXEIzC7b2r30Vluzck1zb6BIXd3CFMP5uc39Tr/TUzFF3SE3RVS4ccZYF
	Y5NEvsDYJKk18CFWUSK6rZOZMyhpasQ0iwalZ+IX4Idn+s8MaWW/BFAfjgv86XkW
	O/HrMLDi0g3RKiSfe28fJf7KTAAkq9x2cVNI/EjnMhtm2fSz7ruY5VXje0bcZjtB
	1TobOGX/BxEWUehOXFLISw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747856085; x=
	1747942485; bh=nP/Cmv4SNAIqjSENCMBwj5U0wXKNe2E3TGSorXUesEU=; b=r
	7sKods6/WXeoFHPNWox2Himtfavd75yLY7K8efgQPcgJA0ZBp/KUDy+KKwCXhoc5
	LE3h+vinYlDL15Wlx4BXeCRpr30Zsy0jU4alKkI4/xW2yo8NF8QFQaMFUe7rKSwf
	v0vDAOqyD1k2hpx5NywbLaxXLShS2kd+vpEmjq43sU/iQjVnmsnaLXAEHXb5HhMq
	cnoSxSNQyC4VoswtAQxv0FZi3lI8MZEQhv/M8Blz3Di6S0hyxTTx3SEmIbOpUSBh
	dGJzG/hrS3FqCZhN/5tN1sooLZkAFvf4x+HqzYTFaga0j8/4VFgzpwQhfpwYTRWz
	8CPjgWK8qd1jGXYk5XY9w==
X-ME-Sender: <xms:1SouaB9X3aF7iE4JWujNYycqNRQT83LsyqCnt1a2MPgeuWO6bAOrsw>
    <xme:1SouaFsODkJDVVEvG9PIbV-yhid4mTEm55HHFoJgkN6Qknnr-JeMudG8bW6LnaJbG
    g7C6itbxxH6diW4yNg>
X-ME-Received: <xmr:1SouaPA2Jt5yG8Luvj14t0bt07zobjiR8SHTjr34S9yvkL6Y-vDQQWJ31PVBgQqqAZX1vEEJJxy8KSvkR8lGbKdZ62vlCgJE2cB8_41mTd0UGVjtdQpACQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmse
    hmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepieeigeeghedtffeifffhkeeu
    ffehhfevuefgvdekjeekhedvtedtgfdvgefhudejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgih
    hkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohep
    ghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1SouaFdwxPXejp8VOs5GA5K1rmE3FtjxlP9U09WLm9lcKMirnwnAlw>
    <xmx:1SouaGPDCWBRYpAqiv6falTROVBT9NtmL_KnQ4ad4Hgrbnu3HnFzhQ>
    <xmx:1SouaHm_3SO8z3nOi4OJYBW3u8cjSdv8fwGigFAX3kaDyPgdTlcdlA>
    <xmx:1SouaAvOmmMNVoDEA8sz0veVMrgVBa6t8PZQN5iKeKguHm1JCpdDqQ>
    <xmx:1SouaOMT017umaggSZVAkPlT77_SR-ec-dHTP9Jyd-BpO2qMqDrQAiHG>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:44 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 02/10] landlock/hash: define (dynamic, non-resizable) hash table helpers
Date: Wed, 21 May 2025 20:31:58 +0100
Message-ID: <8b4d0d2f691e36507d5ad80ad4203c29ac6f216c.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While there is already include/linux/hash.h, it relies on the static size
of the array as the size of the hash table, and thus is inconvenient to
use for this case where we dynamically compute how many slots we need.

There is also the relativistic hash tables in rhashtable.h which supports
dynamic resizes etc, but is more complicated and might be slower to access?

However, on second thought, I'm wondering if we should just use hash
tables for both domain and a not-yet-merged ruleset anyway (which saves us
from having a union in landlock_rule).  If we do that then we should
indeed just use rhashtable.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/hash.h | 117 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 security/landlock/hash.h

diff --git a/security/landlock/hash.h b/security/landlock/hash.h
new file mode 100644
index 000000000000..955c5756d4d9
--- /dev/null
+++ b/security/landlock/hash.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Domain hashtable mainpulation
+ *
+ * Copyright © 2025      Tingmao Wang <m@maowtm.org>
+ */
+
+#ifndef _SECURITY_LANDLOCK_HASH_H
+#define _SECURITY_LANDLOCK_HASH_H
+
+#include <linux/slab.h>
+#include <linux/hash.h>
+
+#include "ruleset.h"
+
+struct landlock_hashtable {
+	struct hlist_head *hlist;
+
+	/**
+	 * @hash_bits: Number of bits in this hash index (i.e.  hlist has
+	 * 2^this many elements).
+	 */
+	int hash_bits;
+};
+
+#define landlock_hash_for_each(rule, ht, i)                \
+	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
+		hlist_for_each_entry(rule, &(ht)->hlist[i], hlist)
+
+#define landlock_hash_for_each_safe(rule, tmp, ht, i)      \
+	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
+		hlist_for_each_entry_safe(rule, tmp, &(ht)->hlist[i], hlist)
+
+static inline int landlock_hash_init(const size_t expected_num_entries,
+				     struct landlock_hashtable *out_ht)
+{
+	size_t table_sz = 1;
+	int hash_bits = 0;
+
+	if (likely(expected_num_entries > 0)) {
+		table_sz = roundup_pow_of_two(expected_num_entries);
+		hash_bits = fls_long(table_sz - 1);
+	}
+
+	/*
+	 * We allocate a table even if expected_num_entries == 0 to avoid
+	 * unnecessary branching in lookup code
+	 */
+
+	out_ht->hash_bits = hash_bits;
+	out_ht->hlist = kcalloc(table_sz, sizeof(struct hlist_head),
+				GFP_KERNEL_ACCOUNT);
+	if (!out_ht->hlist) {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline void landlock_hash_free(struct landlock_hashtable *ht,
+				      const enum landlock_key_type key_type)
+{
+	struct landlock_rule *rule;
+	struct hlist_node *tmp;
+	size_t i;
+
+	if (key_type == LANDLOCK_KEY_INODE)
+		might_sleep();
+
+	if (!ht->hlist)
+		return;
+
+	landlock_hash_for_each_safe(rule, tmp, ht, i)
+	{
+		free_rule(rule, key_type);
+	}
+	kfree(ht->hlist);
+	ht->hlist = NULL;
+}
+
+static inline u32 landlock_hash_key(const union landlock_key key,
+				    const int hash_bits)
+{
+	return hash_ptr((void *)key.data, hash_bits);
+}
+
+static inline struct landlock_rule *
+landlock_hash_find(const struct landlock_hashtable *const ht,
+		   const union landlock_key key)
+{
+	struct hlist_head *head;
+	struct landlock_rule *rule;
+
+	head = &ht->hlist[landlock_hash_key(key, ht->hash_bits)];
+
+	hlist_for_each_entry(rule, head, hlist) {
+		if (rule->key.data == key.data)
+			return rule;
+	}
+
+	return NULL;
+}
+
+/**
+ * @landlock_hash_count - Return number of entries in the hashtable.
+ */
+static inline size_t landlock_hash_count(const struct landlock_hashtable *ht)
+{
+	size_t num_entries = 0;
+	struct landlock_rule *rule;
+	size_t i;
+	landlock_hash_for_each(rule, ht, i)
+	{
+		num_entries += 1;
+	}
+	return num_entries;
+}
-- 
2.49.0

