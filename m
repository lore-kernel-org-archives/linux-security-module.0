Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C033A71A;
	Thu, 21 May 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376581; cv=none; b=kB2zUDPLy5J/Kmk8FCtpYvvWOzLK+RXpAi3rObbt11dmPa3hxkunqFJaimIb4b1x5jcXa3gDeipjSLJlYMfUGfFTKqPKhOyq8S3BdA2/VOi6T83CCwkNJrBczIGYwriADVVUDDYTFAfTtzaZp6Gk95WXu70GNInOr6lGPyr/xB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376581; c=relaxed/simple;
	bh=XMaiFRdfWXMwTrsnzo2uMLmxDTTwoGSwePT6jiZKWxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBj43TDmIBzEn/I1CwU8UXY9pvvGAaeAL1NX1q7VtOfFfS3VsE567wsKFkNZbygzwsz7/WzBRXbHuwHfUut4ah6p7ti+Dd3NE+GHetr5TpTXgIUniBwwmlG8XaUz65wlFpRL7GnL4O1OKz8moE3J4X0V7f7aXKPs2nvifob/7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eduardovasconcelos.com; spf=pass smtp.mailfrom=eduardovasconcelos.com; dkim=pass (2048-bit key) header.d=eduardovasconcelos.com header.i=@eduardovasconcelos.com header.b=oDzFJx5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTz1+3KS; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eduardovasconcelos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eduardovasconcelos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eduardovasconcelos.com header.i=@eduardovasconcelos.com header.b="oDzFJx5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTz1+3KS"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id B005A1300D58;
	Thu, 21 May 2026 11:16:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 21 May 2026 11:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	eduardovasconcelos.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1779376578; x=1779380178; bh=VlREViZVwVWezytnhlvlcYEa6W7KUthVxEO
	CdcP2j1g=; b=oDzFJx5IGPPOEYirRi3TtY/phXLgGfii8V3tGXzm9fyXMHALkIT
	LzMk47xD/of7e9xGQ+mRuQyfmaIzVjXcxRuB9iOX/9q4HKu3xHnPh2d5t/1lRdAe
	//hqRz6pfOOhjFumRoYEzloxpDL0/ztX1aZpNjazcwU7ZneXkS4Qi+S4pb+m74BF
	0yloa2pR/1GyKtsCzKDVcvaMw7UWV3Wgq7IbR90DkvWjn2Dnf0e0ZI4CFOJbt3Ud
	6xIRbiwgWB0Tgv4APDPKKdt+1AWoBJt2dB/0dq9SYzluqSytxsWmOeQ+RKGCYWA7
	odTxzU9jHcDJeuPY4dFbqZhjA0Rr5E7UQGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779376578; x=1779380178; bh=VlREViZVwVWezytnhlvlcYEa6W7KUthVxEO
	CdcP2j1g=; b=eTz1+3KSBGFWkeKf5SEcZevM4gr0SnW+vzZ4C8ElspJz0V8VEyx
	C1KDRDKqge44yztY9n5sO/C7befMSOmk1OXZHXs95AK0PExhCoFd9K5Vzq/hwk3H
	uiZW6fxbnMIe+H56F7S02IG5Dh6hUvWY4EVw20C0L2gbXpohUN/KV945NQb9UUbe
	Vm3fdO/NMqrXiKtaYIyxHFsn40wzpDGapoJj0X6FihEk//x0Yo6eOtCtk89x+VaX
	NTTMMQRHfNDDPHvNUuwMdwdzIL0GV6W1cne79mKutY9df9U0ni0sY4h1EjLBSNyS
	Wg6nIEJG7y4z3lt1hG1rwi2kNcnPoxj/YIg==
X-ME-Sender: <xms:wSEPapJ7Eq531YWJkqe5sb_R0Om6UrNjEGKhSFmuBF2YhgogN4IcGQ>
    <xme:wSEPahLHMyC9E4n55uzuSldl5F-kB57cUdhV2fVyyTPnEVZYOe141PbRBU-HY49LM
    vX1nydjMadP967_HT-Uk9tNiMkhWoxdDNx7HV_JxCf6ODDSVR4hrQ>
X-ME-Received: <xmr:wSEPaj4_Qd5y4QvRMD7IvpRKSwWxfgS9J0l5H0NH-QNrN13YYbcPBRAwlKnePw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefgughurghrughoucggrghstghonhgtvghlohhsuceovgguuhgrrhgu
    ohesvgguuhgrrhguohhvrghstghonhgtvghlohhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpeevffetffegkeetleejfeevkeeihfffueeitdekkeekkedvudegjeeivdeutefhieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepvgguuhgrrhguohesvgguuhgrrhguohhvrghstgho
    nhgtvghlohhsrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehjohhhnhdrjhhohhgrnhhsvghnsegtrghnohhnihgtrghlrdgtohhm
    pdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhope
    hjmhhorhhrihhssehnrghmvghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlhhl
    hihnrdgtohhmpdhrtghpthhtohepvgguuhgrrhguohesvgguuhgrrhguohhvrghstghonh
    gtvghlohhsrdgtohhmpdhrtghpthhtoheprghpphgrrhhmohhrsehlihhsthhsrdhusghu
    nhhtuhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wSEPareBdYRZq-TYEGiJ6l1g8CO6AojzQOZJ2iW43HibMWg9Y6GpcQ>
    <xmx:wSEPauF5ZMY07ltuXSCv78VaeKcdZaPxT7ly_nnvpbng9-hH15BoqA>
    <xmx:wSEPakTAQEWKYi5gv4l-ZhvyMnYuoOc8G-aIfZkmeDtU2YntLUyuEA>
    <xmx:wSEPasYkf2HObQ1Sjj2BPXFDfySkr2NGFnYjQM06_C-9ELDu9KJslg>
    <xmx:wiEPaqcI0gi1hxnoLaKN9UVx5Us_FKndQOzRY9ZxbhKannS8VVq2qO1b>
Feedback-ID: iac1e4b6b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 11:16:15 -0400 (EDT)
From: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] apparmor: Fix inverted comparison in cache_hold_inc()
Date: Thu, 21 May 2026 12:13:06 -0300
Message-ID: <20260521151314.8683-1-eduardo@eduardovasconcelos.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cache_hold_inc() prevents the per-CPU cache hold counter from
rising above MAX_HOLD_COUNT, but the comparison is inverted
(> MAX_HOLD_COUNT instead of <), so the counter never rises
above 0.

This breaks the cache mechanism because since the hold counter
is always 0, the global pool is always attempted first before
falling back to the local cache. The decrement also never occurs,
thus the hold counter is effectively dead.

Fix by changing > to < in cache_hold_inc().

Fixes: 0b6a6b72b329 ("apparmor: document the buffer hold, add an overflow guard")
Signed-off-by: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>
---
Changes in v2:
- Add Fixes: tag
- Link fo v1: https://lore.kernel.org/all/20260521065731.6888-1-eduardo@eduardovasconcelos.com/

 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 3491e9f60194..b7c19805a216 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2129,7 +2129,7 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
  */
 static void cache_hold_inc(unsigned int *hold)
 {
-	if (*hold > MAX_HOLD_COUNT)
+	if (*hold < MAX_HOLD_COUNT)
 		(*hold)++;
 }
 
-- 
2.54.0

