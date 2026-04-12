Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBE2A1AA
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988161; cv=none; b=Hqabhe6O/RBlPfoTSp0awV0+yTJm3/NiT+XHkpffuEQoxo2c0pXemRf+YIX1Hftmxp6LVaM32gJeSjB9GvO7wPY6RoQitBhSeQRrDsLttb7RWK9ve/NXzTdxYYBuCZBT9syHJevfFr6o3Tbtb6hb4GZqXF0BFiXGFDHN9Fa0T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988161; c=relaxed/simple;
	bh=J+Fr5bfTaqx+01El13cjjGFfQ2HdNTK1xRXEcFP1UiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pb36crPNrxPdOoloCTJthtpsu55PE3UjS1ZGw3w3Nt64S7/PKR03xg5E/u9DwnJSerWwojZ5M7H34mT3GEl8JMkVqCmxTKwGZRanptgAewLk6uWYvTrg5rPMGUe4O1LTl+kc0qVkknbBr/fV06GIedEFbMfeSWVvP7x+DgYMFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=ehmCwUHt; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="ehmCwUHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1775988109; bh=J+Fr5bfTaqx+01El13cjjGFfQ2HdNTK1xRXEcFP1UiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehmCwUHtX10JazT2DxYNSBHq3kkVVJlEhowHXQvz4b1AFSsB2RkAVp5sUaYaFXDH5
	 ROGZdW0+U9yoEQmYiO389HsDjJYQM8jm84qP7wOraSKH11t+TXsFfVQJ9+Y0dV83+u
	 iv/wGAW+KbgMSe1P0KA8oXBoui8pqjQAGnaK82Gc=
Received: from localhost (lfbn-idf3-1-911-123.w90-3.abo.wanadoo.fr [90.3.226.123])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 16C6440339;
	Sun, 12 Apr 2026 12:01:49 +0200 (CEST)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	jeff@bencteux.fr
Subject: [PATCH 5/5] landlock: Document chmod and chown support in example code
Date: Sun, 12 Apr 2026 11:50:44 +0200
Message-ID: <20260412095233.34306-6-jeff@bencteux.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412095233.34306-1-jeff@bencteux.fr>
References: <20260412095233.34306-1-jeff@bencteux.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing LANDLOCK_ACCESS_FS_* flags in Landlock documentation

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 Documentation/userspace-api/landlock.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39..4eb7ed3dcbfe 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -77,7 +77,9 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
             LANDLOCK_ACCESS_FS_TRUNCATE |
-            LANDLOCK_ACCESS_FS_IOCTL_DEV,
+            LANDLOCK_ACCESS_FS_IOCTL_DEV |
+            LANDLOCK_ACCESS_FS_CHMOD |
+            LANDLOCK_ACCESS_FS_CHOWN,
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
-- 
2.53.0

