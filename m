Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516880;
	b=w1irELpEsSAm9468TV153MlXWwACMH3m+lvxaA5rxTvVn4CaUpVORcoKn87vJNu+lX8E
	 kNsMH7quTl7cBpBui1W5y/fjsMzRSm8h2blXkXXgNh8pnPXNrgFfFLYZ0NjymhWMlCR9y
	 lOQ6GIx+LCkoWZOABZUNVHRjUAJTgwFSnuWtNlehWyCjHBtxxeWFcvFp7gUvp+Y4Q5zZ8
	 FfXibZxkbYWo2VYwnZuEGfm2qTTbhh5m9T1vmXUZ2mPrQi5vcMdzOMknb6TG/DQePpwjX
	 3jWP8jMSlHzGaN4U4WLXnZct54UBkAkDlkldCNARNdmgnLEFKsJErG06M8sjNCOMwBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516880;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=4NPtJp6ies6ozO1IrS1tIvrmRI0RdeRq2x9wiqSMjAs=;
	b=stWXKM6zYMJCOkwx/USQK1goBvH2Q6B0X9j+rtdBXbM6zO0A49VtydjAU877iDJu1bOa
	 Ibo1u3Ezm0lHg4xCyLpXQE+3cjCRtX2eZVh/CJ/9gOuJd3a+Ma2iEpu3a9+tH6034XV6t
	 CAIfZidAlwJrbplMuuRDUCHpD5wynz45cWUSIopo7gm81KQUP/sL3vPxBt1Ithfvgh94z
	 z6SPYnunD0oyu4mE6GbyW0p/GV8o4bVr40dHvWk2pf3pmnrO8s5gliPMPJG0wvPZPdT4u
	 +gNnO6gJvV67HQHNOjCPN8OHMCC0uS7DBxhcSYDFME8CS8KX6ExwzQ3kw6SZD6+xvEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B51606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 10:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e30ae8ce7f311f19a56ed5b684f684d-20261124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cfc3118e-7973-47f7-a60d-fe042de053b1,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:cfc3118e-7973-47f7-a60d-fe042de053b1,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:4e984b84b15215a72b359b457982e300,BulkI
	D:261124184111NJJ1ZVLY,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,Fil
	e:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e30ae8ce7f311f19a56ed5b684f684d-20261124
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1738096738; Tue, 24 Nov 2026 18:41:07 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org,
	Guicai Ma <maguicai@kylinos.cn>
Subject: Re: [PATCH] yama: fix use-after-free read of a dead PR_SET_PTRACER tracer
Date: Tue, 24 Nov 2026 05:41:04 -0500
Message-ID: <20261124104104.1028000-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123165357.4092273-1-bsdhenrymartin@gmail.com>
References: <20261123165357.4092273-1-bsdhenrymartin@gmail.com>
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

On Tue, Nov 24, 2026 at 12:53:57AM +0800, Henry Martin wrote:
> Keep the tracer's struct pid alive for the lifetime of the relation and
> resolve it with pid_task() under RCU at access-check time.  Pinning the
> task_struct itself would not work: the relation is only invalidated from
> yama_task_free(), which runs when the tracer's task_struct is finally
> released, so a task reference would keep the relation, and therefore the
> task, alive forever.

Looks good to me. Checking !relation->tracer before pid_task() also
handles the case where the tracer detaches its pid between
find_get_task_by_vpid() and get_task_pid(), so a NULL tracer_pid is not
treated as PR_SET_PTRACER_ANY, and yama_task_free() still cleans the
entry up on the final put_task_struct(). Calling put_pid() from the RCU
callback is safe here as well.

Tested on 7.4.0-rc3 arm64 in QEMU with KASAN, lockdep and
CONFIG_SECURITY_YAMA=y (ptrace_scope=1): built cleanly with W=1, ran
PR_SET_PTRACER functional checks and a concurrent process_vm_readv()
stress loop against exiting tracers with no KASAN or lockdep warnings.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
