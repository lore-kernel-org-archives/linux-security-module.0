Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153503;
	b=eOfOdoLLljssrXR18AY30hMsul9HLozQu7ukM2uSSIf6vdJD1YO6JMfyyUz9QOgirIB5
	 pv+5T+vVOUxoBcbjgT5DIE5ut3gTv42oZHcgNm685YIehWbTBWT+N1DHZ+gwXJ9P4jVmn
	 KpSoNwSeeQZWBJNOm1Jzm7At0UXiiXpvqTBMGeEEadDMSZsMPipsHNfT5DfH/usetIGLy
	 aBkq9lrKHUzva6kao+UrKkxGFHnl4m8MiA88b99SD8IFBQqsnKWP9uY2IKGra+BIYr93R
	 ChLljB5ZZmJ7WD+j0QwZFtUg3v+Z01XI0fxR0kLBQmhPYkzICg0w1A+K6HCa7MXImVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153503;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=kpTp5Itr+7pHEx09xf7FUtCYDdDaKSAk9Q1x2eZIJ0c=;
	b=ee/fnMJK8ubILi8Hb4QbBc2EACHZOvl/HUUR40hIAsJ2es1PrYDYTnMPj49xzJUWooGi
	 xQzf1QtAbKlV/4lBOIsINvkkBtqfpJ+W6ttZzRzHfL0ov3IpD3mqUOcKX2ay2pIfgdUWa
	 GAiks5yuqgAh2L+zQlDfX/cykTGyjlxg8nkEUECV0VvBUNLauFYR76C23c1HNEsJagrIw
	 HHv3C1xsMPfMm/9+NmHgR2mwWuet2f/PXGScUtld0b5o6z6eECdXyypWr5VBAtino85f3
	 0yAcdZKhY6kWbmyBX5/f4dCVj19wYLnld++C+HFFiY9g7SIPw52K6J70OJqOdzqx4Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB672606A32A;
	Fri, 20 Nov 2026 05:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB672606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82719832e4a511f19a56ed5b684f684d-20261120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a9fc4996-e65d-40fb-a3a2-412731c88267,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:a9fc4996-e65d-40fb-a3a2-412731c88267,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:23a9333a8862a3c965f469904947d005,BulkI
	D:261120134457ZQCZILDJ,BulkQuantity:0,SF:17|19|38|66|78|81|82|83|102|127|1
	53|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,R
	T:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 82719832e4a511f19a56ed5b684f684d-20261120
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 850449084; Fri, 20 Nov 2026 13:44:53 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Andrew Kroh <andrew.kroh@xata.io>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guicai Ma <maguicai@kylinos.cn>
Subject: Re: [PATCH] apparmor: fix label replacement compiled out of __label_insert()
Date: Fri, 20 Nov 2026 00:44:50 -0500
Message-ID: <20261120054450.846662-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119203650.51147-1-andrew.kroh@xata.io>
References: <20261119203650.51147-1-andrew.kroh@xata.io>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 19, 2026 at 08:36:50PM +0000, Andrew Kroh wrote:
> -			AA_BUG(!__label_replace(this, label));
> +			replaced = __label_replace(this, label);
> +			AA_BUG(!replaced);

Nice catch. I also checked the other AA_BUG() sites in security/apparmor/
for side effects and found none, and verified the a//&b profile
replacement reproducer on arm64 with
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=n.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
