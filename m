Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC66345ED4
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789855370; cv=none; b=cFcKzM9TkhRVMRUTfWLSJKXTDGl7WeavEppgZ1Go8/G9CvTwZSD5ciO7mekQrY5WXFzumnmja8F+A2Kn5ZsOiiwnrOeQ3cB5WSSZRK1dbuV/Iw52QUmJRFMxdK5cghktxhGL4eFv6lPV6SoCwvlTO3p3H8SZ74L7j353BvUy1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789855370; c=relaxed/simple;
	bh=M+S1OIeeGleqMUjdQMnIhCKKvb0fEurS499j/ULZ4uI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MLiTR/k7qXTA7NvW57mSceVXWRO9rXfyqRclPN0Sd2OjfBw8U/5gTD/vwe1NfWWtMwiOuSwbrrqYbIy0+NPRjaSHzcY+cBOTQZc2TPpHwIpIUalu6CWSDonzBjG0kQh/raCKpnd6D5wgWMIr14rVH0ES2deUYpLy4RZCTErBvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6/VGg4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6/VGg4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE42B1F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 22:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789855368;
	bh=bol2m3e1mJqduyjtFjfZFRlcjjFkW20y7GorZ+4P/gA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=T6/VGg4suBv51g6lq6C0yD8tdbnrVPynEZ4yeLFCcUkjE+ukKuW51NF4sp/v1JCAh
	 +cP/9mV1u8/vq3qNUcrUzJ6NMMHPhdotswms9J1p1aE8mSHCRi9Y5cPlX4g5dbhEZ7
	 LDfZOSrHNcfxrtjSH2SuZNzkBauGPs8N6e9kMHsVE7BH2a393KLI0sL/FHiHqx7Dsy
	 N2vDWOknvZsGY6Vl0z5JdmwkGNCS4ts+c1YHEUTbD0E/sD6hkAcpomugwTLSE1JPeA
	 rsFqFMDbprZoifqhmWHkkpo/OrkgWMfN4k9EHnMMv3mc578B9Y9sMWs/iXrQR+qH4e
	 eq0UXt6YBCQHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] netlabel: cipso_v4: reject empty MLS level/cat lists
 and zero tail in cipso_v4_delopt()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919215243.3472150-1-benquike@gmail.com>
References: <20260919215243.3472150-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:02:48 +0000
Message-Id: <20260919220248.BE42B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Fix three bugs in NetLabel CIPSOv4 handling:
>=20
> 1. In netlbl_cipsov4_add_std(), an empty NLBL_CIPSOV4_A_MLSLVLLST or
>    NLBL_CIPSOV4_A_MLSCATLST leaves local_size or cipso_size at 0, causing
>    kcalloc(0, ...) to return ZERO_SIZE_PTR (0x10), which bypasses NULL
>    checks and installs ZERO_SIZE_PTR arrays into cipso_v4_doi_list. Reject
>    0-sized level or category tables before allocation.
> 2. In netlbl_cipsov4_remove_cb(), also inspect NETLBL_NLTYPE_ADDRSELECT
>    entries so IPv4 address-selected domain mappings referencing a removed
>    CIPSOv4 DOI are properly cleaned up.
> 3. In cipso_v4_delopt(), zero the trailing cipso_len bytes with IPOPT_END
>    after memmove() and pass opt->opt.optlen - cipso_len to
>    cipso_v4_get_actual_opt_len() so stale tail bytes are not re-parsed.
>=20
> Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integratio=
n")
> Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly =
in SELinux")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919215243.3472=
150-1-benquike@gmail.com?part=3D1

