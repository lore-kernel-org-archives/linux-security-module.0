Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB122FA0C7;
	Fri,  3 Apr 2026 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187427; cv=none; b=MR89sylI630UpgTUi8f3qANhrAdED2QnDJ/APFRVD6ZEGY8Obnn9qVWabdlr+fx1mvMONz0nxlVk0UGkuCI4S7jcC1f3aNRZ3vjM8n+VXIOdvRBYJJQZ6gGyDAjP1/MSyRir669EosogMgr6GLVVBcHN3XPnnmeoijd+c3YIfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187427; c=relaxed/simple;
	bh=LHb74TegHLOMVBqa0tdVMyBoJKwfPDli45/VnkxSxoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JU9sB4pzjWIYjKw7kZ2+tUVcX1+l0IPo6pwCGU9UcL5Dw5exf7fGtrbKNQiTuZBJA3Zyex8fP7Cmwkc7KNr4ET+Nponht0eOECDXckor1ZKV8d15469MZszASOUYZvebkUgXjs+NZc9QsEaLUHC5+TX94mWi4zOEv2vrLo0m3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tRwCfA7F; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tRwCfA7F"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wOVp4eov60EWNuICi4DIGcfBecJjzeAODZJh0cY7OCs=;
	b=tRwCfA7F0raCaUeV8sh/y1pn1hw7S1ldQTQzrFLq9WAaZ4kcuXOx+3v8qiCRJpLtVhYp//vUW
	0vT9AesSPAzXvvffSUVyBr3Hf6X+FmIaW+K5b8mDx5kkvoEYJG/IbYobwO6cqpVFI3/I8DUMhra
	2rrmIbdzo/SZX0qDmqUEvCo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fn44T4mVWzKmVj;
	Fri,  3 Apr 2026 11:30:49 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 634FB4056C;
	Fri,  3 Apr 2026 11:37:02 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 3 Apr
 2026 11:37:01 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: John Johansen <john.johansen@canonical.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>,
	<gongruiqi1@huawei.com>
Subject: [PATCH] apparmor: Fix two bugs of aa_setup_dfa_engine's fail handling
Date: Fri, 3 Apr 2026 11:51:19 +0800
Message-ID: <20260403035119.2132418-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100018.china.huawei.com (7.202.194.66)

First, aa_dfa_unpack returns ERR_PTR not NULL when it fails, but
aa_put_dfa only checks NULL for its input, which would cause invalid
memory access in aa_put_dfa. Set nulldfa to NULL explicitly to fix that.

Second, aa_put_pdb calls aa_pdb_free_kref -> aa_free_pdb -> aa_put_dfa,
i.e.  it will free nullpdb->dfa. But there's another aa_put_dfa(nulldfa)
after aa_put_pdb(nullpdb), which would cause double free. Remove that
redundant aa_put_dfa to fix that.

Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..be82ec1b9fd9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2465,6 +2465,7 @@ static int __init aa_setup_dfa_engine(void)
 			    TO_ACCEPT2_FLAG(YYTD_DATA32));
 	if (IS_ERR(nulldfa)) {
 		error = PTR_ERR(nulldfa);
+		nulldfa = NULL;
 		goto fail;
 	}
 	nullpdb->dfa = aa_get_dfa(nulldfa);
@@ -2486,7 +2487,6 @@ static int __init aa_setup_dfa_engine(void)
 
 fail:
 	aa_put_pdb(nullpdb);
-	aa_put_dfa(nulldfa);
 	nullpdb = NULL;
 	nulldfa = NULL;
 	stacksplitdfa = NULL;
-- 
2.43.0

