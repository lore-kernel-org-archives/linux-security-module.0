Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F7205E26
	for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850297; cv=none; b=PVlYymahxnWBVFTjkcFNOinuy+dnLSJE687L6429e/Bvq8sUjFpa8JUw/ozkoM1eHg7FjxBBUbiEN5UVmr7PGSjvxS6AK/hdTZmidty5gdoxIoagF4RHLLv/yrx1cGo+HP21AWUp7Rinq6X2LUhM/zZEAoFcpSccyPvXIo8vu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850297; c=relaxed/simple;
	bh=xtg7Q7ENw1mTsh3LmaRrFyTcKHM2yPCcCM954l6BasQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWuzidkOgfvBCsJStMdRwi4Tqh23CrcZc5qUgbXMKoUGI67NElpZuZZTm7agDTfRGRjgJC30C+NCKRVN7EGaAJ4PzHc6YpLQMenD61sw1UfaspzlSaAQUXHPgXy0zNtNQRZC+Vj9arQ31KHFyk/XiNdMunZ/U70NQOfONbJYvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpNiTJ6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpNiTJ6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712850295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vQ7P/yP4wYRRxbHEL+IxPjrSaIDrLl5CNIXerpX7QOI=;
	b=hpNiTJ6n9s20PsUyKhDo9WEwFVd45VLRa/e5ufAL1X2TnMD+PDoV4pTnoiLSnE6iUG1b7p
	yR4LpjdJtENxfzYl9KWmU7nB3uzy52387wbvcaLGhOX5jYLCGklc1YGmPULA/lmg3If/QH
	1WmBSUEpzXVFKXaRu/LAEHsFlJe/MNY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-Z6A_y9w2OWKs4-SBSVrv0g-1; Thu,
 11 Apr 2024 11:44:51 -0400
X-MC-Unique: Z6A_y9w2OWKs4-SBSVrv0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0BC33C0ED58;
	Thu, 11 Apr 2024 15:44:50 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE003C21;
	Thu, 11 Apr 2024 15:44:49 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: xmu@redhat.com,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH net] netlabel: fix RCU annotation for IPv4 options on socket creation
Date: Thu, 11 Apr 2024 17:44:06 +0200
Message-ID: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Xiumei reports the following splat when netlabel and TCP socket are used:

 =============================
 WARNING: suspicious RCU usage
 6.9.0-rc2+ #637 Not tainted
 -----------------------------
 net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by ncat/23333:
  #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setattr+0x25/0x1b0

 stack backtrace:
 CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
 Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
 Call Trace:
  <TASK>
  dump_stack_lvl+0xa9/0xc0
  lockdep_rcu_suspicious+0x117/0x190
  cipso_v4_sock_setattr+0x1ab/0x1b0
  netlbl_sock_setattr+0x13e/0x1b0
  selinux_netlbl_socket_post_create+0x3f/0x80
  selinux_socket_post_create+0x1a0/0x460
  security_socket_post_create+0x42/0x60
  __sock_create+0x342/0x3a0
  __sys_socket_create.part.22+0x42/0x70
  __sys_socket+0x37/0xb0
  __x64_sys_socket+0x16/0x20
  do_syscall_64+0x96/0x180
  ? do_user_addr_fault+0x68d/0xa30
  ? exc_page_fault+0x171/0x280
  ? asm_exc_page_fault+0x22/0x30
  entry_SYSCALL_64_after_hwframe+0x71/0x79
 RIP: 0033:0x7fbc0ca3fc1b
 Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
 RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
 RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
 RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
 RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
 R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
 R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
  </TASK>

The current implementation of cipso_v4_sock_setattr() replaces IP options
under the assumption that the caller holds the socket lock; however, such
assumption is not true, nor needed, in selinux_socket_post_create() hook.

Using rcu_dereference_check() instead of rcu_dereference_protected() will
avoid the reported splat for the netlbl_sock_setattr() case, and preserve
the legitimate check when the caller is netlbl_conn_setattr().

Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
Reported-by: Xiumei Mu <xmu@redhat.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 8b17d83e5fde..1d0c2a905078 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1876,8 +1876,10 @@ int cipso_v4_sock_setattr(struct sock *sk,
 
 	sk_inet = inet_sk(sk);
 
-	old = rcu_dereference_protected(sk_inet->inet_opt,
-					lockdep_sock_is_held(sk));
+	/* caller either holds rcu_read_lock() (on socket creation)
+	 * or socket lock (in all other cases). */
+	old = rcu_dereference_check(sk_inet->inet_opt,
+				    lockdep_sock_is_held(sk));
 	if (inet_test_bit(IS_ICSK, sk)) {
 		sk_conn = inet_csk(sk);
 		if (old)
-- 
2.44.0

