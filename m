Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475831A7253
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064674; cv=none; b=GbMoYxZpBgyVj7V1kgo1AqIcg+ovLwRvVhh2SFI+9vNnj1A6gbvs25ESwOqYxRdNUZP14i+e5hh060tDvO8SRlZJv9ZkiAs7t7N9Gf80iSZ70pl1No4e4pZemOYmqhXUkte3FhLNHaM1XQkSKzZqRpnsMzisQUymrs4ADg9gJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064674; c=relaxed/simple;
	bh=mBvbc65Z8UswphkG06PczNsT2u9k0HioEI/CuoHIgL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQOjhQeSuQstu6Wk/raQCnHiOB3bucNQJtElNN38Jf1/qYNXV9jp2RAEjMtbMA4L36gXE5Ta4DF1s9jjm0XaH0gRDvRtKqXSmoIiUhIgLW8oSNfUecuUjwa9wwRr5ssurU34aEK4u/qxvLZOFQGN4QgEPH1uxcScW75nwZQWh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4bLNsJ0spDzpStF
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 16:46:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DED5D1402F0
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 16:47:57 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3n+E52k9olRzLCQ--.3893S2;
	Mon, 16 Jun 2025 09:47:57 +0100 (CET)
Message-ID: <7fd4117ba8c4060923fe533508ab8f8a9afec24c.camel@huaweicloud.com>
Subject: Re: [PATCH 3/5] smack: deduplicate xattr setting in
 smack_inode_init_security()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Konstantin Andreev <andreev@swemel.ru>, Casey Schaufler
	 <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Date: Mon, 16 Jun 2025 10:47:50 +0200
In-Reply-To: <20250616010745.800386-4-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
	 <20250616010745.800386-4-andreev@swemel.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA3n+E52k9olRzLCQ--.3893S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxXF18ur45Kw1Utw45GFg_yoW5CF1kpF
	43G3W3Cr1rtFnrWrWSya1Uuw1S9a1rKr4jgr9xX3s3AFnFqw1IqFW09r1j9F1rXrykurnY
	vF4jvr45u3Z0v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGhPwmgEHQAAsQ

On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  security/smack/smack_lsm.c | 54 ++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
>=20
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 2d3186e50c62..2b46a2867226 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -981,6 +981,24 @@ smk_rule_transmutes(struct smack_known *subject,
>  	return (may > 0) && (may & MAY_TRANSMUTE);
>  }
> =20
> +static int
> +xattr_dupval(struct xattr *xattrs, int *xattr_count,
> +	     const char *name, const void *value, unsigned int vallen)
> +{
> +	struct xattr * const xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
> +
> +	if (!xattr)
> +		return 0;
> +
> +	xattr->value =3D kmemdup(value, vallen, GFP_NOFS);
> +	if (!xattr->value)
> +		return -ENOMEM;
> +
> +	xattr->value_len =3D vallen;
> +	xattr->name =3D name;
> +	return 0;
> +}
> +
>  /**
>   * smack_inode_init_security - copy out the smack from an inode
>   * @inode: the newly created inode
> @@ -998,7 +1016,6 @@ static int smack_inode_init_security(struct inode *i=
node, struct inode *dir,
>  	struct task_smack *tsp =3D smack_cred(current_cred());
>  	struct inode_smack * const issp =3D smack_inode(inode);
>  	struct smack_known *dsp =3D smk_of_inode(dir);
> -	struct xattr *xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>  	bool trans_cred;
>  	bool trans_rule;
> =20
> @@ -1017,8 +1034,6 @@ static int smack_inode_init_security(struct inode *=
inode, struct inode *dir,
>  	 * Mark the inode as changed.
>  	 */
>  	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
> -		struct xattr *xattr_transmute;
> -
>  		/*
>  		 * The caller of smack_dentry_create_files_as()
>  		 * should have overridden the current cred, so the
> @@ -1030,35 +1045,22 @@ static int smack_inode_init_security(struct inode=
 *inode, struct inode *dir,
> =20
>  		if (S_ISDIR(inode->i_mode)) {
>  			issp->smk_flags |=3D SMK_INODE_TRANSMUTE;
> -			xattr_transmute =3D lsm_get_xattr_slot(xattrs,
> -							     xattr_count);
> -			if (xattr_transmute) {
> -				xattr_transmute->value =3D kmemdup(TRANS_TRUE,
> -								 TRANS_TRUE_SIZE,
> -								 GFP_NOFS);
> -				if (!xattr_transmute->value)
> -					return -ENOMEM;
> =20
> -				xattr_transmute->value_len =3D TRANS_TRUE_SIZE;
> -				xattr_transmute->name =3D XATTR_SMACK_TRANSMUTE;
> -			}
> +			if (xattr_dupval(xattrs, xattr_count,
> +				XATTR_SMACK_TRANSMUTE,
> +				TRANS_TRUE,
> +				TRANS_TRUE_SIZE
> +			))

Ok, can also be optimized that way...

Roberto

> +				return -ENOMEM;
>  		}
>  	}
> =20
>  	issp->smk_flags |=3D SMK_INODE_INSTANT;
> =20
> -	if (xattr) {
> -		const char *inode_label =3D issp->smk_inode->smk_known;
> -
> -		xattr->value =3D kstrdup(inode_label, GFP_NOFS);
> -		if (!xattr->value)
> -			return -ENOMEM;
> -
> -		xattr->value_len =3D strlen(inode_label);
> -		xattr->name =3D XATTR_SMACK_SUFFIX;
> -	}
> -
> -	return 0;
> +	return xattr_dupval(xattrs, xattr_count,
> +			    XATTR_SMACK_SUFFIX,
> +			    issp->smk_inode->smk_known,
> +		     strlen(issp->smk_inode->smk_known));
>  }
> =20
>  /**

