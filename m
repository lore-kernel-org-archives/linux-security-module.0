Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B425A630
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071422; cv=none; b=oeKAUICXTXt4FqF94yGjgMzvXWbCri6kjMLXSJYfjhMi4jwC34loQTJu3pmquzOEBxeKbPsluksoTDEchoOa1F7Vm5Sr+++UKwIHwe+VNF5kvNlZ/7KTQ30D9lM7adBWgt2tX81EXrN6DROFLHLoRaeT8O+MX3+98KXBYorgn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071422; c=relaxed/simple;
	bh=0uIbOvY7vWLYycAlhK8VqXbafkYeZ7AeUEGvVs34E2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4u2ZwfgVmS3q7yurIpoxJkoRfYmxRv6DDeTD+HRzIOb19v5zE2L9E1341aiqnLce++hUjby364xzv1oJuwM1k7lnvY8MScS7meHAhxCMYB9AB7qjw9RhYWHEoTYEf3EKkM9Kt9JsGHuxAfzscFHy/COaFLtJG3AxPPkgeV70yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=jvtuN4Kr; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="jvtuN4Kr"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737070875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SJK6O2euHswKcvpPtpkf+nTNWFV/9JASqjlvapynFiA=;
	b=jvtuN4KrhdBSeMf7HaPHXkl+iQAMAD22xTH8SnwpWQLjc7PyO0rzdYU0cJLL/n0Rzpk6vQ
	Eg5+9IslkYyeg2xDhl5nOMCaFWTGIalTbftekZmmkhYRL5SmEgRqSOIi7YzqxlWudjPZ8l
	L4V1ERGUvkVzjB6cvfnpRdU95GM0uLA=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] smack: recognize ipv4 CIPSO w/o categories
Date: Fri, 17 Jan 2025 02:40:32 +0300
Message-ID: <20250116234043.2904723-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before [1] SMACK did not recognize CIPSO w/o categories (sensitivity only)
[1] tried to address this, but did this wrong.

The 1st patch reverts [1],
the 2nd patch addresses CIPSO w/o categories better than [1].

[1] https://lore.kernel.org/linux-security-module/20230124105037.23108-1-arefev@swemel.ru/
    ccfd889acb06 ("smackfs: Added check catlen")  2023-01-24

Konstantin Andreev (2):
  smack: Revert "smackfs: Added check catlen"
  smack: recognize ipv4 CIPSO w/o categories

 security/smack/smackfs.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

-- 
2.43.0

