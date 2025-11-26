Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A733A70E
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176260; cv=none; b=f5i7kif085RW77XYnavx6A9rhMzet16h/sLc0FTI2fuNJsxIiSlz8fzi0LpDKuwctKQzmI0VuAipPBe90hMoLqm8JFaTkxbc9WssB0mGs8LBGNuPy645B9EVfFIZdkTTaUQ50IvLm6IR/U6cPOQFJfLdJ8kyDkbOEtKQK0TfH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176260; c=relaxed/simple;
	bh=GxfP3X2HTJj6rxIz7ApFYXdc2WNV3Mv2VIfhSQeEEX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axsIcRdjQ6Ef7slB0GKHJpG69l+QVjbc6Vg1IX1H5B5Km66r9sNv4wRXzjuiVZHLAAJjMWIwFQT/yKFmDhnZilSy67IagsQvKyzuCBjFBYNhLtX8iCj+87M0SCWPPb+0vQZHkUPcruvKDU/np111y/vLq9p935clhXQ14pUxW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hDk+rp0f; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hDk+rp0f"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764176255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1V6dVMRPdO6zxApdjSC0yLAiD/k0sxeV6A4unld8xk4=;
	b=hDk+rp0fKD+kzjxKeI+SqW9wKBFQLKbYUes9OqhT3qTqeiwkAPYt03Kd521DjWRfSjAgCk
	W4ziClrMpl5ALfsrX8ghBDIz0T6hdqfKY06W+sbXqiI0fS6boP6aROuF7ZmtaKoQ9EeP5+
	lonSA75Qop8tuXnT9TzL1Fww8ygOx04=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Replace deprecated strcpy with memcpy in gen_symlink_name
Date: Wed, 26 Nov 2025 17:57:01 +0100
Message-ID: <20251126165701.97158-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead. Unlike strcpy(), memcpy()
does not copy the NUL terminator from the source string, which would be
overwritten anyway on every iteration when using strcpy(). snprintf()
then ensures that 'char *s' is NUL-terminated.

Replace the hard-coded path length to remove the magic number 6, and add
a comment explaining the extra 11 bytes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/apparmorfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 391a586d0557..4b2752200ce2 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1602,16 +1602,20 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
 {
 	char *buffer, *s;
 	int error;
-	int size = depth * 6 + strlen(dirname) + strlen(fname) + 11;
+	const char *path = "../../";
+	size_t path_len = strlen(path);
+	int size;
 
+	/* Extra 11 bytes: "raw_data" (9) + two slashes "//" (2) */
+	size = depth * path_len + strlen(dirname) + strlen(fname) + 11;
 	s = buffer = kmalloc(size, GFP_KERNEL);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
 	for (; depth > 0; depth--) {
-		strcpy(s, "../../");
-		s += 6;
-		size -= 6;
+		memcpy(s, path, path_len);
+		s += path_len;
+		size -= path_len;
 	}
 
 	error = snprintf(s, size, "raw_data/%s/%s", dirname, fname);
-- 
2.51.1

