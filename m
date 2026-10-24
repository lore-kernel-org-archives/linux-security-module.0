Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792874382;
	b=0hoAGj0tcCcsCf7oIJ0cCMZ8zQChhAgGCR7JKSnAwWhWBjOP1HS1c+NySFrDQBFRLIYI
	 WGiCY5qPsMBMcZdOnO3bJyMIGHRWf0UYM/oQ3AjTaxCERsYob3IOZPcA3AwoBWPcW4ECY
	 bUq02HT5tzUQ9VE8BjX1lHRqgF6u4MI7zp5MsGmqJlKo/ajcdpX6Q8MfdHYMj84JEANtD
	 GIjMpPc+1nZn8wGJ9g8qZuyRP95IxcU9zvXvgIaP/dV+QScGpJx0SG42FdQVIxuhTrLL6
	 5OuhXNvU5zU8DvbOgaziizlBpTGy+rNjTulc4YZEbhOlxy29oUxSeYXYzwCtv/bPWXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792874382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=h4E3S9EDiGMgYhCegYxU13RBx+r3/6a8Bv+UvPiYpqg=;
	b=AwWkYxsld6A4PVrcjA3QcqZG/nDm9O0G1ml1q75yieouMmZ5/c5Bger4AbFOnGBxWguJ
	 oPOW/CXG+GoEL3DDWD9fSpJu+hxCLcclx9spzl3cQJ26gjOnvobHcwqEClQBaTl9mGGO4
	 7zXJVxXMeRlHaLYDapowPXRwaVg3Ze6lzpvYt3FDA7XB5t6bP0Cz76RUpZtuiBzaIpaWZ
	 MgXMlyp6Q6ilIOSFu6UgH9IlwuVhJphsBpNlYvWY90qQUFN8zSscrPdxwrnR86RDynOAG
	 7rRKSS/xhzlyVr/l64LnanOuORlybnbhQhm/s1DSit/UBnOh1ld6sjtNq/Yc5NYYjRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ml1X2ag1;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BB606A32A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 20:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3BB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ml1X2ag1
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535a54bed9so3017632eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792874381; x=1793479181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4E3S9EDiGMgYhCegYxU13RBx+r3/6a8Bv+UvPiYpqg=;
        b=Ml1X2ag1LJau8sdw94Uvd0+Af0Ho+WujMLDvZ1CYkd/TcbEu2hshwm19Puu4oCuW+q
         6Zrh8dR4/QhuIs1mJ7yNlSo70Iy3qHh/6h0Bup0vJAWvuCWMvkvzGawy1D3BDp2972HM
         tQxIOopnaeJ6PXi1ZF75hXoGkEJss0AWJ2t3N93SGG3/TuvXgVgEo/ExOHe1R34QM8JH
         NaMxdgnfbjYpdL5PmkQCYaOxzgeryVTTYWah6S277IJzYYhla5w/NHPw3UjvA1XLwEKu
         6wLGtpagwho8wWZaDAHMTDYWxOcd3xwvasxyI8Mvw2jF4tOImkLJyk0f/MYdZ93i7/kd
         AeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792874381; x=1793479181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4E3S9EDiGMgYhCegYxU13RBx+r3/6a8Bv+UvPiYpqg=;
        b=aieUsZP11H9RctmuE6PvpiHncatc2k2QLIMKxExTBxU5VmpIYOQgiaGiLpGkSUrH3/
         N05w3JvVwTLo1dlpINR1pVhJNPfQ8u7vZ32wqkn5YYX07n+oJy8jHGpKCqwn9Q2/6l1O
         ZPIZbVURXZda2wMOYQqFzxnkKFgQEgCTlwN4pSLkWC3CV7H72IAyCLD+e68F2/z381Uq
         eDfZsoCacaAkF1XpIfQFR1U7mDfID098CGfKNcKDqshOw+YCKef0VAfPa8cUmjehA9U4
         3UgvGZzWVgQedgA2LaCrW5PLUMyzEKB5c2IAkrdqcTES3SqRr3QuMYJo12RKEaEI/4nF
         XtSw==
X-Forwarded-Encrypted: i=1; AKwUvBxRZ+eSOf9XCVrRKsxBQu4bcxyEK2/rStOnETG6rnuazbJAXB4ZbU1zGszmQEv7sq4PnyIo3jod0SUC8uaojVXrakVe3Qw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJurysGfWkUz+AQGAQAsYP1Kphe/ZeMiGyXZe6dWt6eSj91HT5N
	DiUQXBcvkbg8fNbiK/Pwp2L605xnvhMd/5jNxIVyr4jjpih5VBP/u2I3
X-Gm-Gg: AYBFou104Tljlour5jKiyrWFQ6z4Sr5XMvOVJ5Bad5Mm8Pfg+9Gaacu/HDnv18cJE4/
	7x1YvDb+9A9RqwosKW6UUXg6O/dODcHNMM4dzO01gQvq1EhzYLM+MPzIY3xaABCD0ssQfsP0MEN
	guG3pww/P/jeXkhtS+d9XG2WwpZEi0CogtcbMsw0Swm8mhD1grfRef2f8WKYJhpbdSP24gGuU/0
	3z5ElqET9Wn5BKD2J0LfMUiWRNq4PNFaq+RqX3ybUXNO+m0AJfdNNi6j29gB0i6LnvFWJmaNeqR
	xy/8L62H6maoBMUSfcnpAXHYbqBG04u7x8d/GXX15YDxWj5IaVIXsy1+u5BCVnBBAVxqVq1LPz1
	Pbx2cQw1R5wN5rSozZHUtV8dwpwBpFCRS2O5noR7FELfNgbvJZuf+mS0KkYaeBLzK+6XanBseUK
	KEjgROawlSz1OTw7ilt6a8lrPSLs/LPxfi1MVOjh8FbchzzHNlj/XGJyPVKaeUQsYDruajChIfs
	WmQcbs7ayMwZJQV0uK+FXYoFDqmbo6oIscpqag4K+zFhP9EimnZAXAWPSMfng==
X-Received: by 2002:a05:7022:5f09:b0:15e:6541:3099 with SMTP id a92af1059eb24-19933e10e21mr4253273c88.7.1792874379642;
        Sat, 24 Oct 2026 13:39:39 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm9764737c88.14.2026.10.24.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:39:39 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sat, 24 Oct 2026 13:39:18 -0700
Subject: [PATCH RFC 2/3] landlock: Add access rights on created files
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-landlock-created-rights-v1-2-77c8db3f6bd2@gmail.com>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
In-Reply-To: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, John Ericson <mail@johnericson.me>, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

Landlock ties access rights to inodes that exist when a ruleset is
built. A directory where a sandboxed task may only create entries is
then hard to use: LANDLOCK_ACCESS_FS_MAKE_* lets the task create
entries, but the entries are only covered by the rules of their parent
directories, and granting read access on the directory to cover them
also exposes every entry already there.

A shared package store such as /nix/store has this shape. A build
sandbox should read only its declared inputs and use the outputs it
creates, without being able to list or read the rest of the store. The
outputs do not exist when the ruleset is built, so no rule can name
them.

Add a LANDLOCK_ADD_RULE_CREATED flag for LANDLOCK_RULE_PATH_BENEATH
rules on a directory. Its access rights are not granted on the
directory but on each file hierarchy that a task of the domain, or of a
nested domain, creates directly in it. The inode_init_security hook
observes the creation, and each layer's hierarchy keeps the granted
rights and pins the created inodes until the hierarchy is freed. A file
linked or renamed into the directory only gets the rights it already
had at its source, which keeps the LANDLOCK_ACCESS_FS_REFER guarantee
that a reparented file gains nothing.

This bumps the Landlock ABI version to 13.

Assisted-by: LLM
Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 Documentation/userspace-api/landlock.rst     |  42 +++++++
 include/uapi/linux/landlock.h                |  18 +++
 security/landlock/domain.c                   | 182 ++++++++++++++++++++++++++-
 security/landlock/domain.h                   |  28 +++++
 security/landlock/fs.c                       | 176 ++++++++++++++++++++++++--
 security/landlock/object.h                   |   6 +
 security/landlock/ruleset.c                  |   6 +
 security/landlock/ruleset.h                  |  14 +++
 security/landlock/syscalls.c                 |  20 ++-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 10 files changed, 471 insertions(+), 23 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 3d45b956b640..d347f157fb79 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -418,6 +418,41 @@ In this case, granting read-write access to ``~/tmp/``, instead of write-only
 access, would potentially allow moving ``~/tmp/`` to a non-readable directory
 and still keep the ability to list the content of ``~/tmp/``.
 
+Created file hierarchies
+------------------------
+
+Some directories are shared between trusted and sandboxed tasks.  For instance,
+a package store may hold the declared inputs of a build sandbox, other packages
+that this sandbox must not read, and the outputs that this sandbox creates.
+Granting the ``LANDLOCK_ACCESS_FS_MAKE_*`` access rights on such a directory
+enables the sandbox to create new entries, but these entries are then only
+covered by the rules of their parent directories.  They cannot be the target of
+a rule either, because they do not exist yet when the ruleset is created.
+
+A rule added with the ``LANDLOCK_ADD_RULE_CREATED`` flag grants its access
+rights on each file hierarchy that the sandboxed tasks create directly in a
+directory, instead of on the directory itself.  For instance, the following
+rule enables a sandboxed task to use the entries it creates in ``/nix/store``,
+but not the other entries of this directory:
+
+.. code-block:: c
+
+    struct landlock_path_beneath_attr created_attr = {
+        .allowed_access = ruleset_attr.handled_access_fs,
+        .parent_fd = open("/nix/store", O_PATH | O_CLOEXEC),
+    };
+
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+                            &created_attr, LANDLOCK_ADD_RULE_CREATED);
+
+A file hierarchy linked or renamed into such a directory only gets these access
+rights if it already had them at its source.  This enables building an entry in
+another directory and then moving it in place.  These access rights are tied to
+the created inodes, which are kept in memory for as long as the domain (or one
+of its nested domains) exists.  Entries created through an OverlayFS merge
+directory do not get these access rights, because OverlayFS creates them on its
+upper layer on behalf of the task that mounted it.
+
 Layers of file path access rights
 ---------------------------------
 
@@ -1051,6 +1086,13 @@ fd-reference acquisition (:manpage:`open_tree(2)`, :manpage:`fsmount(2)`) with
 the new ``LANDLOCK_PERMISSION_NAMESPACE_USE`` permission flag and
 ``LANDLOCK_RULE_NAMESPACE`` rule type.
 
+Created file hierarchies (ABI < 13)
+-----------------------------------
+
+Starting with the Landlock ABI version 13, it is possible to grant access
+rights on the file hierarchies created by a sandboxed task in a directory with
+the new ``LANDLOCK_ADD_RULE_CREATED`` rule flag.
+
 .. _kernel_support:
 
 Kernel support
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 24510e5d8479..a92324bba41e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -129,10 +129,28 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ *
+ * %LANDLOCK_ADD_RULE_CREATED
+ *     Only valid for a %LANDLOCK_RULE_PATH_BENEATH rule on a directory.
+ *     Instead of granting allowed_access on the directory hierarchy, this
+ *     grants it on each file hierarchy that a task of the resulting domain
+ *     (or of a nested domain) creates directly in this directory.  A file
+ *     hierarchy linked or renamed into this directory only gets these access
+ *     rights if it already had them at its source.
+ *
+ *     This enables a sandboxed task to use the files it creates in a
+ *     directory without being able to read the rest of this directory, e.g.
+ *     build outputs in a shared package store.  Creating files still requires
+ *     the related ``LANDLOCK_ACCESS_FS_MAKE_*`` rights on the directory.
+ *
+ *     These access rights are tied to the created inodes for as long as the
+ *     domain exists.  This flag cannot be combined with
+ *     %LANDLOCK_ADD_RULE_QUIET.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_CREATED		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 4c0b1f0e1db5..f8dc771724e1 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -57,6 +57,7 @@ static struct landlock_domain *create_domain(const u32 num_layers)
 
 	refcount_set(&new_domain->usage, 1);
 	new_domain->rules.root_inode = RB_ROOT;
+	new_domain->rules.root_inode_created = RB_ROOT;
 
 #if IS_ENABLED(CONFIG_INET)
 	new_domain->rules.root_net_port = RB_ROOT;
@@ -98,9 +99,9 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 }
 
 /* The returned access has the same lifetime as the domain. */
-static const struct landlock_rule *
-find_rule(const struct landlock_domain *const domain,
-	  const struct landlock_id id)
+const struct landlock_rule *
+landlock_find_rule(const struct landlock_domain *const domain,
+		   const struct landlock_id id)
 {
 	const struct rb_root *root;
 	const struct rb_node *node;
@@ -152,7 +153,7 @@ bool landlock_unmask_layers(const struct landlock_domain *const domain,
 	if (!masks)
 		return true;
 
-	rule = find_rule(domain, id);
+	rule = landlock_find_rule(domain, id);
 	if (!rule)
 		return false;
 
@@ -198,6 +199,166 @@ bool landlock_unmask_layers(const struct landlock_domain *const domain,
 	return true;
 }
 
+/**
+ * struct landlock_created - Access rights granted on a created inode
+ */
+struct landlock_created {
+	/**
+	 * @node: Node in &landlock_hierarchy.created .
+	 */
+	struct rb_node node;
+	/**
+	 * @object: Object tied to the created inode.
+	 */
+	struct landlock_object *object;
+	/**
+	 * @access: Access rights granted on the created file hierarchy.
+	 */
+	access_mask_t access;
+};
+
+static struct landlock_hierarchy *
+get_layer_hierarchy(const struct landlock_domain *const domain,
+		    const size_t layer_level)
+{
+	struct landlock_hierarchy *hierarchy = domain->hierarchy;
+
+	for (size_t i = domain->num_layers - 1; i > layer_level && hierarchy;
+	     i--)
+		hierarchy = hierarchy->parent;
+	return hierarchy;
+}
+
+/**
+ * landlock_add_created - Grant access rights on a created inode
+ *
+ * @domain: The domain of the task which created the inode.
+ * @layer_level: The layer of @domain which granted @access.
+ * @object: The object tied to the created inode.
+ * @access: The access rights to grant on the created file hierarchy.
+ *
+ * The access rights are tied to the hierarchy of the layer, which is shared
+ * with nested domains, and keep @object alive until this hierarchy is freed.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int landlock_add_created(const struct landlock_domain *const domain,
+			 const size_t layer_level,
+			 struct landlock_object *const object,
+			 const access_mask_t access)
+{
+	struct landlock_hierarchy *const hierarchy =
+		get_layer_hierarchy(domain, layer_level);
+	struct landlock_created *new_created;
+	struct rb_node **walker_node, *parent_node = NULL;
+
+	if (WARN_ON_ONCE(!hierarchy))
+		return -EINVAL;
+
+	new_created = kzalloc_obj(*new_created, GFP_KERNEL_ACCOUNT);
+	if (!new_created)
+		return -ENOMEM;
+
+	spin_lock(&hierarchy->created_lock);
+	walker_node = &hierarchy->created.rb_node;
+	while (*walker_node) {
+		struct landlock_created *const this =
+			rb_entry(*walker_node, struct landlock_created, node);
+
+		if (this->object == object) {
+			this->access |= access;
+			spin_unlock(&hierarchy->created_lock);
+			kfree(new_created);
+			return 0;
+		}
+		parent_node = *walker_node;
+		if (this->object < object)
+			walker_node = &(*walker_node)->rb_right;
+		else
+			walker_node = &(*walker_node)->rb_left;
+	}
+	landlock_get_object(object);
+	new_created->object = object;
+	new_created->access = access;
+	rb_link_node(&new_created->node, parent_node, walker_node);
+	rb_insert_color(&new_created->node, &hierarchy->created);
+	spin_unlock(&hierarchy->created_lock);
+	WRITE_ONCE(object->created, true);
+	return 0;
+}
+
+static access_mask_t get_created(struct landlock_hierarchy *const hierarchy,
+				 const struct landlock_object *const object)
+{
+	const struct rb_node *node;
+	access_mask_t access = 0;
+
+	spin_lock(&hierarchy->created_lock);
+	node = hierarchy->created.rb_node;
+	while (node) {
+		const struct landlock_created *const this =
+			rb_entry(node, struct landlock_created, node);
+
+		if (this->object == object) {
+			access = this->access;
+			break;
+		}
+		if (this->object < object)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	spin_unlock(&hierarchy->created_lock);
+	return access;
+}
+
+/**
+ * landlock_unmask_created - Remove the access rights in @masks which are
+ *                           granted on a created inode
+ *
+ * @domain: The Landlock domain to check against.
+ * @object: The object tied to the inode, which may have been created by a
+ *          task of @domain, a parent domain, or a nested domain.
+ * @masks: A matrix of unfulfilled access rights for each layer.
+ *
+ * Return: True if the request is allowed (i.e. @masks has no leftover set
+ * bits).
+ */
+bool landlock_unmask_created(const struct landlock_domain *const domain,
+			     const struct landlock_object *const object,
+			     struct layer_masks *masks)
+{
+	struct landlock_hierarchy *hierarchy = domain->hierarchy;
+
+	if (!masks)
+		return true;
+
+	if (!READ_ONCE(object->created))
+		return false;
+
+	for (size_t i = domain->num_layers; i > 0 && hierarchy;
+	     i--, hierarchy = hierarchy->parent)
+		masks->layers[i - 1].access &= ~get_created(hierarchy, object);
+
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
+		if (masks->layers[i].access)
+			return false;
+	}
+	return true;
+}
+
+void landlock_free_created(struct landlock_hierarchy *const hierarchy)
+{
+	struct landlock_created *freeme, *next;
+
+	might_sleep();
+	rbtree_postorder_for_each_entry_safe(freeme, next, &hierarchy->created,
+					     node) {
+		landlock_put_object(freeme->object);
+		kfree(freeme);
+	}
+}
+
 typedef access_mask_t
 get_access_mask_t(const struct landlock_domain *const domain,
 		  const u16 layer_level);
@@ -331,11 +492,15 @@ static int merge_ruleset(struct landlock_domain *const dst,
 	dst->layers[dst->num_layers - 1] =
 		landlock_upgrade_handled_layer_config(src->layer);
 
-	/* Merges the @src inode tree. */
+	/* Merges the @src inode trees. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
 	if (err)
 		return err;
 
+	err = merge_tree(dst, src, LANDLOCK_KEY_INODE_CREATED);
+	if (err)
+		return err;
+
 #if IS_ENABLED(CONFIG_INET)
 	/* Merges the @src network port tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
@@ -386,11 +551,15 @@ static int inherit_ruleset(struct landlock_domain *const parent,
 	if (!parent)
 		return 0;
 
-	/* Copies the @parent inode tree. */
+	/* Copies the @parent inode trees. */
 	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
 	if (err)
 		return err;
 
+	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE_CREATED);
+	if (err)
+		return err;
+
 #if IS_ENABLED(CONFIG_INET)
 	/* Copies the @parent network port tree. */
 	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
@@ -463,6 +632,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 		return ERR_PTR(-ENOMEM);
 
 	refcount_set(&new_dom->hierarchy->usage, 1);
+	spin_lock_init(&new_dom->hierarchy->created_lock);
 
 	/* ...as a child of @parent... */
 	err = inherit_ruleset(parent, new_dom);
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12b3c..21d6bb4453d1 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -19,6 +19,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
 #include "access.h"
@@ -98,6 +99,17 @@ struct landlock_hierarchy {
 	 * domain.
 	 */
 	refcount_t usage;
+	/**
+	 * @created_lock: Protects @created.
+	 */
+	spinlock_t created_lock;
+	/**
+	 * @created: Red-black tree of &struct landlock_created, one per inode
+	 * which got access rights from a %LANDLOCK_ADD_RULE_CREATED rule of
+	 * this layer.  Each node holds a reference to its object, and thus to
+	 * its inode, until this hierarchy is freed.
+	 */
+	struct rb_root created;
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
@@ -187,6 +199,8 @@ landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
 		refcount_inc(&hierarchy->usage);
 }
 
+void landlock_free_created(struct landlock_hierarchy *const hierarchy);
+
 static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 {
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
@@ -194,6 +208,7 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 
 		landlock_log_free_domain(hierarchy);
 		landlock_free_hierarchy_details(hierarchy);
+		landlock_free_created(hierarchy);
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
 	}
@@ -321,6 +336,19 @@ bool landlock_unmask_layers(const struct landlock_domain *const domain,
 			    struct layer_masks *masks,
 			    const struct landlock_rule **matched_rule);
 
+const struct landlock_rule *
+landlock_find_rule(const struct landlock_domain *const domain,
+		   const struct landlock_id id);
+
+int landlock_add_created(const struct landlock_domain *const domain,
+			 const size_t layer_level,
+			 struct landlock_object *const object,
+			 const access_mask_t access);
+
+bool landlock_unmask_created(const struct landlock_domain *const domain,
+			     const struct landlock_object *const object,
+			     struct layer_masks *masks);
+
 access_mask_t
 landlock_init_layer_masks(const struct landlock_domain *const domain,
 			  const access_mask_t access_request,
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2ab67bcad198..64a344725433 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -332,12 +332,15 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 {
 	int err;
 	struct landlock_id id = {
-		.type = LANDLOCK_KEY_INODE,
+		.type = (flags & LANDLOCK_ADD_RULE_CREATED) ?
+				LANDLOCK_KEY_INODE_CREATED :
+				LANDLOCK_KEY_INODE,
 	};
 
 	/* Files only get access rights that make sense. */
 	if (!d_is_dir(path->dentry) &&
-	    !access_mask_subset(access_rights, ACCESS_FILE))
+	    ((flags & LANDLOCK_ADD_RULE_CREATED) ||
+	     !access_mask_subset(access_rights, ACCESS_FILE)))
 		return -EINVAL;
 
 	/* Transforms relative access rights to absolute ones. */
@@ -428,6 +431,16 @@ static bool unmask_layers_fs(const struct landlock_domain *const domain,
 	return ret;
 }
 
+static bool unmask_layers_created(const struct landlock_domain *const domain,
+				  const struct landlock_id id,
+				  struct layer_masks *masks)
+{
+	if (RB_EMPTY_ROOT(&domain->rules.root_inode_created))
+		return false;
+
+	return landlock_unmask_created(domain, id.key.object, masks);
+}
+
 /*
  * Allows access to pseudo filesystems that will never be mountable (e.g.
  * sockfs, pipefs), but can still be reachable through
@@ -869,9 +882,11 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 						    LANDLOCK_MASK_ACCESS_FS,
 						    &_layer_masks_child1,
 						    LANDLOCK_KEY_INODE);
-		if (handled && get_inode_id(dentry_child1, &id))
+		if (handled && get_inode_id(dentry_child1, &id)) {
 			unmask_layers_fs(domain, id, handled,
 					 &_layer_masks_child1, dentry_child1);
+			unmask_layers_created(domain, id, &_layer_masks_child1);
+		}
 		layer_masks_child1 = &_layer_masks_child1;
 		child1_is_directory = d_is_dir(dentry_child1);
 	}
@@ -885,9 +900,11 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 						    LANDLOCK_MASK_ACCESS_FS,
 						    &_layer_masks_child2,
 						    LANDLOCK_KEY_INODE);
-		if (handled && get_inode_id(dentry_child2, &id))
+		if (handled && get_inode_id(dentry_child2, &id)) {
 			unmask_layers_fs(domain, id, handled,
 					 &_layer_masks_child2, dentry_child2);
+			unmask_layers_created(domain, id, &_layer_masks_child2);
+		}
 		layer_masks_child2 = &_layer_masks_child2;
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
@@ -945,13 +962,17 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 				unmask_layers_fs(domain, id,
 						 access_masked_parent1,
 						 layer_masks_parent1,
-						 walker_path.dentry);
+						 walker_path.dentry) ||
+				unmask_layers_created(domain, id,
+						      layer_masks_parent1);
 			allowed_parent2 =
 				allowed_parent2 ||
 				unmask_layers_fs(domain, id,
 						 access_masked_parent2,
 						 layer_masks_parent2,
-						 walker_path.dentry);
+						 walker_path.dentry) ||
+				unmask_layers_created(domain, id,
+						      layer_masks_parent2);
 		}
 
 		/* Stops when a rule from each layer grants access. */
@@ -1148,8 +1169,9 @@ static bool collect_domain_accesses(const struct landlock_domain *const domain,
 
 		/* Gets all layers allowing all domain accesses. */
 		if (get_inode_id(dir, &id) &&
-		    unmask_layers_fs(domain, id, access_masked_dom,
-				     layer_masks_dom, dir)) {
+		    (unmask_layers_fs(domain, id, access_masked_dom,
+				      layer_masks_dom, dir) ||
+		     unmask_layers_created(domain, id, layer_masks_dom))) {
 			/*
 			 * Stops when all handled accesses are allowed by at
 			 * least one rule in each layer.
@@ -1359,8 +1381,130 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	return -EXDEV;
 }
 
+static const struct landlock_rule *
+get_created_rule(const struct landlock_domain *const domain,
+		 const struct inode *const dir)
+{
+	const struct landlock_id id = {
+		.key.object = rcu_access_pointer(landlock_inode(dir)->object),
+		.type = LANDLOCK_KEY_INODE_CREATED,
+	};
+
+	if (!id.key.object)
+		return NULL;
+
+	return landlock_find_rule(domain, id);
+}
+
+/**
+ * grant_created - Grant the access rights of a LANDLOCK_ADD_RULE_CREATED rule
+ *
+ * @domain: The domain of the current task.
+ * @rule: The rule tied to the parent directory of @inode.
+ * @inode: The created, linked, or renamed inode.
+ * @src_masks: If not NULL, the unfulfilled access rights of @inode at its
+ *             source.  Only the layers which already granted their access
+ *             rights there grant them on @inode.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int grant_created(const struct landlock_domain *const domain,
+			 const struct landlock_rule *const rule,
+			 struct inode *const inode,
+			 const struct layer_masks *const src_masks)
+{
+	struct landlock_object *object;
+	int err = 0;
+
+	object = get_inode_object(inode);
+	if (IS_ERR(object))
+		return PTR_ERR(object);
+
+	for (size_t i = 0; i < rule->num_layers && !err; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+
+		if (src_masks &&
+		    (src_masks->layers[layer->level - 1].access & layer->access))
+			continue;
+
+		err = landlock_add_created(domain, layer->level - 1, object,
+					   layer->access);
+	}
+	landlock_put_object(object);
+	return err;
+}
+
+/*
+ * Grants the access rights of @new_dir's LANDLOCK_ADD_RULE_CREATED rule on
+ * the reparented @old_dentry, for the layers which already granted them at
+ * its source.  This must only be called once the refer action is allowed.
+ */
+static int refer_created(struct dentry *const old_dentry,
+			 const struct path *const new_dir)
+{
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+	/* The mount points are the same for old and new paths, cf. EXDEV. */
+	const struct path old_path = {
+		.mnt = new_dir->mnt,
+		.dentry = old_dentry,
+	};
+	const struct landlock_rule *rule;
+	struct layer_masks layer_masks;
+	access_mask_t access = 0;
+
+	if (!subject ||
+	    RB_EMPTY_ROOT(&subject->domain->rules.root_inode_created) ||
+	    old_dentry->d_parent == new_dir->dentry)
+		return 0;
+
+	rule = get_created_rule(subject->domain,
+				d_backing_inode(new_dir->dentry));
+	if (!rule)
+		return 0;
+
+	for (size_t i = 0; i < rule->num_layers; i++)
+		access |= rule->layers[i].access;
+
+	/* Only compares the access rights which make sense for files. */
+	if (!d_is_dir(old_dentry))
+		access &= ACCESS_FILE;
+
+	access = landlock_init_layer_masks(subject->domain, access,
+					   &layer_masks, LANDLOCK_KEY_INODE);
+	is_access_to_paths_allowed(subject->domain, &old_path, access,
+				   &layer_masks, NULL, NULL, 0, NULL, NULL,
+				   NULL);
+	return grant_created(subject->domain, rule,
+			     d_backing_inode(old_dentry), &layer_masks);
+}
+
 /* Inode hooks */
 
+static int hook_inode_init_security(struct inode *const inode,
+				    struct inode *const dir,
+				    const struct qstr *const qstr,
+				    struct xattr *const xattrs,
+				    int *const xattr_count)
+{
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+	const struct landlock_rule *rule;
+	int err;
+
+	if (!subject || !dir ||
+	    RB_EMPTY_ROOT(&subject->domain->rules.root_inode_created))
+		return -EOPNOTSUPP;
+
+	rule = get_created_rule(subject->domain, dir);
+	if (!rule)
+		return -EOPNOTSUPP;
+
+	/* Landlock does not provide any xattr. */
+	err = grant_created(subject->domain, rule, inode, NULL);
+	return err ?: -EOPNOTSUPP;
+}
+
 static void hook_inode_free_security_rcu(void *inode_security)
 {
 	struct landlock_inode_security *inode_sec;
@@ -1623,7 +1767,8 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false, false);
+					false, false) ?:
+		       refer_created(old_dentry, new_dir);
 }
 
 static int hook_path_rename(const struct path *const old_dir,
@@ -1632,10 +1777,16 @@ static int hook_path_rename(const struct path *const old_dir,
 			    struct dentry *const new_dentry,
 			    const unsigned int flags)
 {
+	int err;
+
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
-	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE),
-					!!(flags & RENAME_WHITEOUT));
+	err = current_check_refer_path(old_dentry, new_dir, new_dentry, true,
+				       !!(flags & RENAME_EXCHANGE),
+				       !!(flags & RENAME_WHITEOUT));
+	if (err || (flags & RENAME_EXCHANGE))
+		return err;
+
+	return refer_created(old_dentry, new_dir);
 }
 
 static int hook_path_mkdir(const struct path *const dir,
@@ -2083,6 +2234,7 @@ static void hook_file_free_security(struct file *file)
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_init_security, hook_inode_init_security),
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 5f28c35e8aa8..61bd8589862d 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -54,6 +54,12 @@ struct landlock_object {
 	 * Lock ordering: inode->i_lock nests inside this.
 	 */
 	spinlock_t lock;
+	/**
+	 * @created: Set once the underlying inode got access rights from a
+	 * %LANDLOCK_ADD_RULE_CREATED rule, which enables to skip looking up
+	 * such access rights for other inodes.
+	 */
+	bool created;
 	/**
 	 * @underobj: Used when cleaning up an object and to mark an object as
 	 * tied to its underlying kernel structure.  This pointer is protected
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 11776b138a56..44168537648c 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -49,6 +49,7 @@ struct landlock_ruleset *landlock_create_ruleset(
 	refcount_set(&new_ruleset->usage, 1);
 	mutex_init(&new_ruleset->lock);
 	new_ruleset->rules.root_inode = RB_ROOT;
+	new_ruleset->rules.root_inode_created = RB_ROOT;
 
 #if IS_ENABLED(CONFIG_INET)
 	new_ruleset->rules.root_net_port = RB_ROOT;
@@ -110,6 +111,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 {
 	switch (key_type) {
 	case LANDLOCK_KEY_INODE:
+	case LANDLOCK_KEY_INODE_CREATED:
 		return true;
 
 #if IS_ENABLED(CONFIG_INET)
@@ -342,6 +344,10 @@ void landlock_free_rules(struct landlock_rules *const rules)
 					     node)
 		free_rule(freeme, LANDLOCK_KEY_INODE);
 
+	rbtree_postorder_for_each_entry_safe(freeme, next,
+					     &rules->root_inode_created, node)
+		free_rule(freeme, LANDLOCK_KEY_INODE_CREATED);
+
 #if IS_ENABLED(CONFIG_INET)
 	rbtree_postorder_for_each_entry_safe(freeme, next,
 					     &rules->root_net_port, node)
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 3a38d7079dc2..4ed347a0c3a5 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -74,6 +74,11 @@ enum landlock_key_type {
 	 * keys.
 	 */
 	LANDLOCK_KEY_NET_PORT,
+	/**
+	 * @LANDLOCK_KEY_INODE_CREATED: Type of
+	 * &landlock_rules.root_inode_created's node keys.
+	 */
+	LANDLOCK_KEY_INODE_CREATED,
 };
 
 /**
@@ -130,6 +135,13 @@ struct landlock_rules {
 	 */
 	struct rb_root root_inode;
 
+	/**
+	 * @root_inode_created: Root of a red-black tree containing &struct
+	 * landlock_rule nodes with directory inode object, for rules added with
+	 * %LANDLOCK_ADD_RULE_CREATED.  Immutable for domains.
+	 */
+	struct rb_root root_inode_created;
+
 #if IS_ENABLED(CONFIG_INET)
 	/**
 	 * @root_net_port: Root of a red-black tree containing &struct
@@ -237,6 +249,8 @@ landlock_get_rule_root(struct landlock_rules *const rules,
 	switch (key_type) {
 	case LANDLOCK_KEY_INODE:
 		return &rules->root_inode;
+	case LANDLOCK_KEY_INODE_CREATED:
+		return &rules->root_inode_created;
 
 #if IS_ENABLED(CONFIG_INET)
 	case LANDLOCK_KEY_NET_PORT:
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index fb5af318b69b..755f6574539d 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -191,7 +191,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 12;
+const int landlock_abi_version = 13;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -397,9 +397,15 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	 * are ignored in path walks.  However, the rule is not useless if it is
 	 * there to hold a quiet flag.
 	 */
-	if (!flags && !path_beneath_attr.allowed_access)
+	if (!(flags & LANDLOCK_ADD_RULE_QUIET) &&
+	    !path_beneath_attr.allowed_access)
 		return -ENOMSG;
 
+	/* Created file hierarchies are not covered by quiet flags. */
+	if ((flags & LANDLOCK_ADD_RULE_QUIET) &&
+	    (flags & LANDLOCK_ADD_RULE_CREATED))
+		return -EINVAL;
+
 	/* Checks that allowed_access matches the @ruleset constraints. */
 	mask = ruleset->layer.handled.fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
@@ -450,6 +456,9 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_access.net)
 		return -EINVAL;
 
+	if (flags & LANDLOCK_ADD_RULE_CREATED)
+		return -EINVAL;
+
 	/* Denies inserting a rule with port greater than 65535. */
 	if (net_port_attr.port > U16_MAX)
 		return -EINVAL;
@@ -618,7 +627,7 @@ static int add_rule_capability(struct landlock_ruleset *const ruleset,
  *             %LANDLOCK_RULE_PATH_BENEATH, %LANDLOCK_RULE_NET_PORT,
  *             %LANDLOCK_RULE_NAMESPACE, or %LANDLOCK_RULE_CAPABILITY.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
+ * @flags: Must be 0, %LANDLOCK_ADD_RULE_QUIET, or %LANDLOCK_ADD_RULE_CREATED.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -640,6 +649,9 @@ static int add_rule_capability(struct landlock_ruleset *const ruleset,
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
  * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
  *   quiet access bits set for the corresponding rule type.
+ * - %EINVAL: LANDLOCK_ADD_RULE_CREATED is passed with
+ *   LANDLOCK_ADD_RULE_QUIET, for a rule which is not a
+ *   %LANDLOCK_RULE_PATH_BENEATH one, or for a file which is not a directory.
  * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
  *   0) and no flags;
  * - %ENOMSG: &landlock_namespace_attr.permissions is 0, or both
@@ -667,7 +679,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	if (flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_CREATED))
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 89c0d96607de..14078ad203d8 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(12, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(13, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,

-- 
2.55.0

