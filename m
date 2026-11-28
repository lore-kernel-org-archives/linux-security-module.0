Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795835011;
	b=4ufYpQ49bLuVT4KS6kDH53sEokt6YSKkwcuuWAuomsk/AKk/Uu+VzXvH35+Yf/eZzPvK
	 fjrKl39dc8DZvSJfzQL3oDQNwkdfJF8zGG19w9iUAKmaDsQh7CQL3GV1DL0JYXFhCug73
	 m0jO2AR2UyfY9eje22KTGtldM7bzUyuy0lgvEGDxg7WdLa7Gpzl1GrWtpYEfy2DNsqRwR
	 nNK9tf3O/SvPe1ZjnL5SnH2b4YqEYDACNOqw64a7AVuG8zzzVaAn/qHwGTcPPSCA9Xa92
	 VTvVD5Y1CU+faT41v3/gPx0c1D9Fpq2UQ+1pm/l+efHbibbBIe1XKkMUMZLmxoV7bXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795835011;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=28sJ1Nn18MtzFg8/m/Vih+sCUkkYopDLVhO5tTfjIUU=;
	b=gUwKeae1LW8zm5vCLv5UbtGvJlr6Hjqxx4bCXJrOnIzzRPym/NPUCQngpNaMYtGdGRBk
	 p8pF6JJoTgU5VO5szQZbPH1jioUKoVVJhWxE0AH1xfsBQfnm9DVkPZquVM3iZ5QH1NlWe
	 f2A0ziWtnqtUaDQYMqNq7AYyjpU2zN8Xe2OMZc/I4D7bfq73o83nPK9HfOlOj+M3uUn4I
	 nMKr9kpYa/y+sOp9uT5YPh16wZf5xnlFvFbhG92G5cgjSP5ZRESNq3BNmrOOB0LYDYUwi
	 uEoIOLbTzBtZuDXPXM5v2eipvzKvlO9yMcaHB1xkepep5ApkrDXwr6OVJtYRiEEreDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43D606A31C;
	Sat, 28 Nov 2026 03:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC43D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 453ef002ead811f19a56ed5b684f684d-20261128
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1fffdcbd-9367-471a-adab-f154e30f4661,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:1fffdcbd-9367-471a-adab-f154e30f4661,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:4d2043c6675f08e3d26a93e34addffd8,BulkI
	D:261128110324K3HOR0MJ,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|136|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,
	URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 453ef002ead811f19a56ed5b684f684d-20261128
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2134582366; Sat, 28 Nov 2026 11:03:22 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Guicai Ma <maguicai@kylinos.cn>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: return 0 from unpack_tag_headers() on success
Date: Fri, 27 Nov 2026 22:03:19 -0500
Message-ID: <20261128030319.3205806-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127080132.266236-1-congnt264@gmail.com>
References: <20261127080132.266236-1-congnt264@gmail.com>
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

On Fri, Nov 27, 2026 at 03:01:32PM +0700, Cong Nguyen wrote:
> unpack_tag_headers() returns int, where 0 means success and a negative
> errno means failure, like unpack_strs_table() and unpack_tagsets() which
> unpack_tags() calls next to it. On success it returns true, which is 1.
> 
> unpack_tags() tests the result with "if (error)", so a successfully
> unpacked "hdrs" array is treated as a failure: unpack_tags() destroys the
> tags, rewinds e->pos and returns 1. Its caller, unpack_pdb(), only checks
> for "< 0", so it continues without the tags.
> 
> Return 0 on success.
> 
> Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Looks good. Because unpack_tags() rewinds e->pos to the start of "tags"
before returning 1, unpack_pdb() leaves that section unconsumed and the
profile fails to unpack (-EPROTO) rather than continuing without tags.
Since tagged profiles cannot be loaded at all since 3d28e2397af7, this
probably wants Cc: stable@vger.kernel.org.

Tested on mainline (f4585067150b) on arm64/KVM with KASAN and
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y: the existing 30
apparmor_policy_unpack tests pass, and a local KUnit test passing a
minimal profile with a "tags" section to aa_unpack() fails with -EPROTO
("failed to unpack end of profile") before this patch and passes after.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
