Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315358;
	b=Up/QKHVv13tHDNerVHdPEMVq/vym5iYKJ+XGlF36fvLsVu6uik1IDDQkSp3rUGkWJ2zl
	 AGH5ZZTbuQWysoQFHW9NN/WUpCtfZB+e+OlzHtixCdhVkun0ViIcuRUY9mn1CWNLUifN/
	 nnKA0+pOEHYSyMwe+e5YcX5k/9XnPybYHOUQ5W3Ij+FolNMFbxPrOS/diw3KZ2htWTdnr
	 iPa5M6JBXWSyqOsAtieDjqLLoM8lj4BM22TyBbhcZ/LrUJa1k/M+GEYNde8tyORFWMVhc
	 2SR3rXKVMUApQx0qvcv3SC1pXmo/t1nai/4BD+VNYRtOwtFZRtgYaolc1omqZHrfCeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315358;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=U0OKKZb0bS0e4DptnMS2LcajkhFw1BOADafcvXSHktE=;
	b=2snJ4wJyo2PrfaKa/JckxVs6dhOUJPOjunaos6ZMjFd5gcLL/BtacHNlde0/NapAJhKp
	 2tJ6vO1fx3oLc6xm6soVhgwtoJOqT8zLuuL2UvtMhWdKqsTn5pUcqEwHYFfQ6LeLVic5k
	 RwpEAnPTn4lhJ7GgwvPSW0iHwmXA3cjPXAM5RQp2AClELexIlmIfsXuNdFyURuhw+M1hX
	 KgE3zoucLyE10dP4+CoJnieDlUZ3EIlKCV4lgKCo2CqQq2EJ/bb4A/+urMC1cS2glwtom
	 GD+QwKgVpuZqQ/n8gRi8oNL1qBV0aTOx11CknDA/bYMsO9nzDTN8wsNs7icRjJO7b8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OknLY2ee;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163960A3804;
	Tue, 10 Nov 2026 12:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B163960A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OknLY2ee
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U0OKKZb0bS0e4DptnMS2LcajkhFw1BOADafcvXSHktE=;
	b=OknLY2eeRRyF2bepRVyLhUyH44H8O2MDnYYxe+Av9fxUoRvpYU8B3mCQe4jpk4MRwx6drX4bQ
	qDFnC0Z+aRIAsPi0B1Y0J9WZHkUBbtVLA1yPKsSk+65d7PQ+P5C8MsS0EaIHiEmT0FPJ0qI3Ggp
	P4lAYIcdRstIr7+m+TLZl3k=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jP68J3zH0zKm5B;
	Tue, 10 Nov 2026 20:55:44 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 09A114057C;
	Tue, 10 Nov 2026 20:55:54 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:52 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 3/8] lockdown: select SECURITYFS
Date: Tue, 10 Nov 2026 21:28:13 +0800
Message-ID: <20261110132818.2231593-4-caixinchen1@huawei.com>
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

The lockdown LSM exposes /sys/kernel/security/lockdown, but it does not
select SECURITYFS.  If SECURITYFS is disabled, securityfs_create_file()
returns -ENODEV, lockdown_secfs_init() fails and the LSM framework logs:

  failed LSM lockdown core initcall with errno -19

while the sysfs interface advertised by the Kconfig help text is missing.

Select SECURITYFS like the other LSMs that create securityfs entries
(AppArmor, SafeSetID, TOMOYO and IMA) already do.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lockdown/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index e84ddf484010..82b69d8253bd 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -2,6 +2,7 @@ config SECURITY_LOCKDOWN_LSM
 	bool "Basic module for enforcing kernel lockdown"
 	depends on SECURITY
 	select MODULE_SIG if MODULES
+	select SECURITYFS
 	help
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.
-- 
2.18.0.huawei.25

