Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD7F2EB5A6;
	Tue, 21 Apr 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754671; cv=none; b=HA38Hiun3ihCU1eg4KaW0xusxkKwxCDDEzXGC53JoNmYn/5zdwyQIcSXSxeoAjQ+w6yDxsWyZd4GI3zqPxFQkVbbfkMuocRn86YaO0I8HmfVdp9BwRCyJJ3NLh9YgwO3bsjRgiRjv52HseI7Hil0/UnKKVMtXBCIVoTnF9nPOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754671; c=relaxed/simple;
	bh=QSlJWj/ZlGmtGszuI1E4a2OjETy6Q0GCQCorMuB2AXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCFgL3l30stOvnPudkIFipnRccfi44ymZvPIP1tIPLypKT68jFEU61KBt5kwKr82EGqaCilIvyQTYpkMwm5QZhhwftKGvThaYx+D5lHmkrnDZKIpSuVzDCtG3UtWCgMhzXJK/HADiMOXSF+doNo2OVLwGJgQkw8V35a1T1zbpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pt1psxwr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pt1psxwr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EAA02573;
	Mon, 20 Apr 2026 23:57:43 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E2C3F915;
	Mon, 20 Apr 2026 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776754669; bh=QSlJWj/ZlGmtGszuI1E4a2OjETy6Q0GCQCorMuB2AXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pt1psxwrIkpsDuFunhfbZr6dKT6D8qOQqYLotTMpPy0Bq9X70/1jgHJ8dYVsS2jHp
	 zgJCeSn1zyMK6cIzVPpRKiODcxHa5pZV850tmFXeADvmwDhubwnQo58d9Y8P47F8Vy
	 tyYxXc6QoreOaQt+3CkwM2btIckSac4AVcSR3hBI=
Date: Tue, 21 Apr 2026 07:57:43 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aecf57rWloQwDh6v@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl3vb5bm.wl-maz@kernel.org>

Hi Marc,

> On Sat, 18 Apr 2026 11:34:30 +0100,
> Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > > > @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
> > > >  	u32 buf_sz;
> > > >  	size_t rxtx_bufsz = SZ_4K;
> > > >
> > > > +	/*
> > > > +	 * When pKVM is enabled, the FF-A driver must be initialized
> > > > +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> > > > +	 * the FF-A version or obtain RX/TX buffer information,
> > > > +	 * which leads to failures in FF-A calls.
> > > > +	 */
> > > > +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> > > > +	    !is_kvm_arm_initialised())
> > > > +		return -EPROBE_DEFER;
> > > > +
> > >
> > > That's still fundamentally wrong: pkvm is not ready until
> > > finalize_pkvm() has finished, and that's not indicated by
> > > is_kvm_arm_initialised().
> >
> > Thanks. I miss the TSC bit set in here.
>
> That's the least of the problems. None of the infrastructure is in
> place at this stage...
>
> > IMHO, I'd like to make an new state check function --
> > is_pkvm_arm_initialised() so that ff-a driver to know whether
> > pkvm is initialised.
>
> Doesn't sound great, TBH.
>
> > or any other suggestion?
>
> Instead of adding more esoteric predicates, I'd rather you build on an
> existing infrastructure. You have a dependency on KVM, use something
> that is designed to enforce dependencies. Device links spring to mind
> as something designed for that.
>
> Can you look into enabling this for KVM? If that's possible, then it
> should be easy enough to delay the actual KVM registration after pKVM
> is finalised.

Hmm, I also considered moving kvm_init() into finalised_pkvm() and
then handling the remaining ffa_init() work after /dev/kvm is registered.

However, this approach seems awkward in practice,
because misc has neither a bus nor a dedicated class notifier that we can hook into.

Also, the FF-A initialization is not driven by a device probe, but rather
happens as part of the bus registration itself,
so it does not fit well with a device_link or probe deferral based approach.

Instead, perhaps we could go with the idea I mentioned previously:
either introduce a notifier, or create a pseudo ffa_device
once pKVM initialization has completed, and
then let the ffa driver perform the additional initialization from there.

Am I missing something?

--
Sincerely,
Yeoreum Yun
