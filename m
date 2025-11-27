Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8E27FD5B;
	Thu, 27 Nov 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236633; cv=none; b=tBLpGKY6hRWXnP7/aVkJZgzMmu0rNb8E6DMWEZfdK4mtQU38eJ/FTnhK93whlyZelUTyjbA4lPHA0/zaU/HbL2784s/fxfwkzms/HEvkwJceuxcULoKqspHNu6EQnA3/OgSSeNRgjgQw50G8OWQlKL127XtynjbkNcXKtATuyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236633; c=relaxed/simple;
	bh=a1qtHw3JWF870YtUbOaSDyzYHiouP1W81shdNJE1slI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKnd4BVbV9E9bXD8qGM1ETmIBlHqPxEGygWR3/wURXKTJRYqzol8fg2qhv7j2hSPOaSuh2vnsKGbCChu8mGfTp5Bb7eIzJz6DrS/WCfcv4vkIC6MS9DpYHJlSRL7EyzSNU9X+KAMF9vhhbK6Y4r5nZfuaBxlP2TZjDYKPDBdoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Mtk2Tx3q; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Mtk2Tx3q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=AdX4qKkVkW6+sLO3CN5WYI3tQ8n47arC7Ub7yVZSTu4=; t=1764236629;
	x=1764841429; b=Mtk2Tx3qRtGA5K6ukcQ3bdU/rRSeqOWbVCJmQzjRY7Pmq5voQaUjZJJQgudsg
	DqFv1XO19XZ7DpUbqSIJR94lt0b47xLgfiM7T+QzG3mxs2n8vx/ltf86LYBpML/C4kd9yZKqcJ3W4
	1Y7mtZzDPWK81660pT9cD4Ah9561dy+XjoUzkwJEkqsxdh9Wgoeq9k49G9r5X4IsIbFmXsPjvI4+x
	YT2s/2qJpNY6M9LpJ6Y0gs0JayCr/Z8GyKZNbhc3w1cNKJMtrSE01qBnPWF01P76W36o8iLgxx6ZO
	yi2HfXHeSohWfu3hCoIpWglWYGDwwQvgNwhQnBEqEzdkNJEgag==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vOYXS-00000002b7W-3jNy; Thu, 27 Nov 2025 10:43:46 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vOYXS-00000001LGB-2k8m; Thu, 27 Nov 2025 10:43:46 +0100
Message-ID: <d5c3d7329b6727bae537b118449ca2d5ad70e50e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@kernel.org>, John Johansen
	 <john.johansen@canonical.com>
Cc: david laight <david.laight@runbox.com>, Helge Deller <deller@gmx.de>, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Thu, 27 Nov 2025 10:43:45 +0100
In-Reply-To: <6d80f9bc5fd6d91ed2451d140227b866d6273af4.camel@physik.fu-berlin.de>
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
	 <6d80f9bc5fd6d91ed2451d140227b866d6273af4.camel@physik.fu-berlin.de>
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


On Thu, 2025-11-27 at 10:25 +0100, John Paul Adrian Glaubitz wrote:
> Hi Helge,
>=20
> On Wed, 2025-11-26 at 21:15 +0100, Helge Deller wrote:
> > So, here is a (untested) v3:
> >=20
> >=20
> > [PATCH v3] apparmor: Optimize table creation from possibly unaligned me=
mory
> >=20
> > Source blob may come from userspace and might be unaligned.
> > Try to optize the copying process by avoiding unaligned memory accesses=
.
> >=20
> > Signed-off-by: Helge Deller <deller@gmx.de>
> >=20
> > diff --git a/security/apparmor/include/match.h b/security/apparmor/incl=
ude/match.h
> > index 1fbe82f5021b..19e72b3e8f49 100644
> > --- a/security/apparmor/include/match.h
> > +++ b/security/apparmor/include/match.h
> > @@ -104,16 +104,18 @@ struct aa_dfa {
> >  	struct table_header *tables[YYTD_ID_TSIZE];
> >  };
> > =20
> > -#define byte_to_byte(X) (X)
> > -
> >  #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
> >  	do { \
> >  		typeof(LEN) __i; \
> >  		TTYPE *__t =3D (TTYPE *) TABLE; \
> >  		BTYPE *__b =3D (BTYPE *) BLOB; \
> > -		for (__i =3D 0; __i < LEN; __i++) { \
> > -			__t[__i] =3D NTOHX(__b[__i]); \
> > -		} \
> > +		BUILD_BUG_ON(sizeof(TTYPE) !=3D sizeof(BTYPE)); \
> > +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
> > +			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> > +		else /* copy & convert convert from big-endian */ \
> > +			for (__i =3D 0; __i < LEN; __i++) { \
> > +				__t[__i] =3D NTOHX(&__b[__i]); \
> > +			} \
> >  	} while (0)
> > =20
> >  static inline size_t table_size(size_t len, size_t el_size)
> > diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > index c5a91600842a..1e32c8ba14ae 100644
> > --- a/security/apparmor/match.c
> > +++ b/security/apparmor/match.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/err.h>
> >  #include <linux/kref.h>
> > +#include <linux/unaligned.h>
> > =20
> >  #include "include/lib.h"
> >  #include "include/match.h"
> > @@ -66,14 +67,13 @@ static struct table_header *unpack_table(char *blob=
, size_t bsize)
> >  		table->td_flags =3D th.td_flags;
> >  		table->td_lolen =3D th.td_lolen;
> >  		if (th.td_flags =3D=3D YYTD_DATA8)
> > -			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> > -				     u8, u8, byte_to_byte);
> > +			memcpy(table->td_data, blob, th.td_lolen);
> >  		else if (th.td_flags =3D=3D YYTD_DATA16)
> >  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> > -				     u16, __be16, be16_to_cpu);
> > +				     u16, __be16, get_unaligned_be16);
> >  		else if (th.td_flags =3D=3D YYTD_DATA32)
> >  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> > -				     u32, __be32, be32_to_cpu);
> > +				     u32, __be32, get_unaligned_be32);
> >  		else
> >  			goto fail;
> >  		/* if table was vmalloced make sure the page tables are synced
>=20
> This one does not apply:
>=20
> glaubitz@node54:/data/home/glaubitz/linux> git am ../20251125_app_armor_u=
nalign_2nd.mbx
> Applying: apparmor unaligned memory fixes
> error: patch failed: security/apparmor/match.c:15
> error: security/apparmor/match.c: patch does not apply
> Patch failed at 0001 apparmor unaligned memory fixes
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> glaubitz@node54:/data/home/glaubitz/linux>

The patch alone applies, i.e without your previous patch, but it does not f=
ix the problem:

[   73.961582] Kernel unaligned access at TPC[8dabdc] aa_dfa_unpack+0x3c/0x=
6e0
[   74.053195] Kernel unaligned access at TPC[8dabec] aa_dfa_unpack+0x4c/0x=
6e0
[   74.144814] Kernel unaligned access at TPC[8dacd0] aa_dfa_unpack+0x130/0=
x6e0
[   74.237538] Kernel unaligned access at TPC[8dacd0] aa_dfa_unpack+0x130/0=
x6e0
[   74.330296] Kernel unaligned access at TPC[8dacd0] aa_dfa_unpack+0x130/0=
x6e0

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
