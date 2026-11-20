Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161173;
	b=VdYHsZqrdadZ56FzZ3mMU3DWjvJSWAmlEEcrQFrTyy4PtldEPIwSktGHGZIsRMJ3rqj6
	 4WO4iJ+WAmhLlWm2virgZpnOQUbGFPwDk25cwfpKSI881OzA8Pwb+wCDGQEEeGnFfXyMa
	 VCGJNCm/wkU2b1XgVuxzJtCY6l8r1IkCTfoKuKtoVHhspQsvcHxmiCV58tt+skgNoBSlY
	 6NtkgS2ikzM6U3OZM/vEFZjawBkN5+93Cg4ekaxw5GM36JNNp84cE2BXgfI3HUDeqjc2k
	 N9yeI23W9nzr37iZBzUp3eKyR7sTBEJJxEqSH4wu/pMqLKnwUsJsPNK3vL3Y5h9Julw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161173;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LgxUgJzk/r8WyzK4DQJs7oxLPvLB561xGwUdxP655xs=;
	b=pB8BPulYSkMt5O+raH+z5YJs2mHe3RyS02ZeyJtHmNIus2+CufpcbUelkuYViTZgOOR9
	 K3atZ0j+R8rlkUzI1fHXqLF3SlCN05NHSiFv3lutNQjqnmgOLOroa1RNja6IANfOunCwx
	 toD+/ju7mQZBHvtf+8Wp2vnqIeojzSm5CkDLzoEhhta1orTO7JbPaxDGybCqFAI5SUUfi
	 QaZqW7wORQioD6gse4sGP9BxmcuUccuNOSXnZv3IBeGRVtVEGWsNvkzbCUn1pMkEV3O/t
	 AVa187RKlgnZbREz2mzQY0hiL5+W9bBuo+B7KZVg4jalD69yVztLCHmAohKpJ1gjFHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BABC606A320;
	Fri, 20 Nov 2026 07:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BABC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5bb777e0e4b711f19a56ed5b684f684d-20261120
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
X-CID-O-INFO: VERSION:1.3.19,REQID:0426123b-d849-43c8-b468-89945824a459,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:0426123b-d849-43c8-b468-89945824a459,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:8f8546647e83d8dbb8e8f229ca5a0b72,BulkI
	D:261120155241PT6GDL88,BulkQuantity:0,SF:17|19|38|64|66|78|80|81|82|83|102
	|127|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5bb777e0e4b711f19a56ed5b684f684d-20261120
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 420723945; Fri, 20 Nov 2026 15:52:39 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: JunYoung Lee <ljyoung04@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guicai Ma <maguicai@kylinos.cn>
Subject: Re: [PATCH] yama: hold the PR_SET_PTRACER tracer by its struct pid
Date: Fri, 20 Nov 2026 02:52:36 -0500
Message-ID: <20261120075236.1013988-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119025918.86247-1-ljyoung04@gmail.com>
References: <20261119025918.86247-1-ljyoung04@gmail.com>
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

On Thu, Nov 19, 2026 at 11:59:18AM +0900, JunYoung Lee wrote:
> Once the tracer has been reaped,
> pid_task() returns NULL and the relation matches no tracer. That is
> what an invalidated relation did before, so the tracer side of
> yama_task_free() is no longer needed. The relation itself is still
> removed when the tracee goes away or registers a new tracer. The pid
> reference is dropped from an RCU callback after the relation is
> unlinked.

Since yama_ptracer_add() replaces any existing entry for the same tracee
and release_task() frees the pid number on reap, leaving the relation in
place only pins at most one struct pid per live tracee until replacement
or tracee exit. The pid refcounting and call_rcu() teardown look good to
me.

Tested on arm64 under KASAN (ptrace_scope=1), covering the PR_SET_PTRACER
cases (including from a non-leader thread), relation replacement churn,
and concurrent process_vm_readv() against rapid tracer fork/reap.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
