Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21C480359;
	Thu, 27 Aug 2026 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843585; cv=none; b=qN9byYLPnGuSbiibiuzPvWyalaTsAuf0ak2vS/zAGpF8tj0tnmG9xcmSrs2F4YKK6pMI2M7GOMXq3QPg5J/R5Y1koUUzDi62wH+haNeEI0Li9TwFLN6XtbtjJHyv6nYVy8uiSrYq31H2sGj0nE6H6lzQF2zsKtMe0Aimf/W4u5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843585; c=relaxed/simple;
	bh=8XP+3iFvKeqHuHIKqKyr1ZqegPzvcSy8tM88odHicKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxWnEr8sSGtxLh0RvMRraGC8kEaEXeAfEfXCCxXDc/e/l70+TznVbbc1cEGwq2Ii/B+poHEQWc6A+tj86y82nLUwbG4pguk01oe85p7s0O71ha/jt4kr6NCoFVEgeZu174aMfQ4E3/gdKncuqsmvo9SR9xDC7ZlfiqFU/FC2FMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hW4DV383cz1HCFf;
	Thu, 27 Aug 2026 22:49:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 44C3240558;
	Thu, 27 Aug 2026 22:56:52 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with UTF8SMTPA id LxC2BwAHWtApUJBqpUVuAA--.42007S2;
	Thu, 27 Aug 2026 15:56:51 +0100 (CET)
Message-ID: <d63a007c6d371496780d3577e64e57b4d0e11e1a.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Singh, Jashandeep" <jashandeep.singh@hpe.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jashandeep Singh <jdsw@juniper.net>
Date: Thu, 27 Aug 2026 16:56:38 +0200
In-Reply-To: <037C125E-9343-464E-A1AF-8078D3B7BA38@hpe.com>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
	 <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
	 <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
	 <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
	 <92bf67810c6ed6bc4764f330d77c3ac2279781eb.camel@huaweicloud.com>
	 <037C125E-9343-464E-A1AF-8078D3B7BA38@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHWtApUJBqpUVuAA--.42007S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4UuFWxWr47Ar4UJr4ktFb_yoW5uF18pr
	WkX3WUAFn7XF1xArZ2va1xKr12y3yxGw4UWr1YyFy8Awn0gFn29wsFk3yrWrWq9F1kJF90
	9FW3Kw12yr4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGqP4mYnTwABsc

On Thu, 2026-08-27 at 14:46 +0000, Singh, Jashandeep wrote:
> Mimi, the patch covers the case where the TPM is provisioned with a singl=
e PCR
> bank, SHA-384, while the default IMA hash is configured as SHA-256.
>=20
> The SHA-384 bank is present in nr_allocated_banks, but it matches neither=
 the
> configured default (SHA-256) nor the current hardcoded fallbacks (SHA-256=
, then
> SHA-1). As a result, bank_idx remains -1, and we hit "No suitable TPM alg=
orithm
> for boot aggregate", leaving the boot aggregate zeroed.
>=20
> Roberto, it is not strictly true that the boot aggregate algorithm is alw=
ays the
> same as the default IMA hash algorithm.
>=20
> When the bank corresponding to the default hash is not allocated, the exi=
sting
> SHA-256/SHA-1 fallback logic selects a different bank than the default.
> Therefore, the boot aggregate can already use a different algorithm from =
the
> configured IMA hash.
>=20
> My patch adds SHA-384 as one more fallback for the case where SHA-384 is =
the
> only allocated bank. This allows users with such a configuration to have =
the
> boot aggregate computed, without requiring them to change their default I=
MA
> hash to SHA-384.

That would work for your use case, but what about anyone using a single
SHA-512 PCR bank?

Would it be fine to add a new Kconfig and kernel option to specify a
custom boot aggregate algorithm?

Thanks

Roberto

> Thanks,
> Jashan
>=20
> > On 27 Aug 2026, at 6:47=E2=80=AFPM, Roberto Sassu <roberto.sassu@huawei=
cloud.com> wrote:
> >=20
> > On Wed, 2026-08-26 at 19:14 -0400, Mimi Zohar wrote:
> > > Hi Jashan,
> > >=20
> > > Mail to the kernel mailing lists are in plain text. Please refer to
> > > https://docs.kernel.org/process/submitting-patches.html#no-mime-no-li=
nks-no-compression-no-attachments-just-plain-text=20
> > >=20
> > > On Wed, 2026-08-26 at 22:35 +0000, Singh, Jashandeep wrote:
> > > > Thanks Mimi.
> > > >=20
> > > >=20
> > > > Agreed that all allocated banks are extended via tpm_pcr_extend() -=
 but that's
> > > > the PCR-extend (write) path. The failure is in ima_calc_boot_aggreg=
ate(), which
> > > > reads PCRs 0-9 from a *single* selected bank.
> > > >=20
> > > >=20
> > > > The issue is that a TPM can be provisioned with *only* the SHA-384 =
bank enabled,
> > > > while the default IMA hash algorithm is SHA-256. In this configurat=
ion, the
> > > > current selection logic only matches the configured IMA default, th=
en SHA-256,
> > > > and then SHA-1 - it never considers SHA-384.
> > >=20
> > > It's walking the list of allocated TPM banks and, if allocated, sets =
bank_idx.
> > >=20
> > >        for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> > >                crypto_id =3D ima_tpm_chip->allocated_banks[i].crypto_=
id;
> > >                if (crypto_id =3D=3D hash->algo) {
> > >                        bank_idx =3D i;
> > >                        break;
> > >                }
> > >=20
> > > The question is why isn't the sha384 bank found in the list of
> > > nr_allocated_banks?
> >=20
> > The boot aggregate algorithm is the same as the default hash algorithm.
> >=20
> > Please try ima_hash=3Dsha384.
> >=20
> > Thanks
> >=20
> > Roberto
> >=20
> > > Mimi
> > >=20
> > > >=20
> > > > Adding a SHA-384 match allows the boot aggregate to be computed cor=
rectly
> > > > (sha384:...) instead of returning 0 and logging "No suitable TPM al=
gorithm for
> > > > boot aggregate". The fact that the SHA-384 bank can be selected and=
 the boot
> > > > aggregate computed also confirms that the SHA-384 bank is recognize=
d and
> > > > allocated, rather than being missing.
>=20
>=20

