Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9A371890;
	Wed, 17 Jun 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719528; cv=none; b=Ik5v9yZ2IRI1kKeRyPlOntTMOPw7dX6BSlBVT/4Ow1eZvD/idc5FZI2o1otvaN1xNNSVubDONVQgc0UAyiVWKgyEubQTSYDvcWxrwl8GigBFE6Ldvy2dtvdxKPV0QkT1kbyc6v2AASjC2q2esvk/ZWkn5Oh1rbezQWFT+9m9J1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719528; c=relaxed/simple;
	bh=/FgkYP9syTYmexU5LLVTc9MZQDepe9QOqP1BEKT3OPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSzLQrdziT6l2n78DKOiiFsTLjiM8lX5MZUDykOMKkYjMoPEuxF3NTopCAAZfOIIDFv28pwtZPoaxKSuF+Ljm0icPfbCTTd2PE0qpyXmobIsjNdFi/kK1VsYjXngmXJ7we+Ig10AAsPwIP56ndTxKWivnFE8ey4ErwaopKhiuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=aKj6d2ZE; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="aKj6d2ZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781719516; bh=/FgkYP9syTYmexU5LLVTc9MZQDepe9QOqP1BEKT3OPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKj6d2ZEg4bn7e5Um68yvmRh3hRcvUk+nYwcRhoGLyZP0D28hCrn7oAm/beri55yQ
	 S36NdWeq0UEUpNC173NWEPc0uv7RRFrdFNyB6QF7HxIurGE8VoUYt2wMU+Qs5zF8jy
	 pvogavh+aP7mEqxniUegBEXjPujlMepP0cHuDIdKSy+U5re07NpmyPo25GN1Z4OD5q
	 AgBWi/DW7xd+epaOYZRL+11Kd02fEhYB3RJsQecpDIBgRul/DB06A+4JYg6wMFSEmH
	 xyFKZ7b9Ad6VfcowIZfUJQF/Q77GtRpPPSihuzPsZLpv7g4N949SXSDUREXNL5/pbL
	 1UUVX99kKdRtQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 0F41F12593E;
	Wed, 17 Jun 2026 20:05:16 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open
Date: Wed, 17 Jun 2026 20:05:22 +0200
Message-ID: <20260617180526.15627-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617.eemahv8ui7Ee@digikod.net>
References: <20260617.eemahv8ui7Ee@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/17/2026 4:22 PM, Mickaël Salaün wrote:
> Thanks for the report.  This was previously identified by Mikhail and
> Matthieu, see the related issue:
> https://github.com/landlock-lsm/linux/issues/41

(I worked on a v0 patch for that issue after I first reported it to
Mickaël, missing the fact that it was already documented as a github
issue. Then tried a more generic approach that failed. Here's the v0,
rebased on the beggining of -next to ease backporting, it might be a
good start. For instance, someone with more performance/benchmarking
background might want to add an unlikely() around the MSG_FASTOPEN
condition in the hot code path?)

Have a nice day!

Matthieu Buffet (2):
  landlock: fix TCP Fast Open connection bypass
  selftests/landlock: Add test for TCP fast open

 security/landlock/net.c                     |  17 +++
 tools/testing/selftests/landlock/net_test.c | 155 ++++++++++++++++++++
 2 files changed, 172 insertions(+)


base-commit: 0ce4243509d1580349dd0d50624036d6b097e958
-- 
2.47.3

