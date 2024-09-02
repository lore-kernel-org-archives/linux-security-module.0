Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780D74BE1
	for <linux-security-module@vger.kernel.org>; Mon,  2 Sep 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262251; cv=none; b=hJ9NtxIg7ejLOuG7OLSvxsoRUldNTwSMSM2AbnIuzyXnbmIvtjqNMORZZ3ZpSD3SB6/thAEXNEWgnxnwD5iUGZjPqXcNnQHMyHbg3tcrLTiLc0ksJdUc52aMfmuEfQuXWwtan1JOC7dERvRkbl0VJI+5/T7lB1WrBtC5oh3w7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262251; c=relaxed/simple;
	bh=JfKemli49xl58iE4BfIaZoN4UDHDD3vhAYj+3EgatNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtbOwCVbbi7Re1bdDz3QXm4oLpp6i8xERecHiGD4WW0Qb0zNLMlZHD0El0zhUuaOZdlkksnLn6CX62OGbgNp6xK7UcBAXpYzU7myb684Zk05jsz+M7NXQfc4RAc3zGMu9JAL3AncqmSKTw3sioNNNmwTYzBTkms5EXYElm946K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy0jv4LP3zpVJg;
	Mon,  2 Sep 2024 15:28:51 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 06250140120;
	Mon,  2 Sep 2024 15:30:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 15:30:40 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <ruanjinjie@huawei.com>, <apparmor@lists.ubuntu.com>,
	<linux-security-module@vger.kernel.org>
Subject: [PATCH -next] apparmor: Remove unused parameter L1 in macro next_comb
Date: Mon, 2 Sep 2024 15:39:04 +0800
Message-ID: <20240902073904.3520301-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

In the macro definition of next_comb(), a parameter L1 is accepted,
but it is not used. Hence, it should be removed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 security/apparmor/include/label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 2a72e6b17d68..2635eef0ae2b 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -160,7 +160,7 @@ int aa_label_next_confined(struct aa_label *l, int i);
 #define label_for_each_cont(I, L, P)					\
 	for (++((I).i); ((P) = (L)->vec[(I).i]); ++((I).i))
 
-#define next_comb(I, L1, L2)						\
+#define next_comb(I, L2)						\
 do {									\
 	(I).j++;							\
 	if ((I).j >= (L2)->size) {					\
@@ -174,7 +174,7 @@ do {									\
 #define label_for_each_comb(I, L1, L2, P1, P2)				\
 for ((I).i = (I).j = 0;							\
 	((P1) = (L1)->vec[(I).i]) && ((P2) = (L2)->vec[(I).j]);		\
-	(I) = next_comb(I, L1, L2))
+	(I) = next_comb(I, L2))
 
 #define fn_for_each_comb(L1, L2, P1, P2, FN)				\
 ({									\
-- 
2.34.1

