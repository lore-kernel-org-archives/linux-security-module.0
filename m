Received: from cvsmtppost18.nm.naver.com (cvsmtppost18.nm.naver.com [114.111.35.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286A3AFCE4
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024274; cv=none; b=ukv303RbKHiiygvG775V1pZNbNFjVphCQ9P02vD3p8U2YQvi0fvhhDfwrsQFcUCPTfxbTJwD1Myma+6sFnlEjQHIemIUqSdPO7MDO+lsdMJboT7nZ46OC1klz8VQQnyAfGWpP2kdZHDcfYsy3JgtWJ2KsXJvoB7RjjOdVK9o/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024274; c=relaxed/simple;
	bh=Wb0dFAJpmkwfOvjIUFoVjAV28IRGDfkROO7BQa7lccI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qy7fIO7O4v3qLkrWIhUXnypajoV9K9vzMvZwy4oCQvndKJOvlsfiyvjkDFgLkW1cyPlKpFugP7M6qzL09UjCSuSBwDpZ63EbZVpD7TSfV2ofxZOUh+JsKt80v+BzDjuBOfom2npxEwdXLF0exAyLY+KlVGjMeuzAkb3QR+Ga624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=kMiZzspM; arc=none smtp.client-ip=114.111.35.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="kMiZzspM"
Received: from cvsendbo024.nm ([10.112.24.41])
  by cvsmtppost18.nm.naver.com with ESMTP id zlYsx8lCSwO15dnrLrG7gg
  for <linux-security-module@vger.kernel.org>;
  Sat, 03 Oct 2026 10:34:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791023664; bh=Wb0dFAJpmkwfOvjIUFoVjAV28IRGDfkROO7BQa7lccI=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=kMiZzspMzqsBt5soNjNqtxvoTpHIPLTitz9L6mzdQsfOX1REiL+PCAMiPb2GytnKp
	 YBGcweYCTIcuOSCht6ofsFfBltoOuYVNR2VS9a4n2RsLUygwiZ9V/btWShjYCA/QDt
	 lQoBUv8kNJSBqENF2hRk3YzOPFJPiIgETbScAe6LxSgsEdwwnmXERXUvRjNFBh3GQi
	 gss3vmDHZ4xxKwy61YejNMztj4yN7Wku99jq/1DX7Aip5ZRNZwQMvGwggItnOdVRAL
	 yWdJe9xud1kxaTi0e+DpUWx9YfZhxvMn5vKWKjGz6S/k/WCrYqgpE8pUszQRxsZzxD
	 r4wgj3C4sBl+Q==
X-Session-ID: rWvFZbFrT7mKg33r0C8FkA
X-Works-Send-Opt: O9RwpzGdjHmdKHFOMr39Ko3YKHmwKBmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: AZKlaxglFqJZ+HmqFoUw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp007.nm.naver.com with ESMTP id rWvFZbFrT7mKg33r0C8FkA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 03 Oct 2026 10:34:23 -0000
From: tjdqudcks0424@naver.com
To: Micah Morton <mortonm@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Cc: James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Thomas Cedeno <thomascedeno@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH 0/2] SafeSetID: use real GID for GID policy lookups
Date: Sat,  3 Oct 2026 19:34:14 +0900
Message-ID: <cover.1791023194.git.tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sung Byeongchan <tjdqudcks0424@naver.com>

SafeSetID GID policy enforcement first checks whether a policy applies to
the old real GID.  Its per-target helper then incorrectly constructs the
source lookup key from the old real UID.  When those numeric IDs differ,
the helper can miss the policy for the real GID and return the
unconstrained default.

The issue is present at Torvalds mainline commit
e767a4ea70a3992c37ed604157d32f0dfbf9b1e3.  In three clean QEMU boots, a
task with real UID 1000, real GID 2000 and only CAP_SETGID obtained
non-allowlisted GID 2002 despite a 2000:2001 policy.  The bypass covered
setgid(), setegid(), setregid(), setresgid(), setfsgid() and setgroups(),
including supplementary-group acquisition and access to a synthetic
group-protected resource.  The acquired group credentials also persisted
across exec.

This demonstrates a SafeSetID GID policy bypass and group privilege
expansion.  It does not demonstrate direct UID 0 elevation or a universal
local privilege escalation, and the CAP_SETGID prerequisite is explicit.
The security boundary is that SafeSetID was configured to constrain that
capability but failed to enforce its GID allowlist.

Patch 1 selects the old real UID for UID checks and the old real GID for
GID checks.  Patch 2 adds a focused regression test for mismatched real
IDs, covering both setresgid() and setgroups(), and records the SafeSetID
selftest path in MAINTAINERS.

The vulnerable and fixed kernels used identical debug configurations.
Across three clean boots per kernel, the vulnerable matrix reproduced all
tested forbidden transitions and the fixed matrix blocked all of them.
Allowed, existing-ID, no-policy, no-capability and UID-policy controls
behaved as expected.  The existing SafeSetID selftest passed on both, the
new regression test failed on the vulnerable kernel and passed on the
fixed kernel, and no KASAN, UBSAN, BUG, WARNING, Oops, panic, lockdep,
refcount, hung-task or kmemleak finding was observed.

A reproducer and the complete QEMU validation logs are available
privately on request. They are not included in this public posting.

This finding and patch preparation were assisted by OpenAI Codex.

Sung Byeongchan (2):
  security: safesetid: use real GID for GID policy lookup
  selftests/safesetid: test GID policy with mismatched real IDs

 MAINTAINERS                                   |   1 +
 security/safesetid/lsm.c                      |   8 +-
 tools/testing/selftests/safesetid/Makefile    |   4 +-
 .../safesetid/safesetid-gid-policy-test.c     | 252 ++++++++++++++++++
 .../safesetid/safesetid-gid-policy-test.sh    |  11 +
 5 files changed, 271 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/safesetid/safesetid-gid-policy-test.c
 create mode 100755 tools/testing/selftests/safesetid/safesetid-gid-policy-test.sh


base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
-- 
2.43.0

