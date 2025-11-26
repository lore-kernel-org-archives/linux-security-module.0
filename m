Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51633DEFB;
	Wed, 26 Nov 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173818; cv=none; b=Yb9zxUjlyKruCGwdU277JXC7TP+tU0xg6k8rGtKNbmhnuYxszltBrb5ZUfc8Yr7k26rxglNL1ExkMQJGIL6rydBUyW2Bsn06I/yrnpNj4ITd4qN8YWDSeYKNBXprA46Kt0c1wFyGGHdzZSNRzHw0oXQBH2wpl9LtaAZuJDjyUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173818; c=relaxed/simple;
	bh=d6VNhLTe1+Oa92Zbu01t/4n0Ts7L/x84LlI2FKV34n4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZc74L2OhyFKGXSMIzmUCW+ojOZjMQAjPNmGE2TLk05lJ/w19m6bYgBXZNMzuPnwqc6fbZpSu4H2efIoPNQpWrSlK1TtdXpTgAYsjdrnNS7mDM3xcYqbTDU3+B3FbA4dmtbV2fB81VL9DX37Vi0vdXnk+rxv65zZO1qpQyvFf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=NNp61llQ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="NNp61llQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Gg5/D68mHg67K6ACJ/qySf1Tuf5DCYbgvIMuPbJ81jA=; t=1764173815;
	x=1764778615; b=NNp61llQJXmVcnB18DmfKEaixczruOBSZ22opegkR4LNJWKXJ+pwakcpyTYGE
	9++NeeHi9+MAcvwBhGnt6KmvcmrShgclvZXIS6wNE5PWbyN8zkA9joBb/SAIJKFZS0sox2kOzTDFa
	ba79ImGbVJc29sSm15EY1uI5c0wnK+bo7CD4GrXwPSjdO+zGv1V9xnVYuYDKqCKfKBwEdONrQCart
	8Go3B4mv0ltHJtCZfwbZ9spLYddkYXUP6siV+cegjo1yaJyL17UMp64R0p6QkprACjJFgiPFJ5JEk
	TsEmeD8+I/iNfvAY1NhmXZKyYyZYgtRTJnjHl0L6tz6cPhi5BQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vOICL-00000002PRw-0ZHl; Wed, 26 Nov 2025 17:16:53 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vOICK-00000003I3Z-3pko; Wed, 26 Nov 2025 17:16:53 +0100
Message-ID: <78f1ff26f06c0e61d71c1a7f05a7c03c4ec03bef.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@kernel.org>, John Johansen
	 <john.johansen@canonical.com>, david laight <david.laight@runbox.com>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Wed, 26 Nov 2025 17:16:52 +0100
In-Reply-To: <aSblGNyoSV4LfKji@carbonx1>
References: <aRxT78fdN5v2Ajyl@p100>
	 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
	 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
	 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
	 <aSXHCyH_rS-c5BgP@p100>
	 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
	 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
	 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
	 <20251126104444.29002552@pumpkin>
	 <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de> <aSblGNyoSV4LfKji@carbonx1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Helge,

On Wed, 2025-11-26 at 12:31 +0100, Helge Deller wrote:
> Like this (untested!) patch:
>=20
> [PATCH] apparmor: Optimize table creation from possibly unaligned memory
>=20
> Source blob may come from userspace and might be unaligned.
> Try to optize the copying process by avoiding unaligned memory accesses.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> diff --git a/security/apparmor/include/match.h b/security/apparmor/includ=
e/match.h
> index 1fbe82f5021b..225df6495c84 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h
> @@ -111,9 +111,14 @@ struct aa_dfa {
>  		typeof(LEN) __i; \
>  		TTYPE *__t =3D (TTYPE *) TABLE; \
>  		BTYPE *__b =3D (BTYPE *) BLOB; \
> -		for (__i =3D 0; __i < LEN; __i++) { \
> -			__t[__i] =3D NTOHX(__b[__i]); \
> -		} \
> +		BUILD_BUG_ON(sizeof(TTYPE) !=3D sizeof(BTYPE)); \
> +		/* copy to naturally aligned table address */ \
> +		memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> +		/* convert from big-endian if necessary */ \
> +		if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
> +			for (__i =3D 0; __i < LEN; __i++, __t++) { \
> +				*__t =3D NTOHX(*__t); \
> +			} \
>  	} while (0)
> =20
>  static inline size_t table_size(size_t len, size_t el_size)

So, is this patch supposed to replace all the other proposed patches?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
