Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F69325490;
	Mon,  6 Jul 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346216; cv=none; b=rFXZmYJ8lDlWdT0TsgKz6/eLmX8CXqcjrxPdmPE07NneKfGa2AKXBHMOt4eSh5M+7bEabnmWWalYaTXfF9Bc5qm5xREx9XDDcqjGC3333UbjVTrxeNhaMoHYmC7TTDzqicIXxOVWZidrxjvaR/cphv0fVntDR7yoQA0YZixXFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346216; c=relaxed/simple;
	bh=OXZ7PfvaASQ13DClYjHM9oT2gIHawZ7gl4TcpPuYQHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjyhB2retoWfSMGIsP9Uo/MxmBgt58Rdmz/8GSkbn5CukG5kTuyE6sYUgUwoVpB89FlNYPyeVWpz+x6PWWkrY7BLmz+Azt7SfmslJoC40q6O3hWhq87qgaRs9tV9IvPPsPWyKkOirFuSkSg1oNmU+mIyectZRBJyZrzWhlCRjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hXd6340B; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hXd6340B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rBFMlAX1kjayDDzRB+zJdi+2rZanVD7BJZZfmuoyt0Q=; b=hXd6340BnUNG7Fs9tAnEK9wlVf
	nTbTn0A8NzP8AMQwiYgh5q2nEYPSpj+j6pqHCMep4b1hcDDQhcWMHfSpixHzxxmr5k6hBCwobeXgW
	WEq/Hjt7OIUQECxsttinu/QxFzVmqFMgs7cBiym1eazcer6OTfa01VSAXmCSD9k28A9YEZnHWTPJf
	T8l9VUC+cILcXNvOgBp5/3jXCE5ds/9rFT/EQAn9ui3Q2m/qD5iAK0j7TIhc61PT6tAjrQaW8ZdRl
	RMJtDM3sbOfiTGKk9aUxasGio3lAboNX8sM5z1TZrZwlx/NJQFQE8r4IxkSLW1rjcvN0U2HydSwQ6
	qkeKw6wg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgjoZ-000E2r-2f;
	Mon, 06 Jul 2026 15:56:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v4 7/9] selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
Date: Mon,  6 Jul 2026 15:56:42 +0200
Message-ID: <20260706135644.326006-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706135644.326006-1-daniel@iogearbox.net>
References: <20260706135644.326006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)

With write-only excl member removed from struct bpf_map, ops moves
to offset 32 and inner_map_meta to offset 40. Update the expected
verifier message for the former and retarget the latter at the sha
byte array, so the beyond-member-end rejection path stays covered:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_map_ptr
  [...]
  #619/5   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected:OK
  #619/6   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected @unpriv:OK
  #619/7   verifier_map_ptr/bpf_map_ptr: read beyond sha field rejected:OK
  #619/8   verifier_map_ptr/bpf_map_ptr: read beyond sha field rejected @unpriv:OK
  #619/9   verifier_map_ptr/bpf_map_ptr: read ops field accepted:OK
  #619/10  verifier_map_ptr/bpf_map_ptr: read ops field accepted @unpriv:OK
  [...]
  #620     verifier_map_ptr_mixing:OK
  Summary: 2/20 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_map_ptr.c    | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index 166193659870..e0a65835c861 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -72,14 +72,15 @@ __naked void bpf_map_ptr_write_rejected(void)
 
 /*
  * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a readable
- * byte array), the u32 excl field at offset 32, and the ops pointer at offset
- * 40. Reading a u32 at offset 41 reaches into the middle of the ops pointer,
- * i.e. a partial pointer access, which is rejected.
+ * byte array), followed by the ops pointer at offset 32 and the inner_map_meta
+ * pointer at offset 40. Reading a u32 at offset 41 reaches into the middle of
+ * the inner_map_meta pointer, i.e. a partial pointer access, which is
+ * rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("cannot access ptr member ops with moff 40 in struct bpf_map with off 41 size 4")
+__msg("cannot access ptr member inner_map_meta with moff 40 in struct bpf_map with off 41 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
@@ -97,23 +98,23 @@ __naked void read_non_existent_field_rejected(void)
 }
 
 /*
- * The u32 excl field spans offsets 32..35 (mend 36). Reading a u32 at offset
- * 33 starts inside excl but extends past its end, which the verifier rejects
+ * The sha byte array spans offsets 0..31 (mend 32). Reading a u32 at offset
+ * 30 starts inside sha but extends past its end, which the verifier rejects
  * as an out-of-bounds scalar access.
  */
 SEC("socket")
-__description("bpf_map_ptr: read beyond excl field rejected")
+__description("bpf_map_ptr: read beyond sha field rejected")
 __failure
-__msg("access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4")
+__msg("access beyond the end of member sha (mend:32) in struct bpf_map with off 30 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
-__naked void read_beyond_excl_field_rejected(void)
+__naked void read_beyond_sha_field_rejected(void)
 {
 	asm volatile ("					\
 	r6 = 0;						\
 	r1 = %[map_array_48b] ll;			\
-	r6 = *(u32*)(r1 + 33);				\
+	r6 = *(u32*)(r1 + 30);				\
 	r0 = 1;						\
 	exit;						\
 "	:
@@ -131,7 +132,7 @@ __naked void ptr_read_ops_field_accepted(void)
 	asm volatile ("					\
 	r6 = 0;						\
 	r1 = %[map_array_48b] ll;			\
-	r6 = *(u64*)(r1 + 40);				\
+	r6 = *(u64*)(r1 + 32);				\
 	r0 = 1;						\
 	exit;						\
 "	:
-- 
2.43.0

