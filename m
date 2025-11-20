Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703A34C811
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677445; cv=none; b=kWrDKtJSgRi+YTesHSbP3bRHpak+VwuiAHzY8oHqq+0v3gc/ExTg4vItc+BsRhOEcts8foc+yd4vvvae3CPpde5xpmg5U/h1vxqUIfycx/qbGZPN0mkTZWNbolfgcS2aE3xwRRrKYJGJRDo+kfIHMcdK5NbNZ3qKOiTzG1I+qUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677445; c=relaxed/simple;
	bh=cPqoQmUX8klFkEizqib6HMlqJLi7+pBZy+iOhSTFOaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxwYTaz5YNPXzjDUHiE9iq46jmIvzgtifGSwerv2+uX3km/+n1zinbPKRRjqwa73VrURLSf9v+SxTPDB0r/qrv4saI7zSLZsqca76fS3aFVPMaX89ubncBBNcJfmrWHMwNNiXeIRuXn/ElC12t/4+SrZs1NpvQ7Zk7h/2CKACIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBpbCwcO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBpbCwcO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a6c7ac3caso15655897b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677442; x=1764282242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ7dnEro9c9d2hO/FrIUjxVk+A0RxYq22pdc3c1fxXE=;
        b=MBpbCwcOsu4baz6tOQsoIwXuUEiAxYJR5bqStqheMhs+9q2ze2+GU4av09s657H2ab
         Wmd0BymgW7U6JapAC06oa3UOzoMxIvNgCO9FW2MT/AdeaW4kjZqTGl3BNX5KvRzekb+X
         4GdtxZv5DzsYZ1AWX0m/wW532vMvCvekPUfQGz+ZXb6oIQcpQv9U1erPChtp3pZYUFyR
         urQXXK3O5vJgE5PIklgRj67zM3BrQ9Bp4CJP5OGdbRiMTolKEuEBvKC2pY1pPk/GatUr
         x38u+NoO/fvGHRP6ULHqcfJL5tLepo11NCK6IaQ1EdCs0v0mqF5RTbvWKefPR9YS8u/R
         fBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677442; x=1764282242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZ7dnEro9c9d2hO/FrIUjxVk+A0RxYq22pdc3c1fxXE=;
        b=vRzzWUmX6QfknrPXN3oJ3lVuHuKjeR+5R4BreDEMTBntZw7cSj86iAIu7gCtOi7QFt
         2Jdn6WUjD3RKbJfHQ8HQ95PzKgHTov1TX5hRx9gSAsEWRARdM2+PM6deK/q1u4/JdDie
         3iGBRkZYPeyMFnjtcd9Z40B8RJl45jwJFb4Z7sxVje4++vF2aSqtBU9FPFzOx6C4El5M
         arpJH3SyNu1I5zCCHGP8Fmnwb4e8/A+AcGEc7zh2OJENLFupsBmykaMDYcT/5CexKMc+
         tL8EMUv2B0cMGRXHvNIbDSnA0X4B/D2AQ/OlzUeaztIgoBq0Bmxh8zI34Vs1AqKVc89A
         Xung==
X-Gm-Message-State: AOJu0YwFimGIMs+bj5CHYqZHxkSdftcZvcVwg2Xq4BSM4fYuNe/lHBbW
	xo/aVd8OhesE72zZWUOHPWePue380/StN93HsoLOvcaVhiVSVPuBpXBU6GiaMk0VRzCmoQ==
X-Gm-Gg: ASbGncvh1+3dY+XMb8mepSyxvH/JDhV8xFPHzFwoiNVnIXiw5wFMz31KJnjU/PPQmSu
	CQPsAfQeLb8AniaU7fbuDVLqtiQVL7tmGDQS0njeGgCGyvefvqXhcR8h72OgMgrC113YKAiv42x
	pE8vFPAS9SpOIHFNFgzKcQtgDmUA9/SCSCQg0LOkhD24qaxo5ZrHzu+oqcKlBJ4OsVpL55GhNWf
	BBptO8FlCwAx9MqU7KiybY++ilfmMMm0FNhtZwn3lvLbiw99XFjytoDT/a3ffb/eo42B4RvO9Tc
	mqsePWoWoyo4qSUrMvX9ueDBkazBiHU8RYb23YER9uzU8MF5mAQ+MAxTcCvlBXm2XHNkmeJHU+p
	xBOzLyqywqihYvmqZBNsGtptecPVE9ppA/xU15bDspT8q7YGKViVvEJ1NNeQ1075+5boezUNDMg
	ir6iHsQIUC/F55ywkfufeQc/bvErPhpQLAsUpm3JS8JMj7LIp8K3Hq1wCCL9PF
X-Google-Smtp-Source: AGHT+IEAZxnGOkqoWr8GiQKOuWnp42T6hcdoISotm9xlcUNkUrJfVZXHYL13MQXzzivKzLPJr6IIfQ==
X-Received: by 2002:a05:690c:86:b0:786:24c1:9d9f with SMTP id 00721157ae682-78a79635d9emr49293167b3.54.1763677442007;
        Thu, 20 Nov 2025 14:24:02 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:24:01 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 1/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 20 Nov 2025 17:23:41 -0500
Message-ID: <20251120222346.1157004-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120222346.1157004-1-utilityemal77@gmail.com>
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements a flag to prevent access grant inheritance within the filesystem hierarchy
for landlock rules.

If a landlock rule on an inode has this flag, any access grants on parent inodes will be
ignored. Moreover, operations that involve altering the direct parent tree of the subject with
LANDLOCK_ADD_RULE_NO_INHERIT will be denied up to the mountpoint.

For example, if /a/b/c/ = read only + LANDLOCK_ADD_RULE_NO_INHERIT and / = read write, writes to
files in /a/b/c will be denied. Moreover, moving /a to /bad, removing /a/b/c, or creating links to
/a will be prohibited.

The parent directory restrictions mitigate sandbox-restart attacks. For example, if a sandboxed program
is able to move a LANDLOCK_ADD_RULE_NO_INHERIT restricted directory, upon sandbox restart, the policy
applied naively on the same filenames would be invalid. Preventing these operations mitigates these attacks.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c      | 431 ++++++++++++++++++++++++++++++++++--
 security/landlock/object.h  |   2 +
 security/landlock/ruleset.c |  84 ++++++-
 security/landlock/ruleset.h |  39 ++++
 4 files changed, 539 insertions(+), 17 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 5fb2c9810e6b..ebeee080ea7a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -14,6 +14,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/compiler.h>
 #include <linux/compiler_types.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
@@ -23,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/lsm_audit.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
@@ -36,6 +38,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
 
@@ -317,21 +320,152 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
+static inline layer_mask_t landlock_layer_bit(
+	const struct landlock_layer *layer, u32 layer_index)
+{
+	u32 level = layer->level;
+
+	if (!level)
+		level = layer_index + 1;
+	return BIT_ULL(level - 1);
+}
+
+static const struct landlock_rule *find_rule(
+	const struct landlock_ruleset *const domain,
+	const struct dentry *const dentry);
+
+static layer_mask_t get_ruleset_cached_no_inherit_layers(
+	const struct landlock_ruleset *const ruleset,
+	struct landlock_object *object)
+{
+	struct landlock_no_inherit_desc *desc;
+
+	if (!ruleset || !object)
+		return 0;
+
+	/* xa_load doesn't accept const, but we're only reading */
+	desc = xa_load(&((struct landlock_ruleset *)ruleset)->no_inherit_desc,
+		       (unsigned long)object);
+	if (!desc)
+		return 0;
+	return desc->desc_layers;
+}
+
+static layer_mask_t get_no_inherit_desc_layers_for_dentry(
+	const struct landlock_ruleset *const ruleset,
+	struct dentry *const dentry)
+{
+	const struct landlock_rule *rule;
+	struct landlock_object *object;
+	layer_mask_t layers = 0;
+	u32 layer_index;
+
+	if (!ruleset || !dentry || d_is_negative(dentry))
+		return 0;
+
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(d_backing_inode(dentry))->object);
+	if (object)
+		layers |= get_ruleset_cached_no_inherit_layers(ruleset, object);
+	rcu_read_unlock();
+
+	rule = find_rule(ruleset, dentry);
+	if (!rule)
+		return layers;
+
+	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
+		const struct landlock_layer *layer = &rule->layers[layer_index];
+
+		if (!layer->flags.no_inherit &&
+		    !layer->flags.has_no_inherit_descendant)
+			continue;
+		layers |= landlock_layer_bit(layer, layer_index);
+	}
+
+	return layers;
+}
+
+static void mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
+			     struct dentry *dentry,
+			     layer_mask_t descendant_layers);
+
+static bool mask_no_inherit_descendant_layers(
+	const struct landlock_ruleset *const domain,
+	struct dentry *const dentry,
+	layer_mask_t child_layers,
+	const access_mask_t access_request,
+	layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags)
+{
+	layer_mask_t descendant_layers;
+	const unsigned long access_req = access_request;
+	unsigned long access_bit;
+	bool changed = false;
+
+	if (!access_request || !layer_masks || !rule_flags || !dentry)
+		return false;
+	if (d_is_negative(dentry))
+		return false;
+
+	descendant_layers = get_no_inherit_desc_layers_for_dentry(domain, dentry);
+	{
+		layer_mask_t shared_layers = descendant_layers & child_layers;
+
+		if (shared_layers) {
+			rule_flags->no_inherit_masks |= shared_layers;
+			rule_flags->no_inherit_desc_masks |= shared_layers;
+		}
+	}
+	descendant_layers &= ~child_layers;
+	descendant_layers &= ~rule_flags->no_inherit_masks;
+	if (!descendant_layers)
+		return false;
+
+	for_each_set_bit(access_bit, &access_req,
+		       ARRAY_SIZE(*layer_masks)) {
+		layer_mask_t *const layer_mask = &(*layer_masks)[access_bit];
+
+		if (*layer_mask & descendant_layers) {
+			*layer_mask &= ~descendant_layers;
+			changed = true;
+		}
+	}
+
+	if (!changed)
+		return false;
+
+	rule_flags->no_inherit_masks |= descendant_layers;
+	rule_flags->no_inherit_desc_masks |= descendant_layers;
+
+	return true;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
-			    const struct path *const path,
-			    access_mask_t access_rights, const int flags)
+		    const struct path *const path,
+		    access_mask_t access_rights, const int flags)
 {
 	int err;
+	const bool is_dir = d_is_dir(path->dentry);
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_INODE,
 	};
 
 	/* Files only get access rights that make sense. */
-	if (!d_is_dir(path->dentry) &&
-	    (access_rights | ACCESS_FILE) != ACCESS_FILE)
+	if (!is_dir) {
+		const access_mask_t file_rights = access_rights & ACCESS_FILE;
+
+		/*
+		 * Reject purely directory-only access on files, but allow
+		 * metadata-only quiet rules.
+		 */
+		if (!file_rights && !(flags & LANDLOCK_ADD_RULE_QUIET))
+			return -EINVAL;
+		access_rights = file_rights;
+	}
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) && !is_dir)
 		return -EINVAL;
 	if (WARN_ON_ONCE(ruleset->num_layers != 1))
 		return -EINVAL;
@@ -344,6 +478,39 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	if (!err && (flags & LANDLOCK_ADD_RULE_NO_INHERIT)) {
+		const struct landlock_rule *rule;
+		layer_mask_t descendant_layers = 0;
+		u32 layer_index;
+
+		rule = find_rule(ruleset, path->dentry);
+		if (rule) {
+			for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
+				const struct landlock_layer *layer =
+					&rule->layers[layer_index];
+
+				if (layer->flags.no_inherit ||
+				    layer->flags.has_no_inherit_descendant)
+					descendant_layers |=
+						landlock_layer_bit(layer, layer_index);
+			}
+			if (descendant_layers)
+				mark_no_inherit_ancestors(ruleset, path->dentry,
+					      descendant_layers);
+		}
+	}
+
+	/*
+	 * Register this object in the xarray even if it doesn't currently have
+	 * descendant no-inherit layers, so collect_no_inherit_layers() can walk
+	 * ancestors reliably when checking topology changes.
+	 */
+	if (!err) {
+		const struct landlock_rule *rule = find_rule(ruleset, path->dentry);
+
+		if (rule)
+			landlock_set_no_inherit_desc_layers(ruleset, id.key.object, 0);
+	}
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
@@ -382,6 +549,102 @@ find_rule(const struct landlock_ruleset *const domain,
 	return rule;
 }
 
+
+static void mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
+			     struct dentry *dentry,
+			     layer_mask_t descendant_layers)
+{
+	struct dentry *cursor;
+	u32 layer_index;
+
+	if (!ruleset || !dentry || !descendant_layers)
+		return;
+
+	lockdep_assert_held(&ruleset->lock);
+
+	cursor = dget(dentry);
+	while (cursor) {
+		struct dentry *parent;
+
+		if (IS_ROOT(cursor)) {
+			dput(cursor);
+			break;
+		}
+
+		parent = dget_parent(cursor);
+		dput(cursor);
+		if (!parent)
+			break;
+
+		if (!d_is_negative(parent)) {
+			const struct landlock_rule *rule;
+			struct landlock_object *parent_object;
+
+			rule = find_rule(ruleset, parent);
+			if (rule) {
+				struct landlock_rule *mutable_rule =
+					(struct landlock_rule *)rule;
+
+				for (layer_index = 0;
+				     layer_index < mutable_rule->num_layers;
+				     layer_index++) {
+					struct landlock_layer *layer =
+						&mutable_rule->layers[layer_index];
+					layer_mask_t layer_bit =
+						landlock_layer_bit(layer, layer_index);
+
+					if (descendant_layers & layer_bit)
+						layer->flags.has_no_inherit_descendant = true;
+				}
+			}
+
+			parent_object = get_inode_object(d_backing_inode(parent));
+			if (!IS_ERR(parent_object)) {
+				landlock_set_no_inherit_desc_layers(ruleset, parent_object,
+						      descendant_layers);
+				landlock_put_object(parent_object);
+			}
+		}
+
+		cursor = parent;
+	}
+}
+
+static layer_mask_t get_no_inherit_layers_for_target(
+	const struct landlock_ruleset *const ruleset,
+	struct dentry *const dentry,
+	const bool include_descendants)
+{
+	struct landlock_object *object;
+	const struct landlock_rule *rule;
+	layer_mask_t layers = 0;
+	u32 layer_index;
+
+	if (!ruleset || !dentry || d_is_negative(dentry))
+		return 0;
+
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(d_backing_inode(dentry))->object);
+	if (object && include_descendants)
+		layers |= get_ruleset_cached_no_inherit_layers(ruleset, object);
+	rcu_read_unlock();
+
+	rule = find_rule(ruleset, dentry);
+	if (!rule)
+		return layers;
+
+	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
+		const struct landlock_layer *layer = &rule->layers[layer_index];
+
+		if (layer->flags.no_inherit ||
+		    (include_descendants &&
+		     layer->flags.has_no_inherit_descendant))
+			layers |= landlock_layer_bit(layer, layer_index);
+	}
+
+	return layers;
+}
+
 /*
  * Allows access to pseudo filesystems that will never be mountable (e.g.
  * sockfs, pipefs), but can still be reachable through
@@ -778,6 +1041,13 @@ static bool is_access_to_paths_allowed(
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
 	struct collected_rule_flags _rule_flag_parent1_bkp, _rule_flag_parent2_bkp;
+	layer_mask_t child1_layers = 0;
+	layer_mask_t child2_layers = 0;
+
+	if (dentry_child1)
+		child1_layers = get_no_inherit_desc_layers_for_dentry(domain, dentry_child1);
+	if (dentry_child2)
+		child2_layers = get_no_inherit_desc_layers_for_dentry(domain, dentry_child2);
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -976,8 +1246,12 @@ static bool is_access_to_paths_allowed(
 					memcpy(&_rule_flag_parent2_bkp,
 					       rule_flags_parent2,
 					       sizeof(_rule_flag_parent2_bkp));
-					is_dom_check_bkp = is_dom_check;
 				}
+				is_dom_check_bkp = is_dom_check;
+				child1_layers = get_no_inherit_desc_layers_for_dentry(
+					domain, walker_path.dentry);
+				if (layer_masks_parent2)
+					child2_layers = child1_layers;
 
 				/* Ignores hidden mount points. */
 				goto jump_up;
@@ -1001,15 +1275,48 @@ static bool is_access_to_paths_allowed(
 				break;
 			}
 
-			/*
-			 * We reached a disconnected root directory from a bind mount, and
-			 * we need to reset the walk to the current mount root.
-			 */
-			goto reset_to_mount_root;
-		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
+		/*
+		 * We reached a disconnected root directory from a bind mount, and
+		 * we need to reset the walk to the current mount root.
+		 */
+		goto reset_to_mount_root;
+	}
+	if (likely(!d_is_negative(walker_path.dentry))) {
+		child1_layers = get_no_inherit_desc_layers_for_dentry(
+			domain, walker_path.dentry);
+		if (layer_masks_parent2)
+			child2_layers = child1_layers;
+	} else {
+		child1_layers = 0;
+		if (layer_masks_parent2)
+			child2_layers = 0;
+	}
+	parent_dentry = dget_parent(walker_path.dentry);
+	dput(walker_path.dentry);
+	walker_path.dentry = parent_dentry;
+	/*
+	 * Apply descendant no-inherit masking now that we've moved to the
+	 * parent. This ensures the parent respects any no-inherit rules from
+	 * the child we just left. Only applies to refer operations (rename/link).
+	 */
+	if (unlikely(layer_masks_parent2)) {
+		if (mask_no_inherit_descendant_layers(
+			    domain, walker_path.dentry, child1_layers,
+			    access_masked_parent1,
+			    layer_masks_parent1, rule_flags_parent1))
+			allowed_parent1 =
+				allowed_parent1 ||
+				is_layer_masks_allowed(layer_masks_parent1);
+
+		if (rule_flags_parent2 &&
+		    mask_no_inherit_descendant_layers(
+			    domain, walker_path.dentry, child2_layers,
+			    access_masked_parent2,
+			    layer_masks_parent2, rule_flags_parent2))
+			allowed_parent2 =
+				allowed_parent2 ||
+				is_layer_masks_allowed(layer_masks_parent2);
+	}
 		continue;
 
 reset_to_mount_root:
@@ -1057,6 +1364,10 @@ static bool is_access_to_paths_allowed(
 		dput(walker_path.dentry);
 		walker_path.dentry = walker_path.mnt->mnt_root;
 		dget(walker_path.dentry);
+		child1_layers = get_no_inherit_desc_layers_for_dentry(
+			domain, walker_path.dentry);
+		if (layer_masks_parent2)
+			child2_layers = child1_layers;
 	}
 	path_put(&walker_path);
 
@@ -1083,7 +1394,7 @@ static bool is_access_to_paths_allowed(
 }
 
 static int current_check_access_path(const struct path *const path,
-				     access_mask_t access_request)
+			     access_mask_t access_request)
 {
 	const struct access_masks masks = {
 		.fs = access_request,
@@ -1102,7 +1413,7 @@ static int current_check_access_path(const struct path *const path,
 						   LANDLOCK_KEY_INODE);
 	if (is_access_to_paths_allowed(subject->domain, path, access_request,
 				       &layer_masks, &rule_flags, &request,
-				       NULL, 0, NULL, NULL, NULL, NULL))
+			       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
 	landlock_log_denial(subject, &request, rule_flags);
@@ -1233,6 +1544,65 @@ static bool collect_domain_accesses(
 	return ret;
 }
 
+static layer_mask_t collect_no_inherit_layers(
+	const struct landlock_ruleset *domain, struct dentry *dentry)
+{
+	struct dentry *cursor, *parent;
+	layer_mask_t layers = 0;
+	bool include_descendants = true;
+
+	if (!domain || !dentry)
+		return 0;
+
+	cursor = dget(dentry);
+	if (!cursor)
+		return 0;
+
+	while (true) {
+		layers = get_no_inherit_layers_for_target(domain, cursor,
+						      include_descendants);
+		if (layers || IS_ROOT(cursor) || d_is_negative(cursor))
+			break;
+
+		parent = dget_parent(cursor);
+		dput(cursor);
+		if (!parent)
+			return layers;
+		cursor = parent;
+		include_descendants = false;
+	}
+
+	dput(cursor);
+	return layers;
+}
+
+static int deny_no_inherit_topology_change(
+	const struct landlock_cred_security *subject,
+	struct dentry *dentry)
+{
+	layer_mask_t sealed_layers;
+	unsigned long layer_index;
+
+	if (!subject || !dentry || d_is_negative(dentry))
+		return 0;
+
+	sealed_layers = collect_no_inherit_layers(subject->domain, dentry);
+	if (!sealed_layers)
+		return 0;
+
+	layer_index = __ffs((unsigned long)sealed_layers);
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dentry,
+		},
+		.layer_plus_one = layer_index + 1,
+	}, no_rule_flags);
+
+	return -EACCES;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1319,6 +1689,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
+		int err;
+
+		err = deny_no_inherit_topology_change(subject, old_dentry);
+		if (err)
+			return err;
+		if (exchange) {
+			err = deny_no_inherit_topology_change(subject, new_dentry);
+			if (err)
+				return err;
+		}
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
 	}
@@ -1711,12 +2091,31 @@ static int hook_path_symlink(const struct path *const dir,
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+	int err;
+
+	if (subject) {
+		err = deny_no_inherit_topology_change(subject, dentry);
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
+	int err;
+
+	if (subject) {
+		err = deny_no_inherit_topology_change(subject, dentry);
+		if (err)
+			return err;
+	}
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 5f28c35e8aa8..2520955825bb 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -13,6 +13,8 @@
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 
+#include "access.h"
+
 struct landlock_object;
 
 /**
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index fd633aee0599..63aa420ab593 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -48,6 +48,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 #endif /* IS_ENABLED(CONFIG_INET) */
 
 	new_ruleset->num_layers = num_layers;
+	xa_init(&new_ruleset->no_inherit_desc);
 	/*
 	 * hierarchy = NULL
 	 * num_rules = 0
@@ -108,6 +109,45 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 	}
 }
 
+void landlock_set_no_inherit_desc_layers(struct landlock_ruleset *ruleset,
+	struct landlock_object *object,
+	layer_mask_t layers)
+{
+	struct landlock_no_inherit_desc *desc;
+	int err;
+
+	if (!ruleset || !object || !layers)
+		return;
+
+	desc = xa_load(&ruleset->no_inherit_desc, (unsigned long)object);
+	if (desc) {
+		desc->desc_layers |= layers;
+		return;
+	}
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
+	if (!desc)
+		return;
+
+	desc->object = object;
+	desc->desc_layers = layers;
+	landlock_get_object(object);
+	err = xa_insert(&ruleset->no_inherit_desc, (unsigned long)object, desc,
+			 GFP_KERNEL_ACCOUNT);
+	if (err) {
+		struct landlock_no_inherit_desc *existing;
+
+		if (err == -EBUSY) {
+			existing = xa_load(&ruleset->no_inherit_desc,
+					 (unsigned long)object);
+			if (existing)
+				existing->desc_layers |= layers;
+		}
+		landlock_put_object(object);
+		kfree(desc);
+	}
+}
+
 static struct landlock_rule *
 create_rule(const struct landlock_id id,
 	    const struct landlock_layer (*const layers)[], const u32 num_layers,
@@ -257,6 +297,10 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 				return -EINVAL;
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
+			this->layers[0].flags.no_inherit |=
+				(*layers)[0].flags.no_inherit;
+			this->layers[0].flags.has_no_inherit_descendant |=
+				(*layers)[0].flags.has_no_inherit_descendant;
 			return 0;
 		}
 
@@ -315,7 +359,10 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
-		},
+			.no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+			.has_no_inherit_descendant =
+				!!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+		}
 	} };
 
 	build_check_layer();
@@ -402,6 +449,15 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		goto out_unlock;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
+	{
+		unsigned long index;
+		struct landlock_no_inherit_desc *desc;
+
+		xa_for_each(&src->no_inherit_desc, index, desc)
+			landlock_set_no_inherit_desc_layers(dst, desc->object,
+						       desc->desc_layers);
+	}
+
 out_unlock:
 	mutex_unlock(&src->lock);
 	mutex_unlock(&dst->lock);
@@ -465,6 +521,15 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		goto out_unlock;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
+	{
+		unsigned long index;
+		struct landlock_no_inherit_desc *desc;
+
+		xa_for_each(&parent->no_inherit_desc, index, desc)
+			landlock_set_no_inherit_desc_layers(child, desc->object,
+						       desc->desc_layers);
+	}
+
 	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers)) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -489,6 +554,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 static void free_ruleset(struct landlock_ruleset *const ruleset)
 {
 	struct landlock_rule *freeme, *next;
+	struct landlock_no_inherit_desc *desc;
+	unsigned long index;
 
 	might_sleep();
 	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root_inode,
@@ -501,6 +568,12 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 		free_rule(freeme, LANDLOCK_KEY_NET_PORT);
 #endif /* IS_ENABLED(CONFIG_INET) */
 
+	xa_for_each(&ruleset->no_inherit_desc, index, desc) {
+		landlock_put_object(desc->object);
+		kfree(desc);
+	}
+	xa_destroy(&ruleset->no_inherit_desc);
+
 	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
@@ -660,9 +733,18 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		unsigned long access_bit;
 		bool is_empty;
 
+		/* Skip layers that already have no inherit flags. */
+		if (rule_flags &&
+		    (rule_flags->no_inherit_masks & layer_bit))
+			continue;
+
 		/* Collect rule flags for each layer. */
 		if (rule_flags && layer->flags.quiet)
 			rule_flags->quiet_masks |= layer_bit;
+		if (rule_flags && layer->flags.no_inherit)
+			rule_flags->no_inherit_masks |= layer_bit;
+		if (rule_flags && layer->flags.has_no_inherit_descendant)
+			rule_flags->no_inherit_desc_masks |= layer_bit;
 
 		/*
 		 * Records in @layer_masks which layer grants access to each requested
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index cd0434d8dc63..4e0484c1575d 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -15,6 +15,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 #include "access.h"
 #include "limits.h"
@@ -40,6 +41,18 @@ struct landlock_layer {
 		 * down the file hierarchy.
 		 */
 		bool quiet:1;
+		/**
+		 * @no_inherit: When set, this layer's rule does not inherit
+		 * allowed accesses from parent objects within the same layer.
+		 * (currently only applies to filesystem objects)
+		 */
+		bool no_inherit:1;
+		/**
+		 * @has_no_inherit_descendant: Marks that a descendant rule within
+		 * this layer carries the no-inherit flag and therefore seals
+		 * topology changes on the path.
+		 */
+		bool has_no_inherit_descendant:1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
@@ -56,6 +69,15 @@ struct collected_rule_flags {
 	 * @quiet_masks: Layers for which the quiet flag is effective.
 	 */
 	layer_mask_t quiet_masks;
+	/**
+	 * @no_inherit_masks: Layers for which the no_inherit flag is effective.
+	 */
+	layer_mask_t no_inherit_masks;
+	/**
+	 * @no_inherit_desc_masks: Layers for which a descendant rule carries
+	 * the no_inherit flag.
+	 */
+	layer_mask_t no_inherit_desc_masks;
 };
 
 /**
@@ -136,6 +158,11 @@ struct landlock_rule {
 	struct landlock_layer layers[] __counted_by(num_layers);
 };
 
+struct landlock_no_inherit_desc {
+	struct landlock_object *object;
+	layer_mask_t desc_layers;
+};
+
 /**
  * struct landlock_ruleset - Landlock ruleset
  *
@@ -190,6 +217,12 @@ struct landlock_ruleset {
 			 * @num_rules: Number of non-overlapping (i.e. not for
 			 * the same object) rules in this ruleset.
 			 */
+			/**
+			 * @no_inherit_desc: XArray containing objects
+			 * with no_inherit descendants in this ruleset.
+			 * This is used to quickly merge no_inherit flags,
+			 */
+			struct xarray no_inherit_desc;
 			u32 num_rules;
 			/**
 			 * @num_layers: Number of layers that are used in this
@@ -345,4 +378,10 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 			  layer_mask_t (*const layer_masks)[],
 			  const enum landlock_key_type key_type);
 
+
+
+void landlock_set_no_inherit_desc_layers(struct landlock_ruleset *ruleset,
+	struct landlock_object *object,
+	layer_mask_t layers);
+
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.51.2

