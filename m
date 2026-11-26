Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663891;
	b=ud+whLsXj+JVd/patSnzStvnJ10KWiUBC30fKRSjXNSz8rnIlFYMcshm/Nxi37XwW/FW
	 uuXO6CqR3YDVl0VUSWmAPe4rv+Jf3DKZlrY7V4weqHLcVMdZITKfJl0vH3Qlwui/Hdyi5
	 G91tfognxa6m/WaFXNAdTLXQWyy+lInO+7r8bQg+9kkesu1VdUmhnq29cpSq011W7T8KU
	 TFu1XsjXyFKBWoKuTGBMGZo7OX4Y8cl6HSkK1StbgW2p0l7woG3LehjPm/Alc6LEJUZx2
	 vy3+MkmUc5FDxBfwU1rg8S3esqeweB8oAEm+TdmU1ANSceOFSP5hjrgBDXRZwayH/tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663891;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hGket08iJYS6YeIw9llyXX8ay57TRzhoRjjt6RJOasI=;
	b=HERm09BF2jMn4KwFVvX9EKa4h0lC9e/qfkilG6sdtIWYo98e45nIK73GFetaIeMf96hK
	 mmUMAQJp3iubaaG3JoMuFXS6igF0f7eKYVev1C4y04gfiKUOcXQ4P4Cs+KUmc2yHB8y6K
	 uglS1yaeJ+7X/oFbKbmqsvnWjidYP6XcjfPbpxCeQmAgsomVr7QgIm8JZs7TtAuA8a+2G
	 u5rjzEHbu/LDvTom2S1WgVSvM3Dk5wRZyl8bk0MdpCK3LCaZeVPTcmF4IU20Gy/Vg3cKL
	 Vuq+N2j+bRxonQ/GeUMaS9K+uddl/4JNCQl/VwizwmiuuE5miv5GRXvX9zcO14lfqYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A94606A31E
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 03:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A94606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d5baf526e94911f19a56ed5b684f684d-20261126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:601d1203-49fc-40a6-9cd9-8b40bf9f4b71,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:601d1203-49fc-40a6-9cd9-8b40bf9f4b71,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:e13a4e6ae48a3f18d2f4b5f35879e92d,BulkI
	D:261126113118P5SRBDUF,BulkQuantity:0,SF:17|19|66|78|81|82|83|102|127|136|
	153|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:0,File
	:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DK
	R:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5baf526e94911f19a56ed5b684f684d-20261126
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 168794696; Thu, 26 Nov 2026 11:31:15 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Alejandro Colomar <alx@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: Add missing const
Date: Wed, 25 Nov 2026 22:31:12 -0500
Message-ID: <20261126033112.2007696-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <41df4fcaea9d5eb41d07ffb4119621fb2f233b79.1795630921.git.alx@kernel.org>
References: <41df4fcaea9d5eb41d07ffb4119621fb2f233b79.1795630921.git.alx@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The change is correct: after this point split is only read, through
pointer subtraction against *ns_name, split++, the strncmp() against
"//", and skipn_spaces(), which already takes a const char *.  strnchr()
returns a pointer derived from the const fqname, so the qualifier is
safe and behaviour is unchanged.

Built security/apparmor/lib.o with the patch applied (arm64, W=1): no
warnings.

One note on recipients: get_maintainer.pl also lists John Johansen,
Georgia Garcia and apparmor@lists.ubuntu.com for this file, so I have
added them here.  The posting only reached the LSM side.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>

Thanks,
Guicai Ma
