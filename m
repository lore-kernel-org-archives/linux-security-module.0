Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7013B293;
	Mon, 25 May 2026 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779675356; cv=none; b=MJX0PkoXBDJEkpwJ177Sweall/RUBPC8l69Cfd2YRGPyy9FNEPFHT0CBAVfTLEp4MKEkAl8rrF0LDIy7gDBCdKQC+Dm49ryiJDsqO2zWI9JdiVKnXKZT4CHtUdBGmOzWpyYMsx5EVqOBODtpXNvp4LkkDKuDLqh+ux4j5vfZC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779675356; c=relaxed/simple;
	bh=cfXYwQbwtsMnXS31mlf4l1AI1zDPDw7tS1CvKdIv37c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W1UgXEM4SJYhj9NPoWRymi0txqfWZ581Ek6ZZcogMxL1EkNcZf/liat2SfcEuZofQ4Rdp8RfZ/6vm33eMgWHTyk5za2E1Q00OVnaJcnuTk+WF9oeDDXpradKI8TnOGhbiRq/q3Bqo1/YSzVuYBXwAJE/SB94z4JojZT18NSjYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WumluXXo; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WumluXXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=gEERWc0jBVDWNAZQVeEY8xiybeET2JoKedTCCduHqsw=;
	b=WumluXXo9Lc6mctIlXruENSMDgm0u/WVTwmhPDcm2FiQVC8PJnK5zmOr1DoHrM
	i7w0A9ikvPr6TyuTI2DytR/noUj+Hj/RHlfnUDHorSu1mHm3UcZmIz26GpfirSbC
	yFU9Gx/l5uhO5bpcQIlm7eZuRFW/F7bet1+HN3+ith0sY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnhMqosBNqTIpRDQ--.1404S2;
	Mon, 25 May 2026 10:15:06 +0800 (CST)
From: fffsqian@163.com
To: john.johansen@canonical.com,
	casey@schaufler-ca.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] Fix various spelling mistakes
Date: Mon, 25 May 2026 10:15:00 +0800
Message-Id: <20260525021500.47667-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnhMqosBNqTIpRDQ--.1404S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xGr4rXF4kXFWfWry7trb_yoW8trWxpF
	4DKFZrKF40yFyIvF1qyayUWF4rK3y5GrWaqay3uw40yFnxJrW8Xr1Svr4j9Fy5Xw1DAF1j
	qFnFvrs0v3sFkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFYLkUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbCwQq1gGoTsKpGlQAA3O

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Fix three spelling errors found in code comments:

- overriden  →  overridden
- interated  →  interacted
- dont      →  don't

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 security/apparmor/domain.c | 2 +-
 security/apparmor/lsm.c    | 2 +-
 security/smack/smackfs.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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

base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.25.1

