Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4631C5F1B
	for <linux-security-module@vger.kernel.org>; Sun,  5 Oct 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686998; cv=none; b=QyO+kU3WAXajnDmQgLUyn9OsnCx86RnYaPI6qr3t1hBMKMzrt+mrlu1ym90DjP6vg2dTb7hEpAOy6wH8eS2J+5FA2n06mVQsXtDpOOCPb4DNxhOcrvNuVZwgnLfhNbaqujuY93V/WjmGhhciApyNqxLmocAYhV4hVVy3Aco2qUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686998; c=relaxed/simple;
	bh=1BWE+NC6glYiVbOMc7o6CB6XNR/bnf6iKo+Efzaba3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXQhT55DLjM97T6+lXugKmZVli7689+hBT7WLD6Z2jfLBqDl5W5c4U0wY2+7KWdb2XhUEL4HHfXGIQRB4TlXxgTqHMGCcXNYFaJjq2qZtLKWSm91STx/jWSAsxfyCQd0UVgybtB7vyjKMDE8DA+wH+xETTk1ltlW0JPcuRDemJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=X5+dh7n/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NeFRKgM3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="X5+dh7n/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NeFRKgM3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 30AE11D0001B;
	Sun,  5 Oct 2025 13:56:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 05 Oct 2025 13:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1759686996; x=
	1759773396; bh=ECN3MAbaj8okC0Aelw1+jJyeSTB+cXrf2HSeANR54yQ=; b=X
	5+dh7n/hntvlddpGprJq6t52Tf+qZvva40fMVxfQeIX3DVeJ+6mR9IiCBi0YC82x
	qopJxPvVF598QK+cVALBpxDEIePqfkxIdt/zLwGuIRIubocRj7jO91X2cfi0/3bF
	S4ZdAm4jDuBKjhr9LPQyrvc+7VKxQTZfRNAh9UqEEAmTOeejJvY/Uy85mDzr9mP8
	ZXWmaVimdfNt7Q9TsoxhEqs188JRmTZCAgqzrUGMbjutrR+xLIXx8XFQLo3GjncP
	1cCwO1UzOTWD4MrAKt6GE7HHkTAdccWKfSI6Y6dOaKBh8j9aRc8GSyrKHs15DGA+
	wmoQ1LT0nN55O3ZxCSo+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759686996; x=1759773396; bh=E
	CN3MAbaj8okC0Aelw1+jJyeSTB+cXrf2HSeANR54yQ=; b=NeFRKgM3bZ/B7Pxbm
	S0c8nWAdNOykXDLJgSvnsZmh6flQqSblGeMTbc/8ncSkCSaAdoBhU8K+EpbP45R/
	F5aIGY1hSqeJ60f1264wfA1+7rc+IaE90GO1WFbOxBq9HxGewTQG1DRY8Fup8J6Z
	UNRDWb32AtaN/ml+PF2lnByjkYbpKZRLHZpwbYwf5uYs2dXZWX+RI9Sq6BoHXdCt
	mb4TfVtz3KkgU3RDUgX1P7ZQZ4lYCuyxwXCX/+WHjkDhUEm9nrAYQQN1wGuz2qS9
	RZBAQi7qsqPa89XjTwbOcaAhzpYMt6Z+7NOLLnlcKbW7MZNbs8gjJ/NqDrXiaWKz
	mL+EA==
X-ME-Sender: <xms:U7HiaGPyma21tlRdVP0Ka1-fN_NvXKcBMVVAtEA00aR_ao7HV85LWQ>
    <xme:U7HiaL0MwqKX3GLLVQae0aN8gnbjxEpbQ7fx1UHYCJEejx7x8TGCsQqehbO9YAzZc
    6sovgLOazNdwdRmNBEpGc4rPSkeUIb6CpuKs0JGqxz0MDB72YdbIA>
X-ME-Received: <xmr:U7HiaFnNX-uO2cZyndv3kBwOwckHMP62QtKx_ngnRoeJvodBS6_OHybgSaPvPk87rjZUVnp2jaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U7HiaCWP9UtPefW90efG9PYgHTFrwIrT5Ybs8X_SoxIdcD6kjLMMxQ>
    <xmx:U7HiaLvtWjdTRsiVL99Vg8d-mYjT79FXwDFXIEd0IjnFtfZUezPP2g>
    <xmx:U7HiaFaUrZl_-aI-VtEX-BPnfD7KQCtW2QUu9zbfbbeuJEny2dShmA>
    <xmx:U7HiaKW0rgub47_gUOOk0qaefJ3sbkbtY7iWM1-Jq3ma7W2FUkcyPg>
    <xmx:VLHiaEeTW4zyqbXGnG6iApk-HdM4vBcGYHaCbCjwwWAgNtPlnJ5K3OmH>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 13:56:35 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 4/6] landlock/audit: Fix wrong type usage
Date: Sun,  5 Oct 2025 18:55:27 +0100
Message-ID: <dcaeee389e0c28ead1026367c9bf328174c7a48e.1759686613.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759686613.git.m@maowtm.org>
References: <cover.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think, based on my best understanding, that this type is likely a typo
(even though in the end both are u16)

Signed-off-by: Tingmao Wang <m@maowtm.org>
Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
---

Changes since v1:
- Added Fixes tag

 security/landlock/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index ec00b7dd00c5..4ba44fb1dccb 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -191,7 +191,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 	long youngest_layer = -1;
 
 	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
-		const access_mask_t mask = (*layer_masks)[access_bit];
+		const layer_mask_t mask = (*layer_masks)[access_bit];
 		long layer;
 
 		if (!mask)
-- 
2.51.0
