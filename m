Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A922370A;
	Wed, 23 Sep 2026 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133234; cv=none; b=LLuZ2YxtcUGHFaKkHMnDa6mt5k8Q+6W8+StqRsrx+GshMRh0oGw0Gxy3nrxAlX10203aDtfz1yagd1zq62PH70lnYumy/FPNINTc7/6eK9IIjI1lJd5kSvIG03rhO6LLAGmkW6kI9FViYDCeB5SGMbQhOUCLs888iGJ0WqXLEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133234; c=relaxed/simple;
	bh=eUMUnL09JgoZujcDjHD28pHpgwC30seBXRoiBjOBdwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EC8qZ773LMmO6w3dRexavlsPzzZVlRMcBhmxFD8rfEXmsahxYsnu7zYuunGa3jm5oyOU1c5MZHfaOeqSaN19fXspI0NgZ8O4cyHagRCatEVmD20kl9+rgUDUEYcqIKJmAi8zXObktd7y/bTtFuGOQ6RpxnX2wS9ogoZShoWtsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTgpM43k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTgpM43k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DB31F000FF;
	Wed, 23 Sep 2026 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790133232;
	bh=sp/75QJ/0AAJXaRRqRZ3WNxBQir5H7P0Ip1PtESnJD0=;
	h=From:To:Cc:Subject:Date;
	b=lTgpM43kzERrEFArVqO5RzJSmuN0R3kxJZQVGhGfhmef76Ztagmze9KrgoiLfruja
	 F77GomlmjD1zx156i6sPvTH2zV2ce+FXMfDrciM0RRuyTnYuxqgbAeXYtIbHeeKHHK
	 XtMIRIZV4487kpN8OkJWZb4rQALPzzkVHr/47PsWMrYgzWDV7AR0n+oxvUff2bqSfT
	 39Bc8waKX4oe9vzLsC8P9GwgOGWYK7ZKl1njY5lGdkvWnO6LfioYelMJ/oe9TOqRd3
	 S/+2wST9ngXRkCFdLrCf3kmgg+6TX0vZbbxbcBSn/xoJ7aE1X3280LAU5fo5l1VU5t
	 XnPD/LSmtTERQ==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ipe: fix two use-after-frees
Date: Tue, 22 Sep 2026 20:13:47 -0700
Message-ID: <20260923031349.1216431-1-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two use-after-free bugs in IPE, both found by a recent
AI-assisted code scan.

The first one is in the policy load audit path, where a concurrent
delete can free the policy while it is being audited. The second one is
in the dm-verity root hash path, where ->preresume can free a digest
that policy evaluation is still using.

Fan Wu (2):
  ipe: fix use-after-free when auditing a newly loaded policy
  ipe: protect the dm-verity root hash with RCU

 security/ipe/eval.c      | 12 ++++++++----
 security/ipe/eval.h      |  2 +-
 security/ipe/fs.c        |  8 +++-----
 security/ipe/hooks.c     | 22 +++++++++++++++++-----
 security/ipe/policy_fs.c |  3 +++
 5 files changed, 32 insertions(+), 15 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

