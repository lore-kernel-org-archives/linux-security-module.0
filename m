Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE872617
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235002; cv=none; b=rcZEP58GsDEWlmaqDhg8G0Vu+PSOj8I1y3VbBOFbyymbxH/Q+AsIbZFAxJlK3hHs+149j51lVJHCB8iJRZhs3oF5sk2b4wLI2qW6lIletUe+hU33AvFzG95TY6OQPQf37IpEfFbdCH6/mRED8KgZHnw0zSlEPkFL05wHaGQmqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235002; c=relaxed/simple;
	bh=NogW+YqAKeFJLnvPf/8z0WjXPUw+b8G0vAwFgSwkX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=to0xe1b0qsGbRIgZPFBq2lAin8ZRJq2VDeKZ1yDPJnEl4Sv0Tde0e9WW0tiMvwDqhta64aE1x9YpZrGR3WGt+PqfQfNS1PkfgZSEbEtSJe5IEAECVuibWpMGPrtolCX4ET3na7TtdQLFDpmvRKpreMRtmX5jNkgGc42j4pdSCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=dkdPWeCg; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="dkdPWeCg"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1759234563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YuSR1M/BCxONYIBMTypv+vtzyE+7uuPFWVrR7Ch+ZCI=;
	b=dkdPWeCg6DGZaOmRhAlBrwbn4R4OS8mdfNFLpcJwgwQDEx/u6K8LBpTDY4LFaWba3qoSCa
	PqhQfyJLf+zAUERuf6KdEQxotCt8jhb9zFJ0cIv7eWg4NyJAcrSgvBP1IB1/AmkoOkhlQm
	7tDY7NKKyOH2cVlBwF3WRQ8mh08LoEg=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] smack: /smack/doi must be > 0
Date: Tue, 30 Sep 2025 15:16:02 +0300
Message-ID: <20250930121602.138337-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/smack/doi allows writing and keeping negative doi values.
Correct values are 0 < doi <= (max 32-bit positive integer)

(2008-02-04, Casey Schaufler)
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
The patch applies on top of smack/next, commit 6ddd169d0288 ("smack: fix
kernel-doc warnings for smk_import_valid_label()")

 security/smack/smackfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index b1e5e62f5cbd..316c2ea401e8 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -141,7 +141,7 @@ struct smack_parsed_rule {
 	int			smk_access2;
 };
 
-static int smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
+static u32 smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
 
 /*
  * Values for parsing cipso rules
@@ -1562,7 +1562,7 @@ static ssize_t smk_read_doi(struct file *filp, char __user *buf,
 	if (*ppos != 0)
 		return 0;
 
-	sprintf(temp, "%d", smk_cipso_doi_value);
+	sprintf(temp, "%lu", (unsigned long)smk_cipso_doi_value);
 	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
 
 	return rc;
@@ -1581,7 +1581,7 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
 	char temp[80];
-	int i;
+	unsigned long u;
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
@@ -1594,10 +1594,12 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 
 	temp[count] = '\0';
 
-	if (sscanf(temp, "%d", &i) != 1)
+	if (kstrtoul(temp, 10, &u))
 		return -EINVAL;
 
-	smk_cipso_doi_value = i;
+	if (u == CIPSO_V4_DOI_UNKNOWN || u > U32_MAX)
+		return -EINVAL;
+	smk_cipso_doi_value = u;
 
 	smk_cipso_doi();
 
-- 
2.43.0

