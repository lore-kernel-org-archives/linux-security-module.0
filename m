Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DEB63B9
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885340; cv=none; b=XnDJV2N5EDgIkjqksuqhI/gn+IZPRScQUwbTwjj5WLY93Ki+LZyc9wD5tX8YcuyDlBQeNPm30qouAcmD5OSUyPZ/aitlwsyLc+DhTynh7G/zolsutVKecfYBZ8V3i6QKYO/ZSIl4+aMsxB8z1B79Qr9JDS81tOXEIeWV02B5POo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885340; c=relaxed/simple;
	bh=R1DNFw/ysHbb1iKYcfDvSnvl8HjKja1Cn9i2PYoyHv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4MlElJp+d+hczCarbvXeKWk89Xy9hm0ZDuuZchHjRbgIJpw8n4bIGbFHHmMLlpzxRrrCFGPkcLUOIi92YAEWfO/uX2iJpB2wUABFt/roiO21AmMA5eZhKYxlqQOQbSLwdqUjL1eyG57Z/u38vNa3Q/S5ShWOWqLRAeb2WCnd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ImugncJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gdj/CUWP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ImugncJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gdj/CUWP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FC66EC010D;
	Sat, 27 Dec 2025 20:28:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 27 Dec 2025 20:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1766885337; x=1766971737; bh=6t8CC99BSvPG29Om6KqGu
	gx5aRJj6jW6BYYpAgrxHVA=; b=ImugncJxnoPpRAj+EkC4JaA6wHUq2mkck+cEo
	ZAiQlTVMj9W6AJBjEwKTyZ6NhNXf0qrLcjpdvpB1omqS3C6+ysK+aLmVt5fkQt9O
	P24TQ4z1KAspsqhvSvL+UmAifX6E85d4ci/4U/2MLkDlLpfD/c/IuCq8TzMUfSZZ
	QOspZGtAVgFHTE2kRLYPYFqsPXjbcHIDUe37CRdnbAOsCUm021xkhre6Z1cc/psz
	RI/Bf3ghkv87MUqCuIqexAwTLKl2K0mrHT8k9fQ7ReCJgq/llNsfM+rNZ9jiFKjP
	dNpuCydds7Xy8LTsXo9jpQ8TmAx6keE/0EJtWEwPhhfAt6uuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766885337; x=1766971737; bh=6t8CC99BSvPG29Om6KqGugx5aRJj6jW6BYY
	pAgrxHVA=; b=Gdj/CUWPAfhfPMvAwRkfgGqU9doqJ+jFkvNFbj1mS6G8j/KD4w+
	PYazhFUEt5GkO7RVAztdd5uvPLFj2VmWp3BF/yU+BCCecylpTWew+LmqMDLkHRMy
	iE89SoZfbGxfBevEPeq2F0tCiXIDnDbEkzYGA/ZIxjuZEUHBNSJbQ88YB43rN6t7
	m5wLeu6neujP3D9qq39hz5oaJNGQH/NPfXPhbF5TjR9ko29hksl0RrpetCQTw6CU
	slI8oITA4dQOWlAgeS1M89OxIMCRFI/tzjm2EK4qHmF5uNdi6wt3jWmRv5hSnbzi
	rsDojt50MhoL0yNWeVp8AVL56e6J7RfNjTQ==
X-ME-Sender: <xms:2YdQaYZDyLiNsH69tNvrN0Uwll_XXwgfzHBf5f1s7Gvjg-1SnTCEfg>
    <xme:2YdQaabkpXBhOU6ZozwDTfgUH5zS78JaTWhULZGjjzn2nRo0mRMRQiFrvok6Jc_CK
    t8LkydI0TptdAnKFzr9zgGZPIliww0wmgnG-qgfmqQeXqiIKJ-libo>
X-ME-Received: <xmr:2YdQaX-MAS0nfkike8bD2V_QkxGM5lGYZBvSd9O0o9H7z_sjIkc094IWq8sTgsL7HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucgh
    rghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepjeevtdekhf
    evteejkeelgeelieehueeuteelfeetvdeiffeivefgkeeiieffveegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorh
    hgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehm
    ihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2YdQaRj6Fg5A7U-NU8JFyqkyVkf95sh0oA-sGW_DbtbMM-Sx82fmrg>
    <xmx:2YdQafdB269uEo1PmmNx2p0yP2zn6OQtpPsyX-7Fj9jBGluhlb6gUg>
    <xmx:2YdQaQpO6S0s4Yn0JzmuV5ls1TKsJ8lAWJI-iiM5jgK1ilxKSETO1Q>
    <xmx:2YdQacBJlk2qav78LE-fY_mu6-AZe9GA2eBm7Ei2Inya_V7knivLhw>
    <xmx:2YdQaR6S2k2SrmZgvieVzbLSh0ANi3aPv_4FP7_yRQ99h0e6gzEOw8nN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:28:56 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/5] Landlock: Test, comment and doc improvements
Date: Sun, 28 Dec 2025 01:27:30 +0000
Message-ID: <cover.1766885035.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains various unrelated improvements I stashed while
working on pathname Unix socket scopes (I will send the series for that
tomorrow).  Only test/comment/doc changes.

I was planning to include this in the upcoming Unix socket scope series
but I thought maybe it would be better to send them separately, as they
would be unrelated to the main topic of that series.

Tingmao Wang (5):
  selftests/landlock: Fix typo in fs_test
  selftests/landlock: Fix missing semicolon
  Documentation/landlock: Fix missing case for ABI 6 in downgrade
    example
  selftests/landlock: Use scoped_base_variants.h for ptrace_test
  landlock: Improve the comment for domain_is_scoped

 Documentation/userspace-api/landlock.rst      |   6 +
 security/landlock/task.c                      |   9 +-
 tools/testing/selftests/landlock/fs_test.c    |   4 +-
 .../testing/selftests/landlock/ptrace_test.c  | 154 +-----------------
 .../landlock/scoped_abstract_unix_test.c      |   2 +-
 .../selftests/landlock/scoped_base_variants.h |   9 +-
 6 files changed, 26 insertions(+), 158 deletions(-)


base-commit: 161db1810f3625e97ab414908dbcf4b2ab73c309
-- 
2.52.0

