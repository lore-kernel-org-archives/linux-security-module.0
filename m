Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBA1E5201
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511538; cv=none; b=dX9qs8a+twIwLg/9FFvZVyEaidhrw4I+pzi0+rD4twk32+y6J8svDwVC+wY4TYJPCyELTBiyw2nCuB/T47EIhwgYf2hdX0dJYvDFbF7vd7MTSejtTRNqpLI/p3ywul4jwNL2AsKYwZ83XbB2I4W+wnAfJHp+XXIk4rWBTusvQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511538; c=relaxed/simple;
	bh=mEgq93rJgsob0pCbrpG1k9Tquz9Yz2G5b1uA8/PRqRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b008Im94wxZM7JME7bKsPjmGnS6rkmeH3Fl9D/sxZhDIhpZmQ7oma/k7+WcjbDwRzIJ5CRvtVXp5/HzdL92/NsPY7ou4kxXXvj1GDXYREttZ20uuKau08i0zikxo21HI3SrAAvwAeW1kX4g90Okm9qqtF5BWL9okV/pqv0lT/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=QS79fFTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrwTd2nv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="QS79fFTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrwTd2nv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 014F21400245;
	Sun, 26 Oct 2025 16:45:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 26 Oct 2025 16:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761511534;
	 x=1761597934; bh=y0KRpB20vPoVruW7u8X9JbvOfRtm8ljyyt1ForAfojs=; b=
	QS79fFTOnI1CwMoDLwbMmHAsEWcFJ6Oj6Fpz6ZkRTS9WOPHo2YmA4KvzrZqpKZFr
	rZhTvhmfnRd8PEwG1hinOrP+NUknMiC3lKZDI+a/rWMNmde44VqhoD1SoB2NvCqL
	SSmEnpj3P67xacanahUVUIgNRH2DUzZ+gc8K8G7P3HkZ2D0lCeLUv4rF48H44/Nx
	BAdEx8B1qe604evBwa1mU7OMygzURcUwH+U6THAAnOWpRSF1iLdPXh12Vrun9WSC
	zKjd0JnOVbiFnwa581lnUYpio10XTVvjwHTE8M4YOUaDmy1POLwHIPF1TnZmQGw3
	fM1i7omkFA006Y0NHc7rUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761511534; x=
	1761597934; bh=y0KRpB20vPoVruW7u8X9JbvOfRtm8ljyyt1ForAfojs=; b=l
	rwTd2nvdk1/lsRmmJuSqhoH7XasXMhz/rxR6PSPTE1EqnXoNFNKwnc4Nl4Nw0+IL
	zhLopX/GnOoqqDXSdbmSclXRWxpcBGG/Rxz0zE439F5Yy3/NasVkkxDmunRW2Cni
	uVDH/rjLgQbvvM6EraktrrWlpfa/SSgZVmiWyDuvAaOcqbDREgaxohbs6rbYK4kx
	8QnlqmKY46Whv8nFASbgChdih7OQ854F2eq5vtbaFWpoB6doC3A7Y0HeApl/XEqU
	XUaUQU/wgyJhKSjbOEvyknrR+OaTlcPwvOgZ8w4L67jbQbqYt/Q31HbOPPOa3ynL
	rii9cwP+CElGBq6pqkh1w==
X-ME-Sender: <xms:boj-aPbGSpgwAdLSKXOeFv6EbYmWUIK52FDEf_CTHPNIkmwR4u9xQA>
    <xme:boj-aCH80LxIl7pCbfdcLYlVFDP3h0u38YZUOk0HCA2G-RQTJzjbzS3OJlHHDMxWN
    LjvkF3q_AA0q2eKvkOsQoOC98A-_Tr6_5npMRsJpLpLq6Ccbk0UUAM>
X-ME-Received: <xmr:boj-aLxasHxWNP1FGKrVVIyf33rBO-SPGL5zLL216SYN3ZRJlXyxKQj1a_olpb2nN-xSQa0wgGA4-7aXtJi363x5B-HPs5en80fwU57qi0qnNMXJyBM2dk3wI5S2tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepie
    evueeutdfhheehteeuieetgeefgfevhffgfefhleeiudffjefhheelteevffejnecuffho
    mhgrihhnpegrtggtvghsshgpmhgrshhkshdrnhgvthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughigh
    hikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthho
    pehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvg
    drtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:boj-aMn52BkZ7-DfRLc45hcD3j5lGnFMEPFijGPkFf-tOsgr_78Ycg>
    <xmx:boj-aMm_jut6rajOsPFwW2uVOeA6XiUJueVUrXF2Tvrmc2kuXaTsKg>
    <xmx:boj-aGxdkjY2WYO32YfiBQy8S-tTc1fmhXqqL72kfRGcjrZ3mo7kWg>
    <xmx:boj-aJpF2ZH1IIqV9A4C2s5HYib1Z5VG-hqL89Fu0H5QKL2LUBtrVQ>
    <xmx:boj-aJi3Iv8rz4iYItbg7t57LGYzfqa7V6Hgcm2dYSMbhYxw58NTZtcv>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:33 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 3/8] landlock: Suppress logging when quiet flag is present
Date: Sun, 26 Oct 2025 20:44:18 +0000
Message-ID: <456d46251acf3cf57a5bc8388d5f8b5147ba02db.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
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

Changes since v2:
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

Changes since v1:
- Supports the new quiet access masks.
- Support quieting scope requests (but not ptrace and attempted mounting
  for now)

 security/landlock/access.h  |   5 +
 security/landlock/audit.c   | 255 +++++++++++++++++++++++++++++++++---
 security/landlock/audit.h   |   4 +-
 security/landlock/domain.c  |  33 +++++
 security/landlock/domain.h  |   5 +
 security/landlock/fs.c      |  45 +++++--
 security/landlock/fs.h      |  17 ++-
 security/landlock/net.c     |   3 +-
 security/landlock/ruleset.h |   5 +
 security/landlock/task.c    |  12 +-
 10 files changed, 344 insertions(+), 40 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d..db47edc88afa 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -97,4 +97,9 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
 	return access_masks;
 }
 
+/* A bitmask that is large enough to hold set of optional accesses. */
+typedef u8 optional_access_t;
+static_assert(BITS_PER_TYPE(optional_access_t) >=
+	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77..505b13c8f4c2 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -273,7 +273,7 @@ static void test_get_denied_layer(struct kunit *const test)
 static size_t
 get_layer_from_deny_masks(access_mask_t *const access_request,
 			  const access_mask_t all_existing_optional_access,
-			  const deny_masks_t deny_masks)
+			  const deny_masks_t deny_masks, u8 quiet_optional_accesses, bool *quiet)
 {
 	const unsigned long access_opt = all_existing_optional_access;
 	const unsigned long access_req = *access_request;
@@ -285,18 +285,29 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
 	/* This will require change with new object types. */
 	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
 
+	*quiet = false;
 	for_each_set_bit(access_bit, &access_opt,
 			 BITS_PER_TYPE(access_mask_t)) {
 		if (access_req & BIT(access_bit)) {
 			const size_t layer =
 				(deny_masks >> (access_index * 4)) &
 				(LANDLOCK_MAX_NUM_LAYERS - 1);
+			const bool layer_has_quiet =
+				!!(quiet_optional_accesses & BIT(access_index));
 
 			if (layer > youngest_layer) {
 				youngest_layer = layer;
+				*quiet = layer_has_quiet;
 				missing = BIT(access_bit);
 			} else if (layer == youngest_layer) {
 				missing |= BIT(access_bit);
+				/*
+				 * Whether the layer has rules with quiet flag covering
+				 * the file accessed does not depend on the access, and so
+				 * if this fails, quiet_optional_accesses is corrupted.
+				 */
+				WARN_ON_ONCE(*quiet && !layer_has_quiet);
+				*quiet = layer_has_quiet;
 			}
 		}
 		access_index++;
@@ -312,42 +323,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
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
@@ -381,19 +538,39 @@ static bool is_valid_request(const struct landlock_request *const request)
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
  * @subject: The Landlock subject's credential denying an action.
  * @request: Detail of the user space request.
+ * @rule_flags: The flags for the matched rule, or no_rule_flags (zero) if
+ * this is a scope request (no particular object involved).
  */
 void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request)
+			 const struct landlock_request *const request,
+			 const struct collected_rule_flags rule_flags)
 {
 	struct audit_buffer *ab;
 	struct landlock_hierarchy *youngest_denied;
 	size_t youngest_layer;
-	access_mask_t missing;
+	access_mask_t missing, quiet_mask;
+	bool object_quiet_flag = false, quiet_applicable_to_access = false;
 
 	if (WARN_ON_ONCE(!subject || !subject->domain ||
 			 !subject->domain->hierarchy || !request))
@@ -409,10 +586,13 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			youngest_layer = get_denied_layer(
 				subject->domain, &missing, request->layer_masks,
 				request->layer_masks_size);
+			object_quiet_flag = !!(rule_flags.quiet_masks & BIT(youngest_layer));
 		} else {
 			youngest_layer = get_layer_from_deny_masks(
 				&missing, request->all_existing_optional_access,
-				request->deny_masks);
+				request->deny_masks,
+				request->quiet_optional_accesses,
+				&object_quiet_flag);
 		}
 		youngest_denied =
 			get_hierarchy(subject->domain, youngest_layer);
@@ -447,6 +627,49 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
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
+		quiet_mask = pick_access_mask_for_request_type(
+			request->type, youngest_denied->quiet_masks);
+		quiet_applicable_to_access = (quiet_mask & missing) == missing;
+	} else {
+		/*
+		 * Either the object is not quiet, or this is a scope request.  We
+		 * check request->type to distinguish between the two cases.
+		 */
+		quiet_mask = youngest_denied->quiet_masks.scope;
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
index 92428b7fc4d8..950365cd223d 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -49,6 +49,7 @@ struct landlock_request {
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
 	deny_masks_t deny_masks;
+	u8 quiet_optional_accesses;
 };
 
 #ifdef CONFIG_AUDIT
@@ -56,7 +57,8 @@ struct landlock_request {
 void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
 
 void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request);
+			 const struct landlock_request *const request,
+			 const struct collected_rule_flags rule_flags);
 
 #else /* CONFIG_AUDIT */
 
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d06..8caf07250328 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -212,6 +212,39 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 	return deny_masks;
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
 
 static void test_landlock_get_deny_masks(struct kunit *const test)
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index aadbf53505c0..ea487315580a 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -130,6 +130,11 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const layer_mask_t (*const layer_masks)[],
 			size_t layer_masks_size);
 
+optional_access_t landlock_get_quiet_optional_accesses(
+	const access_mask_t all_existing_optional_access,
+	const deny_masks_t deny_masks,
+	const struct collected_rule_flags rule_flags);
+
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
 static inline void
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 13195b6ffed7..15b9da835eb5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1105,7 +1105,7 @@ static int current_check_access_path(const struct path *const path,
 				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &request, rule_flags);
 	return -EACCES;
 }
 
@@ -1339,7 +1339,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
 			return 0;
 
-		landlock_log_denial(subject, &request1);
+		landlock_log_denial(subject, &request1, rule_flags_parent1);
 		return -EACCES;
 	}
 
@@ -1387,11 +1387,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 	if (request1.access) {
 		request1.audit.u.path.dentry = old_parent;
-		landlock_log_denial(subject, &request1);
+		landlock_log_denial(subject, &request1, rule_flags_parent1);
 	}
 	if (request2.access) {
 		request2.audit.u.path.dentry = new_dir->dentry;
-		landlock_log_denial(subject, &request2);
+		landlock_log_denial(subject, &request2, rule_flags_parent2);
 	}
 
 	/*
@@ -1547,7 +1547,7 @@ log_fs_change_topology_path(const struct landlock_cred_security *const subject,
 			.u.path = *path,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 }
 
 static void log_fs_change_topology_dentry(
@@ -1561,7 +1561,7 @@ static void log_fs_change_topology_dentry(
 			.u.dentry = dentry,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 }
 
 /*
@@ -1755,8 +1755,29 @@ get_required_file_open_access(const struct file *const file)
 	return access;
 }
 
+static void build_check_file_security(void)
+{
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
+}
+
 static int hook_file_alloc_security(struct file *const file)
 {
+	build_check_file_security();
 	/*
 	 * Grants all access rights, even if most of them are not checked later
 	 * on. It is more consistent.
@@ -1842,6 +1863,10 @@ static int hook_file_open(struct file *const file)
 	landlock_file(file)->deny_masks = landlock_get_deny_masks(
 		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks,
 		ARRAY_SIZE(layer_masks));
+	landlock_file(file)->quiet_optional_accesses =
+		landlock_get_quiet_optional_accesses(
+			_LANDLOCK_ACCESS_FS_OPTIONAL,
+			landlock_file(file)->deny_masks, rule_flags);
 #endif /* CONFIG_AUDIT */
 
 	if ((open_access_request & allowed_access) == open_access_request)
@@ -1849,7 +1874,7 @@ static int hook_file_open(struct file *const file)
 
 	/* Sets access to reflect the actual request. */
 	request.access = open_access_request;
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &request, rule_flags);
 	return -EACCES;
 }
 
@@ -1878,8 +1903,9 @@ static int hook_file_truncate(struct file *const file)
 		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
+		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
 #endif /* CONFIG_AUDIT */
-	});
+	}, no_rule_flags);
 	return -EACCES;
 }
 
@@ -1917,8 +1943,9 @@ static int hook_file_ioctl_common(const struct file *const file,
 		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
+		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
 #endif /* CONFIG_AUDIT */
-	});
+	}, no_rule_flags);
 	return -EACCES;
 }
 
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
index bddbe93d69fd..0587aa3d6d0f 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -193,7 +193,8 @@ static int current_check_access_socket(struct socket *const sock,
 				    .access = access_request,
 				    .layer_masks = &layer_masks,
 				    .layer_masks_size = ARRAY_SIZE(layer_masks),
-			    });
+			    },
+			    rule_flags);
 	return -EACCES;
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 57fa2e18a483..cd0434d8dc63 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -58,6 +58,11 @@ struct collected_rule_flags {
 	layer_mask_t quiet_masks;
 };
 
+/**
+ * no_rule_flags - Convenience constant for an empty collected_rule_flags.
+ */
+static const struct collected_rule_flags no_rule_flags = {};
+
 /**
  * union landlock_key - Key of a ruleset's red-black tree
  */
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..d5bd9a1b8467 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -115,7 +115,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				.u.tsk = child,
 			},
 			.layer_plus_one = parent_subject->domain->num_layers,
-		});
+		}, no_rule_flags);
 
 	return err;
 }
@@ -161,7 +161,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 			.u.tsk = current,
 		},
 		.layer_plus_one = parent_subject->domain->num_layers,
-	});
+	}, no_rule_flags);
 	return err;
 }
 
@@ -290,7 +290,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
@@ -327,7 +327,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
@@ -383,7 +383,7 @@ static int hook_task_kill(struct task_struct *const p,
 			.u.tsk = p,
 		},
 		.layer_plus_one = handle_layer + 1,
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
@@ -426,7 +426,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 #ifdef CONFIG_AUDIT
 		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
 #endif /* CONFIG_AUDIT */
-	});
+	}, no_rule_flags);
 	return -EPERM;
 }
 
-- 
2.51.1
