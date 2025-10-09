Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FB2E092E
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011184; cv=none; b=nj4+Hgs4WQdwW0eZFraW7iWo3f0DH7y0kPSfMAX2FO9yAsS3TsoB5jGlSUE+Fp870t+76clKlwfkTtkoxQfe1qNMp8q2AefDkdP3qZsFOKvlgzgGBkkURs+R7/7wfyy3jfZwGGXH50DUEZSB2uPasggHPKQOpe6OU2YttBJg/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011184; c=relaxed/simple;
	bh=k7jEyGwrGZBJ+mBJ/addAS2ZF+jWobMOL2iLQMc1dD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaDFsOe0R4HNx+4EYK6hYBCQGvHrU1TJMWbgrpoUH+QMTl1ZgP2ps4vwWqtmtL1oT3GUPfXrM+VelOaXn5voinvzh26BJGk+LxW6JonQ0nFYYbi+SKkXBPD3F+iFTns9VljZNpd4zyos+kT2y3tT+fGxZRhd3v1dmhQPbl0X63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j7SVYHV8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j7SVYHV8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760011169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KiABDmn04KyLpYGFg9hQuEssOiu7vxmwKbRQ+ewHZs4=;
	b=j7SVYHV8WGDv+dztjVrBDZrNawnGioai3qQkP4sAD5n6cKiAocoFFKIve1hIwPVwwwCVK3
	/2xo52IU+nRW4pYGJCejCtX6T+ScyfEPXdoFj9HMLX1+njr8csepS3jsqIMBsz0kcPuCmC
	Zdv47rRqqzrVxfLKnOYZKE0O2I1UPpY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: encrypted: Use designated initializers for match_table_t structs
Date: Thu,  9 Oct 2025 13:58:17 +0200
Message-ID: <20251009115817.368170-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use designated initializers for 'key_format_tokens' and 'key_tokens' to
allow struct fields to be reordered more easily and to improve
readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/encrypted-keys/encrypted.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index aef438d18da8..76a6dab2f4d2 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -62,17 +62,17 @@ enum {
 };
 
 static const match_table_t key_format_tokens = {
-	{Opt_default, "default"},
-	{Opt_ecryptfs, "ecryptfs"},
-	{Opt_enc32, "enc32"},
-	{Opt_error, NULL}
+	{ .token = Opt_default, .pattern = "default"},
+	{ .token = Opt_ecryptfs, .pattern = "ecryptfs"},
+	{ .token = Opt_enc32, .pattern = "enc32"},
+	{ .token = Opt_error, .pattern = NULL}
 };
 
 static const match_table_t key_tokens = {
-	{Opt_new, "new"},
-	{Opt_load, "load"},
-	{Opt_update, "update"},
-	{Opt_err, NULL}
+	{ .token = Opt_new, .pattern = "new"},
+	{ .token = Opt_load, .pattern = "load"},
+	{ .token = Opt_update, .pattern = "update"},
+	{ .token = Opt_err, .pattern = NULL}
 };
 
 static bool user_decrypted_data = IS_ENABLED(CONFIG_USER_DECRYPTED_DATA);
-- 
2.51.0

