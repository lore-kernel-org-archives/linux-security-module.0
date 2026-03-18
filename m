Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F236604D;
	Wed, 18 Mar 2026 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814809; cv=none; b=eEGyh2bXqx7FQBYm8DdexvnSuVOsklAYFkQA3qB/H2DtQUpfiJ5yJRXsJQKAS/Hg5RtHdVQivkIa2GARV5lyDtx7RgxCRl8iL06gcU0stidDaHlTP4fA1MWfBpwDl6UA8zH5uh5CTqdIqcpqY8W51zNjgm1hGtLLiOiFOxbPvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814809; c=relaxed/simple;
	bh=RKnfp3lIMZbjyp9u+KoYB0KW5j6r6GIcddYQ4SogiOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7fyRkzJip+PupRs4KGb0JBhXQ7SA1q4SWEwgYgaA6r8LzenL4J28kkZYgPt4rNTP24vAFE4n3UVN20Gb0BSOPKIdZlUbMO3WOlfUuRqspZGPdcoankwLYARTegOzgVPvQqnsxQmv7azd71hxR+1wvg3b2oH9/eCFgfQyBtNeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d6daLD1u; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d6daLD1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DV
	dGvuzrKFZ2rbqb1TpxRnxoVjBWpxqbzjO6jVVnOWA=; b=d6daLD1uz6Xeby7Ejj
	0Ah7ASTIFBkQc5w8sNVLdTUCSBg3w4URVAPQlaB/GEAAoWF+D8wX5N72NE5SL26s
	fD5gVncZ5zmpuA/zXfGIptHA9l2e/A/wRU+F9GiSdfuPaDl71k2ijcl7C6uNORfM
	8vHmy6S6hltD1WORmRvfjCS9M=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDn1fXuQ7pplHaTRw--.4684S2;
	Wed, 18 Mar 2026 14:19:28 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
Date: Wed, 18 Mar 2026 14:19:25 +0800
Message-Id: <20260318061925.134954-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDn1fXuQ7pplHaTRw--.4684S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw45tFWxJw4fZw18Ar1UWrg_yoW7Cw1xpw
	4jqFWUGr48Gr1xJr4xCF1Uur1IqrWDZFyUXr47Ar1rG3W7Z3Z8JF4UAr4jywnxKry5G34f
	Xr97XwsY9wnrtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxIWjmm6Q-JA+AAA3f

From: Feng Yang <yangfeng@kylinos.cn>

After hooking the following BPF program:
SEC("lsm/xfrm_decode_session")
int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
{
    return 1; // Any non-zero value
}
Subsequent packet transmission triggers will cause a kernel panic:

[  112.838874] ------------[ cut here ]------------
[  112.838895] kernel BUG at security/security.c:5282!
[  112.838902] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  112.838905] CPU: 5 PID: 4962 Comm: test Kdump: loaded Not tainted 6.19.0-rc5-gae23bc81ddf7 #2 PREEMPT(full)
[  112.838907] Source Version: 55e2f799c748c8e195569363edbd1d6a4159675a
[  112.838908] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  112.838909] RIP: 0010:security_skb_classify_flow+0x3f/0x50
[  112.838914] Code: 85 db 74 28 49 89 fc 48 8d 6e 14 eb 08 48 8b 1b 48 85 db 74 17 31 d2 48 8b 43 18 48 89 ee 4c 89 e7 e8 05 33 86 00 85 c0 74 e3 <0f> 0b 5b 5d 41 5c c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90
[  112.838915] RSP: 0018:ffffc28400200b10 EFLAGS: 00010202
[  112.838918] RAX: 0000000000000001 RBX: ffffffff91d346d8 RCX: 0000000000000000
[  112.838919] RDX: ffffa0890f5eaf80 RSI: 0000000000000001 RDI: ffffa0890f5eaf80
[  112.838920] RBP: ffffc28400200d04 R08: 00000000000000c7 R09: 0000000000000002
[  112.838922] R10: 0000000000000000 R11: 000000000000000f R12: ffffa089086dedc0
[  112.838923] R13: ffffc28400200cf0 R14: ffffa08901ab2000 R15: 0000000000000000
[  112.838926] FS:  00007fb087dd2680(0000) GS:ffffa0891ba80000(0000) knlGS:0000000000000000
[  112.838927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.838929] CR2: 00007fb087d1b940 CR3: 0000000107520006 CR4: 00000000000706e0
[  112.838930] Call Trace:
[  112.838931]  <IRQ>
[  112.838933]  icmp_route_lookup.constprop.0+0xd7/0x460
[  112.838941]  ? switch_hrtimer_base+0x135/0x180
[  112.838944]  ? update_sg_lb_stats+0x9c/0x440
[  112.838949]  __icmp_send+0x3d3/0x740
[  112.838952]  ? __udp4_lib_rcv+0x427/0x6f0
[  112.838955]  __udp4_lib_rcv+0x427/0x6f0
[  112.838957]  ip_protocol_deliver_rcu+0xb7/0x170
[  112.838960]  ip_local_deliver_finish+0x76/0xa0
[  112.838961]  __netif_receive_skb_one_core+0x89/0xa0
[  112.838967]  process_backlog+0x95/0x140
[  112.838969]  __napi_poll+0x2b/0x1c0
[  112.838971]  net_rx_action+0x2aa/0x3a0
[  112.838972]  ? swake_up_one+0x41/0x70
[  112.838974]  ? kvm_sched_clock_read+0x11/0x20
[  112.838977]  handle_softirqs+0xe3/0x2e0
[  112.838980]  do_softirq+0x43/0x60
[  112.838982]  </IRQ>
[  112.838982]  <TASK>
[  112.838983]  __local_bh_enable_ip+0x68/0x70
[  112.838985]  __dev_queue_xmit+0x1c4/0x820
[  112.838987]  ? nf_hook_slow+0x45/0xd0
[  112.838989]  ip_finish_output2+0x1da/0x4a0
[  112.838992]  ip_send_skb+0x86/0x90
[  112.838994]  udp_send_skb+0x15e/0x380
[  112.838996]  udp_sendmsg+0xb9a/0xf80
[  112.838998]  ? __pfx_ip_generic_getfrag+0x10/0x10
[  112.839003]  ? __sys_sendto+0x1e4/0x210
[  112.839005]  __sys_sendto+0x1e4/0x210
[  112.839007]  ? __handle_mm_fault+0x2fc/0x6c0
[  112.839013]  __x64_sys_sendto+0x24/0x30
[  112.839014]  do_syscall_64+0x5f/0x270
[  112.839017]  entry_SYSCALL_64_after_hwframe+0x76/0xe0
[  112.839020] RIP: 0033:0x7fb087cfdb17
[  112.839021] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 55 c8 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
[  112.839023] RSP: 002b:00007ffea64704e8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  112.839025] RAX: ffffffffffffffda RBX: 00007ffea6470638 RCX: 00007fb087cfdb17
[  112.839026] RDX: 0000000000000008 RSI: 00007ffea64704f8 RDI: 0000000000000003
[  112.839027] RBP: 00007ffea6470520 R08: 00007ffea6470500 R09: 0000000000000010
[  112.839029] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  112.839030] R13: 00007ffea6470648 R14: 0000000000403df0 R15: 00007fb087e15000
[  112.839032]  </TASK>

This BUG_ON was first mentioned in [1], but I could not find any explanatory record of why this check is needed.

[1] https://lore.kernel.org/all/Pine.LNX.4.64.0607122149070.573@d.namei/

In the existing LSM_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
when the `ckall` parameter of the `selinux_xfrm_decode_session` function is 0,
it can only return 0 and will not trigger BUG_ON.
Therefore, remove the BUG_ON check to fix this issue.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Closes: https://lore.kernel.org/all/4c4d04ba.6c12b.19c039b69e6.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 security/security.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..198f650070da 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4991,10 +4991,7 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
-	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
-			       0);
-
-	BUG_ON(rc);
+	call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid, 0);
 }
 EXPORT_SYMBOL(security_skb_classify_flow);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-- 
2.43.0

