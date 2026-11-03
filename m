Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692291;
	b=Z5hgAHzKrHVElhX6fKCKWNEpMvXF1H7CnVhMzsUv9AOV5a11CvYLUCGmUKC0Wq3eh0ZL
	 wSHPPRXgw73QizC5CPAXShHwWWVww6UjlLjHrGdnh7kGHjU/dnTtXxcJv3qhSCtvGyHfI
	 fmlwEDw+ozGqi7zJ0DpYtxJyiZClpGqwwrnfqrScBSjfpiqptqKKlPWvZnTkFHh9mZXer
	 1zyauTP2KePHgOs7ocr1jwxQKDE+RzffGnVKD4V+fbqsmord5J/PUvCyPaY6K7/bhf0wN
	 pv3MaC9TFVE1QTACEopNG/GIc/AcX1uv/QrJgAXgvt+dNC0g8O/VzoDDDkjpHRlaxoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692291;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=TebaHDOnvqGDEokgRq+1L6bEUOTWP5a/DEIL9I18Csw=;
	b=yu4a05mwwuewBTTFMg9NfTFm8i++ZlD+fIWxlKzVH43Yg0A+0yfiNv6YOspeItJaGHnm
	 dFVsekk/adiAM4SCKrswJPVf5cpTeJTeqbl5vQctW38NlWN7ygoCjfs9dSqzNmhZntC3W
	 O8G9pq+QnzPeIKQYGF3rVXtRnQjs8v8jw1xXjTV7AOFwPtmTXRVHjwtFKHHrQ9URNi24n
	 iUEL2yXrvcGIBZp64Bod3mL9O1X+RMy7Yrg05gRb587SoAxUqugLcPF3OhxknUmzsKIRM
	 5DBO8Au958z8qNFIdOnUgbb215RVH70/Ny5nkyVABJiiM3jWr8DtWX5lVEvUzjbtMJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QI+HDJ7a;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423E606A32D;
	Tue,  3 Nov 2026 07:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9423E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QI+HDJ7a
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TebaHDOnvqGDEokgRq+1L6bEUOTWP5a/DEIL9I18Csw=;
	b=QI+HDJ7aYe8MfkCuKU7dL0yAZWuoB3bd+VDsT3gwYFTrsb1hr0Ak2GGm/2Z6sOlQpEj5dAjwC
	cId1TF3zeh0ixUSq0abtvLa21nW0CfqfPxdhz33HmksBh+4BEDjl0JhHFhOJfM/aVOLBEKsblB5
	VKzoMwEuXC7338Pwxfrh4PQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jJgk41ShFz1cyqr;
	Tue,  3 Nov 2026 15:51:08 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id A1D724056C;
	Tue,  3 Nov 2026 15:51:18 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:17 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 1/9] lockdown: Add break in lockdown_write
Date: Tue, 3 Nov 2026 16:24:13 +0800
Message-ID: <20261103082421.3033195-2-caixinchen1@huawei.com>
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

