Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692291;
	b=KbL8hi9mnhKDkfqtwGAlu3+9aClYNNsfYP+992RM5w7tKwtv1mqYG8qa6Gg3hk+0u+oq
	 hRZe1C0bNwo5tnKN/eLb8iX/22LWV3RaWBO3S25egJtJstJDo95YP6IYv/sAhGPBTmOLe
	 n0wT3TdJbbcQPBHYvlH2mWzubfk7MkoOn9osOZSHZBOPfwcrKseJsFB0tpMylqTxkUMIe
	 SmxDklP0XoPoLw4moVCv+IhS3sDy5OkADDLBwjEFAOAbcwW4O0cY1cdukQV00J52p0XH/
	 K45jhikClIdoRyFb+dN4fx1B/tBZhljAg/RYUqbpS98HZoUENEGitKo3O8jx5GxIBLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692291;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=Q8UW5TU7NVubhK+JyaRu9e+ysRCGW/oCEMpuGGYgmDA=;
	b=hrwABqvL0GexQsP2dCTYa0YAe8Lp2hz64lmzsbH/A5BqqeB4OvNqpQD9lgeKj4GojKlL
	 8a50Y+NrhmxRmwF2WYX1tdQmaILDakT/LxOVLYBddEX3e5iKNxMyxR17axIlzQd5o2k8d
	 8BYS+GuvP4x32yF9QZ+QhNRLFha+13NtXwjkXtcw/564lIqlWwoMXW0Cc8V5whwirR1Jq
	 STedUzA9n5Y4fDGoHJ/56xCAUsxwXZpjtXueq6aXdyvVStClCYZ2aXuQo5h03FYNjphY8
	 l66zhWKKrgd1BxJXsv3Ideygppx4CgA+O3RSkso6KAlGdihiD7pwXj9PxMxhWy1t9yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G8d2BMoJ;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86A606A32E;
	Tue,  3 Nov 2026 07:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E86A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G8d2BMoJ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q8UW5TU7NVubhK+JyaRu9e+ysRCGW/oCEMpuGGYgmDA=;
	b=G8d2BMoJARzwHIqn/mmD4UnvadIUz9Br0GTmlUyrUns8CUaEtXKceTVHklepkFKUEA1V1P8MG
	pQzWCdBhJlhBk6OERVXmSRx7iws8QiznJs6/EoMCAsq1VBTQ63LeRhw95L7EoTmi6ovo2FIBPzY
	h1thFkL6bes1JtEK+H657Zk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jJgkJ177MznTVM;
	Tue,  3 Nov 2026 15:51:20 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 96FFF4057A;
	Tue,  3 Nov 2026 15:51:19 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:18 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 2/9] lockdown: remove useless decrement operation
Date: Tue, 3 Nov 2026 16:24:14 +0800
Message-ID: <20261103082421.3033195-3-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

