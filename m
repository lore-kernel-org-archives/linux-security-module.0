Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B484FD0
	for <linux-security-module@vger.kernel.org>; Thu, 25 Apr 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039249; cv=none; b=fPBjRg2Vue456a8s1gdh2s1EpXZQc2NN5+rlc8z+Sko5xPdMD2nhKgIAG4L+dccGfmVitnzCJa37VIul4QPOd4825Pt8m1Dk/AdK35kjCHZw2h31h6K//3DTc1gvH1muBR9imGnhuuevjykE6YnKRPmvs3n7tNYcaSddvAC1pW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039249; c=relaxed/simple;
	bh=hWMLyN7uK3gysN1YWIaf+Zxg9Lv6ljiK1vi+Jet7OSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lN4QZ1oVxCFJYNXi3BZR46jFxM57smeweF8a290X6eB+b+li005Td3Mdo8l4+7clNL+g8FQXELK8birla5GMvEL9XPHP2HstJ+xvGaqKsIUlqs10q+5tMDNT1er8+3xXcrl8kEkbtGF+mncaclbDE5REIKbmJaGaykMHHNzQSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yBOdJcW7; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yBOdJcW7"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQ9PW2PpnzxXd;
	Thu, 25 Apr 2024 11:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714036975;
	bh=hWMLyN7uK3gysN1YWIaf+Zxg9Lv6ljiK1vi+Jet7OSs=;
	h=From:To:Cc:Subject:Date:From;
	b=yBOdJcW7ZUSQX0UplevNzR5NSqrSvKzT6jSCp4jm0rMGyOviBzqxQSPPqiJRbyRo/
	 xLHcW8s4CHqW4ZVRS1KAlozxy8oIjN7Sye5+varUhNurHSl0Kj6zYRwuZTJIgElJGO
	 kak6bJ2V30zCLHHr02wq9xiKJ4IjlYx+dUg5C4z0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VQ9PV10dKzTZ4;
	Thu, 25 Apr 2024 11:22:54 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH] =?UTF-8?q?MAINTAINER:=20Add=20G=C3=BCnther=20Noack=20as?= =?UTF-8?q?=20Landlock=20reviewer?=
Date: Thu, 25 Apr 2024 11:21:21 +0200
Message-ID: <20240425092126.975830-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Günther is a major contributor to Landlock, both on the kernel and user
space sides, and he is already reviewing Landlock changes.  Thanks!

Cc: Günther Noack <gnoack@google.com>
Cc: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c95dabf4ecc9..6a84cccbb6d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12216,6 +12216,7 @@ F:	net/l3mdev
 
 LANDLOCK SECURITY MODULE
 M:	Mickaël Salaün <mic@digikod.net>
+R:	Günther Noack <gnoack@google.com>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
-- 
2.44.0

