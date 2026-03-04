Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22823D5653
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653281; cv=none; b=Pv3Y9DRP+O7zU3au5U5GKPsJwe2i9p/MGHswPe6ro8fr0x4/feSnRk6fEm/TRO4shQfB7vMHIedfLIGMdWL9Ixu2h6NrW7Sp51587W3uFRNW8/mWrfTjevv9Qx62dFV+oA9IshTig5HpYs5Tco6JGR+BpKtuIMJ7SJQKL4dQbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653281; c=relaxed/simple;
	bh=s5XAnhG99USSeXVgUSWbgXCMK0v0/hR/TzdUvS1VJ8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuy/rwuRP2kRyOdgHsUPA80wzzHoNSfvH29Mjw+eKQpKmZagEdSwDdv0KJ2EZarmEbgu7ZRFsKTt7TcsinIBkF3JbCXxUB+RkUEGCls7Rs4WN7LEF2cyQJX4kTCU8Yh3nC1PP6EpcSmBEzmFgaA6HOOMBNr5SIDJ4pU75mznZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DQBZ3tSI; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DQBZ3tSI"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fR2q72hbkzb0h;
	Wed,  4 Mar 2026 20:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772652707;
	bh=AphWglXpcagLgevXEHTccmDxJenKNpWo31IVMCGMGIg=;
	h=From:To:Cc:Subject:Date:From;
	b=DQBZ3tSIYVpxGdD0s7F4q7nyh3nPAq5kSnfPf4bBnDyRAjasQZ157QRAIXqMGJx0E
	 2LPNJ9ouoX/+L/RsNR4lQQsXidfPiXjxa+a6XTt6mYXBUoktLZOOXGSdOBhWQVapZW
	 +/sObXWK88nPfQ+HLZLlX3exfsOenktwIQDnPpj0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fR2q671B4zvRb;
	Wed,  4 Mar 2026 20:31:46 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/4] landlock: Fix kernel-doc warning for pointer-to-array parameters
Date: Wed,  4 Mar 2026 20:31:24 +0100
Message-ID: <20260304193134.250495-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The insert_rule() and create_rule() functions take a
pointer-to-flexible-array parameter declared as:

  const struct landlock_layer (*const layers)[]

The kernel-doc parser cannot handle a qualifier between * and the
parameter name in this syntax, producing spurious "Invalid param" and
"not described" warnings.

Introduce landlock_layer_array_t as a typedef for the flexible array
type so the parameter can be written as:

  const landlock_layer_array_t *const layers

This is the same type but kernel-doc parses it correctly, while
preserving the pointer-to-array type safety that prevents callers from
accidentally passing a pointer to a single element.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/ruleset.c | 4 ++--
 security/landlock/ruleset.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 419b237de635..a61ced492f41 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -108,7 +108,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 
 static struct landlock_rule *
 create_rule(const struct landlock_id id,
-	    const struct landlock_layer (*const layers)[], const u32 num_layers,
+	    const landlock_layer_array_t *const layers, const u32 num_layers,
 	    const struct landlock_layer *const new_layer)
 {
 	struct landlock_rule *new_rule;
@@ -205,7 +205,7 @@ static void build_check_ruleset(void)
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
 		       const struct landlock_id id,
-		       const struct landlock_layer (*const layers)[],
+		       const landlock_layer_array_t *const layers,
 		       const size_t num_layers)
 {
 	struct rb_node **walker_node;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 9d6dc632684c..87d52031fb5a 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -37,6 +37,14 @@ struct landlock_layer {
 	access_mask_t access;
 };
 
+/*
+ * Flexible array of Landlock layers, used for pointer-to-array function
+ * parameters that reference either a stack-allocated layer array or a rule's
+ * flexible array member (struct landlock_rule.layers).  This typedef avoids
+ * the complex (*const name)[] syntax that the kernel-doc parser cannot handle.
+ */
+typedef struct landlock_layer landlock_layer_array_t[];
+
 /**
  * union landlock_key - Key of a ruleset's red-black tree
  */
-- 
2.53.0

