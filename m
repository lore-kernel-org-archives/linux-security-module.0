Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2814A09C
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815107; cv=none; b=YiIQT+YjcR/QYeN1Yv2sPInztgyy+KIDBJ1Piq/GqABHihF95AK7oBkY0df1pBbFsykDuGXeVKr4ZkDGwi6pdnmxEAjqBGG2LU3pT9ajIqQcUDc0RgMIFVDFmadhreCicK0TDyrCaa1jjfLfiFNS0ZFag9ebFMTSzUZePEi805c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815107; c=relaxed/simple;
	bh=eFmRlGhJ7mbbpHb87gfmgkIRgCg/Tkvfks3L2vy3JGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+iQ/tZX3w8V1D768yqRN7+VMyxkSX+KSqiU9uX54qH2FAP/YiJCHe/E/zwuop2248ZA7on3aYuCW0Emr3vojJfMKRJzKjRRyY3l7LdthJsZLuo90QKT1rgZHaJreyGSaESKSZHv08rLC7oiqSuA7nKun0Z6mmiFPuDZ/+fuTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=fJVZYai6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2gcasvu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="fJVZYai6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2gcasvu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5A9F7A0156;
	Sun,  6 Jul 2025 11:18:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Jul 2025 11:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815104; x=
	1751901504; bh=ns/awOqnsyViP4TgpwNjVld8cDoBYcDfiLPRIDXknXk=; b=f
	JVZYai6bkYtL3/6KiZ8GXo7iW36pUziOsExaiVL15OFu7D6uIIJowGwZ5ErC/3sA
	dwugiMQxzLaAb5sJucsI7mrlTPyzRmvTCc43FJQIkTbWxDp53Jav/h293o3lAdEQ
	88OgXDv0ELwub7jDwBhGYaNGHcgSBVPpLwu3cXIi3e+qjNnixDR4c+HzkQG2+nIp
	hw8zWqh7A5oWfpSKyL7NqXCw7aUuhpt+SsbXMPJF678gvqyCxOEbehUi6wBA4Vlz
	Vs+rYCM2TsGEqJ0sGKpd7yOAKGnBxZiJkeyTckvBLG04f43+25Rpr46yFIiRNZr2
	I6ZsD/KMfxQ6AGTyaqdNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815104; x=1751901504; bh=n
	s/awOqnsyViP4TgpwNjVld8cDoBYcDfiLPRIDXknXk=; b=d2gcasvuvRgEhbe55
	rmfRHOWEJM0mAESa/xof3UGeSLXhdE0Bus+xu8lFwicnWNbWK0U3qpUobDx4ddgD
	FlsZyoTSqVmPxdNGYf3VufZ4jtih+xG6IIi6ylwGPiZbB9T9kWhRxCd4+EBI++C3
	JMZuiczwSm4deaBoY871xHTLfH+yNgQlShPlsbFqg+wM2a/XvhE4hVDYFshMtEn+
	ls4PzaCSzpMK34VXPvWFdcvqzwVimb68PgOYHuwCLUQDAoPyFSmtNuWNWQ344xGM
	ODv0huUzmPyDHK3rE/lVkVy3JZSJZ/8WQAsmF4iYOkn7xr5RsVuo7M55wdCLOeDo
	6bEWg==
X-ME-Sender: <xms:wJNqaDT1W8O9rzr8IQ-SCsiHy2WkuVp115JS5l8mTlJg8mbl7AcKuw>
    <xme:wJNqaEw7Wji9JpQyieKQ6vK6oKOj9Pf1zu-MoG6wNCu_TD4b37J_HfAR6pcO-dejf
    bsFYXSVhBnzmdF8a9k>
X-ME-Received: <xmr:wJNqaI3fIZmJ_GLOWPqO4I2lkxasK2Ji2UjzOkqGeTkOuEix8ALoY2TjASLT5c9j0xjp6yUVOQdhDXhElyf0ZwLE9bOQ5ZkZi-imsa7NpuYwy0vhNktD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepudeghe
    elheegffffgeeivdefledtuddtjeegffefueeijeevtdefudeuteeugedtnecuffhomhgr
    ihhnpeifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurd
    hnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthi
    dqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghn
    ohhvrdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtph
    htthhopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:wJNqaDBJJEMPWDCda7AItRAqNNNNRTsIRbvNL_DE19RI2jbbCHpjjw>
    <xmx:wJNqaMgNuIQ7N9D1TyOczgneiO3fM6RYn_qFK574PgABPYeHvk7ttg>
    <xmx:wJNqaHoqBoT84bnEVRfDVSuZ5BoZmhSJKuwyCvLxUEsTchCFTlIiYQ>
    <xmx:wJNqaHhD3yc9eO-uBNWpX5NQA8DpN7UuBqFD0EWRZw-bAhqis66z7w>
    <xmx:wJNqaIpW3VD0pKr0FxRMEM4hxaANtxNGJDpCs6tXVzZxo90S0w0oyBUI>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:23 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 05/12] landlock/coalesced_hash: Implement insert
Date: Sun,  6 Jul 2025 16:16:46 +0100
Message-ID: <d761a029478bd322455a83f9c3cb15536cc50bb2.1751814658.git.m@maowtm.org>
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

This algorithm is a slight alteration of the one on Wikipedia at the time
of writing [1].  The difference is that when we are trying to insert into
a slot that is already being used (whether by an element that doesn't
actually belong there, and is just in a collision chain of a different
hash, or whether it is the head of a chain and thus has the correct hash),
we move the existing element away and insert the new element in its place.
The result is that if there is some element in the hash table with a
certain hash, the slot corresponding to that hash will always be the slot
that starts the collision chain for that hash.  In order words, chains
won't "mix" and if we detect that the hash of the element at the slot
we're targeting is not correct, we know that the hash table does not
contain the hash we want.

[1]: https://en.wikipedia.org/w/index.php?title=Coalesced_hashing&oldid=1214362866

This patch seems to have hit a checkpatch false positive:

	ERROR: need consistent spacing around '*' (ctx:WxV)
	#281: FILE: security/landlock/coalesced_hash.h:349:
	+               elem_type *table, h_index_t table_size)                       \
	                          ^

	ERROR: need consistent spacing around '*' (ctx:WxV)
	#288: FILE: security/landlock/coalesced_hash.h:356:
	+               struct h_insert_scratch *scratch, const elem_type *elem)      \
	                                                                  ^

Since this is kinda a niche use-case, I will make a report only after this
series gets out of RFC (and if they still show up).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/coalesced_hash.h | 265 +++++++++++++++++++++++++++++
 1 file changed, 265 insertions(+)

diff --git a/security/landlock/coalesced_hash.h b/security/landlock/coalesced_hash.h
index 14950915f0b5..56d32cf70d67 100644
--- a/security/landlock/coalesced_hash.h
+++ b/security/landlock/coalesced_hash.h
@@ -68,6 +68,256 @@ static inline void *h_find(const void *table, h_index_t table_size,
 	return NULL;
 }
 
+static inline void h_initialize(void *table, h_index_t table_size,
+				size_t elem_size,
+				set_next_collision_t set_next_collision,
+				element_is_empty_t element_is_empty)
+{
+	h_index_t i;
+	void *elem;
+
+	WARN_ON_ONCE(array_size(table_size, elem_size) == SIZE_MAX);
+
+	for (i = 0; i < table_size; i++) {
+		elem = table + i * elem_size;
+		set_next_collision(elem, i);
+	}
+}
+
+struct h_insert_scratch {
+	/**
+	 * @prev_index: For each slot which belongs in a collision chain,
+	 * stores the index of the previous element in the chain.  (The next
+	 * index in the chain is stored in the element itself.)
+	 */
+	h_index_t *prev_index;
+	/**
+	 * @next_free_index: This index moves from end of the table towards
+	 * the beginning.
+	 */
+	h_index_t next_free_index;
+
+	/*
+	 * The following members just helps us avoid passing those arguments
+	 * around all the time.
+	 */
+	h_index_t table_size;
+	void *table;
+	size_t elem_size;
+};
+
+static inline int h_init_insert_scratch(struct h_insert_scratch *scratch,
+					void *table, h_index_t table_size,
+					size_t elem_size)
+{
+	h_index_t i;
+
+	if (table_size == 0) {
+		memset(scratch, 0, sizeof(*scratch));
+		scratch->table = table;
+		scratch->elem_size = elem_size;
+		return 0;
+	}
+
+	if (array_size(table_size, elem_size) == SIZE_MAX)
+		return -ENOMEM;
+
+	scratch->prev_index =
+		kcalloc(table_size, sizeof(h_index_t), GFP_KERNEL_ACCOUNT);
+	if (!scratch->prev_index)
+		return -ENOMEM;
+
+	for (i = 0; i < table_size; i++)
+		scratch->prev_index[i] = i;
+
+	scratch->table_size = table_size;
+	scratch->next_free_index = table_size - 1;
+	scratch->table = table;
+	scratch->elem_size = elem_size;
+	return 0;
+}
+
+static inline void h_free_insert_scratch(struct h_insert_scratch *scratch)
+{
+	if (!scratch)
+		return;
+
+	kfree(scratch->prev_index);
+	memset(scratch, 0, sizeof(*scratch));
+}
+
+static inline h_index_t
+__h_insert_get_next_free(struct h_insert_scratch *scratch,
+			 element_is_empty_t element_is_empty)
+{
+	h_index_t index_to_ret = scratch->next_free_index;
+	void *free_slot;
+
+	if (WARN_ON_ONCE(index_to_ret >= scratch->table_size)) {
+		/*
+		 * We used up all the available slots already.  This isn't
+		 * supposed to happen with correct usage.
+		 */
+		return 0;
+	}
+
+	free_slot = scratch->table + index_to_ret * scratch->elem_size;
+	while (!element_is_empty(free_slot)) {
+		if (WARN_ON_ONCE(index_to_ret == 0)) {
+			/* We unexpectedly used up all slots. */
+			return 0;
+		}
+		index_to_ret--;
+		free_slot = scratch->table + index_to_ret * scratch->elem_size;
+	}
+
+	if (index_to_ret == 0)
+		scratch->next_free_index = scratch->table_size;
+	else
+		scratch->next_free_index = index_to_ret - 1;
+
+	return index_to_ret;
+}
+
+/**
+ * __h_relocate_collision_slot - Moves the element at idx_to_move to
+ * another free slot, and make the original slot free.  We will update any
+ * chain links (scratch->prev_index and target->next_collision).
+ *
+ * Returns the new index of the moved element.
+ */
+static inline h_index_t
+__h_relocate_collision_slot(struct h_insert_scratch *scratch,
+			    h_index_t idx_to_move,
+			    get_next_collision_t get_next_collision,
+			    set_next_collision_t set_next_collision,
+			    element_is_empty_t element_is_empty)
+{
+	h_index_t move_to = __h_insert_get_next_free(scratch, element_is_empty);
+	void *move_to_elem = scratch->table + move_to * scratch->elem_size;
+	void *move_target_elem =
+		scratch->table + idx_to_move * scratch->elem_size;
+	h_index_t old_next = get_next_collision(move_target_elem);
+	h_index_t old_prev = scratch->prev_index[idx_to_move];
+	void *old_prev_elem = scratch->table + old_prev * scratch->elem_size;
+
+	memcpy(move_to_elem, move_target_elem, scratch->elem_size);
+
+	/*
+	 * The logic here is essentially hlist_replace_rcu, except in the
+	 * hlist case the tail have next == NULL, whereas in our case the tail
+	 * has next set to itself.
+	 */
+
+	/*
+	 * if move target already points to something else, it would have been
+	 * memcpy'd across.
+	 */
+	if (old_next == idx_to_move)
+		/*
+		 * Need to fix the tail pointer - it points to itself.  It's own
+		 * prev is correct already.
+		 */
+		set_next_collision(move_to_elem, move_to);
+	else
+		/*
+		 * the next_collision would have been memcpy'd over, but we need to
+		 * fix that next element's prev
+		 */
+		scratch->prev_index[old_next] = move_to;
+
+	if (old_prev == idx_to_move)
+		/* The moved element is a head.  Fix its prev. */
+		scratch->prev_index[move_to] = move_to;
+	else {
+		/*
+		 * Need to make the moved element's prev point to it, and copy over
+		 * the prev pointer.
+		 */
+		set_next_collision(old_prev_elem, move_to);
+		scratch->prev_index[move_to] = old_prev;
+	}
+
+	scratch->prev_index[idx_to_move] = idx_to_move;
+	memset(move_target_elem, 0, scratch->elem_size);
+	set_next_collision(move_target_elem, idx_to_move);
+
+	return move_to;
+}
+
+static inline void h_insert(struct h_insert_scratch *scratch, const void *elem,
+			    hash_element_t hash_elem,
+			    get_next_collision_t get_next_collision,
+			    set_next_collision_t set_next_collision,
+			    element_is_empty_t element_is_empty)
+{
+	h_index_t target_idx, target_hash, moved_to;
+	void *target_elem;
+
+	if (WARN_ON_ONCE(!scratch->table || !scratch->table_size))
+		return;
+	if (WARN_ON_ONCE(scratch->next_free_index >= scratch->table_size))
+		/*
+		 * We used up all the available slots already.  This isn't
+		 * supposed to happen with correct usage.
+		 */
+		return;
+	if (WARN_ON_ONCE(element_is_empty(elem)))
+		return;
+
+	/*
+	 * The general logic here is basically that we always insert the new
+	 * element at its rightful place, but we move any existing element in
+	 * that place around.  Consider these cases:
+	 *
+	 * 1. target slot is empty - we can just insert the new element.
+	 *
+	 * 2. target slot is occupied by an element that is in a collision
+	 *    chain (but not the head).
+	 *    In this case, we can just move that existing element to a free
+	 *    slot, and insert the new element in its rightful place.  This
+	 *    will start a new chain (the fact that the target slot is not a
+	 *    head means) that there is no existing chain with this hash.
+	 *
+	 * 3. target slot is occupied by the head of a chain (i.e. that
+	 *    existing element is already in its "rightful place").  In this
+	 *    case, we can still move that existing element to a free slot,
+	 *    and steals its current place to use for the new element.  The
+	 *    new element will become the new head of the chain, and will
+	 *    point to the existing element.
+	 */
+
+	target_idx = hash_elem(elem, scratch->table_size);
+	if (WARN_ON_ONCE(target_idx >= scratch->table_size))
+		return;
+	target_elem = scratch->table + target_idx * scratch->elem_size;
+
+	if (element_is_empty(target_elem)) {
+		/*
+		 * Simple case - just insert it.  scratch->prev_index is already
+		 * correctly initialized.
+		 */
+		memcpy(target_elem, elem, scratch->elem_size);
+		set_next_collision(target_elem, target_idx);
+	} else {
+		target_hash = hash_elem(target_elem, scratch->table_size);
+		moved_to = __h_relocate_collision_slot(scratch, target_idx,
+						       get_next_collision,
+						       set_next_collision,
+						       element_is_empty);
+		memcpy(target_elem, elem, scratch->elem_size);
+		if (target_hash == target_idx) {
+			/* We should be in the collision chain of the original target */
+			set_next_collision(target_elem, moved_to);
+			WARN_ON_ONCE(scratch->prev_index[moved_to] != moved_to);
+			scratch->prev_index[moved_to] = target_idx;
+		} else {
+			/* We are starting a new chain. */
+			set_next_collision(target_elem, target_idx);
+		}
+	}
+}
+
 /**
  * DEFINE_COALESCED_HASH_TABLE - Define a set of functions to mainpulate a
  * coalesced hash table holding elements of type @elem_type.
@@ -127,4 +377,19 @@ static inline void *h_find(const void *table, h_index_t table_size,
 			      table_func_prefix##_get_next_collision,         \
 			      table_func_prefix##_compare_elem,               \
 			      table_func_prefix##_element_is_empty);          \
+	}                                                                     \
+	static inline void table_func_prefix##_initialize(                    \
+		elem_type *table, h_index_t table_size)                       \
+	{                                                                     \
+		h_initialize(table, table_size, sizeof(elem_type),            \
+			     table_func_prefix##_set_next_collision,          \
+			     table_func_prefix##_element_is_empty);           \
+	}                                                                     \
+	static inline void table_func_prefix##_insert(                        \
+		struct h_insert_scratch *scratch, const elem_type *elem)      \
+	{                                                                     \
+		h_insert(scratch, elem, table_func_prefix##_hash_elem,        \
+			 table_func_prefix##_get_next_collision,              \
+			 table_func_prefix##_set_next_collision,              \
+			 table_func_prefix##_element_is_empty);               \
 	}
-- 
2.49.0

