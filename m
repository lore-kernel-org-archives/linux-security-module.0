Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07651315D24
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588497; cv=none; b=mvYvfHMDGQPY4wGYCSWqVJdlbPLEF1FqaW8ZVAU9OPXwAJQl5Ew8IFMpQo6mommpSiAquq2BdYxjLUUi5+gS2+KdZFoUavcuveYkuSsebdsYh+fnaMwac6zQtahRmeqhYobKGldcxlUrfk610td23qkkRuYRITc7GOBjf0Q3Y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588497; c=relaxed/simple;
	bh=139RHeBRJch3/o96dUC9xpIznk0PJ3HD88auYokglPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dBmkhEeM5l9z6WgLnUzaa007ZnmheubexIh0VZmSQz3vHpT1XGsdUBVK87eoxZDCLUpPMuPrjoIDh3oVahbn6WSPIKCtuR++LuPTtVPST/BlHzp0uHirLvoMuE7JCWc3p0nMlTWAm4qTfiw3arCmNPv1f4JRszMPaTeQxQ+b9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=kVsf1m4K; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="kVsf1m4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1761588488; bh=139RHeBRJch3/o96dUC9xpIznk0PJ3HD88auYokglPU=;
	h=From:To:Cc:Subject:Date:From;
	b=kVsf1m4KaO+U6nwhftwN0R6mEpFBCyuod2BM/3l9iSwbsMya+6l+bjU5l5K3vLbLp
	 c3P4SmMAG2Qc//ALkbc6s+XLtU1DLrVS2BuPHNaNU6Lo2W7WS2dfcT40Bxq52n82F5
	 4d4ZlW0fatmvMvVpu7S2D0Xx+Gj+nhuIbSiBt3UgcSompWl9//JDYwK1caD6siTjux
	 bYjbBJTUs5hzNuW5XLA/F3fu4wxGfVcGXS27G5tIItynXY0FlROgx7pooZBCSY2UdU
	 6Du0+3vagRyAJ5XPZoFBtxU3/1r7m9/CG100LcQO2VoUDcfrtYHEDjHSndU0KjJjRa
	 JoaYoKOyHnfHQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 1F499125405;
	Mon, 27 Oct 2025 19:08:08 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 0/3] Fix TCP short AF_UNSPEC handling
Date: Mon, 27 Oct 2025 20:07:23 +0100
Message-Id: <20251027190726.626244-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Günther, Konstantin, Mikhail,

Here's a small fix for userland behaviour+error consistency in TCP, in
the edge case where userland uses an AF_UNSPEC address consisting of
just a bare sa_family_t.
First two commits fix/add test cases (which then fail), and third commit
patches current_check_access_socket() to make these tests pass. There's
more than one way to patch it, I just chose this because it should also
make it easier to merge UDP support (soon if this goes well).
Feedback welcome!

Matthieu Buffet (3):
  selftests/landlock: Fix TCP bind(AF_UNSPEC) test case
  selftests/landlock: Add missing connect(minimal AF_UNSPEC) test
  landlock: Fix TCP handling of short AF_UNSPEC addresses

 security/landlock/net.c                     | 118 +++++++++++---------
 tools/testing/selftests/landlock/common.h   |   1 +
 tools/testing/selftests/landlock/net_test.c |  30 ++++-
 3 files changed, 96 insertions(+), 53 deletions(-)


base-commit: 6dde339a3df80a57ac3d780d8cfc14d9262e2acd
-- 
2.47.2

