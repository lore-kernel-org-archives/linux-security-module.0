Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B44746B6;
	Thu, 27 Aug 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837606; cv=none; b=LbmDbEdNntPB6uS3ISl1gHS1T5IoXooq84Xf/qrFrW8x5cUk+yrtrdEg5PNq8VcihKAsMM4+f8aHWETE9Wxwr73yl3U1hzFz7D8TqlCa7JCna2dDLCVEy2Neg4S9x2pMlIRz6YrbqwVSkJW7Ue0rhRnXPHbnHBVzvM4+ZMDUXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837606; c=relaxed/simple;
	bh=sADAEZNGrHrwnogfdaHVcKl0hh65+2nxXvW9QfVCfVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWrSlX5w9t1tJBCZRHZ0GKzErJEFlT2H0T2PdNV0zA6LFZBgMoQi6i/oM2mklfoPxWXN9uzBLBlR3yv0zkgeCY7wQxEE8HKwqWS+c4oZVmpWbOI6P3p5y8CafS5KYFAgnnpltLsG/9tt6e9IFY8NUYeqKxKBdEDa2qSO3rDrAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hW22H2bnnzt50v;
	Thu, 27 Aug 2026 21:10:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 760CB4055D;
	Thu, 27 Aug 2026 21:17:24 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwBnCE7aOJBq+abuAQ--.58194S2;
	Thu, 27 Aug 2026 14:17:23 +0100 (CET)
Message-ID: <92bf67810c6ed6bc4764f330d77c3ac2279781eb.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, "Singh, Jashandeep"
 <jashandeep.singh@hpe.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, 
 "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Jashandeep Singh <jdsw@juniper.net>
Date: Thu, 27 Aug 2026 15:17:11 +0200
In-Reply-To: <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
	 <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
	 <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
	 <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnCE7aOJBq+abuAQ--.58194S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4fKFy7Jw1UJw17ZFW5Jrb_yoW8Aryrpr
	4kJ3WUJFnIqr1IyrZFv3y8Kr12v397Jw4xGF1jqFy8Arn8XFs29anxZ34FqFWq93WkXFyY
	vFWa9wnFyr48Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGqP4nAggwAAsD

On Wed, 2026-08-26 at 19:14 -0400, Mimi Zohar wrote:
> Hi Jashan,
>=20
> Mail to the kernel mailing lists are in plain text. Please refer to
> https://docs.kernel.org/process/submitting-patches.html#no-mime-no-links-=
no-compression-no-attachments-just-plain-text
>=20
> On Wed, 2026-08-26 at 22:35 +0000, Singh, Jashandeep wrote:
> > Thanks Mimi.
> >=20
> >=20
> > Agreed that all allocated banks are extended via tpm_pcr_extend() - but=
 that's
> > the PCR-extend (write) path. The failure is in ima_calc_boot_aggregate(=
), which
> > reads PCRs 0-9 from a *single* selected bank.
> >=20
> >=20
> > The issue is that a TPM can be provisioned with *only* the SHA-384 bank=
 enabled,
> > while the default IMA hash algorithm is SHA-256. In this configuration,=
 the
> > current selection logic only matches the configured IMA default, then S=
HA-256,
> > and then SHA-1 - it never considers SHA-384.
>=20
> It's walking the list of allocated TPM banks and, if allocated, sets bank=
_idx.
>=20
>         for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
>                 crypto_id =3D ima_tpm_chip->allocated_banks[i].crypto_id;
>                 if (crypto_id =3D=3D hash->algo) {
>                         bank_idx =3D i;
>                         break;
>                 }
>=20
> The question is why isn't the sha384 bank found in the list of
> nr_allocated_banks?

The boot aggregate algorithm is the same as the default hash algorithm.

Please try ima_hash=3Dsha384.

Thanks

Roberto

> Mimi
>=20
> >=20
> > Adding a SHA-384 match allows the boot aggregate to be computed correct=
ly
> > (sha384:...) instead of returning 0 and logging "No suitable TPM algori=
thm for
> > boot aggregate". The fact that the SHA-384 bank can be selected and the=
 boot
> > aggregate computed also confirms that the SHA-384 bank is recognized an=
d
> > allocated, rather than being missing.

