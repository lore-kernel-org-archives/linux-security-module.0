Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56659390209;
	Fri, 22 May 2026 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487560; cv=none; b=uAr15uVS9aw8kGBhYfXPz0RnDcC6lr0Fs9G6uMftsMQ5IfMR6jC/ZRgsTgQxav+EaOWqwSJWdTG57+DLq0fnzUI6oypaMbz2eAwMvNnqeUNVuLNTYqGu7DfTm+h6VjgVzbsJhNbGLKqNJxhPfFh/0zKnQNVs0KnWpB6Jx2T5vZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487560; c=relaxed/simple;
	bh=p9qtFXqLbBpQ5osYG2JdDirml2JFjFzGB11J5OyrXcs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U/Pdz27Dsc795gzuPgA1ijgz4VAdz0OJrACTOYw534bFtaBhoFuJ01rXcuibd2/zY+1m3aALmoSAv0yZXzpVRKDPZFz7jfjRKV+xdO38AvHhOTgh9UNqEQ0fYQshjbvRpn4/gljral4BVHkIU6lBIvT/aerxgVEscvE21WI9XXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LMY4oSUs; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LMY4oSUs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ljbE8v8CKYRLbaCh7V8cBduGZpcILjAvzPvAwto3ErQ=; b=LMY4oSUslMwaqIiOcK0Dvg2Oit
	2oyBgqNd8YTt4cF9UZGdkwm6sPN5KFjymY1lH2tishlEiRAenHC0AP5IqrHnygccqerKRxBfVHSgF
	LChRtDBsbKM8iT/2c9E6l9fy/UGnC5ORyrabuxLl3sY9CeXKoF1FSNfCAd/Bnp9jv9cZTqQROr581
	18o00lqvyslxwbVW3tQyXV/Y9fRvKDl7ohakp/OS+krGnamkt9YE2xfBNkkZ4ENp+/kh3bWbLUrnS
	/VTL/dSb2viYqXDa4sSz+jBOuC2AOAlVPPRcbvWbrN6Bx05dwqVZljK+b38KDskzpk25QCNqgK9k9
	brZ3qP+w==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wQY0D-000Oz0-0M;
	Sat, 23 May 2026 00:05:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wQY0B-000EKI-2u;
	Sat, 23 May 2026 00:05:56 +0200
Message-ID: <8f74fdf6-4ada-4d30-83bd-9170ff8a4f34@iogearbox.net>
Date: Sat, 23 May 2026 00:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in
 the signed loader
From: Daniel Borkmann <daniel@iogearbox.net>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: ast@kernel.org, memxor@gmail.com
References: <20260521152217.2345235-1-kpsingh@kernel.org>
 <20260521152217.2345235-3-kpsingh@kernel.org>
 <dcc02e2d-58dd-46eb-9b72-54cd8465fb64@iogearbox.net>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <dcc02e2d-58dd-46eb-9b72-54cd8465fb64@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28008/Fri May 22 08:24:46 2026)

On 5/22/26 11:44 PM, Daniel Borkmann wrote:
> On 5/21/26 5:22 PM, KP Singh wrote:
>> The loader verifies map->sha against the metadata hash in its
>> instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is called
>> on the frozen map.
>>
>> While the map is frozen, the loader must also ensure the map is
>> exclusive, as, without exclusivity, another BPF program with map access
>> can mutate the contents afterwards, so the check passes on stale data.
>>
>> Place excl_prog_sha right after sha[] in struct bpf_map and have
>> gen_loader bail with -EINVAL when it is NULL, via BPF_PSEUDO_MAP_IDX at
>> fixed offset 32. Declare excl_prog_sha with __bpf_md_ptr so the
>> 8-byte BPF_LDX_MEM read works on 32-bit kernels.
>>
>> Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>> ---
>>   include/linux/bpf.h                              |  2 +-
>>   tools/lib/bpf/gen_loader.c                       | 16 ++++++++++++++++
>>   .../selftests/bpf/progs/verifier_map_ptr.c       | 10 ++++++----
>>   3 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cd191c5fdb0a..ea9bd24f82c0 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -295,6 +295,7 @@ struct bpf_map_owner {
>>   struct bpf_map {
>>       u8 sha[SHA256_DIGEST_SIZE];
>> +    __bpf_md_ptr(char *, excl_prog_sha);
>>       const struct bpf_map_ops *ops;
>>       struct bpf_map *inner_map_meta;
>>   #ifdef CONFIG_SECURITY
>> @@ -335,7 +336,6 @@ struct bpf_map {
>>       atomic64_t sleepable_refcnt;
>>       s64 __percpu *elem_count;
>>       u64 cookie; /* write-once */
>> -    char *excl_prog_sha;
>>   };
>>   static inline const char *btf_field_type_name(enum btf_field_type type)
>> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
>> index 9478b8f78f26..fee35c26deb8 100644
>> --- a/tools/lib/bpf/gen_loader.c
>> +++ b/tools/lib/bpf/gen_loader.c
>> @@ -600,6 +600,22 @@ static void emit_signature_match(struct bpf_gen *gen)
>>               gen->error = -ERANGE;
>>           }
>>       }
>> +
>> +    /* Reject if the metadata map is not exclusive. Without exclusivity
>> +     * the cached map->sha[] verified above can be stale: another BPF
>> +     * program with map access could have mutated the contents between
>> +     * BPF_OBJ_GET_INFO_BY_FD and loader execution.
>> +     */

(One other small nit: it probably makes sense to first check the exclusivity
before we compare the map->sha[], so this could be reordered inside the
emit_signature_match.)

> We could probably add sth like this somewhere in the bpf kernel side :
> 
>          /* See: emit_signature_match() in tools/lib/bpf/gen_loader.c */
>          BUILD_BUG_ON(offsetof(struct bpf_map, sha) != 0);
>          BUILD_BUG_ON(offsetof(struct bpf_map, excl_prog_sha) != SHA256_DIGEST_SIZE);
>          BUILD_BUG_ON(sizeof_field(struct bpf_map, excl_prog_sha) != sizeof(__u64));
> 
>> +    emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
>> +                     0, 0, 0, 0));
>> +    emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE * sizeof(__u64)));
> 
> nit: SHA256_DWORD_SIZE is SHA256_DIGEST_LENGTH / sizeof(__u64), can we just use
>       SHA256_DIGEST_LENGTH ?
> 
>> +    off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
>> +    if (is_simm16(off)) {
>> +        emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
>> +        emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
>> +    } else {
>> +        gen->error = -ERANGE;
>> +    }
>>   }
>>   void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
> 

