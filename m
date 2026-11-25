Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596720;
	b=JZt5YLUaxx9Eca7ag49Smw5CPY6XMktmulR9lilwDv4OOfn+2uC6t0Csj5UL6S5bGqQH
	 khExAdW0rUu59pBVffhJ9jJOVuNMqHMwvdNz8SWY3Dj46Rjs9HAYIbgEeYQ35GXKdZyXl
	 9n+6WIgqNFwQbynbgbtklqbn5bvJBGqvx20mN8SmU8uswr2Ko0h1ek/mqmTwyc/+GKlXS
	 1XJvVh15plLS1oDeURwbr5hS7gFwHSpnXKqsKNOt2aftcBkl+xEEkEXrhssiOvm8UU5l0
	 CaSq8+pW6cx89wFfVo1pgbmINOZyQnENZnFVdMCHqO9IuURmdRWHZwMn+E2607DFzKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596720;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dX3JEVRhx/vWlwQxJ/iqwhzvMvaIPgw/wLTA3isfI1M=;
	b=BPYN+HLtnJekGWEYaNGa4HRV6nSUc5jvERCCL4DY249X0Jqhbtv3rZVxMKoz18wyaMp+
	 4Jp05++qNte1ytiKTwAkqHLWCrz6mZMjYe7/fdzPN3CpxaZvyfGpftyKbi4mJWnWvmKG/
	 kbPHyDDDyxr3QOiPHx0JDy4ZxU0Ypsx/fj88eqR3dkTEiPzC7+1qZpRqwMPzFlvA54ipK
	 /8lgTFvTxhf3Xxl69SjcNSiekLTyJcpZETmGbGX5Rd3nU1CqLrK/YoSqmKEL+betMZ7C4
	 76FpJH4QR4kkC+aqp9QAqwKKwjdP5NAJTbJ/YdoQD0uB52fP0Z4QF1Rn2R7cB3hx9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DF606A321;
	Wed, 25 Nov 2026 08:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7261866ce8ad11f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:99bff6ad-bb37-4aa4-a860-64fc8b30cd03,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:99bff6ad-bb37-4aa4-a860-64fc8b30cd03,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:0e3476b13cc8e03fb9e0fd0fc43405a2,BulkI
	D:261125165151PWJ4DRX9,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|136|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,
	URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7261866ce8ad11f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1440950153; Wed, 25 Nov 2026 16:51:47 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Micah Morton <mortonm@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] security: safesetid: use real GID for GID policy lookup
Date: Wed, 25 Nov 2026 03:51:43 -0500
Message-ID: <20261125085143.1577709-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com> <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
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

On Sat, 3 Oct 2026 19:34:15 +0900, Sung Byeongchan wrote:
> SafeSetID policies constrain the ID transitions available to a task for
> each source ID.  id_permitted_for_cred() always builds that source key
> from the old real UID, even when it is checking a GID transition.  If the
> real UID and real GID differ, the policy attached to the real GID is
> therefore missed and the lookup can return the unconstrained default.

Reproduced the bypass and verified the fix on arm64 under KVM with KASAN
(v7.4-rc3-178-g20eef29b7c84, CONFIG_LSM="safesetid,yama").

On the unpatched kernel, a task with real UID 1000, real GID 2000 and
only CAP_SETGID reached GID 2002 under a 2000:2001 GID policy via
setresgid(), setgroups() and setfsgid(), while a matching 1000:1001 UID
policy still blocked setresuid(1002). With this patch applied, all three
GID transitions are killed with SIGKILL, and the allowed 2000:2001
transition, existing-GID transitions, the existing safesetid selftest
and the new test in 2/2 all pass with no KASAN warnings.

Tested-by: Guicai Ma <maguicai@kylinos.cn>

Thanks,
Guicai
