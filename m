Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A21BC3F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Jun 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750003842; cv=none; b=djXIe8UiB3bbLiS/jD6wP2FuQVRrJtECjdj8qoG45214PrHvCyoC1zp7G6zEgLDZlkRDXmbL0nlIkFzMUnvCTz34QjBgTOV44xIYLawa3bVxHNCiumkNPKoxkYQfbY8pORinqRbA0GMvWwJzRxUVv5DxZ9dTR8gCSQHOvAquiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750003842; c=relaxed/simple;
	bh=MxBr4uaRq/wVV/fQQKnZWxwaEcyh2nGYIB8c+FjpOq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLoK9DioK2ZXLAc84R6glWXJZojiJ59CYtgHcsvrSQoph63Lw3syJFSj/pOWDwMAtSM1cLPLcxZJ6uQOR/LWbOukmB4EB/k5j5B036D/roxMtDc465RI3+3K6ruaPMdiC68gEUypSoCGicmzHGzRzL48hqsStGlrpy+04HDKbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=jNcMUDgN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ewzdvAf/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="jNcMUDgN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ewzdvAf/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 94AF611401C3;
	Sun, 15 Jun 2025 12:10:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 15 Jun 2025 12:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1750003837; x=1750090237; bh=VSqQdrCpRqq0FiIFF4nsL
	V3CuC4ZqmONORAZT6kmmEw=; b=jNcMUDgN5J3Tlk7F6v5le4e9mUIasvVCevfZI
	W8Jlh0fHuZEbGOqTkOrHuZQ3SBKnjPWZ1fVUU7f5EInR0UCoTb8uKFWE66qWzDAU
	qGhzYi/o+naJy0CJUpRBFllCuWiI+MDJ14DpPEKJkcai7dzTW2lcqetfPGRnDESi
	6sN42zrBGZfxGPjhHmCUjM9D8bgdI5sg5mNBvQZZeuH4DyIAGflZNn7iVpQ9z8QW
	o/dloKAgAh4emuq/lMAEdKUalCtMEhvjMtVIMPHbLIhikilhEMGyHZBXwsz3M9WC
	ij6VHb5Wc1kfL42fC10yluOKXosRC3Vm0G2RbpvZCLhbvJtVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750003837; x=1750090237; bh=VSqQdrCpRqq0FiIFF4nsLV3CuC4ZqmONORA
	ZT6kmmEw=; b=ewzdvAf/b20+s7fQPdkMqXvYId0cRMq9Kx2cn+gwj6Be6vylFbJ
	j2Bt7d1QIj/KcuvWxV9BWIp1uqD2vdpDfRB5niOlm4s3Pnm0/G3AFFC/LJudtHNK
	PW3g0HfPsu+9MeL3J4Ni3yllvXQ1P5l4/JwuBuTgt5Ain4A8Fna9pbQkRoLe4/dC
	nMt9wVd/dO7A2Px2g+TLwbiHgclj9u51C/sgICke4817dXFak5axMfdUX/5Al9YF
	stKUVD1+ZDX0Mi6+VNaevgQNnRCyg/QOWnIpgGVAiHqn7rOW6+Qq2i6b33FZYWab
	PYpC0zVch7ERkGXGSgPvMDRaT0lw76hQ05A==
X-ME-Sender: <xms:fPBOaDJK7GHrSqG32VmvuLbc5AuoMnoGjmqfAiZuWoux5X8G8gHjUQ>
    <xme:fPBOaHKfUgajpnKAdeoHxYJGPwFfdHsvhL9sIVmjYB3dEgeYH7zbh-JC3Fmai6qXo
    L8RXp2T-LJ1Dn8RdKE>
X-ME-Received: <xmr:fPBOaLun5ry7TPyLcyjIDbdOK39d-Rryu_uQAj-BqhZ71koJHK7S25TOETLPgEzzlMOhIDsnEZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjeevtdekhfevteejkeelgeelieehueeuteelfeetvdeiffeivefg
    keeiieffveegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtoh
    epghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fPBOaMbYLri7jgKqbJxgDST6bMbLIWQorxK7Jmb9jX86G3aXV4Iy6Q>
    <xmx:fPBOaKb0f0k-mJCWl6EJBFxdnFJsTkmO1IPLDUEnqKMW-ec1gybBCA>
    <xmx:fPBOaADrNj_PLYt7zUO3qttPp_4sEe8fFcDGe0Lgf3Z2NYOj_eyi0g>
    <xmx:fPBOaIagIVggTgoTgFgx8nnVctdKnXQK3OA3IuSLGhrg1xM_wZ7N8A>
    <xmx:ffBOaD4kQTzh8DHoFHSF0s87Fy6J2t_JVuNDUgJi41lCxOuPH-uSZY58>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 12:10:35 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] landlock/id: Fix WARNING from kunit tests
Date: Sun, 15 Jun 2025 17:09:36 +0100
Message-ID: <73e28efc5b8cc394608b99d5bc2596ca917d7c4a.1750003733.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like get_random_u8 returned 0 here.  Fix this by clamping it.

(Validated by running the test in a for loop for 1000 times.  Note that
MAX is wrong as it is only supposed to be used for unchanging variables,
but the lowercase version is good here.)

	[..]     ok 9 test_range2_rand1
	[..]     ok 10 test_range2_rand2
	[..]     ok 11 test_range2_rand15
	[..] ------------[ cut here ]------------
	[..] WARNING: CPU: 6 PID: 104 at security/landlock/id.c:99 test_range2_rand16 (security/landlock/id.c:99 (discriminator 1) security/landlock/id.c:234 (discriminator 1))
	[..] Modules linked in:
	[..] CPU: 6 UID: 0 PID: 104 Comm: kunit_try_catch Tainted: G                 N  6.16.0-rc1-dev-00001-g314a2f98b65f #1 PREEMPT(undef)
	[..] Tainted: [N]=TEST
	[..] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
	[..] RIP: 0010:test_range2_rand16 (security/landlock/id.c:99 (discriminator 1) security/landlock/id.c:234 (discriminator 1))
	[..] Code: 49 c7 c0 10 70 30 82 4c 89 ff 48 c7 c6 a0 63 1e 83 49 c7 45 a0 e0 63 1e 83 e8 3f 95 17 00 e9 1f ff ff ff 0f 0b e9 df fd ff ff <0f> 0b ba 01 00 00 00 e9 68 fe ff ff 49 89 45 a8 49 8d 4d a0 45 31
	..
	[..] RSP: 0000:ffff888104eb7c78 EFLAGS: 00010246
	[..] RAX: 0000000000000000 RBX: 000000000870822c RCX: 0000000000000000
	          ^^^^^^^^^^^^^^^^
	[..]
	[..] Call Trace:
	[..]
	[..] ---[ end trace 0000000000000000 ]---
	[..]     ok 12 test_range2_rand16
	[..] # landlock_id: pass:12 fail:0 skip:0 total:12
	[..] # Totals: pass:12 fail:0 skip:0 total:12
	[..] ok 1 landlock_id

Fixes: d9d2a68ed44b ("landlock: Add unique ID generator")
Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/id.c | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/security/landlock/id.c b/security/landlock/id.c
index 56f7cc0fc744..b02a7da2f15d 100644
--- a/security/landlock/id.c
+++ b/security/landlock/id.c
@@ -119,6 +119,12 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
+static u8 get_random_u8_positive(void)
+{
+	/* max evaluates its arguments once */
+	return max(1, get_random_u8());
+}
+
 static void test_range1_rand0(struct kunit *const test)
 {
 	atomic64_t counter;
@@ -127,9 +133,10 @@ static void test_range1_rand0(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 0), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 1);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 1);
 }
 
 static void test_range1_rand1(struct kunit *const test)
@@ -140,9 +147,10 @@ static void test_range1_rand1(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 1), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 2);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 2);
 }
 
 static void test_range1_rand15(struct kunit *const test)
@@ -153,9 +161,10 @@ static void test_range1_rand15(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 15), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 16);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 16);
 }
 
 static void test_range1_rand16(struct kunit *const test)
@@ -166,9 +175,10 @@ static void test_range1_rand16(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 16), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 1);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 1);
 }
 
 static void test_range2_rand0(struct kunit *const test)
@@ -179,9 +189,10 @@ static void test_range2_rand0(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 0), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 2);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 2);
 }
 
 static void test_range2_rand1(struct kunit *const test)
@@ -192,9 +203,10 @@ static void test_range2_rand1(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 1), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 3);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 3);
 }
 
 static void test_range2_rand2(struct kunit *const test)
@@ -205,9 +217,10 @@ static void test_range2_rand2(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 2), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 4);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 4);
 }
 
 static void test_range2_rand15(struct kunit *const test)
@@ -218,9 +231,10 @@ static void test_range2_rand15(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 15), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 17);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 17);
 }
 
 static void test_range2_rand16(struct kunit *const test)
@@ -231,9 +245,10 @@ static void test_range2_rand16(struct kunit *const test)
 	init = get_random_u32();
 	atomic64_set(&counter, init);
 	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 16), init);
-	KUNIT_EXPECT_EQ(
-		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
-		init + 2);
+	KUNIT_EXPECT_EQ(test,
+			get_id_range(get_random_u8_positive(), &counter,
+				     get_random_u8()),
+			init + 2);
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0

