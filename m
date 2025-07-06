Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12629279DAD
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815133; cv=none; b=FBxV0Jt+08EhYQ2Tg3jwbWA9QIHCyV4XOqgHTdZVhif5iObZDlZDtuxkWeJcbbUfG/8Qjl1T8DsjQRRBN8og3LK1xEFj+zQZgMWIPYIWPbnLs/Mtuw304w9A6fRf+vt8IjovTkg6TGv1I7bdkp6NqOeoygmOFYWI6hI8fc5+hJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815133; c=relaxed/simple;
	bh=XcVbXNfRYO5bBnCP+PlSjnZMV4j+wpYW943yjNNtsQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bq4rLI+hJVwnA7FBFlLXRvqGJ9wTcNrcYGKP5C/ni0GTvDNYSeeGOs7b/Ibj6JLOSkvfZgEifSjke2jlB7F3WaK7zKAcVm2wovIjG+QXKKu+/sGVnHPMWPE2y5UWlW66lX0156LLYXscIAtxBNIFzjduLWJGSaann7f86xyTMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RIvT7F7E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVFF048h; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RIvT7F7E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVFF048h"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24F837A0156;
	Sun,  6 Jul 2025 11:18:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 06 Jul 2025 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751815131;
	 x=1751901531; bh=BqnzHtyI+BRWSdj3oZMPYRozS925W53joHYpHgKgd2w=; b=
	RIvT7F7E8C2PMK6zhXKZ/xfvZG0d3nG/deiq1RHs86/efTMFHEaeQOnF/lN/ZHz1
	coelRvic2xfFN0MFHcvqM0c/m8excG0cHBNGcw+auylN2hsWXCsjgtjwyDoL9/uf
	pkHZVKcsnJDztV5jLWjr7+n4QhjbNT3x8tbhQ8Qnyv5ZW3nLFW8ZPKCdoRfBpcE+
	mEOD/VGhBz2KCsIAf0i8dgnF0FU0Z+jvJD4yAFvmDbOuPcUYfh0jeqXEhCOGSaUK
	dWFhRHO43NHk/Oqr/mHS6NNctPMnJHJSIMYg5EFW32R/XkUq0y9vcQg3XjZGNMJW
	D1qRrlvDqrI4HMix9V2LUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751815131; x=
	1751901531; bh=BqnzHtyI+BRWSdj3oZMPYRozS925W53joHYpHgKgd2w=; b=Z
	VFF048hGp0kGAF+Kh/Wl6ECezP3HwLujX6S3yM0dN8TdCnnH2FWlzciOt+J5TgmX
	N00LHZk6WbyO6AGlQ62QMN/LUNlDwwxwCWfiKvyer4oFtsgyHoCA03dWBkLH+mUt
	e34ixDjM8O1GkSplKj0jCKmxz60ZpG6RfEBPfZeCEQMYn+fqv4O0G4QgCcuzrd6Z
	jkp533c1kmDcCSCUjzFm3aArUvWrKmRnASRTLQ510lQK3e0b7iwITffkR0VvWId8
	WI9cn9I/1bnhFxEQ2imrDX+J6QRYMik1KQXZYVqPzrNVXfOAv9+CMt1A5kTeA7YT
	wZSB58LzLzo3fE2e0FHMA==
X-ME-Sender: <xms:2pNqaLDGYrFENgIQJFOjMD8lgs8IetWvfXiNnKoR4wLG_7KnuRVScg>
    <xme:2pNqaBjVxlfCYUWwia5aI0YvJ1X6MudTzK_L19CwFQhAXyikYiOwMsdM1htOYGQNh
    ODurnGBo66N-cML_WI>
X-ME-Received: <xmr:2pNqaGmjnDz8Xc5LmRaB-5sc_m0NrDFNf5IuYoOy9v4p_sBa7VFW-_8ddGgkVX5R795eocI9Xu3MHufYuNDDfyC_aIwBMMyu-yEHDl0SWIgcQWcsBM6N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejff
    ekjedugfetffeuiefhvedtvdefheeghefffffhkeevjefgkeeifffhheffudenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvg
    htpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehm
    sehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghnohhv
    rdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtth
    hopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehfrghhihhmihhtrghh
    vghrrgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2pNqaNxVMYEQUrg7_QmVl25ExFBhacpUvYQGShC744pkrl4dwFDm2w>
    <xmx:2pNqaAT7OIAZJt93AXxoMzO8jUBSJcT3_Y_tClxWiErewQcJHzgjRQ>
    <xmx:2pNqaAYVXyqj6lOTlRqofeOkMGomCAhKDc9Y6j_uIr88QeGR8Dw_7g>
    <xmx:2pNqaBTphH80YcjKLr-jC0-ztU1RBK_EjI1iuKDPmzxvChtU7OqB3A>
    <xmx:2pNqaOU1RQP8n6Wv2f-hvkBI1iW6FGbyGTYM7Q69Qy86Uj2jiNx7Sjys>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:49 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [RFC PATCH v2 11/12] landlock/task: Fix incorrect BUILD_BUG_ON() in domain_is_scoped
Date: Sun,  6 Jul 2025 16:16:52 +0100
Message-ID: <0b4ec4e65454af03666b8a9b398777816c93be88.1751814659.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751814658.git.m@maowtm.org>
References: <cover.1751814658.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[1] introduces a check which doesn't seem fully correct / necessary, and
breaks the build for a further commit in this series.  This patch replaces
it with just a signedness check.

Cc: Tahera Fahimi <fahimitahera@gmail.com>
Link: https://lore.kernel.org/all/5f7ad85243b78427242275b93481cfc7c127764b.1725494372.git.fahimitahera@gmail.com/ [1]
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Mickaël, if this looks good can we merge this separately?

 security/landlock/task.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index d79919c1fec3..46e9bcc3beea 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -190,10 +190,11 @@ static bool domain_is_scoped(const struct landlock_domain *const client,
 	client_layer = client->num_layers - 1;
 	client_walker = client->hierarchy;
 	/*
-	 * client_layer must be a signed integer with greater capacity
-	 * than client->num_layers to ensure the following loop stops.
+	 * The following 2 loops involving client_layer and server_layer is
+	 * only safe if those integers are signed.
 	 */
-	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+	BUILD_BUG_ON((typeof(client_layer))(-1) >= 0);
+	BUILD_BUG_ON((typeof(server_layer))(-1) >= 0);
 
 	server_layer = server ? (server->num_layers - 1) : -1;
 	server_walker = server ? server->hierarchy : NULL;
-- 
2.49.0
