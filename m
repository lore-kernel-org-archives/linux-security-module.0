Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43C377014;
	Mon, 20 Apr 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690067; cv=none; b=p6P4Ra1TMeM8WkiLLrJ0RoiwOo2PmMdXNweb9y9SCLtwXLCS5P3O3x12c6r3Jb6heJvJlw1P2pddf5YVcA4CPUqA6ioHOQXqmtWJyPvCG8X9DLawWlHBL2LynddlWkMcHkWV58nh1U3X8SkKjknnmGXgtiYtsQjcDfzJTBMaGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690067; c=relaxed/simple;
	bh=iK+dwfs6TTfXk/h7PczKlm40SXBtrA2IbQBGzgNFSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB1U1OjOb2br5gq9MfpvOm/1e2PWnt9PJG0iHpiOyAGVrWbaAx5rB+l+FUl1B2XRqRSe0XEtWCAlVR6EyXG00V4cjydes3CFLScKcg7ky9xR4cPXLNwdDMmoZBQVTjb3Ngx/bquR8ArcU9TfyW3bdjjOMxSaIrPMITWtvs3JFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BCiadVmk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BCiadVmk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300271516;
	Mon, 20 Apr 2026 06:00:58 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C43543F7B4;
	Mon, 20 Apr 2026 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776690063; bh=iK+dwfs6TTfXk/h7PczKlm40SXBtrA2IbQBGzgNFSkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCiadVmkk/gq0W3CAiKpGOYi+LOoZbmvy1ddW8avimGJSFtvgSTnIVhbjkJffqUox
	 /lwl7p5Mf5Qn+xAXQAzy6glLefm9pQZVFs5BWPVEois8neHP8utP6ztcI7UFKUXOcr
	 ACneYNTOtEdZKvniPmdSbMHdVAwUr82NOwtr2gXc=
Date: Mon, 20 Apr 2026 14:00:57 +0100
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
Message-ID: <aeYjiaPtAl7SMVkL@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYbdmshGZJ4GhXd@google.com>


Hi Sebastian,
> On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:
>
> Hello Yeoreum,
>
>
> > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > Otherwise, pKVM cannot negotiate the FF-A version or
> > obtain RX/TX buffer information, leading to failures in FF-A calls.
>
> At the moment this already happens after you move back ffa_init() to
> device_initcall().

How? the kvm_arm_init() is device_initcall() if both built as built-in.

>
> >
> > During FF-A driver initialization, check whether pKVM has been initialized.
> > If not, defer probing of the FF-A driver.
> >
>
> I don't think you need to add this dependency. pKVM is
> installed through KVM's module_init() which ends up calling hyp_ffa_init() to
> do the proxy initialization. The ARM-FFA driver comes after it (since
> pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
> be able to handle smc(FF-A) calls in the hyp-proxy.
>

As Marc said, the before finalised_pkvm(), smc wouldn't be trapped
to pKVM. IOW, in case when both built as built-in,
if ffa_init() is called before finalised_pkvm(),
it couldn't proxy the FFA_VERSION, FFA_RXTX_MAP and FFA_PARTITION_INFO_GET
called by ffa_init().

How can you gurantee hyp_ffa_init() which is called by kvm_arm_init()
comes first even kvm_arm_init() and ffa_init() are on device_initcall?

[...]

Thanks


--
Sincerely,
Yeoreum Yun
