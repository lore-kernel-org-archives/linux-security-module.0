Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA62EA754
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662285; cv=none; b=PiSqfMnSatU1+8UTeHZah4uTi9xE2VUsNRSmi58yUSNfJT8nGFxvHTUcKRKJWMbrChFuWFT2/QDBDrhPcpLZUY3rrIISS88RzlGK56TQLNNOOBd9fkI2N36o6ftA5WoVjbibJ4uIax80eRlFz4/spgEvulvO5z9G85I+V4Tg4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662285; c=relaxed/simple;
	bh=YwP5qdJ6kXCII6fmfIxLrms5RJQr/mJtIUhROOX8g8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyts/9ijCEkXTWBV7WZXwn1GzUH7azgIjHkQRoSwR24LGeiPB1cRGvFRbjj8iGShD4VucWxkaMwyYVj5hHyqHcxn41qFphmSUnbuvidR8p6DWyFroQPcg5x7rAKEq1acbTepc9KIqoYCwCsAlLsyjXnMJ6y9a48t9VyLoofdEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=nfsQLeAn; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="nfsQLeAn"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1779662270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cnUOOH98TXRoKEWV2QEPtYAF15chDQk7eL2U00C9zxk=;
	b=nfsQLeAnxVFU+DyzD7QLXV6Y9aUqcS7VEh6AmZ7mUfkS+7snZp6wNsf+RJYfEFYER09djd
	JRN1uiuxqHzQ4gsC9Vv0hkKrGHIZoyhpK1+brFqmXCTmXU52eYmDEcYLwiGKKY6YAsRqVm
	poigMvicWWxP69oxGhXDvTxv4+m5xIk=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] smack: restrict smackfs/{direct,mapped} values to 0-255
Date: Mon, 25 May 2026 01:37:47 +0300
Message-ID: <20260524223749.50874-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both smackfs/direct and smackfs/mapped incorrectly accept
the full range of integer values.

2nd patch restricts range.
1st patch deduplicates file_operations code
to apply the fix in a single place

The patch set applies on top of:
https://github.com/cschaufler/smack-next/commits/next
commit b78fede1c69a

Konstantin Andreev (2):
  smack: deduplicate smackfs/{direct,mapped} file_operations
  smack: restrict smackfs/{direct,mapped} values to 0-255

 security/smack/smack.h   |   5 +-
 security/smack/smackfs.c | 153 +++++++++++++--------------------------
 2 files changed, 53 insertions(+), 105 deletions(-)

-- 
2.47.3

