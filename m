Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595059;
	b=HgGtLDws6yv+TzfmGPRrkofwoLGmstpYf2IMs4z1wjTL/iKH+jQ2u7Ha4EKW9uf0mT3L
	 hrl2SCCeu8tqDFXInrrX1k0PLLpFDkgh05voeA5RBM5E68vOOmDX9Mo4BtlL70VaQS17X
	 hXC0t7ffJmgCJvqNLjWRCMApEf+vI7mupWvcCrT8QvoTchjpg0/9+h4YO4eyveelz3fRG
	 RjjU5rTBYqpM/Ii7KCDJ68uSoSFqXOvbOc9T0cKQmnBMw9TXfihmbtELw5eHla87cIe11
	 RkGrTO6vRKx5IEv0pDM7L9uxCFpp7V3TU7XIA6pGAcg1vEdVHKJxB+M1FD7kOlX3CNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595059;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tvASh848fJMA5vteecjZFmNY2W1voJmJDbb9Kyjqx6o=;
	b=T61hzlLJUG0IwDAIbuhVRvPl3BL5i53yRRs36yptyxSyozYCTIdfhZn4TDRYpI8R+5+w
	 V+66iAHXZqtSaEdHCJzVZWIxnuzKAo2xHQUpFBLjKQzN6N1IF9MpScVfooHpfKv3gwQxJ
	 1oOGKgRDxIzGwTw1wfQDC24zGZWT5C/wsAVVKWGDQdw+8a28t+E98iylWK6fC8ZBnDeog
	 OyfbRFRlKprzuk0dS0viYhnu6UbsV+O3q0tcROgsvetcqoT/tAgxW1rr9cTo0lGLzLsvB
	 UOIjE29IHekhpqI08VV87RN5j2/MQsYJkdKYy/lBFOpbfig7LXsPtFhbA2zW5fc6dxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E4606A31E;
	Wed, 25 Nov 2026 08:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 968E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 95d3b77ce8a911f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7e9d3075-1ce8-49fb-bb03-8f262bf8c56c,IP:10,
	URL:0,TC:0,Content:9,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:19
X-CID-INFO: VERSION:1.3.19,REQID:7e9d3075-1ce8-49fb-bb03-8f262bf8c56c,IP:10,UR
	L:0,TC:0,Content:9,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:19
X-CID-META: VersionHash:7db8b62,CLOUDID:8c8c890b99896bbf54089eb9b950923c,BulkI
	D:261125162411DDZ563PP,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|153|841|850|865|898|915,TC:nil,Content:4|15|50|99,EDM:-3,IP:-2,URL:0,Fil
	e:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95d3b77ce8a911f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2035325445; Wed, 25 Nov 2026 16:24:08 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH
Date: Wed, 25 Nov 2026 03:24:05 -0500
Message-ID: <20261125082405.1505471-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526153542.105483-2-ethan.ferguson@zetier.com>
References: <20260526153542.105483-2-ethan.ferguson@zetier.com>
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

On Tue, 26 May 2026 11:35:42 -0400, Ethan Ferguson wrote:
> @@ -224,6 +226,9 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  	int rc = -ENOSYS;
>  	struct task_struct *myself;
>  
> +	if (ptrace_scope == max_scope)
> +		return -EPERM;
> +
>  	switch (option) {

This check sits above the switch, so it runs for every prctl() option,
not just PR_SET_PTRACER. security_task_prctl() propagates any return
value other than -ENOSYS straight back to userspace, so once
ptrace_scope is set to 3 every prctl() in the system fails with -EPERM,
including PR_SET_NAME, PR_SET_DUMPABLE and PR_SET_NO_NEW_PRIVS. The
check needs to live inside `case PR_SET_PTRACER:`.

> @@ -204,7 +205,8 @@ static void yama_ptracer_del(struct task_struct *tracer,
>   */
>  static void yama_task_free(struct task_struct *task)
>  {
> -	yama_ptracer_del(task, task);
> +	if (ptrace_scope <= max_scope)
> +		yama_ptracer_del(task, task);
>  }

ptrace_scope is clamped to [0, max_scope] by the sysctl handler, so this
condition is always true and the hunk is a no-op. Changing it to
`< max_scope` would not be safe either: a prctl(PR_SET_PTRACER) that passes
the scope check just before the sysctl raises it to 3 can insert a relation
after yama_relation_cleanup() has already run, and since scope 3 is
irreversible nothing would mark that entry invalid again. Walking the list
in yama_ptracer_del() is cheap, so dropping this hunk looks safer.

This is a static review against v7.4-rc3; I have not booted the patch.
Are you still working on a respin? I can test one on arm64 with
KASAN/lockdep if that helps.

Thanks,
Guicai
