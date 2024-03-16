Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6517722;
	Sat, 16 Mar 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710591616; cv=none; b=YY1g07K9VeX/iKulCqknTsa4bZJF3jJUQ9uiKbkoijPl7PcXHP/yj+O6hwuCVUeU/cwsuPZlEEADa52bxb4qRzhkcM5ZWbsKxN8qkuF74EHFQN0ZNE+FlH5sE40anMIORLZ9zwwvCHVQJws+1WVpytX+5irzsNL7QV+XfnqoZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710591616; c=relaxed/simple;
	bh=IpVvsg5pgqObEzqUtaStyBRmpMlsNmKyhThSkEbN48Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcrWXPBGh0K6jvTLGcU9q6SPEvIn4MscxrX0BclYVJoSc3LzqJee5pVabaytf28ZkqlsQuO7aIWCTNh0SyycrITfN6fFKcwKP4IzcAyEtEIXQY+c7Tb4ePEXii73+rsTkXmUFyMyxuQG7+cXTmhigb6U/A1PrWzTOD3vPM+saF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TxgDF1JQnz4f3n6c;
	Sat, 16 Mar 2024 20:19:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F02791A0199;
	Sat, 16 Mar 2024 20:20:04 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgCXsQpyjvVls7GEHA--.54843S6;
	Sat, 16 Mar 2024 20:20:04 +0800 (CST)
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
Subject: [PATCH bpf-next 4/5] bpf, lsm: Check bpf lsm hook return values in verifier
Date: Sat, 16 Mar 2024 20:23:58 +0800
Message-Id: <20240316122359.1073787-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
References: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXsQpyjvVls7GEHA--.54843S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr47tFW5Kw48uFyfCFykKrg_yoWxXr4rpF
	s5GrWkCr40yFWxuFnrtan7ZFyrArW8Wa4Ik34xC34SyFZxXr9YqFyqgryjvr1SkrWkCw1x
	Cr4jvrZxuw1UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

A bpf prog returning positive number attached to file_alloc_security hook
will make kernel panic.

The reason is that the positive number returned by bpf prog is not a
valid errno, and could not be filtered out with IS_ERR which is used by
the file system to check errors. As a result, the file system uses this
positive number as file pointer, causing panic.

Considering that hook file_alloc_security never returned positive number
before bpf lsm was introduced, and other bpf lsm hooks may have the same
problem, this patch adds lsm return value check in bpf verifier to ensure
no unpredicted values will be returned by lsm bpf prog.

Fixes: 520b7aa00d8c ("bpf: lsm: Initialize the BPF LSM hooks")
Reported-by: Xin Liu <liuxin350@huawei.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/btf.c      |  5 +++-
 kernel/bpf/verifier.c | 57 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f20f62f9d63..aac92857a5a5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -917,6 +917,7 @@ struct bpf_insn_access_aux {
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
+	bool is_retval; /* is accessing function return value ? */
 };
 
 static inline void
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 90c4a32d89ff..d593684d80c6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6227,8 +6227,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	if (arg == nr_args) {
 		switch (prog->expected_attach_type) {
-		case BPF_LSM_CGROUP:
 		case BPF_LSM_MAC:
+			/* mark we are accessing the return value */
+			info->is_retval = true;
+			fallthrough;
+		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..c3387357bc0d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2325,6 +2325,25 @@ static void mark_reg_unknown(struct bpf_verifier_env *env,
 	__mark_reg_unknown(env, regs + regno);
 }
 
+static int __mark_reg_s32_range(struct bpf_verifier_env *env,
+				struct bpf_reg_state *regs,
+				u32 regno,
+				s32 s32_min,
+				s32 s32_max)
+{
+	struct bpf_reg_state *reg = regs + regno;
+
+	reg->s32_min_value = max_t(s32, reg->s32_min_value, s32_min);
+	reg->s32_max_value = min_t(s32, reg->s32_max_value, s32_max);
+
+	reg->smin_value = max_t(s64, reg->smin_value, s32_min);
+	reg->smax_value = min_t(s64, reg->smax_value, s32_max);
+
+	reg_bounds_sync(reg);
+
+	return reg_bounds_sanity_check(env, reg, "s32_range");
+}
+
 static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 				struct bpf_reg_state *reg)
 {
@@ -5557,11 +5576,12 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, bool *is_retval)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
 		.log = &env->log,
+		.is_retval = false,
 	};
 
 	if (env->ops->is_valid_access &&
@@ -5574,6 +5594,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		 * type of narrower access.
 		 */
 		*reg_type = info.reg_type;
+		*is_retval = info.is_retval;
 
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
 			*btf = info.btf;
@@ -6715,6 +6736,17 @@ static int check_stack_access_within_bounds(
 	return grow_stack_state(env, state, -min_off /* size */);
 }
 
+static bool get_func_retval_range(struct bpf_prog *prog,
+				  struct bpf_retval_range *range)
+{
+	if (prog->type == BPF_PROG_TYPE_LSM &&
+		prog->expected_attach_type == BPF_LSM_MAC &&
+		!bpf_lsm_get_retval_range(prog, range)) {
+		return true;
+	}
+	return false;
+}
+
 /* check whether memory at (regno + off) is accessible for t = (read | write)
  * if t==write, value_regno is a register which value is stored into memory
  * if t==read, value_regno is a register which will receive the value from memory
@@ -6819,6 +6851,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
+		bool is_retval = false;
+		struct bpf_retval_range range;
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
 		u32 btf_id = 0;
@@ -6834,7 +6868,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, &is_retval);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -6843,7 +6877,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 * case, we know the offset is zero.
 			 */
 			if (reg_type == SCALAR_VALUE) {
-				mark_reg_unknown(env, regs, value_regno);
+				if (is_retval && get_func_retval_range(env->prog, &range)) {
+					err = __mark_reg_s32_range(env, regs, value_regno,
+								   range.minval, range.maxval);
+					if (err)
+						return err;
+				} else {
+					mark_reg_unknown(env, regs, value_regno);
+				}
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
@@ -15466,10 +15507,12 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
 	case BPF_PROG_TYPE_LSM:
 		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
-			/* Regular BPF_PROG_TYPE_LSM programs can return
-			 * any value.
-			 */
-			return 0;
+			/* no range found, any return value is allowed */
+			if (!get_func_retval_range(env->prog, &range))
+				return 0;
+			/* no restricted range, any return value is allowed */
+			if (range.minval == S32_MIN && range.maxval == S32_MAX)
+				return 0;
 		}
 		if (!env->prog->aux->attach_func_proto->type) {
 			/* Make sure programs that attach to void
-- 
2.30.2

