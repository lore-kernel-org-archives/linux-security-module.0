Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF331D362
	for <linux-security-module@vger.kernel.org>; Fri,  1 May 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657505; cv=none; b=fkC5wq3aYEsBg4UTHFdgug/+Igo8lXPeaHvHBaX32Cbg+lT5AErrpCFe5Y8uTeRzb3uJhbmcml2QDEXGZKfWAvxfD4WM4G5pLO28OVU/HZDlFIYqG8OxbjZlz3mVIfWogVZ+umMYfqirdAY4je1oXBYMZ9L3ywZM5XfJUKAC/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657505; c=relaxed/simple;
	bh=+pjh3XUzsYD6gZRDxHVbqDDi7+LAqF+5zeyuPPcJ9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpMt6UD7BVfR91hep41ce3w9AtKuLl7Tx2Yc+10Rt4eELF4AB5hf+yH4U/nc32+t6NuP/NgVKH+0Ha02T4u67tai5KNUoV6t6AzEJJqkJgVZE4zHgUaF9t7nqpuepPFjiQk94rVobUfc4KfhpioyI/Wi0h7CA6GzG0Uwy0WRUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=KBfUeZak; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="KBfUeZak"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Ndha0UMPnwNJlNd5+dDGjhMNTIhRPokEODsRmoyxyk=; b=KBfUeZakGtBQXWxZJjmyI9C2Nc
	8KNc+l4cSjvWE3e4HntnTX9kDxXtAblRY1g0fwolSRKh/NDEg9ryMs1ge8WsfEtl+A7INPTHlTuST
	sheCFrw4SWjFIMTyXlJYFhDIejd9fBC5c8x71EsTlw+W5rzmr1wDNhxBMSBvypyefTXfaeUvnXOdU
	a3qathilpDoEBMuTTIO3zSdg6kzXkDu3vS3SAyIz1E7r0aoju4dSdVAlMl9SNO84FgOiyLWBWCa3x
	EtikXvRl3E0m1KGmMmI4FBUrNeUR+Jj0A/F5qOPz1GaPXChSuP7pal3jenMpVI0+xpzAlHkxfn5yp
	ua7wiRoA==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53652 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIrv9-0000000CTao-40Su;
	Fri, 01 May 2026 20:44:59 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: linux-security-module@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] lockdown: remove useless decrement operation
Date: Fri,  1 May 2026 20:44:48 +0300
Message-ID: <20260501174448.47154-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
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
 security/lockdown/lockdown.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8d46886d2cca..2659d36bb74c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -130,10 +130,8 @@ static ssize_t lockdown_write(struct file *file, const char __user *buf,
 		return PTR_ERR(state);
 
 	len = strlen(state);
-	if (len && state[len-1] == '\n') {
+	if (len && state[len-1] == '\n')
 		state[len-1] = '\0';
-		len--;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
 		enum lockdown_reason level = lockdown_levels[i];
-- 
2.54.0

