Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40060285CB8
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815101; cv=none; b=Pj3MG//frcpvsbdXMDZ1oUV603APABB2DMLKNo9Bew++lPoAvJRkTVt56hDUeNJMhrYLAHQjMrk72iQ3F8aXWdOu1UxkM6e5CAFmRYEK1DqS6HgqpwcU8MUqXMrMrl+YXNu6YH5Q1G1FG7tmHeyZTNEwT0+MOfa4IKdS88ynD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815101; c=relaxed/simple;
	bh=PAEp3jrd8S0HH1Wa1iCVl4m6SRpB7s506XRCJHOog4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujm9ddj4yF7WGdG/lHpDQkdqtM2K0Mj0Rw2Bn7mX2/C2pXZc+7wdHJ1/+yIfTrset74O0/Lev5CM0r/wCsIkpHn/k/i70qjp9LrBVDAajdrtqOBk7ULzuCOWPTCl7CP6LWPlafGTakNDezOUqQPeVdJH884tmCAlm8E6RChiHFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=iHPFNOiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNn4dY7k; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="iHPFNOiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNn4dY7k"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86BEC7A0169;
	Sun,  6 Jul 2025 11:18:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 06 Jul 2025 11:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751815098;
	 x=1751901498; bh=Kw0WxHed0SV7BmpOeTtpc57Emu2+UwRv5+yKEaSAwfc=; b=
	iHPFNOiS4Vc8+aHEgV6+f3PgPWf9rTuXq3nA6tiHl7ddg99VCUnUuyk5ejVuVMMa
	DM69XAT7bXlZ7vvKju6VV5kUd+NuVpuwYiACBPqY6FzJfvrIoHeBgwlzQUmqSbWe
	3cfx5rByMM93rbkza8OF1w6XV1buZq8St5AeGYyEBYGPkbT1nGTercdgbZ/ZegQ/
	r9wCMfsR0vhGKfFeUDEzFcPMvZ9JFl+gbga/W71iHCMQykxtbZ36P3oWYgEQW0Xv
	ne/LXK5YCS41i4yGuc4zJZ2vhC0wf1CEuLaq4UN2El6vaDrOwC3/cJI6RWvR+u6Z
	zOFBaQjiy5qQkSDL/ktObg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751815098; x=
	1751901498; bh=Kw0WxHed0SV7BmpOeTtpc57Emu2+UwRv5+yKEaSAwfc=; b=T
	Nn4dY7kKtZFqd9G29DKfghM6ZqmTrD7l5JGPoB/M8OIq5GQOIIl6/CM5D24OXHfG
	QKHfGjG+Ku64b6rV+UIrYMNI6cr/WCrPPBcH/Sxm2FS9V3WUL8vd1L0JHgYQ7ZUa
	BCXqSHoM7zrErBxQZFt6/txW4G6FAgnDKpjkE76IwG8+Gd12m5jZdlsOvCsWDrhZ
	XIVXKymX/VEMK7kmRZVf523zzmPbneh/30I8WLyjuw2PE0UksFlT3sqSbsAghlVk
	CKtA2ksEABU8Ayh6uZIEm33wfeF7vBBSHqjILhpSXVkSkuakSEc5Knt5wu4P19nL
	I02x49AFJ98b9Xp0vldGA==
X-ME-Sender: <xms:upNqaLNSDDT2QQeHy_u1VmqnPdt9yzH_5dH-kdgMuq0Z8yhxdAX3VA>
    <xme:upNqaF8khvpkwk5-gkw3fCL9Eg53QOMFQ2_Rn4ioGVKYvA1lxHH5DE5jMmvQcsKvK
    8UNmHE-ANu0LTUTgb8>
X-ME-Received: <xmr:upNqaKQuvxAiM1Ait4gtSZOwzyhR83uqmRaqqR1XdEsRhTRDBlnyNke_9T2nXq0hrDI9U8WmwMIyKnTiFQooNE31whgwwhEra82Hnz-RvHybqUdsW3YB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeiie
    eggeehtdffieffhfekueffhefhveeugfdvkeejkeehvdettdfgvdeghfdujeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehivhgrnhhovhdrmhhikhhhrghilhdusehhuhgrfigvihdqphgr
    rhhtnhgvrhhsrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:upNqaPufYWGrpPcpSluvGpBZW5oTomV61oOl4nCQ-lzO35UFYC7H2A>
    <xmx:upNqaDdk9I1MItvl1oNnd_i1k51C7ARKUQeiu7FZPBnRaIgpn4_rbA>
    <xmx:upNqaL2xspgONACPklALDG6lmnEWo6k_h1kszOVM8ClzQIrimIHvSQ>
    <xmx:upNqaP8Mn8KLKJ0JlajYWVjQNvm8jLr9KGUveYWiJ90GW4myBqytfQ>
    <xmx:upNqaOk7jdZkKpqjh_9F0-JaEEojAvdyveGrn4HpvFrg59gWAf7x7lXw>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:17 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 03/12] landlock: Define coalesced hashtable and implement finding
Date: Sun,  6 Jul 2025 16:16:44 +0100
Message-ID: <fda3f8dbda58d73d31dbdeb4752db9d36716e8dd.1751814658.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751814658.git.m@maowtm.org>
References: <cover.1751814658.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit introduces utility functions for handling a (generic) compact
coalesced hash table, which we will use in the next commit.

I decided to make it generic for now but we can make it landlock-specific
if we want.

This should include a randomized unit test - I will add this in the next
version.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/coalesced_hash.h | 130 +++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 security/landlock/coalesced_hash.h

diff --git a/security/landlock/coalesced_hash.h b/security/landlock/coalesced_hash.h
new file mode 100644
index 000000000000..14950915f0b5
--- /dev/null
+++ b/security/landlock/coalesced_hash.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - utility functions for handling a compact coalesced hash
+ * tables.
+ *
+ * A coalesced hash table is an array (typically completely filled), where
+ * each element has a next_collision field that contains the index to the
+ * next collision in the chain.  If there is no next collision, the
+ * next_collision field is set to the index of the element itself.  A
+ * search for a particular key starts at the index that it hashes to, then
+ * we follow the chain of collisions until the key is found or we reach
+ * the end of the chain.  Before starting the collision chain loop, if we
+ * found that the element at the index we hashed to does not in fact hash
+ * to its index, then we know that there is no elements with our hash, and
+ * so we can terminate early.
+ *
+ * Copyright © 2025      Tingmao Wang <m@maowtm.org>
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+
+typedef u32 h_index_t;
+
+typedef h_index_t (*hash_element_t)(const void *elem, h_index_t table_size);
+typedef h_index_t (*get_next_collision_t)(const void *elem);
+typedef void (*set_next_collision_t)(void *elem, h_index_t next_collision);
+typedef bool (*compare_element_t)(const void *key_elem, const void *found_elem);
+typedef bool (*element_is_empty_t)(const void *elem);
+
+static inline void *h_find(const void *table, h_index_t table_size,
+			   size_t elem_size, const void *elem_to_find,
+			   hash_element_t hash_elem,
+			   get_next_collision_t get_next_collision,
+			   compare_element_t compare_elem,
+			   element_is_empty_t element_is_empty)
+{
+	h_index_t curr_index, next_collision, next_hash;
+	const void *curr_elem;
+
+	if (unlikely(table_size == 0))
+		return NULL;
+
+	curr_index = hash_elem(elem_to_find, table_size);
+	if (WARN_ON_ONCE(curr_index >= table_size))
+		return NULL;
+	curr_elem = table + curr_index * elem_size;
+	if (compare_elem(elem_to_find, curr_elem))
+		return (void *)curr_elem;
+
+	if (element_is_empty(curr_elem))
+		return NULL;
+	next_collision = get_next_collision(curr_elem);
+	if (next_collision == curr_index)
+		return NULL;
+	next_hash = hash_elem(curr_elem, table_size);
+	if (next_hash != curr_index)
+		return NULL;
+
+	while (next_collision != curr_index) {
+		curr_index = next_collision;
+		curr_elem = table + curr_index * elem_size;
+		if (compare_elem(elem_to_find, curr_elem))
+			return (void *)curr_elem;
+		next_collision = get_next_collision(curr_elem);
+	}
+
+	return NULL;
+}
+
+/**
+ * DEFINE_COALESCED_HASH_TABLE - Define a set of functions to mainpulate a
+ * coalesced hash table holding elements of type @elem_type.
+ *
+ * @elem_type: The type of the elements.
+ * @table_func_prefix: The prefix to use for the functions.
+ * @key_member: The name of a member in @elem_type that contains the key
+ * (to compare for equality).
+ * @next_collision_member: The name of a member in @elem_type that is used
+ * to store the index of the next collision in a collision chain.
+ * @hash_expr: An expression that computes the hash of an element, given
+ * const @elem_type *elem and h_index_t table_size.  If this function is
+ * evaluated, table_size is always positive.
+ * @is_empty_expr: An expression that evaluates to true if the element is
+ * empty (i.e. not used).  Empty elements are not returned by find.  If
+ * the zero value of @elem_type is not "empty", the caller must set all
+ * the slots to empty before using the table.
+ */
+#define DEFINE_COALESCED_HASH_TABLE(elem_type, table_func_prefix, key_member, \
+				    next_collision_member, hash_expr,         \
+				    is_empty_expr)                            \
+	static inline h_index_t table_func_prefix##_hash_elem(                \
+		const void *_elem, h_index_t table_size)                      \
+	{                                                                     \
+		const elem_type *elem = _elem;                                \
+		return hash_expr;                                             \
+	}                                                                     \
+	static inline h_index_t table_func_prefix##_get_next_collision(       \
+		const void *elem)                                             \
+	{                                                                     \
+		return ((const elem_type *)elem)->next_collision_member;      \
+	}                                                                     \
+	static inline void table_func_prefix##_set_next_collision(            \
+		void *elem, h_index_t next_collision)                         \
+	{                                                                     \
+		((elem_type *)elem)->next_collision_member = next_collision;  \
+	}                                                                     \
+	static inline bool table_func_prefix##_compare_elem(                  \
+		const void *key_elem, const void *found_elem)                 \
+	{                                                                     \
+		const elem_type *key = key_elem;                              \
+		const elem_type *found = found_elem;                          \
+		return key->key_member.data == found->key_member.data;        \
+	}                                                                     \
+	static inline bool table_func_prefix##_element_is_empty(              \
+		const void *_elem)                                            \
+	{                                                                     \
+		const elem_type *elem = _elem;                                \
+		return is_empty_expr;                                         \
+	}                                                                     \
+	static inline const elem_type *table_func_prefix##_find(              \
+		const elem_type *table, h_index_t table_size,                 \
+		const elem_type *elem_to_find)                                \
+	{                                                                     \
+		return h_find(table, table_size, sizeof(elem_type),           \
+			      elem_to_find, table_func_prefix##_hash_elem,    \
+			      table_func_prefix##_get_next_collision,         \
+			      table_func_prefix##_compare_elem,               \
+			      table_func_prefix##_element_is_empty);          \
+	}
-- 
2.49.0

