Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEB2D2394;
	Thu,  2 Jul 2026 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957523; cv=none; b=mEA1VePTwkNS8r8BJ2abbhE/adEYcRbFL2/VBLKG+NtxmWAwQA02FTeCR5mJqeota4ciYErFHJyX9ZVz2+9p3e3ierB6uUqal3XEQB6UHp1+QkjXUk+HtYrrK4Q1XqFJaYY1GC7S1MjBNe4aKhHXcKPgr1fE99oB0HzYIoRACUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957523; c=relaxed/simple;
	bh=culmhxhBfvXrBVyEz+8H3ylnLiqx+LscdrkE//7k6QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hnT7iyk0ZPanBmvsN2WAFsOF4bCjJoOaiTC68kUtsVflL3O5f6QBOdQAGQxhaQBjQKkvnISA1mTZ4nhaQzxNsmiU0uHZs6FsmNkTMX7nf6H8IJxwii5a1gLrzP33SdOLb9yeSDCFQExJONwaba91RaKKQUdBFK8jc4ljWfIYTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 89ec5ee075b911f1aa26b74ffac11d73-20260702
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9c12da54-7101-4f7b-8b91-727cd5d9a0fc,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:9c12da54-7101-4f7b-8b91-727cd5d9a0fc,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:6ed38ecfe38b3a7d440884c5907a4339,BulkI
	D:260701203551SC3TKUDB,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	136|850|865|898|915,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 89ec5ee075b911f1aa26b74ffac11d73-20260702
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2051383712; Thu, 02 Jul 2026 09:58:36 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: mic@digikod.net,
	gnoack@google.com,
	shuah@kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH v2] selftests/landlock: fix spelling error in fs_test comment
Date: Thu,  2 Jul 2026 09:58:23 +0800
Message-Id: <20260702015823.368529-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "allowes" -> "allows" in Landlock filesystem test comment.

Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 86e08aa6e0a7..e672089e9329 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6927,7 +6927,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
-	/* Only allowes access to the merge hierarchy. */
+	/* Only allows access to the merge hierarchy. */
 	enforce_fs(_metadata, ACCESS_RW, layer5_merge_only);
 
 	/* Checks new accesses on lower layer. */
-- 
2.25.1

