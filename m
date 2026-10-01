Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577C3EDE6E;
	Thu,  1 Oct 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855028; cv=none; b=WeTGgZZzZhn1jLL1DZ+CRCHfPgsM/V/TGjv7GIGJh8EnWO3PWlQHx6wjChx0s5izY/A+aAcowK9LXZES5sq7ET1IP8Im91FJO2PVm093vrW0VPsP5eu/dXsxbvazttCAHmLMGWReenmE1lQfFO3X9nFJtcxX4jF48XABQpcMCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855028; c=relaxed/simple;
	bh=uWTjLGxnQ/5ATNS7FIr5/dCE3sbu/nG79bh8J+7Tlz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=egfOBk1s3JN2g5Xwu1K0ePEVxpgJjuu/LONRlNIAaN8/xLFJeqrdK44mUHeWXLVsYAvhOHa5vfGz2rw3iFUZt8Pca5kM5AqPSqIlflsmM0mXb8WEkJwXN8j70wDJVBZzdC7Dog0T9xVEkM/Y3HoHpZFBQvUn+8JBlKiIs5XoJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hwTwL22dTz1HCDY;
	Thu,  1 Oct 2026 19:20:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 410394055E;
	Thu,  1 Oct 2026 19:27:53 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwB3Vy+qQ75qmdM_AQ--.58836S2;
	Thu, 01 Oct 2026 12:27:52 +0100 (CET)
Message-ID: <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric
 Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Cc: Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Suzuki Poulose
 <suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>, Sami Mujawar
 <sami.mujawar@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>
Date: Thu, 01 Oct 2026 13:27:35 +0200
In-Reply-To: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3Vy+qQ75qmdM_AQ--.58836S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr47KFy7tr4kJw1ruF1ftFb_yoWrJr47pa
	nIg3W3Gr1UJa43Cr1fA3WjvFWrW3yrGw4DWw43Jw1kCFsxZFy2gr40kFyFkF98Aryftr18
	tr1Yqrs8u34qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBGq+BZ0nUgAAsy

On Wed, 2026-09-30 at 14:43 +0100, Yeoreum Yun wrote:
> Confidential computing guests without a TPM can use TSM measurement
> registers to record IMA measurement digests instead of TPM PCRs.

Hi Yeoreum

a similar patch set has been sent to the linux-integrity mailing list:

https://lore.kernel.org/linux-integrity/20250630125928.765285-1-gongruiqi1@=
huawei.com/

Could you please work with Gong Ruiqi to have a unified proposal?

Thanks

Roberto

> This series introduces in-kernel interfaces for accessing TSM
> measurement registers, abstracts IMA's measurement-register operations,
> and adds a TSM backend for Intel TDX and Arm CCA.
>=20
> The following mappings between TPM PCR indices and TSM measurement
> registers are defined for Intel TDX [0] and proposed for Arm CCA [1]:
>=20
>   TPM PCR index | Intel TDX register | Arm CCA register
>   --------------+--------------------+-----------------
>   0             | MRTD               | RIM
>   1, 7          | RTMR[0]            | REM[0]
>   2-6           | RTMR[1]            | REM[1]
>   8-15          | RTMR[2]            | REM[2]
>=20
> These mappings allow IMA to translate PCR indices into the corresponding
> TSM measurement registers.
>=20
> The TPM backend remains preferred when it is available at IMA
> initialization. Otherwise, IMA falls back to a supported TSM backend.
> Only one backend is selected; IMA measurements are not extended to both
> TPM PCRs and TSM measurement registers.
>=20
> The attestation proccess for guest with TSM measurement register will
> be done with Confidential Compute Event Log (CCEL) which is exported by
> /sys/firmware/acpi/tables/data/CCEL. Here is brief process in arm64:
>=20
>   Verifier                 Realm guest              RMM / Platform
>      |                         |                           |
>      |--- Challenge (nonce) -->|                           |
>      |                         |--- Request token -------->|
>      |                         |    with challenge         |
>      |                         |                           |
>      |                         |<-- CCA token T -----------|
>      |<-- CCA token T ---------|                           |
>      |<-- CCEL event log ------|                           |
>      |<-- IMA measurement log -|                           |
>      |                         |                           |
>  Verify token T:               |                           |
>   - signatures                 |                           |
>   - Platform/Realm             |                           |
>     token binding              |                           |
>   - challenge freshness        |                           |
>   - platform/RIM policy        |                           |
>   - verify measurement logs    |                           |
>      |                         |                           |
>      | ----ACCEPT / REJECT---->|                           |
>=20
> This patch based on arm-cca-mr series [3].
>=20
> Link: [0] https://uefi.org/specs/UEFI/2.11/38_Confidential_Computing.html=
#intel-trust-domain-extension
> Link: [1] https://github.com/tianocore/edk2/issues/11383
> Link: [2] https://github.com/tianocore/edk2/issues/11384
> Link: [3] https://lore.kernel.org/all/20260929-arm_cca_mr-v2-0-1d98bba187=
fd@arm.com/
>=20
> ---
> Yeoreum Yun (3):
>       virt: coco: introduce tsm_default_tm() and tsm_mr_read()/write()
>       security: IMA: introduce ima_mr structure
>       security: IMA: use TSM measurement registers
>=20
>  drivers/virt/coco/guest/tsm-mr.c          | 159 +++++++++++++---
>  include/linux/tsm-mr.h                    |  26 +++
>  security/integrity/ima/Makefile           |   3 +-
>  security/integrity/ima/ima.h              |   7 +-
>  security/integrity/ima/ima_api.c          |   4 +-
>  security/integrity/ima/ima_crypto.c       | 137 +++++---------
>  security/integrity/ima/ima_fs.c           |  16 +-
>  security/integrity/ima/ima_init.c         |   7 +-
>  security/integrity/ima/ima_mr.c           |  48 +++++
>  security/integrity/ima/ima_mr.h           |  76 ++++++++
>  security/integrity/ima/ima_mr_tpm.c       | 155 ++++++++++++++++
>  security/integrity/ima/ima_mr_tsm.c       | 290 ++++++++++++++++++++++++=
++++++
>  security/integrity/ima/ima_queue.c        |  39 ++--
>  security/integrity/ima/ima_template.c     |   4 +-
>  security/integrity/ima/ima_template_lib.c |   2 +-
>  15 files changed, 819 insertions(+), 154 deletions(-)
> ---
> base-commit: b561246f45174b7472c24b75358ea95bae72b7b8
> change-id: 20260929-ima_tgx_integration_v2-1c54aeeaeaee
>=20
> Best regards,

