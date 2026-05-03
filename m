Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46391DED5B;
	Sun,  3 May 2026 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777781586; cv=none; b=hwbNsr6Cqu9s0g6k7meaua7uk63pKZFrnPlqAf4ET653mi83byw/yJ9pOUyYS24sU7TxFr6HQU5zbfGGVBmUWepbSc/KjT7XNimc2eIAyQj9SzZlYHxOGbC8sL1fmRh6dYktdBfeQROtjpK5QymRJGQu5pSLEjz8jc6Bo1JmJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777781586; c=relaxed/simple;
	bh=6eLHlSkkW2sMwUlUSa6If4P4Nabamj9aF1mi46zGPSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXsYm3FwLGb7BVpmYSvuPvLudUBkHW9cBHosMiSWsAoOnXJB6pWuioYUC/phRfORJyEKySMEGrbaywIdmEDu39lv6wseCBn/aTo8AVlcwyVlqMPNafIweywmSFG/BBh6KycKauRrGdcKUCzdAWd0DQtsz7XOgdB9FPNvp5bgzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 57b5430c46a611f1aa26b74ffac11d73-20260503
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c5f66148-d86c-47a3-abc2-9e22791a93fa,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-25
X-CID-INFO: VERSION:1.3.12,REQID:c5f66148-d86c-47a3-abc2-9e22791a93fa,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:d5eb26756dd2cbda9f9ac99edf304a76,BulkI
	D:260503121250KGD6EFPG,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898|915,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 57b5430c46a611f1aa26b74ffac11d73-20260503
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 983381295; Sun, 03 May 2026 12:12:47 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	neil@brown.name,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH 1/3] apparmor: Fix return in ns_mkdir_op
Date: Sun,  3 May 2026 12:12:43 +0800
Message-Id: <20260503041243.200895-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return NULL instead of passing to ERR_PTR while error is zero.
  Fixes smatch warning:
    - security/apparmor/apparmorfs.c:1846 ns_mkdir_op() warn:
      passing zero to 'ERR_PTR'

Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 security/apparmor/apparmorfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index ededaf46f3ca..1d7b1c70f22a 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1922,7 +1922,7 @@ static struct dentry *ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_unlock(&parent->lock);
 	aa_put_ns(parent);
 
-	return ERR_PTR(error);
+	return error ? ERR_PTR(error) : NULL;
 }
 
 static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
-- 
2.25.1

