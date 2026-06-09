Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CE38D401
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2026 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039767; cv=none; b=Pzgsf/gTXBEIJuMXP2O6/oKBJ4mutdxlBigIsjl9/EdOOGBUsIMDCYr5zSK2vorBHfzCTCPdgm38u86kkvD+Me4AdKRs800xF7UxtdU/J137rfquYNnxozgouIRX8iJlUjWeZEZlZWqbD7W+rysdTfRT+i0O8ZuRhFDVixiGtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039767; c=relaxed/simple;
	bh=rIt4kHAP/LEQE9No+iH6YufrtW5b/sn6disemL05uCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=filQaZwbEv66WYiQw3NNXV5gk8UEPkEEIfyoB1BiLhPibyP4pxNbtJwf0YodhgSxTfrXHQpmngJovfenpbE15VShcgGQo2PBppo0/dan3P9mnC8nMy5AMWncOVz9vFDP21fPTYR64AwgKKMRjECHnIGwqYUcaUEGPGWgRGrBdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=b/p7AgIA; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="b/p7AgIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781039756; bh=rIt4kHAP/LEQE9No+iH6YufrtW5b/sn6disemL05uCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/p7AgIAFwodCfcAl1WoG4Wq3Ue9vKI21xd9mAWi/p37FDzWERPeDHktLe8lx4XRP
	 Yp7Fm3rLpi9PbGgEDMH1sxAPXSgnCJGxaK3SV9/nSkqFeplI95tDNOBAv20m/kHlLC
	 6NaFTyKyyH6dP4QmFlbNmhWz+oGFhMdOJnjwl7bsFGvTlC65itV8vUwjb6EhbkAfkE
	 NRHyjFZF2RYIOqfCmdPGjxuHfXFK+DK/lB77KZB0NHZNtdIS4v/q+L/t2Sb1cjgLHO
	 Eq3CvqI78xDNsmJFQnWJpIf79DJqmaVEtakE4rYeiHnxaGIY8WHcCuLiagsfaSB9Yy
	 j8/8NLxGKnRAg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 3285A125930;
	Tue,  9 Jun 2026 23:15:56 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Buffet <matthieu@buffet.re>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] landlock: Fix unmarked concurrent access to socket family
Date: Tue,  9 Jun 2026 23:15:10 +0200
Message-ID: <20260609211511.85630-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e561a8c3-de10-45ba-a931-27b9a5751dc9@buffet.re>
References: <e561a8c3-de10-45ba-a931-27b9a5751dc9@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket family is read (twice) in a context where the socket is not
locked, so another thread can setsockopt(IPV6_ADDRFORM) to write it
concurrently. Add needed READ_ONCE() annotation.

Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/landlock/net.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index a38bdfcffc22..111e58fd9325 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -55,6 +55,7 @@ static int current_check_access_socket(struct socket *const sock,
 	const struct access_masks masks = {
 		.net = access_request,
 	};
+	unsigned short sock_family;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
 	struct lsm_network_audit audit_net = {};
@@ -66,6 +67,12 @@ static int current_check_access_socket(struct socket *const sock,
 	if (addrlen < offsetofend(typeof(*address), sa_family))
 		return -EINVAL;
 
+	/*
+	 * The socket is not locked, so sk_family can change concurrently
+	 * due to e.g. setsockopt(IPV6_ADDRFORM).
+	 */
+	sock_family = READ_ONCE(sock->sk->__sk_common.skc_family);
+
 	switch (address->sa_family) {
 	case AF_UNSPEC:
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
@@ -102,7 +109,7 @@ static int current_check_access_socket(struct socket *const sock,
 			 * these checks, but it is safer to return a proper
 			 * error and test consistency thanks to kselftest.
 			 */
-			if (sock->sk->__sk_common.skc_family == AF_INET) {
+			if (sock_family == AF_INET) {
 				const struct sockaddr_in *const sockaddr =
 					(struct sockaddr_in *)address;
 
@@ -180,7 +187,7 @@ static int current_check_access_socket(struct socket *const sock,
 	 * check, but it is safer to return a proper error and test
 	 * consistency thanks to kselftest.
 	 */
-	if (address->sa_family != sock->sk->__sk_common.skc_family &&
+	if (address->sa_family != sock_family &&
 	    address->sa_family != AF_UNSPEC)
 		return -EINVAL;
 

base-commit: 4c403b9ffc86358d5ae50e4121aaf541bdab04d8
-- 
2.47.3

