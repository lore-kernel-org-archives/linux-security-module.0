Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488B4F7970;
	Fri, 25 Sep 2026 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369730; cv=none; b=I+vhmg2r2ZTsGrjtEOqDhQN8MBu961w+WBm4dw1vMgpqXMWNX97yanD+A633K8FohiNs5wIcAVw7lP+TzAozm5kAeaf85GlggvDcxzPte+RyFQPJgRIYAlXrDXwYJnBV26j/TzdByvsqR7qJmc4Vf0VIYdj/q3XenZ25abjIN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369730; c=relaxed/simple;
	bh=QMoMK63nGZHP7Sy7inPTljnKhwSsIZ+PEF8A/OCamzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnQpKVjrsddOw6KkmcfRpnMRKgRfjtuS3m70odinxQzIbZyYCckD2QVNIhu2mT8j/QeXDwgYF2/pamC7amMPFDWusrFjR+lNGqEn0dvFZ1e02GD+f4p+OLbiN5FhdsiuC3VzfcMxGkbeLpk9sUJ9yXf1S6REzDbe0wmUVHORm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=l2PWlpqR; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="l2PWlpqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GUUPgi9ZsILWTb1QSh9sUG1Eg1ulLf7kxvamYIqQMIM=; b=l2PWlpqRGlhCGQQFA8mmpV5N3+
	/z7sFh1cAiJsPXWde1GyKGtq6asS1Fpm8/24AAkiV5o5OvWBbdA9epYvuBTUO71GuFqSeWV19VAkB
	i/LsD47ZsJl6X0ZLRw0aGUxhuH6AAXvXfFEDay1+zp9OmlXP44ari9G4VN0gk23t8AReKT4qAp5K8
	hlglmq8FreO37w/iDrkTVbo0ruVvWDC5enJPu916s0Zqqg8MDhzjQlE6s6wEmqDjPZ/liGshcQIQV
	yK+U9qkadEoTm+xqHaHx39BofTS0dbvgeN17X8/9gHR2SZ5OicfhKLI59m67Q2UBQohU3bzgl81yG
	/3+CAZPA==;
Received: from [151.115.150.205] (port=51460 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xACx0-0000000Bapv-17z1;
	Fri, 25 Sep 2026 22:55:21 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 1/2] apparmor: check connect permission for SCTP
Date: Fri, 25 Sep 2026 20:54:48 +0000
Message-ID: <20260925205447.1244190-4-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925205447.1244190-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260925205447.1244190-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

SCTP can start an association through sendmsg() or CONNECTX. These paths
call the SCTP-specific sctp_bind_connect hook instead of the normal socket
connect hook, but AppArmor does not register it. As a result, a profile can
deny connect and allow send or setopt, yet a task can still create an SCTP
association.

Register the SCTP hook. Ask for connect permission when SENDMSG_CONNECT
or CONNECTX creates an association.

Fixes: 56974a6fcfef ("apparmor: add base infastructure for socket mediation")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 security/apparmor/lsm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d502ad0ac26f..dba078c73abc 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -15,6 +15,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/ptrace.h>
+#include <linux/sctp.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
 #include <linux/sysfs.h>
@@ -1405,6 +1406,18 @@ static int apparmor_socket_connect(struct socket *sock,
 	return aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
 }
 
+static int apparmor_sctp_bind_connect(struct sock *sk, int optname,
+				      struct sockaddr *address, int addrlen)
+{
+	switch (optname) {
+	case SCTP_SOCKOPT_CONNECTX:
+	case SCTP_SENDMSG_CONNECT:
+		return aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sk);
+	}
+
+	return 0;
+}
+
 static int apparmor_socket_listen(struct socket *sock, int backlog)
 {
 	AA_BUG(!sock);
@@ -1823,6 +1836,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_getsockopt, apparmor_socket_getsockopt),
 	LSM_HOOK_INIT(socket_setsockopt, apparmor_socket_setsockopt),
 	LSM_HOOK_INIT(socket_shutdown, apparmor_socket_shutdown),
+	LSM_HOOK_INIT(sctp_bind_connect, apparmor_sctp_bind_connect),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(socket_sock_rcv_skb, apparmor_socket_sock_rcv_skb),
 #endif
-- 
2.47.3

