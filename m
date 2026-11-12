Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.110.109.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505094;
	b=2HCDHh7I1gvLTCWkhGfD5Hc0/vCICAr9bq3YkEXeQeGgLYKiEGbtiXbFFYuRuLmpshEg
	 3Dsc6S7Koxt0ZkyFGSR5LoJQy40NWeaFbl3vArdRKmmRjz53Ht1JzFvyayYSCngeu2uc7
	 kMnoDQr6IIWLpORD01HGI2+LPpTk/u8ewJuYAphgMZSbvBq0k6nJN3t4OBPQQytXYLcm2
	 MpS/XoiS/h9dts/bVbpE9eYIuaL79HsELwLVetuZ7YkRZFIgc52+n/N2I5Kml+dGfnQPY
	 BAD7DGubr2WbkdoYxWBbJLQHVDzvkC4Kx3OPceU+6rOiP5iDLC3q6bl5Zgja65KpoJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505094;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pRtBn+7pjGYKzgD5cF7fJ2I/G6Pu/pr0vQaRgejNTy4=;
	b=XIHvocvS0l/jj8MKhsBQr7rip21tzyQGzrKaA9XEHCfe04GVivnbpjtAG0udkr6wUdm1
	 4HfiwDQWw4qXQM4Vjf1yxhSt+osxWJp95f5RqCFE3rgn+khs4NPIxxEtsJmWF7U3+NbOF
	 EmVU0v0MnvdiPe0MXJHO/qc0bvkXarRZengmLU/7g/OwXmlKDbGZqkWKDnU32qagnvhdq
	 FTt3bnT2CGnaNlle9wr8AoQRHlmJBJIJHVqYlgRfbRSqnooYK6PeEvgce4O1CiMokdRRO
	 zoeoagRFP2jjMtYm2WXAbgWQPEqJzomLxvPiO3XNS6DZ4fLyrMFLf/iZFMUGRrsvncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tkos.co.il;
	spf=pass smtp.mailfrom=tkos.co.il;
	dkim=pass header.d=tkos.co.il header.i=@tkos.co.il header.a=rsa-sha256 header.s=default header.b="n/HeRCG4";
	arc=none smtp.remote-ip=84.110.109.230
Received: from mail.tkos.co.il (unknown [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC58606CFC7
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 17:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC58606CFC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tkos.co.il header.i=@tkos.co.il header.a=rsa-sha256 header.s=default header.b=n/HeRCG4
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id F1D52440F96;
	Thu, 12 Nov 2026 19:36:11 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1794504972;
	bh=np2PnzP0GVtoi2eIe/Gk2P5uCVPb1z3VghJmR+E/n9U=;
	h=From:To:Cc:Subject:Date:From;
	b=n/HeRCG4zFwDppRLPdeY/zWVZZSmOCWoCaXv6Yn1o4ZUFp1THWvwusqWSVLtm+hlR
	 xOozWhnlM4BRtCjKvOI3ak2Kbf02svh1k1Sg3I2OAKeSWIssRiZft6/VjdYQTf2QQU
	 66jpAj4wWWGP9EDNpKc+902AaVq8KleutUi9h0/FIFVL5AaV4B3Zo2rfQ6jTiOAaFy
	 KAwyt8TSL5IO7AaWwUvIhJp8LPhvcHwGOvbUfjyLExC9lrSNx36YcmD+LqGvcZmosa
	 0msGsCjXoowIZ76lx1ibJBPcCwTpTtJvJopx65E7rYR40u6oAyHTZ5zGB42E3WHxMa
	 Gbua1JpkZg0Pw==
From: Baruch Siach <baruch@tkos.co.il>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] security: update lockdown_reasons[] reference
Date: Thu, 12 Nov 2026 19:37:57 +0200
Message-ID: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
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

Commit 59438b46471ae6 ("security,lockdown,selinux: implement SELinux
lockdown") moved lockdown_reasons[] from security/lockdown/lockdown.c to
security/security.c. Update the documentation comment to match.

Fixes: 59438b46471ae6 ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 include/linux/security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab5470..2782ee404f95 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -124,7 +124,7 @@ enum lsm_integrity_type {
  * so.
  *
  * If you add to this, remember to extend lockdown_reasons in
- * security/lockdown/lockdown.c.
+ * security/security.c.
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
-- 
2.53.0

