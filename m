Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9681A7253
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064726; cv=none; b=prfyi0AlNnBAH7EaHfmoPgOG5oLEeFadZdvVoYjOJpOxDaDxHe/9VDcjgZRPs7WVlYuQbqLaCYDQM3kDAuipcxMMDfELwAAy2172zVv1XmKVkTrNTENzn1awwVsAU5Vwd42KW9JD3xhkTp0HfIj+OKdk3fT91eH4AabnHuj5yyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064726; c=relaxed/simple;
	bh=Hhqw37xfuttuG69TM5tYnVwuAuFrGXFGTN1ro1cAUFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBgteBMnr0nGbF66kLKcER/az8zjTy90vUiLMDkuFE6BeDds7ArzBETZvW6JAVSnC+RqwkxPRZK10eZUj0PZxMAQzyNeSxTxBv5tSXfmn2HPTbmIuGbPF6sHRjgp6brDLVTUxbo4okHFNxhezfJQ1GxAlcvJAjMG0uKDHH6iDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4bLPFN2ShKzpTkx
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:04:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 25D681402C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:05:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3SklL3k9o2RjZCQ--.18764S2;
	Mon, 16 Jun 2025 10:05:21 +0100 (CET)
Message-ID: <147eb5a5c06ed28eec9cf33a877cfb200e9a6103.camel@huaweicloud.com>
Subject: Re: [PATCH 5/5] smack: fix bug: invalid label of unix socket file
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Konstantin Andreev <andreev@swemel.ru>, Casey Schaufler
	 <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Date: Mon, 16 Jun 2025 11:05:11 +0200
In-Reply-To: <20250616010745.800386-6-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
	 <20250616010745.800386-6-andreev@swemel.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB3SklL3k9o2RjZCQ--.18764S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryfAr4kKw47trWxtr13urg_yoWxCF1kpF
	9rGFyakry7JFykWFZYyF1DWr409FWfK3yUJ3W3Ww1xJFnxt3s2gF1Sqr4UCFyUXr4Uu3yF
	qFWj9r4DuFnFg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGhPwmgEZgAAsr

On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
> According to [1], the label of a UNIX domain socket (UDS)
> file (i.e., the filesystem object representing the socket)
> is not supposed to participate in Smack security.
>=20
> To achieve this, [1] labels UDS files with "*"
> in smack_d_instantiate().
>=20
> Before [2], smack_d_instantiate() was responsible
> for initializing Smack security for all inodes,
> except ones under /proc
>=20
> [2] imposed the sole responsibility for initializing
> inode security for newly created filesystem objects
> on smack_inode_init_security().
>=20
> However, smack_inode_init_security() lacks some logic
> present in smack_d_instantiate().
> In particular, it does not label UDS files with "*".
>=20
> This patch adds the missing labeling of UDS files
> with "*" to smack_inode_init_security().
>=20
> Labeling UDS files with "*" in smack_d_instantiate()
> still works for stale UDS files that already exist on
> disk. Stale UDS files are useless, but I keep labeling
> them for consistency and maybe to make easier for user
> to delete them.
>=20
> Compared to [1], this version introduces the following
> improvements:
>=20
>   * UDS file label is held inside inode only
>     and not saved to xattrs.
>=20
>   * relabeling UDS files (setxattr, removexattr, etc.)
>     is blocked.
>=20
> [1] 2010-11-24 Casey Schaufler
> commit b4e0d5f0791b ("Smack: UDS revision")
>=20
> [2] 2023-11-16 roberto.sassu
> Fixes: e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inod=
e_init_security()")
> Link: https://lore.kernel.org/linux-security-module/20231116090125.187209=
-5-roberto.sassu@huaweicloud.com/
>=20
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  Documentation/admin-guide/LSM/Smack.rst |  5 +++
>  security/smack/smack_lsm.c              | 58 +++++++++++++++++++------
>  2 files changed, 49 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/LSM/Smack.rst b/Documentation/admi=
n-guide/LSM/Smack.rst
> index 6d44f4fdbf59..1b554b5bf98e 100644
> --- a/Documentation/admin-guide/LSM/Smack.rst
> +++ b/Documentation/admin-guide/LSM/Smack.rst
> @@ -696,6 +696,11 @@ sockets.
>  	A privileged program may set this to match the label of another
>  	task with which it hopes to communicate.
> =20
> +UNIX domain socket (UDS) with a BSD address functions both as a file in =
a
> +filesystem and as a socket. As a file, it carries the SMACK64 attribute.=
 This
> +attribute is not involved in Smack security enforcement and is immutably
> +assigned the label "*".
> +
>  Smack Netlabel Exceptions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fb23254c8a54..1b41ae053966 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1021,6 +1021,16 @@ static int smack_inode_init_security(struct inode =
*inode, struct inode *dir,
>  	bool trans_cred;
>  	bool trans_rule;
> =20
> +	/*
> +	 * UNIX domain sockets use lower level socket data. Let
> +	 * UDS inode have fixed * label to keep smack_inode_permission() calm
> +	 * when called from unix_find_bsd()
> +	 */
> +	if (S_ISSOCK(inode->i_mode)) {
> +		/* forced label, no need to save to xattrs */
> +		issp->smk_inode =3D &smack_known_star;
> +		goto instant_inode;

Maybe you could also set SMK_INODE_INSTANT here and just return.

Roberto

> +	}
>  	/*
>  	 * If equal, transmuting already occurred in
>  	 * smack_dentry_create_files_as(). No need to check again.
> @@ -1057,14 +1067,16 @@ static int smack_inode_init_security(struct inode=
 *inode, struct inode *dir,
>  		}
>  	}
> =20
> -	issp->smk_flags |=3D (SMK_INODE_INSTANT | transflag);
> -	if (rc)
> -		return rc;
> -
> -	return xattr_dupval(xattrs, xattr_count,
> +	if (rc =3D=3D 0)
> +		if (xattr_dupval(xattrs, xattr_count,
>  			    XATTR_SMACK_SUFFIX,
>  			    issp->smk_inode->smk_known,
> -		     strlen(issp->smk_inode->smk_known));
> +		     strlen(issp->smk_inode->smk_known)
> +		))
> +			rc =3D -ENOMEM;
> +instant_inode:
> +	issp->smk_flags |=3D (SMK_INODE_INSTANT | transflag);
> +	return rc;
>  }
> =20
>  /**
> @@ -1338,13 +1350,23 @@ static int smack_inode_setxattr(struct mnt_idmap =
*idmap,
>  	int check_import =3D 0;
>  	int check_star =3D 0;
>  	int rc =3D 0;
> +	umode_t const i_mode =3D d_backing_inode(dentry)->i_mode;
> =20
>  	/*
>  	 * Check label validity here so import won't fail in post_setxattr
>  	 */
> -	if (strcmp(name, XATTR_NAME_SMACK) =3D=3D 0 ||
> -	    strcmp(name, XATTR_NAME_SMACKIPIN) =3D=3D 0 ||
> -	    strcmp(name, XATTR_NAME_SMACKIPOUT) =3D=3D 0) {
> +	if (strcmp(name, XATTR_NAME_SMACK) =3D=3D 0) {
> +		/*
> +		 * UDS inode has fixed label
> +		 */
> +		if (S_ISSOCK(i_mode)) {
> +			rc =3D -EINVAL;
> +		} else {
> +			check_priv =3D 1;
> +			check_import =3D 1;
> +		}
> +	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) =3D=3D 0 ||
> +		   strcmp(name, XATTR_NAME_SMACKIPOUT) =3D=3D 0) {
>  		check_priv =3D 1;
>  		check_import =3D 1;
>  	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) =3D=3D 0 ||
> @@ -1354,7 +1376,7 @@ static int smack_inode_setxattr(struct mnt_idmap *i=
dmap,
>  		check_star =3D 1;
>  	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) =3D=3D 0) {
>  		check_priv =3D 1;
> -		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
> +		if (!S_ISDIR(i_mode) ||
>  		    size !=3D TRANS_TRUE_SIZE ||
>  		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) !=3D 0)
>  			rc =3D -EINVAL;
> @@ -1485,12 +1507,15 @@ static int smack_inode_removexattr(struct mnt_idm=
ap *idmap,
>  	 * Don't do anything special for these.
>  	 *	XATTR_NAME_SMACKIPIN
>  	 *	XATTR_NAME_SMACKIPOUT
> +	 *	XATTR_NAME_SMACK if S_ISSOCK (UDS inode has fixed label)
>  	 */
>  	if (strcmp(name, XATTR_NAME_SMACK) =3D=3D 0) {
> -		struct super_block *sbp =3D dentry->d_sb;
> -		struct superblock_smack *sbsp =3D smack_superblock(sbp);
> +		if (!S_ISSOCK(d_backing_inode(dentry)->i_mode)) {
> +			struct super_block *sbp =3D dentry->d_sb;
> +			struct superblock_smack *sbsp =3D smack_superblock(sbp);
> =20
> -		isp->smk_inode =3D sbsp->smk_default;
> +			isp->smk_inode =3D sbsp->smk_default;
> +		}
>  	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) =3D=3D 0)
>  		isp->smk_task =3D NULL;
>  	else if (strcmp(name, XATTR_NAME_SMACKMMAP) =3D=3D 0)
> @@ -3608,7 +3633,7 @@ static void smack_d_instantiate(struct dentry *opt_=
dentry, struct inode *inode)
>  		 */
> =20
>  		/*
> -		 * UNIX domain sockets use lower level socket data.
> +		 * UDS inode has fixed label (*)
>  		 */
>  		if (S_ISSOCK(inode->i_mode)) {
>  			final =3D &smack_known_star;
> @@ -4879,6 +4904,11 @@ static int smack_secctx_to_secid(const char *secda=
ta, u32 seclen, u32 *secid)
> =20
>  static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 =
ctxlen)
>  {
> +	/*
> +	 * UDS inode has fixed label. Ignore nfs label.
> +	 */
> +	if (S_ISSOCK(inode->i_mode))
> +		return 0;
>  	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx,
>  				       ctxlen, 0);
>  }

