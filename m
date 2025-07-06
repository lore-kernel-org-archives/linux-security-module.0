Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB714A09C
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815105; cv=none; b=GarPG4tMYEkNi3CEd6jQh4TQIh5YKvOAV+6zF4BxGAzRl/2AvimOU5xhvlgGu8Lo2l7R9swhql/tDeAzRwLh/DeLKDBX9kBr0Grm8I/RUE81lJK/JjnYwzom1Rr6ziVdgloglI+7okImO1YWd93J3MAM81KwtVASx+q7DDW8Mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815105; c=relaxed/simple;
	bh=qLTRJaOo7BzkIUuiOKAcKey+a5pPNxXp13xJgChx55c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwyLksvsWoU0iKpTxXXD+uHBrGL0tB6ujCEfQ6NA4oHULUYzUsmShxnK4wCvqn6iG+b95p2qs6ab9rnVjgLv3GaDBkfiqGJPPMKlJNvkEYICwH9Yuxfn+wb6YzG02kIwsU9LEHRW0th7eyOOL3n9c4T5jKXjcanjHbxn56OKNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Cq/0jGL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7/B/7Xs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Cq/0jGL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7/B/7Xs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D57F1D00147;
	Sun,  6 Jul 2025 11:18:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 06 Jul 2025 11:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815102; x=
	1751901502; bh=kj1Ax0mlP6fUS4So8SNtDL6j1TvkQ+8yTkUg4HAVX0I=; b=C
	q/0jGL8LPn20exuf4nRfrFCmK2xV04yCcGStvenKyzMY4aMYpL2voHL+caLO+aNs
	Jbv5QfyutCR39LyDP+kDaSDULsqw0DyYbEf5CEgQmcQrTUPYt2bcKYLjRnkvYMZT
	hDGB5JDYXjDwhC7gNcMmHQ1e610kTIKlLGNRrdoc0qObUNjUNJapnl+81wrgvXw2
	Zdl2X+gilRFjZHDSRUpFWDdkQmes2/rY2MM02mCQmoNLr/FcTFGzLOC/Cfv6/lhl
	TW4W57yNM/+wTN+IZV5Le/qrw3AtQZZgsNUozTY6ebBX3rQfTeN9xnOD5fkAtknx
	Ul4XDa4lSXxXDgR4dvayg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815102; x=1751901502; bh=k
	j1Ax0mlP6fUS4So8SNtDL6j1TvkQ+8yTkUg4HAVX0I=; b=F7/B/7Xsqrg2qeG//
	vlbzl7pNpWhT0MUZqQixFcRlyX86ffT4qm/omAAcSYKIb4yJOh+/z9HWgIaG0ttI
	zSRmF+gFEVTexPzRoQo6nb1RQvnaxSnRyV1LpHICAjXx1TJRZmB7saqKLSODDzoJ
	7x5CWNAy0Fr6zS4pmMCUsVhEzcdzrXiK13K8xUkkJ4MZuPLfIVwWg/9yd3DyqcNc
	x7QGT4R9Avwqwbh+qEgEt7G9NL4pll/CcU6TvefRROX7ptoRxwFb8/AAzhMTdU61
	mvps6tiuagm18iGKhVoImIOquj5uds7zHVgr+d+iShYoeej3VoQ4H/NzQo6Hwtbp
	D1C9Q==
X-ME-Sender: <xms:vZNqaA1pg_Flw78uj2Pi1AsVQIMuo6p-87SYSAT8J-7YAm4G2hWTdQ>
    <xme:vZNqaLGER0sMvrtvx-tMtZezldlQeXHTSerS0CinMYamZggZI7Rlh6xIL9i_2dsZf
    PJ3thLiTf3aFp5QK7g>
X-ME-Received: <xmr:vZNqaI7dNhcTGW5Bu3YMXWiC2T6yhs2B3eNFAjSaAheXnwNWZ34iCIoEyCmRCWA6RtM5X3T2SOEmgvK4FxvcCZEsgDExDeopwhc2skSuNr5YTfXW-bde>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepihhvrghnohhvrdhmihhkhhgrihhludeshhhurgifvghiqdhprghr
    thhnvghrshdrtghomhdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:vZNqaJ1VNdVV43aYmpAYdFKL9tKX4o5UhbusWv09FrACeSHHe48T3A>
    <xmx:vZNqaDFGoAEb8Z-rudSM9NZxjx84ZfGiag2ldUDXWqNigKKM0vHmkw>
    <xmx:vZNqaC-FYGQDszRLQ9Ig6rL2FI-s1a6E4hinKf2Gw2xiMwsLpLnqig>
    <xmx:vZNqaImAsnDVCtetjk5eVgphUNbBxFyjAG5hn56PQ_Y5xGqhnEMk3A>
    <xmx:vpNqaIMtdSd8oS9Go3Hi5MHB5uLOjg1hVPTxGE0e17bsHsZn2bsBIMvR>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:20 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 04/12] landlock/domain: Implement finding rules
Date: Sun,  6 Jul 2025 16:16:45 +0100
Message-ID: <4d09da243ee14ec5da06f72b02488d70b524eadf.1751814658.git.m@maowtm.org>
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

This implements a function to search for matching rules using the newly
defined coalesced hashtable, and define convinience macros for fs and net
respectively, as well as a macro to iterate over the layers of the rule.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.h | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index b0f5ba59ff4c..8acd88a1d77a 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -22,6 +22,7 @@
 #include "access.h"
 #include "audit.h"
 #include "ruleset.h"
+#include "coalesced_hash.h"
 
 struct landlock_domain_index {
 	/**
@@ -146,6 +147,72 @@ struct landlock_domain {
 	       sizeof(uintptr_t)) /                               \
 	 sizeof(uintptr_t))
 
+/*
+ * We have to use an invalid layer_index to signal empty value as the key
+ * can be 0 for net rules.
+ */
+#define dom_index_is_empty(elem) ((elem)->layer_index == U32_MAX)
+
+DEFINE_COALESCED_HASH_TABLE(struct landlock_domain_index, dom_hash, key,
+			    next_collision,
+			    hash_long(elem->key.data, 32) % table_size,
+			    dom_index_is_empty(elem))
+
+struct landlock_found_rule {
+	const struct landlock_layer *layers_start;
+	const struct landlock_layer *layers_end;
+};
+
+/**
+ * landlock_domain_find - search for a key in a domain.  Don't use this
+ * function directly, but use one of the dom_find_index_*() macros
+ * instead.
+ *
+ * @indices_arr: The indices array to search in.
+ * @num_indices: The number of elements in @indices_arr.
+ * @layers_arr: The layers array.
+ * @num_layers: The number of elements in @layers_arr.
+ * @key: The key to search for.
+ */
+static inline struct landlock_found_rule
+landlock_domain_find(const struct landlock_domain_index *const indices_arr,
+		     const u32 num_indices,
+		     const struct landlock_layer *const layers_arr,
+		     const u32 num_layers, const union landlock_key key)
+{
+	struct landlock_domain_index key_elem = {
+		.key = key,
+	};
+	struct landlock_found_rule out_found_rule = {};
+	const struct landlock_domain_index *found;
+
+	found = dom_hash_find(indices_arr, num_indices, &key_elem);
+
+	if (found) {
+		if (WARN_ON_ONCE(found->layer_index >= num_layers))
+			return out_found_rule;
+		out_found_rule.layers_start = &layers_arr[found->layer_index];
+		out_found_rule.layers_end =
+			&layers_arr[(found + 1)->layer_index];
+	}
+
+	return out_found_rule;
+}
+
+#define dom_find_index_fs(dom, key)                                      \
+	landlock_domain_find(dom_fs_indices(dom), (dom)->num_fs_indices, \
+			     dom_fs_layers(dom), (dom)->num_fs_layers, key)
+
+#define dom_find_index_net(dom, key)                                       \
+	landlock_domain_find(dom_net_indices(dom), (dom)->num_net_indices, \
+			     dom_net_layers(dom), (dom)->num_net_layers, key)
+
+#define dom_find_success(found_rule) ((found_rule).layers_start != NULL)
+
+#define dom_rule_for_each_layer(found_rule, layer) \
+	for (layer = (found_rule).layers_start;    \
+	     layer < (found_rule).layers_end; layer++)
+
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
-- 
2.49.0

