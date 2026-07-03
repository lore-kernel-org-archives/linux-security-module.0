Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86222652D;
	Fri,  3 Jul 2026 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047201; cv=none; b=e5gG3QgfOGQQwXtKus4rDUHnJOE0voHikAuZDKxev/0eXNIZqtEWkpbaCfGXY3QXZDHicVPLpb/DzciThRPNrq3bykcOYOYj+xEwRmimb8L99AR3DGJCzA9QbKfo+GISFIrBKzLxT8xY5HlAYfun5onXKko2wocxv812UaAGsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047201; c=relaxed/simple;
	bh=G/8EFE8SdhjI0Args3IgNLWZyySAYBz0qOcz01IX9iE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ec0PkKCjUOOqZ62eXliWVrykNQiRRpptGqgEW+Q7onXoTt3GskWR9Xv4oKrhw3Gq+ZI5cYR1I+D+MJoR9UeWaZe2VHvt1bEcHTl7M9/8j+FAgVYU5yuDZ1zkmkZe299vRUZx/1LhQaQ5z21zgRkC4EUoie4cbFs+Dzfmoo1GaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 54aec8f4768a11f1aa26b74ffac11d73-20260703
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:77c21a8a-c6b8-481f-a093-ffa8ceb18592,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:77c21a8a-c6b8-481f-a093-ffa8ceb18592,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:ad4301a87f02710f12a5b795d31ae021,BulkI
	D:26070310505284HWJYM9,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898|915,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 54aec8f4768a11f1aa26b74ffac11d73-20260703
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 174164620; Fri, 03 Jul 2026 10:53:12 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	casey@schaufler-ca.com,
	mic@digikod.net,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH] selftests/lsm: Fix memory leak in attr_lsm_count
Date: Fri,  3 Jul 2026 10:52:47 +0800
Message-Id: <20260703025247.940055-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
 tools/testing/selftests/lsm/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
index 9ad258912646..4fa8310750a0 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -76,6 +76,7 @@ int attr_lsm_count(void)
 		return 0;
 
 	if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
+		free(names);
 		return 0;
 
 	if (strstr(names, "selinux"))
@@ -85,5 +86,6 @@ int attr_lsm_count(void)
 	if (strstr(names, "apparmor"))
 		count++;
 
+	free(names);
 	return count;
 }
-- 
2.25.1

