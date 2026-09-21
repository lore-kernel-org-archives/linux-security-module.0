Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C21F938;
	Mon, 21 Sep 2026 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955215; cv=none; b=Eu7f6v7lCYsl0P7DvdhuQEBfKcoZAaZTg1mnanPLUYbi9L8YbUvg7wI1lRwlZBg08STN5Q/dMyyXgytWDlzuteSOdnOZz2gouwZrnBe2v4SicN1dmBYErQHZ9ryW8jtAPVxQALblAVy15lMP1wgS3eWIY1JhXvGkNGXNeb7f0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955215; c=relaxed/simple;
	bh=Q9beA94/928uU3xWnpz7idvGdeGny2607rbitfMEU40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKIZkjF85fKLXmbF7/5zPs4Tmjk6ujfKQDcxL2VCrueEx+p25o0yADyHx08kepvFnLgZdWmWndfhOROst3jIi6DB3hpP46KLYmZ4ynEXyiCrrIPqHAX+AL3Swb0hl4L+FMbijlEje4JE6QkCEoVIHYUaR8XKbPGplFP8YVWdKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpgz11t1789955160td87a9fbb
X-QQ-Originating-IP: 2C5HUUwQm6uH1u8zjMviVM4I/RkA0fRP2jb6bdi/X0M=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 09:45:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14727765409296284287
EX-QQ-RecipientCnt: 11
From: Hongjian Dai <daihongjian@kylinsec.com.cn>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qinyungao@kylinsec.com.cn,
	luoqiu@kylinsec.com.cn,
	liudalin@kylinsec.com.cn,
	dengyingchao@kylinsec.com.cn,
	Hongjian Dai <daihongjian@kylinsec.com.cn>
Subject: [PATCH] smackfs: reject out-of-range IPv4 octets in netlabel writes
Date: Mon, 21 Sep 2026 09:45:55 +0800
Message-ID: <FFA41AC93858A96A+20260921014555.20351-1-daihongjian@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MhIaRTw6VKSjaLw95y9TN+VzVftrOf9Lwpq9sIfYmqlHNGbKeCNFgZdL
	fJHFmFUn3J1OaINVUnMUxxJ3eIPysK+FK+Mf19osOraTH+gEKZzhrDQgEY4W6d072LR1gLO
	dH345ujoD6RoHQvWkjFdfBkw27NGsHIM9j6kwF8m58MiaN48BKSXXjSmZw1voPr4IyIe32n
	i1SHQ8pUXFklEy+yPkzBTt9jQV3A9X96XjtRpCr0BNE2vfg8XtAxyf1ro+9JYTBTAxa7W7V
	nNxafstDjquxzHfzp6VxsioUuHjXlJJPnif/4iHSnFIGpjcOp5P4wFbRH8XqorapTc8qPhf
	DEVSRVswgu1cBzIVBm2Rb7fvvx266cvG1iQZEKcHWbsqUQfeZflkEcSgswQ1m6c82cMJPFM
	wvfBFDWYAza1fU+JZJ7Cw+EkOvbyagPIRAILi1QE8Tvh3CLmSBaBj+WVlU+lZIF+N0WVjZh
	9pRBvxkl7js3Q3gCgmBZoz/Mq8A7VV0cI+KT8bQKsgYac6su4ar+r/HmY6l+TkFiyTxJOs+
	Du3caNNvWaV4MqT1+go1OY41FkQlk0WnlchKTF2ldJJ7A333LQXMWtQE64IKg/cK3X6uE8n
	9Af2pi8NV0tErMqs03oH63+bFY7C4/MsLIEaNkx3cVk9y0owgNAZQcsnsgjpLENZhrQl5Fk
	djv59LeSxSsqNk7FedgzcCG/pAIRPeqnFPJwGqhUjSr6ozWsMeU9jxqQHE5Cy6psCQnqLAl
	iiARo1ntYoFVR9mkZIVMO+nOuWlYpzNXf61DSkoDG1A0Nvv9ILm171YguHfJgSYoDb5SUkv
	tdckGWpWqnjqros+t3icPpwK4BmfR20gMuh+yONprowwEK34FzRj5QtDyl6K7rp4IVmA5ZD
	Wf40w0a7XfKDAJ6IJuL9Ve9E5k+XVZdTJbAa8yVnTJqY0c2QQZWzI/icEjR87S+5Mg1Z9UK
	5gqbAHv1pDrVHy9bj+N/T3Ak0P2WarUpBDVmv9V405oKqx9oLJ9xKpieW7zLaN5m2bVo1WB
	cHWrRRBDpdITb3HmGTficJxEmH0bH3OHuelk83mam62+N67f3hxfgByh1iKzA5pPMLUxWfo
	CMjnU9Ap/C6viKF65/DfFgv8tVVoQ3b9w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

smk_write_net4addr() parses the address with %hhd, which silently
wraps values over 255 (e.g. 300 becomes 44) and accepts them. The
wrong address is then stored and passed to netlbl_cfg_unlbl_static_add(),
so inbound packets get mislabeled and policy can be bypassed or
connections wrongly denied by a privileged misconfiguration.

Parse into unsigned ints like the IPv6 path does and reject any
octet above 255 with -EINVAL, mirroring the existing scanned[i] >
0xffff check in smk_write_net6addr().

Fixes: 6d3dc07cbb1e ("smack: Add support for unlabeled network hosts and networks")
Signed-off-by: Hongjian Dai <daihongjian@kylinsec.com.cn>
---
 security/smack/smackfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a72bc7fabea9..845660cc3a7b 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1169,6 +1169,7 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	struct in_addr mask;
 	unsigned int m;
 	unsigned int masks;
+	unsigned int octet[4];
 	int found;
 	u32 mask_bits = (1<<31);
 	__be32 nsa;
@@ -1198,17 +1199,26 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 		goto free_data_out;
 	}
 
-	rc = sscanf(data, "%hhd.%hhd.%hhd.%hhd/%u %s",
-		&host[0], &host[1], &host[2], &host[3], &masks, smack);
+	rc = sscanf(data, "%u.%u.%u.%u/%u %s",
+		&octet[0], &octet[1], &octet[2], &octet[3], &masks, smack);
 	if (rc != 6) {
-		rc = sscanf(data, "%hhd.%hhd.%hhd.%hhd %s",
-			&host[0], &host[1], &host[2], &host[3], smack);
+		rc = sscanf(data, "%u.%u.%u.%u %s",
+			&octet[0], &octet[1], &octet[2], &octet[3], smack);
 		if (rc != 5) {
 			rc = -EINVAL;
 			goto free_out;
 		}
 		masks = 32;
 	}
+	if (octet[0] > 255 || octet[1] > 255 || octet[2] > 255 ||
+	    octet[3] > 255) {
+		rc = -EINVAL;
+		goto free_out;
+	}
+	host[0] = octet[0];
+	host[1] = octet[1];
+	host[2] = octet[2];
+	host[3] = octet[3];
 	if (masks > BEBITS) {
 		rc = -EINVAL;
 		goto free_out;
-- 
2.43.0

