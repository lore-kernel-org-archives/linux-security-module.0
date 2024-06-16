Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDF14292
	for <linux-security-module@vger.kernel.org>; Sun, 16 Jun 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577891; cv=none; b=XuET5QL+PSjaplBqTsDEMGR/ck2iAm1R8+dqd2/Mmv2dG3m3j71QNckHMPZ3s7mQh9Us8mJLXsH6DADK4Uj+2tSFV/RXhlkN9CRcdrQzXwl5Mv9+HUP9tV/9vQA/wj06Wi+Ri0Drrt8MEomKMZpozOmMeEuRPQdgpaQ4Yh8RS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577891; c=relaxed/simple;
	bh=4L0hDIO/47PGaIlKreoLYWWYFMo1QUccqgFv9+PrWS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Klu607x5lTjq0tLTmZj9YsGf7cbJoiyaBHjd+LtPOBeX38Ch0ycPzv1b80yJKDY0L/O5cZWe4qU/oZvlt/60FQvysxVvMWJO/ap0/h8YCkhd543m/+Zat8tqowPhiB9EcxOsU2hV28nb0RySwEcTCAslwpHe2/5q570HXkd/Af4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=kCUGKjcf; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="kCUGKjcf"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1718577882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zGng8i+6gRcFwUWGGh1Wwve6lGpfWvv7+7PugPGU8eQ=;
	b=kCUGKjcfUsQjFLr1tUBJQsLG6fUmiDYKSkbQVb5rd5l0tWWUfplGmvNJ9krCgmN7dYxYDs
	dj7b3EY/irLBSiWPjUCE2lIJvjqNsi4AryjdrVMseb1IkpTMrgVid4fiEfkfEvJ/rguL8E
	oLoy5j7FNGJW6H1YAtnzbF8AUHnwEX8=
To: linux-security-module@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2] smack: unix sockets: fix accept()ed socket label
Date: Mon, 17 Jun 2024 01:44:30 +0300
Message-ID: <20240616224441.3379-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process accept()s connection from a unix socket
(either stream or seqpacket)
it gets the socket with the label of the connecting process.

For example, if a connecting process has a label 'foo',
the accept()ed socket will also have 'in' and 'out' labels 'foo',
regardless of the label of the listener process.

This is because kernel creates unix child sockets
in the context of the connecting process.

I do not see any obvious way for the listener to abuse
alien labels coming with the new socket, but,
to be on the safe side, it's better fix new socket labels.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
v2: fixed comment style
The patch is against `next' branch at https://github.com/cschaufler/smack-next
The patch does not hurt `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git

 security/smack/smack_lsm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 56e02cc5c44d..d0d484c1599a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3846,12 +3846,18 @@ static int smack_unix_stream_connect(struct sock *sock,
 		}
 	}
 
-	/*
-	 * Cross reference the peer labels for SO_PEERSEC.
-	 */
 	if (rc == 0) {
+		/*
+		 * Cross reference the peer labels for SO_PEERSEC.
+		 */
 		nsp->smk_packet = ssp->smk_out;
 		ssp->smk_packet = osp->smk_out;
+
+		/*
+		 * new/child/established socket must inherit listening socket labels
+		 */
+		nsp->smk_out = osp->smk_out;
+		nsp->smk_in  = osp->smk_in;
 	}
 
 	return rc;
-- 
2.43.0

