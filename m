Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9851B196;
	Thu,  1 Oct 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864709; cv=none; b=lr4ke04zoGCOYerKNvmtt/531liaxeUWVS90SdQqypbQ5Yd6bjkQv+3o+aY3R0/ukNKMyv0dNl7ZYkeqwVZR3aLtdG6qJNqZ5aLKbacC1MPKPK5C0GQi17eyLa8XuizUouxsmbH2hbXEdlnUYQk3LC8f3NIMBqVQyTBqPSx6RNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864709; c=relaxed/simple;
	bh=1hHoKyAPD/b2cGTc6dQTSAgCcK5RPRJLB0llMk6ht/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8RBkqidGwAjzWU8chyNkD36J+nU/PRECai0rPu9JTTQVPgWHZ6H8VX8FZODffmHgQkHeu3fYOZbUq+SVEpHmIItvD42EubsaOQFduVLVxXrAV7ZCkqgpplIZVixtSSq6QSisUMwhJuoeME3qfijs+Tjm+PHnawZ/gKlMSEJEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vXAk2mOi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vXAk2mOi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87EDD497;
	Thu,  1 Oct 2026 07:24:59 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6FAA3F85F;
	Thu,  1 Oct 2026 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790864702; bh=1hHoKyAPD/b2cGTc6dQTSAgCcK5RPRJLB0llMk6ht/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vXAk2mOiEzPgG8p0QPPgnsQD9c5SttjpCm6UTeqpSxuv3JpF0R9stnfs2sdooXT1+
	 +mCwykU1KCsMii36XRamLizkeQxtZpwHbBx36tBChLs0b2MUBc+3jhX+h4uZmD5BNU
	 l8S2Mq3+aGtDdpe0Qwus2ffDKEwIB9946i46aoYk=
Date: Thu, 1 Oct 2026 15:24:57 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, gongruiqi1@huawei.com
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
Message-ID: <ar5tOUor0bp3MtQ6@e129823.arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
 <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>

Hi Roberto,

> On Thu, 2026-10-01 at 13:27 +0200, Roberto Sassu wrote:
> > On Wed, 2026-09-30 at 14:43 +0100, Yeoreum Yun wrote:
> > > Confidential computing guests without a TPM can use TSM measurement
> > > registers to record IMA measurement digests instead of TPM PCRs.
> 
> + Gong Ruiqi, of course.
> 
> Roberto
> 
> > Hi Yeoreum
> > 
> > a similar patch set has been sent to the linux-integrity mailing list:
> > 
> > https://lore.kernel.org/linux-integrity/20250630125928.765285-1-gongruiqi1@huawei.com/
> > 
> > Could you please work with Gong Ruiqi to have a unified proposal?
> > 
> > Thanks
> > 
> > Roberto
> > 

Thanks for letting me know and I think the proposal is almost the same
with the different terminology only.

@Gong, what do you think?

> > > This series introduces in-kernel interfaces for accessing TSM
> > > measurement registers, abstracts IMA's measurement-register operations,
> > > and adds a TSM backend for Intel TDX and Arm CCA.
> > > 
> > > The following mappings between TPM PCR indices and TSM measurement
> > > registers are defined for Intel TDX [0] and proposed for Arm CCA [1]:
> > > 
> > >   TPM PCR index | Intel TDX register | Arm CCA register
> > >   --------------+--------------------+-----------------
> > >   0             | MRTD               | RIM
> > >   1, 7          | RTMR[0]            | REM[0]
> > >   2-6           | RTMR[1]            | REM[1]
> > >   8-15          | RTMR[2]            | REM[2]
> > > 
> > > These mappings allow IMA to translate PCR indices into the corresponding
> > > TSM measurement registers.
> > > 
> > > The TPM backend remains preferred when it is available at IMA
> > > initialization. Otherwise, IMA falls back to a supported TSM backend.
> > > Only one backend is selected; IMA measurements are not extended to both
> > > TPM PCRs and TSM measurement registers.
> > > 
> > > The attestation proccess for guest with TSM measurement register will
> > > be done with Confidential Compute Event Log (CCEL) which is exported by
> > > /sys/firmware/acpi/tables/data/CCEL. Here is brief process in arm64:
> > > 
> > >   Verifier                 Realm guest              RMM / Platform
> > >      |                         |                           |
> > >      |--- Challenge (nonce) -->|                           |
> > >      |                         |--- Request token -------->|
> > >      |                         |    with challenge         |
> > >      |                         |                           |
> > >      |                         |<-- CCA token T -----------|
> > >      |<-- CCA token T ---------|                           |
> > >      |<-- CCEL event log ------|                           |
> > >      |<-- IMA measurement log -|                           |
> > >      |                         |                           |
> > >  Verify token T:               |                           |
> > >   - signatures                 |                           |
> > >   - Platform/Realm             |                           |
> > >     token binding              |                           |
> > >   - challenge freshness        |                           |
> > >   - platform/RIM policy        |                           |
> > >   - verify measurement logs    |                           |
> > >      |                         |                           |
> > >      | ----ACCEPT / REJECT---->|                           |
> > > 
> > > This patch based on arm-cca-mr series [3].
> > > 
> > > Link: [0] https://uefi.org/specs/UEFI/2.11/38_Confidential_Computing.html#intel-trust-domain-extension
> > > Link: [1] https://github.com/tianocore/edk2/issues/11383
> > > Link: [2] https://github.com/tianocore/edk2/issues/11384
> > > Link: [3] https://lore.kernel.org/all/20260929-arm_cca_mr-v2-0-1d98bba187fd@arm.com/
> > > 
> > > ---
> > > Yeoreum Yun (3):
> > >       virt: coco: introduce tsm_default_tm() and tsm_mr_read()/write()
> > >       security: IMA: introduce ima_mr structure
> > >       security: IMA: use TSM measurement registers
> > > 
> > >  drivers/virt/coco/guest/tsm-mr.c          | 159 +++++++++++++---
> > >  include/linux/tsm-mr.h                    |  26 +++
> > >  security/integrity/ima/Makefile           |   3 +-
> > >  security/integrity/ima/ima.h              |   7 +-
> > >  security/integrity/ima/ima_api.c          |   4 +-
> > >  security/integrity/ima/ima_crypto.c       | 137 +++++---------
> > >  security/integrity/ima/ima_fs.c           |  16 +-
> > >  security/integrity/ima/ima_init.c         |   7 +-
> > >  security/integrity/ima/ima_mr.c           |  48 +++++
> > >  security/integrity/ima/ima_mr.h           |  76 ++++++++
> > >  security/integrity/ima/ima_mr_tpm.c       | 155 ++++++++++++++++
> > >  security/integrity/ima/ima_mr_tsm.c       | 290 ++++++++++++++++++++++++++++++
> > >  security/integrity/ima/ima_queue.c        |  39 ++--
> > >  security/integrity/ima/ima_template.c     |   4 +-
> > >  security/integrity/ima/ima_template_lib.c |   2 +-
> > >  15 files changed, 819 insertions(+), 154 deletions(-)
> > > ---
> > > base-commit: b561246f45174b7472c24b75358ea95bae72b7b8
> > > change-id: 20260929-ima_tgx_integration_v2-1c54aeeaeaee
> > > 
> > > Best regards,
> 

-- 
Sincerely,
Yeoreum Yun
