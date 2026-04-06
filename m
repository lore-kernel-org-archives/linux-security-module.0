Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C6329C6D
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490815; cv=none; b=S3Gh5ZyaiWTXgxJrzX6Y7guMQPhsS04SCZAJbTUHijAEFFV9KoVh6JE3mnwIIJ//2hzomSJbwzWwBuzsNQJy/jhoHtrDzpEO7jQk185gY7BKNhELC6QE1Y2B+sviI9J3Gb2zuz4fRlznM6AdURsU0cbg46x/otnUJ89FhBfIRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490815; c=relaxed/simple;
	bh=t0X1FDXDd63pjrS20qZwfUVs/uAOVDHi5475GcpIYHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHOwtWa6hrmn+GzwWzGiTmGzDG1j+25bDznbFXm/Kbkvqq80had3IwW/MzjOaU4k+FLw85eN8//wLDzWO7yn9isDVbKxaPF5xnUsEfRwMbpiWd1NtjjrEDv1MNpyAb374hz+Ah/Nc1/7mm1w/4pYb0X+f+9WIFI1MQDMVop2Jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=d4Q9oovz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+80Q4Hx; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="d4Q9oovz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+80Q4Hx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 334A37A01FA;
	Mon,  6 Apr 2026 11:53:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 11:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775490813;
	 x=1775577213; bh=yvu8CvGnqqvg27Xag+8WFVVXU5crIK8JVS92CyNjEoE=; b=
	d4Q9oovz6OiA3YgdgxWsX73dIbDlXwgPebPRUO8v8soo0QFMC5KbBY6X54CSEF8k
	7wCr47mR0cUBFNyQnuK+Mp3aGT0xrlM54nyM9q81YnJKNa2WiGzvpSPnw4UCiy4H
	L/ABdtIF+d5bOoAkLV303BXtmauL8RqnefiDYFSzdgx1THav0xwxZBEKaC/YAndX
	7SLugO3a3t3zo2CWQi+4zIJ0HB4BfRZ0VncEfQQDJbSE8/tkFj58QK35EeiXIylD
	pt5GaPr8BpweJKxkbu/n8rCFt7oSsN/wym7JSPUUH1pvn6NJaHMr6HCmAW2NGH6g
	snkX0izsGcnHFdEKvxd+yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775490813; x=
	1775577213; bh=yvu8CvGnqqvg27Xag+8WFVVXU5crIK8JVS92CyNjEoE=; b=d
	+80Q4HxJj/ZP//ePhhH370Z7PASlzbjYGVuvQeonOU4xbMMPbfFq9Z8GYvSbDHC3
	61+usWBlWB5PVfjm2nnN0V0vSioIA3H/heX56Ji+r/V1NsSr9kDgzOB607e93EFZ
	f+vyOdKHweIjN+L3cE5R9fXcMAdH/oHA0r9GwdHMgDu7qxddKY/zEELPO9I7DCv9
	8/w1o0lvRALt8YmhY/gxWbht74xYi1N7XWdaXVC/OCMUSAcyB1PKZyFTqeILkfKH
	PqbrDzNMkYDtdzsnkU1rAmmftMVvk2oHYKFg22NZ25RfCzgYJeNVGQlskv6w2G0J
	V/Cl9zAF+qifHkX52vSNA==
X-ME-Sender: <xms:_NbTaSZBXhB7hXE3SWDon5FZtw2FQGmieMi0RtnE8JbDNE9pmo-Fkg>
    <xme:_NbTaXrlf6jBnfjU9optsWdCF7DIVr2tExUbZxaoktxDCtQrSXJC4qgL_YWIqppl6
    ElG5Ah6u7QckSS-0dlKfs_cNEueeiNU-yrIJScENIWJigvmMyUMrB4>
X-ME-Received: <xmr:_NbTafMsXOoptEo0htgxzeMaw9r1D5_ztFjglGDFowFVtf3BE4cFJ_Q2Gw4_suQPn1ubaTYD1UvbpVMzuVONpQ3uQ0D02bz0P6tDV0afDRA9lsW36iIPfw_uOGx3Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeive
    euuedthfehheetueeiteegfefgvefhgfefhfelieduffejhfehleetveffjeenucffohhm
    rghinheprggttggvshhspghmrghskhhsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgih
    hkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohep
    ghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhtihhlihhthi
    gvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgt
    iidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:_NbTaarjVFLQ_DR055VZMWslghPZZiu1zHZcCq1PkxVqy9NkBnfU3Q>
    <xmx:_dbTacd_HOdUVXuedYEaEJuyL0PuliSAiNh22khjlmk64aGMZnyskA>
    <xmx:_dbTaYSRsLHPyOQTXULcQEHv-E3SNXVQIdLMYJ9MZ_cL8yWDs4aMPg>
    <xmx:_dbTadbodFwEY-s6wbLe-lCTmkztZqCHv-cF66kNN0BCduZ4hL2R0Q>
    <xmx:_dbTaVU6lPLiH1Lju05xLY1Mrau1I0DtfJ-BBOTo9wpLTcVohlEsvyIe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:31 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 3/9] landlock: Suppress logging when quiet flag is present
Date: Mon,  6 Apr 2026 16:52:16 +0100
Message-ID: <5a253279ddbc797fa320849e46f7c88d7578a581.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The quietness behaviour is as documented in the previous patch.

For optional accesses, since the existing deny_masks can only store 2x4bit
of layer index, with no way to represent "no layer", we need to either
expand it or have another field to correctly handle quieting of those.
This commit uses the latter approach - we add another field to store which
optional access (of the 2) are covered by quiet rules in their respective
layers as stored in deny_masks.

We can avoid making struct landlock_file_security larger by converting the
existing fown_layer to a 4bit field.  This commit does that, and adds test
to ensure that it is large enough for LANDLOCK_MAX_NUM_LAYERS-1.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v8:
- Rebase on top of mic/next
- Populate request.rule_flags in hook_unix_find()

Changes in v7:
- Following change in commit 1, now we need to copy rule_flags into
  landlock_request before calling landlock_log_denial for relevant fs
  denials
- Remove left over param comment

Changes in v5:
- Update code style and comment in get_layer_from_deny_masks() and
  landlock_log_denial()
- Now that rule_flags is moved into landlock_request, this version removes
  the extra parameter for landlock_log_denial and gets rid of
  no_rule_flags, simplifying some code.
- Fix build failure without CONFIG_AUDIT (reported by Justin Suess)

Changes in v3:
- Renamed patch title from "Check for quiet flag in landlock_log_denial"
  to this given the growth.
- Moved quiet bit check after domain_exec check
- Rename, style and comment fixes suggested by Mickaël.
- Squashed patch 6/6 from v2 "Implement quiet for optional accesses" into
  this one.  Changes to that below:
- Refactor the quiet flag setting in get_layer_from_deny_masks() to be
  more clear.
- Add KUnit tests
- Fix comments, add WARN_ON_ONCE, use __const_hweight64() as suggested by
  review
- Move build_check_file_security to fs.c
- Use a typedef for quiet_optional_accesses, add static_assert, and
  improve docs on landlock_get_quiet_optional_accesses.

Changes in v2:
- Supports the new quiet access masks.
- Support quieting scope requests (but not ptrace and attempted mounting
  for now)

 security/landlock/access.h |   5 +
 security/landlock/audit.c  | 255 +++++++++++++++++++++++++++++++++++--
 security/landlock/audit.h  |   3 +
 security/landlock/domain.c |  33 +++++
 security/landlock/domain.h |   5 +
 security/landlock/fs.c     |  35 +++++
 security/landlock/fs.h     |  17 ++-
 security/landlock/net.c    |  16 +--
 8 files changed, 340 insertions(+), 29 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index c19d5bc13944..2775df80c7da 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -120,4 +120,9 @@ static inline bool access_mask_subset(access_mask_t subset,
 	return (subset | superset) == superset;
 }
 
+/* A bitmask that is large enough to hold set of optional accesses. */
+typedef u8 optional_access_t;
+static_assert(BITS_PER_TYPE(optional_access_t) >=
+	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 8d0edf94037d..2941b6d88688 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -246,7 +246,8 @@ static void test_get_denied_layer(struct kunit *const test)
 static size_t
 get_layer_from_deny_masks(access_mask_t *const access_request,
 			  const access_mask_t all_existing_optional_access,
-			  const deny_masks_t deny_masks)
+			  const deny_masks_t deny_masks,
+			  u8 quiet_optional_accesses, bool *quiet)
 {
 	const unsigned long access_opt = all_existing_optional_access;
 	const unsigned long access_req = *access_request;
@@ -254,6 +255,7 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
 	size_t youngest_layer = 0;
 	size_t access_index = 0;
 	unsigned long access_bit;
+	bool should_quiet = false;
 
 	/* This will require change with new object types. */
 	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
@@ -264,18 +266,29 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
 			const size_t layer =
 				(deny_masks >> (access_index * 4)) &
 				(LANDLOCK_MAX_NUM_LAYERS - 1);
+			const bool layer_has_quiet =
+				!!(quiet_optional_accesses & BIT(access_index));
 
 			if (layer > youngest_layer) {
 				youngest_layer = layer;
 				missing = BIT(access_bit);
+				should_quiet = layer_has_quiet;
 			} else if (layer == youngest_layer) {
 				missing |= BIT(access_bit);
+				/*
+				 * Whether the layer has rules with quiet flag covering
+				 * the file accessed does not depend on the access, and so
+				 * the following WARN_ON_ONCE() should not fail.
+				 */
+				WARN_ON_ONCE(should_quiet && !layer_has_quiet);
+				should_quiet = layer_has_quiet;
 			}
 		}
 		access_index++;
 	}
 
 	*access_request = missing;
+	*quiet = should_quiet;
 	return youngest_layer;
 }
 
@@ -285,42 +298,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
 {
 	deny_masks_t deny_mask;
 	access_mask_t access;
+	u8 quiet_optional_accesses;
+	bool quiet;
 
 	/* truncate:0 ioctl_dev:2 */
 	deny_mask = 0x20;
+	quiet_optional_accesses = 0;
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* layer denying truncate: quiet, ioctl: not quiet */
+	quiet_optional_accesses = 0b01;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* Reverse order - truncate:2 ioctl_dev:0 */
+	deny_mask = 0x02;
+	quiet_optional_accesses = 0;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* layer denying truncate: quiet, ioctl: not quiet */
+	quiet_optional_accesses = 0b01;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
 	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	/* layer denying truncate: not quiet, ioctl: quiet */
+	quiet_optional_accesses = 0b10;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
 
 	/* truncate:15 ioctl_dev:15 */
 	deny_mask = 0xff;
+	quiet_optional_accesses = 0;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access,
+			LANDLOCK_ACCESS_FS_TRUNCATE |
+				LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* Both quiet (same layer so quietness must be the same) */
+	quiet_optional_accesses = 0b11;
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
 	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
 	KUNIT_EXPECT_EQ(test, access,
 			LANDLOCK_ACCESS_FS_TRUNCATE |
 				LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, true);
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
@@ -351,6 +510,22 @@ static bool is_valid_request(const struct landlock_request *const request)
 	return true;
 }
 
+static access_mask_t
+pick_access_mask_for_request_type(const enum landlock_request_type type,
+				  const struct access_masks access_masks)
+{
+	switch (type) {
+	case LANDLOCK_REQUEST_FS_ACCESS:
+		return access_masks.fs;
+	case LANDLOCK_REQUEST_NET_ACCESS:
+		return access_masks.net;
+	default:
+		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
+			  __func__);
+		return 0;
+	}
+}
+
 /**
  * landlock_log_denial - Create audit records related to a denial
  *
@@ -364,6 +539,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	struct landlock_hierarchy *youngest_denied;
 	size_t youngest_layer;
 	access_mask_t missing;
+	bool object_quiet_flag = false, quiet_applicable_to_access = false;
 
 	if (WARN_ON_ONCE(!subject || !subject->domain ||
 			 !subject->domain->hierarchy || !request))
@@ -379,10 +555,14 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			youngest_layer = get_denied_layer(subject->domain,
 							  &missing,
 							  request->layer_masks);
+			object_quiet_flag = !!(request->rule_flags.quiet_masks &
+					       BIT(youngest_layer));
 		} else {
 			youngest_layer = get_layer_from_deny_masks(
 				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				request->deny_masks);
+				request->deny_masks,
+				request->quiet_optional_accesses,
+				&object_quiet_flag);
 		}
 		youngest_denied =
 			get_hierarchy(subject->domain, youngest_layer);
@@ -417,6 +597,53 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			return;
 	}
 
+	/*
+	 * Checks if the object is marked quiet by the layer that denied the
+	 * request.  If it's a different layer that marked it as quiet, but
+	 * that layer is not the one that denied the request, we should still
+	 * audit log the denial.
+	 */
+	if (object_quiet_flag) {
+		/*
+		 * We now check if the denied requests are all covered by the
+		 * layer's quiet access bits.
+		 */
+		const access_mask_t quiet_mask =
+			pick_access_mask_for_request_type(
+				request->type, youngest_denied->quiet_masks);
+
+		quiet_applicable_to_access = (quiet_mask & missing) == missing;
+	} else {
+		/*
+		 * Either the object is not quiet, or this is a scope request.  We
+		 * check request->type to distinguish between the two cases.
+		 */
+		const access_mask_t quiet_mask =
+			youngest_denied->quiet_masks.scope;
+
+		switch (request->type) {
+		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+			quiet_applicable_to_access =
+				!!(quiet_mask & LANDLOCK_SCOPE_SIGNAL);
+			break;
+		case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+			quiet_applicable_to_access =
+				!!(quiet_mask &
+				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			break;
+		/*
+		 * Leave LANDLOCK_REQUEST_PTRACE and
+		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they are
+		 * never quiet.
+		 */
+		default:
+			break;
+		}
+	}
+
+	if (quiet_applicable_to_access)
+		return;
+
 	/* Uses consistent allocation flags wrt common_lsm_audit(). */
 	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
 			     AUDIT_LANDLOCK_ACCESS);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 56778331b58c..c2da854d4405 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -48,6 +48,9 @@ struct landlock_request {
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
 	deny_masks_t deny_masks;
+	u8 quiet_optional_accesses;
+
+	struct collected_rule_flags rule_flags;
 };
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 06b6bd845060..f365721050b7 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -156,6 +156,39 @@ get_layer_deny_mask(const access_mask_t all_existing_optional_access,
 	       << ((access_weight - 1) * HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1));
 }
 
+/**
+ * landlock_get_quiet_optional_accesses - Get optional accesses which are
+ * "covered" by quiet rule flags.
+ *
+ * Returns a bitmask of which optional access are denied by layers for
+ * which rule_flags.quiet_masks has the corresponding bit set.
+ */
+optional_access_t landlock_get_quiet_optional_accesses(
+	const access_mask_t all_existing_optional_access,
+	const deny_masks_t deny_masks,
+	const struct collected_rule_flags rule_flags)
+{
+	const unsigned long access_opt = all_existing_optional_access;
+	size_t access_index = 0;
+	unsigned long access_bit;
+	optional_access_t quiet_optional_accesses = 0;
+
+	/* This will require change with new object types. */
+	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
+
+	for_each_set_bit(access_bit, &access_opt,
+			 BITS_PER_TYPE(access_mask_t)) {
+		const u8 layer = (deny_masks >> (access_index * 4)) &
+				 (LANDLOCK_MAX_NUM_LAYERS - 1);
+		const bool is_quiet = !!(rule_flags.quiet_masks & BIT(layer));
+
+		if (is_quiet)
+			quiet_optional_accesses |= BIT(access_index);
+		access_index++;
+	}
+	return quiet_optional_accesses;
+}
+
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
 static void test_get_layer_deny_mask(struct kunit *const test)
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 9b8aeac8ebd2..c74730097a33 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -129,6 +129,11 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
 			const struct layer_access_masks *const masks);
 
+optional_access_t landlock_get_quiet_optional_accesses(
+	const access_mask_t all_existing_optional_access,
+	const deny_masks_t deny_masks,
+	const struct collected_rule_flags rule_flags);
+
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
 static inline void
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 06a8d2258558..bd7554d0b65a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -983,6 +983,7 @@ static int current_check_access_path(const struct path *const path,
 				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
+	request.rule_flags = rule_flags;
 	landlock_log_denial(subject, &request);
 	return -EACCES;
 }
@@ -1195,6 +1196,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
 			return 0;
 
+		request1.rule_flags = rule_flags_parent1;
 		landlock_log_denial(subject, &request1);
 		return -EACCES;
 	}
@@ -1243,10 +1245,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 	if (request1.access) {
 		request1.audit.u.path.dentry = old_parent;
+		request1.rule_flags = rule_flags_parent1;
 		landlock_log_denial(subject, &request1);
 	}
 	if (request2.access) {
 		request2.audit.u.path.dentry = new_dir->dentry;
+		request2.rule_flags = rule_flags_parent2;
 		landlock_log_denial(subject, &request2);
 	}
 
@@ -1706,6 +1710,7 @@ static int hook_unix_find(const struct path *const path, struct sock *other,
 		    &rule_flags, &request, NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
+	request.rule_flags = rule_flags;
 	landlock_log_denial(subject, &request);
 	return -EACCES;
 }
@@ -1739,8 +1744,31 @@ get_required_file_open_access(const struct file *const file)
 	return access;
 }
 
+static void build_check_file_security(void)
+{
+#ifdef CONFIG_AUDIT
+	const struct landlock_file_security file_sec = {
+		.quiet_optional_accesses = ~0,
+		.fown_layer = ~0,
+	};
+
+	/*
+	 * Make sure quiet_optional_accesses has enough bits to cover all
+	 * optional accesses.  The use of __const_hweight64() rather than
+	 * HWEIGHT() is due to GCC erroring about non-constants in
+	 * BUILD_BUG_ON call when using the latter, and the use of the 64bit
+	 * version is for future-proofing.
+	 */
+	BUILD_BUG_ON(__const_hweight64((u64)file_sec.quiet_optional_accesses) <
+		     __const_hweight64(_LANDLOCK_ACCESS_FS_OPTIONAL));
+	/* Makes sure all layers can be identified. */
+	BUILD_BUG_ON(file_sec.fown_layer < LANDLOCK_MAX_NUM_LAYERS - 1);
+#endif /* CONFIG_AUDIT */
+}
+
 static int hook_file_alloc_security(struct file *const file)
 {
+	build_check_file_security();
 	/*
 	 * Grants all access rights, even if most of them are not checked later
 	 * on. It is more consistent.
@@ -1819,6 +1847,10 @@ static int hook_file_open(struct file *const file)
 #ifdef CONFIG_AUDIT
 	landlock_file(file)->deny_masks = landlock_get_deny_masks(
 		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks);
+	landlock_file(file)->quiet_optional_accesses =
+		landlock_get_quiet_optional_accesses(
+			_LANDLOCK_ACCESS_FS_OPTIONAL,
+			landlock_file(file)->deny_masks, rule_flags);
 #endif /* CONFIG_AUDIT */
 
 	if (access_mask_subset(open_access_request, allowed_access))
@@ -1826,6 +1858,7 @@ static int hook_file_open(struct file *const file)
 
 	/* Sets access to reflect the actual request. */
 	request.access = open_access_request;
+	request.rule_flags = rule_flags;
 	landlock_log_denial(subject, &request);
 	return -EACCES;
 }
@@ -1855,6 +1888,7 @@ static int hook_file_truncate(struct file *const file)
 		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
+		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
 #endif /* CONFIG_AUDIT */
 	});
 	return -EACCES;
@@ -1894,6 +1928,7 @@ static int hook_file_ioctl_common(const struct file *const file,
 		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
+		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
 #endif /* CONFIG_AUDIT */
 	});
 	return -EACCES;
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index cb7e654933ac..ac6e50216f87 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -63,11 +63,20 @@ struct landlock_file_security {
 	 * _LANDLOCK_ACCESS_FS_OPTIONAL).
 	 */
 	deny_masks_t deny_masks;
+	/**
+	 * @quiet_optional_accesses: Stores which optional accesses are
+	 * covered by quiet rules within the layer referred to in deny_masks,
+	 * one access per bit.  Does not take into account whether the quiet
+	 * access bits are actually set in the layer's corresponding
+	 * landlock_hierarchy.
+	 */
+	optional_access_t quiet_optional_accesses
+		: HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL);
 	/**
 	 * @fown_layer: Layer level of @fown_subject->domain with
 	 * LANDLOCK_SCOPE_SIGNAL.
 	 */
-	u8 fown_layer;
+	u8 fown_layer:4;
 #endif /* CONFIG_AUDIT */
 
 	/**
@@ -82,12 +91,6 @@ struct landlock_file_security {
 
 #ifdef CONFIG_AUDIT
 
-/* Makes sure all layers can be identified. */
-/* clang-format off */
-static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
-	      LANDLOCK_MAX_NUM_LAYERS);
-/* clang-format off */
-
 #endif /* CONFIG_AUDIT */
 
 /**
diff --git a/security/landlock/net.c b/security/landlock/net.c
index ade2b1750042..4349bd42e533 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -200,14 +200,14 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 
 	audit_net.family = address->sa_family;
-	landlock_log_denial(subject,
-			    &(struct landlock_request){
-				    .type = LANDLOCK_REQUEST_NET_ACCESS,
-				    .audit.type = LSM_AUDIT_DATA_NET,
-				    .audit.u.net = &audit_net,
-				    .access = access_request,
-				    .layer_masks = &layer_masks,
-			    });
+	landlock_log_denial(
+		subject,
+		&(struct landlock_request){ .type = LANDLOCK_REQUEST_NET_ACCESS,
+					    .audit.type = LSM_AUDIT_DATA_NET,
+					    .audit.u.net = &audit_net,
+					    .access = access_request,
+					    .layer_masks = &layer_masks,
+					    .rule_flags = rule_flags });
 	return -EACCES;
 }
 
-- 
2.53.0
