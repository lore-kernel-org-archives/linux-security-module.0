Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182273659EB
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019555; cv=none; b=Rdmlb4Hur+/r7541/FY216keido8gT+x1YRGRO842DIB+Gg8QEjL6t8W6zNCTWI6JHlSjs9unj0rgthW9V6+weCTvh6u7vte00nGz4N+Umij4q0jMwWoyPKoOrolsSIxUE/p1MlnUYStTEBsEA7FcRrENXQoyuqHAm9XNARXvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019555; c=relaxed/simple;
	bh=V4qyqYkyEOcnTAI510w7NrX5J6c++/Ah8EHhTYHuTHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5nxIrV83wubGqxddUKItB2RAEynOUw/mx9TP8ZIMrYcTYL3++gZDraE21El1h+ZiLpJLHjeaJjiCgbeK4g40rX50hev6tIx7mlhs4z8R7kat9DVAGAMLsmliMPZLejFbz+STJljy0+wvCCC3mUaWuyutsabxcAc6kOZipRZJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAIeoxBQ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAIeoxBQ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bdc947aaa3so140469327b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019553; x=1780624353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFCbqPU2dS/yUCY9uXq7gRsMM8ystmO/PODxvI3hCfQ=;
        b=nAIeoxBQqpaQXpx9Rgajl6gcSmKbOaqBI5FvKOmtjdPxJ7uUDD+DLzRz7nOuoyFfnN
         psx/VYVAyYeXrekgN6z+/pTSufCxE4F52FBJKDz8VueyNjs3MFZksavDCGgETjr9sWeT
         3Gf/ai/97OWZiXtGownSh+6DHXfAL+3c0uXElI6ae0W4LKNLMjgoMEm9vO0nqZ2LdC+b
         3OJ0Iz9ADtNP0Orh3/doS8WfzEpOTZ7p6pDlvjmGtnSPeMUhI3TLdfVFGl/gNoIF1zYj
         E6IDwmQ/l2bJICFTK0pAm7zwyRBRrVQ6ICWFNYrrAphS0eB32J2j4C+fT273QMKVF7iT
         AUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019553; x=1780624353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFCbqPU2dS/yUCY9uXq7gRsMM8ystmO/PODxvI3hCfQ=;
        b=r8nz7HEbJaDlXf6KshhnU2uLinpsXQMErisisN/bHghhe4CE61SNZNJ/hdBQW79Jnv
         hfkw/gWqJYzTO86pbqsMnaGJ66JQTFWI7pVxB3YaLOO+psPbUjBw+ugGrx+lKE2vLawI
         OEQdatgvKsQTj7mXTK1Mo6oNQBUKOhiNMiz5gxlx64NZxWJnm9st5JqOg+iOIy+E0fXn
         R4pFGDa1TpgB9O7vYB3bNqXpKnsRVpk2ntdO9IwmAy8Te5hHUnpPgj095FHBURtJP6p6
         2Esuapja5toX3fR7OwKAiyihWi0VE6eXvtoOwz/Mxn86IaupMT2SPMIVFdcL8/qZ4EcO
         D0Nw==
X-Forwarded-Encrypted: i=1; AFNElJ9xVYnJaoiWfqS/3irXgI4RANlq8B7mpzurvMG7Ka0JbFfsctfriszlESUR//nJqnmDiIdM16405o7ga46TECR1QeDtPHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzM+Vp68dgeXMXpBBQYv3hpoB4Lm7nOA1NbM7oJrwnrLdOVYf/
	hOmF7UmvCKqxKJndVYg5qENDYf440DaFBdrcS1iMYq2UJ2Mi/b09Sjuy
X-Gm-Gg: Acq92OFdNHwpcvTMop+JDAPpEhBIi2lqqL6zI8RVYJ+0xW+Kk3PXvcXCYYlSqB9g83t
	zooEtWdhBBbQ2Au8OhXtE0qDCZfSJ+mP5zWVcjcdOPwJoUFrUSoSvKsBHz1Pf9eSpW69uRdQM2b
	nLXBao1qCWggtaDrCef6aOLhBPKSKXTnRvPHdlIuCyNMO/SmRXjc0B3TGanXr67xiIDI+qnc2Bw
	i1hFZxi/M6yjhsW0tLOURBGO4Ck8j1o4nCPCd3neRZwmgGO22V3IqSpUh2DCVxK2h5sAOCrIgP+
	B3PhbH0hVFXyvyucSrq8MsKxILo8vYrRogDU11xlq6TgSRzskAvzt2wawHzMjEhJkyibv1ech+7
	oQbeJtTla2/tOA//B+ThGmULcu098YpKqlnk8J4IvmmgIPwXX8kxp1fnWmSzcsQj7wBK6+oa/5v
	50nSWrzTCRgliJeQLwHECxsEQXlCVyZhEV75cv9XS0B45kFb/SaoFIBbvxXoejC9NClAbB48QlO
	sDwyK0Oki8=
X-Received: by 2002:a05:690c:260f:b0:7dc:211:d718 with SMTP id 00721157ae682-7de4529219fmr8127397b3.4.1780019552984;
        Thu, 28 May 2026 18:52:32 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:32 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 05/10] landlock: Return inserted rule from landlock_insert_rule()
Date: Thu, 28 May 2026 21:52:04 -0400
Message-ID: <20260529015210.500291-6-utilityemal77@gmail.com>
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

Change insert_rule() and landlock_insert_rule() to return the inserted
(or updated) struct landlock_rule pointer instead of an int errno.
Errors are propagated via ERR_PTR().

This gives callers a handle on the resulting rule so a subsequent change
can mutate per-layer flags on it (e.g. to mark ancestor rules created
for no-inherit topology sealing).

No functional change intended.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Replaced the v7 "Move find_rule definition above
        landlock_append_fs_rule" patch with this new preparatory patch.
        Instead of moving find_rule(), make landlock_insert_rule() (and
        its static insert_rule() helper) return the inserted struct
        landlock_rule * via ERR_PTR(), so callers can directly tag flags
        on the resulting rule. Callers in net.c, merge_tree(), and
        inherit_tree() updated accordingly. No functional change.

 security/landlock/fs.c      |  7 ++--
 security/landlock/net.c     |  8 +++--
 security/landlock/ruleset.c | 68 ++++++++++++++++++-------------------
 security/landlock/ruleset.h |  7 ++--
 4 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6552351e0b9c..ee7d9f5d7ee5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -359,7 +359,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
 			    access_mask_t access_rights, const int flags)
 {
-	int err;
+	int err = 0;
+	struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_INODE,
 	};
@@ -378,7 +379,9 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	rule = landlock_insert_rule(ruleset, id, access_rights, flags);
+	if (IS_ERR(rule))
+		err = PTR_ERR(rule);
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 60894cff973e..f08be4be275a 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -23,11 +23,11 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			     const u16 port, access_mask_t access_rights,
 			     const int flags)
 {
-	int err;
 	const struct landlock_id id = {
 		.key.data = (__force uintptr_t)htons(port),
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
+	struct landlock_rule *rule;
 
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
@@ -36,10 +36,12 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			 ~landlock_get_net_access_mask(ruleset, 0);
 
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	rule = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 
-	return err;
+	if (IS_ERR(rule))
+		return PTR_ERR(rule);
+	return 0;
 }
 
 static int current_check_access_socket(struct socket *const sock,
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index f01c3e14e55d..48397ab43a2d 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -203,12 +203,13 @@ static void build_check_ruleset(void)
  * added to @ruleset as new constraints, similarly to a boolean AND between
  * access rights.
  *
- * Return: 0 on success, -errno on failure.
+ * Return: A pointer to the inserted or updated rule, or an ERR_PTR on failure.
  */
-static int insert_rule(struct landlock_ruleset *const ruleset,
-		       const struct landlock_id id,
-		       const struct landlock_layer (*layers)[],
-		       const size_t num_layers)
+static struct landlock_rule *
+insert_rule(struct landlock_ruleset *const ruleset,
+	    const struct landlock_id id,
+	    const struct landlock_layer (*layers)[],
+	    const size_t num_layers)
 {
 	struct rb_node **walker_node;
 	struct rb_node *parent_node = NULL;
@@ -218,14 +219,14 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 	might_sleep();
 	lockdep_assert_held(&ruleset->lock);
 	if (WARN_ON_ONCE(!layers))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	if (is_object_pointer(id.type) && WARN_ON_ONCE(!id.key.object))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	root = get_root(ruleset, id.type);
 	if (IS_ERR(root))
-		return PTR_ERR(root);
+		return ERR_CAST(root);
 
 	walker_node = &root->rb_node;
 	while (*walker_node) {
@@ -243,7 +244,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 
 		/* Only a single-level layer should match an existing rule. */
 		if (WARN_ON_ONCE(num_layers != 1))
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 
 		/* If there is a matching rule, updates it. */
 		if ((*layers)[0].level == 0) {
@@ -252,16 +253,16 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 			 * landlock_add_rule(2), i.e. @ruleset is not a domain.
 			 */
 			if (WARN_ON_ONCE(this->num_layers != 1))
-				return -EINVAL;
+				return ERR_PTR(-EINVAL);
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
-				return -EINVAL;
+				return ERR_PTR(-EINVAL);
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
-			return 0;
+			return this;
 		}
 
 		if (WARN_ON_ONCE(this->layers[0].level == 0))
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 
 		/*
 		 * Intersects access rights when it is a merge between a
@@ -270,23 +271,23 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 		new_rule = create_rule(id, &this->layers, this->num_layers,
 				       &(*layers)[0]);
 		if (IS_ERR(new_rule))
-			return PTR_ERR(new_rule);
+			return ERR_CAST(new_rule);
 		rb_replace_node(&this->node, &new_rule->node, root);
 		free_rule(this, id.type);
-		return 0;
+		return new_rule;
 	}
 
 	/* There is no match for @id. */
 	build_check_ruleset();
 	if (ruleset->num_rules >= LANDLOCK_MAX_NUM_RULES)
-		return -E2BIG;
+		return ERR_PTR(-E2BIG);
 	new_rule = create_rule(id, layers, num_layers, NULL);
 	if (IS_ERR(new_rule))
-		return PTR_ERR(new_rule);
+		return ERR_CAST(new_rule);
 	rb_link_node(&new_rule->node, parent_node, walker_node);
 	rb_insert_color(&new_rule->node, root);
 	ruleset->num_rules++;
-	return 0;
+	return new_rule;
 }
 
 static void build_check_layer(void)
@@ -305,9 +306,10 @@ static void build_check_layer(void)
 }
 
 /* @ruleset must be locked by the caller. */
-int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-			 const struct landlock_id id,
-			 const access_mask_t access, const int flags)
+struct landlock_rule *
+landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		     const struct landlock_id id,
+		     const access_mask_t access, const int flags)
 {
 	struct landlock_layer layers[] = { {
 		.access = access,
@@ -326,9 +328,8 @@ static int merge_tree(struct landlock_ruleset *const dst,
 		      struct landlock_ruleset *const src,
 		      const enum landlock_key_type key_type)
 {
-	struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_rule *walker_rule, *next_rule, *rule;
 	struct rb_root *src_root;
-	int err = 0;
 
 	might_sleep();
 	lockdep_assert_held(&dst->lock);
@@ -358,11 +359,11 @@ static int merge_tree(struct landlock_ruleset *const dst,
 		layers[0].access = walker_rule->layers[0].access;
 		layers[0].flags = walker_rule->layers[0].flags;
 
-		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
-		if (err)
-			return err;
+		rule = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
+		if (IS_ERR(rule))
+			return PTR_ERR(rule);
 	}
-	return err;
+	return 0;
 }
 
 static int merge_ruleset(struct landlock_ruleset *const dst,
@@ -412,9 +413,8 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 			struct landlock_ruleset *const child,
 			const enum landlock_key_type key_type)
 {
-	struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_rule *walker_rule, *next_rule, *rule;
 	struct rb_root *parent_root;
-	int err = 0;
 
 	might_sleep();
 	lockdep_assert_held(&parent->lock);
@@ -432,12 +432,12 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 			.type = key_type,
 		};
 
-		err = insert_rule(child, id, &walker_rule->layers,
-				  walker_rule->num_layers);
-		if (err)
-			return err;
+		rule = insert_rule(child, id, &walker_rule->layers,
+				   walker_rule->num_layers);
+		if (IS_ERR(rule))
+			return PTR_ERR(rule);
 	}
-	return err;
+	return 0;
 }
 
 static int inherit_ruleset(struct landlock_ruleset *const parent,
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index ff163e5db5f0..5b7f554e8442 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -217,9 +217,10 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
 
-int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-			 const struct landlock_id id,
-			 const access_mask_t access, const int flags);
+struct landlock_rule *
+landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		     const struct landlock_id id,
+		     const access_mask_t access, const int flags);
 
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
-- 
2.53.0

