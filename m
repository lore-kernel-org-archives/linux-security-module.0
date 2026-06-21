Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075612D21B
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013966; cv=none; b=uVqlS0E8aqLVMwNrFZxUSejmJcR9cSXPIdfFlJDVN2rSMHSqsCmyH/dZWn9K+NCw1XKTnOyOuvzWX8vz7ykyBch17xPdhS6pVTT2xw9MiFSRyy3NEURC92pmp9g4B3RNykMhePDPMxul6rRkgKUzjPh/17/KNPJocr5nQndUPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013966; c=relaxed/simple;
	bh=565KumZg6mtB6NvXi9IE+Cq57A6dQ7dpoXNU+aldVu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FobadHj13bgXOAha6Kc55KF9GnUSYc89/Ovldtbj/g7q6ppO389Y9MH2CIISSNQ+QLrkYSLWOf7r7CzqI5YLwUKsBcev2/u8i4wgS2+iXMDN/cIzJOLQzS3k/IBAm8rCTnC3BwHRaAi2B3jL6GTUPqTmAo53Y/0DiLwBEmmYAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5kF2696; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5kF2696"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8000e21f014so33029397b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013964; x=1782618764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSK8SbDI25+g3+Tmex+C3BNm94pUBeAVJpwbLIe2bdM=;
        b=p5kF2696T6Id4zrdsxTf9j7MXth3LOc9fIoX/v9VNU0Kj+El4a3s400vGlM8uhj9Fe
         zazez3/VhlBIaRIURm/QtnGpXxcDPkSsO0e9/wQyoUy8h8fdTDJGMM/kkAmuuTpCesXN
         DX8+edzJeuj7ekvlIxW1KXS0/ggAzwQqQysVM8gDisMGPgNBCAXYEDRaetjnIs0+4R7c
         HZk7z/5jBMkxGdxzxSjQbnqtJ9RgQS4sehYSHwu70+yhd3akKRa0d38i0pMRaqE4oT4E
         OtGu/Z97/vGuS/+y3YYgaWAUV4OhmZfCLVwgVf2X+jW7Iy/tbABHVG19BKxX0glow+sg
         nUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013964; x=1782618764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSK8SbDI25+g3+Tmex+C3BNm94pUBeAVJpwbLIe2bdM=;
        b=h2e7P+xIMKyEmRHLpJnSCieAivWg9rEqOPEnP7SnZpOZHDKSSHLhhpbjVYf/Lr8+ob
         PdYtOrc6Q9WaU+eZoya+PMNq2Y+ll5Dl5U3W/J+qo31NwgQt0qaUSX1jyXlymQVIgusI
         9BfA6dlAbD4y/eJg5tK8hnIFcSDy8fN6kgz7mg9CDuutsFaSXSZOGE6IPIJCRxCoXmey
         Um+EC1W9aGCKQNeha5xEnYmM1NYDmQ9i+TqqPVFospGQ8qJz6jR5+a0KFulNqBwO8muf
         CbNda+O1HLsH1UTZNRvsNFZEy1r95vrWsbSZlW6lWVdcVR6M5EjaL1Z8wPLRtLyI5Dhd
         mnuw==
X-Gm-Message-State: AOJu0YyWJBXWqojoZei4hioh/YNwxDtvDe1Ynk6aSttw0y5O/ROBo3dC
	LUj0eYmZB+gedDDj/5Ij6CSXsCu0qJx/Iv0/uXHKc3YdYJXjFcKdCD7kbXguhQ==
X-Gm-Gg: AfdE7clx3LVQvjiTz1WQSdG1z9RAkAjn5vn06Jm5ZROQ65REC0YBD/uhLtvEwZUG9/y
	rrk5s0v3DyD8Fvh920lCC2H+zowFZ2h6qOVsOq5BTkFcvlDSB5yTi+BKz3/a+xCiVcOlT/B2lcf
	pY7uoaGPg6D9Zg4ZSAxZNgDh8GPPB1EBlj3iz4KW3kpfLgPYadl9bfUqOGENgFhCXu+6zi3oPaQ
	7eErmGpxDOqkN7Z6sxdOI3leTqOZbpOkVQmorJ/SaInhqvNGxfEq74zsDEyJdV6pgeilE8eNXth
	KIBK28PxKF5wxy2mXAwnjIjVApSlnHsJy6ivbPt+YV9iK1PVrtV7fscsToZwTGoMSTleC/Q9XzS
	9UAY21oV6cdgD9h0Z7oNHuNtvU/JcwhKFq1gFHI4GxggWrDHmCcbcxGZlq/q6Vt0BVcBErSDFoC
	MPaHUpzcWHIiPyUZ7g9L189dZvKC8BBjTSE9gRuX0b/6hDzQ==
X-Received: by 2002:a05:690c:7103:b0:7f8:7e11:d0d8 with SMTP id 00721157ae682-801393f64fdmr105513617b3.51.1782013963876;
        Sat, 20 Jun 2026 20:52:43 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:43 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 8/9] selftests/landlock: Add selftests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat, 20 Jun 2026 23:52:21 -0400
Message-ID: <20260621035223.2651547-9-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test coverage for the new flag:

- New layout1_no_inherit fixture with five variants covering NO_INHERIT
  on leaf, middle, and root directories, RW-over-RO expansion, and a
  regular file target.  Three tests per variant exercise inheritance
  blocking, topology sealing (reparenting and same-directory rename,
  hard-link of a sealed file, and removal), and layered (multi-domain)
  NO_INHERIT.

- A new layout4_disconnected_leafs variant exercising NO_INHERIT applied
  through a bind mount, asserting that ancestors in both the bind and
  source paths are sealed.

- A new audit_no_inherit fixture verifying that the flag interacts
  correctly with the quiet flag: a quiet ancestor does not suppress
  audit on a descendant that has crossed a NO_INHERIT boundary.

- Two rejection tests in base_test, modeled on the equivalent quiet
  flag tests: useless_no_inherit_rule_fs checks that NO_INHERIT is
  rejected on a ruleset that handles no filesystem access, and
  no_inherit_rule_net checks that NO_INHERIT (a filesystem-only flag) is
  rejected on a network rule.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Added two base_test rejection tests: useless_no_inherit_rule_fs
      (NO_INHERIT on a ruleset handling no filesystem access -> EINVAL) and
      no_inherit_rule_net (NO_INHERIT on a network rule -> EINVAL).
    - blocks_inheritance now also asserts a same-directory rename and a hard
      link of a sealed file are denied with EACCES, and unconditionally
      expects unlink of the target to fail; added ni_samedir/ni_link fields
      to the layout1_no_inherit variants.
    - seals_topology (layered) now handles LANDLOCK_ACCESS_FS_REFER in both
      rulesets via a shared handled mask.
    - Dropped the redundant parent_is_logged variant from the
      audit_no_inherit fixture.
    - Rebased onto mic/next.

 tools/testing/selftests/landlock/base_test.c |  58 +++
 tools/testing/selftests/landlock/fs_test.c   | 425 +++++++++++++++++++
 2 files changed, 483 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index b8b5fa1042ba..f4435d9a92a8 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -584,6 +584,64 @@ TEST(useless_quiet_rule_net)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(useless_no_inherit_rule_fs)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = 0,
+	};
+	int ruleset_fd, root_fd;
+
+	drop_caps(_metadata);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	root_fd = open("/", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, root_fd);
+	path_beneath_attr.parent_fd = root_fd;
+
+	/*
+	 * A seal is only ever consulted for a domain that handles some
+	 * filesystem access, so a no-inherit rule on a ruleset with no handled
+	 * filesystem access would be silently inert.
+	 */
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath_attr,
+					LANDLOCK_ADD_RULE_NO_INHERIT));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(0, close(root_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST(no_inherit_rule_net)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	struct landlock_net_port_attr net_port_attr = {
+		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.port = 1024,
+	};
+	int ruleset_fd;
+
+	drop_caps(_metadata);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* LANDLOCK_ADD_RULE_NO_INHERIT is a filesystem-only flag. */
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					&net_port_attr,
+					LANDLOCK_ADD_RULE_NO_INHERIT));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
 TEST(invalid_quiet_bits_1)
 {
 	const struct landlock_ruleset_attr ruleset_attr_fs = {
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 86e08aa6e0a7..e5d4fa6a169a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1429,6 +1429,238 @@ TEST_F_FORK(layout1, inherit_superset)
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
+FIXTURE(layout1_no_inherit) {};
+
+FIXTURE_SETUP(layout1_no_inherit)
+{
+	prepare_layout(_metadata);
+	create_layout1(_metadata);
+}
+
+FIXTURE_TEARDOWN_PARENT(layout1_no_inherit)
+{
+	remove_layout1(_metadata);
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(layout1_no_inherit)
+{
+	const char *ni_path;
+	const __u64 ni_access;
+	const char *ni_file;
+	const char *desc_file;
+	/* Sibling of ni_path within the same parent, for same-dir rename. */
+	const char *ni_samedir;
+	/* Hard-link target for a sealed file (NULL when ni_path is a dir). */
+	const char *ni_link;
+	const int expected_ni_write;
+	const int expected_ni_read;
+	const int expected_desc_write;
+	const int expected_desc_read;
+};
+
+/* NO_INHERIT on leaf directory: blocks parent's RW, grants only RO. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout1_no_inherit, rw_parent_ro_leaf) {
+	/* clang-format on */
+	.ni_path = TMP_DIR "/s1d1/s1d2/s1d3",
+	.ni_access = ACCESS_RO,
+	.ni_file = TMP_DIR "/s1d1/s1d2/s1d3/f1",
+	.desc_file = TMP_DIR "/s1d1/s1d2/s1d3/f2",
+	.ni_samedir = TMP_DIR "/s1d1/s1d2/s1d3_renamed",
+	.expected_ni_write = EACCES,
+	.expected_ni_read = 0,
+	.expected_desc_write = EACCES,
+	.expected_desc_read = 0,
+};
+
+/* NO_INHERIT on middle directory: blocks parent's RW for all descendants. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout1_no_inherit, rw_parent_ro_middle) {
+	/* clang-format on */
+	.ni_path = TMP_DIR "/s1d1/s1d2",
+	.ni_access = ACCESS_RO,
+	.ni_file = TMP_DIR "/s1d1/s1d2/f1",
+	.desc_file = TMP_DIR "/s1d1/s1d2/s1d3/f1",
+	.ni_samedir = TMP_DIR "/s1d1/s1d2_renamed",
+	.expected_ni_write = EACCES,
+	.expected_ni_read = 0,
+	.expected_desc_write = EACCES,
+	.expected_desc_read = 0,
+};
+
+/* NO_INHERIT on root directory: blocks parent's RW for entire subtree. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout1_no_inherit, rw_parent_ro_root) {
+	/* clang-format on */
+	.ni_path = TMP_DIR "/s1d1",
+	.ni_access = ACCESS_RO,
+	.ni_file = TMP_DIR "/s1d1/f1",
+	.desc_file = TMP_DIR "/s1d1/s1d2/s1d3/f1",
+	.ni_samedir = TMP_DIR "/s1d1_renamed",
+	.expected_ni_write = EACCES,
+	.expected_ni_read = 0,
+	.expected_desc_write = EACCES,
+	.expected_desc_read = 0,
+};
+
+/* NO_INHERIT with RW access expands parent's RO to RW. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout1_no_inherit, ro_parent_rw_middle) {
+	/* clang-format on */
+	.ni_path = TMP_DIR "/s1d1/s1d2",
+	.ni_access = ACCESS_RW,
+	.ni_file = TMP_DIR "/s1d1/s1d2/f1",
+	.desc_file = TMP_DIR "/s1d1/s1d2/s1d3/f1",
+	.ni_samedir = TMP_DIR "/s1d1/s1d2_renamed",
+	.expected_ni_write = 0,
+	.expected_ni_read = 0,
+	.expected_desc_write = 0,
+	.expected_desc_read = 0,
+};
+
+/* NO_INHERIT on a file: file gets only its explicit READ_FILE access. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout1_no_inherit, rw_parent_read_file) {
+	/* clang-format on */
+	.ni_path = TMP_DIR "/s1d1/s1d2/f1",
+	.ni_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	.ni_file = TMP_DIR "/s1d1/s1d2/f1",
+	.desc_file = TMP_DIR "/s1d1/s1d2/f2",
+	.ni_samedir = TMP_DIR "/s1d1/s1d2/f1_renamed",
+	.ni_link = TMP_DIR "/s1d1/s1d2/f1_link",
+	.expected_ni_write = EACCES,
+	.expected_ni_read = 0,
+	.expected_desc_write = 0,
+	.expected_desc_read = 0,
+};
+
+TEST_F_FORK(layout1_no_inherit, blocks_inheritance)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW,
+	};
+	int ruleset_fd;
+
+	/* RO variants: TMP_DIR gets RO instead of RW. */
+	if (variant->ni_access == ACCESS_RW)
+		ruleset_attr.handled_access_fs |= LANDLOCK_ACCESS_FS_READ_DIR;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	if (variant->ni_access == ACCESS_RW)
+		add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, TMP_DIR, 0);
+	else
+		add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, TMP_DIR, 0);
+
+	add_path_beneath(_metadata, ruleset_fd, variant->ni_access,
+			 variant->ni_path, LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(variant->expected_ni_write,
+		  test_open(variant->ni_file, O_WRONLY));
+	EXPECT_EQ(variant->expected_ni_read,
+		  test_open(variant->ni_file, O_RDONLY));
+
+	if (strcmp(variant->desc_file, variant->ni_file) != 0) {
+		EXPECT_EQ(variant->expected_desc_write,
+			  test_open(variant->desc_file, O_WRONLY));
+		EXPECT_EQ(variant->expected_desc_read,
+			  test_open(variant->desc_file, O_RDONLY));
+	}
+}
+
+TEST_F_FORK(layout1_no_inherit, seals_topology)
+{
+	int ruleset_fd;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				     LANDLOCK_ACCESS_FS_REMOVE_DIR,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 TMP_DIR, 0);
+	add_path_beneath(_metadata, ruleset_fd, variant->ni_access,
+			 variant->ni_path, LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The directory bearing NO_INHERIT cannot be renamed or removed. */
+	ASSERT_EQ(-1, rename(variant->ni_path, TMP_DIR "/ni_renamed"));
+	ASSERT_EQ(EACCES, errno);
+
+	/* A same-directory rename (no REFER needed) is also denied. */
+	ASSERT_EQ(-1, rename(variant->ni_path, variant->ni_samedir));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Hard-linking a sealed file is denied (dirs can't be linked). */
+	if (variant->ni_link) {
+		ASSERT_EQ(-1, link(variant->ni_path, variant->ni_link));
+		ASSERT_EQ(EACCES, errno);
+	}
+
+	/*
+	 * Removal is not granted by any variant's NO_INHERIT access, so
+	 * unlinking content inside the sealed directory is denied.
+	 */
+	ASSERT_EQ(-1, unlink(variant->ni_file));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Unrelated operations outside the sealed branch still work. */
+	ASSERT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, mknod(file1_s2d1, S_IFREG | 0700, 0));
+}
+
+TEST_F_FORK(layout1_no_inherit, layered_no_inherit)
+{
+	const __u64 handled = ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE |
+			      LANDLOCK_ACCESS_FS_REFER;
+	const struct rule layer_rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = handled,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	/* Layer 1: RW + REFER on TMP_DIR. */
+	ruleset_fd = create_ruleset(_metadata, handled, layer_rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Layer 2: NO_INHERIT on the target. */
+	ruleset_fd = create_ruleset(_metadata, handled, layer_rules);
+	ASSERT_LE(0, ruleset_fd);
+	add_path_beneath(_metadata, ruleset_fd, variant->ni_access,
+			 variant->ni_path, LANDLOCK_ADD_RULE_NO_INHERIT);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, rename(variant->ni_path, TMP_DIR "/ni_renamed_layered"));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Content at NI path respects the NO_INHERIT access from layer 2. */
+	EXPECT_EQ(variant->expected_ni_write,
+		  test_open(variant->ni_file, O_WRONLY));
+	EXPECT_EQ(variant->expected_ni_read,
+		  test_open(variant->ni_file, O_RDONLY));
+}
+
 TEST_F_FORK(layout0, max_layers)
 {
 	int i, err;
@@ -5571,6 +5803,25 @@ FIXTURE_VARIANT(layout4_disconnected_leafs)
 	const int expected_exchange_result;
 	/* Expected result of the call to renameat([fd:s1d42]/f4, [fd:s1d42]/f5). */
 	const int expected_same_dir_rename_result;
+
+	/*
+	 * If true, a NO_INHERIT rule is set on s1d41 (via the bind mount
+	 * at s2d2).  Used by the no_inherit_mount test.
+	 */
+	bool no_inherit_on_s1d41;
+	/*
+	 * Access rights used for the optional NO_INHERIT rule on s1d41.
+	 */
+	const __u64 no_inherit_access;
+	/*
+	 * Expected result of renaming s1d31 (parent of s1d41 within the
+	 * mount) when no_inherit_on_s1d41 is set.
+	 */
+	const int expected_parent_rename;
+	/*
+	 * Expected result of rmdir on s1d31, when no_inherit_on_s1d41 is set.
+	 */
+	const int expected_parent_rmdir;
 };
 
 /* clang-format off */
@@ -5823,6 +6074,26 @@ FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, f1_f2_f3) {
 	.expected_exchange_result = EACCES,
 };
 
+/*
+ * NO_INHERIT variant: s1d41 is protected with ACCESS_RO via the bind mount.
+ * Parents within the mount are sealed against topology changes.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, no_inherit_mount) {
+	/* clang-format on */
+	.allowed_f1 = LANDLOCK_ACCESS_FS_READ_FILE,
+	.allowed_f2 = LANDLOCK_ACCESS_FS_READ_FILE,
+	.allowed_f3 = LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.no_inherit_on_s1d41 = true,
+	.no_inherit_access = ACCESS_RO,
+	.expected_parent_rename = EACCES,
+	.expected_parent_rmdir = EACCES,
+};
+
 TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
 {
 	const __u64 handled_access =
@@ -5931,6 +6202,70 @@ TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
 		  test_renameat(s1d42_bind_fd, "f4", s1d42_bind_fd, "f5"));
 }
 
+/*
+ * When s1d41 (accessed via the bind mount at s2d2) is protected with
+ * NO_INHERIT, its parent directories within the mount are sealed from
+ * topology changes.  Other variants do not exercise NO_INHERIT and skip
+ * this test.
+ */
+TEST_F_FORK(layout4_disconnected_leafs, no_inherit_seals_mount)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				     LANDLOCK_ACCESS_FS_REMOVE_DIR,
+	};
+	int ruleset_fd, s1d41_bind_fd;
+
+	if (!variant->no_inherit_on_s1d41)
+		SKIP(return, "variant does not set NO_INHERIT on s1d41");
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 TMP_DIR, 0);
+
+	s1d41_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d41_bind_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &(struct landlock_path_beneath_attr){
+					       .parent_fd = s1d41_bind_fd,
+					       .allowed_access =
+						       variant->no_inherit_access,
+				       },
+				       LANDLOCK_ADD_RULE_NO_INHERIT));
+	EXPECT_EQ(0, close(s1d41_bind_fd));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Parent of s1d41 within the mount is sealed. */
+	ASSERT_EQ(-1, rmdir(TMP_DIR "/s2d1/s2d2/s1d31"));
+	ASSERT_EQ(variant->expected_parent_rmdir, errno);
+
+	ASSERT_EQ(-1, rename(TMP_DIR "/s2d1/s2d2/s1d31",
+			     TMP_DIR "/s2d1/s2d2/s1d31_renamed"));
+	ASSERT_EQ(variant->expected_parent_rename, errno);
+
+	/* Sibling directories outside the sealed chain are free. */
+	ASSERT_EQ(0, rename(TMP_DIR "/s2d1/s2d2/s1d32",
+			    TMP_DIR "/s2d1/s2d2/s1d32_renamed"));
+	ASSERT_EQ(0, rename(TMP_DIR "/s2d1/s2d2/s1d32_renamed",
+			    TMP_DIR "/s2d1/s2d2/s1d32"));
+
+	/* The mount source parent hierarchy is also sealed. */
+	ASSERT_EQ(-1, rename(TMP_DIR "/s1d1/s1d2/s1d31",
+			     TMP_DIR "/s1d1/s1d2/s1d31_renamed"));
+	ASSERT_EQ(variant->expected_parent_rename, errno);
+}
+
 /*
  * layout5_disconnected_branch before rename:
  *
@@ -7358,6 +7693,96 @@ TEST_F(audit_layout1, write_file)
 	EXPECT_EQ(1, records.domain);
 }
 
+FIXTURE(audit_no_inherit)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(audit_no_inherit)
+{
+	prepare_layout(_metadata);
+	create_layout1(_metadata);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN_PARENT(audit_no_inherit)
+{
+	remove_layout1(_metadata);
+	cleanup_layout(_metadata);
+
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+}
+
+FIXTURE_VARIANT(audit_no_inherit)
+{
+	bool parent_quiet;
+	const char *test_path;
+	bool expect_audit_log;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_no_inherit, blocks_quiet_inheritance) {
+	/* clang-format on */
+	.parent_quiet = true,
+	.test_path = TMP_DIR "/s1d1/s1d2/s1d3/f1",
+	.expect_audit_log = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_no_inherit, quiet_parent) {
+	/* clang-format on */
+	.parent_quiet = true,
+	.test_path = TMP_DIR "/s1d1/f1",
+	.expect_audit_log = false,
+};
+
+TEST_F(audit_no_inherit, no_inherit_audit)
+{
+	struct audit_records records;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW,
+		.quiet_access_fs = variant->parent_quiet ? ACCESS_RW : 0,
+	};
+	int ruleset_fd;
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+					     sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	if (variant->parent_quiet)
+		add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d1,
+				 LANDLOCK_ADD_RULE_QUIET);
+	else
+		add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d1, 0);
+
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d3,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	EXPECT_EQ(EACCES, test_open(variant->test_path, O_WRONLY));
+	if (variant->expect_audit_log) {
+		EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+					    "fs\\.write_file",
+					    variant->test_path));
+	} else {
+		EXPECT_NE(0, matches_log_fs(_metadata, self->audit_fd,
+					    "fs\\.write_file",
+					    variant->test_path));
+	}
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(variant->expect_audit_log ? 1 : 0, records.domain);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_F(audit_layout1, read_file)
 {
 	struct audit_records records;
-- 
2.54.0

