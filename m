Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B58383A1;
	Wed, 14 Aug 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606373; cv=none; b=Pe0Ab1CNZNSlfPAM25K1sRtbZ4InTZcZkqxi+gxqcrWUlEfbMfecbMwhkKZhSqPePFlGpj+zQfdOQ3gaXKbUQc/vEALKdB51BDJk38kab5voFlPFRVLPmwxz/G3eAhe2rr3anqdJVbSwLKZeE5OA3cLudrllXHhl3JZsac0fcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606373; c=relaxed/simple;
	bh=Lia4Kv2kecsf1cNt3ZjZldSU6RpnWmqSZ7NCHhPeP4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ug0aEttUAxLazJSgdVf8h0Mte58Cu8Nt52IhBuaik9CwtkMzlhxi/ZkeyJJa34dqI7rTgLSwft7Ax06lgXJ/snL3OQCzyZvgerZ4CjP45RJmRxNL1thnU85mkEswUXeFt700J0KeE1z6IK1VH0bxpxWpXzDluc0xRbzViybOWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkDLl1rQfzndxL;
	Wed, 14 Aug 2024 11:31:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A118180105;
	Wed, 14 Aug 2024 11:32:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Aug
 2024 11:32:47 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<kees@kernel.org>, <casey@schaufler-ca.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] lockdown: Make lockdown_lsmid static
Date: Wed, 14 Aug 2024 11:30:04 +0800
Message-ID: <20240814033004.2216000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Fix sparse warning:

security/lockdown/lockdown.c:79:21: warning:
 symbol 'lockdown_lsmid' was not declared. Should it be static?

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cd84d8ea1dfb..f2bdbd55aa2b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -76,7 +76,7 @@ static struct security_hook_list lockdown_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
-const struct lsm_id lockdown_lsmid = {
+static const struct lsm_id lockdown_lsmid = {
 	.name = "lockdown",
 	.id = LSM_ID_LOCKDOWN,
 };
-- 
2.34.1

