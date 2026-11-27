Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793602;
	b=Fb+Lf9XBsAYK0EP/L8E1Vwvv7A6ILJjxANiS7Z2Y/y4C/t6QRW/1zAlNHH64t51N18Eh
	 D/o9EQxtdND5liuTBpWbEP48zVSOOp3Ysou/ZAe4wgLpzAghQwA1EYjJr0cX7zqjNvhBq
	 pDjekRmtznvCkKFumgUTGCD1bomn9lt0CeHOPq6qfd1LHZdyeu9Ro7sc8g1XTCcLNhf7P
	 DCc4RuRDqyW/DuEbmjNS7nVdxZi+96sn0LlrFyQJQwefQqGp+UBudvUU0ZddD04asRam7
	 ZozTr/RgmaNV5hduig1njBpoFkqjaSp/LNwz6ERcXbb8PvFG3Abk38HWc+CsNFwSLjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793602;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JSaUcdyokx0nCM0VaAYNMMQJYWPBcRALhJ5U21pZ3u0=;
	b=T55PjyDkHXoOuZMtgk3LDkClgpzdraP9/jN7n0uDt4a90F1UsB+Ttfdt4VQGyFpzDnF2
	 wQHFe0nzJKIMj1mqhc9hm4sFDTVyohi8h0dY+HmJDMHl58DJWM4uVJksRB8fanMQen6Q+
	 ipQ4AgQNMwteWNBYhokKmArq2tuLVC6Gu6Cy+Q7XOBbyECvbQt4xWeNgkZRGlXgTw98eY
	 OySREwP6VW+6y9WGteJO58gKbipOcX2VefaKuTI9QjAMdTkM0zk9P0hngDDXbP7OS2UlW
	 LArNDUUmIPbrIJwo34+OOSBu3xOKinEjUl68/ldb7QZDjmlIAIBMw+a3k/giinE8tvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=q6it4Quw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA529606A686;
	Fri, 27 Nov 2026 15:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA529606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=q6it4Quw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C451DB5;
	Fri, 27 Nov 2026 07:33:18 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2D33F632;
	Fri, 27 Nov 2026 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795793600; bh=kHJr5BFqohQ9MXCMflKsAGajKF4U2rgV+vAl7QLaA70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q6it4Quw4kEB8SrkkO8an/Sj/JOcvxksxATyDh/C0LHA8I1TSuTaRqvdX5Xp+w7/Z
	 uLFhf4sDoL7E8+ldB3hUKvpcedlKScA3aTMOZS9JIr4BF5E1pNRm0CJvP7lys3d4ys
	 ZaPdYFNnzcpqGFKlzlhRgBcelTAdXGJCvK3GliY0=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 27 Nov 2026 15:32:57 +0000
Subject: [PATCH RFC v3 2/8] arm64: rsi: Add realm hash algorithm defines
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-arm_cca_mr-v3-2-df3230afce8f@arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
In-Reply-To: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 thuth@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
 Pawel Chmielewski <pawel.chmielewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=CGmL714oNZ1rMgI/iJoIOGjAn2yDceA+mDSJkihQBwQ=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBrCaKzhe4TF3B38fEAkPTJno3T/SIWTv5WKBscT
 lzOwxxnQYyJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCawmiswAKCRBt1cPRWsUx
 MwJJDACOsFwbayMWSJgzlyEf2W9O+7bjaZlEllPAimcjaxZyHTxF7DV7hugrXr/Rvi4c+Hij1Wx
 cqJeqSqEM/9gA0OyGpBkGyzl9CQqnoAS4YZnVeK04yd1vgh6suu0gO2IHsWUoUEfETVXdpkSET9
 cVT77a7xa8FN5XGMfCoz20RVgFOuNFA+F050sy5VchsTGlTxvIJ8tdGqrpv99WRTnpDesUtCxme
 YMVEEnZD+o/NAqb52Rs+B3P2jqgcuhGZh0pi/FBmL3pK+8qGhcosATZGXiLenKspNgkQnUGQRwz
 rHVwTm/nDCAAvAfBL5/UDI+3AVgVYVw79iEl9XXYiMJ/Be8MrMIUI7Wy9Quea3SR/tvhHiVM2ob
 EEzeJDBYH0cz0oIXZtz3H9H7xZCp3B/5eMat4vzajbe3jNh+jxfS65I9W8AToJqgkDS8XX/PYBG
 yObqM+soye3VqoMAil/mgRuXG11s7q2S16hRphhkRuP5nSEq/8TJnVLQeyRwyLdk0IBhU=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: Sami Mujawar <sami.mujawar@arm.com>

Add macro definitions for the hash algorithm identifiers, as
specified in the Realm Management Monitor (RMM) specification.

Signed-off-by: Sami Mujawar <sami.mujawar@arm.com>
---
 include/linux/arm-smccc-rsi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/arm-smccc-rsi.h b/include/linux/arm-smccc-rsi.h
index cca881ddfdbab..cf8e157269f3c 100644
--- a/include/linux/arm-smccc-rsi.h
+++ b/include/linux/arm-smccc-rsi.h
@@ -144,6 +144,14 @@ struct realm_config {
 
 #endif /* __ASSEMBLER__ */
 
+/*
+ * The RSI definition of the Hash Algorithm (as specified by the Secure
+ * Hash Standard) returned in the realm_config data structure.
+ */
+#define RSI_HASH_SHA_256	0
+#define RSI_HASH_SHA_512	1
+#define RSI_HASH_SHA_384	2
+
 /*
  * Read configuration for the current Realm.
  *

-- 
2.43.0

