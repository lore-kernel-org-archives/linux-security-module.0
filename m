Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315356;
	b=lHEdGNVzETwMtIK2IlxZalivs56ruEG6aq23aQaElgGODj3RkIEIdAx8pJdR69mY1IS3
	 NQmFrXBLUsIZ/RehHa2Hl49v0ZzY1MiD09z1OEmhQt70NnWLrj344ec25Jlo3EMjPMAaT
	 /M1TR8eqgPfDsSGTQSEhjHKHkq63ymTN4n7YLGJWlR0JOkuxwTFxhfdJmtkpMGKPytA28
	 gODFSxPE0TkCniSuEWov4DxDk+9T6zrPrggZp21Te9M/7+9wjU/4KBLAyJ/HzupdNZDcu
	 6plO6gnbpJ70aJhL1himU4LQ3+dTq3btsltrTFxeOaOes9xkn0aLLmtsbQ5IXDpWWmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315356;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=TebaHDOnvqGDEokgRq+1L6bEUOTWP5a/DEIL9I18Csw=;
	b=Zou9vaZP4mg3aS/4sZDYKAT9j1Nlxu1+g7kB/uv3VX37XOJoX6fVXyL1l1veFMGccO5V
	 LZ5I9xWIGq+o6UP5zm0DL8+VHbU4R1aWVpdMugDsx/02X3+DUj3QhdI/GA44+ZPg7zfJp
	 P5dJc4FvYNPxswtg6CjuJ2Kb2V/RlYWopE2A4Jd4aUPAhBEOBBX776onpCkoWK5CmlnID
	 2ZyH+W46WtW7CbAtISfXaf55hce29bKDhY6GrUBlMk9OoKrpzKKXL1Ve5a4rQPPggorK4
	 fzNwlJ8IQO0y0yn3NdmJ9C9VWzlb4BLIf/dJZd+Tf24zOpFtc/8hYIM668PwpODma9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QI+HDJ7a;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7E60A2612;
	Tue, 10 Nov 2026 12:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEF7E60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QI+HDJ7a
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TebaHDOnvqGDEokgRq+1L6bEUOTWP5a/DEIL9I18Csw=;
	b=QI+HDJ7aYe8MfkCuKU7dL0yAZWuoB3bd+VDsT3gwYFTrsb1hr0Ak2GGm/2Z6sOlQpEj5dAjwC
	cId1TF3zeh0ixUSq0abtvLa21nW0CfqfPxdhz33HmksBh+4BEDjl0JhHFhOJfM/aVOLBEKsblB5
	VKzoMwEuXC7338Pwxfrh4PQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jP67j6H03zcZyY;
	Tue, 10 Nov 2026 20:55:13 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id EA5CF4057F;
	Tue, 10 Nov 2026 20:55:51 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:50 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 1/8] lockdown: Add break in lockdown_write
Date: Tue, 10 Nov 2026 21:28:11 +0800
Message-ID: <20261110132818.2231593-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261110132818.2231593-1-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100010.china.huawei.com (7.152.184.41)

After the label is matched successful, any other levels judgements
are meaningless. Therefore, add break to return early

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lockdown/lockdown.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8d46886d2cca..263dcc80d839 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -139,8 +139,10 @@ static ssize_t lockdown_write(struct file *file, const char __user *buf,
 		enum lockdown_reason level = lockdown_levels[i];
 		const char *label = lockdown_reasons[level];
 
-		if (label && !strcmp(state, label))
+		if (label && !strcmp(state, label)) {
 			err = lock_kernel_down("securityfs", level);
+			break;
+		}
 	}
 
 	kfree(state);
-- 
2.18.0.huawei.25

