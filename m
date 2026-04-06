Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4C3314B7
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490818; cv=none; b=knKfLLFWK9titmsZ+wZnrxWNI0Oxd7ijyZBjzUhk+GFZxlmYvOxAkSk/4vua4k/pjtVfQKhqY/dsZ/fmAnkY65Od9OYmI15SRTmNzqK3Ig+EARuINP4I1qSziYIkIGlSI9ifeTH0xnrvE1QtbJj7sI4CkiwgNFsblNH3rBK0aTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490818; c=relaxed/simple;
	bh=zty3dy9NaVBgeIsSvBA3ckHr84wBlQgBubETRTI2uq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+O6Ii2qPGKh0SY3Y6Avf0lB4+ASv1CPSaryp7hwOaItBfPB3niGbJZnTY3Y8433ie3f0svBTKBZGT1bNBPhuLiJBoWYbAPulCWwg7uVtVdjbnPX09CqSUcKRSyPCHyS1M3Qgoeb1bLKlUwykPAp+c3w7DXn46MPrhHW2FY9LC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=H+vtGbXt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+GuxubV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="H+vtGbXt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+GuxubV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D1ED7A01FA;
	Mon,  6 Apr 2026 11:53:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Apr 2026 11:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775490816; x=
	1775577216; bh=jSn/kKXctAoXuabOOZUOyAj6HUrP3j0JScgpuEArdOY=; b=H
	+vtGbXtNmNEHxAywZStFlXnB8oom1DIdEgXmz2BVZDgbNRr7vmFoZngUn6KZnZ9J
	w6yWi/ZYVf2amES2IqtQNPIx2+kM+JNMwZu89wTcY8wyBQ4YtoM5TMkh2odnoGC5
	G/kv6zJb8kFYzMnrGrOdekRX/YFMjCxa5uuf01Xe3aBLpHPwMLS8ZN2AWj+lM9u0
	wefeRYq45KjwW2DJuXbdxVGviLv/vB5YSJBQpAs/T/DcVB7QIPyWFZLTQX9O6ZAG
	LQuyHvB8c1OrWlFtr5mGl31aYJKTS9ObUOhGsTo9q2uwtci29XqJyzWPyHEaUJO7
	BJGaPegH8myj/lwQuSi6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775490816; x=1775577216; bh=j
	Sn/kKXctAoXuabOOZUOyAj6HUrP3j0JScgpuEArdOY=; b=K+GuxubVA3+YAOlBM
	Zrodfh80m5KHthUBpAVu98ZY3bs4BpEqgxBVIpvzf20P+7QH1zpr2eg8JkBv12Yh
	WeC2aUcIe5+MBzZq/SbcG8DFQv32esSlI20fblT0WcDybQ/02nf41oxqW66Dmx7S
	teMGaGEE9AH1jLkShl2SKYVxOt1AHHhwOiMdFpFYq05O7KBoLSDKSnNjcKBeiw3B
	2SU+fWhBJ92rDf4bSPdiAya1ztnf5yClfwHFfS+AJcaPf7xqVSflpGAk/Nf24G55
	r38dYIO6E4YT5i1ybmIsB9gS/U69eGYjoLzLipgZS0A8O0X518Lu5LpxJfZHfYXr
	lk42Q==
X-ME-Sender: <xms:ANfTaea8IbzzMRmamBpot6kPTN0fl96CMz9Gu2aaneN2FrUEpeEIxg>
    <xme:ANfTaToW6gDCfnPbIN6UKWVKnNpLlHIiPLoWKW3IlOLHGUPmH5dAGjV3r8pPYeZ2U
    CWYxk1UlQemZMaATg8oqQLm45XLe_u2pmdTHeHZclmyGCpx2ShMCp4>
X-ME-Received: <xmr:ANfTabNuX2hmVLRf2cIFDM-wNCVgu9IHoyh5uwJIr0Tkf5xV-z8NFfsoLF8eMNDUNnS7q7oAhYV88rQhttBk4tN0n-qQ61EE1_kg0c_n47yFVhuxhwEfQbFtXYTe5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ANfTaWpiygMlRAaCLTr6BbOaDR2qDXNRSgZmxsVkZp1UjMc_6tZPcg>
    <xmx:ANfTaYf3A1_OVHupINkYUnTlrOvqTpfU3CDcOr7N5crBHv9fmldnbg>
    <xmx:ANfTaUQO1ZmMlJUxpPGFct1HesE7VYn9cYSTrO4GT-uNk_YFVD2JnA>
    <xmx:ANfTaZaGEn1KdlRutfxBV-SLHCTNXS2uzxQfAXc7EEk1T_VLkTDv_A>
    <xmx:ANfTaRUFwGztA8G6x9bFPeZcm1JHixz76jorobjyt0qk_vSq4ZlMiRv7>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:35 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 5/9] selftests/landlock: Replace hard-coded 16 with a constant
Date: Mon,  6 Apr 2026 16:52:18 +0100
Message-ID: <59231d0c6c96c9647547a04f7159198b8c302f64.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will reuse this number.  Make it a shared constant to
future-proof changes.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- New patch

 tools/testing/selftests/landlock/audit_test.c | 2 +-
 tools/testing/selftests/landlock/common.h     | 2 ++
 tools/testing/selftests/landlock/fs_test.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index da0bfd06391e..36b0e750e889 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -76,7 +76,7 @@ TEST_F(audit, layers)
 		.scoped = LANDLOCK_SCOPE_SIGNAL,
 	};
 	int status, ruleset_fd, i;
-	__u64(*domain_stack)[16];
+	__u64(*domain_stack)[LANDLOCK_MAX_NUM_LAYERS];
 	__u64 prev_dom = 3;
 	pid_t child;
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 90551650299c..7206d5105d66 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -25,6 +25,8 @@
 /* TEST_F_FORK() should not be used for new tests. */
 #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
 
+#define LANDLOCK_MAX_NUM_LAYERS 16
+
 static const char bin_sandbox_and_launch[] = "./sandbox-and-launch";
 static const char bin_wait_pipe[] = "./wait-pipe";
 static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cdb47fc1fc0a..10d9355ade5f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1441,7 +1441,7 @@ TEST_F_FORK(layout0, max_layers)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
 		enforce_ruleset(_metadata, ruleset_fd);
 
 	for (i = 0; i < 2; i++) {
-- 
2.53.0
