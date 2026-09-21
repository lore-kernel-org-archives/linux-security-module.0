Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670E19EED3
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955748; cv=none; b=oAe8gA2H4WbJXZIDFaeO2WHbl1cf/BESDprrOB0Mj+xG1Ih0wfcl6HnJrVmw2MhLFi5B/rT+VEC7rWa4lSPpzeu6WX0Qu7xwfqOhDASaolUKI6e8pstXyQHxmomV7iCZvTrFotuRp2VItjU/ROhqZk9xyWqCm+d6y5XTEazqQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955748; c=relaxed/simple;
	bh=267T66O22j11xe8q/W9n/RXXyuHZIgyVV06DMJvOx1g=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKfSGINDno2Re64GHXxA7PVtPVwmURF7S/nX80+hBGPBvxvTruGZ64hGaFF6g3CxSX4l03iaLeK8U/LQ7wkCoY7xTW2lYQ4Cs59i1CnvQvc8sxOMxcAiB5y68mXD1ECd/q9ZJODBhLiQVDUhQSVxWdyn6aqD2CMpgk8knhP4Ak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0RB57ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0RB57ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351D1F000FF
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 01:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955746;
	bh=5hZTrYal0rfZWpYigCMbAKki2i/zXAQW++i9+41qNhI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=o0RB57ctmoBicjxjbPq8Fo76j+aC+eVwF4bN/gE9JwwA5V0wmXTBzzHG5mOPoZjB+
	 8xol2pFYYKIujX5J5JICkBKE2qiusQOdOwEBMfrfSkoALfEzzT7GWCdm6mltYUt5I5
	 jVGPe89REkdsIw3So1j3VxWLHdG8eXRPbuJaCmc8noU/CCskGK5zpkRJTkp/Wk0+M8
	 bvQmIQ6O/ar4GufExXkash/wJPxFTPEcWZqvpZwaNMG7sx/Rvi+62pkbm9+wBE5qbQ
	 ftzpHENFQjLeHokZFxU96qKSxZZ04+MEvsGSFlGzppj0vgVZ9y23GQAZ58dpl3Imho
	 ToKVArqZSYxfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] smackfs: reject out-of-range IPv4 octets in netlabel
 writes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <FFA41AC93858A96A+20260921014555.20351-1-daihongjian@kylinsec.com.cn>
References: <FFA41AC93858A96A+20260921014555.20351-1-daihongjian@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 01:55:46 +0000
Message-Id: <20260921015546.C351D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] smackfs: out-of-bounds IPv4 octet validation bypassed via intege=
r wrap-around
--

commit 13135cde4c7fdf9b39cec7b05019b4e50745e1ad
Author: Hongjian Dai <daihongjian@kylinsec.com.cn>

smackfs: reject out-of-range IPv4 octets in netlabel writes

This commit attempts to fix a misconfiguration vulnerability in
smk_write_net4addr() where out-of-range IPv4 octets were silently wrapped by
sscanf with %hhd. It changes the sscanf format to %u and adds explicit
bounds checking before storing the address.

> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 6e62dcb36f74f..5d8bddffbabd3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c

[ ... ]

> @@ -1189,17 +1190,26 @@ static ssize_t smk_write_net4addr(struct file *fi=
le, const char __user *buf,
>  		goto free_data_out;
>  	}
> =20
> -	rc =3D sscanf(data, "%hhd.%hhd.%hhd.%hhd/%u %s",
> -		&host[0], &host[1], &host[2], &host[3], &masks, smack);
> +	rc =3D sscanf(data, "%u.%u.%u.%u/%u %s",
> +		&octet[0], &octet[1], &octet[2], &octet[3], &masks, smack);
>  	if (rc !=3D 6) {
> -		rc =3D sscanf(data, "%hhd.%hhd.%hhd.%hhd %s",
> -			&host[0], &host[1], &host[2], &host[3], smack);
> +		rc =3D sscanf(data, "%u.%u.%u.%u %s",
> +			&octet[0], &octet[1], &octet[2], &octet[3], smack);
>  		if (rc !=3D 5) {
>  			rc =3D -EINVAL;
>  			goto free_out;
>  		}
>  		masks =3D 32;
>  	}
> +	if (octet[0] > 255 || octet[1] > 255 || octet[2] > 255 ||
> +	    octet[3] > 255) {

[Severity: Medium]
Does this still silently wrap if an input value is >=3D 2^32?

The kernel's sscanf implementation for %u parses into a 64-bit unsigned long
long and truncates it to a 32-bit unsigned int.

Input values like 4294967296 are silently truncated to values <=3D 255, whi=
ch
would completely bypass this new validation check and reproduce the exact
silent-wrapping misconfiguration this patch intends to fix.

> +		rc =3D -EINVAL;
> +		goto free_out;
> +	}
> +	host[0] =3D octet[0];
> +	host[1] =3D octet[1];
> +	host[2] =3D octet[2];
> +	host[3] =3D octet[3];
>  	if (masks > BEBITS) {
>  		rc =3D -EINVAL;
>  		goto free_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/FFA41AC93858A96A+20=
260921014555.20351-1-daihongjian@kylinsec.com.cn?part=3D1
