Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611595;
	b=RaVbH7XmWX/tQSUEgS5hfewYkXWv9F0fA4ljV+BKw1aAu2GeEmSPEuIl/jSJmZ0Q68Dx
	 pqWbme4NX5wXquItaOyTCZ80zY2kkF00wCgaku1f+oqWjokyA6FNdLNgGq5T4EyTeSui9
	 Wvmo3D+MAMaGrgh6atiyY0M8dBnUb1EkX7bR2arE3AKeffXAp4Ercr7++S70/eqUIZV5U
	 PkxUsj3h5lUO/oFVlyJYXX5in5inf55r8eIa21xlhOVzMmvrzOzeFVzOEJXCeh7XG304q
	 p9ZyDz4z5y0ZhwsDwNerOII2a4iaPSGnMxKw/p6rPvw3ur35dDsvRP9RO1F05QWMSLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611595;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Oz3Sg2286vdogq9Q4FAdVDvDlIdy4qx1XTFTIaQMdP0=;
	b=gIe4b7u1emL+DlusowlY9zkKxqZvi25sKoI80Iou5esjxy/Xv6AFRdYObXbWdIrSi33R
	 yHcYuGY3FqeFGj7pSzyqLlZvzFVjVYYL37dmBUo8BIKklGzrcvMUARmORwnodxktndgfH
	 lXVhY66pwU0BDS4NHNwGTUOCy7GxZC2YcI73eyRvEwN98T8QNN6kchiH12Vgh+mleX4iA
	 bfMvVYvlxmuYrhJd/kJwnkRimriHmiDAFLoOROzPyOaoGdsMyE0hZ53QdPTRU7dgEcTnl
	 RCSkKzk9ON6Qy3nkAAioErE4OaGfOcprA7wEAvPAww9mG9WZBjhZF1h1ievZ/cMYtxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885F606A32D;
	Wed, 25 Nov 2026 12:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6885F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 178704a6e8d011f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cc248436-75e0-480d-913d-5473fc487b15,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.19,REQID:cc248436-75e0-480d-913d-5473fc487b15,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:7db8b62,CLOUDID:5e38f9953fc0ae00a7900448149155f6,BulkI
	D:261125205949LFIJQMAI,BulkQuantity:0,SF:17|19|66|78|101|102|127|153|850|8
	65|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 178704a6e8d011f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 313751556; Wed, 25 Nov 2026 20:59:47 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 0/2] selftests/yama: add ptrace_scope and PR_SET_PTRACER tests
Date: Wed, 25 Nov 2026 07:59:42 -0500
Message-ID: <20261125125944.1768182-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
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

Yama has no selftest coverage.  This series adds a new selftests/yama
directory: 1/2 provides the scaffolding and covers the ptrace_scope
sysctl and the attach matrix, 2/2 adds the PR_SET_PTRACER exception
tests.

The PR_SET_PTRACER lifecycle tests exercise the same grant, replacement
and revocation semantics as the recent tracer-lifetime fix linked below,
and pass both on mainline and with that fix applied.

Scope 3 is irreversible until reboot, so it is only tested when
ptrace_scope is already 3, or when YAMA_TEST_NO_ATTACH=1 opts in.
Privileged cases are skipped when the capability set does not allow
them, so the tests also run in restricted containers.

Tested on arm64 (QEMU/KVM, KASAN + lockdep): 10 rounds of both binaries
as root and as an unprivileged user, plus a final ptrace_scope=3 pass;
a boot with lsm=capability verifies that every test skips cleanly when
Yama is inactive.

Link: https://lore.kernel.org/r/20261123165357.4092273-1-bsdhenrymartin@gmail.com

Guicai Ma (2):
  selftests/yama: add ptrace_scope selftests
  selftests/yama: add PR_SET_PTRACER tests

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/yama/.gitignore       |   3 +
 tools/testing/selftests/yama/Makefile         |  13 +
 tools/testing/selftests/yama/common.h         | 233 +++++++++
 tools/testing/selftests/yama/config           |   4 +
 .../selftests/yama/ptrace_scope_test.c        | 452 ++++++++++++++++++
 tools/testing/selftests/yama/ptracer_test.c   | 403 ++++++++++++++++
 8 files changed, 1110 insertions(+)
 create mode 100644 tools/testing/selftests/yama/.gitignore
 create mode 100644 tools/testing/selftests/yama/Makefile
 create mode 100644 tools/testing/selftests/yama/common.h
 create mode 100644 tools/testing/selftests/yama/config
 create mode 100644 tools/testing/selftests/yama/ptrace_scope_test.c
 create mode 100644 tools/testing/selftests/yama/ptracer_test.c

-- 
2.47.3
