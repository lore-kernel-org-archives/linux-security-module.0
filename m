Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680A3955D6;
	Tue, 22 Sep 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088610; cv=none; b=jQK76tEvPHggHlGMc2lSmhnRuyLkIaZglugqfCc60WWiOA35cPxd18E2LebERgJXUeCP50x3aEaCau5h77DZ65ox5LKoRGoFu1SbfVJ8O4XWWI/5R8z+SqvnGRfEJhwKLSUiTfvCD0sR6r5wMaM8PTgTLjwM1lZROZBbcts2aEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088610; c=relaxed/simple;
	bh=xx9lx+vAlnsB2mvTyGUhmbrsk8f2+azLaHC9Cyvs+pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pB6T5aTOKE1MIKrtryPl4lHG8FGbYFfblRh+lullOgyYs1RSh+X8a0kxicOnFYXn++a2O1bmVB5DMiZKSMpCKOZxAnReanHhH15rk1AxF3QQOkeM95rUrt//QWakTKpeXhSwaa5lzieujU5h3CJ8VR2RGfA8oVhvKbf1pSY80p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpip3t1790088553t8688084e
X-QQ-Originating-IP: CeNMXMgN08HI9g+/bhQKFO97KJixQ4/apYMuth+JRt4=
Received: from kylin-ThinkBook-14-G5-ABP.. ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Sep 2026 22:49:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 383231133204121578
EX-QQ-RecipientCnt: 7
From: Hongjian Dai <daihongjian@kylinsec.com.cn>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongjian Dai <daihongjian@kylinsec.com.cn>
Subject: [PATCH] smackfs: fix IPv6 netlabel prefix mask for non-16-aligned lengths
Date: Tue, 22 Sep 2026 22:47:38 +0800
Message-ID: <A82C90B4956EE3A9+20260922144738.9594-1-daihongjian@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NhdiEwnVOUqEcy9GRLdRqCDiCRqn0h1XJWxu1NAYjvq3Rvg30j0sXkwv
	yoAeCUkAWus88c8/rYOWosJBM93zofzktxRAkrGVNn6B+SAui8Aya2ccqbCPHrm+IKzHSAm
	pkFkOcK5n5HtwjOJxA/LMBYNMfEqe9ycTNG0LcPqsVTTD/219AhJd/N7Qe3G88XgoXspGcp
	tYj5LZ8Kxrute9Na28e276cnDCX7+5oaot6qnBCMJFJgbBocq7KkQQKX23A9xiMGPdDhzwB
	lK/esCiWK+MSnkz8ryEWmSoLEOccMK0PQYzDATCsRJN1Fn4P8CO6nKbQ/ho/XQSMs76sczm
	rBa+2h9gQvg6ZxjZTWgmqrUeaFSaUQx04e4zUsgF0G+HpE50j2DXyCZIGnWiqGcyA5oDE26
	eZIf7kRVRuZRiPFwmFHVxZ+qr8VRk2oZUsry/QhmoEX9Lqm53F8Cc94tukYKFUmlRmZAUnv
	J0+1MGdLwMHX0UH4sTFTUazeNVXBbV1jxqec4nlQKqS5IA3pdZ7LkqvHPdl7v9XQLSRWn4n
	h8AGvuSv785NqvI/azYbV3kH6TRWZ7J9fdW8BG/Etd0y28k8+Ku5bfRp1o11fsE0iDLRGlF
	VRJDdn5hrPxDA79cGYrcMHRegcfg8qivLQ11x3smDP7FbnznQLrOI1TyP/Vo80sCoupTa7P
	oVftw/9TWvOSliIL+VmPYs0kQtCtNyairGXC2+9a2xclR5N3Bdnmk3Ev5kNyde+Ds6PLWVr
	VzFNDcl+ininoKlklPeSqqrxZ85umwV4KdJTvSVwbGNkp2hm6XCazuSaY3RtECgOQxOvT7a
	zMfrPk1x9qDDS35G3YvFgPjZu8Vyuy/SFqy59DwVeOkX8agIrNdl5/5y5IZIUPbJg9P1suH
	09CpyjHSQqLjhrQDBKcbGALN4TDRnpgjUUGrmCve2I1MeiLd7iwJ2YZSZzNJzWw2QEiNYMu
	ZIkahJb4iA4lodVA7XLrIxFmzwA0oZXUsJ7dqQmRqN8LckguIq798LOEYU0SlKqciQSTL+n
	M8DVd5XQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

smk_write_net6addr() builds the partial-word mask as (1 << m) - 1,
which keeps the low m bits instead of the high m bits (e.g. /33
yields 0x0001 instead of 0x8000), and stores it without htons()
while the address words are in network byte order. Any prefix with
mask % 16 != 0 is truncated to the wrong network and mislabeled.

Take the high m bits and convert to network byte order, matching
how newname words are stored with htons().

Fixes: 21abb1ec414c ("Smack: IPv6 host labeling")
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a72bc7fabea9..6d680424a8c3 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1506,7 +1506,7 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 			fullmask.s6_addr16[i] = 0xffff;
 			m -= 16;
 		} else if (m > 0) {
-			fullmask.s6_addr16[i] = (1 << m) - 1;
+			fullmask.s6_addr16[i] = htons(0xffff << (16 - m));
 			m = 0;
 		} else
 			fullmask.s6_addr16[i] = 0;
-- 
2.43.0

