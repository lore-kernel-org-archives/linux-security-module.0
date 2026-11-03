Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692293;
	b=z5jtCXgATTaccLB1b3vG4bjgNuMIfjw+HqRgzpZR+93wGBq1pSSVIGDaK8dlvv/o8bOO
	 bFcA/ahhfMSymNnmvwYsX/X26pQhrXOf6G8dH2hJ3LjlbCubhS3ltmM8ge++ibA2DMpbX
	 Wzn+vXXvSg+moyUjrpdPOtvr/SZMhkZn0B1h/WKMQOKlS0XeU8igklSLSRy/UER3LDng0
	 LsuQUpLrQrOjeTjo3CuNneWSfcgKDQzrfRFdmY+LHLvNN1vUmN9krTXTx3x3/Ctf4C2gL
	 Sr0brk6BLuxt3SjjXk0tMv6uWWuZg5ug8AIEg6e1YZS12g8i3dJNvMUcmAjPMc2I4FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692293;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=2J/Nh+WAAziI7Ldg5W138mKRRltrgs5BOiMGBSikP/g=;
	b=Stav3TuLBr/+JZmeSH2LBUxYShISLz+JG06zgkse+s499vm93buzJvSZdJikjUoSbnyH
	 zuvwXi3B2QRDiIQqcPKWBb6RbxJHi/xfqmIP+fxr9qGIfMiii4QQtyQthY0vuIFL8jQ7C
	 Nqvc/oa7R9bHgOf/+79cCXM0GGaOhgMuIuJnTFBzDzILwZXIvE2Ge/CKvXbUzWXSv2Vet
	 upd/a+XVYJqNS4mAV2Etr0mlEQ5D2Z/t74oqcTnt/7C4/5X8j2ZtudMy1DQRck7+gA42z
	 JdQ7UmBsX0Do+Ngwk5Kja4+2L1EU2cNsRgbK3cmSZ50GarO99a1JODJ4Zs5IV4qzQOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NAzfPAKu;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F369606A33D;
	Tue,  3 Nov 2026 07:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F369606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NAzfPAKu
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2J/Nh+WAAziI7Ldg5W138mKRRltrgs5BOiMGBSikP/g=;
	b=NAzfPAKu3KVVGA1XiFEMtsoMPZydYBSQCqZh6O7M7O+rPGITHNj1ABx108dUkymulBf9qHs82
	1nzzODhZjbRYUKiksDsYu4jwbjfrmIIWh3jjKSQxKUt/HBM40H5wYeeXFu30XxuB9htc3OAxRNm
	fhJer0H5O63cHVJjTO/9Uds=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jJgkD2XY3z1K975;
	Tue,  3 Nov 2026 15:51:16 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 9321640561;
	Tue,  3 Nov 2026 15:51:20 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:19 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 3/9] lockdown: bound the status string with scnprintf
Date: Tue, 3 Nov 2026 16:24:15 +0800
Message-ID: <20261103082421.3033195-4-caixinchen1@huawei.com>
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

Use scnprintf() instead of sprintf() when composing the lockdown status
string in lockdown_read().  The current set of levels fits well within the
80 byte buffer, but sprintf() provides no protection if more or longer
labels are added later.  scnprintf() makes the buffer bounds explicit.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lockdown/lockdown.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8648508d49b2..b6f99b9179b9 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -106,9 +106,13 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			const char *label = lockdown_reasons[level];
 
 			if (kernel_locked_down == level)
-				offset += sprintf(temp+offset, "[%s] ", label);
+				offset += scnprintf(temp + offset,
+						    sizeof(temp) - offset,
+						    "[%s] ", label);
 			else
-				offset += sprintf(temp+offset, "%s ", label);
+				offset += scnprintf(temp + offset,
+						    sizeof(temp) - offset,
+						    "%s ", label);
 		}
 	}
 
-- 
2.18.0.huawei.25

