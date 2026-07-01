Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441773BA222;
	Wed,  1 Jul 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909347; cv=none; b=o+nVtmBZRrI2BnMC6eSQdS7cJxPox9VA1Pt3fnca0MTYVgfaffquQACWQIGJJRqgohA432MsNqsKYbtIITFhOpavt0bYnlRAwnUkHqw/Gkx8BVEOB0hF+A4RPknGSC3Eeax3UfdVKJA38R7kvEWj138J86bYogBplj/jaLAGeEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909347; c=relaxed/simple;
	bh=7wkkm5Vf1AZ5zmbpqEBH+vhLIzlUzBmVr1WRGb7YfAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVoubQ6l99jQex3Ue8jx+h4JsVPLOfZ5+HfsgKKeQgKGvyiIKZvmOEuHwEThH64+8cc9LCBKMuzM1WW9TDTpJ2lAvzUwKqh+mc7sCtRDI3XjMhF3MJRI2llrO/IlcCcr/RFjTG0QutPFYw+Oa9eAIf1KA+dGHurBdvzMjG8xVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b2122aa754911f1aa26b74ffac11d73-20260701
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f02bb558-4bb4-4503-8bba-78eb31165a38,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:f02bb558-4bb4-4503-8bba-78eb31165a38,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:483eb501f7acfca01744a0490e5e62c0,BulkI
	D:26070120353655UNQ1E4,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	136|850|865|898|915,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b2122aa754911f1aa26b74ffac11d73-20260701
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2090762414; Wed, 01 Jul 2026 20:35:34 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH 0/6] selftests: fix multiple spelling errors across submodules
Date: Wed,  1 Jul 2026 20:35:14 +0800
Message-Id: <20260701123520.271580-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes trivial spelling typos in comments across multiple
selftests subdirectories. All changes are pure comment fixes, no
functional or logical change to any test logic.

Changes are split by subsystem for easier review and merging.

Please review.

Wang Yan (6):
  selftests/arm64: fix spelling errors in comments
  selftests/filesystems: fix spelling error in statmount test comment
  selftests/ftrace: fix spelling error in poll test comment
  selftests/kvm/x86: fix spelling error in xapic_ipi_test comment
  selftests/landlock: fix spelling error in fs_test comment
  selftests/powerpc/tm: fix spelling errors in comments

 tools/testing/selftests/arm64/gcs/libc-gcs.c                   | 2 +-
 tools/testing/selftests/arm64/pauth/pac.c                      | 2 +-
 tools/testing/selftests/filesystems/statmount/statmount_test.c | 2 +-
 tools/testing/selftests/ftrace/poll.c                          | 2 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c               | 2 +-
 tools/testing/selftests/landlock/fs_test.c                     | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c        | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c           | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c                    | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.25.1

