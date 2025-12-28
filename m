Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2782FF677
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925973; cv=none; b=kkvB9vxxa2jxOxbiupMDal2gWj1244nIoPpzkpox8xPzerHJf4ERDXu7TRj7YcrS5OTcLcGDkovASZZFEFsG+Bpss6PNEpPFkNVpPfGDFvrzGtYssjT6eUqdIaTA0w1m4MFV9TipOcpArjCeWpcWvQZRQ7TJjAwznf3sV1QUBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925973; c=relaxed/simple;
	bh=Ca6OOTXlvXDiXUh1hXbjueDeBBRN7mElk8aqwWSHGVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKW7oni/XZK+Jqm3a1OFfR6nVirQ5l0HgYpn1ZSUyRINl/7OBkbI66DZ3Sjy/1XsNIDdtEgNp1VKrRsqh5s+z4vLi1dil3PU8nXEtQyFWY64EM+N0oMOybpQ/NibuIYS1xLp8/jL+Ni3FuLwVXIkBMoLALtWW9qQPYhyw1oOV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AKX5PUq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pi13VGCH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AKX5PUq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pi13VGCH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B10637A0376;
	Sun, 28 Dec 2025 07:46:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 28 Dec 2025 07:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766925970;
	 x=1767012370; bh=iKreoZOBq4mgNN2DTUJM8ar9Ta2Fk+mO0IV+/sMy43A=; b=
	AKX5PUq2uVtODVZXUxdsbw2TqW+3Czqo//hKqEK8TMJM3SA0U69H+DQsxPiPwSXo
	5rtJTIhLI7Udt/N4bZREz2pnLnHxXeACTtLFnPo5AxBOkFZWCbErfkkGMrFms2dT
	n5vZu9ugEkR+nymkK1oMByG6IFyjH0/1eXeuw1dQb/kzUg0OFhM1kiYC7SXTVGif
	yZiACHng5UV/rbTUqB2e8zQWAXNRPocDqW+KEiZq/jCIolKgydEAEcfDJEW9MZPH
	jbmxd9goEb3bOhJ641bvDoOVgZ+gYwHVlrWNxlK3cE3KnfdXWymwMijEJNsLBSTJ
	ljih9atLSmkknun6pr7XmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1766925970; x=
	1767012370; bh=iKreoZOBq4mgNN2DTUJM8ar9Ta2Fk+mO0IV+/sMy43A=; b=p
	i13VGCHtNB8OHRzeAWWoPNH5Zr5rWueJJDZeKsyb/EA0BFm+NMCmHO2GBtRvtZG9
	8iVO7jbHx3joDs/CzqEkafNobbJ/twoAwVx1gxdvqT+tiRPBLpdKIJ5DcY00gSjr
	QOio4XlcefbfJ4C7EBZHvDN94QPHmkssDU2dO75n8QtVRa65lqwASSBxwNRno2KI
	OS8DwEeg9tzKb0p9JksZByeUB2daj1JkHE99ANKeNoZlI1doDWKmuos9bWsxOgSt
	opGO4llL/Fzo6tN3mfmyXoM5IEjLfBAYcUlvJPqsa7gZU0D6FFCq5DK7O/PkEGHd
	2yC8yOnLnEz81nC0uy3Wg==
X-ME-Sender: <xms:kiZRaZyL_pk-68Q4UuHytAq46t_qjskOpwHSWaZCgTsegKT1NePdZQ>
    <xme:kiZRaYWUCM0HzjY2gVftq6iIhZZxzJryF5yjylYNrAyw-NkW3H8pImh-HIPyU0VSB
    meChWz-yLMMaDsiX-kwpqU_0muha9jQpb-G88CrAkLHh7inVY4_GSw>
X-ME-Received: <xmr:kiZRaZh4P9arNyMn8kVmXPwIJpVUoIIeDyofPzSsXFfdadt-DU_GLzfk_CjrrEazSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeiie
    eggeehtdffieffhfekueffhefhveeugfdvkeejkeehvdettdfgvdeghfdujeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhi
    hsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kiZRaYAGaLDntKuD0zIz7KXq6b9RFgVk10Wdi0Wl9mn-0Db0oISWTQ>
    <xmx:kiZRaftSYLiDIOb-JKJudScOAFyCJlFoc65ISpCCgObM0xCWLHvjaQ>
    <xmx:kiZRacfUrBV1MiMAV8v3buv6fIQdRDua8YSPtYMolcWtqb9o3z2BUw>
    <xmx:kiZRaU-z-L1QFNz0b-1JPD6sntgdprWy-o0-TmDtYWTI_qIOjuzDFQ>
    <xmx:kiZRadNI5eMskczvpx_C7cVmM-efM6LSv90rUdTIjg18jGYNPKHzUqy->
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 07:46:09 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 5/6] selftests/landlock: Repurpose scoped_abstract_unix_test.c for pathname sockets too.
Date: Sun, 28 Dec 2025 12:45:44 +0000
Message-ID: <9a3b1f821b53facb938e7799e74261ce21f4ffbe.1766925301.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766925301.git.m@maowtm.org>
References: <cover.1766925301.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since there is very little difference between abstract and pathname
sockets in terms of testing of the scoped access checks (the only
difference is in which scope bit control which form of socket), it makes
sense to reuse the existing test for both type of sockets.  Therefore, we
rename scoped_abstract_unix_test.c to scoped_unix_test.c and extend the
scoped_domains test to test pathname (i.e. non-abstract) sockets too.

Since we can't change the variant data of scoped_domains (as it is defined
in the shared .h file), we do this by extracting the actual test code into
a function, and call it from different test cases.

Also extend scoped_audit (this time we can use variants) to test both
abstract and pathname sockets.  For pathname sockets, audit_log_lsm_data
will produce path="..." (or hex if path contains control characters) with
absolute paths from the dentry, so we need to construct the escaped regex
for the real path like in fs_test.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 ...bstract_unix_test.c => scoped_unix_test.c} | 256 ++++++++++++++----
 1 file changed, 206 insertions(+), 50 deletions(-)
 rename tools/testing/selftests/landlock/{scoped_abstract_unix_test.c => scoped_unix_test.c} (81%)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_unix_test.c
similarity index 81%
rename from tools/testing/selftests/landlock/scoped_abstract_unix_test.c
rename to tools/testing/selftests/landlock/scoped_unix_test.c
index 4a790e2d387d..669418c97509 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_unix_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Landlock tests - Abstract UNIX socket
+ * Landlock tests - Scoped access checks for UNIX socket (abstract and
+ * pathname)
  *
  * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
  */
@@ -19,6 +20,7 @@
 #include <sys/un.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <stdlib.h>
 
 #include "audit.h"
 #include "common.h"
@@ -47,7 +49,8 @@ static void create_fs_domain(struct __test_metadata *const _metadata)
 
 FIXTURE(scoped_domains)
 {
-	struct service_fixture stream_address, dgram_address;
+	struct service_fixture stream_address_abstract, dgram_address_abstract,
+		stream_address_pathname, dgram_address_pathname;
 };
 
 #include "scoped_base_variants.h"
@@ -56,27 +59,62 @@ FIXTURE_SETUP(scoped_domains)
 {
 	drop_caps(_metadata);
 
-	memset(&self->stream_address, 0, sizeof(self->stream_address));
-	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
-	set_unix_address(&self->stream_address, 0, true);
-	set_unix_address(&self->dgram_address, 1, true);
+	ASSERT_EQ(0, mkdir(PATHNAME_UNIX_SOCK_DIR, 0700));
+
+	memset(&self->stream_address_abstract, 0,
+	       sizeof(self->stream_address_abstract));
+	memset(&self->dgram_address_abstract, 0,
+	       sizeof(self->dgram_address_abstract));
+	memset(&self->stream_address_pathname, 0,
+	       sizeof(self->stream_address_pathname));
+	memset(&self->dgram_address_pathname, 0,
+	       sizeof(self->dgram_address_pathname));
+	set_unix_address(&self->stream_address_abstract, 0, true);
+	set_unix_address(&self->dgram_address_abstract, 1, true);
+	set_unix_address(&self->stream_address_pathname, 0, false);
+	set_unix_address(&self->dgram_address_pathname, 1, false);
+}
+
+/* Remove @path if it exists */
+int remove_path(const char *path)
+{
+	if (unlink(path) == -1) {
+		if (errno != ENOENT)
+			return -errno;
+	}
+	return 0;
 }
 
 FIXTURE_TEARDOWN(scoped_domains)
 {
+	EXPECT_EQ(0, remove_path(self->stream_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, remove_path(self->dgram_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
 }
 
 /*
  * Test unix_stream_connect() and unix_may_send() for a child connecting to its
  * parent, when they have scoped domain or no domain.
  */
-TEST_F(scoped_domains, connect_to_parent)
+static void test_connect_to_parent(struct __test_metadata *const _metadata,
+				   FIXTURE_DATA(scoped_domains) * self,
+				   const FIXTURE_VARIANT(scoped_domains) *
+					   variant,
+				   const bool abstract)
 {
 	pid_t child;
 	bool can_connect_to_parent;
 	int status;
 	int pipe_parent[2];
 	int stream_server, dgram_server;
+	const __u16 scope = abstract ? LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET :
+				       LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+	const struct service_fixture *stream_address =
+		abstract ? &self->stream_address_abstract :
+			   &self->stream_address_pathname;
+	const struct service_fixture *dgram_address =
+		abstract ? &self->dgram_address_abstract :
+			   &self->dgram_address_pathname;
 
 	/*
 	 * can_connect_to_parent is true if a child process can connect to its
@@ -87,8 +125,7 @@ TEST_F(scoped_domains, connect_to_parent)
 
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 		if (!__test_passed(_metadata))
 			return;
 	}
@@ -102,8 +139,7 @@ TEST_F(scoped_domains, connect_to_parent)
 
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		if (variant->domain_child)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			create_scoped_domain(_metadata, scope);
 
 		stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_client);
@@ -113,8 +149,8 @@ TEST_F(scoped_domains, connect_to_parent)
 		/* Waits for the server. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 
-		err = connect(stream_client, &self->stream_address.unix_addr,
-			      self->stream_address.unix_addr_len);
+		err = connect(stream_client, &stream_address->unix_addr,
+			      stream_address->unix_addr_len);
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
@@ -123,8 +159,8 @@ TEST_F(scoped_domains, connect_to_parent)
 		}
 		EXPECT_EQ(0, close(stream_client));
 
-		err = connect(dgram_client, &self->dgram_address.unix_addr,
-			      self->dgram_address.unix_addr_len);
+		err = connect(dgram_client, &dgram_address->unix_addr,
+			      dgram_address->unix_addr_len);
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
@@ -137,17 +173,16 @@ TEST_F(scoped_domains, connect_to_parent)
 	}
 	EXPECT_EQ(0, close(pipe_parent[0]));
 	if (variant->domain_parent)
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 	stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_server);
 	dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
 	ASSERT_LE(0, dgram_server);
-	ASSERT_EQ(0, bind(stream_server, &self->stream_address.unix_addr,
-			  self->stream_address.unix_addr_len));
-	ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
-			  self->dgram_address.unix_addr_len));
+	ASSERT_EQ(0, bind(stream_server, &stream_address->unix_addr,
+			  stream_address->unix_addr_len));
+	ASSERT_EQ(0, bind(dgram_server, &dgram_address->unix_addr,
+			  dgram_address->unix_addr_len));
 	ASSERT_EQ(0, listen(stream_server, backlog));
 
 	/* Signals to child that the parent is listening. */
@@ -166,7 +201,11 @@ TEST_F(scoped_domains, connect_to_parent)
  * Test unix_stream_connect() and unix_may_send() for a parent connecting to
  * its child, when they have scoped domain or no domain.
  */
-TEST_F(scoped_domains, connect_to_child)
+static void test_connect_to_child(struct __test_metadata *const _metadata,
+				  FIXTURE_DATA(scoped_domains) * self,
+				  const FIXTURE_VARIANT(scoped_domains) *
+					  variant,
+				  const bool abstract)
 {
 	pid_t child;
 	bool can_connect_to_child;
@@ -174,6 +213,14 @@ TEST_F(scoped_domains, connect_to_child)
 	int pipe_child[2], pipe_parent[2];
 	char buf;
 	int stream_client, dgram_client;
+	const __u16 scope = abstract ? LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET :
+				       LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+	const struct service_fixture *stream_address =
+		abstract ? &self->stream_address_abstract :
+			   &self->stream_address_pathname;
+	const struct service_fixture *dgram_address =
+		abstract ? &self->dgram_address_abstract :
+			   &self->dgram_address_pathname;
 
 	/*
 	 * can_connect_to_child is true if a parent process can connect to its
@@ -185,8 +232,7 @@ TEST_F(scoped_domains, connect_to_child)
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 		if (!__test_passed(_metadata))
 			return;
 	}
@@ -199,8 +245,7 @@ TEST_F(scoped_domains, connect_to_child)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		EXPECT_EQ(0, close(pipe_child[0]));
 		if (variant->domain_child)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			create_scoped_domain(_metadata, scope);
 
 		/* Waits for the parent to be in a domain, if any. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
@@ -209,11 +254,10 @@ TEST_F(scoped_domains, connect_to_child)
 		ASSERT_LE(0, stream_server);
 		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
 		ASSERT_LE(0, dgram_server);
-		ASSERT_EQ(0,
-			  bind(stream_server, &self->stream_address.unix_addr,
-			       self->stream_address.unix_addr_len));
-		ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
-				  self->dgram_address.unix_addr_len));
+		ASSERT_EQ(0, bind(stream_server, &stream_address->unix_addr,
+				  stream_address->unix_addr_len));
+		ASSERT_EQ(0, bind(dgram_server, &dgram_address->unix_addr,
+				  dgram_address->unix_addr_len));
 		ASSERT_EQ(0, listen(stream_server, backlog));
 
 		/* Signals to the parent that child is listening. */
@@ -230,8 +274,7 @@ TEST_F(scoped_domains, connect_to_child)
 	EXPECT_EQ(0, close(pipe_parent[0]));
 
 	if (variant->domain_parent)
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -243,11 +286,11 @@ TEST_F(scoped_domains, connect_to_child)
 
 	/* Waits for the child to listen */
 	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
-	err_stream = connect(stream_client, &self->stream_address.unix_addr,
-			     self->stream_address.unix_addr_len);
+	err_stream = connect(stream_client, &stream_address->unix_addr,
+			     stream_address->unix_addr_len);
 	errno_stream = errno;
-	err_dgram = connect(dgram_client, &self->dgram_address.unix_addr,
-			    self->dgram_address.unix_addr_len);
+	err_dgram = connect(dgram_client, &dgram_address->unix_addr,
+			    dgram_address->unix_addr_len);
 	errno_dgram = errno;
 	if (can_connect_to_child) {
 		EXPECT_EQ(0, err_stream);
@@ -268,19 +311,79 @@ TEST_F(scoped_domains, connect_to_child)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+/*
+ * Test unix_stream_connect() and unix_may_send() for a child connecting to its
+ * parent, when they have scoped domain or no domain.
+ */
+TEST_F(scoped_domains, abstract_connect_to_parent)
+{
+	test_connect_to_parent(_metadata, self, variant, true);
+}
+
+/*
+ * Test unix_stream_connect() and unix_may_send() for a parent connecting to
+ * its child, when they have scoped domain or no domain.
+ */
+TEST_F(scoped_domains, abstract_connect_to_child)
+{
+	test_connect_to_child(_metadata, self, variant, true);
+}
+
+/*
+ * Test unix_stream_connect() and unix_may_send() for a child connecting to its
+ * parent with pathname sockets.
+ */
+TEST_F(scoped_domains, pathname_connect_to_parent)
+{
+	test_connect_to_parent(_metadata, self, variant, false);
+}
+
+/*
+ * Test unix_stream_connect() and unix_may_send() for a parent connecting to
+ * its child with pathname sockets.
+ */
+TEST_F(scoped_domains, pathname_connect_to_child)
+{
+	test_connect_to_child(_metadata, self, variant, false);
+}
+
 FIXTURE(scoped_audit)
 {
-	struct service_fixture dgram_address;
+	struct service_fixture dgram_address_abstract, dgram_address_pathname;
 	struct audit_filter audit_filter;
 	int audit_fd;
 };
 
+FIXTURE_VARIANT(scoped_audit)
+{
+	const bool abstract_socket;
+};
+
+// clang-format off
+FIXTURE_VARIANT_ADD(scoped_audit, abstract_socket)
+{
+	// clang-format on
+	.abstract_socket = true,
+};
+
+// clang-format off
+FIXTURE_VARIANT_ADD(scoped_audit, pathname_socket)
+{
+	// clang-format on
+	.abstract_socket = false,
+};
+
 FIXTURE_SETUP(scoped_audit)
 {
 	disable_caps(_metadata);
 
-	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
-	set_unix_address(&self->dgram_address, 1, true);
+	ASSERT_EQ(0, mkdir(PATHNAME_UNIX_SOCK_DIR, 0700));
+	memset(&self->dgram_address_abstract, 0,
+	       sizeof(self->dgram_address_abstract));
+	memset(&self->dgram_address_pathname, 0,
+	       sizeof(self->dgram_address_pathname));
+	set_unix_address(&self->dgram_address_abstract, 1, true);
+	set_unix_address(&self->dgram_address_pathname, 1, false);
 
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
 	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
@@ -291,6 +394,8 @@ FIXTURE_SETUP(scoped_audit)
 FIXTURE_TEARDOWN_PARENT(scoped_audit)
 {
 	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+	EXPECT_EQ(0, remove_path(self->dgram_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
 }
 
 /* python -c 'print(b"\0selftests-landlock-abstract-unix-".hex().upper())' */
@@ -308,6 +413,12 @@ TEST_F(scoped_audit, connect_to_child)
 	char buf;
 	int dgram_client;
 	struct audit_records records;
+	struct service_fixture *const dgram_address =
+		variant->abstract_socket ? &self->dgram_address_abstract :
+					   &self->dgram_address_pathname;
+	size_t log_match_remaining = 500;
+	char log_match[log_match_remaining];
+	char *log_match_cursor = log_match;
 
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
@@ -330,8 +441,8 @@ TEST_F(scoped_audit, connect_to_child)
 
 		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
 		ASSERT_LE(0, dgram_server);
-		ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
-				  self->dgram_address.unix_addr_len));
+		ASSERT_EQ(0, bind(dgram_server, &dgram_address->unix_addr,
+				  dgram_address->unix_addr_len));
 
 		/* Signals to the parent that child is listening. */
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
@@ -345,7 +456,9 @@ TEST_F(scoped_audit, connect_to_child)
 	EXPECT_EQ(0, close(pipe_child[1]));
 	EXPECT_EQ(0, close(pipe_parent[0]));
 
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	create_scoped_domain(_metadata,
+			     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+				     LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -355,19 +468,62 @@ TEST_F(scoped_audit, connect_to_child)
 
 	/* Waits for the child to listen */
 	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
-	err_dgram = connect(dgram_client, &self->dgram_address.unix_addr,
-			    self->dgram_address.unix_addr_len);
+	err_dgram = connect(dgram_client, &dgram_address->unix_addr,
+			    dgram_address->unix_addr_len);
 	EXPECT_EQ(-1, err_dgram);
 	EXPECT_EQ(EPERM, errno);
 
-	EXPECT_EQ(
-		0,
-		audit_match_record(
-			self->audit_fd, AUDIT_LANDLOCK_ACCESS,
+	if (variant->abstract_socket) {
+		log_match_cursor = stpncpy(
+			log_match,
 			REGEX_LANDLOCK_PREFIX
 			" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
 			"[0-9A-F]\\+$",
-			NULL));
+			log_match_remaining);
+		log_match_remaining =
+			sizeof(log_match) - (log_match_cursor - log_match);
+		ASSERT_NE(0, log_match_remaining);
+	} else {
+		/*
+		 * It is assumed that absolute_path does not contain control
+		 * characters nor spaces, see audit_string_contains_control().
+		 */
+		char *absolute_path =
+			realpath(dgram_address->unix_addr.sun_path, NULL);
+
+		EXPECT_NE(NULL, absolute_path)
+		{
+			TH_LOG("realpath() failed: %s", strerror(errno));
+			return;
+		}
+
+		log_match_cursor =
+			stpncpy(log_match,
+				REGEX_LANDLOCK_PREFIX
+				" blockers=scope\\.pathname_unix_socket path=\"",
+				log_match_remaining);
+		log_match_remaining =
+			sizeof(log_match) - (log_match_cursor - log_match);
+		ASSERT_NE(0, log_match_remaining);
+		log_match_cursor = regex_escape(absolute_path, log_match_cursor,
+						log_match_remaining);
+		free(absolute_path);
+		if (log_match_cursor < 0) {
+			TH_LOG("regex_escape() failed (buffer too small)");
+			return;
+		}
+		log_match_remaining =
+			sizeof(log_match) - (log_match_cursor - log_match);
+		ASSERT_NE(0, log_match_remaining);
+		log_match_cursor =
+			stpncpy(log_match_cursor, "\"$", log_match_remaining);
+		log_match_remaining =
+			sizeof(log_match) - (log_match_cursor - log_match);
+		ASSERT_NE(0, log_match_remaining);
+	}
+
+	EXPECT_EQ(0, audit_match_record(self->audit_fd, AUDIT_LANDLOCK_ACCESS,
+					log_match, NULL));
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	EXPECT_EQ(0, close(dgram_client));
-- 
2.52.0

