Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458A224D4;
	Sat, 25 Jan 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737814517; cv=none; b=syPG0dpX665Ec914wjPLC9zFqB01vaWp08NBs8OnNckZGRSlfEL5xGJhqk8R3W3rnsAU32yoqxFzAZXJXawSFEehKdhj/zE5VWEYOpVBuRPsoSihX5tRWVlL3wj/6/opGiLx84UzhKIEN1kKZXJpxfuD27jmfwHdL5Am73GwzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737814517; c=relaxed/simple;
	bh=6H/aO0bio0rLZIJs97M/Ym2q5HFo1VJ69ZsLV4Onr2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8GkltvrHMTL1tPqYkhpRrU/QHz8FXgheWbOHso2I0ZS1mKfV7Cw0k0SK5tD/JDleZ3qrbehEyKT/RJCXMaS+KRXcbunBeuDpM3ChVElJLmWAy3McfSVyV5nAcev46V8KbVs9sro8Xz2wUZATyRfLht7iZjx8hZP+2TInlGfSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8CxyuDo8ZRnPtNoAA--.7115S3;
	Sat, 25 Jan 2025 22:15:04 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMAxPMXX8ZRn9gguAA--.14179S2;
	Sat, 25 Jan 2025 22:15:03 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] audit: Initialize lsmctx to avoid memory allocation error
Date: Sat, 25 Jan 2025 22:14:35 +0800
Message-ID: <20250125141435.205096-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxPMXX8ZRn9gguAA--.14179S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw18Gr1fZFWDWr4fZw48KrX_yoWrKrW8pF
	y5Ar48Cr4kXryUAr10yF1DJrW7X3WUCa1UJr17Gr17G3WUJw1DJr1UGrW7Cw1UJrn8JrW7
	ArnrZr1rtr1DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

Initialize the local variable lsmctx in audit_receive_msg(), so as to
avoid memory allocation errors like:

[  258.074914] WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x4c8/0x1040
[  258.074997] pc 900000000304d588 ra 9000000003059644 tp 9000000107774000 sp 9000000107777890
[  258.075000] a0 0000000000040cc0 a1 0000000000000012 a2 0000000000000000 a3 0000000000000000
[  258.075003] a4 9000000107777bd0 a5 0000000000000280 a6 0000000000000010 a7 0000000000000000
[  258.075006] t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264c80 t3 000000000000002e
[  258.075009] t4 0000000000000000 t5 00000000000003f6 t6 90000001066b6310 t7 000000000000002f
[  258.075011] t8 000000000000003c u0 00000000000000b4 s9 900000010006f880 s0 9000000004a4b000
[  258.075014] s1 0000000000000000 s2 9000000004a4b000 s3 9000000106673400 s4 9000000107777af0
[  258.075017] s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff000 s8 0000000000000004
[  258.075019]    ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
[  258.075026]   ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x1040
[  258.075030]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[  258.075040]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[  258.075045]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
[  258.075051]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[  258.075056] ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
[  258.075061]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
[  258.075064] CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-rc1+ #1899
[  258.075070] Stack : ffffffffffffffff 0000000000000000 9000000002debf5c 9000000107774000
[  258.075077]         90000001077774f0 0000000000000000 90000001077774f8 900000000489e480
[  258.075083]         9000000004b380e8 9000000004b380e0 9000000107777380 0000000000000001
[  258.075089]         0000000000000001 9000000004a4b000 1f3f37829c264c80 90000001001a9b40
[  258.075094]         9000000107774000 9000000004b080e8 00000000000003d4 9000000004b080e8
[  258.075100]         9000000004a580e8 000000000000002d 0000000006ebc000 900000010006f880
[  258.075106]         00000000000000b4 0000000000000000 0000000000000004 0000000000001277
[  258.075112]         900000000489e480 90000001066b6300 0000000000000012 fffffffffffff000
[  258.075118]         0000000000000004 900000000489e480 9000000002def6a8 00007ffff2ba4065
[  258.075124]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
[  258.075129]         ...
[  258.075132] Call Trace:
[  258.075135] [<9000000002def6a8>] show_stack+0x30/0x148
[  258.075146] [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
[  258.075152] [<9000000002e0fe18>] __warn+0x80/0x108
[  258.075158] [<900000000407486c>] report_bug+0x154/0x268
[  258.075163] [<90000000040ad468>] do_bp+0x2a8/0x320
[  258.075172] [<9000000002dedda0>] handle_bp+0x120/0x1c0
[  258.075178] [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
[  258.075183] [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
[  258.075187] [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
[  258.075192] [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
[  258.075199] [<9000000002f1065c>] audit_receive+0xe4/0x1c0
[  258.075204] [<9000000003e5abe8>] netlink_unicast+0x340/0x450
[  258.075211] [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
[  258.075216] [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
[  258.075222] [<9000000003da32f0>] __sys_sendto+0x100/0x170
[  258.075226] [<9000000003da3374>] sys_sendto+0x14/0x28
[  258.075229] [<90000000040ad574>] do_syscall+0x94/0x138
[  258.075233] [<9000000002ded318>] handle_syscall+0xb8/0x158

Root cause: if we enable AUDIT but disable LSM, in the AUDIT_SIGNAL_INFO
case, lsmprop_is_set() returns false, then kmalloc() may try to allocate
a large amount of memory with an uninitialized length.

Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update commit message and CC list.

 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 13d0144efaa3..5f5bf85bcc90 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1221,7 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct audit_buffer	*ab;
 	u16			msg_type = nlh->nlmsg_type;
 	struct audit_sig_info   *sig_data;
-	struct lsm_context	lsmctx;
+	struct lsm_context	lsmctx = { NULL, 0, 0 };
 
 	err = audit_netlink_ok(skb, msg_type);
 	if (err)
-- 
2.47.1

