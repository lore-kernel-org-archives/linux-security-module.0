Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C5266F00
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856089; cv=none; b=M5DuZlusTXzLPp5JpisR/INN8gbcyPO3J2Bn9Bt0kxaIvmdlDdNa+aSOFchVcrzzo6kl3YPWgwS7MDb7xJ/1jbPoIPv0audGnLZDYxzJw9xUuZJhurJ4nQ5jCJBoppQxock7SrB8gfnNHQYZGRhueKXdRu61HeqCiAY2ceDrjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856089; c=relaxed/simple;
	bh=tqe3WzW1Wzi+yiWVwehswb8Jc2KXpXgczfqMhFNic+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOdhAapt28WVIVQYsK4DP61HIYBQNkuXvEaDck9Ha6ysKZAtQQg5MOqo8ug1cOm5xDmFjOoEn7l+JGn759A++/Cn5SyohsrBDjb6YM9jzXiWuiiA5YmlUplPw1F7INJNl9KGACy8KCZQ8XiAXIGfAi4GdWLHr/biEwBlTU3tQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AmvJwvLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdxRL222; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AmvJwvLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdxRL222"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id ECA20138042A;
	Wed, 21 May 2025 15:34:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 15:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856086; x=
	1747942486; bh=90cksteMaKCHrlFYVtuW8MlgM0IbgdPK3hjrBBFz96o=; b=A
	mvJwvLBC3VLDqHhFAhErsvHR5/Lq0j7J7O4qsDsUTTIkKNIbfsA9GIQYsyOpRkNj
	71AzHh0gK6OMoIG11zXUqKta69rMHgwrzm+FXsOt7Q8dUDp+ltaLh+vyLxhtGd4E
	BA6U0rxr/YoLLUP/OWyzziRyZozkr/SxjgQtsjG0jBGwdkGhWHZBdfxuZF0KTSJz
	EMOG7/ak2EwMGx0zmAsDTRcRlXudkaSlSAaqUf1Z4twjo2rd1CH0baVoK8cceEbz
	a7t3/VjOLOq/dNefR3HeZP7zoEHG1iY3MaJYfxrU1Qfku4V0vrw3qaqRUd24qNV8
	k3f5SsDN92ocF+tUlrA3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856086; x=1747942486; bh=9
	0cksteMaKCHrlFYVtuW8MlgM0IbgdPK3hjrBBFz96o=; b=JdxRL222t3+ctvKb+
	6MfD1sXrVZ8KIcJmzp3pGetNf/nUECvMf9UNzgIeRZzhgqjJXqCOseeWYm8Bmzr1
	LzdCcuNcjQvzmIKb2ltRCyyX+gy2X1356/4PgsQGsoc/4wqo+abQnE6Bvf/gaucE
	UKNrnLCHPYioY0e8DNfMsu8bHG5lKt8dWYTxhtPS+5SLht0KZ2Krg8yLxa+3TxkD
	Q5lZ8Bl9AxqOfAFVIZ6dJZXsYuQvMAy+53dRuQDqqQ9U+xI/KDDuShmLT4JTgfOa
	kg0IlPYHuwBtf5krnsvD3EiZ7M6z8MqdyQQB2AJTx0Uhsvlf63K5F6qDZeZuFJZ3
	dG6Tw==
X-ME-Sender: <xms:1iouaAJjClI1nVG99BDBy58AF6b1DVkh78cUHOREmadWlEgo1nsDew>
    <xme:1iouaAIQLo1e0fM2biDHDwdHUnzTAU4F694dP4aY8mW2OpQ50FOP4vClDj8-ITVq2
    VbrymziyM0yMEsY7H4>
X-ME-Received: <xmr:1iouaAv1NvTvzqrTYFJGV4WoSvtoxd9K1lZLNBDRZY6pNwXlfAJ_wB_ak_C5E7uYWqMjd-p36EUzIPCH-uZ3QAC8IvaJqa-FNJDVweenAw_GaQ3L6sWTsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
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
X-ME-Proxy: <xmx:1iouaNajlRBUOgPQF-t1XE09QsjKVgbAzHMQmAMhj0r4gGUMcHDg2g>
    <xmx:1iouaHbKdFodVypAowDF-yxWsbZq1uvR-t4mGZoixefQlxPipDRr_Q>
    <xmx:1iouaJDUTutPkPQbftqBEeuvqQ3sjdLqfIHAaPWMWX3ZStxrvYJ0gg>
    <xmx:1iouaNZy50rK3PSYAx5Nl42jiSbIXJSBjdeJ791_Lm8MpWLZ_xFDbg>
    <xmx:1iouaI5Y3dQb_B88BJIxeMzWBaxgLEyq2KmlmYQjO5mqPQ4PnF9smZaa>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:45 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 03/10] landlock/hash: Use linear search for small tables
Date: Wed, 21 May 2025 20:31:59 +0100
Message-ID: <15c39519cfac85730d92cda11e4430773dbb2117.1747836146.git.m@maowtm.org>
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

The cost of hashing is too significant when there's only a small number of
entries.  For that we might as well just walk the hlist.  The optimal
threshold can be determined imperically which I will do later.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/hash.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/landlock/hash.h b/security/landlock/hash.h
index 955c5756d4d9..8393593cfe7b 100644
--- a/security/landlock/hash.h
+++ b/security/landlock/hash.h
@@ -13,6 +13,8 @@
 
 #include "ruleset.h"
 
+#define LANDLOCK_HASH_LINEAR_THRESHOLD 4
+
 struct landlock_hashtable {
 	struct hlist_head *hlist;
 
@@ -37,7 +39,11 @@ static inline int landlock_hash_init(const size_t expected_num_entries,
 	size_t table_sz = 1;
 	int hash_bits = 0;
 
-	if (likely(expected_num_entries > 0)) {
+	/*
+	 * For small tables, we just have one slot, essentially making lookups
+	 * a linear search.  Doing a hash for small tables is not worth it.
+	 */
+	if (expected_num_entries > LANDLOCK_HASH_LINEAR_THRESHOLD) {
 		table_sz = roundup_pow_of_two(expected_num_entries);
 		hash_bits = fls_long(table_sz - 1);
 	}
@@ -81,6 +87,10 @@ static inline void landlock_hash_free(struct landlock_hashtable *ht,
 static inline u32 landlock_hash_key(const union landlock_key key,
 				    const int hash_bits)
 {
+	if (hash_bits == 0) {
+		return 0;
+	}
+
 	return hash_ptr((void *)key.data, hash_bits);
 }
 
-- 
2.49.0

