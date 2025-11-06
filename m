Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149334574A
	for <linux-security-module@vger.kernel.org>; Thu,  6 Nov 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440751; cv=none; b=YKvaTeoLfJzChvC04OJiRiGugygrGKJnXGQ1eOyOFEHnEINMZPlqJMX9NFhifXXb/soCzfML/Qx5g0yYMwuvcc2Rh7sUUJfaPoAPaAs3Xw6wIcaOYPWgbZGlJuuoCX0xav3YkcFpAVx4SHgXFybQJ9Ud8428eNbN8JLe05HZXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440751; c=relaxed/simple;
	bh=LJGO1EFISHsoJp+waIuIjo3akZR52MXApU7v0jNMSaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7XwIjbzmPkbI7EB7BdrWvw521TEHhvJ4Gr69wSFpU/8S+J2dkSGSUglxBu2a3hyWZsOi5qcg2MRVLHJEZRF9O6fP5uuHDEc2GU+0z0ELbiiEib/NvElF4zPZ8dASqtgHg3LBTOUDEL6jc+h2f4eaVKU50gll8sFjcuxk/gjzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obUKVrPB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obUKVrPB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762440734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4R+9Ob+hbRjK0HBoBAzVyU/bk+mxiL9d1ujtEwngm2c=;
	b=obUKVrPBKtRQxQ1eSjIMNX9QlThWkVT1enKd5VRldVSDy4kELar299dPpeotu+YCHXdqdN
	izcZ0OqvhVezrPBTJziZuZF04LIw58NKFj/akqODr3NLAwNhsIa3cNRh2C7EIYrHPoK/UC
	MtNmZVK+pQGbfSanccyQqViv7JgaCm8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Replace deprecated strcpy in d_namespace_path
Date: Thu,  6 Nov 2025 15:51:38 +0100
Message-ID: <20251106145138.2123-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; replace it with a direct '/' assignment. The
buffer is already NUL-terminated, so there is no need to copy an
additional NUL terminator as strcpy() did.

Update the comment and add the local variable 'is_root' for clarity.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/path.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index d6c74c357ffd..65a0ca5cc1bd 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -164,12 +164,15 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	}
 
 out:
-	/*
-	 * Append "/" to the pathname.  The root directory is a special
-	 * case; it already ends in slash.
+	/* Append "/" to directory paths, except for root "/" which
+	 * already ends in a slash.
 	 */
-	if (!error && isdir && ((*name)[1] != '\0' || (*name)[0] != '/'))
-		strcpy(&buf[aa_g_path_max - 2], "/");
+	if (!error && isdir) {
+		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
+
+		if (!is_root)
+			buf[aa_g_path_max - 2] = '/';
+	}
 
 	return error;
 }
-- 
2.51.1

