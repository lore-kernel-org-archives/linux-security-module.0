Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7213D61B
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611014; cv=none; b=SkUbJkkyKtCeJoZVzjAAIHaBULRej6/HaEPO4MCa9j/Ly+N18BaPfUD4Dx7qQcgFd7/wwMbIN6YHmhczf7NGx9099+MMaATV1HgcvXSIhh1vfBEjTOhvzkgHLzJjIKJdYCVVoXjvDGW/abTrOD91UHh9nMu25/jkSepMf/ibO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611014; c=relaxed/simple;
	bh=G0oSHbfksbSu2t4D2EM01TYyXErs37ZXSLhARmf6ewE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSntrpoi8m6WDEX1wuK9gIFTXQwUBom18Qb6eEnHWiGtjx1MoSrL6h3OXeubZxcT6vkui90mF52ukOY1Vizo+fen7UIcJ3niu0hU8yFUJL/kv8JDnVn3HUAd59/D/0lC7WouxkEaOZ7glFBPhPTftTVc1ovlMyLFM9M5ezUhrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G+hD+cw2; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G+hD+cw2"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXwd343mTz14s8;
	Tue, 22 Oct 2024 17:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729609911;
	bh=DXcgCrfryIcs9aP8OkSnOzrenyom7Z7qj4jE4bpke9c=;
	h=From:To:Cc:Subject:Date:From;
	b=G+hD+cw2W5/DbQiqWwW1mzDSljuqB7v0uXhNqSG9LdxPRenxBsMNnSJBLwc1YAuaT
	 V3xN89IdIpOVn770l/MRBWU8FIDVhWBCV3EMmeFprI1w52+Dp1jPwIKDyOZ9k+FsiZ
	 YOvsumof9ben3fB06eMst7WHWHEkplVk3fIfePNk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXwd306MnzgrS;
	Tue, 22 Oct 2024 17:11:50 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/3] Refactor Landlock access mask management
Date: Tue, 22 Oct 2024 17:11:41 +0200
Message-ID: <20241022151144.872797-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

To simplify code for new access types [1], add 2 new helpers:
- landlock_merge_access_masks()
- landlock_match_ruleset()

This third version mainly use a new union access_masks_all type instead
of changing struct access_masks.

The last patch uses these helpers to optimize Landlock scope management
like with filesystem and network access checks.

[1] https://lore.kernel.org/r/3433b163-2371-e679-cc8a-e540a0218bca@huawei-partners.com

Previous version:
v2: https://lore.kernel.org/r/20241014124835.1152246-1-mic@digikod.net
v1: https://lore.kernel.org/r/20241001141234.397649-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Refactor filesystem access mask management
  landlock: Refactor network access mask management
  landlock: Optimize scope enforcement

 security/landlock/fs.c       | 31 ++++------------
 security/landlock/net.c      | 27 +++-----------
 security/landlock/ruleset.h  | 70 +++++++++++++++++++++++++++++++-----
 security/landlock/syscalls.c |  2 +-
 security/landlock/task.c     | 20 ++++++++---
 5 files changed, 90 insertions(+), 60 deletions(-)


base-commit: dad2f20715163e80aab284fb092efc8c18bf97c7
-- 
2.47.0

