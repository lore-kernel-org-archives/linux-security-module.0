Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2313D891
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815137; cv=none; b=ny493h7oky1IgoBzO6yrYo/v/7qbYfhLdCUryhriOQdub6WWVn0oXe7+RAIGp0PAuYqEnqM2xO/vDZD1LYq7LdYFOIFUP20ZxydbkhD4cjbzLpvmbRIFRQa1Xj+RsnYDirYMUVCwc+HcOIwlDyHVbGmzeFA5GOVQaX/yyFq7550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815137; c=relaxed/simple;
	bh=DO0fKARYH0bSYnqn1hHUAzqAfj9tC6nd72gRLlZXJMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxqkJcI+Qv+uqVkmErJOZ5QarE2PlDRFzF7/Ut8rAjxKEjSc2AnFMpH8OqfivmiHcPldinwaFqwf99c19FC8LNnfvid3BTzZzUcKAjGLc6ljSnbkeVqzY+D65K5HhcFWyFQqENoraFvG3rZBPqTyWmmhinHlo4MXFER4RJJBaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=BVSwN6cq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApP9rttK; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="BVSwN6cq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApP9rttK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AF841D000E7;
	Sun,  6 Jul 2025 11:18:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 06 Jul 2025 11:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815134; x=
	1751901534; bh=BoW8bW3oaXmnoMtkeVngoDI8isxcwzJRwvejC8AL4uc=; b=B
	VSwN6cq7DH02N3HpI0UnWvEpkNma1Hjq0mDU5vPFTXcRIKULU27XKraTY9BhnSoS
	ViE6qTeCWYh/dkerdhZMScSUpm7ZzCdTwZlvc4r5e/IVlt109E6Zad4H7qVeedbp
	+HWVpcsZQ2kZVxorcDIJaRcVaFAiYHEadoOud+kZB7v4V3oSJCzzHhLP/FNzPotF
	XN5jrHg8cSKWVluZipfTYwFf8E1fs7WxRLU1KLHuV8Ih7fdsYSofPH3VpxYxi894
	XqUg70AZqxD29jNro0NHa6kZzhyaYLg2+xbqrO6vEbgT6thMs9fFhBmcUr7wCcWv
	tOBRv+Mnh12ENbiZr8lAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815134; x=1751901534; bh=B
	oW8bW3oaXmnoMtkeVngoDI8isxcwzJRwvejC8AL4uc=; b=ApP9rttKxYFoAGtmx
	Cm0FuaKDbnJsTCyNLgzN9UQH/SfHQPC5pTXj2yhjXR+lEJF3Jv9bMFgVcxjm1RgB
	Oc7lfOXfHj+u/TYrtP79hZq37hHmx2V+unNloQiW3txath1i3/naZURAE7B5Hbpz
	0UWv1FA1RC/1wNJThY2oN4eDrWcBP+HFc4zkTdtIs6ursFywDLFEOMrVn+xX8V2w
	l43lm65/sVK2KdWMNVmx0am8JMrwHPz2wD9gdiVkiQHGsfiQmxC1DQbfxvFbWX8v
	rcLAe6KQ3HEsSST+Gk1uFfELPAedlJQiv5Kp1Vb2JlC3/ClMEGbiLgUyYrcBqHYC
	sp2rw==
X-ME-Sender: <xms:3pNqaIYF3YJ-T6JLCmg1cj3fprdLMJ08HlH3T5rSKiE-AgFEUkTtjw>
    <xme:3pNqaDbaj95p9nE778wmYeq1k4BMnExPsSyI3zFFje_0-Dv40bOxkRkyKEMi3UK-a
    mCuJhicRGPcoTFer1Q>
X-ME-Received: <xmr:3pNqaC_FdPax2xQEvMephKEQGtTsaKcF9iEN63-u9nXRy84Kl-SgQO4pphHwOaVG1unrNNZbEEb3JEJra-yQGifBEFon_IjSE6NdQmz-TwGbhluQS53d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnheptdegve
    dttedvteefvedtleeifffgueffffevudeivddtfefgjedvvdevgfffieeknecuffhomhgr
    ihhnpehkvgihrdgurghtrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprh
    gtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhesmhgr
    ohifthhmrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuh
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehivhgrnhhovhdrmhhi
    khhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrdgtohhmpdhrtghpthhtohepjh
    grnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:3pNqaCqbF6c0AWbk1v8FNkjit6MwCh67mhDnSTjaLknPUlT8zWh3Bw>
    <xmx:3pNqaDqRcA0GEdepcOy62ZZGyDaedoD4YZG9VXFq94LFV23D8VONwg>
    <xmx:3pNqaASOxom2X5h01QGx7eGCaxSS1y-_EDc_2m2KmoKPI1tU-QdwHg>
    <xmx:3pNqaDqhb-Nw0jW_9e1CoWU-tXnpeC7Viw8na9Xb2tQpDPeX6xHx0g>
    <xmx:3pNqaBxB3SY8eExMRx4ar8ychR-Y5gLmY-TkuScalGiqrRQlm8EQdC8j>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:53 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 12/12] landlock: Use a hash function that does not involve division
Date: Sun,  6 Jul 2025 16:16:53 +0100
Message-ID: <79bea4619140ffb3e72532b89d873b3432146b29.1751814659.git.m@maowtm.org>
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

The current hash uses a division to compute the mod, which can be slow and
also unnecessarily loses entropy (since ideally we want to use the most
significant bits of the hash):

./include/linux/hash.h:
78              return val * GOLDEN_RATIO_64 >> (64 - bits);
   0x0000000000000956 <+118>:   49 0f af c3             imul   %r11,%rax

security/landlock/domain.h:
178     DEFINE_COALESCED_HASH_TABLE(struct landlock_domain_index, dom_hash, key,
   0x000000000000095a <+122>:   48 c1 e8 20             shr    $0x20,%rax
   0x000000000000095e <+126>:   f7 f6                   div    %esi
   0x0000000000000960 <+128>:   89 d0                   mov    %edx,%eax
   0x0000000000000962 <+130>:   49 89 c5                mov    %rax,%r13

This commits introduces a hash_bits parameter to the hash table, and use a
folding hash instead of mod to constrain the value to table_size.

Benchmark comparison:

	> ./parse-bpftrace.py typical-workload-{orig,arraydomain-{hashtable-modhash,hashtable-hashbits}}.log
	  landlock_overhead:    avg = 34        34      34
	                     median = 35        34      34
	  landlock_hook:        avg = 878       875     856
	                     median = 854       850     831
	  open_syscall:         avg = 2517      2532    2485
	                     median = 2457      2471    2425

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/coalesced_hash.h | 136 +++++++++++++++--------------
 security/landlock/domain.c         |  58 ++++++++++--
 security/landlock/domain.h         |  64 +++++++++++---
 3 files changed, 177 insertions(+), 81 deletions(-)

diff --git a/security/landlock/coalesced_hash.h b/security/landlock/coalesced_hash.h
index 56d32cf70d67..199df03a8c14 100644
--- a/security/landlock/coalesced_hash.h
+++ b/security/landlock/coalesced_hash.h
@@ -22,15 +22,16 @@
 
 typedef u32 h_index_t;
 
-typedef h_index_t (*hash_element_t)(const void *elem, h_index_t table_size);
+typedef h_index_t (*hash_element_t)(const void *elem, h_index_t table_size,
+				    int hash_bits);
 typedef h_index_t (*get_next_collision_t)(const void *elem);
 typedef void (*set_next_collision_t)(void *elem, h_index_t next_collision);
 typedef bool (*compare_element_t)(const void *key_elem, const void *found_elem);
 typedef bool (*element_is_empty_t)(const void *elem);
 
 static inline void *h_find(const void *table, h_index_t table_size,
-			   size_t elem_size, const void *elem_to_find,
-			   hash_element_t hash_elem,
+			   int hash_bits, size_t elem_size,
+			   const void *elem_to_find, hash_element_t hash_elem,
 			   get_next_collision_t get_next_collision,
 			   compare_element_t compare_elem,
 			   element_is_empty_t element_is_empty)
@@ -41,7 +42,7 @@ static inline void *h_find(const void *table, h_index_t table_size,
 	if (unlikely(table_size == 0))
 		return NULL;
 
-	curr_index = hash_elem(elem_to_find, table_size);
+	curr_index = hash_elem(elem_to_find, table_size, hash_bits);
 	if (WARN_ON_ONCE(curr_index >= table_size))
 		return NULL;
 	curr_elem = table + curr_index * elem_size;
@@ -53,7 +54,7 @@ static inline void *h_find(const void *table, h_index_t table_size,
 	next_collision = get_next_collision(curr_elem);
 	if (next_collision == curr_index)
 		return NULL;
-	next_hash = hash_elem(curr_elem, table_size);
+	next_hash = hash_elem(curr_elem, table_size, hash_bits);
 	if (next_hash != curr_index)
 		return NULL;
 
@@ -102,13 +103,14 @@ struct h_insert_scratch {
 	 * around all the time.
 	 */
 	h_index_t table_size;
+	int hash_bits;
 	void *table;
 	size_t elem_size;
 };
 
 static inline int h_init_insert_scratch(struct h_insert_scratch *scratch,
 					void *table, h_index_t table_size,
-					size_t elem_size)
+					size_t elem_size, int hash_bits)
 {
 	h_index_t i;
 
@@ -131,6 +133,7 @@ static inline int h_init_insert_scratch(struct h_insert_scratch *scratch,
 		scratch->prev_index[i] = i;
 
 	scratch->table_size = table_size;
+	scratch->hash_bits = hash_bits;
 	scratch->next_free_index = table_size - 1;
 	scratch->table = table;
 	scratch->elem_size = elem_size;
@@ -287,7 +290,7 @@ static inline void h_insert(struct h_insert_scratch *scratch, const void *elem,
 	 *    point to the existing element.
 	 */
 
-	target_idx = hash_elem(elem, scratch->table_size);
+	target_idx = hash_elem(elem, scratch->table_size, scratch->hash_bits);
 	if (WARN_ON_ONCE(target_idx >= scratch->table_size))
 		return;
 	target_elem = scratch->table + target_idx * scratch->elem_size;
@@ -300,7 +303,8 @@ static inline void h_insert(struct h_insert_scratch *scratch, const void *elem,
 		memcpy(target_elem, elem, scratch->elem_size);
 		set_next_collision(target_elem, target_idx);
 	} else {
-		target_hash = hash_elem(target_elem, scratch->table_size);
+		target_hash = hash_elem(target_elem, scratch->table_size,
+					scratch->hash_bits);
 		moved_to = __h_relocate_collision_slot(scratch, target_idx,
 						       get_next_collision,
 						       set_next_collision,
@@ -329,67 +333,67 @@ static inline void h_insert(struct h_insert_scratch *scratch, const void *elem,
  * @next_collision_member: The name of a member in @elem_type that is used
  * to store the index of the next collision in a collision chain.
  * @hash_expr: An expression that computes the hash of an element, given
- * const @elem_type *elem and h_index_t table_size.  If this function is
- * evaluated, table_size is always positive.
+ * const @elem_type *elem, h_index_t table_size and int hash_bits.  If
+ * this function is evaluated, table_size is always positive.
  * @is_empty_expr: An expression that evaluates to true if the element is
  * empty (i.e. not used).  Empty elements are not returned by find.  If
  * the zero value of @elem_type is not "empty", the caller must set all
  * the slots to empty before using the table.
  */
-#define DEFINE_COALESCED_HASH_TABLE(elem_type, table_func_prefix, key_member, \
-				    next_collision_member, hash_expr,         \
-				    is_empty_expr)                            \
-	static inline h_index_t table_func_prefix##_hash_elem(                \
-		const void *_elem, h_index_t table_size)                      \
-	{                                                                     \
-		const elem_type *elem = _elem;                                \
-		return hash_expr;                                             \
-	}                                                                     \
-	static inline h_index_t table_func_prefix##_get_next_collision(       \
-		const void *elem)                                             \
-	{                                                                     \
-		return ((const elem_type *)elem)->next_collision_member;      \
-	}                                                                     \
-	static inline void table_func_prefix##_set_next_collision(            \
-		void *elem, h_index_t next_collision)                         \
-	{                                                                     \
-		((elem_type *)elem)->next_collision_member = next_collision;  \
-	}                                                                     \
-	static inline bool table_func_prefix##_compare_elem(                  \
-		const void *key_elem, const void *found_elem)                 \
-	{                                                                     \
-		const elem_type *key = key_elem;                              \
-		const elem_type *found = found_elem;                          \
-		return key->key_member.data == found->key_member.data;        \
-	}                                                                     \
-	static inline bool table_func_prefix##_element_is_empty(              \
-		const void *_elem)                                            \
-	{                                                                     \
-		const elem_type *elem = _elem;                                \
-		return is_empty_expr;                                         \
-	}                                                                     \
-	static inline const elem_type *table_func_prefix##_find(              \
-		const elem_type *table, h_index_t table_size,                 \
-		const elem_type *elem_to_find)                                \
-	{                                                                     \
-		return h_find(table, table_size, sizeof(elem_type),           \
-			      elem_to_find, table_func_prefix##_hash_elem,    \
-			      table_func_prefix##_get_next_collision,         \
-			      table_func_prefix##_compare_elem,               \
-			      table_func_prefix##_element_is_empty);          \
-	}                                                                     \
-	static inline void table_func_prefix##_initialize(                    \
-		elem_type *table, h_index_t table_size)                       \
-	{                                                                     \
-		h_initialize(table, table_size, sizeof(elem_type),            \
-			     table_func_prefix##_set_next_collision,          \
-			     table_func_prefix##_element_is_empty);           \
-	}                                                                     \
-	static inline void table_func_prefix##_insert(                        \
-		struct h_insert_scratch *scratch, const elem_type *elem)      \
-	{                                                                     \
-		h_insert(scratch, elem, table_func_prefix##_hash_elem,        \
-			 table_func_prefix##_get_next_collision,              \
-			 table_func_prefix##_set_next_collision,              \
-			 table_func_prefix##_element_is_empty);               \
+#define DEFINE_COALESCED_HASH_TABLE(elem_type, table_func_prefix, key_member,  \
+				    next_collision_member, hash_expr,          \
+				    is_empty_expr)                             \
+	static inline h_index_t table_func_prefix##_hash_elem(                 \
+		const void *_elem, h_index_t table_size, int hash_bits)        \
+	{                                                                      \
+		const elem_type *elem = _elem;                                 \
+		return hash_expr;                                              \
+	}                                                                      \
+	static inline h_index_t table_func_prefix##_get_next_collision(        \
+		const void *elem)                                              \
+	{                                                                      \
+		return ((const elem_type *)elem)->next_collision_member;       \
+	}                                                                      \
+	static inline void table_func_prefix##_set_next_collision(             \
+		void *elem, h_index_t next_collision)                          \
+	{                                                                      \
+		((elem_type *)elem)->next_collision_member = next_collision;   \
+	}                                                                      \
+	static inline bool table_func_prefix##_compare_elem(                   \
+		const void *key_elem, const void *found_elem)                  \
+	{                                                                      \
+		const elem_type *key = key_elem;                               \
+		const elem_type *found = found_elem;                           \
+		return key->key_member.data == found->key_member.data;         \
+	}                                                                      \
+	static inline bool table_func_prefix##_element_is_empty(               \
+		const void *_elem)                                             \
+	{                                                                      \
+		const elem_type *elem = _elem;                                 \
+		return is_empty_expr;                                          \
+	}                                                                      \
+	static inline const elem_type *table_func_prefix##_find(               \
+		const elem_type *table, h_index_t table_size, int hash_bits,   \
+		const elem_type *elem_to_find)                                 \
+	{                                                                      \
+		return h_find(table, table_size, hash_bits, sizeof(elem_type), \
+			      elem_to_find, table_func_prefix##_hash_elem,     \
+			      table_func_prefix##_get_next_collision,          \
+			      table_func_prefix##_compare_elem,                \
+			      table_func_prefix##_element_is_empty);           \
+	}                                                                      \
+	static inline void table_func_prefix##_initialize(                     \
+		elem_type *table, h_index_t table_size)                        \
+	{                                                                      \
+		h_initialize(table, table_size, sizeof(elem_type),             \
+			     table_func_prefix##_set_next_collision,           \
+			     table_func_prefix##_element_is_empty);            \
+	}                                                                      \
+	static inline void table_func_prefix##_insert(                         \
+		struct h_insert_scratch *scratch, const elem_type *elem)       \
+	{                                                                      \
+		h_insert(scratch, elem, table_func_prefix##_hash_elem,         \
+			 table_func_prefix##_get_next_collision,               \
+			 table_func_prefix##_set_next_collision,               \
+			 table_func_prefix##_element_is_empty);                \
 	}
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 4091e80e45df..bcbad313a958 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -159,6 +159,7 @@ static int dom_calculate_merged_sizes(
 	const struct landlock_rule *walker_rule, *next_rule;
 	struct landlock_domain_index find_key;
 	const struct landlock_domain_index *found;
+	int dom_hash_bits = get_hash_bits(dom_num_indices);
 
 	build_check_domain();
 
@@ -168,7 +169,7 @@ static int dom_calculate_merged_sizes(
 		if (dom_ind_array) {
 			find_key.key = walker_rule->key;
 			found = dom_hash_find(dom_ind_array, dom_num_indices,
-					      &find_key);
+					      dom_hash_bits, &find_key);
 		}
 		/* A new index is only needed if this is a non-overlapping new rule */
 		if (!found) {
@@ -214,6 +215,7 @@ static int dom_populate_indices(
 	const struct landlock_rule *walker_rule, *next_rule;
 	const struct landlock_domain_index *found;
 	struct h_insert_scratch scratch;
+	int dom_hash_bits = get_hash_bits(dom_num_indices);
 	int ret;
 	size_t i;
 
@@ -224,7 +226,8 @@ static int dom_populate_indices(
 	}
 
 	ret = h_init_insert_scratch(&scratch, out_indices, out_size,
-				    sizeof(*out_indices));
+				    sizeof(*out_indices),
+				    get_hash_bits(out_size));
 	if (ret)
 		return ret;
 
@@ -248,7 +251,7 @@ static int dom_populate_indices(
 		found = NULL;
 		if (dom_ind_array)
 			found = dom_hash_find(dom_ind_array, dom_num_indices,
-					      &target);
+					      dom_hash_bits, &target);
 		if (!found) {
 			if (WARN_ON_ONCE(indices_written >= out_size)) {
 				ret = -E2BIG;
@@ -311,6 +314,7 @@ dom_populate_layers(const struct landlock_domain_index *const dom_ind_array,
 	const struct landlock_rule *found_in_child;
 	const struct landlock_layer *layer;
 	struct landlock_layer child_layer;
+	int dom_hash_bits = get_hash_bits(dom_num_indices);
 
 	for (size_t i = 0; i < child_indices_size; i++) {
 		merged_index = &child_indices[i];
@@ -320,8 +324,9 @@ dom_populate_layers(const struct landlock_domain_index *const dom_ind_array,
 		found_in_parent.layers_end = NULL;
 		if (dom_ind_array)
 			found_in_parent = landlock_domain_find(
-				dom_ind_array, dom_num_indices, dom_layer_array,
-				dom_num_layers, merged_index->key);
+				dom_ind_array, dom_num_indices, dom_hash_bits,
+				dom_layer_array, dom_num_layers,
+				merged_index->key);
 		dom_rule_for_each_layer(found_in_parent, layer)
 		{
 			if (WARN_ON_ONCE(layers_written >= out_size))
@@ -387,6 +392,9 @@ static int merge_domain(const struct landlock_domain *parent,
 		if (err)
 			return err;
 
+		child->fs_index_hash_bits =
+			get_hash_bits(child->num_fs_indices);
+
 #ifdef CONFIG_INET
 		err = dom_calculate_merged_sizes(
 			parent ? dom_net_indices(parent) : NULL,
@@ -396,9 +404,13 @@ static int merge_domain(const struct landlock_domain *parent,
 			&child->num_net_layers);
 		if (err)
 			return err;
+
+		child->net_index_hash_bits =
+			get_hash_bits(child->num_net_indices);
 #else
 		child->num_net_indices = 0;
 		child->num_net_layers = 0;
+		child->net_index_hash_bits = 0;
 #endif /* CONFIG_INET */
 	} else {
 		err = dom_populate_indices(
@@ -847,6 +859,41 @@ bool landlock_unmask_layers(const struct landlock_found_rule rule,
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
+static void test_domain_hash_func(struct kunit *const test)
+{
+	u32 table_size, got_hash_bits, got_hash;
+	uintptr_t hash_input;
+	int i;
+	struct landlock_domain_index elem;
+
+	KUNIT_ASSERT_EQ(test, get_hash_bits(0), 0);
+
+	for (table_size = 1; table_size <= 65; table_size++) {
+		got_hash_bits = get_hash_bits(table_size);
+		KUNIT_ASSERT_GE_MSG(
+			test, 1 << got_hash_bits, table_size,
+			"get_hash_bits(%u) returned %d which is too small for table size %u",
+			table_size, got_hash_bits, table_size);
+		KUNIT_ASSERT_LE_MSG(
+			test, 1 << got_hash_bits, table_size * 2,
+			"get_hash_bits(%u) returned %d which is too large for table size %u",
+			table_size, got_hash_bits, table_size);
+
+		for (i = 0; i < 1000; i++) {
+			hash_input = get_random_long();
+			elem.key.data = hash_input;
+			got_hash = dom_index_hash_func(&elem, table_size,
+						       got_hash_bits);
+			KUNIT_ASSERT_LT_MSG(
+				test, got_hash, table_size,
+				"dom_index_hash_func(key=%lx, table_size=%u, hash_bits=%d) "
+				"returned %u which exceeded table size %u",
+				hash_input, table_size, got_hash_bits, got_hash,
+				table_size);
+		}
+	}
+}
+
 static void test_landlock_get_deny_masks(struct kunit *const test)
 {
 	const layer_mask_t layers1[BITS_PER_TYPE(access_mask_t)] = {
@@ -881,6 +928,7 @@ static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_layer_deny_mask),
 	KUNIT_CASE(test_landlock_get_deny_masks),
+	KUNIT_CASE(test_domain_hash_func),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index ac820903ccb6..998c4e747a35 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -71,7 +71,17 @@ struct landlock_domain {
 	 * @num_layers: Number of layers in this domain.  This enables to
 	 * check that all the layers allow an access request.
 	 */
-	u32 num_layers;
+	u16 num_layers;
+	/**
+	 * @fs_index_hash_bits: Precomputed hash bits for the fs table to
+	 * avoid recomputing this power of 2 every hash.
+	 */
+	u8 fs_index_hash_bits;
+	/**
+	 * @net_index_hash_bits: Precomputed hash bits for the net table to
+	 * avoid recomputing this power of 2 every hash.
+	 */
+	u8 net_index_hash_bits;
 	/**
 	 * @num_fs_indices: Number of non-overlapping (i.e. not for the same
 	 * object) inode rules.  Does not include the terminating index.
@@ -175,9 +185,40 @@ struct landlock_domain {
  */
 #define dom_index_is_empty(elem) ((elem)->layer_index == U32_MAX)
 
+/**
+ * dom_index_hash_func - Hash function for the domain index tables.
+ */
+static inline h_index_t
+dom_index_hash_func(const struct landlock_domain_index *elem,
+		    const h_index_t table_size, const int hash_bits)
+{
+	if (hash_bits <= 0)
+		/* hash_long requires hash_bits > 0 */
+		return 0;
+	h_index_t h = hash_long(elem->key.data, hash_bits);
+	/* hash_bits is at most 2x table_size */
+	if (h >= table_size)
+		h -= table_size;
+	return h;
+}
+
+static inline int get_hash_bits(const u32 table_size)
+{
+	if (table_size <= 1)
+		return 0;
+	/**
+	 * Example:
+	 * For table_size = 2, we need 1 bits.  ilog2(2-1)+1 = 0+1 = 1.
+	 * For table_size = 3, we need 2 bits.  ilog2(3-1)+1 = 1+1 = 2.
+	 * For table_size = 4, we need 2 bits.  ilog2(4-1)+1 = 1+1 = 2.
+	 * For table_size = 5, we need 3 bits.  ilog2(5-1)+1 = 2+1 = 3.
+	 */
+	return ilog2(table_size - 1) + 1;
+}
+
 DEFINE_COALESCED_HASH_TABLE(struct landlock_domain_index, dom_hash, key,
 			    next_collision,
-			    hash_long(elem->key.data, 32) % table_size,
+			    dom_index_hash_func(elem, table_size, hash_bits),
 			    dom_index_is_empty(elem))
 
 struct landlock_domain *
@@ -207,13 +248,14 @@ struct landlock_found_rule {
  *
  * @indices_arr: The indices array to search in.
  * @num_indices: The number of elements in @indices_arr.
+ * @hash_bits: The corresponding hash_bits for the indices array.
  * @layers_arr: The layers array.
  * @num_layers: The number of elements in @layers_arr.
  * @key: The key to search for.
  */
 static inline struct landlock_found_rule
 landlock_domain_find(const struct landlock_domain_index *const indices_arr,
-		     const u32 num_indices,
+		     const u32 num_indices, const int hash_bits,
 		     const struct landlock_layer *const layers_arr,
 		     const u32 num_layers, const union landlock_key key)
 {
@@ -223,7 +265,7 @@ landlock_domain_find(const struct landlock_domain_index *const indices_arr,
 	struct landlock_found_rule out_found_rule = {};
 	const struct landlock_domain_index *found;
 
-	found = dom_hash_find(indices_arr, num_indices, &key_elem);
+	found = dom_hash_find(indices_arr, num_indices, hash_bits, &key_elem);
 
 	if (found) {
 		if (WARN_ON_ONCE(found->layer_index >= num_layers))
@@ -236,13 +278,15 @@ landlock_domain_find(const struct landlock_domain_index *const indices_arr,
 	return out_found_rule;
 }
 
-#define dom_find_index_fs(dom, key)                                      \
-	landlock_domain_find(dom_fs_indices(dom), (dom)->num_fs_indices, \
-			     dom_fs_layers(dom), (dom)->num_fs_layers, key)
+#define dom_find_index_fs(dom, key)                                         \
+	landlock_domain_find(dom_fs_indices(dom), (dom)->num_fs_indices,    \
+			     (dom)->fs_index_hash_bits, dom_fs_layers(dom), \
+			     (dom)->num_fs_layers, key)
 
-#define dom_find_index_net(dom, key)                                       \
-	landlock_domain_find(dom_net_indices(dom), (dom)->num_net_indices, \
-			     dom_net_layers(dom), (dom)->num_net_layers, key)
+#define dom_find_index_net(dom, key)                                          \
+	landlock_domain_find(dom_net_indices(dom), (dom)->num_net_indices,    \
+			     (dom)->net_index_hash_bits, dom_net_layers(dom), \
+			     (dom)->num_net_layers, key)
 
 #define dom_find_success(found_rule) ((found_rule).layers_start != NULL)
 
-- 
2.49.0

