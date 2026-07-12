Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5CA3D994
	for <linux-security-module@vger.kernel.org>; Sun, 12 Jul 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851494; cv=none; b=YDqJGhNNga01zSiPQsRKpTNWA6QR6ZmYHuTUrkqYoOrjik3iWlyJf/Dw6MA9vqnXxU9OCrx16rLwcBDjEOjxeOl1CmUABwKl2ZKodcSvvNJyr5JRdNZVil/1qpdcoOci7QDrPQrz/XwvO/PHrcPCYeAVtHO0cdU/x0w+4BeZb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851494; c=relaxed/simple;
	bh=0L4lJQr7AaDt7LGTljafpRpQ9zHO2cbgpwCbYEpqpTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=li0m8pIFI6m9s6PoQ7QHNV5T52ISRKka3ND0SceMEUBHCbnSPNGgYry+Qd4GwHBmtlAikJV4b79Uiin7sNWyhVEYl2+fgPQmlVaWsT4jKIjM8oXr6ArFKOXRoJSnHt1nQwvdFtHe/KUinQO+shMBwiMlkNms6HFC58S2n3FaqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 66CAHxhE015325;
	Sun, 12 Jul 2026 19:17:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 66CAHxbB015321
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 Jul 2026 19:17:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <df2830d0-5ae8-4bb9-b11c-6051fc3784ea@I-love.SAKURA.ne.jp>
Date: Sun, 12 Jul 2026 19:17:59 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] apparmor: replace decompress_zstd() prototype with its entity
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        John Johansen <john.johansen@canonical.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
References: <83eb9325-9688-4a6c-9727-e137df773694@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <83eb9325-9688-4a6c-9727-e137df773694@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp

Fix "undefined symbol: decompress_zstd" error caused by decompress_zstd()
being guarded by CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y.

Reported-by: syzbot+1f14a35d0c73d31555e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f14a35d0c73d31555e4
Fixes: 17b5758bf35c ("apparmor: Initial support for compressed policies")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/apparmor/apparmorfs.c | 72 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2ae9ab94a5a91..152c7967ff1ba 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -483,7 +483,42 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
 
 	return data;
 }
-static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen);
+
+static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen)
+{
+	if (slen < dlen) {
+		const size_t wksp_len = zstd_dctx_workspace_bound();
+		zstd_dctx *ctx;
+		void *wksp;
+		size_t out_len;
+		int ret = 0;
+
+		wksp = kvzalloc(wksp_len, GFP_KERNEL);
+		if (!wksp) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		ctx = zstd_init_dctx(wksp, wksp_len);
+		if (ctx == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		out_len = zstd_decompress_dctx(ctx, dst, dlen, src, slen);
+		if (zstd_is_error(out_len)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+cleanup:
+		kvfree(wksp);
+		return ret;
+	}
+
+	if (dlen < slen)
+		return -EINVAL;
+	memcpy(dst, src, slen);
+	return 0;
+}
+
 /**
  * aa_get_data_from_compressed - common routine for getting compressed policy
  * from user and get both compressed and uncompressed version.
@@ -1517,41 +1552,6 @@ SEQ_RAWDATA_FOPS(revision);
 SEQ_RAWDATA_FOPS(hash);
 SEQ_RAWDATA_FOPS(compressed_size);
 
-static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen)
-{
-	if (slen < dlen) {
-		const size_t wksp_len = zstd_dctx_workspace_bound();
-		zstd_dctx *ctx;
-		void *wksp;
-		size_t out_len;
-		int ret = 0;
-
-		wksp = kvzalloc(wksp_len, GFP_KERNEL);
-		if (!wksp) {
-			ret = -ENOMEM;
-			goto cleanup;
-		}
-		ctx = zstd_init_dctx(wksp, wksp_len);
-		if (ctx == NULL) {
-			ret = -ENOMEM;
-			goto cleanup;
-		}
-		out_len = zstd_decompress_dctx(ctx, dst, dlen, src, slen);
-		if (zstd_is_error(out_len)) {
-			ret = -EINVAL;
-			goto cleanup;
-		}
-cleanup:
-		kvfree(wksp);
-		return ret;
-	}
-
-	if (dlen < slen)
-		return -EINVAL;
-	memcpy(dst, src, slen);
-	return 0;
-}
-
 static ssize_t rawdata_read(struct file *file, char __user *buf, size_t size,
 			    loff_t *ppos)
 {
-- 
2.52.0


