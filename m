Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5437331218
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490821; cv=none; b=XRYGWdMQJ+a0g5gOf1eQGeSwd7iKpPAqil0yzl9PtcJlSjO9S8laG7nYhFlRE/RSUju45AInMGud7FPGRJavjwNLuaTcfSBNpvfOw1W4H3A3K9lvjQvaFlfoAWOJXgdyUkGHeZtKMXZ5ACCpQEhUpPMtC8uYbZd4rLtp+tiVwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490821; c=relaxed/simple;
	bh=/KAg4xPt1s6OvVcgI6FVPa68j9New2taGNjf7/n1dXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMWl+uHhDdv2BXD+7opxEQoTxf3Ci9goIF2oH9zKhE3vCBnzPVXOIxL8PhNAqR0R9SW6q37y1Eu7/SLrDloMigM+8ThTi7EDS0m5s4P7MwKm4dbU7ErVQ4aGld2GvH2Mv/jGnrDyqUg5OxTlkQooj8tiBMJn3HaKweBSdVHT0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Zgx/kqcF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1iHszHy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Zgx/kqcF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1iHszHy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B5C61D0002E;
	Mon,  6 Apr 2026 11:53:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 11:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775490817; x=
	1775577217; bh=4wfJFwTqLjVgibowv1gfVFlAn/um8P3Cr//pP/ZO8FM=; b=Z
	gx/kqcFikWgQxXQ5GCoqVmKKo52444HpSIIKxgGVZfG3zdEjPdpeBIv7BpgI7yhL
	83lzvCrrpTd1V3ndPPV9xjvO1mwSvijJEzilNCT8eFdTbvr12E3zE35MF9m7l840
	rnQh5zsPO3kl2B8NCjUn8fq0RuROk7cgxMtR+y2LKJnLFgztdkpGZoKanG3Lk6Ix
	pXua/D/rOOx8ejpZ7jmhBeP58de6A3SsTeouhH+zzbU4A+8ACUv2M5GO+x35CRZk
	4/9AClF+eQCWZCq+2HGcFqr/zkq2krvVROAmv+424kyuAeq/46OAoz5P37LMxTX8
	zQzDkUS12Mk0mAiNEtGug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775490817; x=1775577217; bh=4
	wfJFwTqLjVgibowv1gfVFlAn/um8P3Cr//pP/ZO8FM=; b=N1iHszHyl+s60FFwP
	1qvIM1U/Vk1dMsw8SecC18UBTlRAR52CJ6WtJcZ7lv6m4s5Y/0xeTRwCVeUKNyKd
	ZFOfKImxGjxTGb5Jkaul+uJ6K4Js2imZPqR0dLJyxNjydy8tDpVpFB0LjQs3Foo+
	4NMxK/4vXOSL+BslyeQ/e/ghmBbvdcbGinGvIpLgeNqLG5+kh9iQUNXCfFH+dtu2
	oYqLYycGOZ2lDiVfGkNHC6liRmuiwR6EeiC5xNOGsB7ladiVOatRUz8aZBaAQRrq
	8QiORs0Gv4/9by2VkIFAEcSEDx1YN50U9CmpeW1yumMMyhKmQ7xINzZoot0SGl4C
	rXTPQ==
X-ME-Sender: <xms:AdfTaXyaVrUZP4A3b01Bz-5Dz_UwQVAU2lKIOMrzFGEDZs_JtZBJ1w>
    <xme:AdfTaRgzyfUMnrOMwf2b8XUhh-AgoPEX85VH3VpeX2vJoVZdqxuiw5BJ5PpdW-wfz
    -JG3FTDjr0qrS-lI-ou6DBTGovkSV9xig_TRyXUYn9Abmg9qSdAc0NK>
X-ME-Received: <xmr:AdfTaTkt9j-DComeX6goqRMRSujm6HaFcI751LJNK-iDJ8sFKzM_RRKqKg9NCNRtP5yysW2EH8DAKO4B1LdcA7VDcp6cCj9BJLeUF7arUQ3Wb5zvGAS2Cl80lDnAKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AdfTaXjlrRVg2X0ZlzidFgTDt5vdDcUsKnDZvyJ44KFbWsd0CUPMtQ>
    <xmx:AdfTaX1YiVlKAsne0cH8Yy0xb7RzRTFmpkEl6eB1MrRmEtA9PW8z7A>
    <xmx:AdfTaQJbhNCkzS5tt8tC9wVLP7DsP2D8hW2tlfJElGO7yBnrvmLPvQ>
    <xmx:AdfTaXzn0MdQewOUMM_Aahlq8-BaThIeWInoWhSMUS8_ea_CKRpiPA>
    <xmx:AdfTaQMYPxdzNoPmGDWXNUd7q9Le6Tz_2VFcT8Fucec-0itm2phhrJ-N>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:36 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 6/9] selftests/landlock: add tests for quiet flag with fs rules
Date: Mon,  6 Apr 2026 16:52:19 +0100
Message-ID: <c253c347777c030303c09d3deb00335f8f79251e.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test various interactions of the quiet flag with filesystem rules:
- Non-optional access (tested with open and rename).
- Optional access (tested with truncate and ioctl).
- Behaviour around mounts matches with normal Landlock rules.
- Behaviour around disconnected directories matches with normal Landlock
  rules (test expected behaviour of 9a868cdbe66a ("landlock: Fix handling of
  disconnected directories") applied to the collected quiet flag).
- Multiple layers works as expected.

Assisted-by: GitHub Copilot:claude-opus-4.6 copilot-review
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v8:
- Rebase, resolve conflict, then clang-format
- Remove previously added comment about domain allocation record leakage -
  this is now documented properly by 239fd9a6f948 ("selftests/landlock:
  Drain stale audit records on init")
- Fix missing EXPECT_EQ on audit_count_records() return value

Changes in v6:
- Change quiet bool argument of add_path_beneath into a __u32 flags
  (suggested by Justin Suess)
- Rename quiet_behind_mountpoint_ignored_disconnected to
  quiet_behind_mountpoint_disconnected and fix test due to disconnected
  directory handling changes

Changes in v5:
- Add quiet_two_layers_different_handled_{1,2,3} variants.

Changes in v3:
- New patch

 tools/testing/selftests/landlock/fs_test.c | 2448 +++++++++++++++++++-
 1 file changed, 2439 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 10d9355ade5f..2e32295258f9 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -720,7 +720,7 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
 
 static void add_path_beneath(struct __test_metadata *const _metadata,
 			     const int ruleset_fd, const __u64 allowed_access,
-			     const char *const path)
+			     const char *const path, __u32 flags)
 {
 	struct landlock_path_beneath_attr path_beneath = {
 		.allowed_access = allowed_access,
@@ -733,7 +733,7 @@ static void add_path_beneath(struct __test_metadata *const _metadata,
 		       strerror(errno));
 	}
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				       &path_beneath, 0))
+				       &path_beneath, flags))
 	{
 		TH_LOG("Failed to update the ruleset with \"%s\": %s", path,
 		       strerror(errno));
@@ -780,7 +780,7 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 				continue;
 
 			add_path_beneath(_metadata, ruleset_fd, rules[i].access,
-					 rules[i].path);
+					 rules[i].path, 0);
 		}
 	return ruleset_fd;
 }
@@ -1310,7 +1310,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * ANDed with the previous ones.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			 dir_s1d2);
+			 dir_s1d2, 0);
 	/*
 	 * According to ruleset_fd, dir_s1d2 should now have the
 	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
@@ -1342,7 +1342,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * Try to get more privileges by adding new access rights to the parent
 	 * directory: dir_s1d1.
 	 */
-	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1);
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
@@ -1365,7 +1365,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * that there was no rule tied to it before.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			 dir_s1d3);
+			 dir_s1d3, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -1417,7 +1417,7 @@ TEST_F_FORK(layout1, inherit_superset)
 	add_path_beneath(_metadata, ruleset_fd,
 			 LANDLOCK_ACCESS_FS_READ_FILE |
 				 LANDLOCK_ACCESS_FS_READ_DIR,
-			 dir_s1d2);
+			 dir_s1d2, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -3970,7 +3970,7 @@ static int ioctl_error(struct __test_metadata *const _metadata, int fd,
 		       unsigned int cmd)
 {
 	char buf[128]; /* sufficiently large */
-	int res, stdinbak_fd;
+	int res, stdinbak_fd, err;
 
 	/*
 	 * Depending on the IOCTL command, parts of the zeroed-out buffer might
@@ -3985,13 +3985,14 @@ static int ioctl_error(struct __test_metadata *const _metadata, int fd,
 	/* Invokes the IOCTL with a zeroed-out buffer. */
 	bzero(&buf, sizeof(buf));
 	res = ioctl(fd, cmd, &buf);
+	err = errno;
 
 	/* Restores the old FD 0 and closes the backup FD. */
 	ASSERT_EQ(0, dup2(stdinbak_fd, 0));
 	ASSERT_EQ(0, close(stdinbak_fd));
 
 	if (res < 0)
-		return errno;
+		return err;
 
 	return 0;
 }
@@ -4789,6 +4790,7 @@ FIXTURE(layout1_bind) {};
 
 static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
 static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
+static const char bind_file2_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f2";
 
 /* Move targets for disconnected path tests. */
 static const char dir_s4d1[] = TMP_DIR "/s4d1";
@@ -7764,4 +7766,2432 @@ TEST_F(audit_layout1, mount)
 	EXPECT_EQ(1, records.domain);
 }
 
+static bool debug_quiet_tests;
+
+FIXTURE(audit_quiet_layout1)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(audit_quiet_layout1)
+{
+	prepare_layout(_metadata);
+	create_layout1(_metadata);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	if (getenv("DEBUG_QUIET_TESTS"))
+		debug_quiet_tests = true;
+}
+
+FIXTURE_TEARDOWN_PARENT(audit_quiet_layout1)
+{
+	remove_layout1(_metadata);
+	cleanup_layout(_metadata);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+struct a_rule {
+	const char *path;
+	__u64 access;
+	bool quiet;
+};
+
+struct a_layer {
+	__u64 handled_access_fs;
+	__u64 quiet_access_fs;
+	struct a_rule rules[6];
+	__u64 restrict_flags;
+};
+
+struct a_target {
+	/* File/dir to try open. */
+	const char *target;
+	/* Open mode (one of O_RDONLY, O_WRONLY, or O_RDWR). */
+	int open_mode;
+	/* Should open succeed? */
+	bool expect_open_success;
+	/* If open fails, whether to expect an audit log for read. */
+	bool audit_read_blocked;
+	/* If open fails, whether to expect an audit log for write. */
+	bool audit_write_blocked;
+	/* If ftruncate() is expected to be allowed. */
+	bool expect_truncate_success;
+	/* If ftruncate fails, whether to expect an audit log. */
+	bool audit_truncate;
+	/*
+	 * If ioctl() is expected to be allowed (ioctl not attempted if
+	 * neither this nor expect_ioctl_denied is set).
+	 */
+	bool expect_ioctl_allowed;
+	/* If ioctl() is expected to be denied. */
+	bool expect_ioctl_denied;
+	/* If ioctl fails, whether to expect an audit log. */
+	bool audit_ioctl;
+};
+
+#define AUDIT_QUIET_MAX_TARGETS 10
+
+FIXTURE_VARIANT(audit_quiet_layout1)
+{
+	struct a_layer layers[3];
+	struct a_target targets[AUDIT_QUIET_MAX_TARGETS];
+};
+
+#define FS_R LANDLOCK_ACCESS_FS_READ_FILE
+#define FS_W LANDLOCK_ACCESS_FS_WRITE_FILE
+#define FS_TRUNC LANDLOCK_ACCESS_FS_TRUNCATE
+#define FS_IOCTL LANDLOCK_ACCESS_FS_IOCTL_DEV
+
+static int sprint_access_bits(char *buf, size_t buflen, __u64 access)
+{
+	size_t offset = 0;
+
+	if (buflen < strlen("rwti make_reg remove_file refer") + 1)
+		abort();
+
+	buf[0] = '\0';
+	if (access & FS_R)
+		offset += snprintf(buf + offset, buflen - offset, "r");
+	if (access & FS_W)
+		offset += snprintf(buf + offset, buflen - offset, "w");
+	if (access & FS_TRUNC)
+		offset += snprintf(buf + offset, buflen - offset, "t");
+	if (access & FS_IOCTL)
+		offset += snprintf(buf + offset, buflen - offset, "i");
+	if (access & LANDLOCK_ACCESS_FS_MAKE_REG)
+		offset += snprintf(buf + offset, buflen - offset, ",make_reg");
+	if (access & LANDLOCK_ACCESS_FS_REMOVE_FILE)
+		offset +=
+			snprintf(buf + offset, buflen - offset, ",remove_file");
+	if (access & LANDLOCK_ACCESS_FS_REFER)
+		offset += snprintf(buf + offset, buflen - offset, ",refer");
+
+	if (buf[0] == ',') {
+		offset--;
+		memmove(buf, buf + 1, offset);
+		buf[offset] = '\0';
+	}
+
+	return offset;
+}
+
+static int apply_a_layer(struct __test_metadata *const _metadata,
+			 const struct a_layer *l)
+{
+	struct landlock_ruleset_attr rs_attr = {
+		.handled_access_fs = l->handled_access_fs,
+		.quiet_access_fs = l->quiet_access_fs,
+	};
+	int rs_fd;
+	int i;
+	const struct a_rule *r;
+	char handled_access_s[33], quiet_access_s[33], rule_access_s[33];
+
+	if (!l->handled_access_fs)
+		return 0;
+
+	rs_fd = landlock_create_ruleset(&rs_attr, sizeof(rs_attr), 0);
+	ASSERT_LE(0, rs_fd);
+
+	for (i = 0; i < ARRAY_SIZE(l->rules); i++) {
+		r = &l->rules[i];
+		if (!r->path)
+			continue;
+
+		add_path_beneath(_metadata, rs_fd, r->access, r->path,
+				 r->quiet ? LANDLOCK_ADD_RULE_QUIET : 0);
+	}
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(rs_fd, l->restrict_flags))
+	{
+		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
+	}
+	ASSERT_EQ(0, close(rs_fd));
+
+	if (debug_quiet_tests) {
+		sprint_access_bits(handled_access_s, sizeof(handled_access_s),
+				   l->handled_access_fs);
+		sprint_access_bits(quiet_access_s, sizeof(quiet_access_s),
+				   l->quiet_access_fs);
+		TH_LOG("applied layer: handled=%s quiet=%s restrict_flags=0x%llx",
+		       handled_access_s, quiet_access_s,
+		       (unsigned long long)l->restrict_flags);
+		for (i = 0; i < ARRAY_SIZE(l->rules); i++) {
+			r = &l->rules[i];
+			if (!r->path)
+				continue;
+
+			sprint_access_bits(rule_access_s, sizeof(rule_access_s),
+					   r->access);
+			TH_LOG("  rule[%d]: path=%s access=%s quiet=%d", i,
+			       r->path, rule_access_s, r->quiet);
+		}
+	}
+	return 0;
+}
+
+void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
+				   FIXTURE_DATA(audit_quiet_layout1) * self,
+				   const struct a_target *targets)
+{
+	struct audit_records records = {};
+	int i;
+	const struct a_target *target;
+	int fd = -1;
+	int open_mode;
+	int ret;
+	bool expect_audit;
+	const char *blocker;
+
+	for (i = 0; i < AUDIT_QUIET_MAX_TARGETS; i++) {
+		target = &targets[i];
+		if (!target->target)
+			continue;
+
+		open_mode = target->open_mode & (O_RDONLY | O_WRONLY | O_RDWR);
+
+		EXPECT_TRUE(open_mode == O_RDONLY || open_mode == O_WRONLY ||
+			    open_mode == O_RDWR);
+
+		if (target->expect_open_success) {
+			EXPECT_FALSE(target->audit_read_blocked);
+			EXPECT_FALSE(target->audit_write_blocked);
+		}
+		if (target->expect_truncate_success)
+			EXPECT_TRUE(target->expect_open_success &&
+				    !target->audit_truncate);
+
+		if (debug_quiet_tests)
+			TH_LOG("Try open \"%s\" with %s%s", target->target,
+			       open_mode != O_WRONLY ? "r" : "",
+			       open_mode != O_RDONLY ? "w" : "");
+
+		fd = openat(AT_FDCWD, target->target, open_mode | O_CLOEXEC);
+		if (target->expect_open_success) {
+			ASSERT_LE(0, fd)
+			{
+				TH_LOG("Failed to open \"%s\": %s",
+				       target->target, strerror(errno));
+			};
+		} else {
+			ASSERT_EQ(-1, fd);
+			ASSERT_EQ(EACCES, errno);
+		}
+
+		expect_audit = true;
+
+		if (target->audit_read_blocked && target->audit_write_blocked)
+			blocker = "fs\\.write_file,fs\\.read_file";
+		else if (target->audit_read_blocked)
+			blocker = "fs\\.read_file";
+		else if (target->audit_write_blocked)
+			blocker = "fs\\.write_file";
+		else
+			expect_audit = false;
+
+		if (expect_audit)
+			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+						    blocker, target->target));
+
+		/* Check that we see no (other) logs. */
+		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, records.access);
+
+		if (target->expect_open_success && fd >= 0) {
+			if (debug_quiet_tests)
+				TH_LOG("Try ftruncate \"%s\"", target->target);
+
+			ret = ftruncate(fd, 0);
+			if (target->expect_truncate_success) {
+				ASSERT_EQ(0, ret);
+			} else {
+				ASSERT_EQ(-1, ret);
+				if (open_mode != O_RDONLY)
+					ASSERT_EQ(EACCES, errno);
+			}
+
+			if (target->audit_truncate)
+				ASSERT_EQ(0, matches_log_fs(_metadata,
+							    self->audit_fd,
+							    "fs\\.truncate",
+							    target->target));
+
+			if (target->expect_ioctl_allowed ||
+			    target->expect_ioctl_denied) {
+				if (debug_quiet_tests)
+					TH_LOG("Try ioctl FIONREAD on \"%s\"",
+					       target->target);
+
+				ret = ioctl_error(_metadata, fd, FIONREAD);
+				if (target->expect_ioctl_allowed) {
+					ASSERT_NE(EACCES, ret);
+				} else {
+					ASSERT_EQ(EACCES, ret);
+				}
+			}
+
+			if (target->audit_ioctl)
+				ASSERT_EQ(0, matches_log_fs_extra(
+						     _metadata, self->audit_fd,
+						     "fs\\.ioctl_dev",
+						     target->target,
+						     " ioctlcmd=0x541b\\+"));
+
+			/* Check that we see no other logs. */
+			EXPECT_EQ(0, audit_count_records(self->audit_fd,
+							 &records));
+			ASSERT_EQ(0, records.access);
+			ASSERT_EQ(0, close(fd));
+		}
+	}
+}
+
+TEST_F(audit_quiet_layout1, base)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++)
+		ASSERT_EQ(0, apply_a_layer(_metadata, &variant->layers[i]));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant->targets);
+}
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_simple) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{ .path = dir_s1d1, .access = 0, .quiet = true },
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+		},
+		/* Not covered by quiet */
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		/* Access not quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.audit_write_blocked = true,
+		},
+		/*
+		 * Quiet flag only takes effect if all blocked access bits are
+		 * quieted, otherwise audit log emitted as normal (with all blockers)
+		 */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+			.audit_write_blocked = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_allow_read) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+			.quiet_access_fs = FS_W,
+			.rules = {
+				{ .path = dir_s1d1, .access = FS_R, .quiet = true },
+				/* Quiet flags inherit down and is not overridden */
+				{ .path = file1_s1d1, .access = FS_R, .quiet = false },
+				{ .path = file1_s2d3, .access = 0, .quiet = true },
+			},
+		},
+	},
+	.targets = {
+		/* Read ok */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+		},
+		/* Write quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+		},
+		/* Read allowed, write quieted so no audit */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+		},
+		/* Not covered by quiet */
+		{
+			.target = file1_s2d2,
+			.open_mode = O_WRONLY,
+			.audit_write_blocked = true,
+		},
+		{
+			.target = file1_s2d2,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+			.audit_write_blocked = true,
+		},
+		/* Single file quiet */
+		{
+			.target = file1_s2d3,
+			.open_mode = O_WRONLY,
+		},
+		/* Wrong file */
+		{
+			.target = file2_s2d3,
+			.open_mode = O_WRONLY,
+			.audit_write_blocked = true,
+		},
+		/* Access not quieted */
+		{
+			.target = file1_s2d3,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		/* Some access not quieted */
+		{
+			.target = file1_s2d3,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+			.audit_write_blocked = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_allow_write) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{ .path = dir_s1d1, .access = FS_W, .quiet = true },
+			},
+		},
+	},
+	.targets = {
+		/* Read quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+		},
+		/* Truncate not quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate = true,
+		},
+		/* Not covered by quiet */
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		/* Write allowed, read quieted so no audit */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, allow_write_quiet_trunc) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+			.quiet_access_fs = FS_TRUNC,
+			.rules = {
+				{ .path = dir_s1d1, .access = FS_W, .quiet = true },
+				{ .path = dir_s2d1, .access = FS_W, .quiet = false },
+			},
+		},
+	},
+	.targets = {
+		/* Read not allowed and not quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		/* Truncate quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+		},
+		/* Not covered by quiet (truncate) */
+		{
+			.target = file1_s2d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate = true,
+		},
+		/* Not covered by quiet (read/write) */
+		{
+			.target = file1_s3d1,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+			.audit_write_blocked = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, allow_rw_quiet_trunc) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+			.quiet_access_fs = FS_TRUNC,
+			.rules = {
+				{ .path = dir_s1d1, .access = FS_R | FS_W, .quiet = true },
+				{ .path = dir_s2d1, .access = FS_R | FS_W, .quiet = false },
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			.audit_truncate = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_all) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{ .path = dir_s1d1, .access = 0, .quiet = true },
+				{ .path = file1_s2d1, .access = FS_R | FS_W, .quiet = true },
+				{ .path = file1_s2d3, .access = 0, .quiet = true },
+				{ .path = dir_s3d1, .access = FS_W, .quiet = false },
+				{ .path = "/dev/zero", .access = FS_R, .quiet = false },
+				{ .path = "/dev/null", .access = FS_R, .quiet = true },
+			},
+		},
+	},
+	.targets = {
+		/* No logs */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+		},
+		/* Truncate quieted - no log */
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+		},
+		/* Truncate not covered by quiet */
+		{
+			.target = file1_s3d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate = true,
+		},
+		/* Not covered by quiet */
+		{
+			.target = file1_s3d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		/* Single file quiet */
+		{
+			.target = file1_s2d3,
+			.open_mode = O_RDWR,
+		},
+		/* Wrong file */
+		{
+			.target = file2_s2d3,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+			.audit_write_blocked = true,
+		},
+		/* Ioctl quieted */
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+		},
+		/* Ioctl not quieted */
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			.audit_ioctl = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_across_mountpoint) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{ .path = dir_s3d1, .access = 0, .quiet = true },
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s3d3,
+			.open_mode = O_RDONLY,
+		},
+		/* Not covered by quiet */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+			.audit_write_blocked = true,
+		},
+		/* Access not quieted */
+		{
+			.target = file1_s3d3,
+			.open_mode = O_WRONLY,
+			.audit_write_blocked = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, allow_all_quiet) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = true
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = true
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			.expect_truncate_success = true,
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_allowed = true,
+		},
+	},
+};
+
+/*
+ * With LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, it doesn't matter what
+ * the quiet flags below the layer says
+ */
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, subdomains_off) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R,
+			.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF,
+			.rules = {
+				{ .path = "/", .access = FS_R, .quiet = false },
+			}
+		},
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{ .path = dir_s1d1, .access = 0, .quiet = true },
+				{ .path = file1_s2d2, .access = FS_R | FS_W, .quiet = true },
+				{ .path = file1_s2d3, .access = FS_R | FS_W, .quiet = false },
+				{ .path = "/dev/null", .access = FS_R | FS_W, .quiet = true },
+				{ .path = "/dev/zero", .access = FS_R | FS_W, .quiet = false },
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDWR,
+		},
+		{
+			.target = file1_s2d2,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			/* No audit_truncate */
+		},
+		{
+			.target = file1_s2d3,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			/* No audit_truncate */
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			/* No audit_ioctl */
+		},
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			/* No audit_ioctl */
+		},
+	},
+};
+
+/*
+ * With LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF, it doesn't matter what
+ * the quiet flags on the layer says
+ */
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, same_exec_off) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R,
+			.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
+			.rules = {
+				{ .path = dir_s1d1, .access = 0, .quiet = true },
+				{ .path = file1_s2d2, .access = FS_R | FS_W, .quiet = true },
+				{ .path = file1_s2d3, .access = FS_R | FS_W, .quiet = false },
+				{ .path = "/dev/null", .access = FS_R | FS_W, .quiet = true },
+				{ .path = "/dev/zero", .access = FS_R | FS_W, .quiet = false },
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDWR,
+		},
+		{
+			.target = file1_s2d2,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			/* No audit_truncate */
+		},
+		{
+			.target = file1_s2d3,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			/* No audit_truncate */
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			/* No audit_ioctl */
+		},
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			/* No audit_ioctl */
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_1) {
+	/* Here, rules that deny access is always quiet. */
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R,
+					.quiet = true,
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = false,
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = false,
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R,
+					.quiet = true,
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+		},
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_2) {
+	/* Here, rules that deny access is never quiet. */
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_W,
+					.quiet = false
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = true
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R,
+					.quiet = false
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = true
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = true
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_W,
+					.quiet = false
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = true
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R,
+					.quiet = false
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate	= true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate	= true,
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			.audit_ioctl = true,
+		},
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			.audit_ioctl = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_3) {
+	/* This time only the second layer quiets things. */
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_W,
+					.quiet = false,
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = false,
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = false,
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R,
+					.quiet = true,
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate = true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+			.audit_ioctl = true,
+		},
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_different_quiet_access) {
+	/* Here, rules that deny access is always quiet. */
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R,
+					.quiet = true,
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = false,
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+			.quiet_access_fs = FS_IOCTL,
+			.rules = {
+				{
+					.path = dir_s1d1,
+					.access = FS_R | FS_W | FS_TRUNC,
+					.quiet = false,
+				},
+				{
+					.path = dir_s2d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = "/dev/null",
+					.access = FS_R | FS_W | FS_IOCTL,
+					.quiet = false,
+				},
+				{
+					.path = "/dev/zero",
+					.access = FS_R,
+					.quiet = true,
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+		},
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+		{
+			.target = file1_s2d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.audit_truncate	= true,
+		},
+		{
+			.target = "/dev/null",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+		},
+		{
+			.target = "/dev/zero",
+			.open_mode = O_RDONLY,
+			.expect_open_success = true,
+			.expect_ioctl_denied = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_different_handled_1) {
+	/* Quiet from layer 1 */
+	.layers = {
+		{
+			.handled_access_fs = FS_R,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{
+					.path = file1_s1d1,
+					.access = FS_R,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d1,
+					.access = 0,
+					.quiet = true,
+				},
+				{
+					.path = file1_s1d2,
+					.access = 0,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d2,
+					.access = FS_R,
+					.quiet = true,
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_W,
+			.quiet_access_fs = FS_W,
+			.rules = {
+				{
+					.path = file1_s1d1,
+					.access = FS_W,
+					.quiet = false,
+				},
+				/* Nothing for file2_s1d1 */
+				{
+					.path = file1_s1d2,
+					.access = FS_W,
+					.quiet = false,
+				},
+				/* Nothing for file2_s1d2 */
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			.expect_truncate_success = true,
+		},
+		/* Missing both, youngest layer denies write, not quiet */
+		{
+			.target = file2_s1d1,
+			.open_mode = O_RDWR,
+			.audit_write_blocked = true,
+		},
+		/* Missing read, denied and quieted by layer 1 */
+		{
+			.target = file1_s1d2,
+			.open_mode = O_RDWR,
+		},
+		/* Missing write, denied and not quieted by layer 2 */
+		{
+			.target = file2_s1d2,
+			.open_mode = O_RDWR,
+			.audit_write_blocked = true,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_different_handled_2) {
+	/* Quiet from layer 2 */
+	.layers = {
+		{
+			.handled_access_fs = FS_R,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{
+					.path = file1_s1d1,
+					.access = FS_R,
+					.quiet = false,
+				},
+				/* Nothing for file2_s1d1 and file1_s1d2 */
+				{
+					.path = file2_s1d2,
+					.access = FS_R,
+					.quiet = false,
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_W,
+			.quiet_access_fs = FS_W,
+			.rules = {
+				{
+					.path = file1_s1d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d1,
+					.access = 0,
+					.quiet = true,
+				},
+				{
+					.path = file1_s1d2,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d2,
+					.access = 0,
+					.quiet = true,
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			.expect_truncate_success = true,
+		},
+		/* Missing both, youngest layer denies write, quiet */
+		{
+			.target = file2_s1d1,
+			.open_mode = O_RDWR,
+		},
+		/* Missing read, denied and not quieted by layer 1 */
+		{
+			.target = file1_s1d2,
+			.open_mode = O_RDWR,
+			.audit_read_blocked = true,
+		},
+		/* Missing write, denied and quieted by layer 2 */
+		{
+			.target = file2_s1d2,
+			.open_mode = O_RDWR,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, quiet_two_layers_different_handled_3) {
+	/* Quiet from both layers */
+	.layers = {
+		{
+			.handled_access_fs = FS_R,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{
+					.path = file1_s1d1,
+					.access = FS_R,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d1,
+					.access = 0,
+					.quiet = true,
+				},
+				{
+					.path = file1_s1d2,
+					.access = 0,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d2,
+					.access = FS_R,
+					.quiet = true,
+				},
+			},
+		},
+		{
+			.handled_access_fs = FS_W,
+			.quiet_access_fs = FS_W,
+			.rules = {
+				{
+					.path = file1_s1d1,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d1,
+					.access = 0,
+					.quiet = true,
+				},
+				{
+					.path = file1_s1d2,
+					.access = FS_W,
+					.quiet = true,
+				},
+				{
+					.path = file2_s1d2,
+					.access = 0,
+					.quiet = true,
+				},
+			},
+		},
+	},
+	.targets = {
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+			.expect_open_success = true,
+			.expect_truncate_success = true,
+		},
+		{
+			.target = file2_s1d1,
+			.open_mode = O_RDWR,
+		},
+		{
+			.target = file1_s1d2,
+			.open_mode = O_RDWR,
+		},
+		{
+			.target = file2_s1d2,
+			.open_mode = O_RDWR,
+		},
+	},
+};
+
+FIXTURE_VARIANT_ADD(audit_quiet_layout1, without_quiet_then_with_quiet) {
+	.layers = {
+		{
+			.handled_access_fs = FS_R | FS_W,
+			.quiet_access_fs = FS_R,
+			.rules = {
+				{ .path = dir_s1d1, .access = FS_W, .quiet = false },
+				{ .path = dir_s1d1, .access = 0, .quiet = true },
+			},
+		},
+	},
+	.targets = {
+		/* Read denied and quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDONLY,
+		},
+		/* Write ok */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_WRONLY,
+			.expect_open_success = true,
+			.expect_truncate_success = true,
+		},
+		/* Write ok, read denied and quieted */
+		{
+			.target = file1_s1d1,
+			.open_mode = O_RDWR,
+		},
+		/* Not covered by quiet */
+		{
+			.target = file1_s2d1,
+			.open_mode = O_RDONLY,
+			.audit_read_blocked = true,
+		},
+	},
+};
+
+/*
+ * The following TEST_F extend the above test cases to test more layers,
+ * with the inserted layers having varying configurations.
+ */
+
+/* Extra allow all layers, quiet or not, does not change any behaviour. */
+TEST_F(audit_quiet_layout1, allow_all_layer)
+{
+	struct a_layer allow_all_layer = {
+		.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+		.quiet_access_fs = 0,
+		.rules = {
+			{
+				.path = "/",
+				.access = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+				.quiet = false,
+			},
+		},
+	};
+	int i;
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &allow_all_layer));
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++)
+		ASSERT_EQ(0, apply_a_layer(_metadata, &variant->layers[i]));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant->targets);
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &allow_all_layer));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant->targets);
+
+	/*
+	 * SELF_LOG flags or quiet bits from inner allowing layers should not
+	 * affect behaviour.
+	 */
+	allow_all_layer.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL;
+	allow_all_layer.rules[0].quiet = true;
+	/*
+	 * Note: this only works because we're not checking counts of domain
+	 * alloc/dealloc logs
+	 */
+	allow_all_layer.restrict_flags =
+		LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+		LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF;
+	ASSERT_EQ(0, apply_a_layer(_metadata, &allow_all_layer));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant->targets);
+}
+
+/*
+ * Add useless outer layers until we reach the layer limit.  Should not
+ * change anything.
+ */
+TEST_F(audit_quiet_layout1, many_outer_layers)
+{
+	struct a_layer useless_layer = {
+		.handled_access_fs = FS_R | FS_W | FS_TRUNC,
+		.quiet_access_fs = FS_R | FS_W | FS_TRUNC,
+		.rules = {
+			{ .path = "/", .access = FS_R | FS_W | FS_TRUNC, .quiet = true },
+		},
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++) {
+		if (variant->layers[i].handled_access_fs == 0)
+			break;
+	}
+
+	for (; i < LANDLOCK_MAX_NUM_LAYERS; i++)
+		ASSERT_EQ(0, apply_a_layer(_metadata, &useless_layer));
+
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++)
+		ASSERT_EQ(0, apply_a_layer(_metadata, &variant->layers[i]));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant->targets);
+}
+
+/*
+ * An inner layer that denies and quiets everything should result in no
+ * logs.
+ */
+TEST_F(audit_quiet_layout1, deny_all_quiet_layer)
+{
+	struct a_layer deny_all_layer = {
+		.handled_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+		.quiet_access_fs = FS_R | FS_W | FS_TRUNC | FS_IOCTL,
+		.rules = {
+			{ .path = "/", .access = 0, .quiet = true },
+		},
+	};
+	int i;
+	FIXTURE_VARIANT(audit_quiet_layout1) variant_2 = {};
+
+	/* Any open should fail with no logs. */
+	for (i = 0; i < ARRAY_SIZE(variant->targets); i++) {
+		const struct a_target *target = &variant->targets[i];
+
+		variant_2.targets[i] = (struct a_target){
+			.target = target->target,
+			.open_mode = target->open_mode,
+			/* We denied everything, open should always fail. */
+			.expect_open_success = false,
+		};
+	}
+
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++)
+		ASSERT_EQ(0, apply_a_layer(_metadata, &variant->layers[i]));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &deny_all_layer));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant_2.targets);
+}
+
+/*
+ * An inner layer that denies everything without quiet should produce logs
+ * for all access.
+ */
+TEST_F(audit_quiet_layout1, deny_all_layer)
+{
+	struct a_layer deny_all_layer = {
+		.handled_access_fs = FS_R | FS_W,
+		.quiet_access_fs = FS_R | FS_W,
+	};
+	int i;
+	FIXTURE_VARIANT(audit_quiet_layout1) variant_2 = {};
+	bool test_has_subdomains_off = false;
+
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++) {
+		if (variant->layers[i].restrict_flags &
+		    LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF) {
+			test_has_subdomains_off = true;
+			break;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(variant->targets); i++) {
+		const struct a_target *target = &variant->targets[i];
+
+		variant_2.targets[i] = (struct a_target){
+			.target = target->target,
+			.open_mode = target->open_mode,
+
+			/* We denied everything, open should always fail. */
+			.expect_open_success = false,
+			/* Audit should always happen as long as open request contains read. */
+			.audit_read_blocked = !test_has_subdomains_off &&
+					      target->open_mode != O_WRONLY,
+			/* Audit should always happen as long as open request contains write. */
+			.audit_write_blocked = !test_has_subdomains_off &&
+					       target->open_mode != O_RDONLY,
+		};
+	}
+
+	for (i = 0; i < ARRAY_SIZE(variant->layers); i++)
+		ASSERT_EQ(0, apply_a_layer(_metadata, &variant->layers[i]));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &deny_all_layer));
+
+	audit_quiet_layout1_test_body(_metadata, self, variant_2.targets);
+}
+
+/* Uses layout1_bind hierarchy */
+FIXTURE(audit_quiet_rename)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(audit_quiet_rename)
+{
+	prepare_layout(_metadata);
+	create_layout1(_metadata);
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(dir_s1d2, dir_s2d2, NULL, MS_BIND, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	if (getenv("DEBUG_QUIET_TESTS"))
+		debug_quiet_tests = true;
+}
+
+FIXTURE_TEARDOWN_PARENT(audit_quiet_rename)
+{
+	remove_layout1(_metadata);
+	cleanup_layout(_metadata);
+
+	/* umount(dir_s2d2)) is handled by namespace lifetime. */
+
+	remove_path(file1_s4d1);
+	remove_path(file2_s4d1);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+static void simple_quiet_rename(struct __test_metadata *const _metadata,
+				FIXTURE_DATA(audit_quiet_rename) *const self,
+				__u64 handled_access, __u64 quiet_access,
+				bool source_allow, bool dest_allow,
+				bool source_quiet, bool dest_quiet,
+				const char *source_blockers,
+				const char *dest_blockers)
+{
+	/* We will move file1_s1d1 to file1_s2d1 */
+	struct a_layer layer = {
+		.handled_access_fs = handled_access,
+		.quiet_access_fs = quiet_access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = source_allow ? handled_access : 0,
+				.quiet = source_quiet,
+			},
+			{
+				.path = dir_s2d1,
+				.access = dest_allow ? handled_access : 0,
+				.quiet = dest_quiet,
+			},
+		},
+	};
+	struct audit_records records = {};
+	int ret, err;
+
+	/* Skip landlock_add_rule for useless rules. */
+	if (!source_allow && !source_quiet)
+		layer.rules[0].path = NULL;
+	if (!dest_allow && !dest_quiet)
+		layer.rules[1].path = NULL;
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+	EXPECT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	if (debug_quiet_tests)
+		TH_LOG("Try renameat \"%s\" to \"%s\"", file1_s1d1, file1_s2d1);
+	ret = renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1);
+	err = errno;
+	if (ret != 0 && debug_quiet_tests) {
+		TH_LOG("renameat error: %s", err == EXDEV  ? "EXDEV" :
+					     err == EACCES ? "EACCES" :
+							     strerror(err));
+	}
+	if (source_allow && dest_allow) {
+		ASSERT_EQ(0, ret);
+	} else {
+		ASSERT_EQ(-1, ret);
+		if (handled_access & (LANDLOCK_ACCESS_FS_MAKE_REG |
+				      LANDLOCK_ACCESS_FS_REMOVE_FILE)) {
+			ASSERT_EQ(EACCES, err);
+		} else {
+			ASSERT_EQ(EXDEV, err);
+		}
+
+		if (source_blockers)
+			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+						    source_blockers, dir_s1d1));
+		if (dest_blockers)
+			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+						    dest_blockers, dir_s2d1));
+	}
+	/*
+	 * No other logs. records.domain not checked per reasoning in
+	 * audit_quiet_layout1_test_body.
+	 */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, rename_ok)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, true, true, false,
+			    false, NULL, NULL);
+}
+
+TEST_F(audit_quiet_rename, no_quiet)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, false, false,
+			    false, false, "fs\\.remove_file,fs\\.refer",
+			    "fs\\.make_reg,fs\\.refer");
+}
+
+TEST_F(audit_quiet_rename, quiet)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, false, false, true,
+			    true, NULL, NULL);
+}
+
+TEST_F(audit_quiet_rename, source_no_quiet_dest_quiet)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, false, false,
+			    false, true, "fs\\.remove_file,fs\\.refer", NULL);
+}
+
+TEST_F(audit_quiet_rename, source_quiet_dest_no_quiet)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, false, false, true,
+			    false, NULL, "fs\\.make_reg,fs\\.refer");
+}
+
+TEST_F(audit_quiet_rename, only_quiet_refer)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, LANDLOCK_ACCESS_FS_REFER,
+			    false, false, true, true,
+			    "fs\\.remove_file,fs\\.refer",
+			    "fs\\.make_reg,fs\\.refer");
+}
+
+TEST_F(audit_quiet_rename, source_allow_dest_quiet)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, true, false, false,
+			    true, NULL, NULL);
+}
+
+TEST_F(audit_quiet_rename, source_quiet_dest_allow)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+
+	simple_quiet_rename(_metadata, self, access, access, false, true, true,
+			    false, NULL, NULL);
+}
+
+TEST_F(audit_quiet_rename, handle_all_deny_quiet_refer)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_REFER,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* No logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = 0,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				.quiet = false,
+			},
+			{
+				.path = dir_s2d1,
+				.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				.quiet = false,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s1d1));
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s2d1));
+
+	/* No other logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_REFER,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				.quiet = false,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s2d1));
+
+	/* No other logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_same_dir)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = file1_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = file1_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
+	/* We didn't unlink destination file */
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
+				    dir_s2d1));
+
+	/* No other logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = file1_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = file2_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0,
+		  matches_log_fs(_metadata, self->audit_fd,
+				 "fs\\.remove_file,fs\\.make_reg", dir_s1d1));
+
+	/* No other logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, two_layers_different_quiet1)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer1 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = access,
+				.quiet = false,
+			},
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct a_layer layer2 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_REFER,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = access,
+				.quiet = false,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * The youngest denial will be layer 2.  Refer is quieted but we are
+	 * also missing remove_file on source.
+	 */
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
+	/* No other logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, two_layers_different_quiet2)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer1 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = access,
+				.quiet = false,
+			},
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct a_layer layer2 = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_REFER,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_REFER,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = LANDLOCK_ACCESS_FS_REFER,
+				.quiet = false,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * The youngest denial will be layer 2, but refer is quieted (and that
+	 * layer does not handle any other accesses).
+	 */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, two_layers_different_quiet3)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer1 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = access,
+				.quiet = false,
+			},
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct a_layer layer2 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = access,
+				.quiet = false,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * The youngest denial will be layer 2, in which everything is
+	 * quieted.
+	 */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename,
+       first_layer_quiet_deny_all_second_layer_not_quiet_deny_all)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer1 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct a_layer layer2 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
+	/* No other logs. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename,
+       first_layer_quiet_deny_all_second_layer_dest_not_quiet)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer1 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct a_layer layer2 = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file1_s2d1));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer1));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Source is quieted but destination is not.
+	 */
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
+	/* No other logs. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, rename_xchg)
+{
+	struct a_layer layer = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				     LANDLOCK_ACCESS_FS_REFER,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG,
+		.rules = { {
+				   .path = dir_s1d1,
+				   .access = LANDLOCK_ACCESS_FS_REMOVE_FILE |
+					     LANDLOCK_ACCESS_FS_REFER,
+				   .quiet = true,
+			   },
+			   {
+				   .path = dir_s2d1,
+				   .access = LANDLOCK_ACCESS_FS_MAKE_REG |
+					     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+					     LANDLOCK_ACCESS_FS_REFER,
+				   .quiet = false,
+			   } },
+	};
+	struct audit_records records = {};
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_on_parent_mount)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file2_s1d3));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, bind_file1_s1d3, AT_FDCWD,
+			       bind_file2_s1d3));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s1d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+
+	EXPECT_EQ(0, unlink(file2_s1d3));
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1, renameat(AT_FDCWD, bind_file1_s1d3, AT_FDCWD,
+			       bind_file2_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.make_reg",
+				    bind_dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s2d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+	int bind_s1d3_fd;
+
+	EXPECT_EQ(0, unlink(file2_s1d3));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_DIRECTORY);
+	ASSERT_GE(bind_s1d3_fd, 0);
+
+	/* Make s1d3 disconnected. */
+	create_directory(_metadata, dir_s4d1);
+	ASSERT_EQ(0, renameat(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s4d2));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1,
+		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
+TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
+{
+	__u64 access = LANDLOCK_ACCESS_FS_MAKE_REG |
+		       LANDLOCK_ACCESS_FS_REMOVE_FILE |
+		       LANDLOCK_ACCESS_FS_REFER;
+	struct a_layer layer = {
+		.handled_access_fs = access,
+		.quiet_access_fs = access,
+		.rules = {
+			{
+				.path = dir_s4d1,
+				.access = 0,
+				.quiet = true,
+			},
+		},
+	};
+	struct audit_records records = {};
+	int bind_s1d3_fd;
+
+	EXPECT_EQ(0, unlink(file2_s1d3));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_DIRECTORY);
+	ASSERT_GE(bind_s1d3_fd, 0);
+
+	/* Make s1d3 disconnected. */
+	create_directory(_metadata, dir_s4d1);
+	ASSERT_EQ(0, renameat(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s4d2));
+
+	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
+
+	ASSERT_EQ(-1,
+		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, records.access);
+}
+
 TEST_HARNESS_MAIN
-- 
2.53.0
