Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954B189B84
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228957; cv=none; b=sovQDbi4vPS6s+hPw6FADGx23yn4MQPD6STko2/v6M0+qGZd9KZQk3WybK9nUjFfBiBtvotAvR/D1BwTjunENIovOz223TZOPPThJ61pdPN92QruQs49vmEOHwicch1l2tJqAF5clABt4FnvDUxuaGtH7MYXm/m1l+4Axeuoj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228957; c=relaxed/simple;
	bh=hLKh/D9bTjyozbC1WEhdiWowkYcA8xcCour2cbVlGpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRjYotvI26rKtN0RBgajJbQ/1sNmbJJM7lJmTLGpY5gAp/qlIkZNNY5cQmKMHbS6pVf9C8MM8sRTPq/Azncpl9zsbaKL7uQApz4raKFRfKMHkfGWmsd0fAExf9qLhRO6LHyACTNigRoxoJR9N2iZU6kAzjWTilhVyvW0HYzXfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=c9cH0Y1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yrvsnc8k; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="c9cH0Y1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yrvsnc8k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83C887A00F6;
	Thu, 11 Jun 2026 21:49:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 21:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781228954;
	 x=1781315354; bh=B95hVu71HNoWmqfo7j1NqdKJ5sysCmhnLqRgOKTS2PU=; b=
	c9cH0Y1un/OWWSJ2Wxm3dLTgKdvhwtOLP535iUAPzMYvRGAM1XADMGIvhdE0JoNp
	np/Omf4zHx3pYzkGqcms7LLDjruRHUgHi4s9ngBVS2TLNrxIuQ5ktx1yA5jddPPO
	GRVTMC9Bf6zQQL3oXKAJUfbFRNg/BZXqyk2fB0XfDHemDT2bIBAJ+iqzaWTJ/YhM
	aAtmWMScHZpl4Ax2plsttfgCzJmR+WItWY0GhlwHxttYKmmW+3EO+Mw85DLgan7q
	GEc43yMK3gpL9deDA0JS/eL29jX6hpBC45xXKOBHLO9dtvXMMgxbmhkXDpfDzBpZ
	0e/5zxYxHOIURD829k/KQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781228954; x=
	1781315354; bh=B95hVu71HNoWmqfo7j1NqdKJ5sysCmhnLqRgOKTS2PU=; b=Y
	rvsnc8k+TaTrGLnbpkhzW3AtE2IzSaAHvOghUYosCiGa6oHMO+tXbZuSPv94jswl
	TfStYFQyLJDpQ/9Gv73fnpBsRr0KxP/cJ0v31y4A/xLOhozsuJT2SfkNBBTduuwI
	5W/QiIR/6Vgys5AQfvHahS1eTe795Y2LiIyt8Hkv9rqG80bRMjFfTQjlJ+KgdDKz
	21JIUVO1xIz6bc7l6c6ElnO8kPAdQ5Tsb8N8WEZXVyKjnZoyvAI3B1NYFq5wyqqX
	SZ5Www406DiIIrlumw3BvgeQdWBgo4VEpghCVCAH4HfUxWmabJGDm1zY98RY8/Xc
	/V7MdrDukzp3Wkor5XQJA==
X-ME-Sender: <xms:mmUrapr25drY3NYy143m4rFeuOrXMVYlmM0eBT-GorF9zrnIGkGczQ>
    <xme:mmUrat5fPrAOsJ2zH-KtoWjEL4wuag-90MLQKW7Bm4Q7ghELY_hh1y6r1Hhi8PDWO
    yiEqzTnQ43cy9py-8kkSzo5KVf3oe1Otb84u5jZ5e3pAvaoXviGSg>
X-ME-Received: <xmr:mmUraochnOSVtf0ZqipuCARwpmx4rueeFaeSbKSe2gMJi5-o4N0nWRsUc9XdGoGnwuGVNNx_XY1A6DOIMIPh6hEHOil_n9Lq4j8IdPJVCHMNSEhAxbL5urttq5U>
X-ME-Proxy-Cause: dmFkZTErKxrXYUL5tItpm4VyGrw55q1qJ3/OcVfN9hLWAMSXZrP9b7HN8Tr4l0G+Ar2Ye6
    0L7ygV34bF/lHINNVVcEna+uVAGoejYxG67PEgd1nueOu4uGaMN9VPe9GapvQZPICV7QBX
    lalkqGjBIYVd3xFpbAGWspH6668i4rR5BZJD4jyuAMpR+rCAr/aHUda55OHVhZOFD5yrPx
    NYIlfKm4gzz1WkE1I6ep2MJwlZbPYds3MhfRyxdDD9sfkXykeshrH5U23nBLkIySpt5YJd
    TDAjWIMWvhlD7JWpRNSt4lmLoVHWiOHGLmPKf6hAy6xZvXjiphdQ9527k0dlxE2bcf4Pol
    qEbmeVdXx2Wj8lRLScTzqtVniI6lVTzebMC5WEbbWIH+8rY/JHzTdq9a4pGhYkcyzCC4ml
    jFXeIs8+flrTpaKdihqD5eZGIzOUoyZWyFCRcTDFgvOo6DUiVJg8HRCsms6NXJE94zPdvX
    mJSp44zw3xeJIf5/YRGFpnjwL+8o7qXz/HB4QYGpCJ/XYmPwkfFHQ/JAvxM9m8FeYF89Dt
    httht3IaWu9Oz9pLnu3uHaI2c5MFXtjyl5fxBZdkymjkw8L9kqMfATXWCKtTxhhGb5WCf4
    BohkdJclEkzWfkgr3NAXMbfMsItC7NSU0Ul0ADyJpyDSPC3L1v97U481iyIw
X-ME-Proxy: <xmx:mmUraq7-vCXN26qgxvrPffefYC2r4xmD2IQB1J5nDFlrjDYHrWwLTw>
    <xmx:mmUranuYZdID5v3kBoEZdggSDqpWF5QEhTdBeH0awVSiHWrmjEPiEw>
    <xmx:mmUraijO8WmhPskRE_M3a6-T8xSvXgvWUPZQK7JDyvV6_UzThBdCrA>
    <xmx:mmUraqoS54uO_eI5QLo3_Y2By1hNFFKOWqlNuKeewT4LRNC0J2AHJw>
    <xmx:mmUraplX0v7TmMGthLJRkwHkoI1GuEWSjO9LI8YRX8ZB-xpXqpdJP0e6>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:13 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 3/9] landlock: Suppress logging when quiet flag is present
Date: Fri, 12 Jun 2026 02:48:49 +0100
Message-ID: <2510a357a94183683eefc49917dcb2240d67be96.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781228815.git.m@maowtm.org>
References: <cover.1781228815.git.m@maowtm.org>
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

Assisted-by: GitHub-Copilot:claude-opus-4.8 copilot-review
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v11:

- Add quiet_optional_accesses invariant check in is_valid_request
- Enhance docstring on landlock_get_quiet_optional_accesses
- Don't use bitfields for fown_layer and quiet_optional_accesses
- Also remove the newly added build_check_file_security() and use
  bits_per_field based check for quiet_optional_accesses since we now
  don't have a bitfield

Changes in v10:
- clang-format header file changes too
- Fix grammar in some comments

Changes in v9:
- Fix conflict
- Applied struct layer_masks changes to this as well.
- Replace 4 with HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1) in
  landlock_get_quiet_optional_accesses()
- Replace 4 with HWEIGHT in (existing) get_layer_from_deny_masks as
  well.
- Use optional_access_t typedef for all quiet_optional_accesses values
  instead of u8

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
 security/landlock/audit.c  | 268 ++++++++++++++++++++++++++++++++++---
 security/landlock/audit.h  |   1 +
 security/landlock/domain.c |  38 ++++++
 security/landlock/domain.h |   4 +
 security/landlock/fs.c     |   6 +
 security/landlock/fs.h     |  19 ++-
 security/landlock/net.c    |  15 +--
 8 files changed, 330 insertions(+), 26 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 94f4b9fb7238..e81164876c7d 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -143,4 +143,9 @@ static inline bool access_mask_subset(access_mask_t subset,
 	return (subset | superset) == superset;
 }
 
+/* A bitmask that is large enough to hold set of optional accesses. */
+typedef u8 optional_access_t;
+static_assert(BITS_PER_TYPE(optional_access_t) >=
+	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 8c56f7f6467a..738d8c810b2c 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -249,7 +249,9 @@ static void test_get_denied_layer(struct kunit *const test)
 static size_t
 get_layer_from_deny_masks(access_mask_t *const access_request,
 			  const access_mask_t all_existing_optional_access,
-			  const deny_masks_t deny_masks)
+			  const deny_masks_t deny_masks,
+			  optional_access_t quiet_optional_accesses,
+			  bool *quiet)
 {
 	const unsigned long access_opt = all_existing_optional_access;
 	const unsigned long access_req = *access_request;
@@ -257,6 +259,7 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
 	size_t youngest_layer = 0;
 	size_t access_index = 0;
 	unsigned long access_bit;
+	bool should_quiet = false;
 
 	/* This will require change with new object types. */
 	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
@@ -265,20 +268,33 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
 			 BITS_PER_TYPE(access_mask_t)) {
 		if (access_req & BIT(access_bit)) {
 			const size_t layer =
-				(deny_masks >> (access_index * 4)) &
+				(deny_masks >>
+				 (access_index *
+				  HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
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
 
@@ -288,42 +304,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
 {
 	deny_masks_t deny_mask;
 	access_mask_t access;
+	optional_access_t quiet_optional_accesses;
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
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
 	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
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
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
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
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
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
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
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
@@ -349,11 +511,34 @@ static bool is_valid_request(const struct landlock_request *const request)
 	if (request->deny_masks) {
 		if (WARN_ON_ONCE(!request->all_existing_optional_access))
 			return false;
+		static_assert(sizeof(request->all_existing_optional_access) ==
+			      sizeof(u32));
+		if (WARN_ON_ONCE(
+			    request->quiet_optional_accesses >=
+			    BIT(hweight32(
+				    request->all_existing_optional_access))))
+			return false;
 	}
 
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
@@ -367,6 +552,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	struct landlock_hierarchy *youngest_denied;
 	size_t youngest_layer;
 	access_mask_t missing;
+	bool object_quiet_flag = false, quiet_applicable_to_access = false;
 
 	if (WARN_ON_ONCE(!subject || !subject->domain ||
 			 !subject->domain->hierarchy || !request))
@@ -382,10 +568,15 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			youngest_layer = get_denied_layer(subject->domain,
 							  &missing,
 							  request->layer_masks);
+			object_quiet_flag =
+				request->layer_masks->layers[youngest_layer]
+					.quiet;
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
@@ -420,6 +611,53 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
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
index b85d752273ac..620f8a24291d 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -48,6 +48,7 @@ struct landlock_request {
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
 	deny_masks_t deny_masks;
+	optional_access_t quiet_optional_accesses;
 };
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index d1a4d8b33ee1..6f1cff739ae8 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -157,6 +157,44 @@ get_layer_deny_mask(const access_mask_t all_existing_optional_access,
 	       << ((access_weight - 1) * HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1));
 }
 
+/**
+ * landlock_get_quiet_optional_accesses - Get optional accesses which are
+ *                                        covered by quiet rule flags.
+ *
+ * @all_existing_optional_access: Bitmask of valid optional accesses.
+ * @deny_masks: Domain layer levels that denied each optional access (the
+ *              deny_masks field on struct landlock_file_security).
+ * @masks: The struct layer_masks collected during the path walk.
+ *
+ * Return: a bitmask of which optional accesses are denied by layers for
+ * which the quiet flag was collected during the path walk.
+ */
+optional_access_t landlock_get_quiet_optional_accesses(
+	const access_mask_t all_existing_optional_access,
+	const deny_masks_t deny_masks, const struct layer_masks *const masks)
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
+		const u8 layer =
+			(deny_masks >> (access_index *
+					HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
+			(LANDLOCK_MAX_NUM_LAYERS - 1);
+
+		if (masks->layers[layer].quiet)
+			quiet_optional_accesses |= BIT(access_index);
+		access_index++;
+	}
+	return quiet_optional_accesses;
+}
+
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
 static void test_get_layer_deny_mask(struct kunit *const test)
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 9f560f3c3bd1..2a1660e3dea7 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -126,6 +126,10 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
 			const struct layer_masks *const masks);
 
+optional_access_t landlock_get_quiet_optional_accesses(
+	const access_mask_t all_existing_optional_access,
+	const deny_masks_t deny_masks, const struct layer_masks *const masks);
+
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
 static inline void
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a096e4aa7fcd..ccb2fe4fa056 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1805,6 +1805,10 @@ static int hook_file_open(struct file *const file)
 #ifdef CONFIG_AUDIT
 	landlock_file(file)->deny_masks = landlock_get_deny_masks(
 		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks);
+	landlock_file(file)->quiet_optional_accesses =
+		landlock_get_quiet_optional_accesses(
+			_LANDLOCK_ACCESS_FS_OPTIONAL,
+			landlock_file(file)->deny_masks, &layer_masks);
 #endif /* CONFIG_AUDIT */
 
 	if (access_mask_subset(open_access_request, allowed_access))
@@ -1841,6 +1845,7 @@ static int hook_file_truncate(struct file *const file)
 		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
+		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
 #endif /* CONFIG_AUDIT */
 	});
 	return -EACCES;
@@ -1880,6 +1885,7 @@ static int hook_file_ioctl_common(const struct file *const file,
 		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
 #ifdef CONFIG_AUDIT
 		.deny_masks = landlock_file(file)->deny_masks,
+		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
 #endif /* CONFIG_AUDIT */
 	});
 	return -EACCES;
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index e4c530511360..7efe9b172acf 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -63,6 +63,14 @@ struct landlock_file_security {
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
+	optional_access_t quiet_optional_accesses;
 	/**
 	 * @fown_layer: Layer level of @fown_subject->domain with
 	 * LANDLOCK_SCOPE_SIGNAL.
@@ -91,13 +99,18 @@ struct landlock_file_security {
 };
 
 #ifdef CONFIG_AUDIT
-
 /* Makes sure all layers can be identified. */
 /* clang-format off */
 static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
 	      LANDLOCK_MAX_NUM_LAYERS);
-/* clang-format off */
-
+/* clang-format on */
+/*
+ * Make sure quiet_optional_accesses has enough bits to cover all optional
+ * accesses.
+ */
+static_assert(BITS_PER_TYPE(typeof_member(struct landlock_file_security,
+					  quiet_optional_accesses)) >=
+	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
 #endif /* CONFIG_AUDIT */
 
 /**
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 4b4f974dc877..51050dd39a3a 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -250,14 +250,13 @@ static int current_check_access_socket(struct socket *const sock,
 
 	audit_net.family = address->sa_family;
 	audit_net.sk = sock->sk;
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
+					    .layer_masks = &layer_masks });
 	return -EACCES;
 }
 
-- 
2.54.0
