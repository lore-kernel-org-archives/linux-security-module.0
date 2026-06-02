Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2893C2799;
	Tue,  2 Jun 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405140; cv=none; b=iZ8Bi/AuQCEBuxVTOHbjS0Sp5iFmWRJLhr5LBahWByYEPevwkmwT+50JBp6ZcqnTURWpayYak1s0uWk25h7DNLeTF7IcGF+gOoGcREoY8dbbWaU7GncE43/rn5eyPtFre/it/6Ni0nIAKn9r7Qj09m7EhDgM00biGA0ElZOoWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405140; c=relaxed/simple;
	bh=Y0GQNFYOedy21MCKtWpt6MqIuBGco1GIXaca2/Mu3ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJKPify1myJ/v+CKuUDf6IJhI5lKuhmmHXtZS6RPiXgNckzncunGQXVlSlQJNHJJxnPS7dmUkdHrgmrYWLo0ogYCr5IWezEVoVFD/flsFbU358t4ED9W7u772Yqf6GYaXhVxnX8E4IfHY+HGn958ta0UX/mmXVKjHRv5M6yu7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iZROQl4o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iZROQl4o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F70E169C;
	Tue,  2 Jun 2026 05:58:53 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C4B63F632;
	Tue,  2 Jun 2026 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780405138; bh=Y0GQNFYOedy21MCKtWpt6MqIuBGco1GIXaca2/Mu3ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZROQl4oHi6gzkkEuq55AQvvdOHbqENrH+Qw3bvvQzXLUMV+7VsxLvhYDVhVYbZWE
	 0gPKw3iS0CzIco0por6kzUw3AEJLV6f+lIZl5PpzIysMRqx703HhdLr23FFFuEqSVr
	 u/wTUHk2R7ZyZ0e1TXQ+dNk+USY8mwdSJf93VgS4=
Date: Tue, 2 Jun 2026 13:58:53 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org,
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 2/4] security: ima: introduce IMA_INIT_LATE_SYNC option
Message-ID: <ah7Tjcm4CBEoDzIu@e129823.arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-3-yeoreum.yun@arm.com>
 <1cb6e74f1d63bd256d70e5c026234d4535acb662.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb6e74f1d63bd256d70e5c026234d4535acb662.camel@linux.ibm.com>

On Tue, Jun 02, 2026 at 08:35:52AM -0400, Mimi Zohar wrote:
> On Mon, 2026-06-01 at 15:27 +0100, Yeoreum Yun wrote:
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
> > device probed deferred.
> > 
> > When this option is enabled, modules that access files in the
> > initramfs through usermode helper calls such as request_module()
> > during initcall must not be built-in. Otherwise, IMA may miss
> > measuring those files [1].
> > 
> > Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
> > Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

Thanks!

-- 
Sincerely,
Yeoreum Yun
