Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB51B142D
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459188; cv=none; b=lpxwV2lhuTZ3SSY5FHGpCNhaIJ1Vw7UzEGnw9pD2naY7n6csojl4QIlDtfYX8lla77izWAo5doufHknPr6idJ/jChMOkDUxDm7NTx4KCIMZI1retwPJQfptrxOuTaUazw7KhovBYt6r7+YpR+Z8H2GMC/TZA85NQzF2+kPgrrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459188; c=relaxed/simple;
	bh=H+h17eP25qcXAZaPPod2/oqrUAVfjjdtQhb6LycYgvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rvC5cMBem1PhjYtoYFJD0JnnXv8uymmcxTbvRQle0oPmGqFkI4hmaARFVB1znZOCrLr7K73DyWIqLagEy9mt4vtmxo2g9YOL++ZS1OeiUPav8zom4lsJeyX50hiey/yE+YJ3c+G/kmnp2vfvMFj9i8Deg2p7Nl+3if99L9uhBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=wfQX/D+G; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="wfQX/D+G"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1778458637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wow6AEoya5Us8IwT6dPOE/DzOyA+KGzWrUvRIBJve14=;
	b=wfQX/D+G/0DQ9q/PeJka0ia6d2hBMgWlimA0szKQN/WD2/aY1lRgJgY+0E94Jo2TExZT+c
	XiaQyJptzu9RYkfuh9k1z4QA2++kmjeNii6Uu/OekMfy0s79fn7+3O6FEFhBCN91n3MRxK
	+WCD5XZ7pE/wAbLKfGs+JDor5qgdA1E=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] smack: fix incorrect task context in smack_msg_queue_msgrcv
Date: Mon, 11 May 2026 03:17:15 +0300
Message-ID: <20260511001717.3522345-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 1st patch in the set is the fix itself,
the 2nd is a followup to resolve an ambiguity in the audit log.

The patch set applies on top of:
https://github.com/cschaufler/smack-next/commits/next
commit b78fede1c69a

Konstantin Andreev (2):
  smack: fix incorrect task context in smack_msg_queue_msgrcv
  smack: show msgrcv() subject task in audit

 security/smack/smack.h        |  1 +
 security/smack/smack_access.c |  9 +++++
 security/smack/smack_lsm.c    | 67 +++++++++++++++++++++++++----------
 3 files changed, 59 insertions(+), 18 deletions(-)

-- 
2.47.3

