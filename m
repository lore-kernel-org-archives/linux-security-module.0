Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080D280318;
	Tue, 26 May 2026 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758624; cv=none; b=g2o9kEOnADr4Yrcj6ptFC9xd5he7LejbxuwLKnauOE2vkd0H42p7rbYhFNLtUwYDV8G14Z8zqRx9T0n//MPTPqwgQYwj8Wo1NjKFZad5aTSZQx7yeBIrF00+e+C7AkUbxzwdTK62tRePMYy0jDDM+Apa+p3kmtgK9aCF6wHDEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758624; c=relaxed/simple;
	bh=ptaZMqRoKRah2EWEYFI3B99xkjghr5huwIqwCjuwQzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oP4fQRtWzGe1OLD3hn1dEmleN278gE5ES6XirSBxVZxOK78IC/Pgu2h6uY/TLp2xyqMqkpzoiaTZi+1mTEKC33H/LnU7k94ID8V/52uyDncOfDq4w/VxEdTF7kNSxZplhRwgHz8a9WEbYzucMsu9NKeCj6DBfce15ZDOAbmDYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXr9IG9hRqaX5zEQ--.4180S2;
	Tue, 26 May 2026 09:23:18 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: "Serge E . Hallyn" <serge@hallyn.com>,
	James Morris <jmorris@namei.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Paul Moore <paul@paul-moore.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] tomoyo: Fix NULL pointer dereference in tomoyo_init_request_info() when domain is NULL
Date: Tue, 26 May 2026 01:23:15 +0000
Message-Id: <20260526012315.762144-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXr9IG9hRqaX5zEQ--.4180S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrGF13CFW5GrW3XFy8Grg_yoWrWryDpF
	43tF1UGr48JFnrtFs7JFy5WryUtry5Ca47GrsxJr18JF1Duw4kJr17Jr4fur98Jr4UJFy7
	trnFqrWFgr1DGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

tomoyo_domain() can return NULL when the current task has no TOMOYO
domain_info set.  When this happens, tomoyo_init_request_info() sets 
r->domain = NULL and then dereferences the NULL domain via 
domain->profile and later domain->acl_info_list in tomoyo_check_acl(), 
causing a kernel page fault.

Add a NULL check after tomoyo_domain() and return TOMOYO_CONFIG_DISABLED
when domain is NULL.  All callers that can reach this path already check
for TOMOYO_CONFIG_DISABLED and bail out, so this prevents the crash
without changing the control flow for those callers.

Fixes: c3ef1500ec8338 ("TOMOYO: Split files into some pieces.")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 security/tomoyo/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 6799b1122c9d8..cdc085390949c 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1024,6 +1024,8 @@ int tomoyo_init_request_info(struct tomoyo_request_info *r,
 	memset(r, 0, sizeof(*r));
 	if (!domain)
 		domain = tomoyo_domain();
+	if (!domain)
+		return TOMOYO_CONFIG_DISABLED;
 	r->domain = domain;
 	profile = domain->profile;
 	r->profile = profile;
-- 
2.34.1

Found by fuzzing. Here is the report:

Unable to handle kernel paging request at virtual address dfffffff00000003
Current syz-executor pgtable: 4K pagesize, 57-bit VAs, pgdp=0x000000012edec000
[dfffffff00000003] pgd=000000005fffe401, p4d=000000005fffe001, pud=0000000000000000
Oops [#1]
Modules linked in:
CPU: 0 UID: 0 PID: 3126 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : tomoyo_check_acl+0x90/0x4bc security/tomoyo/domain.c:173
 ra : tomoyo_check_acl+0x86/0x4bc security/tomoyo/domain.c:173
epc : ffffffff8149cf64 ra : ffffffff8149cf5a sp : ff200000040c7a90
 gp : ffffffff8a395420 tp : ff60000089d05040 t0 : ff200000040c7960
 t1 : 000000000000000f t2 : ffffffff86c068b0 s0 : ff200000040c7b10
 s1 : 0000000000000000 a0 : 0000000000000018 a1 : 0000000000000000
 a2 : 0000000000000002 a3 : ffffffff8149cf5a a4 : 0000000000000000
 a5 : dfffffff00000003 a6 : 0000000000000003 a7 : 000000003dfe34af
 s2 : dfffffff00000000 s3 : ff200000040c7b80 s4 : ff600000872a1510
 s5 : ffe3ffff00818f79 s6 : 0000000000000000 s7 : ffffffff814a2e18
 s8 : ff600000872a1500 s9 : ff200000040c7bc8 s10: 0000000000000002
 s11: 0000000000000000 t3 : 6a92f41f00000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: dfffffff00000003 cause: 000000000000000d
[<ffffffff8149cf64>] tomoyo_check_acl+0x90/0x4bc security/tomoyo/domain.c:173
[<ffffffff814a4108>] tomoyo_path_number_perm+0x384/0x5a4 security/tomoyo/file.c:738
[<ffffffff814b0cc4>] tomoyo_file_ioctl+0x28/0x34 security/tomoyo/tomoyo.c:350
[<ffffffff81454e8c>] security_file_ioctl+0xaa/0x2c2 security/security.c:2512
[<ffffffff80d45c5e>] __do_sys_ioctl fs/ioctl.c:591 [inline]
[<ffffffff80d45c5e>] __se_sys_ioctl fs/ioctl.c:583 [inline]
[<ffffffff80d45c5e>] __riscv_sys_ioctl+0xae/0x1e4 fs/ioctl.c:583
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa9ea>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff867267f6>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
Code: 2544 1097 ff0a 80e7 e9c0 8513 0184 5793 0035 97ca (8703) 0007 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	2544                	fld	fs1,136(a0)
   2:	ff0a1097          	auipc	ra,0xff0a1
   6:	e9c080e7          	jalr	-356(ra) # 0xffffffffff0a0e9e
   a:	01848513          	addi	a0,s1,24
   e:	00355793          	srli	a5,a0,0x3
  12:	97ca                	add	a5,a5,s2
* 14:	00078703          	lb	a4,0(a5) <-- trapping instruction

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

