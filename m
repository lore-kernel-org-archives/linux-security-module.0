Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C4369D4C
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019565; cv=none; b=Q7T00NSvEpz818xNGLzRTqBqIBWXEx73xe/bhI1NPpziNKfHryoZqHT7Enbv7CGoliYJOGBcZZo2XVgiDfdOOW/HY75KX4qgMPB/Exv2+KJPi6V8pQNRf/D/+0pc/DaXt1xeZCB3Kzta/pDl1cTdqGBp6Ys8kIWwfGkbZvRJu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019565; c=relaxed/simple;
	bh=PxWTSJcZjWDmMHYkUewv0UtXCB9psPHTCWUWYSPymSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOs70UeXfl1LekI7peEjJBxWXf3+tB/DR7wyLDNzO7oC3uUwC3ZLfuYSK3f4oSOf4htQDhwI1XbuJTN2VzgJw7ug136hHdD4GU3viTU2X1CSJ27xNPTBD0NeWRDzLqA62i1wBzHswHBdiCsYCaHLP/4H3HtuzgOvsnteIoXw+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtW4s2YP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtW4s2YP"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dbcb505578so21161057b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019562; x=1780624362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c98JrFKnAAYycYa6ckPFwB8uVY2q85M51B8MtK4Ddo=;
        b=DtW4s2YP/jd9/sXcaZDEXsXkDyj105PMoDzO5sqvzcr4VDaE7RhVrn8oloCGZyXSvL
         qVJbw8+oBfeNhcX+tc1X8lBivY+KSZ6SgmKoCdOaA6pJNfJUkYGTiJodWByWBbTXPHGa
         /ZjZ879nhbTJ0o7X83DZFH+ucSF7YjxAWc1jIVt5AUTpUTex246ghOjZEbLieryMw+03
         8Q5KiHoYJu45OpE/LZj8IeJrvXD6ws5sYjjt/SYbbvvI/P5rCwL1abSFpGA7F+Zj49qm
         EnPQke6R0xcAjWKmz6zgxnwVQbuTue1qIm+kJlF10UjajM6RsPk5E7oc7grTwXZT8XOE
         6hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019562; x=1780624362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3c98JrFKnAAYycYa6ckPFwB8uVY2q85M51B8MtK4Ddo=;
        b=WBsFUJjAupjwAPE2BayemGBQEmU+v5EiiEg9kt3NXHwcch5dYUa7+SYbSFRrYHjJPs
         14fuvtxif4ifb61o4c5gqvBDJse1Hc0/9xs8Q0ei5hUb3JTeMmBzxe+UZwqxGCWvlRsM
         Oq2dO3i9MUFb+5wez52NrNysCH7Xs7+Uy+Cj4mn9HTx+2QSqVk41vkRGDqjOoAQZDl+u
         CdaPouRzWl0zI6tXnNElVaEMwmlfyH51YhX+TH8CTMASNj6Xpm6fEECoX5FenCLS4Tom
         3TsE576q2C2W8kD7m/xtD9lBeO+iLD0TbQkd80AczS62k/JuU239jTnZCd+i30d5OMGc
         U3GA==
X-Forwarded-Encrypted: i=1; AFNElJ9Jwt3p1FH9S73W6qMsjvZVJgieK+N4OMRvDRYXK8Krb1E3sQz4j6HVhHk5DAVRudg3+O+XKaT36ooiV2+Xe0hYErh8J10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWYA1fTmG3Ah/6oKnOz4Xndg4U3TuNQ2IHs5b592XYmvnMdDV
	uS8thfy6DbqmA8UmiuLKhtPxuer3T88WJkr8zz5Qz2qYbfYD29Nm7fg/
X-Gm-Gg: Acq92OGbO9QLAF2CX4IkZnkTvQ0JMv3iF8E0C3gWsEtjIWm/UROp+I8tvP17y+/cgqm
	HXuMfIv4yoL4RYsjYSC5t52S6i+wjN0h76AA7zO7UMPhANFlxwCdMRE4gNOhyiHlt6ghZL+zdOz
	6qf7/D0IZH+k+qUErIdeBAD31KomcyLPcRjadkA67ps2wSuSi36ncFSTBCvRnWMd2CC8DjV35cL
	090z2nv+a2LiGnAVwQ2wxU/mV3GOLJ+rEt0FLJbGJ5iRI+yBunFcboYeP72dE3DBSn8EScUYTFm
	WKYdnvQnDyEtvrR+L9wD80IUokGcZc/IzC6HDie6MNG/ZyO0l6c6DkPYmslCiFzKWRhayM5YJ9l
	9qDfXgaFgOk6OPxzgw2AHTbbDxVszmi8z+RQkIPbjpxvi0JRNWEh9hmxiE6FdgZXO9lRKFnCfz5
	QbMGyxsgsukSUnln1Xr0LZDLoYSFxG4+BgMWV5hgvTTiyCqsuxIzivlI6y07wxE6jDMa1Zm/2IL
	CxF7ftb3B0=
X-Received: by 2002:a05:690c:7307:b0:7bd:7d69:7660 with SMTP id 00721157ae682-7de47e26cb6mr6564497b3.43.1780019562356;
        Thu, 28 May 2026 18:52:42 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:41 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 09/10] selftests/landlock: Add selftests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 28 May 2026 21:52:08 -0400
Message-ID: <20260529015210.500291-10-utilityemal77@gmail.com>
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

Add test coverage for the new flag:

- New layout1_no_inherit fixture with five variants covering NO_INHERIT
  on leaf, middle, and root directories, RW-over-RO expansion, and a
  regular file target.  Three tests per variant exercise inheritance
  blocking, topology sealing, and layered (multi-domain) NO_INHERIT.

- A new layout4_disconnected_leafs variant exercising NO_INHERIT applied
  through a bind mount, asserting that ancestors in both the bind and
  source paths are sealed.

- A new audit_no_inherit fixture verifying that the flag interacts
  correctly with the quiet flag: a quiet ancestor does not suppress
  audit on a descendant that has crossed a NO_INHERIT boundary.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Reorganized the new fs_test.c coverage around fixtures and
        variants instead of one TEST_F_FORK per scenario:
    
        - New layout1_no_inherit fixture with five FIXTURE_VARIANT_ADD
          cases (rw_parent_ro_leaf, rw_parent_ro_middle, rw_parent_ro_root,
          ro_parent_rw_middle, rw_parent_read_file) collapse what were
          eight near-duplicate layout1 tests in v7 into three shared
          tests (blocks_inheritance, seals_topology, layered_no_inherit).
    
        - New layout4_disconnected_leafs variant 'no_inherit_mount' with a
          single 'no_inherit_seals_mount' test replaces the four
          v7 layout4 tests (no_inherit_mount_parent_{rename,rmdir,link}
          and no_inherit_source_parent_rename) by exercising all four
          sealed topology operations in one test.
    
        - New audit_no_inherit fixture with three variants
          (parent_is_logged, blocks_quiet_inheritance, quiet_parent)
          covers the quiet/no_inherit interaction previously inlined
          into an ad hoc audit test.
    
      * Net change: 705 added lines in v7 -> 419 added lines in v8, with
        equivalent coverage.

 tools/testing/selftests/landlock/fs_test.c | 419 +++++++++++++++++++++
 1 file changed, 419 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 2e32295258f9..625ff1afecb0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1429,6 +1429,224 @@ TEST_F_FORK(layout1, inherit_superset)
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
+	if (variant->desc_file != variant->ni_file) {
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
+	/*
+	 * Content inside the NO_INHERIT directory is still mutable
+	 * (if the access rights permit it).
+	 */
+	if (variant->ni_access & LANDLOCK_ACCESS_FS_REMOVE_FILE) {
+		ASSERT_EQ(0, unlink(variant->ni_file));
+	} else {
+		ASSERT_EQ(-1, unlink(variant->ni_file));
+	}
+
+	/* Unrelated operations outside the sealed branch still work. */
+	ASSERT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, mknod(file1_s2d1, S_IFREG | 0700, 0));
+}
+
+TEST_F_FORK(layout1_no_inherit, layered_no_inherit)
+{
+	const struct rule layer_rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	/* Layer 1: RW on TMP_DIR. */
+	ruleset_fd = create_ruleset(_metadata,
+				    ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    layer_rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Layer 2: NO_INHERIT on the target. */
+	ruleset_fd = create_ruleset(_metadata,
+				    ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    layer_rules);
+	ASSERT_LE(0, ruleset_fd);
+	add_path_beneath(_metadata, ruleset_fd, variant->ni_access,
+			 variant->ni_path, LANDLOCK_ADD_RULE_NO_INHERIT);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The target path cannot be renamed. */
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
@@ -5571,6 +5789,25 @@ FIXTURE_VARIANT(layout4_disconnected_leafs)
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
@@ -5823,6 +6060,26 @@ FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, f1_f2_f3) {
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
@@ -5931,6 +6188,70 @@ TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
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
@@ -7358,6 +7679,104 @@ TEST_F(audit_layout1, write_file)
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
+FIXTURE_VARIANT_ADD(audit_no_inherit, parent_is_logged) {
+	/* clang-format on */
+	.parent_quiet = false,
+	.test_path = TMP_DIR "/s1d1/s1d2/f1",
+	.expect_audit_log = true,
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
2.53.0

