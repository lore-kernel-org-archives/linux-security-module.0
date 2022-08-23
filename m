Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D140BC32796
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Aug 2022 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbiHWQkA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbiHWQjZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Aug 2022 12:39:25 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E739033E00
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 07:41:42 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MBsPJ4YsRzMq0HF;
        Tue, 23 Aug 2022 16:41:40 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MBsPJ2JW6zlh8Tk;
        Tue, 23 Aug 2022 16:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661265700;
        bh=VrSklp/986tvOpkc92OuHVLjqoqDvWm+CaBM4hIsiDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gDS/7E34ZSyeSwAUuOPhgLgLrWU8TRUI5SwilXj8qIu4NkqP5MeXHVC/xOzbn61JF
         qQmYS6F+5F79id7GI7ysQl3zAGlvWMmJJiXkWoMa/Iz/zHzDGXhs8j/ZkRK3/LNwl3
         v7Co2MMmc/pPCTB80F1+kIHFTQwM3olntJWDY2Co=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1] landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFER
Date:   Tue, 23 Aug 2022 16:41:23 +0200
Message-Id: <20220823144123.633721-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
globally denied-by-default access right.  Indeed, this lifted an initial
Landlock limitation to rename and link files, which was initially always
denied when the source or the destination were different directories.

This led to an inconsistent backward compatibility behavior which was
only taken into account if no domain layer were using the new
LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers are
using the first and the second Landlock ABI (i.e.
LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if all
domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
implicitely allowing such right.  Indeed, the not-handled access rights
were allowed, which should not be the case for LANDLOCK_ACCESS_FS_REFER.
It should be noted that this bug only allowed safe renames or links, but
no privilege escalation because the LANDLOCK_ACCESS_FS_REFER properties
were still enforced (e.g. only allowed to move a file according to all
other access rights, and if it doesn't give more Landlock accesses).

This change adds an ACCESS_INITIALLY_DENIED list of denied-by-default
rights, which (only) contains LANDLOCK_ACCESS_FS_REFER.  All domains are
treated as if they are also handling this list, but without modifying
their fs_access_masks field, which enables correct domain audit.

A side effect is that the errno code returned by rename(2) or link(2)
*may* be changed from EXDEV to EACCES according to the enforced
restrictions.  Indeed, we now have the mechanic to identify if an access
is denied because of a required right (e.g. LANDLOCK_ACCESS_FS_MAKE_REG,
LANDLOCK_ACCESS_FS_REMOVE_FILE) or if it is denied because of missing
LANDLOCK_ACCESS_FS_REFER rights.  This may result in different errno
codes than for the initial Landlock version, but this approach is better
for rename/link compatibility reasons, and it wasn't possible before
(hence no backport to ABI v1).  The layout1.rename_file test reflects
this change.

Add the layout1.refer_denied_by_default* tests to check that the
behavior of a ruleset not handling LANDLOCK_ACCESS_FS_REFER (ABI v1) is
unchanged even if another layer handles LANDLOCK_ACCESS_FS_REFER (i.e.
ABI v1 precedence).  Make sure rule's absolute access rights are correct
by testing with and without a matching path.

Extend layout1.inval tests to check that a denied-by-default access
right is not necessarily part of a domain's handled access rights.

Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220823144123.633721-1-mic@digikod.net
---
 security/landlock/fs.c                     |  28 +++--
 tools/testing/selftests/landlock/fs_test.c | 133 +++++++++++++++++++--
 2 files changed, 143 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ec5a6247cd3e..0cf484e89f68 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -149,6 +149,15 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_READ_FILE)
 /* clang-format on */
 
+/*
+ * All access rights that are denied by default whether they are handled or not
+ * by a ruleset/layer.
+ */
+/* clang-format off */
+#define ACCESS_INITIALLY_DENIED ( \
+	LANDLOCK_ACCESS_FS_REFER)
+/* clang-format on */
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -167,7 +176,9 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return -EINVAL;
 
 	/* Transforms relative access rights to absolute ones. */
-	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~ruleset->fs_access_masks[0];
+	access_rights |=
+		LANDLOCK_MASK_ACCESS_FS &
+		~(ruleset->fs_access_masks[0] | ACCESS_INITIALLY_DENIED);
 	object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(object))
 		return PTR_ERR(object);
@@ -277,7 +288,7 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
 static inline access_mask_t
 get_handled_accesses(const struct landlock_ruleset *const domain)
 {
-	access_mask_t access_dom = 0;
+	access_mask_t access_dom = ACCESS_INITIALLY_DENIED;
 	unsigned long access_bit;
 
 	for (access_bit = 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
@@ -316,8 +327,13 @@ init_layer_masks(const struct landlock_ruleset *const domain,
 
 		for_each_set_bit(access_bit, &access_req,
 				 ARRAY_SIZE(*layer_masks)) {
-			if (domain->fs_access_masks[layer_level] &
-			    BIT_ULL(access_bit)) {
+			/*
+			 * Artificially handles all initially denied by default
+			 * access rights.
+			 */
+			if (BIT_ULL(access_bit) &
+			    (domain->fs_access_masks[layer_level] |
+			     ACCESS_INITIALLY_DENIED)) {
 				(*layer_masks)[access_bit] |=
 					BIT_ULL(layer_level);
 				handled_accesses |= BIT_ULL(access_bit);
@@ -857,10 +873,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 					      NULL, NULL);
 	}
 
-	/* Backward compatibility: no reparenting support. */
-	if (!(get_handled_accesses(dom) & LANDLOCK_ACCESS_FS_REFER))
-		return -EXDEV;
-
 	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
 	access_request_parent2 |= LANDLOCK_ACCESS_FS_REFER;
 
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..2c134a9202a1 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4,7 +4,7 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2020 ANSSI
- * Copyright © 2020-2021 Microsoft Corporation
+ * Copyright © 2020-2022 Microsoft Corporation
  */
 
 #define _GNU_SOURCE
@@ -371,6 +371,13 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
 
+	/* Tests with denied-by-default access right. */
+	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_REFER;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath, 0));
+	ASSERT_EQ(EINVAL, errno);
+	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_REFER;
+
 	/* Test with unknown (64-bits) value. */
 	path_beneath.allowed_access |= (1ULL << 60);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
@@ -1867,10 +1874,10 @@ TEST_F_FORK(layout1, rename_file)
 	 * to a different directory (which allows file removal).
 	 */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EXDEV, errno);
@@ -1894,7 +1901,7 @@ TEST_F_FORK(layout1, rename_file)
 	ASSERT_EQ(EXDEV, errno);
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(EACCES, errno);
 
 	/* Exchanges and renames files with same parent. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
@@ -2014,6 +2021,107 @@ TEST_F_FORK(layout1, reparent_refer)
 	ASSERT_EQ(0, rename(dir_s1d3, dir_s2d3));
 }
 
+/* Checks renames beneath dir_s1d1. */
+static void refer_denied_by_default(struct __test_metadata *const _metadata,
+				    const struct rule layer1_abi_v2[],
+				    const struct rule layer2_abi_v1[])
+{
+	int ruleset_fd;
+
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	/*
+	 * First layer, which handles LANDLOCK_ACCESS_FS_REFER, can allow some
+	 * different-parent renames and links.
+	 */
+	ruleset_fd = create_ruleset(_metadata, layer1_abi_v2[0].access,
+				    layer1_abi_v2);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that legitimate renames are allowed. */
+	ASSERT_EQ(0, rename(file1_s1d1, file1_s1d2));
+	ASSERT_EQ(0, rename(file1_s1d2, file1_s1d1));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d2,
+			       RENAME_EXCHANGE));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s1d2, AT_FDCWD, file2_s1d1,
+			       RENAME_EXCHANGE));
+
+	/*
+	 * Second layer, which does not handle LANDLOCK_ACCESS_FS_REFER, denies
+	 * any different-parent renames and links, thus making the first layer
+	 * null and void.
+	 */
+	ruleset_fd = create_ruleset(_metadata, layer2_abi_v1[0].access,
+				    layer2_abi_v1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that all renames are now denied. */
+	ASSERT_EQ(-1, rename(file1_s1d1, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d2, AT_FDCWD, file2_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EXDEV, errno);
+}
+
+/*
+ * Tests precedence over renames: denied by default for different parent
+ * directories, *with* a rule matching a parent directory, but not directly
+ * denying access (with MAKE_REG nor REMOVE).
+ */
+TEST_F_FORK(layout1, refer_denied_by_default1)
+{
+	const struct rule layer1_abi_v2[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{},
+	};
+	const struct rule layer2_abi_v1[] = {
+		{
+			/* Matches a parent directory. */
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{},
+	};
+
+	refer_denied_by_default(_metadata, layer1_abi_v2, layer2_abi_v1);
+}
+
+/*
+ * Tests precedence over renames: denied by default for different parent
+ * directories, *without* a rule matching a parent directory, but not directly
+ * denying access (with MAKE_REG nor REMOVE).
+ */
+TEST_F_FORK(layout1, refer_denied_by_default2)
+{
+	const struct rule layer1_abi_v2[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{},
+	};
+	const struct rule layer2_abi_v1[] = {
+		{
+			/* Does not match a parent directory. */
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{},
+	};
+
+	refer_denied_by_default(_metadata, layer1_abi_v2, layer2_abi_v1);
+}
+
 TEST_F_FORK(layout1, reparent_link)
 {
 	const struct rule layer1[] = {
@@ -2336,11 +2444,12 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
 	ASSERT_EQ(EXDEV, errno);
 
 	/*
-	 * However, moving the file2_s1d3 file below dir_s2d3 is allowed
-	 * because it cannot inherit MAKE_REG nor MAKE_DIR rights (which are
-	 * dedicated to directories).
+	 * Moving the file2_s1d3 file below dir_s2d3 is denied because the
+	 * second layer does not handle REFER, which is always denied by
+	 * default.
 	 */
-	ASSERT_EQ(0, rename(file2_s1d3, file1_s2d3));
+	ASSERT_EQ(-1, rename(file2_s1d3, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
@@ -2373,8 +2482,12 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
 	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
 	ASSERT_EQ(EXDEV, errno);
-	/* Modify layout! */
-	ASSERT_EQ(0, rename(file2_s1d2, file1_s2d3));
+	/*
+	 * Modifying the layout is now denied because the second layer does not
+	 * handle REFER, which is always denied by default.
+	 */
+	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
 
 	/* Without REFER source, EACCES wins over EXDEV. */
 	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));

base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
-- 
2.37.2

