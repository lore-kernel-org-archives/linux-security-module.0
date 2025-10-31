Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3781834320D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908851; cv=none; b=gM7hHz9hXk9PbAjVzrhtOnimPkLgGsTLuzRRtxK/pvMouDGWlQJaxCBZtxoyIqJwc+JUUzb+fDac21/kMcwQA9MWBp3UdaLMhJ22WtZZJfA7DoHeRhZXm8IfR1B8HLmjTKHb0likrSTcP+ZHA/OwgGvgGqHHDKJiJcw/pyIeiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908851; c=relaxed/simple;
	bh=M3Qb9g3bZHc0X1YpiMc193vcKMbFF09mnqTmKUEXPdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LATKxBB3W7q+KUa/H4KN+Ay71v+zqj43hQprWkGRRfyJbbgI7+6SLZ5exlexi8mbqIkH+3UbCZ8/rcQiM0SU8q4nL48bwpajnxCvtjmoSj0rs5/kdxFMIp/r3N/JvrTlcaZiL7lybLsfZuoGqFvUyMbS2/2qBK4CR1Pd9vPoUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkCOozVc; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkCOozVc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761908836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P525aXze3q+eRQRgjVHMUG0duLtS7TQgJYdpfahubEM=;
	b=gkCOozVcOTNZY+BzZvOG9QsaMUrVwG9A5p9YPPrKrFrVyTz3ktex9eXPeLlfCQaF+ZazwW
	Xf466KH/nqy9aztbuq96Qc5L98b4t62t32yPhhFDyANfETZlL9zTZzNvX4ce66uPMwl6mA
	t1uQshmt2tsfd+6afuX1kkZqtyMDnc8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
Date: Fri, 31 Oct 2025 12:06:47 +0100
Message-ID: <20251031110647.102728-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated and sprintf() does not perform bounds checking
either. While the current code works correctly, strscpy() and snprintf()
are safer alternatives that follow secure coding best practices.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/device_cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index dc4df7475081..a41f558f6fdd 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -273,9 +273,9 @@ static char type_to_char(short type)
 static void set_majmin(char *str, unsigned m)
 {
 	if (m == ~0)
-		strcpy(str, "*");
+		strscpy(str, "*", MAJMINLEN);
 	else
-		sprintf(str, "%u", m);
+		snprintf(str, MAJMINLEN, "%u", m);
 }
 
 static int devcgroup_seq_show(struct seq_file *m, void *v)
-- 
2.51.1

