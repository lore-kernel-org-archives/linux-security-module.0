Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD7397321;
	Mon,  6 Jul 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360038; cv=none; b=sIRbtOZVnWWY1M3MXNdCavZfv3kfX4BpNddpfMny0AeOHgILRElcuJcUtWfHt2D+R3nYwpjIJjBxUhYV8S9ZeADLyEzX/3wqO3Bil0O4KSGM+Gy2p8bWw/UnyXBBm9wq4Sg11M2jsF12P3eudgHBczvdTMcGWB3PVLbUxdbGO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360038; c=relaxed/simple;
	bh=e7q9zMmpoYHRtcGdArMY71TL2qGl/mkwbBL4wXX4FUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADY7HCy6lVcE8m44GIr6Y8kEfz+f4bTJuGGp6IHPraleU5S+k//9/qeMFkBGSpLNutBJNXPDOk9Xef/Ub7eJDUokwu/T5tFNdsSigjnqfkSa4ocQpsSMzB8om4hnaCTPWLyOjcHsxvGRpXDmTPv7kTkF0rbZRP39Ww+ILF1zt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hbE0viOv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hbE0viOv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=G/OJpbEHyGfCeMDRZaO2FVZhTSPXLsGw4iJAbMLbWto=; b=hbE0viOvY2ilGYuDzK/uAU6YdO
	ugJ94YP0n2zSAquR9Fex7MbjoATbCmcnGnnt+lwNRhhms7PUeKMHSnzZ9wCfrd2AxztQrN5E8miGd
	PnRxGd1tfNcR1WSxcddBo2eHG5nE123XV7Kurbi8v6uRIVLcKwTfpi30B7ZonMcUlmj+1z86p/2pz
	evoN22Nk5YNxor7qmvXBjbdd2xvxcqtIrUbLYwrlE9i7STKSLtT0JdQZM7PuLrkBoczVp+hY1VgZQ
	CULLE5X2HMjXBAL3GnawUDvqpm72zVoLfTu3bK9wWWJUB40O6M5WpZ9PHZIyZhHHJ5xD9FIOnF9Za
	Qjh8UyMw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgnPU-000HvW-2i;
	Mon, 06 Jul 2026 19:47:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgnPU-000CDW-0F;
	Mon, 06 Jul 2026 19:47:12 +0200
Message-ID: <35678f78-2068-4c2a-a1aa-19abf007067a@iogearbox.net>
Date: Mon, 6 Jul 2026 19:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/9] Verify BPF signed loader at load time
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, kpsingh@kernel.org,
 James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com,
 memxor@gmail.com, torvalds@linux-foundation.org, a.s.protopopov@gmail.com,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260706135644.326006-1-daniel@iogearbox.net>
 <CAHC9VhQbqxJFBX+3-JiHR7+QqgWsiAAak7J4-q3QykdGqB7g+g@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAHC9VhQbqxJFBX+3-JiHR7+QqgWsiAAak7J4-q3QykdGqB7g+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)

Hi Paul,

On 7/6/26 7:13 PM, Paul Moore wrote:
> On Mon, Jul 6, 2026 at 9:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> The BPF signing scheme signs a light skeleton's loader program and lets
>> the loader vouch for everything else: bpftool bakes the SHA256 of the
>> metadata map into the loader's instructions, signs the instructions, and
>> the loader compares the (frozen, exclusive) map against that hash from
>> within BPF once it runs. The construction is sound as a trusted hash
>> chain, but the kernel itself never attests the metadata, and that split
>> has been the recurring objection from the LSM / integrity side since the
>> scheme was proposed.
>>
>> This proposal closes both gaps by having the kernel verify the metadata
>> at BPF_PROG_LOAD time, before the LSM admission hook and before the
>> verifier, /without/ growing the UAPI. A signed loader binds its metadata
>> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
>> are already bound to the loader's digest via excl_prog_hash. When a
>> signature is present, the kernel collects the exclusive maps from the
>> fd_array and appends their frozen contents to the instructions before
>> PKCS#7 verification, so the signature covers ...
>>
>>      insns || metadata_0 || metadata_1 || [...]
>>
>> ... in fd_array order. The in-loader hash check is dropped from the
>> gen_loader entirely: generated loaders carry no verification logic
>> anymore, and signing or verifying a skeleton becomes an ordinary CMS
>> operation over bytes that sit verbatim in the skeleton, reproducible
>> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED
>> with nothing in between.
>>
>> There is no new UAPI, we now have a single signature scheme, no LSM
>> code reaching into BPF internals, no new LSM hook, and unsigned loads
>> are completely unaffected. It is also less complex since the loader
>> does not need to deal with BTF, an extra kfunc, etc, as proposed in
>> an earlier series [0]. Tested against full BPF CI which came back
>> green. For more details and examples, see the documentation patch in
>> this series.
>>
>>    [0] https://lore.kernel.org/bpf/20260522023234.3778588-1-kpsingh@kernel.org/
>>
>> v3 -> v4:
>>    - Fix upper limit in MAX_FD_ARRAY_CNT (Anton)
>>    - Reject !fd_array && attr->fd_array_cnt (Anton)
>>    - Add bpftool patch wrt ignored return value of EVP_Digest() (sashiko)
>>    - Fix setting of gen_loader_fixture_init (sashiko)
>>    - Fix unused map_fd cleanup branch in selftest (bot+bpf-ci)
>>    - Remove now unused map->excl member and adjust selftests
>>    - Added more BPF signed_loader corner case selftest coverage
>>    - Added Paul's Nack wrt bpf_prog_load LSM hook dispute
>>    - Added patch 2 to move bigger allocations below fd_array
>>      resolution (Paul)
> 
> If you want to squash patch 2/9 and 3/9 together so that one can't
> easily merge 3/9 without the vzalloc(program) relocation I'll gladly
> drop my NACK on patch 3/9.

Okay, I can do that and send a v5. Btw, I saw one sashiko complaint
about the security_bpf_prog_load() internally not needing the:

   [...]
         if (unlikely(rc))
                 security_bpf_prog_free(prog);
   [...]

since the security_bpf_prog_free() is already called via the regular
teardown path now. While there are no in-tree LSM users that are
affected by this, I'll include this as well into the squashed patch,
so its really only called once and not twice.

>> v2 -> v3:
>>    - Added first commit to cache and work on objects in fd_array
>>      which was the most recent issue sashiko rightfully complained
>>    - Added more BPF signed_loader selftest coverage to cover that
>>      usage of sparse fd_array or map fds gets rejected
>>    - I left the security_bpf_prog_load as in v2 given preference
>>      from BPF side over adding new hook
>> v1 -> v2:
>>    - Addressed both sashiko complaints, the TOCTOU bug regarding
>>      fd_array processing, as well as exclusive map checking to
>>      only allow array maps. The validation is now moved into the
>>      verifier before the main verification work happens. This also
>>      gives the opportunity to utilize the verifier log.
>>
>> Daniel Borkmann (9):
>>    bpf: Resolve and cache fd_array objects at load time
>>    bpf: Move bigger allocations below fd_array resolution
>>    bpf: Verify signed loader metadata at load time
>>    libbpf: Drop in-loader metadata check for load-time verification
>>    bpftool: Check EVP_Digest when computing excl_prog_hash
>>    bpftool: Cover loader metadata with the program signature
>>    selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
>>    selftests/bpf: Verify load-time signed loader metadata
>>    Documentation/bpf: Add BPF signing and enforcement doc
>>
>>   Documentation/bpf/index.rst                   |    1 +
>>   Documentation/bpf/signing.rst                 |  496 ++++++++
>>   include/linux/bpf.h                           |    1 -
>>   include/linux/bpf_verifier.h                  |   23 +-
>>   kernel/bpf/syscall.c                          |   83 +-
>>   kernel/bpf/verifier.c                         |  450 ++++++--
>>   tools/bpf/bpftool/gen.c                       |    2 +
>>   tools/bpf/bpftool/sign.c                      |   24 +-
>>   tools/lib/bpf/bpf_gen_internal.h              |    1 -
>>   tools/lib/bpf/gen_loader.c                    |   76 +-
>>   tools/lib/bpf/libbpf_internal.h               |    1 -
>>   tools/lib/bpf/skel_internal.h                 |   31 +-
>>   .../selftests/bpf/prog_tests/signed_loader.c  | 1004 ++++++++++++++---
>>   .../selftests/bpf/progs/test_signed_loader.c  |    9 +-
>>   .../selftests/bpf/progs/verifier_map_ptr.c    |   23 +-
>>   15 files changed, 1786 insertions(+), 439 deletions(-)
>>   create mode 100644 Documentation/bpf/signing.rst

Thanks,
Daniel

