Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A616F29D;
	Mon, 25 Mar 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360382; cv=none; b=OMFzRKYdUuBa5pWzTJpwpUTVSfEq3yXMUanYXrWn31ENgGb5bpU6cUYHlfKsyEvRkcvBC/d6eLdAJ7LSrEjo2+mvEelhcs0YwPb36kk96BbDkf4DZEpJ8lVjAYJkQ3O8AwhJOybGpPI0Db2rhK447qbid7he4y29JHWdAqwLRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360382; c=relaxed/simple;
	bh=/CxeULT5kR+RD3NSe0u40FOQAIPQdqzrfrThysSCq1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1/exMDy6g3GLEBg5mrGRM57EXePx20bj2mMyUsWXRse1hU/G7CkyjWRE3Ma0iN8hIhbEuwUjffe84haf/ilXM9b3h/3n8QLx/PqcCdvglp1zNPRz15PyWwwwhuYfkRxd2zQuxLiOh0XMiwEkcZVFiLvMh5FTDjaUEzyxY0tBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V37XN5dcGz4f3l8C;
	Mon, 25 Mar 2024 17:52:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C40B61A01A8;
	Mon, 25 Mar 2024 17:52:56 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgDn9Jx1SQFmHl6fHw--.8953S7;
	Mon, 25 Mar 2024 17:52:56 +0800 (CST)
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
Subject: [PATCH bpf-next v2 5/7] bpf: Fix compare error in function retval_range_within
Date: Mon, 25 Mar 2024 17:56:51 +0800
Message-Id: <20240325095653.1720123-6-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
References: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDn9Jx1SQFmHl6fHw--.8953S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfWF4kKw15tF1kuw13twb_yoW8Zr1fpF
	1rGr1qyw4DXr43W3yjyr4kA3yrK3Wjqw47KFWkC34Fyw15tryqgF4UKw4akrW5KrW8Ww1S
	vF12v3yYqa4UuaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1tr
	cDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

After checking lsm hook return range in verifier, the test case
"test_progs -t test_lsm" failed, and the failure log says:

libbpf: prog 'test_int_hook': BPF program load failed: Invalid argument
libbpf: prog 'test_int_hook': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
0: (79) r0 = *(u64 *)(r1 +24)         ; R0_w=scalar(smin=smin32=-4095,smax=smax32=0) R1=ctx()

[...]

24: (b4) w0 = -1                      ; R0_w=0xffffffff
; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
25: (95) exit
At program exit the register R0 has smin=4294967295 smax=4294967295 should have been in [-4095, 0]

It can be seen that instruction "w0 = -1" zero extended -1 to 64-bit
register r0, setting both smin and smax values of r0 to 4294967295.
This resulted in a false reject when r0 was checked with range [-4095, 0].

Given bpf_retval_range is a 32-bit range, this patch fixes it by
changing the compare between r0 and return range from 64-bit
operation to 32-bit operation.

Fixes: 8fa4ecd49b81 ("bpf: enforce exact retval range on subprog/callback exit")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c3387357bc0d..36cd13982926 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9864,7 +9864,7 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 
 static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
 {
-	return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
+	return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
 }
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
-- 
2.30.2

