Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2E284B37;
	Fri, 26 Jun 2026 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457235; cv=none; b=lUaol41y4LcbVhqPPdXHSNea1pw7YrQ4MQSNARFuPTri3/GIKggKj7EDOtIgx8vb32t2gar38Ypn3LE+ukYi7eLm1unSuPwsQOADSCqBdAjiGAZ4arXRkOJG0zeZHDIE3mR2bKcD46LP6W/uzLGf91LwndxeMPhDpkf6F0dgVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457235; c=relaxed/simple;
	bh=c8RXj0I2/e3WFVbhYVrruUZugBFuE/lKMbhdYAeacIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glYiN6sJWL3NDpcn9R2F93xf1phWl7WwTSXbEHjI5Y1ZvhhiKzNBFNldldYboNgZsinGSD4j3cexEw4uotwQVhVKVnPRdB+4qxZhp8oZ0hM8oURKGPlRArl8BRC/DPYCinbkXCD7bsTCa0BV8Lhqfsh1VY4KFXAhcg/IFoUuYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2c87434712c11f1aa26b74ffac11d73-20260626
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a54ae16f-c33a-46cf-bf5f-7487c510c1d7,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a54ae16f-c33a-46cf-bf5f-7487c510c1d7,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:952585c279831a707051a69ca8c92066,BulkI
	D:260626145735GM795IA3,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|865|898|915,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b2c87434712c11f1aa26b74ffac11d73-20260626
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(39.144.194.184)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2623302; Fri, 26 Jun 2026 15:00:21 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: mic@digikod.net,
	gnoack@google.com,
	shuah@kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] selftests/landlock: Fix snprintf truncation checks in test files
Date: Fri, 26 Jun 2026 15:00:16 +0800
Message-Id: <20260626070016.61049-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b566f7a4f0e4 ("selftests/landlock: Fix snprintf truncation checks
in audit helpers") fixed the truncation detection in audit.h by changing
the comparison from ">" to ">=" to correctly handle the edge case where
snprintf returns a value equal to the buffer size.

However, the same pattern exists in ptrace_test.c, audit_test.c, and
net_test.c and was not fixed.  snprintf() returns the number of characters
that would have been written, excluding the terminating NUL byte.  When
the output is truncated, this return value equals or exceeds the buffer
size. The existing ">" check therefore fails to detect truncation when
the return value equals the buffer size.

Fix these remaining instances to use ">=" for truncation detection,
matching the fix in audit.h.

Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/landlock/audit_test.c  | 2 +-
 tools/testing/selftests/landlock/net_test.c    | 4 ++--
 tools/testing/selftests/landlock/ptrace_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 72b5612375dd..4bea8c880a4d 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -31,7 +31,7 @@ static int matches_log_signal(struct __test_metadata *const _metadata,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, opid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2ed1f76b7a8b..aebeafd80466 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2777,7 +2777,7 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
 		log_match_len = snprintf(log_match, sizeof(log_match),
 					 log_with_addrport_tmpl, blockers,
 					 dir_addr, addr, dir_port, port);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
@@ -3072,7 +3072,7 @@ static int matches_log_connect_bound(int audit_fd, const char *const blockers,
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
 				 blockers, addr, lport, addr, dport);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4f64c90583cd..65cf2d82f721 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -302,7 +302,7 @@ static int matches_log_ptrace(struct __test_metadata *const _metadata,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, opid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
-- 
2.25.1

