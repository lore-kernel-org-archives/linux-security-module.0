Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8503313287
	for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629407; cv=none; b=fux0GyU9QWMNjIfrwi21VhAAGRNrhd8x4RSUcD4Nw5bC+zXXx5tfbablT0qJN8PgjsBWzY4x1t7SjszXY2XSGXeji7gbxVvva+4EEWBTvQyyEcByUY0jWkoIaLVLr3g1cs323ZtTN+VaB89XYgkZhu5QlKaHpcjmff45U8pBBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629407; c=relaxed/simple;
	bh=6D/ISnDKBD4TnGiRHJ/boFfSs5DQwWVpdvgtgcKhPrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/3V6Fw9ZjqF7tjwqfIqY9P1ug8NMjc0STq29XlT7wGxbYUg+7lUZx+h+ohBEx2lkE5TsTmqdXaYsAX5FZbknjPzcZkJcFS2ymeur6DdITmHkI7EF4t4R3/Fg79MA0gz0eBYx3TnJz+1ZwTeDjIcHae8CrA4vaMbfMVPxJqxNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIExFIw/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIExFIw/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760629393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yrDJGramIbWN35zytt17dHBV5bJqn1DeqiU025oaupE=;
	b=qIExFIw/eD4UwrwAMnApg6TH3vcMgxzxvrafXIFl1Nq+tckXVFNRokP3b7FK/TUABX3CaT
	ztlxNFitIElc9pOsPGfu/9VX0ccXWTlV2XkpHtdX8vjeuQ4J0m8SqIRgaM1svNn05h539c
	NZxTd8yBZUyA68hUgznwo1dfYv/lb90=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Replace deprecated strcpy with memcpy in gen_symlink_name
Date: Thu, 16 Oct 2025 17:41:10 +0200
Message-ID: <20251016154109.32343-2-thorsten.blum@linux.dev>
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
2.51.0

