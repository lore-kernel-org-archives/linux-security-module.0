Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90295171AD;
	Sat, 16 Mar 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710591610; cv=none; b=JB+iNwNDdYKsEcy7avdo9y2W1RR3sNqpMzLu5Pm7jKDesvUA5y5AQsbdEFdJK6AQjeJ0vaZhM+zSEaHZk54zTJf6lRnD5FjNTqlorBkmywDxkLdu2S0DCHhhFshD08fpgN/GJRCeOafZI5YlwmILUlqeaiGxPKTtOEYNAOKXelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710591610; c=relaxed/simple;
	bh=6XYTXU0hZs4EdZDZYUMqxaUi1+XBZVM7Y2TtZSDAPAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpCDJDXd6hswYQOgPLlLz2kxhDj2DZO4w6gjWA/YcSzG8y5s23ptd4a0CDwnouCF0gMfSvecQ8+JPKqrslSpYasWU4SksKAHiuk/2ROfWnnuSr8bcg2gyg7I4t5xXqxWULbAnzasT3WkpNBrRdMG35Ey9l+tQxwRuWfr9zry8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TxgDG3RBTz4f3kpB;
	Sat, 16 Mar 2024 20:19:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4D1831A0A09;
	Sat, 16 Mar 2024 20:20:04 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgCXsQpyjvVls7GEHA--.54843S2;
	Sat, 16 Mar 2024 20:20:03 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 0/5] Fix kernel panic caused by bpf lsm return value
Date: Sat, 16 Mar 2024 20:23:54 +0800
Message-Id: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXsQpyjvVls7GEHA--.54843S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4kKF48tFWxCF1rAry3CFg_yoWrZF4xpr
	43KF18Gr4IqrWUJF1IkF45Jr13JFZrA3WUXryxJr95AF15Ww1DJr18JrWjqr9xJr4UAr17
	tFyqqa1rtry8XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

A bpf prog returning positive number attached to file_alloc_security hook
will make kernel panic.

Here is a panic log:

[  441.235774] BUG: kernel NULL pointer dereference, address: 00000000000009
[  441.236748] #PF: supervisor write access in kernel mode
[  441.237429] #PF: error_code(0x0002) - not-present page
[  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PMD 0
[  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
[  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0cbf23373 #22
[  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b4
[  441.241933] RIP: 0010:alloc_file+0x4b/0x190
[  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe ff ff 48 3d 00 f0 ff fb
[  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
[  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 0000000035b08000
[  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0b8088ffff
[  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 0000000000000001
[  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffffffffffff4
[  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
[  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 0000000000170ef0
[  441.252688] Call Trace:
[  441.253011]  <TASK>
[  441.253296]  ? __die+0x24/0x70
[  441.253702]  ? page_fault_oops+0x15b/0x480
[  441.254236]  ? fixup_exception+0x26/0x330
[  441.254750]  ? exc_page_fault+0x6d/0x1c0
[  441.255257]  ? asm_exc_page_fault+0x26/0x30
[  441.255792]  ? alloc_file+0x4b/0x190
[  441.256257]  alloc_file_pseudo+0x9f/0xf0
[  441.256760]  __anon_inode_getfile+0x87/0x190
[  441.257311]  ? lock_release+0x14e/0x3f0
[  441.257808]  bpf_link_prime+0xe8/0x1d0
[  441.258315]  bpf_tracing_prog_attach+0x311/0x570
[  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
[  441.259605]  __sys_bpf+0x1bb7/0x2dc0
[  441.260070]  __x64_sys_bpf+0x20/0x30
[  441.260533]  do_syscall_64+0x72/0x140
[  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  441.261643] RIP: 0033:0x4b0349
[  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 88
[  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 00000000004b0349
[  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 000000000000001c
[  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 0000000000000000
[  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 00000000004004e8

The reason is that the positive number returned by bpf prog is not a
valid errno, and could not be filtered out with IS_ERR which is used by
the file system to check errors. As a result, the file system uses this
positive number as file pointer, causing panic.

To fix this issue, there are two schemes:

1. Modify the calling sites of file_alloc_security to take positive
   return values as zero.

2. Make the bpf verifier to ensure no unpredicted value is returned by
   lsm bpf prog.

Considering that hook file_alloc_security never returned positive number
before bpf lsm was introduced, and other bpf lsm hooks may have the same
problem, scheme 2 is more reasonable.

So this patch set adds lsm return value check in verifier to fix it.

Xu Kuohai (5):
  bpf, lsm: Annotate lsm hook return integer with new macro LSM_RET_INT
  bpf, lsm: Add return value range description for lsm hook
  bpf, lsm: Add function to read lsm hook return value range
  bpf, lsm: Check bpf lsm hook return values in verifier
  bpf: Fix compare error in function retval_range_within

 include/linux/bpf.h           |   1 +
 include/linux/bpf_lsm.h       |   8 +
 include/linux/lsm_hook_defs.h | 433 +++++++++++++++++-----------------
 include/linux/lsm_hooks.h     |   6 -
 kernel/bpf/bpf_lsm.c          |  66 +++++-
 kernel/bpf/btf.c              |   5 +-
 kernel/bpf/verifier.c         |  59 ++++-
 security/security.c           |   1 +
 8 files changed, 348 insertions(+), 231 deletions(-)

-- 
2.30.2

