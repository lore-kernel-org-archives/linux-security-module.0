Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33743CF1F5;
	Fri,  3 Jul 2026 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080630; cv=none; b=AJ29a9xG5eJEY/0HCIl6aQ+ZqOjoR3MZUSXclR80QDtnBPuLNJvd/ZvCSOQm3xcYklzu8JVU4tYnItt3FPCo+3JV92o/T7bh4hFilCYgvM9/tmtZph5GYZv+K10o0fs1EqWN/TQwnUFNXXMye1gKdFb8ehmBBrYbJTk4ZOK5MEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080630; c=relaxed/simple;
	bh=oy17HZPdJNlh+5IeYqa3gikbqHqLbJ2RB3av78le6ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DujNb+OGRtJZn2DaB3cC50f1PLiGtODt+7AmneKfTLrPkyY+9YsB4LvJ+CUNEuAH9mjZlk0PxRc3pIq4UbFRw89S5ohFvksCIYYyI58rv9p8M5zJpf9cPpKdymVPVpQ44CFiMDRx9OF44vNpTsm1AXvIyQW4hxV7rLZex+AWR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2846491a76d811f1aa26b74ffac11d73-20260703
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9201fb13-3fb1-43b3-8e79-67ad92ea33c9,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:9201fb13-3fb1-43b3-8e79-67ad92ea33c9,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:29aae46b6e7b057768350e6a0fb91eaf,BulkI
	D:260703151457A2XKY1N7,BulkQuantity:2,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|850|865|898|915,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2846491a76d811f1aa26b74ffac11d73-20260703
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 921031607; Fri, 03 Jul 2026 20:10:18 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: bill.c.roberts@gmail.com
Cc: casey@schaufler-ca.com,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	paul@paul-moore.com,
	serge@hallyn.com,
	shuah@kernel.org,
	wangyan01@kylinos.cn
Subject: [PATCH v2] selftests/lsm: Fix memory leak in attr_lsm_count
Date: Fri,  3 Jul 2026 20:09:51 +0800
Message-Id: <20260703120951.1622491-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAFftDdrDgoHCopx9byaupea8GB6P=qSAY==6QQoXSJcJgn_04w@mail.gmail.com>
References: <CAFftDdrDgoHCopx9byaupea8GB6P=qSAY==6QQoXSJcJgn_04w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calloc-allocated buffer in attr_lsm_count() is never released on
any exit path, including both the normal return path and the early
return when read_sysfs_lsms fails, resulting in a heap memory leak.

Add free() for the buffer on all return branches to fix the leak.

Fixes: d3d929a8b0cd ("LSM: selftests for Linux Security Module syscalls")
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/lsm/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
index 9ad258912646..927dce4f04cb 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -76,7 +76,7 @@ int attr_lsm_count(void)
 		return 0;
 
 	if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
-		return 0;
+		goto out;
 
 	if (strstr(names, "selinux"))
 		count++;
@@ -85,5 +85,7 @@ int attr_lsm_count(void)
 	if (strstr(names, "apparmor"))
 		count++;
 
+out:
+	free(names);
 	return count;
 }
-- 
2.25.1

