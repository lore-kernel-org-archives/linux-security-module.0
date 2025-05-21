Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B27266F00
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856091; cv=none; b=Hiuor5XlEY8oSjRoouMcmhqvYZE7W0+vOAj4/ehVasTgGdld9e7U/fv+5ucFCEDUkTZXjwtuAx5mdm/Ojx8270/KSC0cRFnz5d0fGiWY1WtS/KfRcrl6b/QA3nLHwxdROPtDACvq8JWJGMD992Jsg3LLd/h1gr8xeAknT/813/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856091; c=relaxed/simple;
	bh=+dOUnHgz5gsUMsTK9BYIBSmYBDyoAmtyZqC+FzSrSdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs1HIC1XyE96GyULRMrwPbQA5IT2xlkd3dOpXxY69xtEAUymP9mIslTQhj6ZfVI3CFfT07K1AuolF+cywcwCG3SPFNkEZCC4QTmoqwxun0agBDSuk/xQCou+ymFoNYk7Dcbcsmb8f7wNyKok237in64Nkj9LA6a1yyjGbqItkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=OdfAcIQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4Bl3Pl9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="OdfAcIQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4Bl3Pl9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D1FF1380434;
	Wed, 21 May 2025 15:34:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 15:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856089; x=
	1747942489; bh=t7BvLy36rqOQW4MskC/3iOEhqKHAzYloaRUH5yngGpU=; b=O
	dfAcIQpyYO4eGFnUWkrZ9ppYaIQrShNAKu9UBivjECOPJEvEZWxUCjElCIfeZ/Th
	9wSovuSk6+6qTUgP7Y0PiKJ+GmPNC9a5z/KX6NLdySz+84m8t8Mi+BawrClBu3wu
	t5MGbNZTBucBR0DskXys5E/WAxMyHLz6NFuiX/P4h4CpJK5/7RVwcbtT2y2BMk3J
	8OnqG6ndct9sctYfcxCsxADXwBCLQs9bAdE4ToyC60W9KABXIUt1HPbrxZuXCXB4
	cMmh0NV1MILeAFb+C6+7zgjWSwBM/btyGNgV/PRMsBhB/apispBab2iNkTpS/HYo
	9lUYRI9AKOFb5Za9xFmhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856089; x=1747942489; bh=t
	7BvLy36rqOQW4MskC/3iOEhqKHAzYloaRUH5yngGpU=; b=B4Bl3Pl9z6ja0FAfn
	wfj6lFz1CtOofYdYVqlZMaZPIgGsXQnTQvbZS4ziTln3i2W9coo8kGy34YM1EbSO
	NXSntjpTEQKgtIeVP0Y85C58Y9mbmVPaaUpvj3S2cdKYmQSe0mJPcI3ckujJVUZM
	3pRC8qHBgOhAmeAWD12+QBoJkd0vG64tsmJpaMvecEfurH24Pwf/kkc1QtDg1X2z
	DKLEmV4vbsbJ2QmIncIKOQ6VMajkDQBhanwzmzyqa+VP86kf2Ms9ldn0tIES5Zv4
	kxLvSGPm2/KB1C9FuIte6gtPxkwJdTFcP5O235kcD3SNeUgVlYGw3//aj8BVbrml
	fP8BQ==
X-ME-Sender: <xms:2SouaMRHDg-UxKM3w8VeDo7F7M46uGtU8_8vdT-HVVO2w9yyGO7Kqw>
    <xme:2SouaJzCNKbvzIrgw-oUXYjLVyXAQbnr2lKim9yoS4oRWOhjeHR9sA_Z9AHj2BH0j
    KaiqLaDNe5gzBMdSdQ>
X-ME-Received: <xmr:2SouaJ1cf9JLV055GQx1mVC1F2oB6oBFBq7iXeWihQX8HLegZPHoCuE78T0x5PXKChQ48uW67PeX3OGyYu7xoedQUTGMaqKIWWlfAzVwSrLHjwhovBNFhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmh
    grohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddv
    teefffegteetueegueeljeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurh
    hithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2SouaADpDtkVmvF1rofAh532t58mT_dDYLr_Ga6fponBdtZ7bfjHYw>
    <xmx:2SouaFj58tjpznt0LRWA5YiHERzI0dKVdWka2nZKscLBGrcMO8gzqA>
    <xmx:2SouaMrWf1nzF2woluGaDPwP39I25uIL0V0YG3qM9qfqj6vmkrmS8A>
    <xmx:2SouaIiBPZeP3Nr6DKwnofR9lKE5n_kuxUZRG27KfrxoF6TS50Om9w>
    <xmx:2SouaIAsDhX-RIFqSOPwjhxNN1kYeew5QYOn01NOSuFXYOdlSw213WsI>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:48 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 05/10] Add hlist_node member to struct landlock_rule
Date: Wed, 21 May 2025 20:32:01 +0100
Message-ID: <3a9336cad807610a8b85cb95363c3769c863c978.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare for the new domain. Since a rule can only be in either
a ruleset (rbtree based) or a landlock_domain (hashtable based), we can
make the node/hlist member of a union.  For now let create_rule initialize
is as before.

(Alternatively, if we use hashtable for both cases, then we save 8 bytes
per each rule, but then we will need some kind of resizable hashtable)

(Maybe we should use the relativistic hash tables after all?)

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/ruleset.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 215578ad82f7..07823771b402 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -87,10 +87,16 @@ struct landlock_id {
  * struct landlock_rule - Access rights tied to an object
  */
 struct landlock_rule {
-	/**
-	 * @node: Node in the ruleset's red-black tree.
-	 */
-	struct rb_node node;
+	union {
+		/**
+		 * @node: Node in the ruleset's red-black tree.
+		 */
+		struct rb_node node;
+		/**
+		 * @hlist: Node in the domain's hash table.
+		 */
+		struct hlist_node hlist;
+	};
 	/**
 	 * @key: A union to identify either a kernel object (e.g. an inode) or
 	 * a raw data value (e.g. a network socket port). This is used as a key
@@ -248,7 +254,13 @@ landlock_create_rule(const struct landlock_id id,
 			   GFP_KERNEL_ACCOUNT);
 	if (!new_rule)
 		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * We assume the rule will be in a rbtree for now - in the
+	 * landlock_domain case caller can init the hlist afterward
+	 */
 	RB_CLEAR_NODE(&new_rule->node);
+
 	if (is_object_pointer(id.type)) {
 		/* This should have been caught by insert_rule(). */
 		WARN_ON_ONCE(!id.key.object);
-- 
2.49.0

