Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692290;
	b=LaJ0ZVkIBMNItKchsUSqjeE1E3R/PjzmiC7sYWgO2j5v0CjuoDwNg/IrId1Wfne/2Udm
	 NyLuI0xOJ49MouBP8TELeIYgDxM25CqSyBWynQ87/E5IK3amRAGSTdN3YW9UGVwkuYFzC
	 4XT48LQT628XsQmLymbaRZpi/JXeqxA4UUJj8k288V9pWg07tHDdERHhcd/sIsgeT9bpu
	 QOhoURYzHCOJ1lheWBqKTZKThhXn8Or2WlJtNjzujFomU97gYTIJT5wFRUBIeJndiuUX8
	 IC6RgBaUx2RRPShdIZTzq7y/Cjr8Enpohe67d1K45kp3yKyVrw2yvnBJsplkFk5FW7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692290;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=whOPXAhmuyoqQssML4ZFu0H8T+s7JMuYpqdJcIs4gvs=;
	b=WD+P/r4BVEy07a+02E/YrYEO8HmeCgpVH4+6nYKLSa3fjuDfnbrIvcXVzVODE/j5nTRd
	 zCh9MIMOn9tsh9xVb0E0GW21NlehYnqg3DDkqNXsIrCPUbz4OFeC9HqQHB/q14TElDQvj
	 skVx7isMLfEia1vYKmgk2h/1SLXjC7bMsMASZH2vP5KWMYCXbLe1HKVZln4m3/Jn5F7Zr
	 4Sw4cC3j6o5v4WKx9o/QCuQzUYpCEJU5WUrdGp3uttiiUyj7rLQp0eaSCrpvqsY3gPogX
	 RB4g454T7pMSfih+nsjzJ7JpTpWdsHDPRYUwoLLcygdolry9SsavAMrCbZ/JHAe4xmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769A606A324;
	Tue,  3 Nov 2026 07:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0769A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=whOPXAhmuyoqQssML4ZFu0H8T+s7JMuYpqdJcIs4gvs=;
	b=K1ntj93SuOFBbZMZ5wjY2n/9aYDuGCFApbIcYDMOZsDHw3LP0cc6pA997a+7mSYvtkIuywbrH
	Qw/lBcnVa0Gy5QEDROFwj8AUvSKPZHUhka6xoXRMWtByD3RmtOy5L94dk0wAAYC9cf9aWQzVG01
	bQPYB4LD2sXsqByX/wDj7Q8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jJgk83Db8zmV6r;
	Tue,  3 Nov 2026 15:51:12 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 79BB64058E;
	Tue,  3 Nov 2026 15:51:22 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:21 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 5/9] lsm: remove unused lockdown audit data
Date: Tue, 3 Nov 2026 16:24:17 +0800
Message-ID: <20261103082421.3033195-6-caixinchen1@huawei.com>
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

Commit f5d0e5e9d72d ("selinux: remove the SELinux lockdown
implementation") removed the only producer of LSM_AUDIT_DATA_LOCKDOWN.
The type, the u.reason union member and the audit formatting case are now
dead, so drop them.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 include/linux/lsm_audit.h | 2 --
 security/lsm_audit.c      | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 5cf0b4795065..51b498c0ec74 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -74,7 +74,6 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_FILE	12
 #define LSM_AUDIT_DATA_IBPKEY	13
 #define LSM_AUDIT_DATA_IBENDPORT 14
-#define LSM_AUDIT_DATA_LOCKDOWN 15
 #define LSM_AUDIT_DATA_NOTIFICATION 16
 #define LSM_AUDIT_DATA_ANONINODE	17
 #define LSM_AUDIT_DATA_NLMSGTYPE	18
@@ -98,7 +97,6 @@ struct common_audit_data {
 		const struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
-		int reason;
 		const char *anonclass;
 		u16 nlmsg_type;
 		struct {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 955b2e7b2c8e..4b653edcb77e 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -393,10 +393,6 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 				 a->u.ibendport->dev_name,
 				 a->u.ibendport->port);
 		break;
-	case LSM_AUDIT_DATA_LOCKDOWN:
-		audit_log_format(ab, " lockdown_reason=\"%s\"",
-				 lockdown_reasons[a->u.reason]);
-		break;
 	case LSM_AUDIT_DATA_ANONINODE:
 		audit_log_format(ab, " anonclass=%s", a->u.anonclass);
 		break;
-- 
2.18.0.huawei.25

