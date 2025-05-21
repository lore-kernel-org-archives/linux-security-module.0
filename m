Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1828F942
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856093; cv=none; b=N+WvdCTtklZe9V1wGW7/iaCR11WMD1of99THLHxI6PzqsFa0WsHSb9NCSG2m+SXgTGUGvbfTotyv1to3lpwO6Jnxay0RpbeyS0M49rAbX5pMcou6dEzkKT9w05zNCs/fRDp4mClhrDscX4DJCOWhVfhXj1CJkkw1rnV9wmiwrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856093; c=relaxed/simple;
	bh=mNH8DEXWvMAf0hHTKBZiM9wuY2gFjAtwpn+FohyruD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YutqGOVpBYLV7DZMQ0+OT/j6Nz4Yqp0fY+EGcrvwlL3JNo0d69kjHtF7lZhF/bWdH5laJL8+tyLSL8EUP88HXTQBztp/WQ+Vv61/A7CSD8mkryDvikq15R/soyhlJBlPVs66gavCrGYb2c+kpULKHsUUnBXQ5PVB0BY1JFcExD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=WC2tER4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjaQmyNH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="WC2tER4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjaQmyNH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A8E091380078;
	Wed, 21 May 2025 15:34:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 15:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747856090;
	 x=1747942490; bh=YLzHNg+N48ctvppl/v0HP776x+da3ecEYcFJtfgowrk=; b=
	WC2tER4kArmWV7fR0/8gc+vc8dF44y+4GAkKV667UD6UihAgLuOM3vd9yqP4FrIw
	KWM+GYiSecFmWk7hQVkNK90UbkAiledXDLWzVncSpTb1hDF7/RXy5Ct0gJeULHxm
	wT/9jXmB+OYqOA9YZ+TSyx5NTgtU4rGUF8ZhzagCqfehc2jD+bIfbKiue7HmoQTH
	GwnBpuuGEA2fCcyqJCzsvwgDRYlk9Z7S4kKDSIRlBkHjRRWvKFVF+1H4VrHfclL6
	vOxLW1GVXWQQBUodsAVD6nEzt0uvYiF17v8QZFbk93qzN8L44MDE6rGN7y01cq91
	n6hh8rWianR5g+eICc6L6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747856090; x=
	1747942490; bh=YLzHNg+N48ctvppl/v0HP776x+da3ecEYcFJtfgowrk=; b=F
	jaQmyNHiQlXEamWFk1He7Y1j53WA/5+Dq4cF/Fg9+9poRKui7Km28Npj72Fg5CRx
	YOTrbopI62fSWLXDmeryHDAYFAZB6NVETrnDy69qDn0woCm4ct0SUDNFu1YKtafv
	5nPs+qicMOY678qlzUl08Uveg+oiJqTaet8NyP38Z6ycvrqFfPePTjko0ZDBZMFm
	IP1hteVA/liENtvCkUlbCxwdLoriIieelmGY3we08aNAkncP/5NDj9ZDyEupZsrj
	MZURcAzsWAoCmKra5xQXmnqZFAEXjD5HiVdW4ahwbmp6irBOBxT2Aj63Q9aC5GqP
	6UhpSW+o4o05jpLJwrihw==
X-ME-Sender: <xms:2iouaM7UINvhP0V9y6geHzpSXVMmLcjJgCMbBwTm7Gz22pfB48Yscg>
    <xme:2iouaN7LCebiBl_jjmky5kmUIK_k-8r0D9EW2i3nJT7ra7deR1XJp1Tg8hhGiOxGM
    SpYzTCLHzTSZZfwI94>
X-ME-Received: <xmr:2iouaLeZXSvT5NnV4pHnfd_Hpxe-aoIKYBD89GsssvmNZK6gn3KZPgtPOC1HFnc-rs2ANnYa5h-ptRHQT5w5WQ0rhWDBMWu0kS327M4pyNs6YzV0P7dPRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmse
    hmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepieeigeeghedtffeifffhkeeu
    ffehhfevuefgvdekjeekhedvtedtgfdvgefhudejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgih
    hkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohep
    ghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2iouaBJJjDrBkWC9_kK4gCrsA-gThrVYuFLlgFfP3Hh6G3UIWuDi0Q>
    <xmx:2iouaAINPSzAZeC5WVQi8xvDPLMXyJyz_ijnQCKnlIXJGh2Dzp5VPw>
    <xmx:2iouaCzybOqu2Aq9VaW7p67ENzluAUMUiV0LK6ugvfqKrPqi55hH-w>
    <xmx:2iouaEI2JI0PqM4tmU3H-YjwT-46RRRjL_VK87DlkmFBLjrML6N5YA>
    <xmx:2iouaFdrh_c8lDleynNpvYcw0ZqoKbwosE9pgxF05pvLmFiRUElxh5SL>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:49 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 06/10] landlock/domain: Define landlock_domain
Date: Wed, 21 May 2025 20:32:02 +0100
Message-ID: <33630445684e7f8388ba056d757a3279798bff7e.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This will eventually take the role of landlock_ruleset (and maybe
landlock_hirearchy?), but for now it is just the inode rules hashtable.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c | 36 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h | 27 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d06..180ed75da9e2 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -5,6 +5,7 @@
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
  * Copyright © 2024-2025 Microsoft Corporation
+ * Copyright © 2025      Tingmao Wang <m@maowtm.org>
  */
 
 #include <kunit/test.h>
@@ -24,6 +25,41 @@
 #include "domain.h"
 #include "id.h"
 
+struct landlock_domain *landlock_alloc_domain(size_t num_inode_entries,
+					      u16 num_layers)
+{
+	struct landlock_domain *new_domain =
+		kzalloc(sizeof(struct landlock_domain), GFP_KERNEL_ACCOUNT);
+
+	if (!new_domain)
+		return NULL;
+	refcount_set(&new_domain->usage, 1);
+	new_domain->num_layers = num_layers;
+	if (landlock_hash_init(num_inode_entries, &new_domain->inode_table)) {
+		kfree(new_domain);
+		return NULL;
+	}
+
+	return new_domain;
+}
+
+static void free_domain(struct landlock_domain *const domain)
+{
+	might_sleep();
+
+	landlock_hash_free(&domain->inode_table, LANDLOCK_KEY_INODE);
+	kfree(domain);
+}
+
+void landlock_put_domain(struct landlock_domain *const domain)
+{
+	might_sleep();
+
+	if (domain && refcount_dec_and_test(&domain->usage)) {
+		free_domain(domain);
+	}
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a..ed685f8ad52e 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -5,6 +5,7 @@
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
  * Copyright © 2024-2025 Microsoft Corporation
+ * Copyright © 2025      Tingmao Wang <m@maowtm.org>
  */
 
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
@@ -20,6 +21,32 @@
 
 #include "access.h"
 #include "audit.h"
+#include "hash.h"
+
+struct landlock_domain {
+	struct landlock_hashtable inode_table;
+
+	/**
+	 * @usage: Reference count for this struct.
+	 */
+	refcount_t usage;
+
+	/**
+	 * @num_layers: Number of layers in this domain.
+	 */
+	u16 num_layers;
+};
+
+struct landlock_domain *landlock_alloc_domain(size_t num_inode_entries,
+					      u16 num_layers);
+
+static inline void landlock_get_domain(struct landlock_domain *const domain)
+{
+	if (domain)
+		refcount_inc(&domain->usage);
+}
+
+void landlock_put_domain(struct landlock_domain *const domain);
 
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
-- 
2.49.0

