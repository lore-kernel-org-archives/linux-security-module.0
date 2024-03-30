Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E03A1D3
	for <linux-security-module@vger.kernel.org>; Sat, 30 Mar 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711829697; cv=none; b=gNJYO22uhU3yQS1goucVYMnyDTE7Zsvd0C4+dUev/t3gFqIFoFEF/ymvkJuDfaVF1sGxW0pGBs33HfWww1+7fNFGo6pyU1qwuqTM6Y6+ILoskr6IKnpebQwh5kedwKKfnt93OUSHcbVzh21lg3v+Q7LoGVBhcWyRcVrcRZTsjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711829697; c=relaxed/simple;
	bh=U+YnV8Y3KTaeUj0Az4reQS6PqtozG4Cc38hO+SYxiRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkIzIXombv2qQPWU+8EuBpg7bNSikYily8F6DcIdjXBkQuIuCPCzxVLsE7evAiqt49hRCWGrHwAFg+wRptcEtd1opQ35MgEOUcJTCY7XvxTQsRP69PD6CzNemGCkKOIrH61uFIN1S4b/dSrrx4yOn5wxsGHzL57us24baE/jsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42UKEQUe005483;
	Sat, 30 Mar 2024 15:14:26 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42UKEPlA005482;
	Sat, 30 Mar 2024 15:14:25 -0500
Date: Sat, 30 Mar 2024 15:14:25 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        roberto.sassu@huaweicloud.com
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
Message-ID: <20240330201425.GA5453@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com> <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com> <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com> <20240328153800.GA17524@wind.enjellic.com> <86c7477e-260f-419a-8aea-ea527a344877@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c7477e-260f-419a-8aea-ea527a344877@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 30 Mar 2024 15:14:27 -0500 (CDT)

On Thu, Mar 28, 2024 at 09:34:39AM -0700, Casey Schaufler wrote:

Good afternoon, I hope the weekend is going well for everyone.

> On 3/28/2024 8:38 AM, Dr. Greg wrote:
> > ...
> >> In Linux v6.8[1] only Smack and SELinux provide implementations for
> >> the security_inode_init_security() hook, and both also increment the
> >> associated lsm_blob_sizes::lbs_xattr_count field.  While the
> >> behavior of the hook may have changed, I see no indications of any
> >> harm with respect to the standard upstream Linux kernel.  We
> >> obviously want to ensure that we work to fix harmful behavior, but I
> >> simply don't see that here; convince me there is a problem, send me
> >> a patch as we've discussed, and I'll merge it.
> > BPF provides an implementation and would be affected.

> BPF has chosen to implement its LSM hooks their own way. As it is
> impossible for the infrastructure developers to predict what the
> behavior of those hooks may be, it is unreasonable to constrain them
> based on hypothetical or rumored use cases.

We were asked to identify a case where upstream could be possibly
broken by the change in behavior, we did that.

It is now perfectly clear that the LSM maintainers don't consider the
possibility of breaking upstream BPF to be an issue of concern, no
doubt an important clarification for everyone moving forward.

> The implementation of BPF precludes its use of LSM blobs that are
> infrastructure managed. That ought to be obvious. BPF could include
> a non-zero lbs_xattr_count just in case, and your problem would be
> solved, but at a cost.

FWIW, it would not seem unreasonable to assume that an LSM, BPF
included, may want to be notified of the the instantiation of the
security state of an inode, regardless of whether or not the LSM is
using extended attributes.

> > Bear poking trimmed ...
> >
> > [1] In Linux v6.9-rc1 this grows to include EVM, but EVM also provides
> > both a hook implementation and a lbs_xattr_count bump.
> > BPF initialization, as of 6.8 does not include an xattr request.

> Just so. If BPF wants to use the aforementioned interface, it needs to
> include an xattr request. Just like any other LSM.

Requirement so noted.

Have a good week.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
		  https://github.com/Quixote-Project
