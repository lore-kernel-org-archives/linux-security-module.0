Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F311D63E4
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995914; cv=none; b=oklkzWfDQGuAG6MPCZpSAuAFvgHAzG/rm9rMy8ltDx4B7vbs+duhDRgO7YfR2nOX2eKZOI+vwlhJx3WsjgEKEwuONkKb3mIyiUCASncCzxAgEuit9WnGHyv7IBKQuJEiOoRqV/5k4UmIo1RjLXeSI9j6kZWaJ8+xBxEQbcId4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995914; c=relaxed/simple;
	bh=GeFRw1uGi5DDzGaOmT+kjDg5MDlxQlwDTD54KzbYB3s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gMS82+49DEe2WaEFzGUPY/Q0Td/W7tuUhUm8+vNuw5Qk1YGRWZqa1cqE5+nerLbHKMNU3LdEniiM3Wx8+1Fg3gbrF2B+5LzZUE4e+dUvgm/GxlCNKTizuLHqdX4seAcERalTBsoAgrYvH4TEuycIjiNPNTm87ysTvlWHcRha8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNVIwPKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNVIwPKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4FF1F000FF
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995912;
	bh=F2t9SsKMACU7YmqxdXiLeWnedh5R70DIn4OAGX4w4i4=;
	h=From:To:Subject:Date;
	b=mNVIwPKXdfwgL9l5BdLlkR0/tNsYBpVujaOQiF0LZiUB5fnKJIIjpzOvo8tqTDAXI
	 0DCRIRW7ea978tZjyvg3r3MNo5YCLirsKtMFe6n4lQEpDnhY089VWpzN9MdF0Or0Y0
	 08WFLtp3x7/sM64qczlh01FgIuvIuvOS/BdsGVniVcrvTVJalkX571DqpY2+nUqUWc
	 yTHQ7sx/BZYV+dTYE/SY1xPp4AAOEximTnrYgxYHjN5wAqqNmHyeVVzYSlZNkAYwOS
	 A08Xu+7FZ2hveCcCTx3UDjCWFOfMJUAjCc3RHpF7vTOBg5nOHK8VHHQkjQULANtyzM
	 dX6i3W6ocIbRQ==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 0/6] ipe: cleanups, an audit fix and updated links
Date: Fri,  2 Oct 2026 19:51:29 -0700
Message-ID: <20261003025135.3666767-1-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains small IPE cleanups, a fix for an extra empty audit
record, and updated documentation links.

Patches 1-4 are cleanups with no functional change.

Patch 5 fixes an extra empty audit record on enforcement changes.

Patch 6 points the documentation to the new IPE website and test suite
repository.

Fan Wu (6):
  ipe: constify token_default()
  ipe: use designated initializers for audit name tables
  ipe: check parser token table sizes
  ipe: correct policy text ownership comment
  ipe: fix enforcement audit
  ipe: update the project and test suite links

 Documentation/admin-guide/LSM/ipe.rst |  2 +-
 Documentation/security/ipe.rst        |  2 +-
 security/ipe/audit.c                  | 52 ++++++++++++---------------
 security/ipe/policy.c                 |  2 +-
 security/ipe/policy_parser.c          | 10 +++++-
 5 files changed, 34 insertions(+), 34 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

