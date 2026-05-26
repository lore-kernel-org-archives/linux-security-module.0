Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78C280A58;
	Tue, 26 May 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779759554; cv=none; b=Y5HmRGSS4ngbp2mEFbTEjHDf4X1vslJcXl24alA2V6btm1YuenAxmLWdQ8SUM3MAJxuCG3anNxizVYjtgOSviLUUOg/EBffX7sLGHtEiNqXDNpG6ULjZ9w9oXBCat3IA/8GtF1kylG8Qfc4pBWTvQRtj1WbCtfOGNfs5UBnZGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779759554; c=relaxed/simple;
	bh=YEJyjsK+G7CMf0Zer0CEmdN+S0JeSVv52PffgOHQG8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QfvX9MLxOSk8L6d+rA8hek2zf3LII8/DATL5EwOIh7AJPz6WlvBXEuUE9eB8xpFXE2qm/bX0ASup2vvlz30JnqnIT6E128RpORM8x1afLXPPTv9ck7hB5g6GiRvND6KYX261Z57eH8eg/iVUDuNHb45BxmFtrjonf+KOsFvE93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GpbwFpFR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GpbwFpFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=DgFPBC3+jhQ9bBDRqs1m3w4YrWm9tSzf++kO9rEI2oM=;
	b=GpbwFpFRzcxBCWtbyepXqrf8XAq4jaCanLmIwpaulhG1kxdjxzsZPYXU+nB5v/
	BE/ldbvOxmZoyz71vOH3OJFrvCsAk4ePin6vB3dRaCQvU6IuAbzhzH7OSGsnI02F
	4ykplyz6cylZn+gB1VASwSFS+bBKXCct1EYaHGlNlBKL4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3XyuV+RRqjt0eDw--.22442S2;
	Tue, 26 May 2026 09:38:30 +0800 (CST)
From: fffsqian@163.com
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH v2 1/2] security: apparmor: fix two spelling mistakes
Date: Tue, 26 May 2026 09:38:26 +0800
Message-Id: <20260526013826.399735-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XyuV+RRqjt0eDw--.22442S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xGr4DGFWUtr1UJw4ktFb_yoW8WFy7pF
	4DKFZrGF4UAFWxZw1ktay3uryrK3y5GrWSqay3Cw4jyrn8JF4kXF13tr1Uury5Xws8Cr1a
	yw12qr4rZ3sFyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE2-e3UUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6RZDDmoU+ZYKdQAA3c

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Fix two spelling errors in comment:
- interated  →  interacted
- dont      →  don't

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>

Changes since v1:
- Split original single patch into two standalone patches,
  separate AppArmor and Smack changes for different maintainer trees.
---
 security/apparmor/domain.c | 2 +-
 security/apparmor/lsm.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f02bf770f638..7e097c40720a 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -135,7 +135,7 @@ static int label_compound_match(struct aa_profile *profile,
 	struct label_it i;
 	struct path_cond cond = { };
 
-	/* find first subcomponent that is in view and going to be interated with */
+	/* find first subcomponent that is in view and going to be interacted with */
 	label_for_each(i, label, tp) {
 		if (!aa_ns_visible(profile->ns, tp->ns, inview))
 			continue;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 3491e9f60194..51a388cfea11 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1493,7 +1493,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
  *
  * Note: can not sleep may be called with locks held
  *
- * dont want protocol specific in __skb_recv_datagram()
+ * don't want protocol specific in __skb_recv_datagram()
  * to deny an incoming connection  socket_sock_rcv_skb()
  */
 static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
-- 
2.25.1

