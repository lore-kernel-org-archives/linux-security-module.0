Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33887367B69
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019558; cv=none; b=ae67O1HBNcSA7FUO3o2f0PYqb4ZHAE7ZtlGauh4kE9L3e/fTOChqy9d7piCBEt+E+pPQ3AYZQC7iOurlOFN/ZC/ZsXp3DQMLBB/2VmKLmlkIwCN+6/UQvLThoPnKZpSV/rVKqh9PUkaP4aHz5RSyy7F3SUrxd8AT/yeFX7yU2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019558; c=relaxed/simple;
	bh=QugJtaPW1wkcSw1F+D0TQcpCXe9Neeo65mo6cxF+OQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyrKayJt9aep+QyGS0DgpY94zZPwKrbU0mXzq4qNnv13T9oWTtd4HH8S9Hs89Y4FF63WyrAVXq5nAI1PA+fBMEE65x66CBaVIB+oMuXi/CTQmCrtlh2A6p0v1PfgiC1QghpbJ1VkhD7z78qQoMTVzVKXVwjGZdGTvwMFTO1kK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1xILmeM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1xILmeM"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dbcb505578so21160687b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019555; x=1780624355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7CHCXr72km3LTx0xZQD8IgCm2NpcAMYh22DNkOLa9w=;
        b=Z1xILmeMVqFA+6YTX98ghCisQ02jYgDF4V16/vnE5OG308xp6J9L9a11B/KWJd2Vc6
         zZjll6bCnwBs2fRQY2dLQI9YNuw67tANSLuY/r3z8cat2dFQXATUsV4832gEQYzyW3t7
         cxsXkjoMKv/CWI2jXQbtXoddCy+LJGov0Ej5FWgFJhbNz+2FISay89qGAtjkEGBkiF1q
         4AW6SeIq5tBJJBTUjIW7X1lkIpTnCv26G8LYfNnbKngMckowPY1uP27VM1sBF0Y5+YJN
         rRC4hzKzk5g2liXy4AV+/DBAKLA2Y2PTZtwtJz8Rvfm4wR4dIBfFR96lND3cxh67h3H/
         oz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019555; x=1780624355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7CHCXr72km3LTx0xZQD8IgCm2NpcAMYh22DNkOLa9w=;
        b=tQaaeSb8GwcT0rqNaG8MjuBJmz6bVkeSRaccA2Yrn2fIXkmJyNv3F/WEcYNEs7SfHs
         i9pfCWwheS01DPR14eAYcaL/vvm5GXg+iIfoKnrtI3W+FH8izqOE+w9XAa7/VVHTEUXo
         yUT02laaLx2E+KimbQbXve9qp7oR5MtQ6oHLgQ2HxwUew8rBevwXWTrYdwCqwBbYJdRd
         uPy2gG5iuplg9QqufyVF3rUbiVMWabL5gETed0mgVVJNEWRHyBVT/lvu7hbVk3nc4dXh
         8ENBVbwejnOApOJaPjQPqWbj6Oa4p8LAA57+3lBvxNG/gZdDExJNSlSbs63mWhvX66gM
         fyvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oXsZQRYJDpLnFXDrHT19aS+wp/ln3Fj68gXz/x12qKCaLNQAdfUfpjPZZ1H7cJrFcPICt2K50kQSsetRUv2Cc5eyv+XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVj2t5fEUijI5hUonI1Oho4gJm9b8BHyFwogsGWzoISyeAyF9
	mBRZ9OyO6QnpukHdF/jFusB0WNq6DqsLc80XhqU11OrBwN/eaIjDodPl
X-Gm-Gg: Acq92OHrwAp1TQf3LSB7/vujVPo8boMI44zqS+dkEVmeF9gVT5tQxmb44y36I84APSM
	8PTVHJtGob3CZfe0gFO8SI7xdE+gwNXEcU9EtgyxcTctPOpxoGHuoxzdKypu1uuqpt5Iv5OcLi0
	VIpMUBSCR3JpvckWNgpWwshzz9hSFXXIbf69XrelEBVnMtWJ7Iiu0mph7yqQito+W1KXcyN9enu
	MBHGsd5YppGiwwpTsbWwW3sKISmPcBFV9KRZuLGRxsfEBenQ+WoxgxDhx4ORSriNOf816zh1uA2
	6oPbxLytmMZNbPlOb6ykqO7fH9jJSuuY3ffbEMS/chSHH517yKgIbTARsTDUBqgRF7kISVpCIAo
	ZaAGZdXm72F9+gLq/89/rveVUkFWOLWXj2bbBxz1jhy+M5BTBio+bnl778WR3AZ5sg7od4Sv1Pu
	eP6gKTGqqasD6aoDnSlrXq7eHDavcHvh4Q+I/s6VoF9lYOxx/IXXDBSgu/u+eegIlcLSRGqXkpw
	ofD8W8LyfE=
X-Received: by 2002:a05:690c:22c6:b0:7db:9594:5edc with SMTP id 00721157ae682-7de47e26d33mr7766637b3.44.1780019555111;
        Thu, 28 May 2026 18:52:35 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:34 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 06/10] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 28 May 2026 21:52:05 -0400
Message-ID: <20260529015210.500291-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make %LANDLOCK_ADD_RULE_NO_INHERIT actually enforce its semantics:

- Tag the new rule's layer with @no_inherit and
  @has_no_inherit_descendant so landlock_unmask_layers() stops walking
  up the hierarchy once it has been seen, and so the rule's own object
  is sealed against topology changes.
- Walk from the rule's path up to the VFS root in
  landlock_append_fs_rule(), inserting a zero-access rule on each
  ancestor with @has_no_inherit_descendant set, so topology changes
  (rename, rmdir, link, ...) on any ancestor are denied too.
- Add deny_no_inherit_topology_change(), called from
  current_check_refer_path(), hook_path_unlink() and hook_path_rmdir()
  to enforce the seal at the LSM hook layer.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Reworded commit message to describe the three pieces of the
        implementation (per-layer tagging, ancestor walk, LSM hook
        enforcement).
      * Reworked ancestor sealing in landlock_append_fs_rule(): use the
        new landlock_insert_rule() return value to tag flags directly on
        the inserted ancestor rule, removing the prior find_rule() round
        trip after insertion.
      * Moved no_inherit / has_no_inherit_descendant tracking from a
        separate collected_rule_flags struct into the existing
        layer_mask struct as a single per-layer 'no_inherit' bit.
        landlock_unmask_layers() now skips layers whose mask already has
        no_inherit set, and landlock_init_layer_masks() clears the new
        bit. The 'has_no_inherit_descendant' rule-layer flag is
        auto-set on the rule's own object when LANDLOCK_ADD_RULE_NO_INHERIT
        is passed, sealing it against topology changes without a separate
        blank-rule insertion.
      * Simplified deny_no_inherit_topology_change(): dropped the
        override_layers accumulator (it was always 0 in practice) and
        now just OR-collects sealed layers from no_inherit /
        has_no_inherit_descendant.
      * Updated kerneldoc comments on the new layer flags.

 security/landlock/access.h  |   4 ++
 security/landlock/fs.c      | 116 +++++++++++++++++++++++++++++++++++-
 security/landlock/ruleset.c |  30 +++++++++-
 security/landlock/ruleset.h |  13 ++++
 4 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 61a17b568652..ab5c1e0bc25d 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -71,12 +71,16 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
  *
  * @quiet is used to store whether we have encountered a rule with the
  * quiet flag for this layer, which will be used to control audit logging.
+ *
+ * @no_inherit is used to mark this layer as having a no_inherit rule, so
+ * that ancestor rules in the same layer do not contribute access rights.
  */
 struct layer_mask {
 	access_mask_t access:LANDLOCK_NUM_ACCESS_MAX;
 #ifdef CONFIG_AUDIT
 	bool quiet:1;
 #endif /* CONFIG_AUDIT */
+	bool no_inherit:1;
 };
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ee7d9f5d7ee5..3aa7d898efe1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -364,6 +364,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_INODE,
 	};
+	struct path walker = *path;
 
 	/* Files only get access rights that make sense. */
 	if (!d_is_dir(path->dentry) &&
@@ -378,10 +379,47 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	id.key.object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
+
 	mutex_lock(&ruleset->lock);
 	rule = landlock_insert_rule(ruleset, id, access_rights, flags);
-	if (IS_ERR(rule))
+	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
+		goto out_unlock;
+	}
+	if (!(flags & LANDLOCK_ADD_RULE_NO_INHERIT))
+		goto out_unlock;
+
+	/*
+	 * Seal each ancestor up to the VFS root with a no-access rule
+	 * tagged @has_no_inherit_descendant so that topology-changing
+	 * operations (rename, rmdir, link, ...) on them are denied.
+	 */
+	path_get(&walker);
+	while (landlock_walk_path_up(&walker) != LANDLOCK_WALK_STOP_REAL_ROOT) {
+		struct landlock_rule *ancestor_rule;
+		struct inode *const ancestor_inode =
+			d_backing_inode(walker.dentry);
+		struct landlock_id ancestor_id = {
+			.type = LANDLOCK_KEY_INODE,
+			.key.object = get_inode_object(ancestor_inode),
+		};
+
+		if (IS_ERR(ancestor_id.key.object)) {
+			err = PTR_ERR(ancestor_id.key.object);
+			break;
+		}
+		ancestor_rule = landlock_insert_rule(ruleset, ancestor_id, 0,
+						     0);
+		landlock_put_object(ancestor_id.key.object);
+		if (IS_ERR(ancestor_rule)) {
+			err = PTR_ERR(ancestor_rule);
+			break;
+		}
+		ancestor_rule->layers[0].flags.has_no_inherit_descendant = true;
+	}
+	path_put(&walker);
+
+out_unlock:
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
@@ -1106,6 +1144,54 @@ collect_domain_accesses(const struct landlock_ruleset *const domain,
 	return ret;
 }
 
+/**
+ * deny_no_inherit_topology_change - Deny topology changes on sealed paths
+ * @subject: Subject performing the operation.
+ * @dentry: Target of the topology modification.
+ *
+ * Returns -EACCES (and emits an audit record) if any of the subject's
+ * domain layers seal @dentry against topology changes: either @dentry
+ * itself has a %LANDLOCK_ADD_RULE_NO_INHERIT rule, or one of its
+ * descendants does (recorded via @has_no_inherit_descendant on the
+ * dentry's rule).
+ *
+ * Returns 0 otherwise.
+ */
+static int
+deny_no_inherit_topology_change(const struct landlock_cred_security *subject,
+				struct dentry *const dentry)
+{
+	unsigned long sealed_layers = 0;
+	const struct landlock_rule *rule;
+
+	if (WARN_ON_ONCE(!subject || !dentry || d_is_negative(dentry)))
+		return 0;
+
+	rule = find_rule(subject->domain, dentry);
+	if (!rule)
+		return 0;
+
+	for (size_t i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+
+		if (layer->flags.no_inherit ||
+		    layer->flags.has_no_inherit_descendant)
+			sealed_layers |= BIT(layer->level - 1);
+	}
+	if (!sealed_layers)
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dentry,
+		},
+		.layer_plus_one = __ffs(sealed_layers) + 1,
+	});
+	return -EACCES;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1188,6 +1274,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
+		int err = deny_no_inherit_topology_change(subject, old_dentry);
+
+		if (err)
+			return err;
+		if (exchange) {
+			err = deny_no_inherit_topology_change(subject,
+							      new_dentry);
+			if (err)
+				return err;
+		}
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
 	}
@@ -1579,12 +1675,30 @@ static int hook_path_symlink(const struct path *const dir,
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+
+	if (subject) {
+		int err = deny_no_inherit_topology_change(subject, dentry);
+
+		if (err)
+			return err;
+	}
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
 }
 
 static int hook_path_rmdir(const struct path *const dir,
 			   struct dentry *const dentry)
 {
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+
+	if (subject) {
+		int err = deny_no_inherit_topology_change(subject, dentry);
+
+		if (err)
+			return err;
+	}
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 48397ab43a2d..c78e2b2d73ff 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -258,6 +258,10 @@ insert_rule(struct landlock_ruleset *const ruleset,
 				return ERR_PTR(-EINVAL);
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
+			this->layers[0].flags.no_inherit |=
+				(*layers)[0].flags.no_inherit;
+			this->layers[0].flags.has_no_inherit_descendant |=
+				(*layers)[0].flags.has_no_inherit_descendant;
 			return this;
 		}
 
@@ -311,12 +315,20 @@ landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		     const struct landlock_id id,
 		     const access_mask_t access, const int flags)
 {
+	const bool no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT);
 	struct landlock_layer layers[] = { {
 		.access = access,
 		/* When @level is zero, insert_rule() extends @ruleset. */
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
+			.no_inherit = no_inherit,
+			/*
+			 * The rule's own object is also sealed against
+			 * topology changes, so mark it as if it had a
+			 * no-inherit descendant.
+			 */
+			.has_no_inherit_descendant = no_inherit,
 		},
 	} };
 
@@ -657,15 +669,25 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 	 */
 	for (size_t i = 0; i < rule->num_layers; i++) {
 		const struct landlock_layer *const layer = &rule->layers[i];
+		struct layer_mask *const layer_mask =
+			&masks->layers[layer->level - 1];
+
+		/*
+		 * Skip layers that already have no_inherit set: these layers
+		 * should not inherit access rights from ancestor directories.
+		 */
+		if (layer_mask->no_inherit)
+			continue;
 
 		/* Clear the bits where the layer in the rule grants access. */
-		masks->layers[layer->level - 1].access &= ~layer->access;
+		layer_mask->access &= ~layer->access;
 
 #ifdef CONFIG_AUDIT
-		/* Collect rule flags for each layer. */
 		if (layer->flags.quiet)
-			masks->layers[layer->level - 1].quiet = true;
+			layer_mask->quiet = true;
 #endif /* CONFIG_AUDIT */
+		if (layer->flags.no_inherit)
+			layer_mask->no_inherit = true;
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
@@ -731,6 +753,7 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 #ifdef CONFIG_AUDIT
 		masks->layers[i].quiet = false;
 #endif /* CONFIG_AUDIT */
+		masks->layers[i].no_inherit = false;
 	}
 	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
 	     i++) {
@@ -738,6 +761,7 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 #ifdef CONFIG_AUDIT
 		masks->layers[i].quiet = false;
 #endif /* CONFIG_AUDIT */
+		masks->layers[i].no_inherit = false;
 	}
 
 	return handled_accesses;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 5b7f554e8442..249a736248db 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -40,6 +40,19 @@ struct landlock_layer {
 		 * down the file hierarchy.
 		 */
 		bool quiet:1;
+		/**
+		 * @no_inherit: Prevents this rule from inheriting access rights
+		 * from ancestor inodes.  Only used for filesystem rules; set
+		 * via %LANDLOCK_ADD_RULE_NO_INHERIT.
+		 */
+		bool no_inherit:1;
+		/**
+		 * @has_no_inherit_descendant: Marker used to deny topology
+		 * changes on the rule's object: either the object itself has
+		 * a no-inherit rule, or a descendant does.  Only used for
+		 * filesystem rules; set by Landlock, never by user space.
+		 */
+		bool has_no_inherit_descendant:1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
-- 
2.53.0

