Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341036B91A
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738066; cv=none; b=axdo+U471hD3ErsD1Apw8vtnJ4HFa0mRjUPJjbwBY4N3bLaYU7pcZCJ7IhkI4B4K6fZf3n5/L9p68ncWVpXXw9UHbcjsTos+uHfh682PQz8ky/p2aG4/tEQtsqarhdDh30kLyX0hhbDioI/O6bL3Lfzn17+HKeXUq0N6207bh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738066; c=relaxed/simple;
	bh=BLuOPH0G4oeTqFw51OAVLkRZTL2f2LTPyrH1ES5GjiM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBPNgAQZjcCFZUH/BQD3Gc/xYd//7NQctLHN3BqTO0qHmQ6EQcbcn4ig77dvQbV9sQ7JvostLBSe2oJOj2frrKvfBEDwcpJkVN/34L9BHzL2tXIl4h1OhMn5jZ3hPXEnJGvEqiEvWza5JbNkmf69j8ePpkOaOBrdgyXZTUlwYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5nzsLes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5nzsLes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B181F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 03:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738064;
	bh=z3Cq7+ILL3eg6JPWz6+tw6V0ZeRLUlE5OC2/QMxtmI0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=i5nzsLesWcCE+k9zWJ0vPrhjAwiby+FaHpnN1LVRGJT/d4fMD+exnesLfS2uxc44C
	 dBsh1EOt/by82/i43bdhjj2v/kCaajShUA+O/DFhxe/Zu6u70sfW+Bpqb315Q/tD5C
	 0/omgf09BksN3iolOLlcqfrZZ+2AiqivyfuzREmZ6NtbyTf7qkXSzwLw8szzL+jUW7
	 CFkOz3UOyf/tZqDDTIxQ9cY7y7fpu/BQ+E1/DdFTEgEj3/V2Hwv6GwIdC5fb1ipLME
	 q9l5EU8toVynAuIjpAiCtpUwjrwbstQxxGSgKHPXd6fZA9EkbVtrtLyinKh0GFp/Hl
	 ZXxVZ8L+93FjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] smack: preserve low-integrity labels across file copy
 via whitelist
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <9EAFC73B591799F5+20260930030425.496501-1-tangpengke@yhkylin.cn>
References: <9EAFC73B591799F5+20260930030425.496501-1-tangpengke@yhkylin.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:14:24 +0000
Message-Id: <20260930031424.73B181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] security/smack: TOCTOU race in smack_inode_init_security() cau=
ses NULL deref
- [High] security/smack: lockless mutation of shared cred in smack_file_ope=
n()
- [High] security/smack: caching file labels on task creds mislabels unrela=
ted files
- [Medium] security/smack: smk_preserve state leaks during label transmutat=
ion
--

commit 6dde1ac3f8846672b424ea2f203f58b7b5b2f900
Author: Tang Pengke <tangpengke@yhkylin.cn>
smack: preserve low-integrity labels across file copy via whitelist

This commit introduces a mechanism to preserve low-integrity Smack labels
across file copies by temporarily storing a whitelisted label in the
task's Smack credential during file open. This label is then inherited by
the next inode created by the task.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c

[ ... ]

> @@ -1066,6 +1073,19 @@ static int smack_inode_init_security(struct inode =
*inode, struct inode *dir,
>  		}
>  	}
> =20
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +	/*
> +	 * If a whitelisted label was recorded on file open and no
> +	 * transmutation applies, inherit it so the new file keeps the
> +	 * source's (low-integrity) label across the copy.
> +	 */
> +	if (!trans_cred && tsp->smk_preserve !=3D NULL &&
> +	    !(trans_rule && smk_inode_transmutable(dir))) {

[Severity: Medium]
If transmutation applies, the condition checking smk_inode_transmutable(dir)
evaluates to false and this block is skipped.

Because tsp->smk_preserve is not cleared in that path, will the untrusted
label leak and inadvertently taint the next unrelated file created in a
non-transmutable directory?

> +		issp->smk_inode =3D tsp->smk_preserve;
> +		tsp->smk_preserve =3D NULL;

[Severity: Critical]
Could a time-of-check to time-of-use race occur here if the task credential
is shared among multiple threads?

If thread A and thread B both enter smack_inode_init_security() concurrentl=
y,
could thread B clear tsp->smk_preserve right after thread A checks it for
non-null, causing thread A to assign a null pointer to issp->smk_inode?=20

This appears to lead to a kernel panic when issp->smk_inode->smk_known is
subsequently passed to strlen() a few lines below.

> +	}
> +#endif
> +

[ ... ]

> @@ -2068,6 +2088,39 @@ static int smack_file_open(struct file *file)
>  	smk_ad_setfield_u_fs_path(&ad, file->f_path);
>  	rc =3D smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
>  	rc =3D smk_bu_credfile(file->f_cred, file, MAY_READ, rc);
> +	if (rc)
> +		return rc;
> +
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST

[ ... ]

> +	if (!list_empty(&smk_preserve_wl) &&
> +	    (file->f_flags & O_ACCMODE) =3D=3D O_RDONLY &&
> +	    S_ISREG(inode->i_mode)) {
> +		struct smack_known *skp =3D smk_of_inode(inode);
> +
> +		if (smk_preserve_allowed(skp))
> +			tsp->smk_preserve =3D skp;

[Severity: High]
Is it safe to locklessly mutate a live, committed, and potentially shared
cred structure here?=20

Since credentials can be shared between threads via clone flags, mutating
tsp->smk_preserve without synchronization might result in data races. Stand=
ard
kernel patterns generally treat cred structures as immutable after
commit_creds() is called.

[Severity: High]
Does latching the file's label onto the task simply because a file was read
risk mislabeling unrelated files during subsequent creations?=20

For example, if a program reads a whitelisted file and subsequently creates
a completely unrelated temporary file, it seems the unrelated file will
erroneously inherit the whitelisted label in smack_inode_init_security().

> +	}
> +#endif
> =20
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/9EAFC73B591799F5+20=
260930030425.496501-1-tangpengke@yhkylin.cn?part=3D1
