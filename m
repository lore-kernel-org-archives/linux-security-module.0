Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315363;
	b=gGzU9+MdAW1CezOjsS4AJSptcHeE9+Ew0b7/kDsY98EQG8QPQbsu7PbwHzFmqgdkWCtT
	 4VTavp1ZSqcz8mMoEStceH1tElL84kJygFbKQ0gwHKM0DVGaPXBWP54kts9vfb57f74oj
	 rgyOK7ZJda+7G+IvU1aFsLzBrPkljrSaBQ8uXH/FjAybmc32g3dwc8chSn9+NhHw/23fW
	 oI2Y8NOIzCT1EhT+v1PwfGtm4bVAbf90dj92C7PG4t5BWhLz4CVA39dyyXD/BRK52Q6si
	 tReEnWLlFvfoGohPiOCwhuM8xVKzxro72zNgr2Ex3YBCH7Dt9a18izLnrtHpa9EYHDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315363;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=Q8UW5TU7NVubhK+JyaRu9e+ysRCGW/oCEMpuGGYgmDA=;
	b=kL3SQ9oi97Q7ekjycmqsSo51KWDFjK/HFTX/w9Pvl5AIVey3BWN+UqVrRAGdlmUSrX0r
	 /gnZOEnKI4QPCtnRf1I5zPcPoGRXTFKON4rvs8lMtUfl2gbd8ark5C8p5McXavTGuDbhM
	 yo+OD8N2o5kCaqElMPV5GOUsLwKwxM/srYLOl88wQGNCZjZ2WG5xGol9FaEOByPN7hZV9
	 AVpkwqN4lQ5gZD+rPyz8zIDt82cySuLGTwArF2qY8pGIAvpqig3+2zI9dV8QEp5gQy0b9
	 FLQxpWjwY3PLcOpX9xXzQx8E0GDdH4PQNIxx8UoK1Q7yOnVbdQJZ80kDnq80UXYOe6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G8d2BMoJ;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593860A380B;
	Tue, 10 Nov 2026 12:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6593860A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G8d2BMoJ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q8UW5TU7NVubhK+JyaRu9e+ysRCGW/oCEMpuGGYgmDA=;
	b=G8d2BMoJARzwHIqn/mmD4UnvadIUz9Br0GTmlUyrUns8CUaEtXKceTVHklepkFKUEA1V1P8MG
	pQzWCdBhJlhBk6OERVXmSRx7iws8QiznJs6/EoMCAsq1VBTQ63LeRhw95L7EoTmi6ovo2FIBPzY
	h1thFkL6bes1JtEK+H657Zk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jP68B06sSz1cyRv;
	Tue, 10 Nov 2026 20:55:38 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id EF7264055B;
	Tue, 10 Nov 2026 20:55:52 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:51 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 2/8] lockdown: remove useless decrement operation
Date: Tue, 10 Nov 2026 21:28:12 +0800
Message-ID: <20261110132818.2231593-3-caixinchen1@huawei.com>
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

From: Kalevi Kolttonen <kalevi@kolttonen.fi>

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 security/lockdown/lockdown.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 263dcc80d839..8648508d49b2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -130,10 +130,8 @@ static ssize_t lockdown_write(struct file *file, const char __user *buf,
 		return PTR_ERR(state);
 
 	len = strlen(state);
-	if (len && state[len-1] == '\n') {
+	if (len && state[len-1] == '\n')
 		state[len-1] = '\0';
-		len--;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
 		enum lockdown_reason level = lockdown_levels[i];
-- 
2.18.0.huawei.25

