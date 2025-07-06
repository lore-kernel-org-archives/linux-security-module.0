Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF424A3E
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815112; cv=none; b=RNvGYRBZ/wvjqNhvA0lPtOuvJOQ2R6DmH2TzdDy93/XJ/0dMd1L7iEg/d0TYq9VCE6Ch4wEoplxFgnvWK8RFviQKLOchjNMYv/8i33DhHAzVXRaOFEiALdGkPDBMYNSxUVeM/2J/CVX3bh2ccOmGZWNA3fbdS2aY6j6JAxJ9veA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815112; c=relaxed/simple;
	bh=j0bmiI2yHAbLs8SGlPp0CCoy0qhjtue3o7iWjGgIuiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdEZAbtieJWGrqIyu6Kvmea41gX7/suSHVcoMVTfBmrsHk/d3fU0UmjXbGVjTGGNYNwPSZN8SpSRFHlWrf32OaEGrsbcwk+8MiTN2N5mw1ADEpjHNBUhms/JeSCyZqfEZjF1HU2KXiJyuKpbSOGqg35FjTb39DsB+PrS3FE2SOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Y4OFq8q+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7aWwLXx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Y4OFq8q+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7aWwLXx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 054B11D00182;
	Sun,  6 Jul 2025 11:18:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Jul 2025 11:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815109; x=
	1751901509; bh=7oBHiwF5gK/z/umMS3Jn1HBa3xemQXPHWH5fb7m87gA=; b=Y
	4OFq8q+D24W/kVtE+RhNUhyp9vylhW3p9m9aFrRxaMTNG+AhqCACOVqGt+pT+ZI8
	IpWskdugf8gTL6I9ORB0CL/i53dhtyLtu2+mmjLR7/Vce5st5KL3UQ4+Ap8U8zFz
	s/AIHlFxhgg6/UVP2PvPMOk0WvZyPqxkRLZCkKbiYt8AwV3Escsd7/37QLWacbsi
	s6Y99vBgWaAcpTnqTLDysFQ06qumD2GoS30GKDeL75sFKIsJ2cR0IMuH8BPT4U3d
	F7Hs+QNPX66/x6/1tqagd9/+8/MBsRp20mwOMuQpsHsJ0V+22sOwmzt43Kyfq5nV
	LeC9HqXPC3ejGrAJr2WhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815109; x=1751901509; bh=7
	oBHiwF5gK/z/umMS3Jn1HBa3xemQXPHWH5fb7m87gA=; b=g7aWwLXxYdWFl4oPw
	NmHeGR7zcvqztP/hlyfRxfgrt9xFF1tTdB1c0hI0s1bgJt0MhkbUI+6cR8qfEVrH
	6LQDNn2sVBIaU7ZPqvjT0zy6nEm5A7GnrTkJ7KyE+20/t4CP4nt5TgfwObyWbLpH
	XoMvdFif9GseyzL5/++1UMf8jM2+KCdZUuKG2oO4hc5PQ1F/wKXkTNAdrVVGN8jb
	q3a3GY1xUPUT0c/UBVcozRA83zZH9W/tz9fqEM4meD95Olb4CVGbPngiW+xIS3P1
	u/2ejvEOJjBzq9sFGrfT28KX3TDH1MeXNRKzGqjtRijAWlKflfAERv5DpQMeRDEB
	g2eXg==
X-ME-Sender: <xms:xZNqaLe9xQc_W5TlLEiXycaQzE2clxVWUVXmUPaig63E40zKSWTIUQ>
    <xme:xZNqaBNNTtZ9OmGtVhC9wnxtz7J-RZgudFxHRbo34TFOpk04AR7FsMAr2VzIgXh4W
    6NAMH2oVku7I5yt3FU>
X-ME-Received: <xmr:xZNqaEg7ehccRf_gKCsd-l5e6EHQ_w069V8qQ2GBA_lRMm61rZYEg2yTaXqK18Jd7AIIQku7h_v6NOa-KB_EX3bTMZdz01rpj-mmOaoZNqQnIDjQnA-S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:xZNqaM9ZkSvxiwT9fjjGDWq1zifjFiaa-bnGdZ2Q7jQBWZAvc31IVw>
    <xmx:xZNqaHv7qqyavKscclS3kG1Fm5dL5aESC-s6A6PezFNh1yb3exf7-w>
    <xmx:xZNqaLExCCNsVDCOctiKzxxK2a0XVQMqB9TB_urldX8CXPB0xWjLmQ>
    <xmx:xZNqaOO_6wazGs8EAL6uvTap3srLLTbB4jowb-KKIrCdSpFaXkUq5w>
    <xmx:xZNqaG2nzACcCLQJUkM4Bu-KjRCTE-LmJSVihI3oSNoM-n6bZjTuCx6R>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:28 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 07/12] landlock/domain: Define alloc and free
Date: Sun,  6 Jul 2025 16:16:48 +0100
Message-ID: <71c79f53c9bac67b69696f402bb8c073309c2fc0.1751814658.git.m@maowtm.org>
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

We will eventually need a deferred free just like we currently have for
the ruleset, so we define it here as well.  To minimize the size of the
domain struct before the rules array, we separately allocate the
work_struct (which is currently 72 bytes) and just keep a pointer in the
domain.

This patch triggers another (false positive?) checkpatch warning:

	ERROR: trailing statements should be on next line
	#177: FILE: security/landlock/domain.h:197:
	 DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
	+	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c | 96 ++++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h | 38 +++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 89d36736a59c..a7474b803c47 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -33,6 +33,102 @@ static void build_check_domain(void)
 		     U32_MAX - 1);
 }
 
+/**
+ * landlock_alloc_domain - allocate a new domain given known sizes.  The
+ * caller must then at least fill in the indices and layers arrays before
+ * trying to free this domain.
+ *
+ * @sizes: A "fake" struct landlock_domain which just contains various
+ * num_* numbers.  This function will call dom_rules_len() to compute the
+ * total rules array length, and copy over the number fields.
+ * sizes.usage, sizes.hierarchy and sizes.work_free are ignored.
+ */
+struct landlock_domain *
+landlock_alloc_domain(const struct landlock_domain *sizes)
+{
+	u32 len_rules = dom_rules_len(sizes);
+	struct landlock_domain *new_dom = kzalloc(
+		struct_size(new_dom, rules, len_rules), GFP_KERNEL_ACCOUNT);
+
+	if (!new_dom)
+		return NULL;
+
+	memcpy(new_dom, sizes, sizeof(*sizes));
+	new_dom->hierarchy = NULL;
+	new_dom->work_free =
+		kzalloc(sizeof(*new_dom->work_free), GFP_KERNEL_ACCOUNT);
+	if (!new_dom->work_free) {
+		kfree(new_dom);
+		return NULL;
+	}
+	new_dom->work_free->domain = new_dom;
+	refcount_set(&new_dom->usage, 1);
+	new_dom->len_rules = len_rules;
+
+	return new_dom;
+}
+
+static void free_domain(struct landlock_domain *const domain)
+{
+	struct landlock_domain_index *fs_indices, ind;
+	u32 i, num_fs_indices;
+
+	might_sleep();
+	if (WARN_ON_ONCE(!domain))
+		return;
+	fs_indices = dom_fs_indices(domain);
+	num_fs_indices = domain->num_fs_indices;
+	if (WARN_ON_ONCE((uintptr_t *)(fs_indices + num_fs_indices) -
+				 domain->rules >
+			 domain->len_rules))
+		return;
+
+	for (i = 0; i < num_fs_indices; i++) {
+		ind = fs_indices[i];
+		landlock_put_object(ind.key.object);
+	}
+
+	landlock_put_hierarchy(domain->hierarchy);
+	domain->hierarchy = NULL;
+	kfree(domain->work_free);
+	domain->work_free = NULL;
+	kfree(domain);
+}
+
+void landlock_put_domain(struct landlock_domain *const domain)
+{
+	might_sleep();
+
+	if (domain && refcount_dec_and_test(&domain->usage))
+		free_domain(domain);
+}
+
+static void free_domain_work(struct work_struct *const work)
+{
+	struct landlock_domain_work_free *const fw =
+		container_of(work, struct landlock_domain_work_free, work);
+	struct landlock_domain *domain = fw->domain;
+
+	free_domain(domain);
+	/* the work_free struct will be freed by free_domain */
+}
+
+/*
+ * Schedule work to free a landlock_domain, useful in a non-sleepable
+ * context.
+ */
+void landlock_put_domain_deferred(struct landlock_domain *const domain)
+{
+	if (domain && refcount_dec_and_test(&domain->usage)) {
+		INIT_WORK(&domain->work_free->work, free_domain_work);
+
+		if (WARN_ON_ONCE(domain->work_free->domain != domain))
+			return;
+
+		schedule_work(&domain->work_free->work);
+	}
+}
+
 /**
  * dom_calculate_merged_sizes - Calculate the eventual size of the part of
  * a new domain for a given rule size (i.e. either fs or net).  Correct
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 8acd88a1d77a..7af32810003c 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -44,7 +44,30 @@ struct landlock_domain_index {
 	u32 layer_index;
 };
 
+struct landlock_domain_work_free {
+	struct work_struct work;
+	struct landlock_domain *domain;
+};
+
 struct landlock_domain {
+	/**
+	 * @hierarchy: Enables hierarchy identification even when a parent
+	 * domain vanishes.  This is needed for the ptrace protection.
+	 */
+	struct landlock_hierarchy *hierarchy;
+	/**
+	 * @work_free: Enables to free a domain within a lockless section.
+	 * This is only used by landlock_put_domain_deferred() when @usage
+	 * reaches zero. This is a pointer to an allocated struct in order to
+	 * minimize the size of this struct. To prevent needing to allocate
+	 * when freeing, this is pre-allocated on domain creation.
+	 */
+	struct landlock_domain_work_free *work_free;
+	/**
+	 * @usage: Number of processes (i.e. domains) or file descriptors
+	 * referencing this ruleset.
+	 */
+	refcount_t usage;
 	/**
 	 * @num_layers: Number of layers in this domain.  This enables to
 	 * check that all the layers allow an access request.
@@ -158,6 +181,21 @@ DEFINE_COALESCED_HASH_TABLE(struct landlock_domain_index, dom_hash, key,
 			    hash_long(elem->key.data, 32) % table_size,
 			    dom_index_is_empty(elem))
 
+struct landlock_domain *
+landlock_alloc_domain(const struct landlock_domain *sizes);
+
+static inline void landlock_get_domain(struct landlock_domain *const domain)
+{
+	if (domain)
+		refcount_inc(&domain->usage);
+}
+
+void landlock_put_domain(struct landlock_domain *const domain);
+void landlock_put_domain_deferred(struct landlock_domain *const domain);
+
+DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
+	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))
+
 struct landlock_found_rule {
 	const struct landlock_layer *layers_start;
 	const struct landlock_layer *layers_end;
-- 
2.49.0

