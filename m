Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881559;
	b=NTUorK0zWRVHq6QB/IiWHtL10/T7xxGWLim0hjsq4vzvkjFdwG+U4Q2zDKReZ+f3815x
	 zJbqQYV0feqwvoYNFuR1vEMrOXLW9iFQX8lvnbvQp2BEb6y731Xoa8F1uFDiel9dApF1l
	 TeaTEW+9KuB6opx2hjBsiidewlNSDZU+y3TH12qwOG9xE3aHVgyyOHBc+UPZARIWroul1
	 O96CkdPxG+PmeJCNnp5CxIV7UqXrjOXpA4quKViivAOPYc8NZevERjhzABbmCqlL806yt
	 Syk2sMMHsvRK9Ye91ahsDmWa39OIqd3BdxbjcrIL8SC9DQoCGqwD+4T8Liaq5TPZR/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881559;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Hu1od8+lCznHEOv79xf7ZnVgX/h5koJBmJSgkBfKPa0=;
	b=Q1h/Hm1Kq1CWhfmCoK1sb60T+azO2kR4+C0PFNBL9PIqbq1T9ix38rZhElLd+18RmLo/
	 xo/WeI5/NppXnHhH7F90Hi2vZp/VyB53AjUnNGzhRxeBkk0uKVROxWq7mps55iHSZMsqR
	 acm9MiFkFxuZIPAPRJ+FZQWRgEc1a0vuJe82hFVR63ShVGZefPfZJBBYwzSyrtCzJF/R0
	 r82/Ghnk8TZzblNvlN9ptKW15vBWeQZnLK7tyJ388MpEdqcUd64FfvkLKwe5/kmYmL1hu
	 pj6uBI+aX4TbRjYVXKef8MDUL5H27MYH7KxPIEi4rzGQ5yJVOMWWrZih34PcuEXCR8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinsec.com.cn;
	spf=pass smtp.mailfrom=kylinsec.com.cn;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42514606A31C;
	Tue, 17 Nov 2026 02:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42514606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpsz19t1794881473t486d8fe4
X-QQ-Originating-IP: avSySWkYbX0rQq5RXysYH62VZfq27zIoxR0GTnw15HE=
Received: from kylin-ThinkBook-14-G5-ABP ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Nov 2026 10:11:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10544378180861782766
EX-QQ-RecipientCnt: 7
From: Hongjian Dai <daihongjian@kylinsec.com.cn>
To: casey@schaufler-ca.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongjian Dai <daihongjian@kylinsec.com.cn>
Subject: [PATCH v2] smackfs: fix IPv6 netlabel prefix mask for non-16-aligned lengths
Date: Tue, 17 Nov 2026 10:11:08 +0800
Message-ID: <49DF0992E528A465+20261117021108.209924-1-daihongjian@kylinsec.com.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MIXpHopat2Ia8CP/ahrKqazNJKlcR0VI3sLwLA5Rwkh2HabYVCWfKQQL
	L3wYzA8q0QvskftSp/t3b5C1/QLKMU0N7XZDEsNzgrinudMnMwv4TzvecQqQHMu1+fQXVkc
	XonqJ+gMTfnXeqSFdWJFHveu74Ju6hQBqLcd0l5Bjm0kgGJ4EaU9E7I9rIS098pH2rEP2LT
	OT/u99j81AzUZsnMWxwcvzPs60onvzqqiter1JysvwaCuVHWzzzck9VcDxUU397Yaz1WT06
	/YX8mojsDq61Gga9a2rZVzsbwdIey6ezIiJqhqtxTpy+XfoTwYaHfBTjl+/tVoElSqNL35F
	ZU8mvPaKTI3futgqwzyVIFPthAcaDgQL0LW1w1aohEH42uaWJZ6BGXyITBMANoc1o3+Gct5
	N/ShahkNcKzw1L1479Z7dyXHhXWONwidjQCDT5K6uHi8JUraUHiFlnpKuVfumGNWtghJtIB
	FCUZc+bW8UYeK7KvtgMdxqZAokgyOL7I3YrxZQBC3JRzSl11jo76ma9LOkKj+oYvhMBY9mU
	KoitoO9suE+gs+T5H6IRP+XqGp6BC6SrbAtfZZy7l4tkRFzAstm4Is9rYBVTzBqtBWKY3F2
	HXrNmuJDjxRLuFgfI7plAIe7HP618gjvmiqnQMsYGawzQ0S77ZbwZz8o6x/1syyfKepogUC
	v4Fk4ojRKo5XhNDPgLcdGF3+dRrWvIYsbyKX8Ojc3EYFwFB6OHj6RSiwJ/Iti/gSvncUR7r
	O9piDzKRVbwBfm6vLXL7C5sYL4gp3Cj9BO4GoUC7tYiH2z/2PefsuHpM5PrBre8B7RXkYtg
	2Ll8mYl4AskXKzHjy0FDJAkie1+V9LATOB8xiJT0hRZRlt4T/bjF8oa+uXKqjf4+EZUuek5
	8w81IuwRZIM3kXp87aKRoANi1hfwwGoGQ4csb/m5AqTrzZclkwpU0poLjpX1x6Ax1rKm/GS
	amRNKtvgPlga3JrRpyicUJYUkVMOqZhYsP8gdh0l3viOf4LRx6NTLT4ruhQ5iUxbX99+YAP
	fPWRkv96cyNm/Gu2htz97bNtuBDSt4ZdyOpWjOacqcpkBG3M3aqtqAW262wRSu7I7N4yshq
	A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

smk_write_net6addr() builds the partial-word mask as (1 << m) - 1,
which keeps the low m bits instead of the high m bits (e.g. /33
yields 0x0001 instead of 0x8000), and stores it without htons()
while the address words are in network byte order. Any prefix with
mask % 16 != 0 is truncated to the wrong network and mislabeled.

Take the high m bits and convert to network byte order, matching
how newname words are stored with htons().

Fixes: 21abb1ec414c ("Smack: IPv6 host labeling")
Signed-off-by: Hongjian Dai <daihongjian@kylinsec.com.cn>
---
Link: https://lore.kernel.org/linux-security-module/A82C90B4956EE3A9+20260922144738.9594-1-daihongjian@kylinsec.com.cn/
v2: Added missing Signed-off-by tag (as requested by Casey).
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
2.53.0

