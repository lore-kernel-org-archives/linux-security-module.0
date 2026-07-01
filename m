Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97E481FDD;
	Wed,  1 Jul 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909360; cv=none; b=pkhb5TnQh3Al4C5iIWsE2PKWxBw87WE6F4JtKySQSYWuXNz5UlcG//gplUvt99dkja97quwsao5Y5UfsyzbHYjarCLISkHKnICWKCYsZKjp+a3T0+39RzdX32OFw5Gc1QZawQX2O/P6wQEfdGdQ5ez0PD5M/FPnB6B/43TKOMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909360; c=relaxed/simple;
	bh=culmhxhBfvXrBVyEz+8H3ylnLiqx+LscdrkE//7k6QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8eY9KTdQARTbJgNyg4oIZ78vKz2OChJ0MyGXHGoK9KvBzET/ttqJPzyOA+FLsYZVpjGtJmnsYZ2hWLzHR1PzGFs2+/HpUtz96AVXu8vRu3jR5qFa25f/T/8xo6zLZasgMCjBPH6WEwLqAariZ0eWOY4C0oezwF0onhx3u9AYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64203ab2754911f1aa26b74ffac11d73-20260701
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c6a89f45-1fe7-4d07-8700-11bc02364979,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:c6a89f45-1fe7-4d07-8700-11bc02364979,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:03b8158711f4bc889e1957fab6181341,BulkI
	D:260701203551SC3TKUDB,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|136|850|865|898|915,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0
	,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 64203ab2754911f1aa26b74ffac11d73-20260701
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1968431467; Wed, 01 Jul 2026 20:35:49 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH 5/6] selftests/landlock: fix spelling error in fs_test comment
Date: Wed,  1 Jul 2026 20:35:19 +0800
Message-Id: <20260701123520.271580-6-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701123520.271580-1-wangyan01@kylinos.cn>
References: <20260701123520.271580-1-wangyan01@kylinos.cn>
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

