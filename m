Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EF30B521;
	Mon, 22 Jun 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161859; cv=none; b=ba2P5MFhKxKZ2Kby3QHcmdHSJfNkZ3CxPcP3/xheVCq7/Ds0MCIuffVuWgPT+96FzONeuTQVYq9RZ72YhBigmR+GRm4j0Fkr/uRRg6fDvl/uJpdLMD9oKULOlQeYkZejmdJ0v1SSptV3eUBwFcJtJWJHuG5xISIGo9Yo4QYZPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161859; c=relaxed/simple;
	bh=i027bylM2PNKv+QNm0GBB+kTy88AbDvSEBMyWowNxIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PQDrH/DN+pILooF4Tlc7Xehu2jh3kUQfcSlG/huuukJjXNhWwpMYJqJb9sNyOntawDAufUFXNuzRzwrk/VKiRe6jQjOYUyU0kfwbNFAUCLrkpjloyC1n4onKwaS7AWMaq63E//HyiQVhEiyoDKG3u8R30ft9SdxLcoJI+50vCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYVW/5px; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYVW/5px"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 050BAC2BCB4;
	Mon, 22 Jun 2026 20:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782161859;
	bh=i027bylM2PNKv+QNm0GBB+kTy88AbDvSEBMyWowNxIU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HYVW/5pxV6KpCIC8Lnk7LcWS094OLKkI4k5pSkO1hYmwZESgTPaJMyDzS9zRSsfHe
	 gP//Ue82ISdAcyffG4/h6PGYk9UVYlWIWP/Vu7ZbNKukGeO1BRx2U/n5ngTBiFWXz8
	 CrPVjtrjVMkelBt3cVGPf0iJ80TNW1tNVKRVbjsycs0slb8ZwouFF8JLjgp45rnjGe
	 Pd6iYEK3pb+tCDn1QFcWaWZaZsLfIB6Ouwb8IAOZV3xgEIuUG7uBEysP1pZY+HZWyQ
	 zd6sOiodWFES4RUgWff995YX7WMfvcEGGIJGxBOzf68/gyddjLe+hcxMBSDIxIPT9f
	 Gc21jm0qpowKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26FCDB46F;
	Mon, 22 Jun 2026 20:57:38 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 15:57:38 -0500
Subject: [PATCH] apparmor: mediate the implicit connect of TCP fast open
 sendmsg
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-disp-aba401c6-v1-1-9d74343c7ced@proton.me>
X-B4-Tracking: v=1; b=H4sIAMGhOWoC/x3MPQqAMAxA4atIZgM11Fq9ijj0J9UsKi2IIN7d4
 vgN7z1QOAsXmJoHMl9S5NgruraBsLl9ZZRYDaTIKEOEXmOUcqLzTqsuGEyKrKZgaRx6qNmZOcn
 9L+flfT/zOldgYgAAAA==
To: Ryan Lee <ryan.lee@canonical.com>, 
 John Johansen <john.johansen@canonical.com>
Cc: Mickael Salaun <mic@digikod.net>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 James Morris <jmorris@namei.org>, Matthieu Buffet <matthieu@buffet.re>, 
 linux-security-module@vger.kernel.org, 
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
 "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
 Paul Moore <paul@paul-moore.com>, apparmor@lists.ubuntu.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782161857; l=3633;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=e2t5bp4l0ZsG/vhIPuFXcseb3OvyeXAly/te6D921wY=;
 b=c2u7zxjk1psh1+GEDQpUgJx2ZUR+fEinuqAMbCLImRETnNGXUO1+VZ2sxlUo+UWeog5PgYsY0
 40TH6DrS5hzA01zjyU5PD0xy3IFNR/aO1+2Ampv+zvCzfZOAQugY6p0
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

sendmsg()/sendto() with MSG_FASTOPEN is a combination of connect(2) and
write(2): it opens the connection in the SYN. apparmor_socket_sendmsg()
only checks AA_MAY_SEND, so a profile that grants send but denies connect
lets a confined task open an outbound TCP/MPTCP connection that connect(2)
would have refused, bypassing connect mediation.

Mediate the implicit connect when MSG_FASTOPEN is set and a destination
is supplied. Add it to apparmor_socket_sendmsg() (not the shared
aa_sock_msg_perm() helper, which recvmsg also uses) and call aa_sk_perm()
directly, mirroring the selinux and tomoyo fixes. sk_is_tcp() does not
cover MPTCP fast open, so the SOCK_STREAM/IPPROTO_MPTCP arm is explicit.

Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
This is the patch and reproducer requested in [1]. A userspace regression test
(tests/regression/apparmor/net_inet_tcp_fastopen) follows separately to the
apparmor tree, as suggested.

Reproducer (behavioral; the bypassed value is policy, not bus state, so no special
hardware). Under a profile that grants inet/inet6 stream send but denies connect, on
the current Debian security kernel 6.12.94 (apparmor active):

  [TCP ] connect(2)=EACCES   sendto(MSG_FASTOPEN)=OK   -> connect bypassed (listener accepted)
  [TCP6] connect(2)=EACCES   sendto(MSG_FASTOPEN)=OK   -> connect bypassed

The kernel audit shows the connect(2) denial and no connect record for the fastopen
sendto:

  apparmor="DENIED" operation="connect" profile="egress_restricted" comm="lsm_tfo_ab"
    family="inet" sock_type="stream" protocol=6 requested_mask="connect" denied_mask="connect"

With this patch the fastopen sendto hits that same connect denial. Full reproducer
available on request.

Same-class fixes: selinux [2], tomoyo [3]; the original cross-LSM report (landlock,
the first instance) is [4].

[1] https://lore.kernel.org/r/20260619011138.264578-1-hexlabsecurity@proton.me
[2] https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.work@gmail.com
[3] https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re
[4] https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@proton.me
---
 security/apparmor/lsm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 3491e9f60194..e01efdf50efa 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1422,7 +1422,21 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
 static int apparmor_socket_sendmsg(struct socket *sock,
 				   struct msghdr *msg, int size)
 {
-	return aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+	int error = aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+
+	if (error)
+		return error;
+
+	/* TCP fast open carries connect() semantics in sendmsg(); mediate
+	 * the implicit connect so it cannot bypass the connect permission.
+	 */
+	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name &&
+	    (sk_is_tcp(sock->sk) ||
+	     (sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
+	      sock->sk->sk_protocol == IPPROTO_MPTCP)))
+		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
+
+	return error;
 }
 
 static int apparmor_socket_recvmsg(struct socket *sock,

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260622-b4-disp-aba401c6-f02842c82975

Best regards,
-- 
bryamzxz <hexlabsecurity@proton.me>


