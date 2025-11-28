Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC943054D4;
	Fri, 28 Nov 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323683; cv=none; b=YZxyZxZpN3uoB835BqoETAk5ahZcsRPYHgzMh+DFuw5nuXwOxFFz6czoT93kA6tUSb/5KLawOebRQkH7/jb+5+y8WUXZQdocI3O40ONYAUMlN34+x8wf2pVAtQ9Xk6um2bVyB+9FlNVVM04XMFUrGsnWaw9Bmm9DLw6hdNI60AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323683; c=relaxed/simple;
	bh=pvNgC4bN8pJNA11BlEE8YSd6c5vQKkgmo21pTKF3sK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bjye0J/Rmmzfr596B1kLX3cY8adKGUNUV6E4OZbBiWR5ODLNYHyBMuLjlfKkK/YNibLVMuSNO6ZEG1zc29W3rr1SUMmiOj3o4h89++lVIfp4gfkT6CQsOF0NMUQDoSu+4kVNfMm0aKWZvWdSJrmNRJE0aop3pW0TVHFiQMNSDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Wd4tpyKf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Wd4tpyKf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=znKwaoS12heTTIaC8HIQotcIgnIoXFFh5BL229hmjIw=; t=1764323680;
	x=1764928480; b=Wd4tpyKfcZxBBvuawgUW7BQ3sxUU8ztBOcDY8lob7mixNTkBobI8EGnmhyrRD
	aMpU97BFINpa5IktlBuyHaELSUUa3Dw06N5uhS1CCKHLRC2u529OHIPQ9nATAF2PTWHLQNiEkRyAY
	oCOpAlk2KvlSts4t/vjWrl/sRZZiWVUX1JPkojkfYzYS8vxbM+lGlv8HqKyqifWhXHPURU7ssxoKH
	Pdsk4ukAzTbv7wTEBXg02eD2fzYx7PDZkXviHDLnO1kldA5p+A1pqsvev5GyEbyjiaCSWJ9Ehzcm2
	X7khlt8utoOhxLj0aPAEuwauzSlPTVuw7rNUviTJ9HuOe3Y09g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vOvBQ-00000002G4E-1km8; Fri, 28 Nov 2025 10:54:32 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vOvBQ-00000003NTO-0lOp; Fri, 28 Nov 2025 10:54:32 +0100
Message-ID: <8485bdec75a0584ae765a45eea4828ca5a5a49d1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@kernel.org>, John Johansen
	 <john.johansen@canonical.com>
Cc: david laight <david.laight@runbox.com>, Helge Deller <deller@gmx.de>, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Fri, 28 Nov 2025 10:54:31 +0100
In-Reply-To: <aSdfyGv2T88T5FEu@carbonx1>
References: <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
	 <aSXHCyH_rS-c5BgP@p100>
	 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
	 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
	 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
	 <20251126104444.29002552@pumpkin>
	 <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
	 <20251126142201.27e23076@pumpkin> <aScY13MEBATreotz@carbonx1>
	 <f5637038-9661-47fe-ba69-e461760ac975@canonical.com>
	 <aSdfyGv2T88T5FEu@carbonx1>
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

On Wed, 2025-11-26 at 21:15 +0100, Helge Deller wrote:
> * John Johansen <john.johansen@canonical.com>:
> > On 11/26/25 07:12, Helge Deller wrote:
> > > * david laight <david.laight@runbox.com>:
> > > > On Wed, 26 Nov 2025 12:03:03 +0100
> > > > Helge Deller <deller@gmx.de> wrote:
> > > >=20
> > > > > On 11/26/25 11:44, david laight wrote:
> > > > ...
> > > > > > > diff --git a/security/apparmor/match.c b/security/apparmor/ma=
tch.c
> > > > > > > index 26e82ba879d44..3dcc342337aca 100644
> > > > > > > --- a/security/apparmor/match.c
> > > > > > > +++ b/security/apparmor/match.c
> > > > > > > @@ -71,10 +71,10 @@ static struct table_header *unpack_table(=
char *blob, size_t bsize)
> > > > > > >     				     u8, u8, byte_to_byte);
> > > > > >=20
> > > > > > Is that that just memcpy() ?
> > > > >=20
> > > > > No, it's memcpy() only on big-endian machines.
> > > >=20
> > > > You've misread the quoting...
> > > > The 'data8' case that was only half there is a memcpy().
> > > >=20
> > > > > On little-endian machines it converts from big-endian
> > > > > 16/32-bit ints to little-endian 16/32-bit ints.
> > > > >=20
> > > > > But I see some potential for optimization here:
> > > > > a) on big-endian machines just use memcpy()
> > > >=20
> > > > true
> > > >=20
> > > > > b) on little-endian machines use memcpy() to copy from possibly-u=
naligned
> > > > >      memory to then known-to-be-aligned destination. Then use a l=
oop with
> > > > >      be32_to_cpu() instead of get_unaligned_xx() as it's faster.
> > > >=20
> > > > There is a function that does a loop byteswap of a buffer - no reas=
on
> > > > to re-invent it.
> > >=20
> > > I assumed there must be something, but I did not see it. Which one?
> > >=20
> > > > But I doubt it is always (if ever) faster to do a copy and then byt=
eswap.
> > > > The loop control and extra memory accesses kill performance.
> > >=20
> > > Yes, you are probably right.
> > >=20
> > > > Not that I've seen a fast get_unaligned() - I don't think gcc or cl=
ang
> > > > generate optimal code - For LE I think it is something like:
> > > > 	low =3D *(addr & ~3);
> > > > 	high =3D *((addr + 3) & ~3);
> > > > 	shift =3D (addr & 3) * 8;
> > > > 	value =3D low << shift | high >> (32 - shift);
> > > > Note that it is only 2 aligned memory reads - even for 64bit.
> > >=20
> > > Ok, then maybe we should keep it simple like this patch:
> > >=20
> > > [PATCH v2] apparmor: Optimize table creation from possibly unaligned =
memory
> > >=20
> > > Source blob may come from userspace and might be unaligned.
> > > Try to optize the copying process by avoiding unaligned memory access=
es.
> > >=20
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > >=20
> > > diff --git a/security/apparmor/include/match.h b/security/apparmor/in=
clude/match.h
> > > index 1fbe82f5021b..386da2023d50 100644
> > > --- a/security/apparmor/include/match.h
> > > +++ b/security/apparmor/include/match.h
> > > @@ -104,16 +104,20 @@ struct aa_dfa {
> > >   	struct table_header *tables[YYTD_ID_TSIZE];
> > >   };
> > > -#define byte_to_byte(X) (X)
> > > +#define byte_to_byte(X) (*(X))
> > >   #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
> > >   	do { \
> > >   		typeof(LEN) __i; \
> > >   		TTYPE *__t =3D (TTYPE *) TABLE; \
> > >   		BTYPE *__b =3D (BTYPE *) BLOB; \
> > > -		for (__i =3D 0; __i < LEN; __i++) { \
> > > -			__t[__i] =3D NTOHX(__b[__i]); \
> > > -		} \
> > > +		BUILD_BUG_ON(sizeof(TTYPE) !=3D sizeof(BTYPE)); \
> > > +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || sizeof(BTYPE) =3D=3D 1) \
> > > +			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> > > +		else /* copy & convert convert from big-endian */ \
> > > +			for (__i =3D 0; __i < LEN; __i++) { \
> > > +				__t[__i] =3D NTOHX(&__b[__i]); \
> > > +			} \
> > >   	} while (0)
> > >   static inline size_t table_size(size_t len, size_t el_size)
> > > diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > > index c5a91600842a..13e2f6873329 100644
> > > --- a/security/apparmor/match.c
> > > +++ b/security/apparmor/match.c
> > > @@ -15,6 +15,7 @@
> > >   #include <linux/vmalloc.h>
> > >   #include <linux/err.h>
> > >   #include <linux/kref.h>
> > > +#include <linux/unaligned.h>
> > >   #include "include/lib.h"
> > >   #include "include/match.h"
> > > @@ -70,10 +71,10 @@ static struct table_header *unpack_table(char *bl=
ob, size_t bsize)
> > >   				     u8, u8, byte_to_byte);
> > >   		else if (th.td_flags =3D=3D YYTD_DATA16)
> > >   			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> > > -				     u16, __be16, be16_to_cpu);
> > > +				     u16, __be16, get_unaligned_be16);
> > >   		else if (th.td_flags =3D=3D YYTD_DATA32)
> > >   			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> > > -				     u32, __be32, be32_to_cpu);
> > > +				     u32, __be32, get_unaligned_be32);
> > >   		else
> > >   			goto fail;
> > >   		/* if table was vmalloced make sure the page tables are synced
> >=20
> > I think we can make one more tweak, in just not using UNPACK_ARRAY at a=
ll for the byte case
> > ie.
> >=20
> > diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > index 26e82ba879d44..389202560675c 100644
> > --- a/security/apparmor/match.c
> > +++ b/security/apparmor/match.c
> > @@ -67,8 +67,7 @@ static struct table_header *unpack_table(char *blob, =
size_t bsize)
> >  		table->td_flags =3D th.td_flags;
> >  		table->td_lolen =3D th.td_lolen;
> >  		if (th.td_flags =3D=3D YYTD_DATA8)
> > -			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> > -				     u8, u8, byte_to_byte);
> > +			memcp(table->td_data, blob, th.td_lolen);
>=20
> True.
> Then byte_to_byte() can go away in match.h as well.
> So, here is a (untested) v3:
>=20
>=20
> [PATCH v3] apparmor: Optimize table creation from possibly unaligned memo=
ry
>=20
> Source blob may come from userspace and might be unaligned.
> Try to optize the copying process by avoiding unaligned memory accesses.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> diff --git a/security/apparmor/include/match.h b/security/apparmor/includ=
e/match.h
> index 1fbe82f5021b..19e72b3e8f49 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h
> @@ -104,16 +104,18 @@ struct aa_dfa {
>  	struct table_header *tables[YYTD_ID_TSIZE];
>  };
> =20
> -#define byte_to_byte(X) (X)
> -
>  #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
>  	do { \
>  		typeof(LEN) __i; \
>  		TTYPE *__t =3D (TTYPE *) TABLE; \
>  		BTYPE *__b =3D (BTYPE *) BLOB; \
> -		for (__i =3D 0; __i < LEN; __i++) { \
> -			__t[__i] =3D NTOHX(__b[__i]); \
> -		} \
> +		BUILD_BUG_ON(sizeof(TTYPE) !=3D sizeof(BTYPE)); \
> +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
> +			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> +		else /* copy & convert convert from big-endian */ \
> +			for (__i =3D 0; __i < LEN; __i++) { \
> +				__t[__i] =3D NTOHX(&__b[__i]); \
> +			} \
>  	} while (0)
> =20
>  static inline size_t table_size(size_t len, size_t el_size)
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index c5a91600842a..1e32c8ba14ae 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -15,6 +15,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/err.h>
>  #include <linux/kref.h>
> +#include <linux/unaligned.h>
> =20
>  #include "include/lib.h"
>  #include "include/match.h"
> @@ -66,14 +67,13 @@ static struct table_header *unpack_table(char *blob, =
size_t bsize)
>  		table->td_flags =3D th.td_flags;
>  		table->td_lolen =3D th.td_lolen;
>  		if (th.td_flags =3D=3D YYTD_DATA8)
> -			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u8, u8, byte_to_byte);
> +			memcpy(table->td_data, blob, th.td_lolen);
>  		else if (th.td_flags =3D=3D YYTD_DATA16)
>  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u16, __be16, be16_to_cpu);
> +				     u16, __be16, get_unaligned_be16);
>  		else if (th.td_flags =3D=3D YYTD_DATA32)
>  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u32, __be32, be32_to_cpu);
> +				     u32, __be32, get_unaligned_be32);
>  		else
>  			goto fail;
>  		/* if table was vmalloced make sure the page tables are synced

I have applied both patches, the latter required minimal rework, and I conf=
irm the issue is gone.

Could you post a cleaned up series with both patches so I can add my Tested=
-by?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
