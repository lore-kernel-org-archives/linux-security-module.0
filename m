Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C881A23BA
	for <linux-security-module@vger.kernel.org>; Sat, 24 May 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748109420; cv=none; b=dWpQ81z7wcmnf+fYdqj/66fMZlwgeJId2vtYwhDd+51Gplyescv+ubX+imDtezc9Jb7Fpno4Nlep10W/9rS684HQuEMW0al+7304VLg+SzSvhzw/rE1wFwgmwNO3TAhmUl2rPg8tgdr2yEqaUwuqAo7twjUzY1gDqp00Di2GAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748109420; c=relaxed/simple;
	bh=7qA66irb9R56OPSEBSralFj1x7bpLPxD8Uz2J5vAXWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1bCXzY2jFTAJWtxSNHTCyxonS7c4WYrgkmc5Tjtug/ubMhM295J3JiSYAjWs2AN7k0tMGpzdDvM8Z1wGza4bpY+VRRzaFWd8DSZ4TmDMYjl2Qdcr7KALIY8s+yaKSjEysBKLlEBmWKrMGyKwBfmDpN5td3H5XcwGf09pVpYI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ifGya8/k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LU/9LOuq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ifGya8/k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LU/9LOuq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4344D11400AE;
	Sat, 24 May 2025 13:56:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 24 May 2025 13:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1748109416; x=1748195816; bh=gL8yZn86DUv8mfS2PYccM
	PervMWamH4TCDleYx58x3w=; b=ifGya8/k5pDn8oeYq1VCqiUhlq0EUJxMDZzEu
	DpiKQtlDP26eLAf2dbTXTVExelnzioyvX5/6FyVMs6YZAEtVwTBGvTGr4P8wjF9W
	stBf93fkkbedzRnWaKDQKeGs7q0l3uFxAz/79DkxU3zYPJG+0mqJPH7eDmizPELm
	x44mS5j6sKUnp3jDapkIoZn8DUpUaupJEHHghDVkM2ovvdQkKxQcTgEuBvzbFhrE
	9gfaHz//AW3djlGu80UMGk6s2+QLUT7h7g+nktpcQuKmKY1oq1yaI3oRiBTDi2gv
	YXGwlQhPCUXWVVV9j50IFRcx9LnJP41Kdsjqhm4/EkgwywlNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748109416; x=1748195816; bh=gL8yZn86DUv8mfS2PYccMPervMWamH4TCDl
	eYx58x3w=; b=LU/9LOuqy9vAwiCMG6nAWM2ZBdc+cF7sV+SZiO3SOyIkDvldgDv
	/aRt0WcDeF1P631LqwQLM/dr+lfm7o4VkAV3WR5N9b1k/4KCOnMRopc91Lbak8tA
	Yny3GZl74XXlvPvBWGY59sd01RjQfzmTZ4Xu+gxLUTou9ex3gBQEfBsFIg6+cf8/
	9bNHDPhlK/cBX1rmG0cjBC+aMCcuIEUiGob3GewOcRIDT74+00NPUcGxrG80mXtG
	xQKFzcHToLob5G4nSgrGQKGKvzzFtwSfFVcplkxoxag8ZZ0WjgiTMKIc6ibuwu5i
	i+8pJAhpDknchQHSaOWUZYL5mGsFoc6yOOQ==
X-ME-Sender: <xms:ZwgyaJR5NDf0QaSLPFFRDyuQlpAJA_sBMauQjs-z0ZsYajgCi7J2cg>
    <xme:ZwgyaCzY-FrJdpolVZveKQOtW5oQJQVO_uMH9SHKFoIn3MJhXqkuhiY3LaNfLBnas
    lxjga0vo-obKhEDueA>
X-ME-Received: <xmr:ZwgyaO3qG7bD0d1ygQgK9rP28GIsoWHXIDnUPFkG4jtH29nl_S-vMQROtZs-5lutqRugquQZ0pDf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdefjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrg
    hofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepjeevtdekhfevteejkeelgeelieeh
    ueeuteelfeetvdeiffeivefgkeeiieffveegnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkoh
    gurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphht
    thhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrih
    hthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZwgyaBBhU_xSsKy220tm0x2Re8KzSlKLcUhTPJjebl5WOBO5oynFWw>
    <xmx:ZwgyaCh4uO9ZR69u_yATrq1YjD1wMgDVThzYe63Shwy5G8eEqiAl4w>
    <xmx:ZwgyaFq1RcMBlr5JsBbdOEsP7r6HO-p_u3qah9rHcXUnqeqTerd4BA>
    <xmx:ZwgyaNikMnMaJ0evgc76sp3l9TmgH7wC02SWWoyG-kIYmJ3bftpKOw>
    <xmx:aAgyaNBRH09uUGJ1c1YlYIaKAobtBJ1va8vwn_LV19m1H-s8kbL1mkE7>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 May 2025 13:56:54 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/3] selftests/landlock: UX improvements
Date: Sat, 24 May 2025 18:56:31 +0100
Message-ID: <cover.1748108582.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A while ago I tried running the landlock selftests and it took me a while
to get it completely working.  One of the main thing which confused me a
bit was the fact that I was missing the right permissions on the test
directory, and this matters even though I ran the test with root.

The other slightly annoying thing was that the mkdir would fail with
EEXIST if a previous run fails to setup.

This patch series tries to improve the experience should someone else runs
into the same issues.

Tingmao Wang (3):
  selftests/landlock: Clean up tmp directory even when mount fails
  selftests/landlock: Print a warning about directory permissions
  selftests/landlock: Clean up TMP_DIR and retry if dir already exists

 tools/testing/selftests/landlock/fs_test.c | 91 +++++++++++++++++++---
 1 file changed, 81 insertions(+), 10 deletions(-)


base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
--
2.49.0
