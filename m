Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0726B76A
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815117; cv=none; b=Ir4QVLHBVrk5hNO0VdLppVZWJ4ZD73/Tt2SxU3IGpKEnWBPqVk/Q8Ja3rLuxxRCI/fZD2MXyWkw64qmp1j6qhNS3oouq/j/uG1qLLnmvxVlugZnkRvA7BQKCd5oBRdq/f+lEgiiUFQLRtMzFmpisaZVGZFPSRd6yy+Fy51CMDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815117; c=relaxed/simple;
	bh=8CrPq2CR41tp2uab5754mfy4yML5BHeXqZb4zjOxZaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDfsIMV9/Rt9D8V9WDwAW3NPV1AB8izehd5MLY21HEw4eTWbz/31Laj2bOXaXc4fSEtEG0ePxuwTfIEkvFvaieV/JCV5bCvn7w8kU8NgovSXlKjRUEyWvUldlHf2E43Sei+SYRNID2mSD/LziGUlM1ZIZFw1PWdTigY3Rw8jsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AQhdJMu8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T8oMKCxp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AQhdJMu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8oMKCxp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id ADCEB1D00147;
	Sun,  6 Jul 2025 11:18:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 06 Jul 2025 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815114; x=
	1751901514; bh=BsSy6cc+qe60SXVaNeI1sRUM3pf0si9TPLtTg6s3lbU=; b=A
	QhdJMu8Ok8oJ9FlQj57SVNP1XYKDpoeFThCEvOt/pHHDscvYAtYy7z3aVn39NTvX
	t5L/HUWoiWbvkFVUuV1DCMyLOc32rxC9IrF2jqYbwqlQuOO5jNCyBWSjnQtk3AQY
	idrXBw8EXPJz642D2iButiguLKu9Cd4W4Jtx7XCvzbfAeMke6Ja4PcO4vZ+YwZg/
	A+H8R7Qfu4JpDxWsx3zwf6ppVgM7uq8QPdSAldUMPLkq1vz0iDhi7vI15k1sUxvu
	wsxDw47kEBQ69B55JjPqYy4xHZXY2EHeaAc8vp2vgtA3M7LqrhhJBMbb1fkBOqGB
	IQSnfOre/biTwzUfajp1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815114; x=1751901514; bh=B
	sSy6cc+qe60SXVaNeI1sRUM3pf0si9TPLtTg6s3lbU=; b=T8oMKCxpzl4wAaO3v
	+20BEWRlYRHQhxwgQPvyam40XmOO9sdIWwF2DDI32HWFkFTPpMOH7hOubtrFne21
	ALVLz5a1epbj/oLWn3Prd9QfpOr63fkU5cBH1M6Q98y4AFdzb809Q/RHUUqUxSG9
	DfSGdrbUNfsto3vnhsfecUtx8rxe0YMWOsP1OgrXbYUF0BD0W0fh49LKcGh0rHLQ
	3ozOXVjuD+THp/xCrbR5PaA9iZseOO0RQaV9+6VuCuEOxFawVZweZQYi3Xs8NBZr
	JwTlk9dpW+LJ0eIg2w5g5VNibykkDX6IeGDL6h9QKDqTnU4Cz21j0XIPW/eZ/4hT
	J9O2g==
X-ME-Sender: <xms:ypNqaEi9QpZFifJ8j0eDhmk2i0Ryn1w22xJwF0i_Frw7bDCvdVrNJw>
    <xme:ypNqaNBjzybPA1OHApB9R-vRhwpqN6gMWxFUNqoxfi54Wr0_1t6NR6Zp6ERtkC0Pw
    BfYGEepCCoN5NuVzeU>
X-ME-Received: <xmr:ypNqaMG3GjWuivWbWbS8R83bR55K2lW-63JMFUd5VuJKMUjviQ2AwtcwZqN_bpokdOUVgbo5yAXRcw_J1ZnPOgmogQoI3-7KYzoVmjZrFROJgd0I5GqH>
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
X-ME-Proxy: <xmx:ypNqaFQPR6Y-79TsURRSTYfNjM49dqx9gF9ORDDJSZ1fC6Mk1VIxrg>
    <xmx:ypNqaBzDutn6lEVJwEjrvIqN8o5ukHnt8ubrbdlhuoq-5aAHohwwFw>
    <xmx:ypNqaD7XhibcYj1_Ak0yqW2FGeuFa8lJHnsGhxqXfOKu_PdC4U8qXg>
    <xmx:ypNqaOzqkDCf-oLWz5dDKFNmUnN8D6n6ZRCtuM3FjtKdZXoU0DQGgg>
    <xmx:ypNqaB5BADl7WlFGZ4tO-cBPnPU23bhiMb8TUcxEZYQoO4o2V8YD-1_X>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:33 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 08/12] landlock/domain: Add landlock_domain_merge_ruleset
Date: Sun,  6 Jul 2025 16:16:49 +0100
Message-ID: <ee66ed9ad0d78fed6e801cfb3c57a80209ec6a08.1751814658.git.m@maowtm.org>
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

Implement the equivalent of landlock_merge_ruleset, but using the new
domain structure.  The logic in inherit_domain and
landlock_domain_merge_ruleset c.f. inherit_ruleset and merge_ruleset.
Once we replace the existing landlock_restrict_self code to use this those
two functions can then be removed.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c | 243 ++++++++++++++++++++++++++++++++++++-
 security/landlock/domain.h |   4 +
 2 files changed, 245 insertions(+), 2 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a7474b803c47..da8f1bf00db1 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -147,7 +147,7 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
  * @out_num_layers: Outputs the number of layer objects that would be
  * needed in the new domain.
  */
-static int __maybe_unused dom_calculate_merged_sizes(
+static int dom_calculate_merged_sizes(
 	const struct landlock_domain_index *const dom_ind_array,
 	const u32 dom_num_indices, const u32 dom_num_layers,
 	const struct rb_root *const child_rules, u32 *const out_num_indices,
@@ -202,7 +202,7 @@ static int __maybe_unused dom_calculate_merged_sizes(
  * @out_indices: The output indices array to be populated.
  * @out_size: The size of @out_indices, in number of elements.
  */
-static int __maybe_unused dom_populate_indices(
+static int dom_populate_indices(
 	const struct landlock_domain_index *const dom_ind_array,
 	const u32 dom_num_indices, const struct rb_root *const child_rules,
 	struct landlock_domain_index *const out_indices, const u32 out_size)
@@ -344,6 +344,245 @@ dom_populate_layers(const struct landlock_domain_index *const dom_ind_array,
 	return 0;
 }
 
+/**
+ * merge_domain - Do merge for both fs and net.
+ *
+ * @parent: Parent domain, or NULL if there is no parent.
+ * @child: Child domain.  child->num_layers must be set to the new level.
+ * @ruleset: Ruleset to be merged.  Must hold the ruleset lock across
+ * calls to this function.
+ * @only_calc_sizes: Whether this is a size-calculation pass, or the final
+ * merge pass.  For the size-calculation pass, no data except various sizes
+ * in @child will be written.
+ *
+ * If @only_calc_sizes is true, child->num_{fs,net}_{indices,layers} will
+ * be updated.  Otherwise, the function writes to child->rules and checks
+ * that the number of indices and layers written matches with previously
+ * stored numbers in @child.
+ */
+static int merge_domain(const struct landlock_domain *parent,
+			struct landlock_domain *child,
+			struct landlock_ruleset *ruleset, bool only_calc_sizes)
+	__must_hold(&ruleset->lock)
+{
+	u32 new_level;
+	int err;
+
+	if (WARN_ON_ONCE(!ruleset || !child))
+		return -EINVAL;
+
+	new_level = child->num_layers;
+	/* We should have checked new_level <= LANDLOCK_MAX_NUM_LAYERS already */
+	if (WARN_ON_ONCE(new_level == 0 || new_level > LANDLOCK_MAX_NUM_LAYERS))
+		return -EINVAL;
+
+	if (only_calc_sizes) {
+		err = dom_calculate_merged_sizes(
+			parent ? dom_fs_indices(parent) : NULL,
+			parent ? parent->num_fs_indices : 0,
+			parent ? parent->num_fs_layers : 0,
+			&ruleset->root_inode, &child->num_fs_indices,
+			&child->num_fs_layers);
+		if (err)
+			return err;
+
+#ifdef CONFIG_INET
+		err = dom_calculate_merged_sizes(
+			parent ? dom_net_indices(parent) : NULL,
+			parent ? parent->num_net_indices : 0,
+			parent ? parent->num_net_layers : 0,
+			&ruleset->root_net_port, &child->num_net_indices,
+			&child->num_net_layers);
+		if (err)
+			return err;
+#else
+		child->num_net_indices = 0;
+		child->num_net_layers = 0;
+#endif /* CONFIG_INET */
+	} else {
+		err = dom_populate_indices(
+			parent ? dom_fs_indices(parent) : NULL,
+			parent ? parent->num_fs_indices : 0,
+			&ruleset->root_inode, dom_fs_indices(child),
+			child->num_fs_indices);
+		if (err)
+			return err;
+
+		err = dom_populate_layers(
+			parent ? dom_fs_indices(parent) : NULL,
+			parent ? parent->num_fs_indices : 0,
+			parent ? dom_fs_layers(parent) : NULL,
+			parent ? parent->num_fs_layers : 0,
+			&ruleset->root_inode, dom_fs_indices(child),
+			child->num_fs_indices, new_level, dom_fs_layers(child),
+			child->num_fs_layers);
+		if (err)
+			return err;
+
+		dom_fs_terminating_index(child)->layer_index =
+			child->num_fs_layers;
+
+#ifdef CONFIG_INET
+		err = dom_populate_indices(
+			parent ? dom_net_indices(parent) : NULL,
+			parent ? parent->num_net_indices : 0,
+			&ruleset->root_net_port, dom_net_indices(child),
+			child->num_net_indices);
+		if (err)
+			return err;
+
+		err = dom_populate_layers(
+			parent ? dom_net_indices(parent) : NULL,
+			parent ? parent->num_net_indices : 0,
+			parent ? dom_net_layers(parent) : NULL,
+			parent ? parent->num_net_layers : 0,
+			&ruleset->root_net_port, dom_net_indices(child),
+			child->num_net_indices, new_level,
+			dom_net_layers(child), child->num_net_layers);
+		if (err)
+			return err;
+
+		dom_net_terminating_index(child)->layer_index =
+			child->num_net_layers;
+#endif /* CONFIG_INET */
+	}
+
+	return 0;
+}
+
+/**
+ * Populate handled access masks and hierarchy for the child.
+ *
+ * @parent: Parent domain, or NULL if there is no parent.
+ * @child: Child domain to be populated.
+ * @ruleset: Ruleset to be merged.  Must hold the ruleset lock.
+ */
+static int inherit_domain(const struct landlock_domain *parent,
+			  struct landlock_domain *child,
+			  struct landlock_ruleset *ruleset)
+	__must_hold(&ruleset->lock)
+{
+	if (WARN_ON_ONCE(!child || !ruleset || !child->hierarchy ||
+			 child->num_layers < 1 || ruleset->num_layers != 1)) {
+		return -EINVAL;
+	}
+
+	if (parent) {
+		if (WARN_ON_ONCE(child->num_layers != parent->num_layers + 1))
+			return -EINVAL;
+
+		/* Copies the parent layer stack. */
+		memcpy(dom_access_masks(child), dom_access_masks(parent),
+		       array_size(parent->num_layers,
+				  sizeof(*dom_access_masks(child))));
+
+		if (WARN_ON_ONCE(!parent->hierarchy))
+			return -EINVAL;
+
+		landlock_get_hierarchy(parent->hierarchy);
+		child->hierarchy->parent = parent->hierarchy;
+	}
+
+	/* Stacks the new layer. */
+	dom_access_masks(child)[child->num_layers - 1] =
+		landlock_upgrade_handled_access_masks(ruleset->access_masks[0]);
+
+	return 0;
+}
+
+/**
+ * landlock_domain_merge_ruleset - Merge a ruleset and a parent domain
+ * into a new domain.
+ *
+ * @parent: Parent domain.
+ * @ruleset: Ruleset to be merged.  This function will take the mutex on
+ * this ruleset while merging.
+ *
+ * The current task is requesting to be restricted.  The subjective credentials
+ * must not be in an overridden state. cf. landlock_init_hierarchy_log().
+ *
+ * Returns the intersection of @parent and @ruleset, or returns @parent if
+ * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
+ */
+struct landlock_domain *
+landlock_domain_merge_ruleset(const struct landlock_domain *parent,
+			      struct landlock_ruleset *ruleset)
+{
+	struct landlock_domain *new_dom __free(landlock_put_domain) = NULL;
+	struct landlock_hierarchy *new_hierarchy __free(kfree) = NULL;
+	struct landlock_domain new_dom_sizes = {};
+	u32 new_level;
+	int err;
+
+	might_sleep();
+	if (WARN_ON_ONCE(!ruleset))
+		return ERR_PTR(-EINVAL);
+
+	if (parent) {
+		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
+			return ERR_PTR(-E2BIG);
+		new_level = parent->num_layers + 1;
+	} else {
+		new_level = 1;
+	}
+
+	new_dom_sizes.num_layers = new_level;
+
+	/* Allocate this now so we fail early */
+	new_hierarchy = kzalloc(sizeof(*new_hierarchy), GFP_KERNEL_ACCOUNT);
+	if (!new_hierarchy)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Figure out how many indices and layer structs.  From this point
+	 * until we actually merge in the ruleset, ruleset must not change.
+	 */
+	mutex_lock(&ruleset->lock);
+	err = merge_domain(parent, &new_dom_sizes, ruleset, true);
+	if (err)
+		goto out_unlock;
+
+	/*
+	 * Ok, we know the required size now, allocate the domain and merge in
+	 * the indices and rules.
+	 */
+	new_dom = landlock_alloc_domain(&new_dom_sizes);
+	if (!new_dom) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+	new_dom->hierarchy = new_hierarchy;
+	new_hierarchy = NULL;
+	refcount_set(&new_dom->hierarchy->usage, 1);
+
+	err = merge_domain(parent, new_dom, ruleset, false);
+	if (err) {
+		/* new_dom can contain invalid landlock_object references. */
+		kfree(new_dom);
+		new_dom = NULL;
+		goto out_unlock;
+	}
+
+	for (size_t i = 0; i < new_dom->num_fs_indices; i++)
+		landlock_get_object(dom_fs_indices(new_dom)[i].key.object);
+
+	err = inherit_domain(parent, new_dom, ruleset);
+	if (err)
+		goto out_unlock;
+
+	mutex_unlock(&ruleset->lock);
+
+	err = landlock_init_hierarchy_log(new_dom->hierarchy);
+	if (err)
+		return ERR_PTR(err);
+
+	return no_free_ptr(new_dom);
+
+out_unlock:
+	mutex_unlock(&ruleset->lock);
+	return ERR_PTR(err);
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7af32810003c..1d9608439781 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -251,6 +251,10 @@ landlock_domain_find(const struct landlock_domain_index *const indices_arr,
 	for (layer = (found_rule).layers_start;    \
 	     layer < (found_rule).layers_end; layer++)
 
+struct landlock_domain *
+landlock_domain_merge_ruleset(const struct landlock_domain *parent,
+			      struct landlock_ruleset *ruleset);
+
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
-- 
2.49.0

