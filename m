Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74B5B5AB
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885359; cv=none; b=bF0STnnrbp0/e7A9rkng4R1J8r2QWrdE0DqThSEevVb8+w45cHTzMI5AIyKFdZNajxYR434pqny9dwRXzqK2rlBPBLl+EGEQWmCH6H2E5IB6BmUPMgcL+4/sz8B023keMOEgI67wp3jky2qyucVmrmimc+jU7jf8jcFUD0D9Ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885359; c=relaxed/simple;
	bh=mODpKLbaKg6RZsXYo95hko1I65bPWGskKwr6zX+hfYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ8a081wIW+xFNLUtQmQWjoIYYukEATfFEDL3OwqOnIdO7IwdilmPYZykizXi0vsac6vQZcTqe+3w03kaUD1Ea9ilSyreuNdAG0h3PZtHchccbB1Uk4hwwpefwHNrYc8bgwiE8DGX/bZ62laTR+EDQWzQW5HxEkNN/CPJClTMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=UbS65yPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SifBGI4o; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="UbS65yPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SifBGI4o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C178114000B7;
	Sat, 27 Dec 2025 20:29:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 27 Dec 2025 20:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766885356; x=
	1766971756; bh=n/rvG/+FlRA1cvUhCX0DDLesrAwSfow1aqVNTGGEYro=; b=U
	bS65yPHkLgqp6NuutetvWINuzD9d/L2pHYQiR+duh1iN92u8lrFtpuC8+PUeWzm2
	7ICI/4TBC5JOMZl3RUEZne3zFSd5/ifqeSvO5Zp+3X9LP56dIrTbEesh9X0nSMiU
	d/s5E3/VPvDzDYb4eaIQEQ0x+Q/i4+Mvjh+PN3ETCOXj4yS8BwWZyrVBo73VuezX
	QkZ1CTtq9dTkPps+wHnafafyBlZvqtp/V34U1k3RVauRsVE9XhoO6NQ4iEO7bVzp
	6joxgASDqUS8NT5eiLuj2Y6xwqHgZuhxo4zwCMqjbILpcAu/6z4YX3xKTN5S07qo
	KvVoF+1CdLOVC/kaHGcRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766885356; x=1766971756; bh=n
	/rvG/+FlRA1cvUhCX0DDLesrAwSfow1aqVNTGGEYro=; b=SifBGI4oj3qhSd7CV
	3T3RzpIlz9Cf77oi9AGLGKlGdd7m3Cv58NmPXzTwEXEMIKzvIaYDcZgiA/7XMZjQ
	97RcqtlozzCsMglGZu0OEyDnLicXCeNs6w9tPCo5/rwok784nes/wN+rE0uU+6Nu
	Tm/w8R3CLHOPAJAwQMTvbxUrNWd3if/Bp2pADHd/nz7DSufVTZ/1GJxo7SfiW9Tc
	l1MMiu7u2l/imV3m09QsKI+wkByK4ma6AZQ7BvMOOIuUlOrYWK/rs7ir8b1SkKu2
	cPESaCWdYfQoQDhdWgTpTSlJyCzpjxy54IpEaQKDTtsW8guqthatWRQAqKRwYxLR
	SYggw==
X-ME-Sender: <xms:7IdQaYPtxwpggxQ0KBWJoFQD7hBreP0D6zGapj0H4xYOEjZtTtV4Qw>
    <xme:7IdQaV25dOAvTyWHPWzhWuGSx0uxbU5RivfLfYs3jd_qMPAw8b7tO7JjMJ0bPMsAB
    JxITbCHfojPmJIuIhtgIFSfD5H-y9tGiHuDEksHRLBT6wmqKkVeyACA>
X-ME-Received: <xmr:7IdQaXkNC5tp5HWOLfgV5MNaXHe2RfuJciMViX3lYviGHhaQEQyZaj-JR4olRikPPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7IdQacWc_NBYYdH65eiUuRSxAuEtWhQld3Itdh0ix3D26Q6qJNbEDw>
    <xmx:7IdQadt6GYEaGITel9dzops6_2-BxFc3cs_DV4HNKiNY-XWRp-tumg>
    <xmx:7IdQafZqGgxyOwB-HG5bjZsBSsiCwsvfK-Te3DcbbDU6pE04ndwaMg>
    <xmx:7IdQacXWWShmljJIFogZ7FVkogm95PANHSQkeCHcl0_tQIDBsxwtNw>
    <xmx:7IdQaexBxHi8MpRup644NLsZNRR7RrsjDkF_mTN1oTCsCLEYmhiVaBgt>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:29:15 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH 2/5] selftests/landlock: Fix missing semicolon
Date: Sun, 28 Dec 2025 01:27:32 +0000
Message-ID: <d9e968e4cd4ecc9bf487593d7b7220bffbb3b5f5.1766885035.git.m@maowtm.org>
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

Add missing semicolon after EXPECT_EQ(0, close(stream_server_child)) in
the scoped_vs_unscoped test.  I suspect currently it's just not executing
the close statement after the line, but this causes no observable
difference.

Fixes: fefcf0f7cf47 ("selftests/landlock: Test abstract UNIX socket scoping")
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 2cdf1ba07016..72f97648d4a7 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -543,7 +543,7 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
-		EXPECT_EQ(0, close(stream_server_child))
+		EXPECT_EQ(0, close(stream_server_child));
 		EXPECT_EQ(0, close(dgram_server_child));
 		return;
 	}
-- 
2.52.0

