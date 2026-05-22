Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1F311969;
	Fri, 22 May 2026 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417165; cv=none; b=RAHRcxS8y1BJoBtTGw/VF1NVlKCsR9/r7IWUez+AUf6ePybywBy45cuGfQJOAf4FDEQcHoIkBBMDR+aQtHCUnGvrT0x+TawiMNm7QHHwFl8Bf3iK7GA/lMgJEyswwUcqMlX7kJ6cvp59zwhhAr1LwZ78IqId1/zFUuh7KZrpnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417165; c=relaxed/simple;
	bh=ox3NwoY8hYsenj5Vw6ksn7w4vO0OZ/gwqo2mrfqtpFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qR/OOyb+kRrFfFI0VNYVhWy75psVyBxBNuIvf0LxeuZvc51oN1hGm2wN6bUtU8dlADwMkZGFrSEvnU95FO1iQ0sbvyx3QW0chn7ZrewjJ8zvBNlRGimrz5O+YR5V7SrrOFBFWA9l08bGxee2CQn7soVXIFCcnbE70VBDuQuMwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8zEuwJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8zEuwJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356021F00A3D;
	Fri, 22 May 2026 02:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417163;
	bh=PFHR39TgzypNAcr42X6/YPw7VXLaKpTiRBiY1gZpkRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8zEuwJC0CRT5DxgG6dwYoHOyX/8xW8yfNJDeessbw0zl7dni7rjiuzzpqMKOx3CV
	 k936Bg1p6gQB//EVkDszbriYHCpChTGuPiIC6/gePDVTiyv0mL1BkZM6r4bkgvcrpz
	 2wVM0mHB+xrTlW0PH2WM1ZevdrKxpDGy4fYCQ8B4x4XO0Zx7p5WwpSP6wHNra66RlP
	 Bc1jF1rXR7W0G6MXkd5QikN7IXq1QXgJcju8pVke7AeyISNWoJjOaYw3xCu+xIIyfC
	 raBd1qemLpUvNkbCQohUJHqrzzgOM7GJv6Itl/mA/8V9bPAaOdp8mOOuAQcF7q7lUv
	 aRb09v9s6pjaA==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 03/13] bpf, libbpf: load prog BTF in the skel_internal loader
Date: Fri, 22 May 2026 04:32:23 +0200
Message-ID: <20260522023234.3778588-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_load_and_run loads only the loader insns and the metadata map.
To match the kernel's extended signature scope (insns || btf), the
loader needs to BPF_BTF_LOAD the prog BTF before BPF_PROG_LOAD so
attr->prog_btf_fd can be filled in.

Add btf and btf_sz to bpf_load_and_run_opts; when set, do the
BPF_BTF_LOAD before BPF_PROG_LOAD and pass the resulting fd as
attr->prog_btf_fd.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/skel_internal.h | 44 ++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 6a8f5c7a02eb..0b6b1ecedd45 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -11,6 +11,8 @@
 #include <linux/bpf.h>
 #else
 #include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <linux/keyctl.h>
@@ -66,8 +68,10 @@ struct bpf_load_and_run_opts {
 	struct bpf_loader_ctx *ctx;
 	const void *data;
 	const void *insns;
+	const void *btf;
 	__u32 data_sz;
 	__u32 insns_sz;
+	__u32 btf_sz;
 	const char *errstr;
 	void *signature;
 	__u32 signature_sz;
@@ -88,6 +92,22 @@ static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 #endif
 }
 
+#ifndef __KERNEL__
+static inline int skel_sys_btf_load(union bpf_attr *attr, unsigned int size)
+{
+	int fd;
+
+	fd = skel_sys_bpf(BPF_BTF_LOAD, attr, size);
+	if (fd >= 0 && fd < 3) {
+		int new_fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
+
+		close(fd);
+		fd = new_fd;
+	}
+	return fd;
+}
+#endif
+
 #ifdef __KERNEL__
 static inline int close(int fd)
 {
@@ -353,8 +373,9 @@ static inline int skel_map_freeze(int fd)
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
 	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, keyring_id);
+	const size_t btf_load_attr_sz = offsetofend(union bpf_attr, btf_token_fd);
 	const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
-	int map_fd = -1, prog_fd = -1, key = 0, err;
+	int map_fd = -1, prog_fd = -1, btf_fd = -1, key = 0, err;
 	union bpf_attr attr;
 
 	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1,
@@ -387,11 +408,30 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	}
 #endif
 
+#ifndef __KERNEL__
+	if (opts->btf && opts->btf_sz) {
+		memset(&attr, 0, btf_load_attr_sz);
+		attr.btf = (long) opts->btf;
+		attr.btf_size = opts->btf_sz;
+		attr.btf_log_level = opts->ctx->log_level;
+		attr.btf_log_size = opts->ctx->log_size;
+		attr.btf_log_buf = opts->ctx->log_buf;
+		err = btf_fd = skel_sys_btf_load(&attr, btf_load_attr_sz);
+		if (btf_fd < 0) {
+			opts->errstr = "failed to load loader BTF";
+			set_err;
+			goto out;
+		}
+	}
+#endif
+
 	memset(&attr, 0, prog_load_attr_sz);
 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
 	attr.insns = (long) opts->insns;
 	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
 	attr.license = (long) "Dual BSD/GPL";
+	if (btf_fd >= 0)
+		attr.prog_btf_fd = btf_fd;
 #ifndef __KERNEL__
 	attr.signature = (long) opts->signature;
 	attr.signature_size = opts->signature_sz;
@@ -437,6 +477,8 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 		close(map_fd);
 	if (prog_fd >= 0)
 		close(prog_fd);
+	if (btf_fd >= 0)
+		close(btf_fd);
 	return err;
 }
 
-- 
2.53.0

