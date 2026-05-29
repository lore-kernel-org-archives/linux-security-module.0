Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BF369D77;
	Fri, 29 May 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057552; cv=none; b=s7p8GL/+T/S66+Mt2KDVPtiTyFxNxe0kf0sEPfwg6nWF7q7t5tmzz5k5gn5rD4M7gLzHVjN7a4KIjY2Wtb2Itqhq5KaKB7vBK5a+wWFUikUDdnrv8p94ylT/ue0ZoP4xSoSid0mquxChUU2aUXfV1Oj3ddHegO+7nEKTjBoieaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057552; c=relaxed/simple;
	bh=N6sVf38+FHJduniGZ0W3fwFzekBcrJr4FsogusoV7Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUpZYHBTPg41pSEeElINbp4Xct/shIBbMRQK/KFo5OGVSuT2emrY+ciPILUj9vDAYeEcZZJy6l2IBY3zy/EHWGJldJVYDUKZo+OmwH55qY+e6U99+Dn9DVHsGC4EzwWHEb251ea3SnU67o51bRiMHDQDupiPzxVCON1e5X1GNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=P68p2Ixu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="P68p2Ixu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cDRm8FJe+A1DHHSWj+EE8qVw4sy3yXZrJY0jrv55lAU=; b=P68p2Ixuvnc2jQSglPNMrAzAuS
	grWG4jqN2n0JB6uVtk5qaOYu+jleFw+/Tt1aZlRG6SvDNIEQ8Gk78OoasUXJxRKVGTbf+T1CJJlVP
	dc7Vd9D1cNEeYmPrmwTPEeFqgz7h6NcLfWYvcOYQ4r5qlGGq3uFvadu/+ZjAg+9ZvcZtn+YjmFcQX
	6H5dpuFZGYLKRIxAZOSm3cuv50eXoanlH1Z9KNKOy+la5/a1LhrvRMZ91lurCo3bRfX5QTDUvJytt
	N+cxYdjXAG8Kwbl7qN8f5UjchJ53bsnxC6oZI7WWcSoQSQnZkyXreGEdzr5dxoeDv0ZTf+9dho6zu
	KRMvweFw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSwHa-000FmU-1z;
	Fri, 29 May 2026 14:25:46 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSwHZ-0008gK-0Z;
	Fri, 29 May 2026 14:25:45 +0200
Message-ID: <544dbc0d-24d2-423f-9db4-07976d67a9d0@iogearbox.net>
Date: Fri, 29 May 2026 14:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata
 maps in the signed loader
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20260522215337.662271-1-kpsingh@kernel.org>
 <20260522215337.662271-3-kpsingh@kernel.org>
 <CAADnVQLJsvCfRxyLT-NJRubwSPTNd0k5bEp45Zyu9q1B_3oG+A@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAADnVQLJsvCfRxyLT-NJRubwSPTNd0k5bEp45Zyu9q1B_3oG+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

On 5/23/26 5:12 PM, Alexei Starovoitov wrote:
> On Fri, May 22, 2026 at 11:53 PM KP Singh <kpsingh@kernel.org> wrote:
>>
>> The loader verifies map->sha against the metadata hash in its
>> instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is called
>> on the frozen map.
>>
>> While the map is frozen, the loader must also ensure the map is
>> exclusive, as, without exclusivity, another BPF program with map access
>> can mutate the contents afterwards, so the check passes on stale data.
> 
> Hold on. How is this an issue? excl_prog_sha guarantees
> that only loader prog can use this map.
> Are you saying the same loader prog will use the same map
> for the 2nd time. Ok. I still don't see a problem.
> 
>> Place excl_prog_sha right after sha[] in struct bpf_map and have
>> gen_loader bail with -EINVAL when it is NULL, via BPF_PSEUDO_MAP_IDX at
>> fixed offset 32. The 8-byte read of the pointer field limits this to
>> 64-bit kernels; gen_loader needs target pointer size tracking to emit
>> the right sized read on 32-bit (follow-up).
> 
> I don't think we can go from maybe-racy to certainly-broken-on-32-bit.
> So only applied patch 1.

I've looked a bit more into it with regards to above question from Alexei
as well as the __bpf_md_ptr issue.

Imho, KP is correct that the extra check/enforcement is needed. So Alice
as a trusted signer generates the loader program (loader_insns + data_blob)
and signs it. The loader program contains the below enforcement to reject
if the metadata map was not exclusive.

Now the (untrusted) host that wants to load the program, it holds a signed
loader where they can't change a byte of it without breaking the signature.

However, it could simply omit excl_prog_hash on BPF_MAP_CREATE for the data
map (which would "normally" be bound exclusively to the loader).

Then check_map_prog_compatibility() enforcement is skipped on verifier side
given excl_prog_sha is not set. The loader loads fine, the fingerprint check
can then pass against a stale snapshot while a different program mangled the
data_blob underneath.

Regarding __bpf_md_ptr, I would solve it differently via fixed size, see below
together with the excl check coming before the signature check in the loader
and the build bug assertions, and a jmp not eq to 1.

  include/linux/bpf.h        |  1 +
  kernel/bpf/syscall.c       |  5 +++++
  tools/lib/bpf/gen_loader.c | 17 +++++++++++++++++
  3 files changed, 23 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd191c5fdb0a..487f4653d8a6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -295,6 +295,7 @@ struct bpf_map_owner {
  
  struct bpf_map {
  	u8 sha[SHA256_DIGEST_SIZE];
+	u32 excl;
  	const struct bpf_map_ops *ops;
  	struct bpf_map *inner_map_meta;
  #ifdef CONFIG_SECURITY
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 630d530782fe..37dacdbc5c01 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1572,6 +1572,11 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
  			err = -EFAULT;
  			goto free_map;
  		}
+
+		/* See libbpf: emit_signature_match() */
+		BUILD_BUG_ON(offsetof(struct bpf_map, excl) != SHA256_DIGEST_SIZE);
+		BUILD_BUG_ON(offsetof(struct bpf_map, sha)  != 0);
+		map->excl = 1;
  	} else if (attr->excl_prog_hash_size) {
  		err = -EINVAL;
  		goto free_map;
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index bcea21c3b7bb..cd8d7df94ac7 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -586,6 +586,23 @@ static void emit_signature_match(struct bpf_gen *gen)
  	__s64 off;
  	int i;
  
+	/*
+	 * Reject if the metadata map is not exclusive. Without exclusivity
+	 * the cached map->sha[] verified above can be stale: another BPF
+	 * program with map access could have mutated the contents between
+	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
+	 */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
+					 0, 0, 0, 0));
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, SHA256_DIGEST_LENGTH));
+	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
+	if (is_simm16(off)) {
+		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
+		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, off));
+	} else {
+		gen->error = -ERANGE;
+	}
+
  	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
  		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
  						 0, 0, 0, 0));
-- 
2.43.0
