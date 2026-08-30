Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1530D3F8
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121027; cv=none; b=CE1VNpC7P+uCM1KODBfYkZdLej5kWSPKQuAvar+YFA0Xp8bWMVYkR0awJwAuEhrmPfoaJrKdYE8Rd78kle2B+OX+iBHsBUwO9Mteft4Hs8J0H6WwXhQkDJkpbe3OqdE7iGg6lHp2Di68qcVlJB8FQqOPipwVz0WP5OGGjmd+/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121027; c=relaxed/simple;
	bh=7wEDaDm21llur5hKylLQvWMRMvBg/bAaty0AoAvvgrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cX7SMrCMDEOAxg/00vnTqJBKhUANaKVE+nDAe7EcHPbm9ajFX95pJgZnV5zcrgBR1u08YfNpSzsh5odOq9s+pX5nmMnUyVuaLPUExAlk3pH4tmINZuo+H9M5x/Mw4timfIv5lp6BkIWyfwwmk6lwI0q3NXKSY19A57sPPiUlgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDv1LVis; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDv1LVis"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso16089685e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121024; x=1788725824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Pdseog3hjBqegC/S81uic44NEP627xpHcoKP1WPxsA=;
        b=nDv1LVisI4np3KEtvGVNGOW7sBFQuqbDLd3gn5uEUVhsdhTHfJlcHSWepHvflET9q1
         JiV018miv/DwkoP6IYiQ/Qg0JLdcHEpaVED/N/v2QJczqlAmfmGWjBOZMgOlb7f5cNM2
         e+mU/8fkZzy12zhI+7mXFIbbmEadJDs0/vaYg0OSIRbQwRQzofLxCJuJXtpbBm3muGAl
         +x7bxBrhG6oxfm5/Xg3+TRKJYViZGa/efoMkWO0ogRtiQtiS5Hia6ibpLyCUasxloVW3
         J6DNgCXmS8LGgLzj64ofpXGo80cT+2GE5yrnI1Cqq9wAzX2QI6hBReAKZ10VXO84Tqcn
         eMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121024; x=1788725824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Pdseog3hjBqegC/S81uic44NEP627xpHcoKP1WPxsA=;
        b=Ou/mIo1ljFhF15Zttwc4SqIRkYgLgX3FmUWO4GA7jxJstOGbWJ9sWVoYNjMKB8upaS
         IYSKtECQNzX6FFn4N8QF14PNlf0uTA/QU3wRgBU7opuprK6evxfapVE4hwd6JDt1LaXT
         eT4g7Vv2O81RVUVgtpp4rdDHtmnfa6WnFyyAx7IKlGp+zhZd5vyh93ZH2mJ2jovX2Bsp
         qKcjIruxZgqOboZn3DP41DYsdDPN0NySg4je+G3hlQFb8EW80DnYu5UJ0M8Hx1CFfr+q
         1T3ce/znof6nftFP9jKSiE7U5DVB22ufsPf2CFYn+rlqSxOEO8N06PgLijVUOVtUYju2
         nSxA==
X-Forwarded-Encrypted: i=1; AHgh+Roh4PaamOZFf8FX+WsMhiEQcMWYblVX7bzGqnZvwt67xZMseNyucNnEbr7SLQYHL/rdIV+xdnPqJcN4OmNNRJd6fUZtVu8=@vger.kernel.org
X-Gm-Message-State: AFuF++lDDKEvLXDhQszjtJfJZkEtWQOeamccy6+QJmoz9LuElEmz4CS9
	BvxmVyWQzCZ+jkqqT3lt0/svtsZRK0fRpJM82I63jIZ2HaI20l6wO7Jv
X-Gm-Gg: AR+sD12/99vTAzznclF3oVeVeXr0P2R7i3WpYdrtn2FEO2aXPLjAIqkK5lfKQzEi5Pj
	dudAfhnZqqSYBMWu6xTdx31wMUHW+vulZ0SjM0i0jA9kDkJfNnyC8PZaT7vKU/r4QOxfwKo4n0+
	kMDmY1N9qbFofpamdpsTUaJafmhgHx+LsVam2PdjJq7d1bFvF96ImBIZvaJbcH6ZJRlqk2sZn0F
	cFR7yAaVOzggQgDUK+R+LLVVxMQyH/N4NJOROoRIciCXvpaAHWehimH5tB2+oI8HbYM2V+Vs05K
	jfhZ9pOq1g2KZPXmrvVhW2IcjuIBD9zBskF0Wakp6HSS7zGjj+cbLlzwkbEZ5AJ6rsjp4XbOHac
	y6hGzTUlJl6K9SNwUIf1kYO1wyIAWlQNoloV7u/ynB8NCXaFfggidGkwGu+qixrHHGZ25U28aDf
	cjl167XumpjlBPvucL686v/T90FD4Zenh1aO+QgrsaXYg9+SEWyahbZuxx70ESZNGppXopJNgHg
	xeV8gV54UJ41WgIbv7RFpoa
X-Received: by 2002:a05:600c:a106:b0:49c:cb6a:1687 with SMTP id 5b1f17b1804b1-49ccb6a1689mr169989075e9.4.1788121024059;
        Sun, 30 Aug 2026 13:17:04 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dcaf61sm214133605e9.4.2026.08.30.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:03 -0700 (PDT)
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
Subject: [PATCH 2/6] selftests/landlock: Generalize net test helpers for multiple socket types
Date: Sun, 30 Aug 2026 22:16:46 +0200
Message-ID: <20260830201650.67050-3-gnoack3000@gmail.com>
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

Create helper methods for determining the access rights to be tested
based on socket type (TCP or UDP).  This makes it simpler to add more
socket types with similar bind(2) and connect(2) restrictions in the
future.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/net_test.c | 85 +++++++++++----------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index a18761e0fd82..3a0482beca5f 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -108,11 +108,41 @@ static bool prot_is_udp(const struct protocol_variant *const prot)
 static bool is_restricted(const struct protocol_variant *const prot,
 			  const enum sandbox_type sandbox)
 {
-	if (sandbox == TCP_SANDBOX)
+	switch (sandbox) {
+	case TCP_SANDBOX:
 		return prot_is_tcp(prot);
-	else if (sandbox == UDP_SANDBOX)
+	case UDP_SANDBOX:
 		return prot_is_udp(prot);
-	return false;
+	case NO_SANDBOX:
+	default:
+		return false;
+	}
+}
+
+static __u64 sandbox_bind_access(const enum sandbox_type sandbox)
+{
+	switch (sandbox) {
+	case TCP_SANDBOX:
+		return LANDLOCK_ACCESS_NET_BIND_TCP;
+	case UDP_SANDBOX:
+		return LANDLOCK_ACCESS_NET_BIND_UDP;
+	case NO_SANDBOX:
+	default:
+		return 0;
+	}
+}
+
+static __u64 sandbox_connect_access(const enum sandbox_type sandbox)
+{
+	switch (sandbox) {
+	case TCP_SANDBOX:
+		return LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	case UDP_SANDBOX:
+		return LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+	case NO_SANDBOX:
+	default:
+		return 0;
+	}
 }
 
 static int socket_variant(const struct service_fixture *const srv)
@@ -916,16 +946,10 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 
 TEST_F(protocol, bind)
 {
-	if (variant->sandbox == TCP_SANDBOX ||
-	    variant->sandbox == UDP_SANDBOX) {
-		const __u64 bind_access =
-			(variant->sandbox == TCP_SANDBOX ?
-				 LANDLOCK_ACCESS_NET_BIND_TCP :
-				 LANDLOCK_ACCESS_NET_BIND_UDP);
+	if (variant->sandbox != NO_SANDBOX) {
+		const __u64 bind_access = sandbox_bind_access(variant->sandbox);
 		const __u64 conn_access =
-			(variant->sandbox == TCP_SANDBOX ?
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+			sandbox_connect_access(variant->sandbox);
 		const struct landlock_ruleset_attr ruleset_attr = {
 			.handled_access_net = bind_access | conn_access,
 		};
@@ -987,16 +1011,10 @@ TEST_F(protocol, bind)
 
 TEST_F(protocol, connect)
 {
-	if (variant->sandbox == TCP_SANDBOX ||
-	    variant->sandbox == UDP_SANDBOX) {
-		const __u64 bind_access =
-			(variant->sandbox == TCP_SANDBOX ?
-				 LANDLOCK_ACCESS_NET_BIND_TCP :
-				 LANDLOCK_ACCESS_NET_BIND_UDP);
+	if (variant->sandbox != NO_SANDBOX) {
+		const __u64 bind_access = sandbox_bind_access(variant->sandbox);
 		const __u64 conn_access =
-			(variant->sandbox == TCP_SANDBOX ?
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+			sandbox_connect_access(variant->sandbox);
 		const struct landlock_ruleset_attr ruleset_attr = {
 			.handled_access_net = bind_access | conn_access,
 		};
@@ -1054,9 +1072,7 @@ TEST_F(protocol, connect)
 
 TEST_F(protocol, bind_unspec)
 {
-	const __u64 bind_access = (variant->sandbox == TCP_SANDBOX ?
-					   LANDLOCK_ACCESS_NET_BIND_TCP :
-					   LANDLOCK_ACCESS_NET_BIND_UDP);
+	const __u64 bind_access = sandbox_bind_access(variant->sandbox);
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = bind_access,
 	};
@@ -1066,8 +1082,7 @@ TEST_F(protocol, bind_unspec)
 	};
 	int bind_fd, ret;
 
-	if (variant->sandbox == TCP_SANDBOX ||
-	    variant->sandbox == UDP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -1103,8 +1118,7 @@ TEST_F(protocol, bind_unspec)
 	}
 	EXPECT_EQ(0, close(bind_fd));
 
-	if (variant->sandbox == TCP_SANDBOX ||
-	    variant->sandbox == UDP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -1150,13 +1164,8 @@ TEST_F(protocol, bind_unspec)
 
 TEST_F(protocol, connect_unspec)
 {
-	const __u64 connect_right =
-		(variant->sandbox == TCP_SANDBOX ?
-			 LANDLOCK_ACCESS_NET_CONNECT_TCP :
-			 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
-	const __u64 bind_right = (variant->sandbox == TCP_SANDBOX ?
-					  LANDLOCK_ACCESS_NET_BIND_TCP :
-					  LANDLOCK_ACCESS_NET_BIND_UDP);
+	const __u64 connect_right = sandbox_connect_access(variant->sandbox);
+	const __u64 bind_right = sandbox_bind_access(variant->sandbox);
 	const struct landlock_ruleset_attr ruleset_conn = {
 		.handled_access_net = connect_right,
 	};
@@ -1197,8 +1206,7 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX ||
-		    variant->sandbox == UDP_SANDBOX) {
+		if (variant->sandbox != NO_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_conn, sizeof(ruleset_conn), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -1229,8 +1237,7 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX ||
-		    variant->sandbox == UDP_SANDBOX) {
+		if (variant->sandbox != NO_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_conn_bind, sizeof(ruleset_conn_bind),
 				0);
-- 
2.55.0

