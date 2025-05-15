Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42501F5827
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340644; cv=none; b=AkZB0HsLQIQ60fa4zp2HTKD5+7gVKFky4YEcDO5XJ7xb0BNTJtzsQv3/fWRhRl9PTh1FXrDEHu2yUu4daY72i7Gr82w9dWO9YqLZMbEw4vFG4Qq627rhi8VIKtopxgAwAWR7r59K2cJvZ6SMQNXLRF6tkh+zXEQkOj3F3Goe6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340644; c=relaxed/simple;
	bh=pzDjhbn5cWaqOSlZGH/T2tQYkiN6em1Hks4lCJvmHV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPGev//ErRClf3E61Gy6DOKH5HqXTwKVa9uv/sxeduOUh5iOruZRHRbLC0J0jFKFB6bFRVmG2DsFTW/m/78rPtULvnslzHFQpC/QSsQcNfYZnM1lAbPs0++OZYUN0FXQ2iIfZRHbnBrw88TUxBcawW2W1kW3p47MSwYzjHCSOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=ee2jrBTj; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="ee2jrBTj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jn2E6cmYkj6lv5IXJSnPDQ7D/rJuduAlo54Qe+uRgF8=; b=ee2jrBTjKhO6tPZIOl2ihY3Qqg
	BNkXNmCnbeHxUuQbLjURRykxrxz6dZJCKNscsujdsN9MqnTrFONNhBYAN/9IvXs5KdbyYM8M0j4Ji
	SslnkvdceFLteObnQlEKcJtp/XVmBsq1OEvuhN9NmCKvSO/i9T1Pyh4wjW8+d7AEbiMXmmmHHcajx
	CfEKsVofbeHPqLBLqv6ATphTUCnPAdZ9yZRyZN3YbFUX72ODNhswwyymaRxM86pSQA6E5qUfNn5yc
	Z5nPD05JOP1UMoJTMHsJkn/kRE0Uj51RJs65ondwtjCnegOr5Tf+BMDn9Xmg/2sUGjathXvcrC0VZ
	NrrkBu1g==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11565 helo=fedora..)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFf7W-00000007Ewz-0rjn;
	Thu, 15 May 2025 23:23:58 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: linux-security-module@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] Trivial fix comment
Date: Thu, 15 May 2025 23:23:40 +0300
Message-ID: <20250515202340.4271-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 596d41818577..fc8405928cc7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2181,7 +2181,7 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 }
 
 /**
- * security_inode_mkdir() - Check if creation a new director is allowed
+ * security_inode_mkdir() - Check if creating a new directory is allowed
  * @dir: parent directory
  * @dentry: new directory
  * @mode: new directory mode
-- 
2.49.0

