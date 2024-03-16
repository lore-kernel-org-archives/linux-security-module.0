Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC118C38;
	Sat, 16 Mar 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710591616; cv=none; b=Nsc8n/33poB7qaBUhgr4ky35uF7FG4i27vnPKhQiVKHBLnT6QeOxmNC73rUb2XFuXuERYg3Edi0tCnGz1y3JR6Tb6GfOaduwOjEJx3gokEGcFhWmO30oQXIKbr+IgLoPxAiLJ1nkzc1BqT737J89oCuPBKG7bk04YxVILQxhsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710591616; c=relaxed/simple;
	bh=iilZid+oT+pGEFAMunYNcrjmdyzHWWGlHCwE6zHW9lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjjiBrsv2c8XiZ4X7Sgw9Qqq8nlfMLfID1mmbmTVugXcQY4X+nDj6boBu6qucBRtyUVGC4DvOqd6oPPHElCCy4PVh+BwlVYPMaw2CwQXgpUdGl5C2fidTKMeyyU91Q9c/jVwJ6G+4fKBax7wQ7sqFJzDBJ8q+zRF+1WF0SO1B9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TxgDK0QGSz4f3kjd;
	Sat, 16 Mar 2024 20:20:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CE1791A016E;
	Sat, 16 Mar 2024 20:20:04 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgCXsQpyjvVls7GEHA--.54843S5;
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
Subject: [PATCH bpf-next 3/5] bpf, lsm: Add function to read lsm hook return value range
Date: Sat, 16 Mar 2024 20:23:57 +0800
Message-Id: <20240316122359.1073787-4-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXsQpyjvVls7GEHA--.54843S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45Zw1kGr1DuF45WFyDZFb_yoW5Kw45pF
	sxAa1Yyrs8Aw43KF1ayF4rA3W3Xr1vq3yUGFy7Gry2ya1Syw1kXa1DGrn8tr9xurWvkw15
	CF4jg3yfC347ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add function to read lsm hook return value range. The following patch
will use this information to check lsm hook return values in bpf
verifier.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf_lsm.h |  8 ++++++
 kernel/bpf/bpf_lsm.c    | 56 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..e51c042abf43 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
 #ifdef CONFIG_BPF_LSM
@@ -45,6 +46,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			      struct bpf_retval_range *range);
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -78,6 +81,11 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+					   struct bpf_retval_range *range)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index ee9d1a795334..7b4611fd3a37 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,7 +11,6 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
-#include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
@@ -40,6 +39,31 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #undef LSM_RET_INT
 #undef LSM_RET_VOID
 
+struct lsm_retval_desc {
+	unsigned long func_addr;
+	int minval;
+	int maxval;
+};
+
+#define LSM_RET_INT_ERRNO -MAX_ERRNO, 0
+#define LSM_RET_INT_ANY INT_MIN, INT_MAX
+#define LSM_RET_INT(defval, range_desc) LSM_RET_INT_##range_desc
+
+#define LSM_HOOK_RETVAL_int(NAME, ...) \
+{ (unsigned long)&bpf_lsm_##NAME, __VA_ARGS__ },
+
+#define LSM_HOOK_RETVAL_void(NAME, ...)
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+LSM_HOOK_RETVAL_##RET(NAME, DEFAULT)
+
+static struct lsm_retval_desc lsm_retvalues[]  = {
+#include <linux/lsm_hook_defs.h>
+};
+#undef LSM_HOOK
+#undef LSM_RET_INT
+#undef LSM_RET_VOID
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
@@ -399,3 +423,33 @@ const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
+
+static struct lsm_retval_desc *find_retval_desc(const char *func_name)
+{
+	unsigned long addr;
+	struct lsm_retval_desc *desc;
+
+	addr = kallsyms_lookup_name(func_name);
+	for (unsigned int i = 0U; i < ARRAY_SIZE(lsm_retvalues); i++) {
+		desc = &lsm_retvalues[i];
+		if (addr == desc->func_addr)
+			return desc;
+	}
+
+	return NULL;
+}
+
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			      struct bpf_retval_range *retval_range)
+{
+	struct lsm_retval_desc *desc;
+
+	desc = find_retval_desc(prog->aux->attach_func_name);
+	if (desc == NULL)
+		return -ENODEV;
+
+	retval_range->minval = desc->minval;
+	retval_range->maxval = desc->maxval;
+
+	return 0;
+}
-- 
2.30.2

