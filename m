Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942527AC45
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160400; cv=none; b=YhJMd0LfB0HQv9ZDyKZP8KDYuTJN4cADV4UhqJBHPRKNYw0O6L4iD6YoYkFEYrWfwa4iKM7lFcZZAZclBQGEAp/uYLYuiHjhH9wxDw71ZoiW7sNn6F12CU52A0bqAdv47MZyQ79sNbwqdSxNrfz0tOip/jtAYLiYjfeJXq4WNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160400; c=relaxed/simple;
	bh=MXNh6C2nR2hdF2LzgXL5SCZ1NswQpictsz1YgTfdwA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avDO7ShRDZKZFNS5YuU+OvWI8vBpr0HMeQalCcsOR+bSbOs+HnBa5z2jLqnt7HVSRff7hV6DLREikopw1wnSP+Iy13c6BH2qA6kGXZVwKX3UCkc1Xdv3CfnOxfUopOazjYbSHo3hFXMIzCFbuYvH0uSTvJPcljydWQhjCaC4MIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Pxl22Q8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFMsta79; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Pxl22Q8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFMsta79"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F0D0EC04F0;
	Tue,  3 Feb 2026 18:13:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 18:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770160398;
	 x=1770246798; bh=nrA2W5Kw+S2tGhWQQoJhZoEXOLkZBd+h/ONZ1+efT50=; b=
	Pxl22Q8j55KQ4eUct5gJpmZqnzNClNjbkbtju64UgZR5meZwmbtppfRFhz+7RJ/9
	TVPYZ/L4FV2DbjIpjSzOJAVh9WDhxl58VLxKtaczw+5WI/lbOMDslBOUm9lJVy1o
	sfBOSBzxq6LKGaIr2HArgQFPBSB84ZzACtmPdlU/c6zFKRO4bQPK74S1IErV1mMZ
	1oT45VKY227MPnpRBvIs5jjYYpA1TQM5MHLtsCahTMkDov0iefRjbqATPMEY119h
	Ac012U4nEr99ZFH4jMNHKybmSXKkkXuFTJCJAfrqDVZNOvkwB8StwaHacTQ1eeWo
	awYAqDcNqw5Uc66YvxNowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770160398; x=
	1770246798; bh=nrA2W5Kw+S2tGhWQQoJhZoEXOLkZBd+h/ONZ1+efT50=; b=A
	FMsta79a6mWQoGvsx0xK1N8Ark0WExGb4NvmFj6Asf1Gu3qKdmXKt4h5pUwiq6d4
	R4m+cKZlARXY2ULeiP7w7k1SntMMDMR2YzVUx3i0wNNlMNyKoBohjS69CbGzCOLH
	08tpmvUTBc+O91lOn5d6FvAPW/E9fOjZQsoEdnjEuxiK4rGCd3e58G0F8iCdLkST
	91OpetMfcifT/o1glCSEQP4ndk5CejOWOaZEgFOAGh7ohA2DE4LH5jhpj8ot8rzH
	zwXbz3z/jlH83U/f19DbHMLjee4Ie+UtMjws5dAMK88QYyeJV4Tadht4ac/CpfB6
	MU/5wAxoLNv+L2x51sbYA==
X-ME-Sender: <xms:DYGCaZHmowlJu8FVqCo2j672hvXxK2gT6H2UBPTRHWJImbiUSGMCgg>
    <xme:DYGCaQ5ST9rew2hNr8otkDeayMBxX7EBoVapLjc89R2Ud1LQIDMOZOBgOiWqe5U-8
    0LhKB77i3_SsneBpueINmk0csXr8MJlJTFqaSEZPNo_fQ8alQXHEO4>
X-ME-Received: <xmr:DYGCaexYhIfJzTTZtI0XsWHQOmn9LoCKJ5KDAb222UCawMmpUSGOiLRvuc94FCPOlUnQqlapkAKxT34njMml2wsxRl01aNd5fCs0FIqDc9rIb_8GXNSn-F8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepie
    eigeeghedtffeifffhkeeuffehhfevuefgvdekjeekhedvtedtgfdvgefhudejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrd
    horhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthho
    peguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlh
    ihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuh
    htihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DYGCafOZWkpC0JCx7lw9ON-4ZOpMqaqfZDIby8TD1WpZ50C5ssyEkA>
    <xmx:DoGCaUkOaDZjbsL33mbKVyX8RCIK6NqLbg8wXrPZRyVbJ9EErSBVsw>
    <xmx:DoGCaURhETIAM9aR6wySCvCB-T2TpFHfvp6Y8XXRaSYW-LXgbhg2UQ>
    <xmx:DoGCaTV-gFpRNjG6JNJSIUJKR4WhhFRiTGL6aODlPxfZXU9qVVLl6A>
    <xmx:DoGCaUyEj9mDrnHSlYF5m2c7xpk2PzZ_5Dzvj29sIPLUWdvyOogIkmrp>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:13:16 -0500 (EST)
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
Subject: [PATCH v3 5/6] selftests/landlock: Repurpose scoped_abstract_unix_test.c for pathname sockets too
Date: Tue,  3 Feb 2026 23:12:32 +0000
Message-ID: <e58372c6c22b7a774515f271a27e77678656299f.1770160146.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770160146.git.m@maowtm.org>
References: <cover.1770160146.git.m@maowtm.org>
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
sense to reuse the existing test for both type of sockets.  Therefore,
we rename scoped_abstract_unix_test.c to scoped_unix_test.c and extend
the scoped_domains test to test pathname (i.e. non-abstract) sockets
too.

Since we can't change the variant data of scoped_domains (as it is
defined in the shared .h file), we do this by extracting the actual test
code into a function, and call it from different test cases.

Also extend scoped_audit (this time we can use variants) to test both
abstract and pathname sockets.  For pathname sockets, audit_log_lsm_data
will produce path="..." (or hex if path contains control characters)
with absolute paths from the dentry, so we need to construct the escaped
regex for the real path like in fs_test.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- Fix comment, style, formatting, and reflow the above message
- Update definition of log_match_remaining

 ...bstract_unix_test.c => scoped_unix_test.c} | 269 ++++++++++++++----
 1 file changed, 217 insertions(+), 52 deletions(-)
 rename tools/testing/selftests/landlock/{scoped_abstract_unix_test.c => scoped_unix_test.c} (80%)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_unix_test.c
similarity index 80%
rename from tools/testing/selftests/landlock/scoped_abstract_unix_test.c
rename to tools/testing/selftests/landlock/scoped_unix_test.c
index 4a790e2d387d..d117c85a2ca7 100644
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
@@ -56,27 +59,64 @@ FIXTURE_SETUP(scoped_domains)
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
+	EXPECT_EQ(0, remove_path(
+			     self->stream_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0,
+		  remove_path(self->dgram_address_pathname.unix_addr.sun_path));
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
@@ -87,8 +127,7 @@ TEST_F(scoped_domains, connect_to_parent)
 
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 		if (!__test_passed(_metadata))
 			return;
 	}
@@ -102,8 +141,7 @@ TEST_F(scoped_domains, connect_to_parent)
 
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		if (variant->domain_child)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			create_scoped_domain(_metadata, scope);
 
 		stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_client);
@@ -113,8 +151,8 @@ TEST_F(scoped_domains, connect_to_parent)
 		/* Waits for the server. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 
-		err = connect(stream_client, &self->stream_address.unix_addr,
-			      self->stream_address.unix_addr_len);
+		err = connect(stream_client, &stream_address->unix_addr,
+			      stream_address->unix_addr_len);
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
@@ -123,8 +161,8 @@ TEST_F(scoped_domains, connect_to_parent)
 		}
 		EXPECT_EQ(0, close(stream_client));
 
-		err = connect(dgram_client, &self->dgram_address.unix_addr,
-			      self->dgram_address.unix_addr_len);
+		err = connect(dgram_client, &dgram_address->unix_addr,
+			      dgram_address->unix_addr_len);
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
@@ -137,17 +175,16 @@ TEST_F(scoped_domains, connect_to_parent)
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
@@ -166,7 +203,11 @@ TEST_F(scoped_domains, connect_to_parent)
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
@@ -174,6 +215,14 @@ TEST_F(scoped_domains, connect_to_child)
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
@@ -185,8 +234,7 @@ TEST_F(scoped_domains, connect_to_child)
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 		if (!__test_passed(_metadata))
 			return;
 	}
@@ -199,8 +247,7 @@ TEST_F(scoped_domains, connect_to_child)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		EXPECT_EQ(0, close(pipe_child[0]));
 		if (variant->domain_child)
-			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+			create_scoped_domain(_metadata, scope);
 
 		/* Waits for the parent to be in a domain, if any. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
@@ -209,11 +256,10 @@ TEST_F(scoped_domains, connect_to_child)
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
@@ -230,8 +276,7 @@ TEST_F(scoped_domains, connect_to_child)
 	EXPECT_EQ(0, close(pipe_parent[0]));
 
 	if (variant->domain_parent)
-		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+		create_scoped_domain(_metadata, scope);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -243,11 +288,11 @@ TEST_F(scoped_domains, connect_to_child)
 
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
@@ -268,19 +313,79 @@ TEST_F(scoped_domains, connect_to_child)
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
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoped_audit, abstract_socket)
+{
+	/* clang-format on */
+	.abstract_socket = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoped_audit, pathname_socket)
+{
+	/* clang-format on */
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
@@ -291,6 +396,9 @@ FIXTURE_SETUP(scoped_audit)
 FIXTURE_TEARDOWN_PARENT(scoped_audit)
 {
 	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+	EXPECT_EQ(0,
+		  remove_path(self->dgram_address_pathname.unix_addr.sun_path));
+	EXPECT_EQ(0, rmdir(PATHNAME_UNIX_SOCK_DIR));
 }
 
 /* python -c 'print(b"\0selftests-landlock-abstract-unix-".hex().upper())' */
@@ -308,6 +416,22 @@ TEST_F(scoped_audit, connect_to_child)
 	char buf;
 	int dgram_client;
 	struct audit_records records;
+	struct service_fixture *const dgram_address =
+		variant->abstract_socket ? &self->dgram_address_abstract :
+					   &self->dgram_address_pathname;
+	static const char abstract_log_regex[] = REGEX_LANDLOCK_PREFIX
+		" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
+		"[0-9A-F]\\+$";
+	static const char pathname_log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=scope\\.pathname_unix_socket path=\"%s\"$";
+	size_t log_match_remaining =
+		sizeof(abstract_log_regex) + PATH_MAX * 2 + 1;
+	char log_match[log_match_remaining];
+	char *log_match_cursor = log_match;
+
+	/* Make sure log_match_remaining calculation is correct */
+	static_assert(sizeof(pathname_log_template) <
+		      sizeof(abstract_log_regex));
 
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
@@ -330,8 +454,8 @@ TEST_F(scoped_audit, connect_to_child)
 
 		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
 		ASSERT_LE(0, dgram_server);
-		ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
-				  self->dgram_address.unix_addr_len));
+		ASSERT_EQ(0, bind(dgram_server, &dgram_address->unix_addr,
+				  dgram_address->unix_addr_len));
 
 		/* Signals to the parent that child is listening. */
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
@@ -345,7 +469,9 @@ TEST_F(scoped_audit, connect_to_child)
 	EXPECT_EQ(0, close(pipe_child[1]));
 	EXPECT_EQ(0, close(pipe_parent[0]));
 
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	create_scoped_domain(_metadata,
+			     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+				     LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -355,19 +481,58 @@ TEST_F(scoped_audit, connect_to_child)
 
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
+		log_match_cursor = stpncpy(log_match, abstract_log_regex,
+					   log_match_remaining);
+		log_match_remaining =
+			sizeof(log_match) - (log_match_cursor - log_match);
+		ASSERT_NE(0, log_match_remaining);
+	} else {
+		/*
+		 * It is assumed that absolute_path does not contain control
+		 * characters nor spaces, see audit_string_contains_control().
+		 */
+		char *const absolute_path =
+			realpath(dgram_address->unix_addr.sun_path, NULL);
+
+		EXPECT_NE(NULL, absolute_path)
+		{
+			TH_LOG("realpath() failed: %s", strerror(errno));
+			return;
+		}
+
+		log_match_cursor = stpncpy(
+			log_match,
 			REGEX_LANDLOCK_PREFIX
-			" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
-			"[0-9A-F]\\+$",
-			NULL));
+			" blockers=scope\\.pathname_unix_socket path=\"",
+			log_match_remaining);
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
