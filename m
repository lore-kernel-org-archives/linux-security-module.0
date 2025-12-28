Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B463B9
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885351; cv=none; b=o/slF0UbpzqfTNajBaoB6jTRYVs2Rpog03vkq+2hi7eIvxtgX0XDl717i7hf/Pu2SFomMqe/BtOUTE0ukWJIiNVJdnkSNO9BjABcN7C46zcKOnpqLMMqS3SMeVi2F4i62ORMbQZDMUQcwVnL7NhPR0q7TYw2ifFqyGK+hpDFRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885351; c=relaxed/simple;
	bh=vNBJNSYDDXx5QdX0Cjw90ADfO/CuQvMEAXhbcXe16oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiIXMNoFs0ai0DM73JjAXZ8Y6bV5cQJTuGT38iLajUvDWdbhqRUmgNtJQD9h05gT6CrPA1FmWbQRmg1+s1w8/Wufv/indgPisG4EtpDZNoMDPf2JkEOWedSjUL6/AolcPPgzinCuuqNSUjVx5pupBNAfSw6L1niRdLVGXLPWevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=VoXrybzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaAJADF5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="VoXrybzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaAJADF5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA58114000B7;
	Sat, 27 Dec 2025 20:29:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 27 Dec 2025 20:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766885348; x=
	1766971748; bh=of4vmiw8DlNWzFvFP/7d1bcxSqCKCofdhlqYQC8UdyQ=; b=V
	oXrybzwrkLegU8q2dG8oFFjzYJtJ5VUd2eBWFHdd7f6g4AU19FWOMNLmxFTOOrvQ
	hmZJsPR/Mhv24dOBwuAf/Jtd6vPL+PNSdJs29tV8AD4wWHnnKrTHBhP6J4Lg+jeQ
	TbW6zTxlx0bnCTCijcIfbdLwTAvTwOyiHAAgwQ46IJeg4CA8wN82Cyq9vDuJsJbD
	PabwC90nJ+JnWl1LuusRJnhuaBG6a2v43lmjNIjPz1ibM+JceFb+iW0QrHHg1166
	pb2cMCyXGIErMc06w6CepBlHGrUWbCpwV1QXtA2QgeRF6+mKc4euUZ1t4p33JRRE
	S+jg2aT+hTFC91z8nXZRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766885348; x=1766971748; bh=o
	f4vmiw8DlNWzFvFP/7d1bcxSqCKCofdhlqYQC8UdyQ=; b=JaAJADF5qLv/or9zm
	juRlhBmiA3VgoULxiRSSke0DBRZBTpnzPzZkQ+uzOtNff0Ax5lWHy4OsftJWYjIx
	wGqljnBD2Mj4cK+gGU9bImRedZgbUVQq/76JZspjkE3d2pO5PtEo4UDgGuDHR787
	1GkYv1Ag1d+BYlQaZTwKe4evpZ0jwUNiSObj8Rl5RHly6uuQshRDXEkNpwG1k/mU
	b9zh959kHgd/otqzqA7/GqPIgm57+MGXnsGMPktgtMV+Hw3FTnUGEjU1/6FGpsb8
	UaPAiTa3R7Pc1JeJyiZkkdM1ua9lHj4ePanMK5fNDH3pgcQRiHMYqogvZm7Iy1SW
	8chyQ==
X-ME-Sender: <xms:5IdQaUHo1S2K0wH70WVNMgN3MHZnId4wL1f_VSZ0uubHh5IhddRbUA>
    <xme:5IdQaUUK2Y9TxtM0WBJduifBnMLx99mZR3SIdz8ZB9PYa5SFft6WQFy38DCotThmn
    fAu8CYbIBTaveWwvWy0STsnuYC7Ctl_yQI-RRyXhrsW3wHzjSyUbPk>
X-ME-Received: <xmr:5IdQaTJrKfoDDWlgg4_PWajHeNwPmBTY6KkiOJ9oFqpbZv0RLvr63XHkCUPKDiGAqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:5IdQaU-eKcEPWc9BUqD3qyE6I2gEMxukZTVBq0NBU4Mhnms9Dz7Cww>
    <xmx:5IdQaWKXCMO2Lm_mzhAc5JvjS7-PX_TIWPBuEhWVJS_y-2w7HfIdqw>
    <xmx:5IdQaZnOmJsT7KOk_Q43olYaMUPiGbCA57wz4EABeCnBsxmXP7QpyA>
    <xmx:5IdQaaOApDQSoNzEIP1Dm5ly9IG2es82r4GA5mK7JTFwm9f8cgwg0Q>
    <xmx:5IdQaeH_ab3BMvp1cpFOCP4PK2H29ytJP7fOPN2qWSl2KDttxsIlpB7T>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:29:07 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/5] selftests/landlock: Fix typo in fs_test
Date: Sun, 28 Dec 2025 01:27:31 +0000
Message-ID: <62d18e06eeb26f62bc49d24c4467b3793c5ba32b.1766885035.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766885035.git.m@maowtm.org>
References: <cover.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 76491ba54dce..37a5a3df712e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7069,8 +7069,8 @@ static int matches_log_fs_extra(struct __test_metadata *const _metadata,
 		return -E2BIG;
 
 	/*
-	 * It is assume that absolute_path does not contain control characters nor
-	 * spaces, see audit_string_contains_control().
+	 * It is assumed that absolute_path does not contain control
+	 * characters nor spaces, see audit_string_contains_control().
 	 */
 	absolute_path = realpath(path, NULL);
 	if (!absolute_path)
-- 
2.52.0

