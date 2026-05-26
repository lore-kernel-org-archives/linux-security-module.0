Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA5280A58;
	Tue, 26 May 2026 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779759560; cv=none; b=gFUABwT1sOpQ6AAl2ie1Cy9y6nBRPIETq9AejRQY9AeRNcgKCXZAzBW/1L70qfKTh9zKKa1XdcIFVjKbKRABa+LnBXkJ9t17/KLb72qBcCOKuP6xbl8LiXju/Wwlxs8CGOdd0zYjE65SmShxO43/puYEPZ65Ka7XrkR++bbY1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779759560; c=relaxed/simple;
	bh=A0oSMeqJRMYjlcAN0Rx3mrD4kFwYrk2pdAD1aAWXZjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gkYQ/FAAP/3dPsUV7bwEBOebezrHGV5AhzHoAPfmP4JNEG1QyAWAjOYUfCt0iVXqO3ZK/1sk19XCngeoRrUHDsUaDRwrBaVSNieq0He66YAKmZaP8vVePaCx83/KlttBkHGUagYqFsXLCOTbYt5937EzP9wnwN0m2xpATAeMq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FsgAalqW; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FsgAalqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=t5cHYAv92QcWPYeMgV7iJstQ1cbWYimjSVQwo6nNDIQ=;
	b=FsgAalqWo+BT6EeeBeCraCbwSuKnyinWc5tnn5hYHiaaHsfeAGwuDAHd4SpU9O
	7BMncIAbKFnimqrQ3YUDCL7p6Mp8VHsresvN8EtBiWHigbCfpjTblMFx6PINZwO0
	ku2GGmC8ENSIf4eo+O8IWXTKCUsP/EszKb3wH4BOUTHCA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCHFdyc+RRqZ26iDQ--.39799S2;
	Tue, 26 May 2026 09:38:36 +0800 (CST)
From: fffsqian@163.com
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH v2 2/2] security: smack: fix spelling mistake
Date: Tue, 26 May 2026 09:38:34 +0800
Message-Id: <20260526013834.399816-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHFdyc+RRqZ26iDQ--.39799S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry5tr1xXFW3WFyUWF4DArb_yoWDGrg_Xw
	1kCan7GFnrAw1DCw47Ar18Ars2g340gr4UuF1rtr1fAa45urW5GrZ8Grn2yFyjy3WYyFn8
	C3ZxG3y3tF1SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1G2M5UUUUU==
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbCwRxFEGoU+ZzTrgAA3u

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Fix misspelling: overriden → overridden

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>

Changes since v1:
- Split original single patch into two standalone patches,
  separate AppArmor and Smack changes for different maintainer trees.
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 6e62dcb36f74..2820bd3ee72e 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -115,7 +115,7 @@ struct smack_known *smack_syslog_label;
 /*
  * Ptrace current rule
  * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
- * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
+ * SMACK_PTRACE_EXACT      labels must match, but can be overridden with
  *			   CAP_SYS_PTRACE
  * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
  */
-- 
2.25.1

