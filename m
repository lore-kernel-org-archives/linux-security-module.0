Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566F40B6DE
	for <linux-security-module@vger.kernel.org>; Sat, 28 Feb 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271911; cv=none; b=ojcSeN/VVTZgIX4qOCgX4weS5vRaQpAmtoH3IKSB01x1fjjKlyfqSBS0kxIeJcMgwpF3rM+c8bfYehtxXYinK0AEuWPz0GMkL9LNT5EynDh9J82yAKLgzI7uc3VkpyxNfoURe020HHS+4mNH7B+YuL4WO+Tw0Ut/gYRw5ChZTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271911; c=relaxed/simple;
	bh=BbBnzLzIVKCMk5bpR05I6NthxRYeyQFEVvHu5rxo4FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUFOwWNVdLyfLrJBim9W0t9g4AF2tpsbxsltRP623hCvsWYwmee2Ftn3yTMnxQaNjrId9v5svSF0d9fMFuu2trqETjjvYxBjXIs+wDFVUjbuCVjnWVdjIce3tL1h9TZaCod+HnqLGnn8BtTCjELs8TDFG3WwU+aAWTj0YKN1Vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JaMvbNE/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JaMvbNE/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772271897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+IWRKGe07FbN2ZKZYmIp9gPYUSJKqCBN8aB5e4C9Dx0=;
	b=JaMvbNE/jgJoH/5QX26jITNLTCf59yat0XVXf4pO3cUcHy4PE8/IWGzAUn8Tkt+k6CFt4L
	Gs/tCd/SXQvU2lglshunoUvoQNzftIEaB9x716y7IIfY0zv1PfexGgpKEorCYl6i6O511p
	gNpXJnugu55R6oYVGChQ0nOT/IY+j6U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] keys: Remove return variable and length check to simplify user_read
Date: Sat, 28 Feb 2026 10:44:46 +0100
Message-ID: <20260228094447.869637-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In user_read(), remove the unnecessary return variable 'ret' and return
->datalen directly. Drop the redundant 'buflen > 0' check and use min()
to determine the number of bytes to copy.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/user_defined.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 6f88b507f927..b53e063272c2 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -171,20 +171,14 @@ EXPORT_SYMBOL_GPL(user_describe);
 long user_read(const struct key *key, char *buffer, size_t buflen)
 {
 	const struct user_key_payload *upayload;
-	long ret;
 
 	upayload = user_key_payload_locked(key);
-	ret = upayload->datalen;
 
 	/* we can return the data as is */
-	if (buffer && buflen > 0) {
-		if (buflen > upayload->datalen)
-			buflen = upayload->datalen;
+	if (buffer)
+		memcpy(buffer, upayload->data, min(buflen, upayload->datalen));
 
-		memcpy(buffer, upayload->data, buflen);
-	}
-
-	return ret;
+	return upayload->datalen;
 }
 
 EXPORT_SYMBOL_GPL(user_read);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

