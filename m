Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697239;
	b=2E7UFOh29605LANuatkiDnAgLkgaNxIRX2TxDB2L9L/ddSfz5X9+E/IL+Eg0i8h+ctaG
	 bfwZydhYdrQDojlAXUCpVmXPA52Pr/DzzAUT4VmOx2+QdmKK56JuzyareWExTkG76SX3l
	 FiGTXTNfJau4+ZZTe7L07IveQlub+Smf69oaPTamoBZE/IlRkP0VUdJVGqCg6Jh7l24+g
	 UJ51rLC5R4PkJ0PRSPsYPOx22heHusls6lvdZg3OnMTG4IvhU79H9T3CfcnMYFSi5QyKR
	 mRBOVZAoRt/AyAAedOlEOHx+GgFtnFFmcPeqNFrRs8MVecLhotWeA8OVcOMxoGwoHVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697239;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=ZflxKbm+wiO87awewiVvOdKuztT1d99nh7I+L6MPEos=;
	b=uFuoi98gLmtQ5nDp/MZS/WwkZilL8rEmk1O0fyiXkXRS6idP+zs6W3P57rftgJH2q9Lu
	 x8lCe4+n4hIc2cdLX9O5AhFbX0XYpFjNfNXoGE8Y34VjSpfxRtRvBfYiM07nDSf3KqoxK
	 xxqVWcWjVPFTCrzJNnky3/EhhKQgode/41xX6uEMnYjWI83nkRtNXcbonnfL8JHUa5K6N
	 ZKZu0sqnP66kTmkl/YsOw1MAE2Nl2ERZYXNNSrywKQRdgy4LgC5OzJTAlH5n5Os4M3g5d
	 O/nV5p2IRHnOqKXpDraC1ztLWoarLe90Me2i0Rm+Ry4KuCGMRnaUchzTm7vDQ4gqbAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=X24NdrkC;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F8606A686;
	Thu, 26 Nov 2026 12:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C7F8606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=X24NdrkC
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZflxKbm+wiO87awewiVvOdKuztT1d99nh7I+L6MPEos=;
	b=X24NdrkCHqE4WYI7PoShdKf0lkfVpdRsy0GrC9Bi2mwvHaIwSPg61kaqKIT3DzSAFPJh/wJzB
	HtfPOWt5NXQzDETMUJ8QzaaDaHNd8H4GXsTEEnLloI2/fZpAbJIox7WBpG0nxjwAU/efcZ6345n
	n8OLZ1uXloL62mWD2Ndxii8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jZxBm1nW3zKm4k;
	Thu, 26 Nov 2026 20:46:56 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id A26FB40586;
	Thu, 26 Nov 2026 20:47:15 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:14 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 3/8] lockdown: select SECURITYFS
Date: Thu, 26 Nov 2026 21:13:10 +0800
Message-ID: <20261126131315.1256553-4-caixinchen1@huawei.com>
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

The lockdown LSM exposes /sys/kernel/security/lockdown, but it does not
select SECURITYFS.  If SECURITYFS is disabled, securityfs_create_file()
returns -ENODEV, lockdown_secfs_init() fails and the LSM framework logs:

  failed LSM lockdown core initcall with errno -19

while the interface that the LOCK_DOWN_KERNEL_FORCE_NONE help text
presents as a way to enable lockdown is missing.

Select SECURITYFS like the other LSMs that create securityfs entries
(AppArmor, SafeSetID, TOMOYO and IMA) already do.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
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

