Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD1B410D32;
	Wed, 27 May 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893059; cv=none; b=UOLUnSxanim+Do/uCHiieKMij+faIxWSV0dGKYYEOS/JaeioVWTpHhQR02QfGBcJuP0SQh/iLA3Q8E84tl2wjUyHfJDBHFE7QL0Z3efeKoJ6zAkRB+ay5K1FtekJE5mPtjsmzWc1WqtMmNjDXFmbwHHLW5Do/CHo8aLDvHt3a1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893059; c=relaxed/simple;
	bh=ANflYJ9pJdsWVS0W8lRHDLlWe0UmLSP1cit/EuPE1A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhW4EyEkKb1GVgENhrbM79EDYO2TBHatHCPbAaNnPyN6VXW/UBsTtkuF4OpI04c9661A1OjI7GdLlGbW8uETqt4adR1qCIKdLBbH34YA3m4dOt+33e+wHlyzdtPv9pkPjbqP8FqNRPHdB53ytL88ND9ceBNQwB8K+YPtuUZ28MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H2IlUOI1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H2IlUOI1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 999192E96;
	Wed, 27 May 2026 07:44:11 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A833F905;
	Wed, 27 May 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779893056; bh=ANflYJ9pJdsWVS0W8lRHDLlWe0UmLSP1cit/EuPE1A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2IlUOI1Hu0HSpL2m47BJ/BKA188zABpBa0IlM0SgmfuJn1Hg3uGi7F842JPtnatB
	 BKDuTMA3Z/OISjqD11aqnUkankz29zRD+BzEXTGQrElCcr2skrdJKAOcQR9P6WkDVE
	 1qstspGHwpkLEpSPhB4kqxxj37JMou4zgLoQa2CE=
Date: Wed, 27 May 2026 15:44:12 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org,
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 2/3] security: ima: introduce IMA_INIT_LATE_SYNC option
Message-ID: <ahcDPDJbILZM028u@e129823.arm.com>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-3-yeoreum.yun@arm.com>
 <e017ff8eb8bee4540e8877a594774508e8a79311.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e017ff8eb8bee4540e8877a594774508e8a79311.camel@linux.ibm.com>

Hi Mimi,

> On Mon, 2026-05-25 at 08:54 +0100, Yeoreum Yun wrote:
> > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > the TPM driver must be built as built-in and
> > must be probed before the IMA subsystem is initialized.
> > 
> > However, when the TPM device operates over the FF-A protocol using
> > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > the tpm_crb_ffa device — an FF-A device that provides the communication
> > interface to the tpm_crb driver — has not yet been probed.
> > 
> > To ensure the TPM device operating over the FF-A protocol with
> > the CRB interface is probed before IMA initialization,
> > the following conditions must be met:
> > 
> > 1. The corresponding ffa_device must be registered,
> >    which is done via ffa_init().
> > 
> > 2. The tpm_crb_driver must successfully probe this device via
> >    tpm_crb_ffa_init().
> > 
> > 3. The tpm_crb driver using CRB over FF-A can then
> >    be probed successfully. (See crb_acpi_add() and
> >    tpm_crb_ffa_init() for reference.)
> > 
> > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > all registered with device_initcall, which means crb_acpi_driver_init() may
> > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > 
> > When this occurs, probing the TPM device is deferred.
> > However, the deferred probe can happen after the IMA subsystem
> > has already been initialized, since IMA initialization is performed
> > during late_initcall, and deferred_probe_initcall() is performed
> > at the same level.
> > 
> > And the similar situation is reported on TPM devices attached on SPI
> > bus[0].
> > 
> > To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
> > IMA at late_inicall_sync so that IMA is initialized with the TPM
> > device probed deffered.
> 
> -> deferred

Thanks. I'll fix this typo.

> 
> > 
> > When this option is enabled, modules that access files in the
> > initramfs through usermode helper calls such as request_module()
> > during initcall must not be built-in. Otherwise, IMA may miss
> > measuring those files since they're the file accesses before the
> 
> Reword or remove phrase starting with "since".

Okay. I'll remove this phrase starting with "since".

> 
> > initialisation of IMA [1].
> > 
> > Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
> > Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> This version of the patch drops differentiating the boot_aggregate record based
> on initcall as was posted in "[RFC PATCH v3 1/4] lsm: Allow LSMs to register for
> late_initcall_sync init".  Being able to differentiate the initcalls is need by
> the remote attestation services.

Thanks ;) I overlooked for the remote attestation.
Then For the IMA_INIT_LATE_SYNC option, As the former patch did,
Let IMA use the name "boot_aggregate_late" for boot_aggregate record.

-- 
Sincerely,
Yeoreum Yun
