Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1F2882BE;
	Mon, 20 Apr 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696452; cv=none; b=TaIK2BN/u1Qh/tWfcTk+Fnx4+OnUwKeNtW82bUN/I3jorzMMGEkTwLiwclSgTwFyOSR3QCCKwQGDDeR22thS4e3SS46YcLlrdnoEobMIPLuN6J8e0UsjxTvQlwvIpMTN7JYjc93rCCF6lw2pcYpoS4DXxbL1JC2JEUrJZr4f9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696452; c=relaxed/simple;
	bh=O7ibaDjJseGlqangzveB9VynH2pKp+LSowkGObgjgio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSt76plIbIbJ3/uMLq3uSotlA747sO1l6ruu/pJiXLG8EtU0UnldrqsXPq379rpbUqyXPmAZaHKYPAt4vMxzzFCeKrDejwk3p365lPRj7qjaf4ARbtG5MAuj3vCCMstFsmqOb0VmGyr69WJ8w3juGtkMX4PV13GwmPfk4qJovnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L+B9r/qO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L+B9r/qO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11CF1516;
	Mon, 20 Apr 2026 07:47:24 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1833F3F7B4;
	Mon, 20 Apr 2026 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776696450; bh=O7ibaDjJseGlqangzveB9VynH2pKp+LSowkGObgjgio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+B9r/qOOHsKRGrLzuIhK2+5vpLf3w4qwXoOl9kCQvqnkOWQ5+Zow32TpfNVrDtPG
	 860JlQ9vReiyPUZlJYDMzVQWo2F/FpENb8Gp7LCFkEeSAK4iMW59tInMBLR8WNvil6
	 Yj7yn1g03HiLuPc/jYd1hNYsr0IXxSoqwG7QNhpI=
Date: Mon, 20 Apr 2026 15:47:24 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeY8fNhtuVzL2X9a@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
 <aeYjiaPtAl7SMVkL@e129823.arm.com>
 <aeYypF4lv6LMH2ch@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYypF4lv6LMH2ch@google.com>

Hi Sebastian,

> On Mon, Apr 20, 2026 at 02:00:57PM +0100, Yeoreum Yun wrote:
>
> Hi,
>
> >
> > Hi Sebastian,
> > > On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:
> > >
> > > Hello Yeoreum,
> > >
> > >
> > > > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > > > Otherwise, pKVM cannot negotiate the FF-A version or
> > > > obtain RX/TX buffer information, leading to failures in FF-A calls.
> > >
> > > At the moment this already happens after you move back ffa_init() to
> > > device_initcall().
> >
> > How? the kvm_arm_init() is device_initcall() if both built as built-in.
> >
> > >
> > > >
> > > > During FF-A driver initialization, check whether pKVM has been initialized.
> > > > If not, defer probing of the FF-A driver.
> > > >
> > >
> > > I don't think you need to add this dependency. pKVM is
> > > installed through KVM's module_init() which ends up calling hyp_ffa_init() to
> > > do the proxy initialization. The ARM-FFA driver comes after it (since
> > > pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
> > > be able to handle smc(FF-A) calls in the hyp-proxy.
> > >
> >
> > As Marc said, the before finalised_pkvm(), smc wouldn't be trapped
> > to pKVM. IOW, in case when both built as built-in,
>
> They are, I tested before replying to this thread. The HCR_EL2 is
> 0x480080000 so HCR_EL2 TSC bit is set so SMC/FF-A and trapping is enabled.

Oh. I've missed cpu_init_hyp_mode() sets up HCR_EL2. So you're right.
Thanks to correct me ;)

>
> In __pkvm_prot_finalize it sets the HCR_VM bit which enables stage-2 and
> then write the HCR_EL2 from params->hcr_el2. However I wasn't sure that
> this is seen as a 'hack' and not expected to work.
>
> > if ffa_init() is called before finalised_pkvm(),
> > it couldn't proxy the FFA_VERSION, FFA_RXTX_MAP and FFA_PARTITION_INFO_GET
> > called by ffa_init().
> >
> > How can you gurantee hyp_ffa_init() which is called by kvm_arm_init()
> > comes first even kvm_arm_init() and ffa_init() are on device_initcall?
> >
>
> While they are both on device_initcall, the only difference is that
> kvm_arm_init is arch code which appears before the driver/ code in the
> linker. That's why Marc said it is not a solid construct to rely on
> this.

Then I think the origin one -- just check kvm_arm_initialised
is enough to check in ffa_driver. since I misunderstood TSC bit
is setup after finalised_pkvm().

or Am I missing something?

Thanks.

--
Sincerely,
Yeoreum Yun
