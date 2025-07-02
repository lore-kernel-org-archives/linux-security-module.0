Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C6189902
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450444; cv=none; b=u22ycp56FiWHBl5hdXXisTufIO+QWrbcGpkJgnjia4HWwyIZhf9LGBMcPQS7+Y7V0li53UVX2ZT/Ny3x6yzKcsKLTdYTG7PR9MOD4/2HKnq87jRVH1d8AvLOpuwaUyUWuX8AyeiX3IMzqGKJyd8R8Wnazv/G93rrfd425PlsCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450444; c=relaxed/simple;
	bh=/H8nlSVptfM8cvLEUDKt9w2phlkY99AZhhL4PtHvnZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eE/RGVEcm2u3vjl8CXAyl6iLbGikEQeJrgSnj3dJuQFztICip9amgCzcQ7hbTT34szybWGKX1giWVpjOnCiM/gSj7vOmyWjruIGJfsIdZpBuKOP8pGuA0qoSRctx+oMepv2Idk9TbwALCSpEhsK5X0GTpzRoZGh4yyKtd3pOJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=YVHPpmbu; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="YVHPpmbu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1751450441; x=1782986441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/H8nlSVptfM8cvLEUDKt9w2phlkY99AZhhL4PtHvnZk=;
  b=YVHPpmbuA9holumvkU2/JThvz6TS8K51usbk7VBPhh3YVYSIEXPTrw4Z
   afRloV9SNGJreKSc0WMdjALKuOr1d7moD+ov2rF0hsmM/mtkwZ0KrmmPx
   H1whol9NL7U4IiCBbCegsVvT4vicF8a4g/tBIGPREfZ+ytXg1letcZEem
   k=;
X-CSE-ConnectionGUID: 0xOV0C8bSSikpfUPeWoNTw==
X-CSE-MsgGUID: dF7gXEe8TCyrG304MFJmMw==
X-IronPort-AV: E=Sophos;i="6.16,281,1744063200"; 
   d="scan'208,217";a="2012175"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 02 Jul 2025 12:00:34 +0200
Received: from s76.. (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 467CB2F09;
	Wed,  2 Jul 2025 12:00:33 +0200 (CEST)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-security-module@vger.kernel.org
Cc: "Andrew G . Morgan" <morgan@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Subject: [PATCH v2 0/1] uapi: fix broken link in linux/capability.h
Date: Wed,  2 Jul 2025 12:00:20 +0200
Message-Id: <20250702100021.1849243-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr>
References: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch fixes a broken link to the libcap library. The old link is outdated:

> $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/"
>
> <html>
> <head><title>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</title></head>
> <body>
> <h1>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</h1><hr><pre><a href="../">../</a>
> </pre><hr></body>
> </html>

Moreover the patch gives the full reference of the compliance with POSIX.

The README of libcap2 says it is based on Draft 15 [1]; but, as far as I could see, only copies of Draft 17 exist online [2, 3].

Your feedback is much appreciated,
Ariel

[1] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/README
[2] https://drive.google.com/file/d/16yTUA10JLyi6zKky9_KBu7P8FpZrprl3/view?usp=sharing
[3] https://simson.net/ref/1997/posix_1003.1e-990310.pdf
---
v2:
* reworded commit log (Paul Moore)
* reworded cover letter

v1 (https://lore.kernel.org/all/20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr)

Ariel Otilibili (1):
  uapi: fix broken link in linux/capability.h

 include/uapi/linux/capability.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

