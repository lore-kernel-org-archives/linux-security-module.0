Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01627308F2C
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369240; cv=none; b=TF9+xU926ScBZgUaAIU4kiGzL/Lm+dbwDeLJQtEYeu5zAOXPf7oHDqjEyEjid7V1ritrhqdbDPLQZlvtaVa2EFRl94QGM45BKCu4g5HrX/qxp7lCmtyI6Y5vDG6i4HAhPe6SjRtEhTYBJ/w23axwGHIMnMgWKlrCASNwTe4CerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369240; c=relaxed/simple;
	bh=au5Zxa9P6vv155UjeHIJB4LFB8RaN28iXMoa0bi7Z1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPWr1abolfyQ6QMBbI+sQaNg7tbg1w51DCBcvi1jVKPeUc0omc/v55zSzLliOB/jfBe5JRe0CBWdUhxTp/zQH+1zkX/SS3oIvqMx7eFIhe+wszLZTQwr45pzvXREfn8FEX18qXNd5EF3RDNRuoUqaQwgN8YwFqKh4HTQvT0n3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t5ud2BXl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t5ud2BXl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760369226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sUj9/fl0PKZckLy/y4eN1T39rCUtbYnu7ZJ7T8cVVSc=;
	b=t5ud2BXlDCEPZ1pxV130zo3FndtMDDhLrfBFVwETd2jkIRR1vszPGNqa9Y27dW57tBOa9X
	XEfAKBUILypXfYlBzR6R4k2A1J+XazEjleqQ8h6WxRmB3TrVuy5w4p9IwgfGpBPxziNp2t
	G8lr4i8D1khM26NUONWpyHkUuCs5uDw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] keys: Replace deprecated strncpy in ecryptfs_fill_auth_tok
Date: Mon, 13 Oct 2025 17:26:28 +0200
Message-ID: <20251013152627.98231-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy_pad() instead to retain the NUL-padding behavior of strncpy().

The destination buffer is initialized using kzalloc() with a 'signature'
size of ECRYPTFS_PASSWORD_SIG_SIZE + 1. strncpy() then copies up to
ECRYPTFS_PASSWORD_SIG_SIZE bytes from 'key_desc', NUL-padding any
remaining bytes if needed, but expects the last byte to be zero.

strscpy_pad() also copies the source string to 'signature', and NUL-pads
the destination buffer if needed, but ensures it's always NUL-terminated
without relying on it being zero-initialized.

strscpy_pad() automatically determines the size of the fixed-length
destination buffer via sizeof() when the optional size argument is
omitted, making an explicit size unnecessary.

In encrypted_init(), the source string 'key_desc' is validated by
valid_ecryptfs_desc() before calling ecryptfs_fill_auth_tok(), and is
therefore NUL-terminated and satisfies the __must_be_cstr() requirement
of strscpy_pad().

Link: https://github.com/KSPP/linux/issues/90
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Improve commit message
- Link to v2: https://lore.kernel.org/lkml/20251010161340.458707-2-thorsten.blum@linux.dev/

Changes in v2:
- Improve commit message as suggested by Jarkko and Kees
- Link to v1: https://lore.kernel.org/lkml/20251009180316.394708-3-thorsten.blum@linux.dev/
---
 security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index 8fdd76105ce3..2fc6f3a66135 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
 	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
 			     | ((uint16_t)minor & 0x00FF));
 	auth_tok->token_type = ECRYPTFS_PASSWORD;
-	strncpy((char *)auth_tok->token.password.signature, key_desc,
-		ECRYPTFS_PASSWORD_SIG_SIZE);
+	strscpy_pad(auth_tok->token.password.signature, key_desc);
 	auth_tok->token.password.session_key_encryption_key_bytes =
 		ECRYPTFS_MAX_KEY_BYTES;
 	/*
-- 
2.51.0

