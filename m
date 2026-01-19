Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E3350A3F;
	Mon, 19 Jan 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814841; cv=none; b=oQ+zk9AqkhiM9IwCAiaG6knajok0qL8xLSsrcr0wLxmLGfRKg3DCTXVgOMQYl5BK/HeK7h7Mgn67U+cPUpYKBqgPjC7jATOTGO+KUlXcmnEL41kd6TkzxJ8MYuLOqmElIZOHQAy5zEE+vTRB01VCfSPDfB0ap9ZT40aGtWd58lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814841; c=relaxed/simple;
	bh=6lz1CisiMfsqryTFpKaFrbZYpBx7iVMrvgdVPEhfTgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tj3/+/3ntNsGll9XEyd/hWWnQ0pCvtdFQ7XUTx7jLZ5idjWJaiE2qs+hCin/nLtrLpQiGFDNcTB20/5GopjDtc0ZnNZr0Mf7cilUWOx6EQ3ZA8Bq4sGIjbLZ6+MbE0dENgE3f4Kzg6i30J+1t/wiIh091/vMKejfMpMK+ePQPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hKG9ThrX; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hKG9ThrX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=USozgccrdh7iIVsYykksvK4mQ6gJoGxHWG829TOQYFo=;
	b=hKG9ThrX639NYKjJemNgh4gxS7skHXLCyyZcarkmICjAn7jde8Hw1prhHSIrCi1FwJLBJ9tbh
	9orVIyD0SN56+J1Mt9OOQnYihDyzCdiAcaRFH+ZHd92re0wJxbI50vprw1JeFvcJsu089yd3w5j
	up7RkNZpmvgSZkd1S3H5/QY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dvlPJ6kyGz12LJf;
	Mon, 19 Jan 2026 17:23:16 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7990740569;
	Mon, 19 Jan 2026 17:27:16 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 17:27:16 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 17:27:15 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<caixinchen1@huawei.com>
Subject: [PATCH -next] lockdown: Add break in lockdown_write
Date: Mon, 19 Jan 2026 09:12:26 +0000
Message-ID: <20260119091226.3195309-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200017.china.huawei.com (7.202.195.228)

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
2.34.1

