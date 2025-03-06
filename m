Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD927BF7B
	for <linux-security-module@vger.kernel.org>; Thu,  6 Mar 2025 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301545; cv=none; b=MM2ACaIPB5IS2DlBUS316d5VtEVjCi1znEyu3BhrbHBKg2/THb4KfODIvaAo43YrQR2Qui8EWHqw/ya5rxp7bVkKnqPpVsDA7K49nwU943KlLY0R6wuAWO1Yf45+FZkhN3fyL52izQuxTtN/XPLUJ2egWZX/Hk00clBzYhOdY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301545; c=relaxed/simple;
	bh=bLdkRwqv0NGub04Yap9M/BupDFpWFTorx5fYfbe09sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1jqmcQ3KaC6fizRgHmYUM9DIrkq/NoiLkkGYEark+trg2TEYVN57lVZEkE8djymb8Fe1ZrSs8P2mXW0wx1EXwW+kPbVUAIoKLdnZ7BrHs0s7nlrt6P4pkBtYZl9BHVkSI6Lo6V+jSkfKYAdNX2dCyIvQEeRApwBGsnLO5QDx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=tc08pqmm; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="tc08pqmm"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1741301006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ulyI95aPz1KYh7PUGBCxs2uGCwrE3yGBj9vuSnKxPNY=;
	b=tc08pqmmh/uqf3GyYbohU+xazyP14l0L65P2Ez8SXiuwtts6Dqh9jSGAXXa//Xj+5OATUW
	n2DOHSAK3Uo2vhHgnCEnJdazCUEtm9lOOmgi7VDMWT5hbsIP4TxcJbmMMQ67XSW6/X6xn2
	mhOIkTMn6S89HKoVyUJmqI/r6Lg6kNs=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] smack: fix two bugs in setting task label
Date: Fri,  7 Mar 2025 01:43:01 +0300
Message-ID: <20250306224317.416365-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches have distinct subjects,
but work on the same object,
  security/smack/smack_lsm.c`do_setattr()
and the second patch partially overwrites first,
so I combine them in a series.

Konstantin Andreev (2):
  smack: fix bug: unprivileged task can create labels
  smack: fix bug: setting task label silently ignores input garbage

 security/smack/smack.h        |   3 +
 security/smack/smack_access.c |  93 +++++++++++++++++++++++-------
 security/smack/smack_lsm.c    | 104 ++++++++++++++++++++++------------
 3 files changed, 143 insertions(+), 57 deletions(-)

-- 
2.43.0

