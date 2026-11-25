Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596721;
	b=ekGzGsjWzhCMXFCCXeiy1IN2N9tbniblBObPxdha/sKrN0zsK7jVygiQDTSRIQU+vJpd
	 8wkXQn2aQosdmZf1fU/xqRvhOob+yNy5TrICZaoFASZEZ9dIUhxbqInjSBjD5G7cn6KXN
	 VWRMGOW1bW4yVcVVxhPm8O1DSfbQjJor/B/aEJI1RCAJ5T4AlZDirSe1oKkkfqmskTd8D
	 SYwha1vgzXGmDKvqagl51dYgd1IAnS2ywjKszPPNODn51K7mtBE8397hN3mz8E4p1+Jhk
	 2JzuBl5BLwRvbfl3EKN8uWazAQlPy3WxAbnvqJdeCl1NACocHOR8d+BDIi9785DJCqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596721;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xkBQOJtHC0lvEY+rBYunFY5GQKJ3kOPXvh+IUTXWI0g=;
	b=T5OmNa+akpgJ7vJCErkpP5Z+bY8C5qb/7Dp3OJmO63aQn910lECTxHG8JjLmyWzgce20
	 nzPDrW8ncV6Cz31/p2GjZUOAdjpiq/zkw1+0tYGQloq1MHL604uK1iWwSa/HrQaLeRgrG
	 XE7jBOpMBlJ0+ibyWxRvnNKFNIDFbQDbklVOB6AnESwingK5iq94zeZgz+uemCE6P6hfn
	 Rf1eftsdRwmvP8bdayJXgta29P9nOcCl2aNfpeNL/rnHRzNyv1rdRlfmuhdEP7qpiw8uS
	 MnMswpHfJkSEAA4CYsjnPj0jAzdUSvUdoZ/af8L4GOYoV6lNqBVZpfhhrmJYDNbiH0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1632606A323;
	Wed, 25 Nov 2026 08:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1632606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7499e49ce8ad11f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9832daa8-c891-441e-8720-9dc9578cd3bc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:9832daa8-c891-441e-8720-9dc9578cd3bc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:8a5213e8bdf8dcb89ad097d2b2b49f7b,BulkI
	D:2611251651543Q3MVRI4,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,Fil
	e:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7499e49ce8ad11f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 145562270; Wed, 25 Nov 2026 16:51:50 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Micah Morton <mortonm@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	James Morris <jmorris@namei.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/safesetid: test GID policy with mismatched real IDs
Date: Wed, 25 Nov 2026 03:51:47 -0500
Message-ID: <20261125085147.1577733-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <899af06e29dd599246082096e27edd51eda1fb27.1791023194.git.tjdqudcks0424@naver.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com> <899af06e29dd599246082096e27edd51eda1fb27.1791023194.git.tjdqudcks0424@naver.com>
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

On Sat, 3 Oct 2026 19:34:16 +0900, Sung Byeongchan wrote:
> +#define GID_POLICY "2000:2001\n"

Because 2001 has no self-rule, verify_ruleset() logs an "insecure policy
detected" warning and inserts 2001:2001 on every run. Adding 2001:2001
here (as safesetid-test.c does with 2:2/3:3) keeps dmesg clean.

> +	policy = fopen(GID_POLICY_FILE, "w");
> +	if (!policy) {
> +		perror("fopen gid policy");
> +		return -1;
> +	}

If SafeSetID is not built in or enabled in the active LSM list, fopen()
fails with ENOENT and main() exits 1 instead of 4 (ksft_skip). Returning
4 on ENOENT, and adding CONFIG_SECURITY_SAFESETID=y to
tools/testing/selftests/safesetid/config (like landlock/config does),
would avoid false failures on kernels without SafeSetID active.

> +	for (i = 0; i <= CAP_LAST_CAP; i++) {
> +		if (prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, i, 0, 0) != 0) {
> +			fprintf(stderr, "unexpected ambient capability %d\n", i);
> +			return -1;
> +		}
> +	}

When built with newer headers and run on an older kernel,
PR_CAP_AMBIENT_IS_SET returns -1 with EINVAL for unknown capabilities.
Checking `== 1` (or ignoring -1/EINVAL) avoids false failures there.

> +	pidfd = syscall(SYS_pidfd_open, child, 0);

Using __NR_pidfd_open (with an #ifndef fallback like selftests/pidfd)
avoids requiring glibc >= 2.36.

Tested on arm64 under KVM with KASAN (v7.4-rc3-178-g20eef29b7c84): the
two forbidden cases fail on the unpatched kernel and all four pass with
1/2 applied, including when run after safesetid-test.sh in TEST_PROGS
order.

Tested-by: Guicai Ma <maguicai@kylinos.cn>

Thanks,
Guicai
