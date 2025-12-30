Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9B21CC7B
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115274; cv=none; b=RSK2E9VlMWRDCbmpQbEZs/cUSoVdeCldBHgU2qxWuY2MrQTFM6dRizBxUpfgpFty1JyErd2a9LuLQ3IPNDxN3eW8kfM//nv0taU8RBE8WymxAUSjzOVS/sG2eniNY0doPyWqT/QfIl9FF9pLIPlc+39vt+VJYEBs1TUa1CrfA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115274; c=relaxed/simple;
	bh=poOPPTH/D8gFoeGPicRjTQpFynL7kE0QZF+FNeqaG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU8tVQhJfI4Ehoi7EwdjVLYFzxoveB6AaBEeQMzTYjB4VsHqSA4In53/RbgPWS+YXs6orrdDuXpOxULGhwGS/YAi5P6gNJXTvPbwJj9hKk20WfkDbgPorBiIlx1RbytR1Jg664YWmbsCalQg6f7DOBA77eWWeVzKpS41ovVP0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=oIZUWHlD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmDQQJXy; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="oIZUWHlD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmDQQJXy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B7A161D00027;
	Tue, 30 Dec 2025 12:21:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Dec 2025 12:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767115270; x=
	1767201670; bh=DBa6bSHSjqexH+IIuxa+HSgxgFAr0KrzE0/lRQalhrI=; b=o
	IZUWHlDhjlteJIPvYaJU2KXpG2oGhxNnAFL+7K1yLKqHq/kYcWvCBD01lQW6T3t1
	E6cIMEUz0+BGH50aES+kLSJZS5ILQbsSHdsa8tUOoQ6RNC5u7lfZxgphyqKMGC9+
	RUg9yRet1ECO9Aihe/aJ02y3kq3Co0J17+vLgwuOEbbOS4z8GFKTDs/gqUijTfv5
	srxzqWjlu4Aa31FrEVLQepby6zIb0dpuXr2JlfkmbJ9jNuDhZAHlD/FguIJ80vaw
	GvMh1UlHcPPo8JDLN8X4UwcG9b8dEA6Ls5X/u4cSy/NdhMDPWPTckS8hzKiYECjz
	Fffz8lvClhrKjTgUXqVKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767115270; x=1767201670; bh=D
	Ba6bSHSjqexH+IIuxa+HSgxgFAr0KrzE0/lRQalhrI=; b=bmDQQJXyEVcQbhPuW
	oQ57MZhlfaTg2LrStpee24PG3r6l7Of2QPitoRPxKGx9UtAs38Lokf1x5h4FtrfQ
	6rlgXEagSDjwcCKS/S2NOyX7WC5lAC+aEYbdA+RtotHHrSD6a6KCD05ias1pIKOT
	I7VyR6uRxI2cAxZj51LMQoMx1CNHh7ZLa+1eGHuaqhGGjDux1okORHl3oISaICUD
	KcGC01Pc1A+gPgjCQDvRbSgYebpKQiCeB7QcI6fdPDp5Zt1zamsRbDGzQ+SG7mPy
	o4rwgKhwoqaXiY8b7AGtsKiUv14nmV72g/9dNJ4hp7qWwYBrs6cyVjSPuHH428ah
	sOFzg==
X-ME-Sender: <xms:BgpUaT8oEQpVzxSyj3AblZoB_MrfKjUa6T1HWiAYxZOvkf8vKSbW5w>
    <xme:BgpUaSSdPqIZodUddi5gkN1TfzMggnR1vGj78Yqg7y3eGv2FcX4ftgu1H4Va7oiRG
    skrPuvleSGZTUxrepO7pdJ5gz4ECZVrDQLQvzv6_BcvV5uh1icavA>
X-ME-Received: <xmr:BgpUaUoVJfIY8BXlgTL8w12snxqY36BfBFw4RGFaSIfehWA0xddPNzNVkm7vqrQX9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    vghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlhihsh
    hsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhtih
    hlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhs
    vggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BgpUaflBr0SXpNrVHcJJ8Bm4fPg8LWxiEW18uOzhC5l9idGQioBMUQ>
    <xmx:BgpUadf88PSOLL3tB90swZqy4mp19g2kEZzLV9eAvoJlZckwcKSK0Q>
    <xmx:BgpUabqHmmfchEw3f5AU1cLDzY3y0IrRgqTb4JCvvpQZcTH25-7gVw>
    <xmx:BgpUaXPiOycHGaNu72Wg1Nqk9bpnIWbdDnyxCpxbTN4R8_DD6jryZA>
    <xmx:BgpUaVIdOCeK9Stdi-vDcCV6UjPx29Gvc7aHHLa2IEW7vii2PawtRMpu>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 12:21:09 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 6/6] selftests/landlock: Add pathname socket variants for more tests
Date: Tue, 30 Dec 2025 17:20:24 +0000
Message-ID: <88de5bed60b06ba97088d87803f7bb3dbcc9a808.1767115163.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767115163.git.m@maowtm.org>
References: <cover.1767115163.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this produces a lot of change, it does allow us to "simultaneously"
test both abstract and pathname UNIX sockets with reletively little code
duplication, since they are really similar.

Tests touched: scoped_vs_unscoped, outside_socket,
various_address_sockets, datagram_sockets, self_connect.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 .../selftests/landlock/scoped_unix_test.c     | 599 ++++++++++++------
 1 file changed, 395 insertions(+), 204 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_unix_test.c b/tools/testing/selftests/landlock/scoped_unix_test.c
index 669418c97509..6d1541f77dbe 100644
--- a/tools/testing/selftests/landlock/scoped_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_unix_test.c
@@ -536,8 +536,12 @@ TEST_F(scoped_audit, connect_to_child)
 
 FIXTURE(scoped_vs_unscoped)
 {
-	struct service_fixture parent_stream_address, parent_dgram_address,
-		child_stream_address, child_dgram_address;
+	struct service_fixture parent_stream_address_abstract,
+		parent_dgram_address_abstract, child_stream_address_abstract,
+		child_dgram_address_abstract;
+	struct service_fixture parent_stream_address_pathname,
+		parent_dgram_address_pathname, child_stream_address_pathname,
+		child_dgram_address_pathname;
 };
 
 #include "scoped_multiple_domain_variants.h"
@@ -546,35 +550,75 @@ FIXTURE_SETUP(scoped_vs_unscoped)
 {
 	drop_caps(_metadata);
 
-	memset(&self->parent_stream_address, 0,
-	       sizeof(self->parent_stream_address));
-	set_unix_address(&self->parent_stream_address, 0, true);
-	memset(&self->parent_dgram_address, 0,
-	       sizeof(self->parent_dgram_address));
-	set_unix_address(&self->parent_dgram_address, 1, true);
-	memset(&self->child_stream_address, 0,
-	       sizeof(self->child_stream_address));
-	set_unix_address(&self->child_stream_address, 2, true);
-	memset(&self->child_dgram_address, 0,
-	       sizeof(self->child_dgram_address));
-	set_unix_address(&self->child_dgram_address, 3, true);
+	ASSERT_EQ(0, mkdir(PATHNAME_UNIX_SOCK_DIR, 0700));
+
+	/* Abstract addresses. */
+	memset(&self->parent_stream_address_abstract, 0,
+	       sizeof(self->parent_stream_address_abstract));
+	set_unix_address(&self->parent_stream_address_abstract, 0, true);
+	memset(&self->parent_dgram_address_abstract, 0,
+	       sizeof(self->parent_dgram_address_abstract));
+	set_unix_address(&self->parent_dgram_address_abstract, 1, true);
+	memset(&self->child_stream_address_abstract, 0,
+	       sizeof(self->child_stream_address_abstract));
+	set_unix_address(&self->child_stream_address_abstract, 2, true);
+	memset(&self->child_dgram_address_abstract, 0,
+	       sizeof(self->child_dgram_address_abstract));
+	set_unix_address(&self->child_dgram_address_abstract, 3, true);
+
+	/* Pathname addresses. */
+	memset(&self->parent_stream_address_pathname, 0,
+	       sizeof(self->parent_stream_address_pathname));
+	set_unix_address(&self->parent_stream_address_pathname, 4, false);
+	memset(&self->parent_dgram_address_pathname, 0,
+	       sizeof(self->parent_dgram_address_pathname));
+	set_unix_address(&self->parent_dgram_address_pathname, 5, false);
+	memset(&self->child_stream_address_pathname, 0,
+	       sizeof(self->child_stream_address_pathname));
+	set_unix_address(&self->child_stream_address_pathname, 6, false);
+	memset(&self->child_dgram_address_pathname, 0,
+	       sizeof(self->child_dgram_address_pathname));
+	set_unix_address(&self->child_dgram_address_pathname, 7, false);
 }
 
 FIXTURE_TEARDOWN(scoped_vs_unscoped)
 {
+	EXPECT_EQ(0, remove_path(self->parent_stream_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, remove_path(self->parent_dgram_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, remove_path(self->child_stream_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, remove_path(self->child_dgram_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
 }
 
 /*
  * Test unix_stream_connect and unix_may_send for parent, child and
  * grand child processes when they can have scoped or non-scoped domains.
  */
-TEST_F(scoped_vs_unscoped, unix_scoping)
+static void test_scoped_vs_unscoped(
+	struct __test_metadata *const _metadata,
+	FIXTURE_DATA(scoped_vs_unscoped) * self,
+	const FIXTURE_VARIANT(scoped_vs_unscoped) * variant,
+	const bool abstract)
 {
 	pid_t child;
 	int status;
 	bool can_connect_to_parent, can_connect_to_child;
 	int pipe_parent[2];
 	int stream_server_parent, dgram_server_parent;
+	const __u16 scope = abstract ? LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET :
+				       LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+	const struct service_fixture *parent_stream_address =
+		abstract ? &self->parent_stream_address_abstract :
+			   &self->parent_stream_address_pathname;
+	const struct service_fixture *parent_dgram_address =
+		abstract ? &self->parent_dgram_address_abstract :
+			   &self->parent_dgram_address_pathname;
+	const struct service_fixture *child_stream_address =
+		abstract ? &self->child_stream_address_abstract :
+			   &self->child_stream_address_pathname;
+	const struct service_fixture *child_dgram_address =
+		abstract ? &self->child_dgram_address_abstract :
+			   &self->child_dgram_address_pathname;
 
 	can_connect_to_child = (variant->domain_grand_child != SCOPE_SANDBOX);
 	can_connect_to_parent = (can_connect_to_child &&
@@ -585,8 +629,7 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 	if (variant->domain_all == OTHER_SANDBOX)
 		create_fs_domain(_metadata);
 	else if (variant->domain_all == SCOPE_SANDBOX)
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 	child = fork();
 	ASSERT_LE(0, child);
@@ -600,8 +643,7 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		if (variant->domain_children == OTHER_SANDBOX)
 			create_fs_domain(_metadata);
 		else if (variant->domain_children == SCOPE_SANDBOX)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			create_scoped_domain(_metadata, scope);
 
 		grand_child = fork();
 		ASSERT_LE(0, grand_child);
@@ -616,9 +658,7 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 			if (variant->domain_grand_child == OTHER_SANDBOX)
 				create_fs_domain(_metadata);
 			else if (variant->domain_grand_child == SCOPE_SANDBOX)
-				create_scoped_domain(
-					_metadata,
-					LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				create_scoped_domain(_metadata, scope);
 
 			stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
 			ASSERT_LE(0, stream_client);
@@ -626,15 +666,13 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 			ASSERT_LE(0, dgram_client);
 
 			ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
-			stream_err = connect(
-				stream_client,
-				&self->child_stream_address.unix_addr,
-				self->child_stream_address.unix_addr_len);
+			stream_err = connect(stream_client,
+					     &child_stream_address->unix_addr,
+					     child_stream_address->unix_addr_len);
 			stream_errno = errno;
-			dgram_err = connect(
-				dgram_client,
-				&self->child_dgram_address.unix_addr,
-				self->child_dgram_address.unix_addr_len);
+			dgram_err = connect(dgram_client,
+					    &child_dgram_address->unix_addr,
+					    child_dgram_address->unix_addr_len);
 			dgram_errno = errno;
 			if (can_connect_to_child) {
 				EXPECT_EQ(0, stream_err);
@@ -653,14 +691,12 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 
 			ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
 			stream_err = connect(
-				stream_client,
-				&self->parent_stream_address.unix_addr,
-				self->parent_stream_address.unix_addr_len);
+				stream_client, &parent_stream_address->unix_addr,
+				parent_stream_address->unix_addr_len);
 			stream_errno = errno;
 			dgram_err = connect(
-				dgram_client,
-				&self->parent_dgram_address.unix_addr,
-				self->parent_dgram_address.unix_addr_len);
+				dgram_client, &parent_dgram_address->unix_addr,
+				parent_dgram_address->unix_addr_len);
 			dgram_errno = errno;
 			if (can_connect_to_parent) {
 				EXPECT_EQ(0, stream_err);
@@ -681,8 +717,7 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		if (variant->domain_child == OTHER_SANDBOX)
 			create_fs_domain(_metadata);
 		else if (variant->domain_child == SCOPE_SANDBOX)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			create_scoped_domain(_metadata, scope);
 
 		stream_server_child = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_server_child);
@@ -690,11 +725,11 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		ASSERT_LE(0, dgram_server_child);
 
 		ASSERT_EQ(0, bind(stream_server_child,
-				  &self->child_stream_address.unix_addr,
-				  self->child_stream_address.unix_addr_len));
-		ASSERT_EQ(0, bind(dgram_server_child,
-				  &self->child_dgram_address.unix_addr,
-				  self->child_dgram_address.unix_addr_len));
+				  &child_stream_address->unix_addr,
+				  child_stream_address->unix_addr_len));
+		ASSERT_EQ(0,
+			  bind(dgram_server_child, &child_dgram_address->unix_addr,
+			       child_dgram_address->unix_addr_len));
 		ASSERT_EQ(0, listen(stream_server_child, backlog));
 
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
@@ -708,19 +743,16 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 	if (variant->domain_parent == OTHER_SANDBOX)
 		create_fs_domain(_metadata);
 	else if (variant->domain_parent == SCOPE_SANDBOX)
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 	stream_server_parent = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_server_parent);
 	dgram_server_parent = socket(AF_UNIX, SOCK_DGRAM, 0);
 	ASSERT_LE(0, dgram_server_parent);
-	ASSERT_EQ(0, bind(stream_server_parent,
-			  &self->parent_stream_address.unix_addr,
-			  self->parent_stream_address.unix_addr_len));
-	ASSERT_EQ(0, bind(dgram_server_parent,
-			  &self->parent_dgram_address.unix_addr,
-			  self->parent_dgram_address.unix_addr_len));
+	ASSERT_EQ(0, bind(stream_server_parent, &parent_stream_address->unix_addr,
+			  parent_stream_address->unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_server_parent, &parent_dgram_address->unix_addr,
+			  parent_dgram_address->unix_addr_len));
 
 	ASSERT_EQ(0, listen(stream_server_parent, backlog));
 
@@ -734,57 +766,119 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+TEST_F(scoped_vs_unscoped, unix_scoping_abstract)
+{
+	test_scoped_vs_unscoped(_metadata, self, variant, true);
+}
+
+TEST_F(scoped_vs_unscoped, unix_scoping_pathname)
+{
+	test_scoped_vs_unscoped(_metadata, self, variant, false);
+}
+
 FIXTURE(outside_socket)
 {
-	struct service_fixture address, transit_address;
+	struct service_fixture address_abstract, transit_address_abstract;
+	struct service_fixture address_pathname, transit_address_pathname;
 };
 
 FIXTURE_VARIANT(outside_socket)
 {
 	const bool child_socket;
 	const int type;
+	const bool abstract;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, abstract_allow_dgram_child) {
+	/* clang-format on */
+	.child_socket = true,
+	.type = SOCK_DGRAM,
+	.abstract = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, abstract_deny_dgram_server) {
+	/* clang-format on */
+	.child_socket = false,
+	.type = SOCK_DGRAM,
+	.abstract = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, abstract_allow_stream_child) {
+	/* clang-format on */
+	.child_socket = true,
+	.type = SOCK_STREAM,
+	.abstract = true,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(outside_socket, allow_dgram_child) {
+FIXTURE_VARIANT_ADD(outside_socket, abstract_deny_stream_server) {
+	/* clang-format on */
+	.child_socket = false,
+	.type = SOCK_STREAM,
+	.abstract = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(outside_socket, pathname_allow_dgram_child) {
 	/* clang-format on */
 	.child_socket = true,
 	.type = SOCK_DGRAM,
+	.abstract = false,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(outside_socket, deny_dgram_server) {
+FIXTURE_VARIANT_ADD(outside_socket, pathname_deny_dgram_server) {
 	/* clang-format on */
 	.child_socket = false,
 	.type = SOCK_DGRAM,
+	.abstract = false,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(outside_socket, allow_stream_child) {
+FIXTURE_VARIANT_ADD(outside_socket, pathname_allow_stream_child) {
 	/* clang-format on */
 	.child_socket = true,
 	.type = SOCK_STREAM,
+	.abstract = false,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(outside_socket, deny_stream_server) {
+FIXTURE_VARIANT_ADD(outside_socket, pathname_deny_stream_server) {
 	/* clang-format on */
 	.child_socket = false,
 	.type = SOCK_STREAM,
+	.abstract = false,
 };
 
 FIXTURE_SETUP(outside_socket)
 {
 	drop_caps(_metadata);
 
-	memset(&self->transit_address, 0, sizeof(self->transit_address));
-	set_unix_address(&self->transit_address, 0, true);
-	memset(&self->address, 0, sizeof(self->address));
-	set_unix_address(&self->address, 1, true);
+	ASSERT_EQ(0, mkdir(PATHNAME_UNIX_SOCK_DIR, 0700));
+
+	/* Abstract addresses. */
+	memset(&self->transit_address_abstract, 0,
+	       sizeof(self->transit_address_abstract));
+	set_unix_address(&self->transit_address_abstract, 0, true);
+	memset(&self->address_abstract, 0, sizeof(self->address_abstract));
+	set_unix_address(&self->address_abstract, 1, true);
+
+	/* Pathname addresses. */
+	memset(&self->transit_address_pathname, 0,
+	       sizeof(self->transit_address_pathname));
+	set_unix_address(&self->transit_address_pathname, 2, false);
+	memset(&self->address_pathname, 0, sizeof(self->address_pathname));
+	set_unix_address(&self->address_pathname, 3, false);
 }
 
 FIXTURE_TEARDOWN(outside_socket)
 {
+	EXPECT_EQ(0, remove_path(self->transit_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, remove_path(self->address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
 }
 
 /*
@@ -798,6 +892,15 @@ TEST_F(outside_socket, socket_with_different_domain)
 	int pipe_child[2], pipe_parent[2];
 	char buf_parent;
 	int server_socket;
+	const __u16 scope = variant->abstract ?
+				    LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET :
+				    LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+	const struct service_fixture *transit_address =
+		variant->abstract ? &self->transit_address_abstract :
+				    &self->transit_address_pathname;
+	const struct service_fixture *address =
+		variant->abstract ? &self->address_abstract :
+				    &self->address_pathname;
 
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
@@ -812,8 +915,7 @@ TEST_F(outside_socket, socket_with_different_domain)
 		EXPECT_EQ(0, close(pipe_child[0]));
 
 		/* Client always has a domain. */
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 		if (variant->child_socket) {
 			int data_socket, passed_socket, stream_server;
@@ -823,8 +925,8 @@ TEST_F(outside_socket, socket_with_different_domain)
 			stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
 			ASSERT_LE(0, stream_server);
 			ASSERT_EQ(0, bind(stream_server,
-					  &self->transit_address.unix_addr,
-					  self->transit_address.unix_addr_len));
+					  &transit_address->unix_addr,
+					  transit_address->unix_addr_len));
 			ASSERT_EQ(0, listen(stream_server, backlog));
 			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 			data_socket = accept(stream_server, NULL, NULL);
@@ -839,8 +941,8 @@ TEST_F(outside_socket, socket_with_different_domain)
 
 		/* Waits for parent signal for connection. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
-		err = connect(client_socket, &self->address.unix_addr,
-			      self->address.unix_addr_len);
+		err = connect(client_socket, &address->unix_addr,
+			      address->unix_addr_len);
 		if (variant->child_socket) {
 			EXPECT_EQ(0, err);
 		} else {
@@ -859,9 +961,8 @@ TEST_F(outside_socket, socket_with_different_domain)
 
 		ASSERT_LE(0, client_child);
 		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
-		ASSERT_EQ(0, connect(client_child,
-				     &self->transit_address.unix_addr,
-				     self->transit_address.unix_addr_len));
+		ASSERT_EQ(0, connect(client_child, &transit_address->unix_addr,
+				     transit_address->unix_addr_len));
 		server_socket = recv_fd(client_child);
 		EXPECT_EQ(0, close(client_child));
 	} else {
@@ -870,10 +971,10 @@ TEST_F(outside_socket, socket_with_different_domain)
 	ASSERT_LE(0, server_socket);
 
 	/* Server always has a domain. */
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	create_scoped_domain(_metadata, scope);
 
-	ASSERT_EQ(0, bind(server_socket, &self->address.unix_addr,
-			  self->address.unix_addr_len));
+	ASSERT_EQ(0,
+		  bind(server_socket, &address->unix_addr, address->unix_addr_len));
 	if (variant->type == SOCK_STREAM)
 		ASSERT_EQ(0, listen(server_socket, backlog));
 
@@ -888,52 +989,85 @@ TEST_F(outside_socket, socket_with_different_domain)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
-static const char stream_path[] = TMP_DIR "/stream.sock";
-static const char dgram_path[] = TMP_DIR "/dgram.sock";
-
 /* clang-format off */
-FIXTURE(various_address_sockets) {};
+FIXTURE(various_address_sockets) {
+	struct service_fixture stream_pathname_addr, dgram_pathname_addr;
+	struct service_fixture stream_abstract_addr, dgram_abstract_addr;
+};
 /* clang-format on */
 
-FIXTURE_VARIANT(various_address_sockets)
-{
-	const int domain;
+/*
+ * Test all 4 combinations of abstract and pathname socket scope bits,
+ * plus a case with no Landlock domain at all.
+ */
+/* clang-format off */
+FIXTURE_VARIANT(various_address_sockets) {
+	/* clang-format on */
+	const __u16 scope_bits;
+	const bool no_sandbox;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(various_address_sockets, scope_abstract) {
+	/* clang-format on */
+	.scope_bits = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(various_address_sockets, scope_pathname) {
+	/* clang-format on */
+	.scope_bits = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(various_address_sockets, pathname_socket_scoped_domain) {
+FIXTURE_VARIANT_ADD(various_address_sockets, scope_both) {
 	/* clang-format on */
-	.domain = SCOPE_SANDBOX,
+	.scope_bits = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+		      LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(various_address_sockets, pathname_socket_other_domain) {
+FIXTURE_VARIANT_ADD(various_address_sockets, scope_none) {
 	/* clang-format on */
-	.domain = OTHER_SANDBOX,
+	.scope_bits = 0,
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(various_address_sockets, pathname_socket_no_domain) {
+FIXTURE_VARIANT_ADD(various_address_sockets, no_domain) {
 	/* clang-format on */
-	.domain = NO_SANDBOX,
+	.no_sandbox = true,
 };
 
 FIXTURE_SETUP(various_address_sockets)
 {
 	drop_caps(_metadata);
 
-	umask(0077);
-	ASSERT_EQ(0, mkdir(TMP_DIR, 0700));
+	ASSERT_EQ(0, mkdir(PATHNAME_UNIX_SOCK_DIR, 0700));
+
+	memset(&self->stream_pathname_addr, 0, sizeof(self->stream_pathname_addr));
+	set_unix_address(&self->stream_pathname_addr, 0, false);
+	memset(&self->dgram_pathname_addr, 0, sizeof(self->dgram_pathname_addr));
+	set_unix_address(&self->dgram_pathname_addr, 1, false);
+
+	memset(&self->stream_abstract_addr, 0, sizeof(self->stream_abstract_addr));
+	set_unix_address(&self->stream_abstract_addr, 2, true);
+	memset(&self->dgram_abstract_addr, 0, sizeof(self->dgram_abstract_addr));
+	set_unix_address(&self->dgram_abstract_addr, 3, true);
 }
 
 FIXTURE_TEARDOWN(various_address_sockets)
 {
-	EXPECT_EQ(0, unlink(stream_path));
-	EXPECT_EQ(0, unlink(dgram_path));
-	EXPECT_EQ(0, rmdir(TMP_DIR));
+	EXPECT_EQ(0, remove_path(self->stream_pathname_addr.unix_addr.sun_path));
+	EXPECT_EQ(0, remove_path(self->dgram_pathname_addr.unix_addr.sun_path));
+	EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
 }
 
-TEST_F(various_address_sockets, scoped_pathname_sockets)
+/*
+ * Test interaction of various scope flags (controlled by variant->domain)
+ * with pathname and abstract sockets when connecting from a sandboxed
+ * child.
+ */
+TEST_F(various_address_sockets, scoped_sockets)
 {
 	pid_t child;
 	int status;
@@ -942,25 +1076,10 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 	int unnamed_sockets[2];
 	int stream_pathname_socket, dgram_pathname_socket,
 		stream_abstract_socket, dgram_abstract_socket, data_socket;
-	struct service_fixture stream_abstract_addr, dgram_abstract_addr;
-	struct sockaddr_un stream_pathname_addr = {
-		.sun_family = AF_UNIX,
-	};
-	struct sockaddr_un dgram_pathname_addr = {
-		.sun_family = AF_UNIX,
-	};
-
-	/* Pathname address. */
-	snprintf(stream_pathname_addr.sun_path,
-		 sizeof(stream_pathname_addr.sun_path), "%s", stream_path);
-	snprintf(dgram_pathname_addr.sun_path,
-		 sizeof(dgram_pathname_addr.sun_path), "%s", dgram_path);
-
-	/* Abstract address. */
-	memset(&stream_abstract_addr, 0, sizeof(stream_abstract_addr));
-	set_unix_address(&stream_abstract_addr, 0, true);
-	memset(&dgram_abstract_addr, 0, sizeof(dgram_abstract_addr));
-	set_unix_address(&dgram_abstract_addr, 1, true);
+	bool pathname_restricted =
+		(variant->scope_bits & LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET);
+	bool abstract_restricted =
+		(variant->scope_bits & LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 
 	/* Unnamed address for datagram socket. */
 	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_DGRAM, 0, unnamed_sockets));
@@ -975,82 +1094,103 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		EXPECT_EQ(0, close(unnamed_sockets[1]));
 
-		if (variant->domain == SCOPE_SANDBOX)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
-		else if (variant->domain == OTHER_SANDBOX)
+		/* Create domain based on variant. */
+		if (variant->scope_bits)
+			create_scoped_domain(_metadata, variant->scope_bits);
+		else if (!variant->no_sandbox)
 			create_fs_domain(_metadata);
 
 		/* Waits for parent to listen. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 		EXPECT_EQ(0, close(pipe_parent[0]));
 
-		/* Checks that we can send data through a datagram socket. */
+		/* Checks that we can send data through a unnamed socket. */
 		ASSERT_EQ(1, write(unnamed_sockets[0], "a", 1));
 		EXPECT_EQ(0, close(unnamed_sockets[0]));
 
 		/* Connects with pathname sockets. */
 		stream_pathname_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_pathname_socket);
-		ASSERT_EQ(0,
-			  connect(stream_pathname_socket, &stream_pathname_addr,
-				  sizeof(stream_pathname_addr)));
-		ASSERT_EQ(1, write(stream_pathname_socket, "b", 1));
+		err = connect(stream_pathname_socket,
+			      &self->stream_pathname_addr.unix_addr,
+			      self->stream_pathname_addr.unix_addr_len);
+		if (pathname_restricted) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+			ASSERT_EQ(1, write(stream_pathname_socket, "b", 1));
+		}
 		EXPECT_EQ(0, close(stream_pathname_socket));
 
-		/* Sends without connection. */
+		/* Sends without connection (pathname). */
 		dgram_pathname_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 		ASSERT_LE(0, dgram_pathname_socket);
 		err = sendto(dgram_pathname_socket, "c", 1, 0,
-			     &dgram_pathname_addr, sizeof(dgram_pathname_addr));
-		EXPECT_EQ(1, err);
+			     &self->dgram_pathname_addr.unix_addr,
+			     self->dgram_pathname_addr.unix_addr_len);
+		if (pathname_restricted) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(1, err);
+		}
+
+		/* Sends with connection (pathname). */
+		err = connect(dgram_pathname_socket,
+			      &self->dgram_pathname_addr.unix_addr,
+			      self->dgram_pathname_addr.unix_addr_len);
+		if (pathname_restricted) {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, err);
+			ASSERT_EQ(1, write(dgram_pathname_socket, "d", 1));
+		}
 
-		/* Sends with connection. */
-		ASSERT_EQ(0,
-			  connect(dgram_pathname_socket, &dgram_pathname_addr,
-				  sizeof(dgram_pathname_addr)));
-		ASSERT_EQ(1, write(dgram_pathname_socket, "d", 1));
 		EXPECT_EQ(0, close(dgram_pathname_socket));
 
 		/* Connects with abstract sockets. */
 		stream_abstract_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_abstract_socket);
 		err = connect(stream_abstract_socket,
-			      &stream_abstract_addr.unix_addr,
-			      stream_abstract_addr.unix_addr_len);
-		if (variant->domain == SCOPE_SANDBOX) {
+			      &self->stream_abstract_addr.unix_addr,
+			      self->stream_abstract_addr.unix_addr_len);
+		if (abstract_restricted) {
 			EXPECT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(0, err);
 			ASSERT_EQ(1, write(stream_abstract_socket, "e", 1));
 		}
+
 		EXPECT_EQ(0, close(stream_abstract_socket));
 
-		/* Sends without connection. */
+		/* Sends without connection (abstract). */
 		dgram_abstract_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 		ASSERT_LE(0, dgram_abstract_socket);
 		err = sendto(dgram_abstract_socket, "f", 1, 0,
-			     &dgram_abstract_addr.unix_addr,
-			     dgram_abstract_addr.unix_addr_len);
-		if (variant->domain == SCOPE_SANDBOX) {
+			     &self->dgram_abstract_addr.unix_addr,
+			     self->dgram_abstract_addr.unix_addr_len);
+		if (abstract_restricted) {
 			EXPECT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(1, err);
 		}
 
-		/* Sends with connection. */
+		/* Sends with connection (abstract). */
 		err = connect(dgram_abstract_socket,
-			      &dgram_abstract_addr.unix_addr,
-			      dgram_abstract_addr.unix_addr_len);
-		if (variant->domain == SCOPE_SANDBOX) {
+			      &self->dgram_abstract_addr.unix_addr,
+			      self->dgram_abstract_addr.unix_addr_len);
+		if (abstract_restricted) {
 			EXPECT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(0, err);
 			ASSERT_EQ(1, write(dgram_abstract_socket, "g", 1));
 		}
+
 		EXPECT_EQ(0, close(dgram_abstract_socket));
 
 		_exit(_metadata->exit_code);
@@ -1062,27 +1202,30 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 	/* Sets up pathname servers. */
 	stream_pathname_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_pathname_socket);
-	ASSERT_EQ(0, bind(stream_pathname_socket, &stream_pathname_addr,
-			  sizeof(stream_pathname_addr)));
+	ASSERT_EQ(0, bind(stream_pathname_socket,
+			  &self->stream_pathname_addr.unix_addr,
+			  self->stream_pathname_addr.unix_addr_len));
 	ASSERT_EQ(0, listen(stream_pathname_socket, backlog));
 
 	dgram_pathname_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 	ASSERT_LE(0, dgram_pathname_socket);
-	ASSERT_EQ(0, bind(dgram_pathname_socket, &dgram_pathname_addr,
-			  sizeof(dgram_pathname_addr)));
+	ASSERT_EQ(0, bind(dgram_pathname_socket,
+			  &self->dgram_pathname_addr.unix_addr,
+			  self->dgram_pathname_addr.unix_addr_len));
 
 	/* Sets up abstract servers. */
 	stream_abstract_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_abstract_socket);
-	ASSERT_EQ(0,
-		  bind(stream_abstract_socket, &stream_abstract_addr.unix_addr,
-		       stream_abstract_addr.unix_addr_len));
+	ASSERT_EQ(0, bind(stream_abstract_socket,
+			  &self->stream_abstract_addr.unix_addr,
+			  self->stream_abstract_addr.unix_addr_len));
+	ASSERT_EQ(0, listen(stream_abstract_socket, backlog));
 
 	dgram_abstract_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 	ASSERT_LE(0, dgram_abstract_socket);
-	ASSERT_EQ(0, bind(dgram_abstract_socket, &dgram_abstract_addr.unix_addr,
-			  dgram_abstract_addr.unix_addr_len));
-	ASSERT_EQ(0, listen(stream_abstract_socket, backlog));
+	ASSERT_EQ(0, bind(dgram_abstract_socket,
+			  &self->dgram_abstract_addr.unix_addr,
+			  self->dgram_abstract_addr.unix_addr_len));
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	EXPECT_EQ(0, close(pipe_parent[1]));
@@ -1092,24 +1235,31 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 	ASSERT_EQ('a', buf_parent);
 	EXPECT_LE(0, close(unnamed_sockets[1]));
 
-	/* Reads from pathname sockets. */
-	data_socket = accept(stream_pathname_socket, NULL, NULL);
-	ASSERT_LE(0, data_socket);
-	ASSERT_EQ(1, read(data_socket, &buf_parent, sizeof(buf_parent)));
-	ASSERT_EQ('b', buf_parent);
-	EXPECT_EQ(0, close(data_socket));
-	EXPECT_EQ(0, close(stream_pathname_socket));
+	if (!pathname_restricted) {
+		/*
+		 * Reads from pathname sockets if we expect child to be able to
+		 * send.
+		 */
+		data_socket = accept(stream_pathname_socket, NULL, NULL);
+		ASSERT_LE(0, data_socket);
+		ASSERT_EQ(1,
+			  read(data_socket, &buf_parent, sizeof(buf_parent)));
+		ASSERT_EQ('b', buf_parent);
+		EXPECT_EQ(0, close(data_socket));
 
-	ASSERT_EQ(1,
-		  read(dgram_pathname_socket, &buf_parent, sizeof(buf_parent)));
-	ASSERT_EQ('c', buf_parent);
-	ASSERT_EQ(1,
-		  read(dgram_pathname_socket, &buf_parent, sizeof(buf_parent)));
-	ASSERT_EQ('d', buf_parent);
-	EXPECT_EQ(0, close(dgram_pathname_socket));
+		ASSERT_EQ(1, read(dgram_pathname_socket, &buf_parent,
+				  sizeof(buf_parent)));
+		ASSERT_EQ('c', buf_parent);
+		ASSERT_EQ(1, read(dgram_pathname_socket, &buf_parent,
+				  sizeof(buf_parent)));
+		ASSERT_EQ('d', buf_parent);
+	}
 
-	if (variant->domain != SCOPE_SANDBOX) {
-		/* Reads from abstract sockets if allowed to send. */
+	if (!abstract_restricted) {
+		/*
+		 * Reads from abstract sockets if we expect child to be able to
+		 * send.
+		 */
 		data_socket = accept(stream_abstract_socket, NULL, NULL);
 		ASSERT_LE(0, data_socket);
 		ASSERT_EQ(1,
@@ -1125,30 +1275,73 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 		ASSERT_EQ('g', buf_parent);
 	}
 
-	/* Waits for all abstract socket tests. */
+	/* Waits for child to complete, and only close the socket afterwards. */
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	EXPECT_EQ(0, close(stream_abstract_socket));
 	EXPECT_EQ(0, close(dgram_abstract_socket));
+	EXPECT_EQ(0, close(stream_pathname_socket));
+	EXPECT_EQ(0, close(dgram_pathname_socket));
 
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
-TEST(datagram_sockets)
+/* Fixture for datagram_sockets and self_connect tests */
+FIXTURE(socket_type_test)
 {
 	struct service_fixture connected_addr, non_connected_addr;
+};
+
+FIXTURE_VARIANT(socket_type_test)
+{
+	const bool abstract;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(socket_type_test, abstract) {
+	/* clang-format on */
+	.abstract = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(socket_type_test, pathname) {
+	/* clang-format on */
+	.abstract = false,
+};
+
+FIXTURE_SETUP(socket_type_test)
+{
+	drop_caps(_metadata);
+
+	if (!variant->abstract)
+		ASSERT_EQ(0, mkdir(PATHNAME_UNIX_SOCK_DIR, 0700));
+
+	memset(&self->connected_addr, 0, sizeof(self->connected_addr));
+	set_unix_address(&self->connected_addr, 0, variant->abstract);
+	memset(&self->non_connected_addr, 0, sizeof(self->non_connected_addr));
+	set_unix_address(&self->non_connected_addr, 1, variant->abstract);
+}
+
+FIXTURE_TEARDOWN(socket_type_test)
+{
+	if (!variant->abstract) {
+		EXPECT_EQ(0, remove_path(self->connected_addr.unix_addr.sun_path));
+		EXPECT_EQ(0, remove_path(self->non_connected_addr.unix_addr.sun_path));
+		EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
+	}
+}
+
+TEST_F(socket_type_test, datagram_sockets)
+{
 	int server_conn_socket, server_unconn_socket;
 	int pipe_parent[2], pipe_child[2];
 	int status;
 	char buf;
 	pid_t child;
-
-	drop_caps(_metadata);
-	memset(&connected_addr, 0, sizeof(connected_addr));
-	set_unix_address(&connected_addr, 0, true);
-	memset(&non_connected_addr, 0, sizeof(non_connected_addr));
-	set_unix_address(&non_connected_addr, 1, true);
+	const __u16 scope = variant->abstract ?
+				    LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET :
+				    LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
 
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
@@ -1169,8 +1362,9 @@ TEST(datagram_sockets)
 		/* Waits for parent to listen. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
 		ASSERT_EQ(0,
-			  connect(client_conn_socket, &connected_addr.unix_addr,
-				  connected_addr.unix_addr_len));
+			  connect(client_conn_socket,
+				  &self->connected_addr.unix_addr,
+				  self->connected_addr.unix_addr_len));
 
 		/*
 		 * Both connected and non-connected sockets can send data when
@@ -1178,13 +1372,12 @@ TEST(datagram_sockets)
 		 */
 		ASSERT_EQ(1, send(client_conn_socket, ".", 1, 0));
 		ASSERT_EQ(1, sendto(client_unconn_socket, ".", 1, 0,
-				    &non_connected_addr.unix_addr,
-				    non_connected_addr.unix_addr_len));
+				    &self->non_connected_addr.unix_addr,
+				    self->non_connected_addr.unix_addr_len));
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
 		/* Scopes the domain. */
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 		/*
 		 * Connected socket sends data to the receiver, but the
@@ -1192,8 +1385,8 @@ TEST(datagram_sockets)
 		 */
 		ASSERT_EQ(1, send(client_conn_socket, ".", 1, 0));
 		ASSERT_EQ(-1, sendto(client_unconn_socket, ".", 1, 0,
-				     &non_connected_addr.unix_addr,
-				     non_connected_addr.unix_addr_len));
+				     &self->non_connected_addr.unix_addr,
+				     self->non_connected_addr.unix_addr_len));
 		ASSERT_EQ(EPERM, errno);
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
@@ -1210,10 +1403,11 @@ TEST(datagram_sockets)
 	ASSERT_LE(0, server_conn_socket);
 	ASSERT_LE(0, server_unconn_socket);
 
-	ASSERT_EQ(0, bind(server_conn_socket, &connected_addr.unix_addr,
-			  connected_addr.unix_addr_len));
-	ASSERT_EQ(0, bind(server_unconn_socket, &non_connected_addr.unix_addr,
-			  non_connected_addr.unix_addr_len));
+	ASSERT_EQ(0, bind(server_conn_socket, &self->connected_addr.unix_addr,
+			  self->connected_addr.unix_addr_len));
+	ASSERT_EQ(0, bind(server_unconn_socket,
+			  &self->non_connected_addr.unix_addr,
+			  self->non_connected_addr.unix_addr_len));
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 
 	/* Waits for child to test. */
@@ -1238,52 +1432,49 @@ TEST(datagram_sockets)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
-TEST(self_connect)
+TEST_F(socket_type_test, self_connect)
 {
-	struct service_fixture connected_addr, non_connected_addr;
 	int connected_socket, non_connected_socket, status;
 	pid_t child;
-
-	drop_caps(_metadata);
-	memset(&connected_addr, 0, sizeof(connected_addr));
-	set_unix_address(&connected_addr, 0, true);
-	memset(&non_connected_addr, 0, sizeof(non_connected_addr));
-	set_unix_address(&non_connected_addr, 1, true);
+	const __u16 scope = variant->abstract ?
+				    LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET :
+				    LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
 
 	connected_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 	non_connected_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 	ASSERT_LE(0, connected_socket);
 	ASSERT_LE(0, non_connected_socket);
 
-	ASSERT_EQ(0, bind(connected_socket, &connected_addr.unix_addr,
-			  connected_addr.unix_addr_len));
-	ASSERT_EQ(0, bind(non_connected_socket, &non_connected_addr.unix_addr,
-			  non_connected_addr.unix_addr_len));
+	ASSERT_EQ(0, bind(connected_socket, &self->connected_addr.unix_addr,
+			  self->connected_addr.unix_addr_len));
+	ASSERT_EQ(0, bind(non_connected_socket,
+			  &self->non_connected_addr.unix_addr,
+			  self->non_connected_addr.unix_addr_len));
 
 	child = fork();
 	ASSERT_LE(0, child);
 	if (child == 0) {
 		/* Child's domain is scoped. */
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 		/*
 		 * The child inherits the sockets, and cannot connect or
 		 * send data to them.
 		 */
 		ASSERT_EQ(-1,
-			  connect(connected_socket, &connected_addr.unix_addr,
-				  connected_addr.unix_addr_len));
+			  connect(connected_socket,
+				  &self->connected_addr.unix_addr,
+				  self->connected_addr.unix_addr_len));
 		ASSERT_EQ(EPERM, errno);
 
 		ASSERT_EQ(-1, sendto(connected_socket, ".", 1, 0,
-				     &connected_addr.unix_addr,
-				     connected_addr.unix_addr_len));
+				     &self->connected_addr.unix_addr,
+				     self->connected_addr.unix_addr_len));
 		ASSERT_EQ(EPERM, errno);
 
 		ASSERT_EQ(-1, sendto(non_connected_socket, ".", 1, 0,
-				     &non_connected_addr.unix_addr,
-				     non_connected_addr.unix_addr_len));
+				     &self->non_connected_addr.unix_addr,
+				     self->non_connected_addr.unix_addr_len));
 		ASSERT_EQ(EPERM, errno);
 
 		EXPECT_EQ(0, close(connected_socket));
-- 
2.52.0

