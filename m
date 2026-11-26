Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697241;
	b=kmqCwVYl/QYox9RPp2lnUw5oXGolfslipokGmHIxAAhP0oDM2C7n8qGt32pzGKuIyZGf
	 QQEd4sBXVGz4VvIYzz19vZoXqZbAijnGBrbyZ6zBr9y9gcQ4aMl3jsOPkh2+q00uJopgQ
	 bSlLYm1yhcsB4d4bA2DxPP+xkPRWd6bYNBfSXsfUvSrPQ0w/bm7Eq8lKXGd0RCXyq0d8q
	 8FktnNmZgK+wqyEHqb9U+up9N8IkezcgcumhCW7AiYu0n+PthyQG2mITwLH7ySPoGkqXt
	 TmH7jJ3YmRaeA6PeOhYjh1BUlCPqFjyJRVYFAjJsSi8hIbiJ3WCb08yX5kHuOhSU9Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697241;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=7HB80arrzZyCBom3sXuXwuYgBXzCAd4JNuZqsg2qCWA=;
	b=Moi5mdVxUCM40A/0XbzQwxMRtDZc96WZ+6hmUcjZKDEvTPsm+ctgOM9e5sV2ymBq+35S
	 D5uKDd3dyZvPVD0eBelBIXLQCiILTiWTJ0nxf4oCzK3gqJ+s8KcKSKx7mfS0JCI6iWqYx
	 J0SqC/DEn0+7qm0HXM57P7iKGXtVOtWV3LbmQq2bGfmHLSO/bSKIG92cEoi+UYdhffmdz
	 6n4GLlnvANP3QjQxxhVAIbHnPeSqr4A3pTVjlJ/59IFHlkcs53MshKomujNULPPPAcyOI
	 Lya1dBudtbbhRBH+a/00wmoNG5X3RB59ry+6vN2iRtSIydscnOOajU+pOtaaiY4sWEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="W/KgnyiU";
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CB606A6AF;
	Thu, 26 Nov 2026 12:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 699CB606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=W/KgnyiU
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7HB80arrzZyCBom3sXuXwuYgBXzCAd4JNuZqsg2qCWA=;
	b=W/KgnyiUqD5JT5wgdZTEAuJt2HsBgGvYM8oZsp6JW82GQ4oewYuqDlIcZNoIr9mmzjQN9bO4f
	HfoPu7iYbxMXZTq2t0JS154DEtcC48L+ah+4DrLw0tXJAkoP/rHGthjqTK6Jq3YZNAp08QEHTi6
	eO1EZBSQUicOqNV2vNzMi0g=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jZxBl19kCzRhQT;
	Thu, 26 Nov 2026 20:46:55 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F1DF40561;
	Thu, 26 Nov 2026 20:47:14 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:13 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 2/8] lockdown: remove useless decrement operation
Date: Thu, 26 Nov 2026 21:13:09 +0800
Message-ID: <20261126131315.1256553-3-caixinchen1@huawei.com>
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

From: Kalevi Kolttonen <kalevi@kolttonen.fi>

The length of the written state is only used to strip the trailing
newline; it is never read afterwards, so decrementing it while
stripping the newline serves no purpose.  Drop the decrement, and with
it the braces around the now single-statement if.

No functional change.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
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

