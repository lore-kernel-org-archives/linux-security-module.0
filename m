Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C63A4F51;
	Fri, 12 Jun 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256799; cv=none; b=uVZMTefIxN+HCoPuqM3OTTPNontzVY6HnsvEt3HzCxp0SbCzz3xR5PD4i5pGeS6ODpTd4VSiFTvo4a831TZavVgCiO8nZ1V6/Ys9wrOdrmHjwm8oxhfnAqjwfrWgz5StPltpsvCV8OFsl1+OB9A8OSvKl/aDQKG1tzKfqGt91eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256799; c=relaxed/simple;
	bh=TuXbsbpYjq0WkqJVqRC8k3PCCAtx+ZxL9trYkMnBcf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWuvkOT2+MLYKdJnwCW5R54Q7WDz0qgqQ34XGq1ycgoTnMte5vTJsFsrrX+gLlEodk9ONUWeCYElR2/pPteYbtvo2jYF4Dza0nawxcRTy3XufrHM46LppmOw5L/+35k+lqhG5HyeIxwVYdFnllSH9DxQWAAIX/9uYwvDGOjAB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VnZrPh1a; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VnZrPh1a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dUAqsEQ84VVSEuE6I1PSNNLeR8Cb/bpdsjGdzktMwl8=; b=VnZrPh1aOOFTWpPwOFTyTlWnH5
	vd87opP1xPmfnksE+V8x/EyfIJVuTTwxm1YWpeoz0DHLxVCjhFr7OxClnzutRlzmUXHo/7tej01cV
	MK02L+xSZHQ9fyR4F/Uyu5GZBIZx2AIOAop7HkR8tM8Owvipz9PecrXyIUXSS3VLP9RaIeBJkDX2r
	L8Syza2bZliJxP9kZMtRrQA6KHtxF6HIzMZ9X+Gjc9up0h/W6a/odaMTGjPI2uhoDV14RSqyx5iaD
	sDwbQq58Q3wabu2v/7fE+S3ORTP3Xx5im/ByKdjZY3l8tCTC9fDEwtkOH8CrfwwfKt7UTJa4axgJV
	YIJzLrAQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXyGC-000L7q-1W;
	Fri, 12 Jun 2026 11:33:08 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXyGB-0004O1-0C;
	Fri, 12 Jun 2026 11:33:07 +0200
Message-ID: <78107b57-5f4e-42b8-b780-5aebf7362de2@iogearbox.net>
Date: Fri, 12 Jun 2026 11:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] Verify BPF signed loader at load time
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, kpsingh@kernel.org,
 James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com,
 memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260610230329.727075-1-daniel@iogearbox.net>
 <CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=B2smEw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=B2smEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28029/Fri Jun 12 08:28:05 2026)

On 6/12/26 12:56 AM, Paul Moore wrote:
> On Wed, Jun 10, 2026 at 7:03 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
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
> 
> I'll be honest and say I'm a bit surprised to see this patchset,
> especially since KP and Alexei argued so strongly against this
> signature scheme, preferring KP's scheme where the loader verified the
> maps.  I'd be curious to hear the reason for the change of heart if
> you can share it.  Regardless of the motivation for this change, I
> obviously think this is a significant improvement over KP's signature
> scheme which shipped in Linux v6.18.
> 
> I also think it is worth mentioning the similarities to work Blaise
> did before the most recent Hornet version:
> 
> https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-bboscaccy@linux.microsoft.com/
> 
> While Blaise's patchset added to the UAPI, that was done simply to
> retain compatibility with KP's signature scheme; your patchset does
> without any UAPI additions, but loses compatibility with existing
> signed lskels.  Beyond that, the basic signature scheme between
> Blaise's patchset and what you are proposing appears the same ...
> which is a good thing as far as I'm concerned.

For the rework, I've mainly been looking at KP's most recent series as
well as some of the past discussions. Mainly trying to see if we can get
away with a simpler model and without having to pull in BTF support for
the signed loader just for the extra kfunc. Over the last couple of weeks,
I've also build user space tooling on my side to experiment with some
real world application which the signed loader would have to deal with.

For sending a v2, I'll have to move this slightly deeper into verifier
side but before the main verifier work happens in order to solve the
exclusive map race issue, and additionally we could also utilize the
verifier log to tell the user that the signature validation failed.

I think a couple of things would still stand out imo: i) we sign over the
raw bytes, not the derived hash anymore, so the hashing is only used in the
context to tie the map to the loader prog, but not anymore for the signature.
ii) its one single scheme and not a parallel branch, so the main loader is
built upon the updated signing scheme rather than having this as an option
on the side; iow this replaces the in-loader check and there's a single PKCS#7-
over-bytes path, not an 'if (signature_maps_size)' fork; and iii) given we
expose the verification result in the BPF prog, we also don't need a new LSM
hook and can just piggy back on the existing security_bpf_prog() which also
has the possibility to still reject late at this point.

Anyway, I hope we can find a compromise here.. will keep you posted on v2
of the series.

Thanks,
Daniel
