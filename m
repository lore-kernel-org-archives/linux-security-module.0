Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831B3F9FB;
	Thu,  2 Jul 2026 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027026; cv=none; b=U0Sv9bfMiL96cNOu9tw1OF+XgeL/H7UK4zFm3tkEKhuyqgWnny57uYH4PJ/l9+dMdRyneCT5bd//SlipUoDved0cSpgQnkKrxrjVvS+7BeMYPTL4gcXWDGqmUjTJUgEAv1C1EN/kv2p2Yjh3PQKcwTMABqEeK1ZiWYg1rom5DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027026; c=relaxed/simple;
	bh=XawzBJW+QEVhyimcAwWarKIl3iK4n81nuEVvzQSJwOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RY8NNPN3GIKkbD3PtSSGhXw9PGj0dQGFRoh9C0n6bIgd/Ba2McV+qHJ2y7TareZw0X8oDozR+d/gZp6Sc8OPiJvcl0W5zozbeuymSLV5THDcaAuhFnrP3xpWucQZYaWU2EmT9HKZImq5UyeR36bGFHBpc3CCA6i9HS6QY0OaGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BjPorjnm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BjPorjnm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7MrVyOUQ+A2JIaTA8EefePQMTeG/s1iSrjXUbdvwrEA=; b=BjPorjnmXBN07GBx1zL3xPvgJ0
	8CPMK+iAJPXLnE2qUxMKQx0YFwLLeRNjpgvISMcuOS3jlOJ7DEnotykpxL3xk4/b5/B6eTXNeWL/x
	ILo8wuNuDKB/cqEpYIZyNR1N4XgXBCH+Gl8TcRv26YRqAndfxu4fqVj6F8zmq1bwgdIIWL4FSAFX2
	jg9SAYQSzN63qIEtSY9aZzzKTcqLDlf3mfCXyPPrB+baGNe2KbGvgVTdFQD4qtvP+rFqaPeOv9LLo
	MUrgwS3Rcwfv6egY4Qmkal7j8GM8NePHyQ+KdeA1O1QJqNin1Ppd6+wRccmKmoqbkmK8fXtew8a7F
	wmvQeTfQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wfOmL-0003cR-0F;
	Thu, 02 Jul 2026 23:17:01 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wfOmK-000PAZ-14;
	Thu, 02 Jul 2026 23:17:00 +0200
Message-ID: <a430a735-4657-475f-a7e7-64036a540644@iogearbox.net>
Date: Thu, 2 Jul 2026 23:16:59 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Resolve and cache fd_array objects
 at load time
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: ast@kernel.org, kpsingh@kernel.org,
 James.Bottomley@hansenpartnership.com, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, memxor@gmail.com,
 torvalds@linux-foundation.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260702143605.252797-1-daniel@iogearbox.net>
 <20260702143605.252797-2-daniel@iogearbox.net>
 <aka2yR6IUZMAOUwJ@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aka2yR6IUZMAOUwJ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28048/Thu Jul  2 08:25:04 2026)

On 7/2/26 9:06 PM, Anton Protopopov wrote:
> On 26/07/02 04:36PM, Daniel Borkmann wrote:
>> The fd_array passed to BPF_PROG_LOAD carries the map and module BTF file
>> descriptors a program binds. The verifier reads it more than once during
>> a load: process_fd_array() walks it to bind the maps and BTFs, and
>> check_and_resolve_insns() and the kfunc BTF resolver later read it again
>> to resolve the program's BPF_PSEUDO_MAP_IDX and module kfunc refs.
>>
>> For signed BPF, we need these upfront in memory, thus resolve each fd to
>> its object once and cache it by fd_array index, then bind that cached
>> object for the rest of the load. env->fd_array becomes a small per-slot
>> {map, btf} cache rather than a bpfptr_t; every later reference is then
>> an in-bounds lookup of an already-resolved object, and an index outside
>> the cache is rejected instead of read from user memory:
>>
>>    - continuous (fd_array_cnt given): the caller declares the length and
>>      every entry is resolved and bound up front (used also by signed loader)
>>
>>    - sparse (no fd_array_cnt): left as the legacy path with no fd_array
>>      cache; each reference reads its fd from the caller's fd_array and
>>      resolves it on the spot. Deduplication in used_maps and the kfunc BTF
>>      table keeps this correct, and only unsigned programs use this shape.
>>
>> UAPI-wise nothing changes, its just the internals on how BPF processes
>> and caches the fd_array favors. Split these into separate helpers for
>> continuous versus sparse to make it easier to follow.
> 
> Overall looks ok. A few comments below.
> 
[...]
>> -	/* Check for integer overflow */
>> -	if (attr->fd_array_cnt >= (U32_MAX / size)) {
>> -		verbose(env, "fd_array_cnt is too big (%u)\n", attr->fd_array_cnt);
>> -		return -EINVAL;
>> +	if (cnt > MAX_FD_ARRAY_CNT) {
> 
> So, I _think_ I've done the "unlimited" thing because there can be duplicates
> in fd_array. The limit is actually tracked by __add_{map_btf} So here we hard
> limit on the size of the fd_array itself. (Even without duplicates, this
> fd_array can contain, say, MAX_KFUNC_BTFS different maps, which will be in any
> case rejected by __add_used_map.)
> 
>> +		verbose(env, "fd_array has too many entries (%u, max %u)\n",
>> +			cnt, MAX_FD_ARRAY_CNT);
>> +		return -E2BIG;
>>   	}
>>   
[...]
>>   
>> +static int process_fd_array(struct bpf_verifier_env *env,
>> +			    union bpf_attr *attr, bpfptr_t uattr)
>> +{
>> +	bpfptr_t fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
>> +
>> +	if (bpfptr_is_null(fd_array))
>> +		return 0;
>> +	/*
>> +	 * New API: the caller passes fd_array_cnt and a continuous array that
>> +	 * is resolved and bound up front. Legacy API (no fd_array_cnt): keep
>> +	 * the caller's array and resolve entries lazily, on first reference.
>> +	 */
>> +	if (attr->fd_array_cnt)
>> +		return process_fd_array_continuous(env, fd_array,
>> +						   attr->fd_array_cnt);
> 
> Looks like this returns success in case (!fd_array && attr->fd_array_cnt),
> which is a misconfiguration and should be rejected.
Thanks for the review, addressing both in v4!
