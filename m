Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F42E0926
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588518; cv=none; b=cskcp+odMG3y5qmkiS2QIhaET5U6m+aWfdUz7sxsBiEDUgdMSpi6ogB+EF4Pi6BQ2nNiPHUYdIBH8NyKYcGEVMUQdbYNyULAvuM+4XIq3VntVrCiwaCom702qsLZmSB0Y4DkBLR0bXQbB4lkR94Etamy52rrqpzi02Zh1fgywCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588518; c=relaxed/simple;
	bh=zIc6X9ZOkN2OMlA+nzoUiQm9CiNFlkIctTX5hvHKgOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jel+C2aoLsPlieED8eHHitLykI6dI1cI4UyRfpwTldoyJM0haJjUxIsUt6otbrbc10Oi7eyRBUltprSQTmoC5+A8/sVnG/KCNZ2cTn5Rzp7UU673dDljnKEAle243sdqBQd3CeqCpZbl8sa3tV70c7/OtqPaPv7V85AYvDr/G5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=b/Oel+0p; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="b/Oel+0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1761588513; bh=zIc6X9ZOkN2OMlA+nzoUiQm9CiNFlkIctTX5hvHKgOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/Oel+0pXIyiIQJV+1Nxo7RzFybAOvHRi9w3Xx5/q3Ek6OZQ+YMSrtRjoaXn+IXYU
	 AB5+wEkhyuI2EEn1gf/xJ9ZcdYSIkFvas+9N4SxW60AHFD9h4Qmt4OFK/CoVi9yOGa
	 b3HJEVz6fBI6BLSXMtO0sh/sd9dGTgSFs6Cz82gfeS9vSBUyJQl37Zs/9y2gsH7tim
	 pBERPbMKtUp5U1TCRqt8VDNg7UvZ2Cdccf5L9xz+W3B134n0yhQmBhEHP1olwc83pU
	 4Omh+omSyPiTIyVh3zNucNzCvAGPz9TT6NusRtseYypEKYsvnujewdpuIYoqEJfk3u
	 Rp+QKUW1Szfng==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 001FD125423;
	Mon, 27 Oct 2025 19:08:32 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 2/3] selftests/landlock: Add missing connect(minimal AF_UNSPEC) test
Date: Mon, 27 Oct 2025 20:07:25 +0100
Message-Id: <20251027190726.626244-3-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027190726.626244-1-matthieu@buffet.re>
References: <20251027190726.626244-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

connect_variant(unspec_any0) is called twice. Both calls end
up in connect_variant_addrlen() with an address length of
get_addrlen(minimal=false).
However, the connect() syscall and its variants (e.g.
iouring/compat) accept much shorter addresses of 4 bytes
and that behaviour was not tested.

Replace one of these calls with one using a minimal address
length (just a bare sa_family=AF_UNSPEC field with no actual
address). Also add a call using a truncated address for good
measure.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 3bbc0508420b..b34b139b3f89 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -906,7 +906,19 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, close(ruleset_fd));
 		}
 
-		ret = connect_variant(connect_fd, &self->unspec_any0);
+		/* Try to re-disconnect with a truncated address struct. */
+		EXPECT_EQ(-EINVAL,
+			  connect_variant_addrlen(
+				  connect_fd, &self->unspec_any0,
+				  get_addrlen(&self->unspec_any0, true) - 1));
+
+		/*
+		 * Re-disconnect, with a minimal sockaddr struct (just a
+		 * bare af_family=AF_UNSPEC field).
+		 */
+		ret = connect_variant_addrlen(connect_fd, &self->unspec_any0,
+					      get_addrlen(&self->unspec_any0,
+							  true));
 		if (self->srv0.protocol.domain == AF_UNIX &&
 		    self->srv0.protocol.type == SOCK_STREAM) {
 			EXPECT_EQ(-EINVAL, ret);
-- 
2.47.2

