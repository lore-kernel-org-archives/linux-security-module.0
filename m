Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1122F76C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063360; cv=none; b=CfDkDJYjmh96y6Hfbp06MyPRZpt66g13VDWnNGB+33xaeQhFHLxZBr/smx56wSFxP0ut49WtHjlAJaBj9C8YE9mOY5Euvb1veoNcCRafoaP/u0wzkSAQCIbkBOwJs38aW1rBaJSgg5V32pixK8fJlAzzH1/QCxqB/ZYvYqlsU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063360; c=relaxed/simple;
	bh=fsaG4Yr+qbfXr72IFLFLBzq0OEjbg96ntH08l7+8WuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZS+R9+HH/LbU9QYwwBhfO0qwH4PIvNldKOBnmEUneHVGYfEkIjP9AGUM+jhv9u8ow5IXbP3iJbPp1+Od9RrkUZHTUjipd6ps0+O5RLu8codgC0d4okzF3GJ3a4gUeDt2QQhHaVDKPZ2dJF1+jox+F4yBr4rhrjgPFJ0I+vIqO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bLNl22r6zzsSJD
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 16:41:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id BFB2E1402FC
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 16:42:27 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXaEfs2E9o19jYCQ--.24961S2;
	Mon, 16 Jun 2025 09:42:26 +0100 (CET)
Message-ID: <c9d0b5e758a3dcf7e5aed7ca597ecec02c72dc52.camel@huaweicloud.com>
Subject: Re: [PATCH 2/5] smack: fix bug: SMACK64TRANSMUTE set on
 non-directory
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Konstantin Andreev <andreev@swemel.ru>, Casey Schaufler
	 <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Date: Mon, 16 Jun 2025 10:42:16 +0200
In-Reply-To: <20250616010745.800386-3-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
	 <20250616010745.800386-3-andreev@swemel.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXaEfs2E9o19jYCQ--.24961S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr48KrWDAw4UJF4DtFW7twb_yoW5Ar4xpr
	45W3W3Gr1DtF1DZ3y0yF43Ww1a9FZ5Gw4UWF90grnxZFyDJryIgFWI9r1Y9F1Iqr97ZrnY
	qr42vr15uFn0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGhPwmgEDQABsB

On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
> When a new file system object is created
> and the conditions for label transmutation are met,
> the SMACK64TRANSMUTE extended attribute is set
> on the object regardless of its type:
> file, pipe, socket, symlink, or directory.
>=20
> However,
> SMACK64TRANSMUTE may only be set on directories.
>=20
> This bug is a combined effect of the commits [1] and [2]
> which both transfer functionality
> from smack_d_instantiate() to smack_inode_init_security(),
> but only in part.
>=20
> Commit [1] set blank  SMACK64TRANSMUTE on improper object types.

Hi Konstantin

I didn't see where, can you point where it is done?

> Commit [2] set "TRUE" SMACK64TRANSMUTE on improper object types.
>=20
> [1] 2023-06-10,
> Fixes: baed456a6a2f ("smack: Set the SMACK64TRANSMUTE xattr in smack_inod=
e_init_security()")
> Link: https://lore.kernel.org/linux-security-module/20230610075738.327376=
4-3-roberto.sassu@huaweicloud.com/
>=20
> [2] 2023-11-16,
> Fixes: e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inod=
e_init_security()")
> Link: https://lore.kernel.org/linux-security-module/20231116090125.187209=
-5-roberto.sassu@huaweicloud.com/
>=20
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  security/smack/smack_lsm.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a7292d286f7c..2d3186e50c62 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1028,18 +1028,20 @@ static int smack_inode_init_security(struct inode=
 *inode, struct inode *dir,
>  		if (!trans_cred)
>  			issp->smk_inode =3D dsp;
> =20
> -		issp->smk_flags |=3D SMK_INODE_TRANSMUTE;
> -		xattr_transmute =3D lsm_get_xattr_slot(xattrs,
> -						     xattr_count);
> -		if (xattr_transmute) {
> -			xattr_transmute->value =3D kmemdup(TRANS_TRUE,
> -							 TRANS_TRUE_SIZE,
> -							 GFP_NOFS);
> -			if (!xattr_transmute->value)
> -				return -ENOMEM;

To avoid having another indentation, you could also set xattr_transmute
to NULL initially, and call lsm_get_xattr_slot() only for directories.
Setting SMK_INODE_TRANSMUTE in issp->smk_flags should be done of course
if xattr_transmute !=3D NULL.

Either way is fine for me.

Roberto

> +		if (S_ISDIR(inode->i_mode)) {
> +			issp->smk_flags |=3D SMK_INODE_TRANSMUTE;
> +			xattr_transmute =3D lsm_get_xattr_slot(xattrs,
> +							     xattr_count);
> +			if (xattr_transmute) {
> +				xattr_transmute->value =3D kmemdup(TRANS_TRUE,
> +								 TRANS_TRUE_SIZE,
> +								 GFP_NOFS);
> +				if (!xattr_transmute->value)
> +					return -ENOMEM;
> =20
> -			xattr_transmute->value_len =3D TRANS_TRUE_SIZE;
> -			xattr_transmute->name =3D XATTR_SMACK_TRANSMUTE;
> +				xattr_transmute->value_len =3D TRANS_TRUE_SIZE;
> +				xattr_transmute->name =3D XATTR_SMACK_TRANSMUTE;
> +			}
>  		}
>  	}
> =20

