Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3545149C7B;
	Mon,  5 Oct 2026 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239895; cv=none; b=Z2rDujvShTq4kZw5UgoBHs1HNCv1+a74SPyTiqbuL/P9jXkx8ib1SZ1jjD+yPTgH8q8s2EXzfSnELjH8pF6ZdZ5KAm5S9uPMmRxyZ2R70Cq1/daBItCUHBOnpE8nZmN0NAWCO96ROjWWXGuvK5LNAltzZgcET7iP3TxHlZPQAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239895; c=relaxed/simple;
	bh=cRuqM+Yx+knEqJioaBb/kNfF8kMrQs5lwacPr8cB/Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYwbbbRGvb7BQBhdpN7fDG0ROaUSMZHh7TdiRYecK0/Ln+PjfebzXxAhNQfzrDEfVkZ+bpWzGzYfBV+Ujip7hABVPbTIA7YuW654EGbSqRDzi713PlJ3yySdVD7V0QOUqpoty4qm+TYVu+HHEJTSj2EnEOzfJKsKcQNtPxLZ8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU4e5V4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU4e5V4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477731F000FF;
	Mon,  5 Oct 2026 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239893;
	bh=YGDkf4hQ1/gmB/Wf7Jky2o0N9gskIXx/bGD2aMZF1DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XU4e5V4w8zKbYGx+Bb8fERd442qJrBO4g77JjQ/5byONx48IUq36NawSewjsOIjS/
	 BnNqLYzWfUjBsXtnCDF1Vey7ptFpp5a4RGZSZFnDWEEIixBpTq3lQnzD8yBcBGTArB
	 Xktuo5ij+tQfd8ArvIVTL6QCiJ3QOvk2JbamcI8Z5xlM0jDZTdJ08+/ovRRwhtYXv5
	 LUdes1nBU1hKM941o75goMv/RnmCEe/hyKqSZAvxDxLdeFRKVILauPDFpTtO4QjJBp
	 OfZjfeWe7nHppgwkeot4DfYb+ZT5Y0qFJKrI7LqFtvtaeRmPECT06yYfboT+nbTXP6
	 cd8Zgv2z98mnw==
Date: Mon, 5 Oct 2026 15:38:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej =?UTF-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] cipso: adjust cached option offsets when removing
 CIPSO
Message-ID: <20261005153812.27a84bac@kernel.org>
In-Reply-To: <20260930140400.2955466-1-4ncienth@gmail.com>
References: <20260930140400.2955466-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 23:04:00 +0900 Daehyeon Ko wrote:
> cipso_v4_skbuff_delattr() shifts every IPv4 option after CIPSO left by
> cipso_len, but leaves the cached srr, rr, ts and router_alert offsets at
> their old locations.
> 
> With a valid eight-byte CIPSO option followed by a seven-byte RR option,
> RR moves from offset 28 to 20 while opt->rr remains 28.  The stale offset
> then points into packet payload, letting the sender control both the
> length and bytes copied by __ip_options_echo().  Setting the length to
> 255 produced this condensed KASAN result:
> 
>   BUG: KASAN: stack-out-of-bounds in __ip_options_echo
>   Write of size 255
>   Call Trace:
>    __ip_options_echo
>    run_cipso_stale_offset [net_candidate_probe]
> 
> The destination holds 40 bytes of option data.  In an existing
> uninstrumented x86-64 v7.2 build, __icmp_send() places that buffer
> immediately before its stack canary, and the 255-byte copy also crosses
> the saved return address.  A canary mismatch unconditionally panics;
> no canary disclosure or control-flow exploit was demonstrated.
> 
> Mirror cipso_v4_delopt() and subtract cipso_len from each cached offset
> that follows CIPSO.  cipso_len is the logical distance moved by the first
> memmove(); hdr_len_delta includes padding, while the later header move and
> network-header reset relocate the bytes and their base together.
> 
> The adjusted input leaves rr at 20 with length 7 and completes without a
> sanitizer report.  Natural remote reachability requires a configured
> SELinux/NetLabel gateway and a later option consumer; the retained test
> invokes the real mutation and echo consumer directly because the available
> rootfs has no SELinux policy or netlabelctl.

AI points out that the example given can't happen in practice:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930140400.2955466-1-4ncienth@gmail.com

Please adjust the commit msg and the code per Ondrej's suggestion.
-- 
pw-bot: cr
