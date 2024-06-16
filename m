Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3110A11
	for <linux-security-module@vger.kernel.org>; Sun, 16 Jun 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718548090; cv=none; b=l6WhN04vk5B+MDoWx1xjQCqeiZY9eKlkhnYTuf/XptKJqOBc3auqK0ytesaFfK8gmlqWGAjR5OgQwFKi4p5J4AM6xMDhzMj22hQy+POt1t41ZfPtk9OJRFAHj3oy7vAa41pmRvPwbU1B5cRt7xsbmbJ039ZaqgXwceYMrKtRia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718548090; c=relaxed/simple;
	bh=D/XM6PVFlBSTmcGirWZOeSOTHZ2D9Eq+mNrJciwsEls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wvn5VZh5RFzqlclE9ACOJhV1pVa68BJyg5bMM9GuP7oj3AYCZQVRaRyBk8WkaWpPBQnQ5cwqE30DpgqSzeqzxQkL8/cBNTf8Nfpu/dRMesjmN6bKmRDU6z4iPwnAG2JOcjxvI6jy+nPgqhM/YsL5w/N8bgpzdP6I1nXjkWTEyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=jFFxLZod; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="jFFxLZod"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1718548075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CQb5ApzFgS19+tofDpdiVcbXswgqHAOR1KT6imtmD4I=;
	b=jFFxLZod9K5aXF+IsAy06Fp2/L/1ZpWc9jTUWpYIgYyar5wVYDLxZMHA5abZWT0m5ImMaf
	r9QBv48CjQANIS94tCrpKc6K+p51chQS7+wvtdu4IX85o+i3HUPoIcq7plfufi1yQXd+ke
	UzXBawm1IWD1fHwkgiEG8TRrJA0haoI=
To: linux-security-module@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>
Subject: [PATCH] smack: unix sockets: fix accept()ed socket label
Date: Sun, 16 Jun 2024 17:27:44 +0300
Message-ID: <20240616142751.273466-1-andreev@swemel.ru>
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
The patch is against `next' branch at https://github.com/cschaufler/smack-next
The patch does not hurt `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git

 security/smack/smack_lsm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 56e02cc5c44d..0843bc519ed9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3846,12 +3846,17 @@ static int smack_unix_stream_connect(struct sock *sock,
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
+		/* new/child/established socket must inherit listening socket labels */
+
+		nsp->smk_out = osp->smk_out;
+		nsp->smk_in  = osp->smk_in;
 	}
 
 	return rc;
-- 
2.40.1

