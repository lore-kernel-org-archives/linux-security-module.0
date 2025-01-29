Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398921B6CEC;
	Wed, 29 Jan 2025 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152438; cv=none; b=mTOgP/GyeSnmbQQmQZCNEyaVhiggvSLxo86iCTALbrrNfObaETqy8fAFPpVerT+z+Xnla/NnxEBy/tiyeZl8GoR2E8x1SD02Kx5lhmCXHO4/Is92wGyip+VMRSrdrjqbQOuFxagHPttLb9t38/aMEUW0FtjUBNuf2u/AzU2hqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152438; c=relaxed/simple;
	bh=7T70VKAAIl3j+ukN7O0lBNZ+VWZNarqYwWnQCBT2WeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElItouEH05UYqPlKlipvsnJFLbeMFMKjWIrpCgF/2RbFfQVVOC8NXC8GUJZd11iH2n1lSNyXOgO3dngOzP136ij7x61kdLojcwfnFGISQ5yeJWU/APlRhoJqOZpOP7KNjMP8tQviD1jhQ5u4gCwb20fGDs71/OkFlbO6BSOOUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8AxaeHtGZpnry5qAA--.10183S3;
	Wed, 29 Jan 2025 20:07:09 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMAxPMXjGZpnmoEwAA--.14902S2;
	Wed, 29 Jan 2025 20:07:07 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3] audit: Initialize lsmctx to avoid memory allocation error
Date: Wed, 29 Jan 2025 20:06:52 +0800
Message-ID: <20250129120652.308571-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxPMXjGZpnmoEwAA--.14902S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw17Wry5Gr4fZw45CFyxCrX_yoWrCr17pF
	yUJr48Gr48JryUAr1UAF1UJr4UJw1DCF18Jr1UGr1UJr1UJr1DWF1UtrW7Gr1UJr45Jr17
	Jw1DJw45tr1DJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

When audit is enabled in a kernel build, and there are no LSMs active
that support LSM labeling, it is possible that local variable lsmctx
in the AUDIT_SIGNAL_INFO handler in audit_receive_msg() could be used
before it is properly initialize. Then kmalloc() will try to allocate
a large amount of memory with the uninitialized length. 

This patch corrects this problem by initializing the lsmctx to a safe
value when it is declared, which avoid errors like:

 WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc_pages_noprof
 pc 900000000304d588 ra 9000000003059644 tp 9000000107774000 sp 9000000107777890
 a0 0000000000040cc0 a1 0000000000000012 a2 0000000000000000 a3 0000000000000000
 a4 9000000107777bd0 a5 0000000000000280 a6 0000000000000010 a7 0000000000000000
 t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264c80 t3 000000000000002e
 t4 0000000000000000 t5 00000000000003f6 t6 90000001066b6310 t7 000000000000002f
 t8 000000000000003c u0 00000000000000b4 s9 900000010006f880 s0 9000000004a4b000
 s1 0000000000000000 s2 9000000004a4b000 s3 9000000106673400 s4 9000000107777af0
 s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff000 s8 0000000000000004
    ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
   ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x1040
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 00000004 (PPLV0 +PIE -PWE)
  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
 CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-rc1+ #1899
 Stack : ffffffffffffffff 0000000000000000 9000000002debf5c 9000000107774000
         90000001077774f0 0000000000000000 90000001077774f8 900000000489e480
         9000000004b380e8 9000000004b380e0 9000000107777380 0000000000000001
         0000000000000001 9000000004a4b000 1f3f37829c264c80 90000001001a9b40
         9000000107774000 9000000004b080e8 00000000000003d4 9000000004b080e8
         9000000004a580e8 000000000000002d 0000000006ebc000 900000010006f880
         00000000000000b4 0000000000000000 0000000000000004 0000000000001277
         900000000489e480 90000001066b6300 0000000000000012 fffffffffffff000
         0000000000000004 900000000489e480 9000000002def6a8 00007ffff2ba4065
         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
         ...
 Call Trace:
 [<9000000002def6a8>] show_stack+0x30/0x148
 [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
 [<9000000002e0fe18>] __warn+0x80/0x108
 [<900000000407486c>] report_bug+0x154/0x268
 [<90000000040ad468>] do_bp+0x2a8/0x320
 [<9000000002dedda0>] handle_bp+0x120/0x1c0
 [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
 [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
 [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
 [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
 [<9000000002f1065c>] audit_receive+0xe4/0x1c0
 [<9000000003e5abe8>] netlink_unicast+0x340/0x450
 [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
 [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
 [<9000000003da32f0>] __sys_sendto+0x100/0x170
 [<9000000003da3374>] sys_sendto+0x14/0x28
 [<90000000040ad574>] do_syscall+0x94/0x138
 [<9000000002ded318>] handle_syscall+0xb8/0x158

Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update commit message and CC list.
V3: Update commit message again (thanks to Paul).

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

