Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771777;
	b=KLp23mr+XweWAsqoy2f8JVKDmgvEWdT1J6ePAP2yARCCQSsv4Qz8kTQfoJkKqyH5JvDd
	 7CYYyOL5LjASYeZk5v4HwYEpCCea3Hq3uky7523LoKS4kDjKifrgtWjINgohmgIFXCRc6
	 ZgTArlKLf64qiNR5IEOA67TBG5YiFoC0A8+GZvbSxzihxP4sYQz7KqVBFpKtzbVvtRJPK
	 vEHk2ke8YfpfTA4Afb6cGpddK8fmFPBqVD2a9lq9FGdzhiCqplKcegwJD/r7RNZcbw6RO
	 q9gBXpW5awMJBTGDtZVLGCf0bXQ+VzFl6JB+2+1m3FrsKU8INAaxPXZ7Z35x1ayS9kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xHPyJcYvf1j/SZNHNisUR9Gg3vD2ENM54wGJRAGjrNo=;
	b=Ntgs2m4x4acO2A5iooTjZNQKbMgg93rXTqOUC8VT0IzUl2d26rdxymIPTbeezHXdBb2V
	 B3vT2vG8obj/U6o+X2Pj1bbd0eWL/Hfzs81xpJQnfIW+E5wPZmz/G0GGAR7UdRAv4u3vo
	 jcXv7fC3rKMlr/qxQ8FIC1pvxthHOc8KEMB9hfwjCUfKaw92WckC+0IVTzgdLKlKEJXdW
	 SHHQ+5OBKnbj1Pc7jZ4U2uPgRdDygpkbsY++RiJGftmE8OsoWJwzGYFCA5BgefOdNiUID
	 RMJZYbZiEKDiAh4QhuB5jzWc+khTTBjOMYZXs8OGXFlKTOQ+3zhjj1/BTj18nkPLfWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THk+yRIS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A329606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THk+yRIS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23321F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 05:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771776;
	bh=xHPyJcYvf1j/SZNHNisUR9Gg3vD2ENM54wGJRAGjrNo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=THk+yRISu9g2BJSaBAg7Q27Cacm0lDHFkWU2e//596hfJqQPuck+vNm+F8frcfCmU
	 4lJMNkWCSz0b3bEUs+xbe1AWy7VCbcVUAK4/WraJXqYT+n4e8l/CecxVL6YsHTZ8yo
	 P0yi61j6y/118hdKPUfxlHkR+6RPc+sgHQiGHtT8nusns89ID4UicRraaLBPoB/zsk
	 BVvDFyED+gn6YI7GUJnUIiSbt/F9LQvb9Y/xlnLTIcp5ykOJS7P3dc2Eglrhzo7LhD
	 GJ1CIsR6mKJL/y4ZSkgWaMC5psfJSBBk3+a0fPK65v2ukBrTnB0wGfleMr1fvV4ryY
	 X25kmehLL4Nlg==
Message-ID: <sashiko-outbox-196706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: hold ima_extend_list_mutex while locating the trim
 position
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104053705.3967228-1-liuwb@xiaopeng.com>
References: <20261104053705.3967228-1-liuwb@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:56:16 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] ima: comment and commit message in ima_queue_delete_partial() cite =
non-existent ima_extend_list()
--

commit 1fb4a03b7cbb60d3d99dc9d31af10d612ce10f6a
Author: Weibin Liu <liuwb@xiaopeng.com>

ima: hold ima_extend_list_mutex while locating the trim position

This commit moves the measurement list lookup in ima_queue_delete_partial()
under ima_extend_list_mutex so that locating the trim position and cutting =
the
list are serialized against concurrent writers on separate file descriptors.

> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 0f1b7e4113c4f..cf8c164eea139 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -427,12 +427,16 @@ int ima_queue_delete_partial(unsigned long req_valu=
e)
>  	struct ima_queue_entry *qe;
>  	int ret =3D 0;
> =20
> +	mutex_lock(&ima_extend_list_mutex);
> +
>  	/*
> -	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
> -	 * only list append can happen concurrently. No list replace due to the
> -	 * staging/delete writers mutual exclusion.
> +	 * The lookup and the cut have to be atomic with respect to other
> +	 * writers: ima_fs.c serializes open(), but write() can run
> +	 * concurrently on independently opened descriptors. Holding
> +	 * ima_extend_list_mutex also excludes ima_extend_list(), so the
> +	 * plain list traversal is sufficient.
>  	 */

[Severity: Low]
This isn't a bug, but both the comment in ima_queue_delete_partial() and the
commit message refer to ima_extend_list(), which does not exist in the tree.

Entries are appended to ima_measurements in ima_add_digest_entry() (called
from ima_add_template_entry() and ima_restore_measurement_entry()) while
holding ima_extend_list_mutex. Should the comment and commit message refer =
to
ima_add_digest_entry() instead of ima_extend_list()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104053705.3967=
228-1-liuwb@xiaopeng.com?part=3D1
