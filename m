Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7432571A
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160398; cv=none; b=lGhVxfAKkokG5QytlhRUXzuasA4n8mrKUwZuY+a6YjLATlM16TstIMcYIN46ilqTdkEl759Z+fb0DxldGxxJP77/UsjcemYC6OMcOB7rmAWVfNVJ3KUfFlJ9uFOpB498OyLonjRDy0uL3O0GFlZVvdxf680ZPe9qzpgxYPStfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160398; c=relaxed/simple;
	bh=8yKINERM/ugVZGeVqGkmyAyS2A7APJ8XFTMsqPySaZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivdc/uFY7n56eB7aw/kkX5xyClLQZP1i3CN7WclEdVnfPuVEw1K0s9cmISScHbHpe5VKYeKYKT7wVbewk7nmYTegNCj2vfB6fEwoV5Hm6tt4vdo9cUCHoe16iDH1fmy0te9MK4pyo68oYhHq20DckIa/6fn3wQl4c0UeSlVdXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=DDRauE6R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=trWE3kJP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="DDRauE6R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="trWE3kJP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 937A014000CE;
	Tue,  3 Feb 2026 18:13:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 18:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770160396; x=
	1770246796; bh=DGOM1Tbs7ttLBVCMyjU5NOXGxleHzsrKuRJp2BF60Kc=; b=D
	DRauE6R/XezwY6TjeKksCJ219PpFMCkoqu7o4XwACYLttOo6DHi8tnaeUvo/8+Fz
	TCkT5/ayXPa0SNdrjwQ16MbMzGr2/BgMTKhS4IAnlhBK+P/scqavEHnuKeVx4pPn
	SPeGB2olmlgvv9vPUMRWEf1tpdT2H7g4d9N5Lj6VEYyos2i2dbVG9UStEdpUObv1
	KtapKmAXsdQwnXTZyFlrGdntFZ3/YDpjMCGB7dFKZupGTMCYiH351kUme5S6roNC
	60tBIeCtMDPjdtHJkWtGaJXqoFUbZuBaxK99+Ra7a6zRlszpcSSNC5OodoZ6+t/2
	S/jtrOkdIcV8/dOLXJ0Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770160396; x=1770246796; bh=D
	GOM1Tbs7ttLBVCMyjU5NOXGxleHzsrKuRJp2BF60Kc=; b=trWE3kJPg+oGnWR1c
	A9K4QNDwZpKI33PmpdmdCr6muT4R8PMR84E2FaGsazgRphFUFlfBZ/XVYlFJDdqT
	iO9oOB1ZWuLSr26+02yTwfYkidaXPH4BH9DeNa1Fmqz5S967Wvvb7EjBI2uBrYT3
	LN3vcb/IjOazMiuTccX8LZd856+jFVEKsvHXz6rdK+oYnPKWOKbFIoNSXy4hb11D
	QpfOWKb9bSVdEpqpOAusqIn1Z8Zx+arUguglSIZJQXl8/Btjq69nFhPqg71i4N2C
	olom+Py2tH/LcNDaJNDdZVSYtuSpgaCsvsp4PUdxtuyWMn3vDQHivKVbaUpt8+RC
	tVk1w==
X-ME-Sender: <xms:DIGCaQ7HMcyceCx5v4jZ5jkgm7868-CZWIWmTXvU4BfXdHynSP8Vdg>
    <xme:DIGCaUc1pIH8KiuwrO_XLlLwYqxJmkqeNSy3VBGJBp4EDmWgkh45byqKQUNqpfPg4
    jUVui6YPI5FWXmBf5IcDRAH4Oh7iKrN_odLExcAmHI074PrEWt5P5Cy>
X-ME-Received: <xmr:DIGCaTFOWvFp0UUTEK580F_ztrFWlV1v7-oEdNqAjucdy0wkOClFG8rzMmCxprvBDbjE2zUB30an9FWhz5PaC-SkDzuyM5q03dkq5dCBHot2ZIcV05a010U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhi
    hsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehuth
    hilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    shgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DIGCaVQGbIYxEdLYUPnBPSdYeZdRhTqQFZFSXHuUpGvWmUnvdTg7ZA>
    <xmx:DIGCaZZZnni_h4zprLDzw50FvaWdRxiXWy0esRvcnKyjM8cKedCU8Q>
    <xmx:DIGCaQ2f0luDbAeMwKd5XlqRAQVIAB1b21BFrKjn-CjFiluqaqTJPw>
    <xmx:DIGCacpilgKTTt7fi7e98xVWdHMweY-JvsKtc8suSJTFONZwAELidQ>
    <xmx:DIGCaS3-ZXWayETys0x1RxY48JA4nEpyFunVaIGe8yd-Rgbj5kugmL9e>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:13:15 -0500 (EST)
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
Subject: [PATCH v3 4/6] selftests/landlock: Support pathname socket path in set_unix_address
Date: Tue,  3 Feb 2026 23:12:31 +0000
Message-ID: <2b09c6641c78746be497ff250ccc0dcb0524e60f.1770160146.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770160146.git.m@maowtm.org>
References: <cover.1770160146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for extending the socket tests to do non-abstract sockets too,
extend set_unix_address() to also be able to populate a non-abstract
socket path under TMP_DIR.  Also use snprintf for good measure.

This also changes existing callers to pass true for the abstract argument.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/common.h     | 33 +++++++++++++++----
 tools/testing/selftests/landlock/net_test.c   |  2 +-
 .../landlock/scoped_abstract_unix_test.c      | 30 ++++++++---------
 .../selftests/landlock/scoped_signal_test.c   |  2 +-
 4 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 90551650299c..c55c11434e27 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -241,13 +241,34 @@ struct service_fixture {
 	};
 };
 
+#define PATHNAME_UNIX_SOCK_DIR TMP_DIR
+
+/**
+ * set_unix_address - Set up srv->unix_addr and srv->unix_addr_len.
+ * @srv: Service fixture containing the socket address to initialize
+ * @index: Index to include in socket names
+ * @abstract: If true, creates an abstract socket address (sun_path[0] ==
+ *     '\0') with the given name.  If false, creates a pathname socket
+ *     address with the given path.
+ */
 static void __maybe_unused set_unix_address(struct service_fixture *const srv,
-					    const unsigned short index)
+					    const unsigned short index,
+					    const bool abstract)
 {
 	srv->unix_addr.sun_family = AF_UNIX;
-	sprintf(srv->unix_addr.sun_path,
-		"_selftests-landlock-abstract-unix-tid%d-index%d", sys_gettid(),
-		index);
-	srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
-	srv->unix_addr.sun_path[0] = '\0';
+	if (abstract) {
+		snprintf(srv->unix_addr.sun_path,
+			 sizeof(srv->unix_addr.sun_path),
+			 "_selftests-landlock-abstract-unix-tid%d-index%d",
+			 sys_gettid(), index);
+		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
+		srv->unix_addr.sun_path[0] = '\0';
+	} else {
+		snprintf(srv->unix_addr.sun_path,
+			 sizeof(srv->unix_addr.sun_path),
+			 PATHNAME_UNIX_SOCK_DIR
+			 "/pathname-unix-tid%d-index%d.sock",
+			 sys_gettid(), index);
+		srv->unix_addr_len = sizeof(srv->unix_addr);
+	}
 }
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index b34b139b3f89..fd3fe51ce92f 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -69,7 +69,7 @@ static int set_service(struct service_fixture *const srv,
 		return 0;
 
 	case AF_UNIX:
-		set_unix_address(srv, index);
+		set_unix_address(srv, index, true);
 		return 0;
 	}
 	return 1;
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 72f97648d4a7..4a790e2d387d 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -58,8 +58,8 @@ FIXTURE_SETUP(scoped_domains)
 
 	memset(&self->stream_address, 0, sizeof(self->stream_address));
 	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
-	set_unix_address(&self->stream_address, 0);
-	set_unix_address(&self->dgram_address, 1);
+	set_unix_address(&self->stream_address, 0, true);
+	set_unix_address(&self->dgram_address, 1, true);
 }
 
 FIXTURE_TEARDOWN(scoped_domains)
@@ -280,7 +280,7 @@ FIXTURE_SETUP(scoped_audit)
 	disable_caps(_metadata);
 
 	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
-	set_unix_address(&self->dgram_address, 1);
+	set_unix_address(&self->dgram_address, 1, true);
 
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
 	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
@@ -392,16 +392,16 @@ FIXTURE_SETUP(scoped_vs_unscoped)
 
 	memset(&self->parent_stream_address, 0,
 	       sizeof(self->parent_stream_address));
-	set_unix_address(&self->parent_stream_address, 0);
+	set_unix_address(&self->parent_stream_address, 0, true);
 	memset(&self->parent_dgram_address, 0,
 	       sizeof(self->parent_dgram_address));
-	set_unix_address(&self->parent_dgram_address, 1);
+	set_unix_address(&self->parent_dgram_address, 1, true);
 	memset(&self->child_stream_address, 0,
 	       sizeof(self->child_stream_address));
-	set_unix_address(&self->child_stream_address, 2);
+	set_unix_address(&self->child_stream_address, 2, true);
 	memset(&self->child_dgram_address, 0,
 	       sizeof(self->child_dgram_address));
-	set_unix_address(&self->child_dgram_address, 3);
+	set_unix_address(&self->child_dgram_address, 3, true);
 }
 
 FIXTURE_TEARDOWN(scoped_vs_unscoped)
@@ -622,9 +622,9 @@ FIXTURE_SETUP(outside_socket)
 	drop_caps(_metadata);
 
 	memset(&self->transit_address, 0, sizeof(self->transit_address));
-	set_unix_address(&self->transit_address, 0);
+	set_unix_address(&self->transit_address, 0, true);
 	memset(&self->address, 0, sizeof(self->address));
-	set_unix_address(&self->address, 1);
+	set_unix_address(&self->address, 1, true);
 }
 
 FIXTURE_TEARDOWN(outside_socket)
@@ -802,9 +802,9 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 
 	/* Abstract address. */
 	memset(&stream_abstract_addr, 0, sizeof(stream_abstract_addr));
-	set_unix_address(&stream_abstract_addr, 0);
+	set_unix_address(&stream_abstract_addr, 0, true);
 	memset(&dgram_abstract_addr, 0, sizeof(dgram_abstract_addr));
-	set_unix_address(&dgram_abstract_addr, 1);
+	set_unix_address(&dgram_abstract_addr, 1, true);
 
 	/* Unnamed address for datagram socket. */
 	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_DGRAM, 0, unnamed_sockets));
@@ -990,9 +990,9 @@ TEST(datagram_sockets)
 
 	drop_caps(_metadata);
 	memset(&connected_addr, 0, sizeof(connected_addr));
-	set_unix_address(&connected_addr, 0);
+	set_unix_address(&connected_addr, 0, true);
 	memset(&non_connected_addr, 0, sizeof(non_connected_addr));
-	set_unix_address(&non_connected_addr, 1);
+	set_unix_address(&non_connected_addr, 1, true);
 
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
@@ -1090,9 +1090,9 @@ TEST(self_connect)
 
 	drop_caps(_metadata);
 	memset(&connected_addr, 0, sizeof(connected_addr));
-	set_unix_address(&connected_addr, 0);
+	set_unix_address(&connected_addr, 0, true);
 	memset(&non_connected_addr, 0, sizeof(non_connected_addr));
-	set_unix_address(&non_connected_addr, 1);
+	set_unix_address(&non_connected_addr, 1, true);
 
 	connected_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 	non_connected_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index d8bf33417619..8d1e1dc89c43 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -463,7 +463,7 @@ TEST_F(fown, sigurg_socket)
 	pid_t child;
 
 	memset(&server_address, 0, sizeof(server_address));
-	set_unix_address(&server_address, 0);
+	set_unix_address(&server_address, 0, true);
 
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
-- 
2.52.0

