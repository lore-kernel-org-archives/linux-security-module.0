Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CC1DE8BB;
	Wed,  2 Sep 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310169; cv=none; b=nzB54mBb9SSkh5oseD0UwK0WXZ077/EiNFGILyuZkYViLCGt3PLaUiFcT8hFJHfnErqt8T5ncLLjL03X0789vnGlrADDfkmrorEsyMc42qfaV0abkBAOXuKY3f5raIK8UHYcu7Bw/eXBD/MfdmgoSeMxsA+1+TveKaCzPmdJW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310169; c=relaxed/simple;
	bh=pXG0V5jXBLIVF9fdYnPv8sfD7dZDrtssN9xflLdKFBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvstI4Q//wvQ8Bwg2+EriHYtQgZtvn03AVObEdaD5ZMkFv5zI+KX8+QHIAPlME4dPiVGqn2mm3U4K2ymAmsrH/rZE38zUlX5nAn7SK+bfrmTBmeNpy96ewlqS4aXIMRQklwD1tYJbfDt326OZzahpKLDWJfbS+lzKIPIBHw9TnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V11WDYvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V11WDYvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD551F000E9;
	Wed,  2 Sep 2026 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788310167;
	bh=7nLgCQSaCFKCb63UhFK8QBEL2bgjau/HoDT7IXt2qnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V11WDYvd0mgQawzLkGXiCrh1Gbka0P+U0c2qkRCJRZslacaQG0DNwxHoLn1Qju7WQ
	 0MzAu+NpoT3thjyrsWNg7u67A+WKgEddbnwOdrfAjgEOH0419r4CNRQcbBRrzGmQjq
	 2ZSPSSFNKK7hv+832HVp6OXpkPLSWGVYfAFoPB81EuBd0s34N/nYrZoF7Day9GON8M
	 SF/NDbPlTIf7CDL+JwCsiqzMroZbYj65xzREDqptE3Jl+F/8JZlbHGCao5rfK+cQtY
	 S+GA9fnfWhjB5gZeaxQHD6S5GHKq3kZ5Fkkhu5HJekLEQIS8Epb9ebG2t2a4nZYcm/
	 9SWVQPrbIhNUA==
Date: Tue, 1 Sep 2026 17:49:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski
 <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, Christian
 Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <20260901174926.12cc95f1@kernel.org>
In-Reply-To: <apbFG4WKaZNsURo8@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
	<20260831153456.5a7d6937@kernel.org>
	<apbFG4WKaZNsURo8@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 12:29:15 +0000 Anton Protopopov wrote:
> On 26/08/31 03:34PM, Jakub Kicinski wrote:
> > On Mon, 31 Aug 2026 11:09:25 +0000 Anton Protopopov wrote:  
> > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > operators to mitigate known bugs without a need to reboot or livepatch
> > > machines.  BPF has shown very useful to create such runtime policies.
> > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > hooks and this would be beneficial to extend the coverage.  
> > 
> > Dunno. Do you have any reason to believe that any of the CVEs your LLM
> > gathered for you here are actually getting exploited? Spot checking 
> > a few they seem to be mostly driver bugs. What security model do you
> > have in mind? Untrusted/malicious users with physical NIC access?  
> 
> For the untrusted part, here are some existing examples:
> 
>   * old untrusted bugs: CVE-2022-50651, CVE-2025-40255
>   * "namespace CAP_NET_ADMIN" bugs: CVE-2024-43836, CVE-2025-21921

These span 4 years.

> Also, the recent copy-fail is a stronger example (though not generic
> netlink-related).

Yes, if anything it proves that serious security issues are usually
on the datapath for networking, not what you're covering.

> The general idea is that we gate the common de-multiplexors such that
> not only known bugs, but mainly those which will appear in future are
> covered. Rough numbers for coverage: around 5% of known cves are
> covered with existing LSM hooks. Another ~5-7% can be covered if we
> add netlink-related hooks [this series + net/sched, nftables,
> rtnetlink, others smaller]. So, statistically, we know where
> bugs had appeared in the past, so we can "predict" where new
> will appear. Some of them might be severe, so this would be
> good to have hooks in place to be able to "mitigate" them.

Easy to PoC stuff with LLMs these days. I'd like to hear from
an end user who would find these hooks useful, in more detail.
Anyone with an ounce of gray matter will run untrusted workloads
_at least_ in a VM today.

> Just in case, to test this patch locally, I've found around 10 new
> ethtool-related bug candidates. I've sent a fix to one, d09c98a6da21
> ("virtio_net: Fix resize of the RX ring"), which was easy to
> reproduce in a VM. Others require specific hardware, though popular,
> so I can try to reproduce some, and was planning to do this later.
> Of those findings one is unprivileged, it triggers a OOB read.

Please send the fixes along. The hash you mention requires
CAP_NET_ADMIN on a real interface, not a serious security
issue.
