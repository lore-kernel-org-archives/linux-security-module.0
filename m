Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A668F48;
	Wed, 26 Nov 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178018; cv=none; b=NT8/usosLmqB/ZLAaRwAKTa1ced+HqIRcjUeyY/7F7gFsGOipGI+sx0Zom8Ew9u8cqqbtcD+ln7XzjZ/vLBn/1q3uZ70iW/tsH/m2Wphe2rCITaass57hcEkn6V5Xcg7Q05iPYEAo47fMwWMg8DMDe4QB1WmdeUSG0jt811hJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178018; c=relaxed/simple;
	bh=/NeEx7MRlBM/17vZ0G6HKWUd0ZqZPBRi9xVQWjI1GD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OHW6dh1aAWpReXfTCLMfFw1ZOja9OafHfkkFkAQ69MUmyJlT5JdJmcs8Luvh6qQUWSvA8RiHiuPTdc+6u0w/F0CyK+Pb1qOn/RFeNqQKe00N5cq8JWD1FRQ0OtxS1Sr3fRnSERHXtOqocXrR4L8fhWDIfEXjYbX3VHy/3ZjS/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Sb2AU+iU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Sb2AU+iU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=SY5HCvTJvykBu+1rnX4LhTUEPrefpAqk5BUwRggKC/8=; t=1764178015;
	x=1764782815; b=Sb2AU+iUGAsSnR8L7LD1MFwIf01pEdDkLoAr2En5YZqLXE9nbzc6MmUwv3K/M
	5dJY5tQpAz8zSj9dpjBLnFXKUCjAnzTe8u7AS6F/6p00NmEJKlfUU2Dc7c0o141XvI1qLG0LafCR4
	0Q1lCgj6b0RanmEgQxvAciEfG6+NYCUmsJMGBMHuuuJn2Cefj+dgpwGfFGw9/42m/UjQq2ozBHHdm
	W4y9ChYb/NeUw08jubZddSqwuhe6z7oYPLXs7koAqOgINOapkMcJkpTyEUNZW292GymYPjP1LouLD
	ys29kdv9FkVi/0oFewYSoI6HSwIr/NGPvqzDQmJ/ELaG3iD5bg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vOJI4-00000002qgL-3rYf; Wed, 26 Nov 2025 18:26:52 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vOJI4-00000003SYo-2i6X; Wed, 26 Nov 2025 18:26:52 +0100
Message-ID: <85864bcfa48fe341c655ebcd4c7d53ae1e0c1d74.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, John
 Johansen <john.johansen@canonical.com>, david laight
 <david.laight@runbox.com>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Wed, 26 Nov 2025 18:26:51 +0100
In-Reply-To: <0d03ddb9-d01f-435e-a57c-fbea32844b66@gmx.de>
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
	 <78f1ff26f06c0e61d71c1a7f05a7c03c4ec03bef.camel@physik.fu-berlin.de>
	 <0d03ddb9-d01f-435e-a57c-fbea32844b66@gmx.de>
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

On Wed, 2025-11-26 at 17:58 +0100, Helge Deller wrote:
> On 11/26/25 17:16, John Paul Adrian Glaubitz wrote:
> > Hi Helge,
> >=20
> > On Wed, 2025-11-26 at 12:31 +0100, Helge Deller wrote:
> > > Like this (untested!) patch:
> > >=20
> > > [PATCH] apparmor: Optimize table creation from possibly unaligned mem=
ory
> > >=20
> > > Source blob may come from userspace and might be unaligned.
> > > Try to optize the copying process by avoiding unaligned memory access=
es.
> > >=20
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > >=20
> > > diff --git a/security/apparmor/include/match.h b/security/apparmor/in=
clude/match.h
> > > index 1fbe82f5021b..225df6495c84 100644
> > > --- a/security/apparmor/include/match.h
> > > +++ b/security/apparmor/include/match.h
> > > @@ -111,9 +111,14 @@ struct aa_dfa {
> > >   		typeof(LEN) __i; \
> > >   		TTYPE *__t =3D (TTYPE *) TABLE; \
> > >   		BTYPE *__b =3D (BTYPE *) BLOB; \
> > > -		for (__i =3D 0; __i < LEN; __i++) { \
> > > -			__t[__i] =3D NTOHX(__b[__i]); \
> > > -		} \
> > > +		BUILD_BUG_ON(sizeof(TTYPE) !=3D sizeof(BTYPE)); \
> > > +		/* copy to naturally aligned table address */ \
> > > +		memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> > > +		/* convert from big-endian if necessary */ \
> > > +		if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
> > > +			for (__i =3D 0; __i < LEN; __i++, __t++) { \
> > > +				*__t =3D NTOHX(*__t); \
> > > +			} \
> > >   	} while (0)
> > >  =20
> > >   static inline size_t table_size(size_t len, size_t el_size)
> >=20
> > So, is this patch supposed to replace all the other proposed patches?
>=20
> It just replaces the patch from John.
> But please test the v2 patch I sent instead...

OK, so we need your previous patch that I already tested and your v2 of Joh=
n's patch?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
