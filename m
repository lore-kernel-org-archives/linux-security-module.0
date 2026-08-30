Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290C309EE7
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121031; cv=none; b=Xuiz2EJMaE6JYtgDWWFKUAtuYLJpzfw73OW6Kcq595KYChjUtzNwISp3F4wTbV4R8XPMcJCuIO2hK5cLMgUE+HEs+9zOdopBsy9OBihks0hkxE56RTD7AQ9k+IuVrs6uLVsc6X+Q7OGj9sqx3bhFCP6qqfyKhhhSYd8TrfIhqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121031; c=relaxed/simple;
	bh=jNY4uJoFtV1wVz5cGO5OQXFw5bVAghAZjzW8EipPaDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uk7ajsJdilM5GgPrhL17GwUW/9Er6zDxzpoO+RLrIMMqGrMytxz/fa3GkYtu/toJcSStFVFLD5+cXWfMk78EFivj4mpAa3UdovFJ/z4FpVFV0fEMRTWpcANPIjNnjYIIH2QImUHDenFQR7B4WWbHy4Nw3/yPJQiHRAFbSUoq0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIeV4YqS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIeV4YqS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so15012945e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121028; x=1788725828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SGjXy395v8FjFoEjmZQLYbJNRsx4nqNp3408l01vhyw=;
        b=UIeV4YqSdGgxNNPyLNZMsvfVgAA+LhrLekBtVOhLViqNyKgyFwL3hPzqH+kL6vUg0p
         oJ8XYJPhZEK6nhm3wJn/xfBS7106dks1Cpo+n9BYjzd7xvM9RKY2TQjrFxi4/ZimP+QG
         bDQM/GZGcMzh+ZWmXtayG1IKn6nVQx1sIGzzXOZP4ccdguEQHi9W4W+V8XtfHaxLTwuk
         Rw1WXNMym7Dkvi0brC/YuT1OtZgzim1xbVX4DtRmTArbg4JtvC+zYJRt/X/Kn8+ULuAj
         FuS0j9j/jbJe1PE0uHbAMhGYE5UxrGJ+F6Ymd4jCMXdumEHH4wBeYsYaJfP/DBr7eil1
         ofUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121028; x=1788725828;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGjXy395v8FjFoEjmZQLYbJNRsx4nqNp3408l01vhyw=;
        b=c6w2uUxtXRBiYtgY+2piFPEKX+LKP3JTvGuuxcb0yXHNYfdKT8Vv4VKfVRtvmznF6V
         +VrMDAFg1ki+mda24Ldi/rVKJoyiuu13d7dv7aUPf/kfu6vEYBZtieEGJIQjsnHEcu2/
         4rauI7HBfIoPCydXlAie6v83+nk7gHiVRghc2IwnSPd6yD77DCQylQgNAdY1NPDEYIIX
         8RcChCoSmgK43F7xSyKqsqBBZF/jXtNEt7Nz8D0Nyobx6QvY1ZA4XMFmjene+q9nEl3C
         mWdpsKCKj/+LE/37Oq3yaRmFv0deN0AtOtGD+pnrLlob+ifzOaPeLjB9EkWzi9fc6VtV
         x3hg==
X-Forwarded-Encrypted: i=1; AHgh+RoT6WzWLGj+Rnib9pIAnaG/mNgosWYY4mQDPbpOiZmOozVy5aF04QvPS4lY+L9sp1BAcnNJDvesOOI6P9+i3X5yXlFG2dg=@vger.kernel.org
X-Gm-Message-State: AFuF++n8S4VA1Ac9rj81mg5uVSZOdoRShJRV/6k0Cvb4Oz6Xg5RmCeQK
	wCIfhJ3/Mi1GA/F3yJUQQ4pCBSk6Bic0guLyU5vXNZvZ44rpIi7LRael
X-Gm-Gg: AR+sD11uVNCLADzyxHcQ6XC7+Qi2I7IYa3A1X0lPSL6c1hxgdPrRnu1VR5s/PrKs3K2
	CvJglA2aXiIJzhlDDNOt+LDne6msS9jAFwqbeN1GR82790Iji5k7CWj6yjob4gTrpV86u/BpgI3
	cfosU+xeoYKPT2o7rW93UW2aiwEu+fmxVoKYp1bdJEr8lATSmtJu2e54RAszI6Q0kaqeSVLtHNP
	N5kHpsu0XfgrdkGnuLQ0V8cm+zpFcVIE018KgTX/dEtbVSsxbzaCeKAKuIRS7FpMaHOXcwGB0jF
	9MItbgWs8m9BiglE+5z05vQp31PM2/NCPUw9ZWFwP+9Wd2mrR/otYbMq71jj+oixLjBoI2nW4p0
	EcBUQ2h3vHNVX0icO4vG4KApRp0rTVJ7ho3EllX1688v96fLt/yRGA/6cOVDrLNEbzVKnzuCNxR
	gEUJWh9M0h6ObE4tYFueExDtdpmgVwtKW42EWGOifWpcfnIxfSclNo8H/H4dKkRyi0Xz3nNT63b
	7ape8lGNMnpoQ==
X-Received: by 2002:a05:600c:1d1d:b0:499:ad2e:f7bc with SMTP id 5b1f17b1804b1-49b91c3ddbcmr257245375e9.10.1788121027637;
        Sun, 30 Aug 2026 13:17:07 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cc9497b3esm180660665e9.5.2026.08.30.13.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:07 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 4/6] selftests/landlock: Add MPTCP network access tests
Date: Sun, 30 Aug 2026 22:16:48 +0200
Message-ID: <20260830201650.67050-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test LANDLOCK_ACCESS_NET_BIND_MPTCP and LANDLOCK_ACCESS_NET_CONNECT_MPTCP:

* Add the MPTCP_SANDBOX variant to the net_test fixtures.
* Introduce prot_*() helper functions for audit tests.
* Extend existing tests as needed for MPTCP, including the tcp_fastopen test.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/net_test.c | 256 ++++++++++++++++----
 1 file changed, 210 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 3a0482beca5f..fbb3a99bc380 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -40,6 +40,7 @@ enum sandbox_type {
 	/* This may be used to test rules that allow *and* deny accesses. */
 	TCP_SANDBOX,
 	UDP_SANDBOX,
+	MPTCP_SANDBOX,
 };
 
 static int set_service(struct service_fixture *const srv,
@@ -105,6 +106,12 @@ static bool prot_is_udp(const struct protocol_variant *const prot)
 	       (prot->protocol == IPPROTO_UDP || prot->protocol == IPPROTO_IP);
 }
 
+static bool prot_is_mptcp(const struct protocol_variant *const prot)
+{
+	return (prot->domain == AF_INET || prot->domain == AF_INET6) &&
+	       prot->type == SOCK_STREAM && prot->protocol == IPPROTO_MPTCP;
+}
+
 static bool is_restricted(const struct protocol_variant *const prot,
 			  const enum sandbox_type sandbox)
 {
@@ -113,6 +120,8 @@ static bool is_restricted(const struct protocol_variant *const prot,
 		return prot_is_tcp(prot);
 	case UDP_SANDBOX:
 		return prot_is_udp(prot);
+	case MPTCP_SANDBOX:
+		return prot_is_mptcp(prot);
 	case NO_SANDBOX:
 	default:
 		return false;
@@ -126,6 +135,8 @@ static __u64 sandbox_bind_access(const enum sandbox_type sandbox)
 		return LANDLOCK_ACCESS_NET_BIND_TCP;
 	case UDP_SANDBOX:
 		return LANDLOCK_ACCESS_NET_BIND_UDP;
+	case MPTCP_SANDBOX:
+		return LANDLOCK_ACCESS_NET_BIND_MPTCP;
 	case NO_SANDBOX:
 	default:
 		return 0;
@@ -139,6 +150,8 @@ static __u64 sandbox_connect_access(const enum sandbox_type sandbox)
 		return LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	case UDP_SANDBOX:
 		return LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+	case MPTCP_SANDBOX:
+		return LANDLOCK_ACCESS_NET_CONNECT_MPTCP;
 	case NO_SANDBOX:
 	default:
 		return 0;
@@ -815,6 +828,114 @@ FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_unix_datagram) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv4_tcp1) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv4_tcp2) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_TCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv4_mptcp) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv6_tcp1) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv6_tcp2) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_TCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv6_mptcp) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv4_udp) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_ipv6_udp) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_unix_stream) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_UNIX,
+		.type = SOCK_STREAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, mptcp_sandbox_with_unix_datagram) {
+	/* clang-format on */
+	.sandbox = MPTCP_SANDBOX,
+	.prot = {
+		.domain = AF_UNIX,
+		.type = SOCK_DGRAM,
+	},
+};
+
 static void test_bind_and_connect(struct __test_metadata *const _metadata,
 				  const struct service_fixture *const srv,
 				  const bool deny_bind, const bool deny_connect)
@@ -1294,14 +1415,12 @@ TEST_F(protocol, connect_unspec)
 
 TEST_F(protocol, tcp_fastopen)
 {
-	const bool restricted = variant->sandbox == TCP_SANDBOX &&
-				variant->prot.type == SOCK_STREAM &&
-				(variant->prot.protocol == IPPROTO_TCP ||
-				 variant->prot.protocol == IPPROTO_IP) &&
-				(variant->prot.domain == AF_INET ||
-				 variant->prot.domain == AF_INET6);
+	const bool stream_sandbox = variant->sandbox == TCP_SANDBOX ||
+				    variant->sandbox == MPTCP_SANDBOX;
+	const bool restricted = stream_sandbox &&
+				is_restricted(&variant->prot, variant->sandbox);
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = sandbox_connect_access(variant->sandbox),
 	};
 	int bind_fd, client_fd, status;
 	char buf;
@@ -1324,7 +1443,7 @@ TEST_F(protocol, tcp_fastopen)
 		connect_fd = socket_variant(&self->srv0);
 		ASSERT_LE(0, connect_fd);
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (stream_sandbox) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -2219,13 +2338,15 @@ FIXTURE_TEARDOWN(mini)
 
 /* clang-format off */
 
-#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
+#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_MPTCP
 
 #define ACCESS_ALL ( \
 	LANDLOCK_ACCESS_NET_BIND_TCP | \
 	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
 	LANDLOCK_ACCESS_NET_BIND_UDP | \
-	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)
+	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP | \
+	LANDLOCK_ACCESS_NET_BIND_MPTCP | \
+	LANDLOCK_ACCESS_NET_CONNECT_MPTCP)
 
 /* clang-format on */
 
@@ -2949,6 +3070,28 @@ FIXTURE_VARIANT_ADD(audit, ipv6_udp) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, ipv4_mptcp) {
+	/* clang-format on */
+	.addr = "127\\.0\\.0\\.1",
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, ipv6_mptcp) {
+	/* clang-format on */
+	.addr = "::1",
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
 FIXTURE_SETUP(audit)
 {
 	struct protocol_variant prot_unspec = variant->prot;
@@ -2975,17 +3118,56 @@ FIXTURE_TEARDOWN(audit)
 	clear_cap(_metadata, CAP_AUDIT_CONTROL);
 }
 
+static __u64 prot_bind_access(const struct protocol_variant *const prot)
+{
+	if (prot_is_mptcp(prot))
+		return LANDLOCK_ACCESS_NET_BIND_MPTCP;
+
+	if (prot->type == SOCK_STREAM)
+		return LANDLOCK_ACCESS_NET_BIND_TCP;
+
+	return LANDLOCK_ACCESS_NET_BIND_UDP;
+}
+
+static __u64 prot_connect_access(const struct protocol_variant *const prot)
+{
+	if (prot_is_mptcp(prot))
+		return LANDLOCK_ACCESS_NET_CONNECT_MPTCP;
+
+	if (prot->type == SOCK_STREAM)
+		return LANDLOCK_ACCESS_NET_CONNECT_TCP;
+
+	return LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+}
+
+static const char *prot_bind_blocker(const struct protocol_variant *const prot)
+{
+	if (prot_is_mptcp(prot))
+		return "net\\.bind_mptcp";
+
+	if (prot->type == SOCK_STREAM)
+		return "net\\.bind_tcp";
+
+	return "net\\.bind_udp";
+}
+
+static const char *
+prot_connect_blocker(const struct protocol_variant *const prot)
+{
+	if (prot_is_mptcp(prot))
+		return "net\\.connect_mptcp";
+
+	if (prot->type == SOCK_STREAM)
+		return "net\\.connect_tcp";
+
+	return "net\\.connect_send_udp";
+}
+
 TEST_F(audit, bind)
 {
-	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
-					 "net\\.bind_tcp" :
-					 "net\\.bind_udp");
-	const __u64 access_rights =
-		(variant->prot.type == SOCK_STREAM ?
-			 LANDLOCK_ACCESS_NET_BIND_TCP |
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
-			 LANDLOCK_ACCESS_NET_BIND_UDP |
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+	const char *audit_evt = prot_bind_blocker(&variant->prot);
+	const __u64 access_rights = prot_bind_access(&variant->prot) |
+				    prot_connect_access(&variant->prot);
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = access_rights,
 		.quiet_access_net = access_rights,
@@ -3031,15 +3213,9 @@ TEST_F(audit, bind)
 
 TEST_F(audit, connect)
 {
-	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
-					 "net\\.connect_tcp" :
-					 "net\\.connect_send_udp");
-	const __u64 bind_right = (variant->prot.type == SOCK_STREAM ?
-					  LANDLOCK_ACCESS_NET_BIND_TCP :
-					  LANDLOCK_ACCESS_NET_BIND_UDP);
-	const __u64 conn_right = (variant->prot.type == SOCK_STREAM ?
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP :
-					  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+	const char *audit_evt = prot_connect_blocker(&variant->prot);
+	const __u64 bind_right = prot_bind_access(&variant->prot);
+	const __u64 conn_right = prot_connect_access(&variant->prot);
 	const __u64 access_rights = bind_right | conn_right;
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = access_rights,
@@ -3104,15 +3280,9 @@ TEST_F(audit, connect)
 /* Quieting bind access has no effect on connect. */
 TEST_F(audit, connect_quiet_bind)
 {
-	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
-					 "net\\.connect_tcp" :
-					 "net\\.connect_send_udp");
-	const int bind_right = (variant->prot.type == SOCK_STREAM ?
-					LANDLOCK_ACCESS_NET_BIND_TCP :
-					LANDLOCK_ACCESS_NET_BIND_UDP);
-	const int conn_right = (variant->prot.type == SOCK_STREAM ?
-					LANDLOCK_ACCESS_NET_CONNECT_TCP :
-					LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+	const char *audit_evt = prot_connect_blocker(&variant->prot);
+	const int bind_right = prot_bind_access(&variant->prot);
+	const int conn_right = prot_connect_access(&variant->prot);
 	const int access_rights = bind_right | conn_right;
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = access_rights,
@@ -3194,15 +3364,9 @@ static int matches_log_connect_bound(int audit_fd, const char *const blockers,
  */
 TEST_F(audit, connect_bound)
 {
-	const __u64 bind_right = (variant->prot.type == SOCK_STREAM ?
-					  LANDLOCK_ACCESS_NET_BIND_TCP :
-					  LANDLOCK_ACCESS_NET_BIND_UDP);
-	const __u64 conn_right = (variant->prot.type == SOCK_STREAM ?
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP :
-					  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
-	const char *const audit_evt = (variant->prot.type == SOCK_STREAM ?
-					       "net\\.connect_tcp" :
-					       "net\\.connect_send_udp");
+	const __u64 bind_right = prot_bind_access(&variant->prot);
+	const __u64 conn_right = prot_connect_access(&variant->prot);
+	const char *const audit_evt = prot_connect_blocker(&variant->prot);
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = bind_right | conn_right,
 	};
-- 
2.55.0

