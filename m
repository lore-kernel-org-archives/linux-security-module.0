Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F72BA4A
	for <linux-security-module@vger.kernel.org>; Sat, 15 Mar 2025 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742003872; cv=none; b=sWw1nMFFLVOGf0bVOuLW14eXVrVxl9hAxJg7NVUP5SluvQLEnFemzGhR/QaU0csz7srXX/NHfmv4INkXqU0Sy+nWUEvTx2OLMuIp1VpxSQmc4Wt5xEL/7dMErfMczHT9YzFRDNL0124pXRgGgZarjfQ5xH1mcUaghHIUAKCTLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742003872; c=relaxed/simple;
	bh=+kEZGOvWw7PVACn/cS2PW79pN/SYazug9Li0FjLsH94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvIDBOCcQEtvVPS2PQIisw+FAntx5nwW4KBBZei2ospNxyAnBWwR4GOkwEraz7piAuYC3ahkrk+ofEEWvnvAy+4tERpdowo9v6vTB6GaAI/DzOqJ6P9kEpLv0wZFIHtdmT5yDH39tdj/2yzPlQukNR6JweJWz3QfLuq8pih+d44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=KHL7kxvT; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="KHL7kxvT"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742003857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=66j4MLNqlQfoLx1DNTLBp1U095SjHv/u10Rz81Onz9E=;
	b=KHL7kxvTVfpUEiug5CLABbtVH/a3hR9wbEz1AJOkvJOOnYFhHfPdaOLn7Oouuq1KGBZUHJ
	i5NxBd9BCi1K7T0kQ9ouL5yeC1SlzQRn191NsWfnlmkX+1rXxJ24Kv+8tqglSSDXU6je28
	97vO8UDiS3NSPI5K69IfX4NMXhZ+rJQ=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] smack: fix two bugs in setting task label
Date: Sat, 15 Mar 2025 04:57:12 +0300
Message-ID: <20250315015723.1357541-1-andreev@swemel.ru>
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

v2: see individual patches

Konstantin Andreev (2):
  smack: fix bug: unprivileged task can create labels
  smack: fix bug: setting task label silently ignores input garbage

 Documentation/admin-guide/LSM/Smack.rst |  11 ++-
 security/smack/smack.h                  |   3 +
 security/smack/smack_access.c           |  93 ++++++++++++++-----
 security/smack/smack_lsm.c              | 118 ++++++++++++++++--------
 4 files changed, 164 insertions(+), 61 deletions(-)

-- 
2.43.0

