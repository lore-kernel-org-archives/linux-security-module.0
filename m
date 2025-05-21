Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB521FF45
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856094; cv=none; b=EOMxNJJ8GObBWluw8bJNhYPWRKXMSCktcFHjtJ8nebG0VGG5CLN9BmmoTfH0BDWR7Xhl2AaS9dgvrUb8j+86zkPr68hudwkk9hL6/jt2shbpoODcRcGwp86sTRXC3Hbl6pMmBbrOfx9MRwvB0b6fWYAQJYhYHga/WdeWpKmt0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856094; c=relaxed/simple;
	bh=1Sa0IC/uZ0HH/PlwF9g6snMyMoSZskQi8W77+CSTMg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQg7FhVFv3TYzW5DTuVlXG2SzFNknj3hBBjdqytJkSzQ+NE61qJQ7E2xxCFDe0+ke4qpNDUKsN5URRwAvWhwzVHN/PQZBgl36/14yJi3tLMenTrFSmso3mQR9rXdZaIbyJZchle8r9Y8VypyEZJNCGgS32UqeCMmTvRU2xVELLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=B8ItRCIc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1+JZlQU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="B8ItRCIc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1+JZlQU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A78EC1380190;
	Wed, 21 May 2025 15:34:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 15:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856091; x=
	1747942491; bh=bESGrqgsGIXo4kLQAGND2jbCd9OhpP0GM/3yeY1aMww=; b=B
	8ItRCIcW3MoVyTug2ybV8s44egNE8JivevMBWmUN2h3zD1+82dmAPRYwZLs0lDVO
	F8/f+Jni5MAu4SLdxsbdZ6LPjBUm2zTy934qxFT4U9klcDo+A6RTtgbiWHB7fWdk
	/6Jo3U1KliciDbFvvxfCA34iCpm1tq0VB61hBAVdlEt2YcpuRZ1ZMo2w+Yz1VSOC
	jhoJ6hj5RZyRR96FzLeYnEukhXV/KjetNlSS69V1zdIE2Hcjsitnectj9ZIAjEJP
	fd04CPC3oF1eSVSFQBYQkJUVIFGK7OD0umohPrSMGjxVUOyECWTsBTrpqnBU5Pgr
	fEndUfyZreTNROT+1JjvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856091; x=1747942491; bh=b
	ESGrqgsGIXo4kLQAGND2jbCd9OhpP0GM/3yeY1aMww=; b=H1+JZlQUyO32Gf93W
	CXxlPRAK6rGP044kXW89oo3HVCWMGtUrREkzcKhapeFyd5B5bePNrCfTqPA73d+V
	BqBwI6Znwh+gzZbjn/YsBpzAHzAQIZbxLg5wdbLqDss7ZcpaKXfUoqs2PoTq92sE
	eM6XFSy6oFpDavm9VlbeuGX+T3H8g4amEx8/2NggKXHXzUC1YOH1l8Yq7I3EHuht
	TVBnMe2Hu7NimXVc+0ggo8hTDo8+d2g4rZ22WUHVVWIb0CA17huIurU2C8tbJyGX
	aAHgMipCOxBkD3I2hcffdijPJqhRVuMXlpFHi4mO2Ruk4SiChSQe2JOuCls4Xk0r
	TRvhg==
X-ME-Sender: <xms:2youaFlm2PcqBu67AycuDzdOkt_Vb6eTYN9Grpa_OcrR6XEx8hH0kg>
    <xme:2youaA2mGcO8RHyCHdsxTOXtH7EvFfISQEWF4X70Tx4rY1WyZl7SWsCkMUya6NNl6
    EiOhz-f8njOX2-kiks>
X-ME-Received: <xmr:2youaLq5d26KLqMTwSHCTsr-QHo8kKjOfCgzyeZ2FHQlEXh0dOIJfFzJzg_DnjsZ-yaMATbtVsSrYhu2UZ85E3G2ZNwb62nzi5bJiNwZ8i84TPtj5fppTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmh
    grohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddv
    teefffegteetueegueeljeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurh
    hithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2youaFmcMmI-ZU0tF40PvaZNwkbUqKzHLJq4gVOCXKX1rcAzajhLZg>
    <xmx:2youaD1MVNRWKdBOF6IpJgP-i3YE1Yjl-VQMqet_ccjt4BINxOYz1Q>
    <xmx:2youaEvghdPaja42Yp4CjYBvdGH4JCxPNPt_UakQrhEFbnp1e4hs_g>
    <xmx:2youaHVzRZlgGrSEmSxZL56mmEDbhf8fbezywHU-o69Xtp4ciD-EUQ>
    <xmx:2youaI3ZhPAsknU7IjjDgkhql87l1ojxMwh-wXzTnYbvyR71CP6eXBGw>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:50 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 07/10] landlock: Add the new domain to landlock_cred_security
Date: Wed, 21 May 2025 20:32:03 +0100
Message-ID: <2b7add2e0ddfed8fe021c2716d0770e0df818848.1747836146.git.m@maowtm.org>
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

We add a new field domain2 that will eventually replace the old struct
landlock_ruleset domain.  Also add get/put to appropriate places where
this struct is copied/freed.

In a future patch, this domain2 will be renamed to domain.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/cred.c   |  8 ++++----
 security/landlock/cred.h   |  1 +
 security/landlock/domain.c | 17 +++++++++++++++++
 security/landlock/domain.h | 32 +++++++++++++++++++++++---------
 security/landlock/fs.c     |  5 +++++
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..e08c9e206350 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -13,6 +13,7 @@
 
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "ruleset.h"
 #include "setup.h"
 
@@ -24,6 +25,7 @@ static void hook_cred_transfer(struct cred *const new,
 
 	if (old_llcred->domain) {
 		landlock_get_ruleset(old_llcred->domain);
+		landlock_get_domain(old_llcred->domain2);
 		*landlock_cred(new) = *old_llcred;
 	}
 }
@@ -37,10 +39,8 @@ static int hook_cred_prepare(struct cred *const new,
 
 static void hook_cred_free(struct cred *const cred)
 {
-	struct landlock_ruleset *const dom = landlock_cred(cred)->domain;
-
-	if (dom)
-		landlock_put_ruleset_deferred(dom);
+	landlock_put_ruleset_deferred(landlock_cred(cred)->domain);
+	landlock_put_domain_deferred(landlock_cred(cred)->domain2);
 }
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c82fe63ec598..b13b4c2e21aa 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -32,6 +32,7 @@ struct landlock_cred_security {
 	 * @domain: Immutable ruleset enforced on a task.
 	 */
 	struct landlock_ruleset *domain;
+	struct landlock_domain *domain2;
 
 #ifdef CONFIG_AUDIT
 	/**
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 180ed75da9e2..321c52b275fc 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -60,6 +60,23 @@ void landlock_put_domain(struct landlock_domain *const domain)
 	}
 }
 
+static void free_domain_work(struct work_struct *const work)
+{
+	struct landlock_domain *domain;
+
+	domain = container_of(work, struct landlock_domain, work_free);
+	free_domain(domain);
+}
+
+/* Only called by hook_cred_free(). */
+void landlock_put_domain_deferred(struct landlock_domain *const domain)
+{
+	if (domain && refcount_dec_and_test(&domain->usage)) {
+		INIT_WORK(&domain->work_free, free_domain_work);
+		schedule_work(&domain->work_free);
+	}
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index ed685f8ad52e..944420231040 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -18,6 +18,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "access.h"
 #include "audit.h"
@@ -26,15 +27,26 @@
 struct landlock_domain {
 	struct landlock_hashtable inode_table;
 
-	/**
-	 * @usage: Reference count for this struct.
-	 */
-	refcount_t usage;
-
-	/**
-	 * @num_layers: Number of layers in this domain.
-	 */
-	u16 num_layers;
+	union {
+		/**
+		 * @work_free: Enables to free a ruleset within a lockless
+		 * section.  This is only used by
+		 * landlock_put_domain_deferred() when @usage reaches zero.
+		 */
+		struct work_struct work_free;
+
+		struct {
+			/**
+			* @usage: Reference count for this struct.
+			*/
+			refcount_t usage;
+
+			/**
+			* @num_layers: Number of layers in this domain.
+			*/
+			u16 num_layers;
+		};
+	};
 };
 
 struct landlock_domain *landlock_alloc_domain(size_t num_inode_entries,
@@ -48,6 +60,8 @@ static inline void landlock_get_domain(struct landlock_domain *const domain)
 
 void landlock_put_domain(struct landlock_domain *const domain);
 
+void landlock_put_domain_deferred(struct landlock_domain *const domain);
+
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b407c644ac65..c4f442093c6e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1844,6 +1844,7 @@ static bool control_current_fowner(struct fown_struct *const fown)
 static void hook_file_set_fowner(struct file *file)
 {
 	struct landlock_ruleset *prev_dom;
+	struct landlock_domain *prev_dom2;
 	struct landlock_cred_security fown_subject = {};
 	size_t fown_layer = 0;
 
@@ -1856,11 +1857,13 @@ static void hook_file_set_fowner(struct file *file)
 				current_cred(), signal_scope, &fown_layer);
 		if (new_subject) {
 			landlock_get_ruleset(new_subject->domain);
+			landlock_get_domain(new_subject->domain2);
 			fown_subject = *new_subject;
 		}
 	}
 
 	prev_dom = landlock_file(file)->fown_subject.domain;
+	prev_dom2 = landlock_file(file)->fown_subject.domain2;
 	landlock_file(file)->fown_subject = fown_subject;
 #ifdef CONFIG_AUDIT
 	landlock_file(file)->fown_layer = fown_layer;
@@ -1868,11 +1871,13 @@ static void hook_file_set_fowner(struct file *file)
 
 	/* May be called in an RCU read-side critical section. */
 	landlock_put_ruleset_deferred(prev_dom);
+	landlock_put_domain_deferred(prev_dom2);
 }
 
 static void hook_file_free_security(struct file *file)
 {
 	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
+	landlock_put_domain_deferred(landlock_file(file)->fown_subject.domain2);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-- 
2.49.0

