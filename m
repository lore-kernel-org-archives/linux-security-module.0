Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED9368978;
	Sat, 28 Feb 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240261; cv=none; b=M6ERIOcbAkXDAw63kdrboLsgLCVkWB2TI+yjlXvcHvW1f1wTyvW8KQCuc84dH1FVpqhYEVhUrn3waxp0Ns1/Lb3k62tInVaKrBQQ968GiJRlREmDWGbyVWC5QP7mRqV4vPggP3NMdv14qllv2w5XzySzb1QHaG/NsrVk8qGSXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240261; c=relaxed/simple;
	bh=THrk0S1hUifkCD5Acw2ePMoclJ4QRq7m4suO6JFURgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RIpEZkoelalLc9WYp/rQMMLdzKkPn1JR9xUjlzn72x+avnSJpJjCYBMXgbcoS9W2VghyRQPUMqtHCkIs4h20A/vRWswLwAm+37a5+1mNVGtcsF2YhUjdmqI3sUMcIxw77Bc3ijy9cn4SEVhfxh7DGyWE6iySecE0SPL7Ln9kCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hoq+0YE/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hoq+0YE/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=9qDDL8pSQ7Li0UdiwzA94dKuksU5huQcWTQy5Af+yjw=; b=Hoq+0YE/aWhYQe0nJSb4LxSNR6
	rHGSWDZJ+4dcH5WoyxxffTnc+v1y/x1eJnAGPQaDe+76DnubVZe8EMK6uiccMadST84d9rvF2TVu7
	4wVaEAtvYatY6i4okkMsinC9W1BjAteubAYLCwmJejDdi5n0slUEydvohWqV/65+ozx+YIfiYHn9x
	fbBYcVks8d7kjlU+d8ukuMrrE0ECA4PGfBo0WaLjD5D3hCxvXK6OdYXd3CkBM9CI+3VMZZEc873zm
	pCu4PFaXAdoUW4LEXiu3hMCm+EB3YI3NPjuyhvaUG7d5E+krDZEFZ24HFhEjWr4Nu285dZmvAPhfm
	MU6kM/ig==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8e6-00000009MWc-0BxN;
	Sat, 28 Feb 2026 00:57:26 +0000
Message-ID: <9b9d841c-1b56-4202-ba04-0a176ab15218@infradead.org>
Date: Fri, 27 Feb 2026 16:57:23 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] lsm: framework for BPF integrity verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 James.Bottomley@HansenPartnership.com, dhowells@redhat.com,
 Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
 <20260227233930.2418522-7-bboscaccy@linux.microsoft.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260227233930.2418522-7-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Blaise--

On 2/27/26 3:38 PM, Blaise Boscaccy wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> Add a new LSM hook and two new LSM hook callbacks to support LSMs that
> perform integrity verification, e.g. digital signature verification,
> of BPF programs.
> 
> While the BPF subsystem does implement a signature verification scheme,
> it does not satisfy a number of existing requirements, adding support
> for BPF program integrity verification to the LSM framework allows
> administrators to select additional integrity verification mechanisms
> to meet these needs while also providing a mechanism for future
> expansion.  Additional on why this is necessary can be found at the
> lore archive link below:
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com/
> 
> The LSM-based BPF integrity verification mechanism works within the
> existing security_bpf_prog_load() hook called by the BPF subsystem.
> It adds an additional dedicated integrity callback and a new LSM
> hook/callback to be called from within LSMs implementing integrity
> verification.
> 
> The first new callback, bpf_prog_load_integrity(), located within the
> security_bpf_prog_load() hook, is necessary to ensure that the integrity
> verification callbacks are executed before any of the existing LSMs
> are executed via the bpf_prog_load() callback.  Reusing the existing
> bpf_prog_load() callback for integrity verification could result in LSMs
> not having access to the integrity verification results when asked to
> authorize the BPF program load in the bpf_prog_load() callback.
> 
> The new LSM hook, security_bpf_prog_load_post_integrity(), is intended
> to be called from within LSMs performing BPF program integrity
> verification.  It is used to report the verdict of the integrity
> verification to other LSMs enforcing access control policy on BPF
> program loads.  LSMs enforcing such access controls should register a
> bpf_prog_load_post_integrity() callback to receive integrity verdicts.
> 
> More information on these new callbacks and hook can be found in the
> code comments in this patch.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++
>  include/linux/security.h      | 25 ++++++++++++
>  security/security.c           | 75 +++++++++++++++++++++++++++++++++--
>  3 files changed, 102 insertions(+), 3 deletions(-)

For patches that you did not author, but are transporting instead,
Documentation/process/submitting-patches.rst indicates that you should
add your Signed-off-by: line to them:

"""
Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author.
"""

-- 
~Randy

