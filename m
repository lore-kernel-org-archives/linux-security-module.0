Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697238;
	b=CPRK+eeapOHgueVX0OXwQW9Qmdn5DRKrbPTCQ/1RqTgmQmRYu6oSL1Dl5fblp11t7imb
	 8cFbsR0TC74uWDTbkFcwOtZVm4L8QbKl2t1rBYm03Vv50tVx8Ul1JHp4W+tIHgxr3srC3
	 T8ZdZnnpbnV3cHbCnREVc+spWiGEPSadmpakPaGXni6EAkwiaOsU8joDGTgKRgYKWy7FY
	 F3uA3xKXEY2oheuhMeiQtjkSHuCMqDJQWRlEYLwut4RJTnM0W1tdJQbbzEy5JCEhlzGMS
	 FC6y8a+PMSLOcaR0PhF6zRuCXeX1DxGnNYrIJR58fnfrj4cdSQq7w3+4LFLZ5YAyiiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697238;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=3LHITGddRlTiLA40cOh8vcQ7HHK7Q/74L0rv/A6ls8M=;
	b=hy9xg/lABCjTx9RTvMQTDHSGTsdobIDkYQELRZqGYgmK0/5iX+nsVG/vqSN3Tqvkeldb
	 sEk7scntbssJH29Ti9XNC2OTT/Bsym4sCtTlSCmM203XLC51SKsCMMZ8bB/isDWNx+wu4
	 B1JOpSIERmfXu7/YJfMvjVC2Gn7p1JAhssvMmtLxFaobsH+iUHKCPs2LROTHNcZ8tyDV3
	 P1kvv+9XBj4oyjKA4NzG4JJEJLHrzdePiv7HRHIQ8MhIabe2P+IC9P+Mn8K3WP2TY/5su
	 8uagjVTl8DInUHhMjN1L6h1c/rm4v38gDb9C79zFPhbYINQKOkC8Qx45uyS1PQkn8sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I2c2hEPq;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FD606A31E;
	Thu, 26 Nov 2026 12:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C32FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I2c2hEPq
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3LHITGddRlTiLA40cOh8vcQ7HHK7Q/74L0rv/A6ls8M=;
	b=I2c2hEPqAnZdTU+weMelCVdBZFbZOCYTQY5owdIc1I6aXJEYW0plPrkHIoVwRHT/p/65Rn407
	FIEs4J44YWv4FYWad9BtQDVec68xSamoympPRw2qpzMoTKRVY7gpo4qxUfvS5cIcokeS6Jwuxf/
	KekP7YxgsDCDGJ6revtEptA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jZxBk4yrMz1K96p;
	Thu, 26 Nov 2026 20:46:54 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E8B64055B;
	Thu, 26 Nov 2026 20:47:13 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:12 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 1/8] lockdown: Add break in lockdown_write
Date: Thu, 26 Nov 2026 21:13:08 +0800
Message-ID: <20261126131315.1256553-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261126131315.1256553-1-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100010.china.huawei.com (7.152.184.41)

After the label is matched successfully, no other iteration can match,
so comparing the state against the remaining levels is meaningless.
Leave the loop as soon as the level is matched.

The level labels are distinct, so at most one iteration can match and
the behaviour is unchanged.

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

