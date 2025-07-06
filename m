Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA113D891
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815099; cv=none; b=ifnWTPmbX/BmeMSY5Clv+gfUMfFrGSYzavoKP/BVZkao+IBp4Pkbx06ZDpgIgrOryqb+3iqurLhLWDqv8jLw5YLBKTK87cLXI4uIXT+sWekNtLPpzTkT8n0UQZOlYsBVl5mOAR6q9tvIBKApC8qN9ZSUMgQpY1bMTnF4Gq0P7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815099; c=relaxed/simple;
	bh=/2WlCAq45vCbjeTkRxFW/bYgQmpgNOg/7VpxDvoQ34g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVRVuwMEiTxj9AFe/nk683Uoae0uJLe0FoCjux12Pu7V1cL3KrIVvQMSP1fPanusRxqRpaCB+0Sp/3VBaXr47A7gAzf4xp0MFejH0VaJzlbdZHDtfhu/GEQWjg1o0ldY5NshzQ+HmknRH7ZuZE4po/Nfn0bCYrtL/cRTqv4TNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=F9k340ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWs+yK/r; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="F9k340ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWs+yK/r"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EE297A015B;
	Sun,  6 Jul 2025 11:18:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 06 Jul 2025 11:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751815096;
	 x=1751901496; bh=CuRzTkXYAacxO0KG5Wy+/Db9eh5kvBjRf6nGI1gbfPU=; b=
	F9k340gawYoGPFxFdvnfgTcOMFu33ADorePRmXq1+MPioZuctWzn88YY3ACc4nY1
	zJGI8BarycjgNgUjQXFphV1eFPnCm+dZSWKrpIjYaWAYD+TSr3UY6tqUN+A3akAU
	sHTvWvzlXNCfT9hURm7X31i+YhOFM7EglZ2tqiQnD400v7oeL54d6IP2xqDaSMTz
	JxWfDROF5Gda1zfTLZRZj5hQ8jRrNpThHSNLdC4SR/feRX6uLtD8+KNgtPWQXJ5z
	YWbP7O+QaWKZpZV6XtaYayROEa2+iSvbfx5sxXr/4CWwMOb4JllePRSdeTwO/bG8
	39Cswva2helcWQlSJlED0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751815096; x=
	1751901496; bh=CuRzTkXYAacxO0KG5Wy+/Db9eh5kvBjRf6nGI1gbfPU=; b=J
	Ws+yK/rffy+MvvLClk/wImlH70uBKSFLvX3GXfywbQApwGV5PT5570L2wajVA0Ts
	0SLQGDAQaiSiI21zpMpGwcEAvMgu4bcEc+kfXyXd4zpepRqENCJYKC3tNqzpgN61
	r6ea1WS41ecq/kXBVK9wiFU8Q30LxUP2X9De/Kr0KYVBy8GKlIxiHzmM1px2ZfIy
	tt+sj6u4a6mYN22EDsqhJuxnucq75dbEKEvk/oWoAi0YITf4GHJ4BF3T0zCdh7bY
	xr0fjDp8fWoxeR+dKgKJlM6SZGCJMu4LBtCOvuVFZV3fQ563RI0IzwBFBMM4bNO3
	Ztzyi5Q3w12DpooRR03CQ==
X-ME-Sender: <xms:t5NqaCB2hpva-6O6ZdiD3BC8KQI3kOwz-O6wqq6VBVHHLEyfdzubQg>
    <xme:t5NqaMgn1_O0Oha87VlxdBx7_cZNYqxFhFhA938wpWGDrL6cLn97LlYDrfjDxRRUv
    7-EUCMJbxyTrkst-m8>
X-ME-Received: <xmr:t5NqaFn4GTRb35HuBZecFGlwoPWlfobFsXZFSrBmWczhUofXLgpWhJp8nB7Z6VC3aqMBTkEFQHV84lhNrpob7e37yxGEhezOsRWd7n5b8NGglWersxl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejff
    ekjedugfetffeuiefhvedtvdefheeghefffffhkeevjefgkeeifffhheffudenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvg
    htpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehm
    sehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghnohhv
    rdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtth
    hopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:t5NqaAwgHumhppB99f6xxrUOwMmhnKN0CtlHMIlkAXtwtDuKMYEneA>
    <xmx:t5NqaHQx8oFGQRD0eCa4DJZP-M0SxwzZdpLrfLAj5dXwGCNDZFo1xQ>
    <xmx:t5NqaLbiY5xJiFdq9w7hMtQNtyRUf7SzZo4hJqs9WBIUvytRxZdDhQ>
    <xmx:t5NqaASdnJqLq1qGpDYgtPIcNr2xLtKGjW4F6BUkHpRm9EuhpG8wCA>
    <xmx:uJNqaEosj6uPXPw_cpD-55HN6DGb7WhOrty0ST1_A34_qMh_ltAuuyRu>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:14 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 02/12] landlock/domain: Define structure and macros for flat-array domains
Date: Sun,  6 Jul 2025 16:16:43 +0100
Message-ID: <5f5b75a8d4dd62e2537ed7206b27bbe1b8a7f331.1751814658.git.m@maowtm.org>
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

This implements the structure proposed in in [1], using a flat array to
store the rules and eventually using hashing to find rules.  The array is
stored in the domain struct itself to avoid extra pointer indirection and
make all the rule data as cache-local as possible.  The non-array part of
the domain struct is also kept reasonably small.  This works well for a
small (10 or 20 rules) ruleset, which is the common case for Landlock
users, and still has reasonable performance for large ones.

This will eventually make landlock_rule/landlock_ruleset only needed for
unmerged rulesets, and thus it doesn't have to store multiple layers etc.
create_rule and insert_rule would also hopefully become much simpler.

Different to the original proposal, the number of layers for each rule is
now deducted from the layer index of the next offset.  In order to
simplify logic, a special "terminating index" is placed after each of the
two index arrays, which will contain a layer_index = num_layers.

On reflection, using the name "layer" to refer to individual struct
landlock_layers is very confusing especially with names like num_layers -
the next version should probably find a better name for it.

Link: https://lore.kernel.org/all/20250526.quec3Dohsheu@digikod.net/ [1]

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c |   8 +++
 security/landlock/domain.h | 125 +++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d06..83233bf3be6a 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -24,6 +24,14 @@
 #include "domain.h"
 #include "id.h"
 
+static void __maybe_unused build_check_domain(void)
+{
+	BUILD_BUG_ON(LANDLOCK_MAX_NUM_RULES >= U32_MAX - 1);
+	/* Non-inclusive end indices are involved, so needs to be U32_MAX - 1. */
+	BUILD_BUG_ON(LANDLOCK_MAX_NUM_RULES * LANDLOCK_MAX_NUM_LAYERS >=
+		     U32_MAX - 1);
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a..b0f5ba59ff4c 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -5,6 +5,7 @@
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
  * Copyright © 2024-2025 Microsoft Corporation
+ * Copyright © 2025      Tingmao Wang <m@maowtm.org>
  */
 
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
@@ -20,6 +21,130 @@
 
 #include "access.h"
 #include "audit.h"
+#include "ruleset.h"
+
+struct landlock_domain_index {
+	/**
+	 * @key: The landlock object or port identifier.
+	 */
+	union landlock_key key;
+	/**
+	 * @next_collision: Points to another slot in the domain indices
+	 * array, forming a collision chain in a coalesced hashtable.  See
+	 * landlock_domain_find for how this is used.
+	 */
+	u32 next_collision;
+	/**
+	 * @layer_index: The index of the first landlock_layer corresponding
+	 * to this key in the relevant subarray.  A rule may have multiple
+	 * layers.  The end of the layers region for this rule is the index of
+	 * the next struct landlock_domain_index in the array.
+	 */
+	u32 layer_index;
+};
+
+struct landlock_domain {
+	/**
+	 * @num_layers: Number of layers in this domain.  This enables to
+	 * check that all the layers allow an access request.
+	 */
+	u32 num_layers;
+	/**
+	 * @num_fs_indices: Number of non-overlapping (i.e. not for the same
+	 * object) inode rules.  Does not include the terminating index.
+	 */
+	u32 num_fs_indices;
+	/**
+	 * @num_net_indices: Number of non-overlapping (i.e. not for the same
+	 * port) network rules.  Does not include the terminating index.
+	 */
+	u32 num_net_indices;
+	/**
+	 * @num_fs_layers: Number of landlock_layer in the fs_layers array.
+	 */
+	u32 num_fs_layers;
+	/**
+	 * @num_net_layers: Number of landlock_layer in the net_layers array.
+	 */
+	u32 num_net_layers;
+	/**
+	 * @len_rules: Total length (in units of uintptr_t) of the rules
+	 * array.  Used to check accesses are not out of bounds, but in theory
+	 * this is always derivable from the other length fields.
+	 */
+	u32 len_rules;
+	/**
+	 * @rules: The rest of this struct consists of 5 dynamically-sized,
+	 * arrays as well as 2 terminating indices, placed one after another,
+	 * the contents of which are to be accessed with dom_ helper macros
+	 * defined in this header.  They are:
+	 *
+	 *     struct access_masks access_masks[num_layers];
+	 *     (possible alignment padding here)
+	 *     struct landlock_domain_index fs_indices[num_fs_indices];
+	 *     struct landlock_domain_index terminating_fs_index;
+	 *     struct landlock_domain_index net_indices[num_net_indices];
+	 *     struct landlock_domain_index terminating_net_index;
+	 *     struct landlock_layer fs_layers[num_fs_layers];
+	 *     struct landlock_layer net_layers[num_net_layers];
+	 *     (possible alignment padding here)
+	 *
+	 * The purpose of the terminating indices is to allow getting the
+	 * non-inclusive end index of the layers for a rule without branching.
+	 * They do not represent any rules themselves, and the only valid
+	 * field for those two indices is layer_index.
+	 */
+	uintptr_t rules[] __counted_by(len_rules);
+};
+
+#define dom_access_masks(dom) ((struct access_masks *)((dom)->rules))
+
+#define _dom_fs_indices_offset(dom)                                        \
+	(ALIGN(array_size((dom)->num_layers, sizeof(struct access_masks)), \
+	       sizeof(uintptr_t)))
+
+#define dom_fs_indices(dom)                                      \
+	((struct landlock_domain_index *)((char *)(dom)->rules + \
+					  _dom_fs_indices_offset(dom)))
+
+#define dom_fs_terminating_index(dom) \
+	(&dom_fs_indices(dom)[(dom)->num_fs_indices])
+
+#define _dom_net_indices_offset(dom)                       \
+	(_dom_fs_indices_offset(dom) +                     \
+	 array_size(((size_t)(dom)->num_fs_indices) + 1ul, \
+		    sizeof(struct landlock_domain_index)))
+
+#define dom_net_indices(dom)                                     \
+	((struct landlock_domain_index *)((char *)(dom)->rules + \
+					  _dom_net_indices_offset(dom)))
+
+#define dom_net_terminating_index(dom) \
+	(&dom_net_indices(dom)[(dom)->num_net_indices])
+
+#define _dom_fs_layers_offset(dom)                          \
+	(_dom_net_indices_offset(dom) +                     \
+	 array_size((size_t)((dom)->num_net_indices) + 1ul, \
+		    sizeof(struct landlock_domain_index)))
+
+#define dom_fs_layers(dom)                                \
+	((struct landlock_layer *)((char *)(dom)->rules + \
+				   _dom_fs_layers_offset(dom)))
+
+#define _dom_net_layers_offset(dom)   \
+	(_dom_fs_layers_offset(dom) + \
+	 array_size((dom)->num_fs_layers, sizeof(struct landlock_layer)))
+
+#define dom_net_layers(dom)                               \
+	((struct landlock_layer *)((char *)(dom)->rules + \
+				   _dom_net_layers_offset(dom)))
+
+#define dom_rules_len(dom)                                        \
+	(ALIGN(_dom_net_layers_offset(dom) +                      \
+		       array_size((dom)->num_net_layers,          \
+				  sizeof(struct landlock_layer)), \
+	       sizeof(uintptr_t)) /                               \
+	 sizeof(uintptr_t))
 
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
-- 
2.49.0

