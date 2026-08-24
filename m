Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AC3769F0;
	Mon, 24 Aug 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553670; cv=none; b=EXS54hmJaGj+120XdGO9VqbDCRXGW5HRtN9VK6s6Czp1qbRFyS3dodtSncIn3F0Bn7NUYOgDq4+Mg1r6cyy8NP/60gS3HuygKYv/2T2RxxqRbEtPx4qsGTJgYJpkjhoCBkWjjHZ6hRtbBLBeCpxoIfuXOnXdSULZBzO8va/MNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553670; c=relaxed/simple;
	bh=0q8C/sBZvT3gYGnxgQRmLqehElSdputVSzITVFBXaTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNAFswCHO1XWZQp0t0lIE+u4rP23bC9vEBuY4kd2VbE4lQVy7Q9x/H8zeDl+bWe5oaO/72aPx1tyePitOOyxY1yrJxC3PG/M4u3rpRCjXyLPETo56kVWNqogOkpXQ64m39h33BBo1DpjNH91rd8pBoRekm2Uolr/c0r3+AgKZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c1603f269f8611f19a56ed5b684f684d-20260824
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d6004999-4ff3-4401-8283-fd56e1256820,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:11
X-CID-INFO: VERSION:1.3.19,REQID:d6004999-4ff3-4401-8283-fd56e1256820,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-META: VersionHash:7db8b62,CLOUDID:664ea2e1f5260cca0433da99c0c178d5,BulkI
	D:2608241440596H0VOLEZ,BulkQuantity:0,SF:17|19|38|66|78|81|82|83|102|127|8
	41|850|865|898|915,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c1603f269f8611f19a56ed5b684f684d-20260824
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2139166115; Mon, 24 Aug 2026 14:40:54 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: gnoack@google.com,
	mic@digikod.net,
	shuah@kernel.org
Cc: lihaofeng@kylinos.cn,
	wangyan01@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Fix snprintf truncation checks in test files
Date: Mon, 24 Aug 2026 14:40:32 +0800
Message-Id: <20260824064032.774597-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260626070016.61049-1-wangyan01@kylinos.cn>
References: <20260626070016.61049-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi maintainers and reviewers,

I hope this email finds you well.

I submitted this patch on June 26, 2026, and it has not received any
review comments yet. I understand you are very busy, but I would
greatly appreciate it if you could take a look when you have a moment.

The patch fixes the remaining snprintf truncation checks in
selftests/landlock test files (audit_test.c, net_test.c, ptrace_test.c)
to match the already-merged fix in audit.h. It is a small and
straightforward change.

Please let me know if any adjustments are needed. I'm happy to update
the patch based on your feedback.

Thank you for your time and work!

Best regards,
Wang Yan
