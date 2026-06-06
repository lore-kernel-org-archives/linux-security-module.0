Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D0286A4;
	Sat,  6 Jun 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780766361; cv=none; b=ofcJXCQlkAEzv5hKpRFtytW8OBLGDSS5bSRZFX+N/1cHYWTvJdK1jD8UtEoDuugGsW0d72TYlT2pWjnkx4Hm9zxEV78GqprcxC2zowplTEXuDhLXG1nq9y4JOxzQXYsGr1blOV5WGphQnT8V0oVdLC1yrYPt2pBTKOtgf4TXjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780766361; c=relaxed/simple;
	bh=1RDXp45No9ZkJjybuVCYN6tsxgzfb+nP3XDfP7AUCI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJfeJ9OgRXw9CTEQb2IIwfVoTH2C7mdrYUYz5Bo76vLTj7COCbIyVhIJ1yR8IdoQO7GLpgovT7ZJZnOnPwgDcw0Cwj3Tz2QLqgDHF8Ub+kvvqb41aEPxSWxmBLnLA1UqHnA0wRPS7LbYaDSUbSfMfcs4ywUWoXoD5Vvgah2SkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=PoIf1UAz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="PoIf1UAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1780766357; x=1781371157; i=len.bao@gmx.us;
	bh=mimo6ZtY2ifvXCNJbj351ldSbALwGxDBUAsitWhfdS8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PoIf1UAz1OAJNZPkRkLqYFmShF/6XudAAa1tcsgqS87K/XICI6YiGNDYpF6FRW6F
	 9ij+eUrelO9jmV702yYAXImjVgGr81k7wBLTpJod266NQ1nIKI0FmSsJbhWLCev5n
	 hXhEE9XLDM1tYGOuyzFtlMO2Vh8tCc0+fihhk1Nt4Q3hjSZEfHm4aErERJHzgRrOW
	 Lq9QQJDKEAOApW9sgGXxieWaAoalm4ttvr8vvcPZNckf741ynxYJkDd4Ot4rdnV8e
	 4UpMBUFm55x6IU8n2jtRVnQNIL2FH1lwc8pWVJ1kMup6EUpJEV7QDIoa5Cqiijfnf
	 bTdT+OTno7sV54k2VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof9F-1x3Lkz2uzZ-00c3Ee; Sat, 06
 Jun 2026 19:19:16 +0200
Date: Sat, 6 Jun 2026 17:18:53 +0000
From: Len Bao <len.bao@gmx.us>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>
Cc: Len Bao <len.bao@gmx.us>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: Constify 'nulldfa_src' and 'stacksplitdfa_src'
 arrays
Message-ID: <aiRWfQhfBBHqq3mK@ubuntu>
References: <20260524113412.48050-1-len.bao@gmx.us>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524113412.48050-1-len.bao@gmx.us>
X-Provags-ID: V03:K1:PbsmbGirY1Vbv65osjbuGK5tUjPqniYCecTsA/JTwL015YiPMwU
 ykhZWOLtZFosQnqW4eGT2OuUXlF3ZW6SQjk+6TZcq8Cr+2drZqYWtqkH6s6k3akltQXQpNo
 vcRgmw74ZLKqRofs6SohMBBWkESXulkI21hMr16ajj4zJywk096wnxQA7wVqby0xJnb314z
 xuCam2bQ8zSkB6NTvj8NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tpLtLi8+mbA=;2whOWzc0JcPZiS6ngYyGKUmFNwV
 8PUyXMF5bgOrNQTymRguJJ/015kqmjKxlDTKmQSTWW6evCtEyLi4F6Kq+Lb4Jr9XrwQIZBsHQ
 HuEU0n7PUK64o4Zphk+7n9jTao0VvujdGn3WRsj+SSOzialgWpxOzAHSq7kyYx447waxXAoB9
 KGAoiOYnprtEobl4ZMVbSn0zWgSk9VQaeynNs8OPrjnerIbxMJ8ra7a960t1H8mVLLCxVKJJN
 M0+Jl8LYk1PJdKuawgO28JLMl41qgxc/xdJf7jyrgyisAm5p37PLepUFwwZvUiGXy70en5PnQ
 rMneYNPs4tTF+DCHvZ2rJLlB1+Py8kPABuOHO8RTRthz8TGafQmY8czk7L0Rq9lI4cKGqFyn7
 9CJQ2NGggA7yy8aYeRX02GFTabErpDLQM6zIuCjcRmch/BuEm3VehRyjj9njtLTc8KrXu2FYR
 PYaD+9YaxHR0fCvLoxPI5lzgguDDQKgPX+nPqIE9l4MlS5EBMh5DNMZgLkwDTLoWdXSL07yZZ
 Z0AUy14ak3VVsrVtiQ701nKIgYyArs4PPzNctWbAypQ9WheFoYgs45mSoxeaKj/Pc8cYIa5RD
 U/7wzUeZkeO1Z5350fWc3dGl9xSOxha11OS+Du/lAUE6Gb7ftCnRCr/GyU1PKr6VdKQnutjfD
 sjXeDT30oPsxouTiC1IofD672oFWRM9JGkYyNs0/i1A036x0cd1br1N9ZWBvYyM8VfcIlA8iu
 wdSw8lAoRqtIhXhWuJMdzCYBumGH44V9Gtxt8HBxroJ16JuPbKl0uqZKjEi6zBKWJs63gkP+a
 MlYrle7CcH6VIaFQzEcYTsUc11Y3th6UloEi3v9DxWervgCTODWsCvXC5ashBwxUd8H3LGmBC
 GJc1kC0mp6o/3rPeH3DfQX7rpJiEXVwIT01CmPd+fK+3bPJ3WyDlNl+w9HmRywd3jfFrwTsW6
 I0T33PI68tQciQFWYM306Lc8q8F0ZDNaqK/GyofdEcxeBJt0RECC7Pm1CAeZzEUNMS9OLg3Og
 kYiEOHtUa0TytdHhcFLPqyUd4b+DFQsHFvZ2ZZxb105mAkXiQh7f7/WwFnaMQ6Z1szjKSI8Tw
 6PjeUOf8sR3XXiNCAtkKcWFnXnQyjTRO9VDTdznjABdKnGJoozglADLg+5sOpb93dXD4NY2VO
 6eqCZJ+tlfPBDVHo367jGbShrHdBEa1DelFTj83OIQW1py1Gtj6uK3n55LGj7WxHtnleBmIGL
 6H2tWzcZOJbVQ09OG5GtOdjfgJ3UKGuRW9CteT/eDU3YiAogOjxm0xT64bjUwWtI2qdv9QNeJ
 GXvRJLOOm/inEb2hzEbh0Tdqc97FNMT6fujVU+C9V4tufRoTbtFfJ5VyoLom2KbGlGH8IqMGo
 17SFowxaWsTWKsuxIk1dZpbZ3ope2+Lu5PX8WmRPUGp5Cq/nVdaZ9sdBa5ptONKeS4QWxHWII
 FZCCDSogButMQO3fAJ4W7N0qJmdxRW+PHhOTb/FcP9fOlbPKrP0E9Xlj4nv8jhVNVzdYLvynj
 dkafqgGfDF5xdZfWT0tTFAio2cwNjm55L5J2X2wgwGVks60RM9Ey/kbKKT/Xq6gXyTUY6Megv
 FaB5qLuNxoXz2Z/sPmck7Eq2RSQm9H7yUjln4CSyBfyFKuO1RHRzwx00m/2jydIiRQqLhUPxh
 H2M90+bFcEwTPP+Bp6shvGPArqG1ejyBTTU/xLRRDqfTXMRBKYOz6Gd6kmCTkCODxYvw1L05a
 OS5yy9m4urEQ9NjmJXogMOvzC+N5yp3pIU+IFvjSJpkGX2sRlfhUgqQGhtc29OHwVKkqti4KK
 y8DcvomTeDEOqU+obgNBOp5q705sdjygLJocUpK2KOOH3HIV91wiXN4sybg9ISA+bknGryqez
 47rxi2cqt8xNR91/vH+Z63JSl7kvx3b44JGhRbYhLoFUEUJmpJrtAC2CsRP/dZ+u0F14kWl5l
 rta53EHFGZ7kgSfqU0YYCVDn0J44andTfIeYsSoXsWHIg9kWNyFCPlKEI8/wDobnUU5FtGmJN
 jiuvXVzRV+d+Rb7ngpR6Oj+oVAFY17DhOB/ZATLNx/07niXImkBefegBtSEPzQcPAiHwYfc/8
 l1zDQJbUQRdFyb0q+IYnv9BPUtikpaqRRmRIc9tcl7tLP4dvnwGUUK3MrbORnmnIKh2cvyPTf
 0uP2OO45ct6+IDTTrOkTCbfNbPcDtACA2bJMkSArgjdEP2Wu8gigm04GtRVIF9/aGwX//tg+P
 Q9TYVegfhlhfG6/3cYgklU5Lz+8Rgr8TJqEtEVdGVi+Rag6LVmhJkQKcRaP6h0dSD6OwIumPY
 KloKxCd0wB2YA1qjMeputz/rFtgUfk3NzGYH0EzZO0axPL3s65M0W3X3ifNSnPVNzDNSnRiqE
 7zcXE6yUTxrYygQjaMyXq8URPmQQTDkBm4fOmSeFRXQNGV5oAnByi9HmV7sG1kpNS640t4nrM
 7vi8vaTRIa8luOqry1leGUD310O3/ptWZFGFK9Sz0tQ62IpYaH+PbiBOXa0mAFyA9q5SnYeNT
 B/Ua4txpUwhz1CYNNWc53mE4sdE5eeHMTbME7Q8Zo9wVCEz7LwTy/WycNNiz2TDAOUjnkgji3
 XLbNwRaBQ169/zQHpB5kJGBCzYYcoPl1NS40VqtqxZF4J0PrV3gSQo1Uf8i60sDNyoqqsBHX/
 8CtSS0fdlsltkrogFjQSQZncGMFBk1eyG/exTOMrT7qyXpuvz70tis3HVNWfnRIgqHxaKUCvd
 H4cmFnO9CG/yP5M0AVO0y8lSG8mV9NxLKj0JTgKjBZUG3NuVIoo4+QFEmnUYSgzPrpfu0UpYV
 iLPH8xW6neKo8XsYzBZDx6TLZ5IJhlaSmMzmMnkKzH8ajcG43LrJ1y3AzXlForrEdqFQcotsQ
 88ZDG9wOxwNPaxPcCrsy/xcR/QZL1fUPqcTyOOPZ8lTjX4xy040mvbIZuldFLPdcu10g5rGd4
 Ky1m63w6F1TkpQNwP6UtADJUxs9TEqMgtxV6sPByJe6o5oQGU4ncMNugVXdc5Nk7cRDjE9pCo
 dYRts9VLRvJBz54jIYrfRM0cJqY+DWhBjlByQKkdrnuCBjFgk6pBltJQdg8gXgPnF1lvH4ftj
 i7tFv8eJ6BkaXUIFTvwR4wwF9T2lV2ozY3vLXC8S4Ko1VJO899WQ9twQ6t9nPTJlRRo3Yhuft
 PZCnFfKr8vGMCYbsg6l+BCXJ0qyuoCYNlbHKH5OMbFR4jvyGl9QNqvE2ndQRp30e37U1+rIY3
 fAvdD5WBGrzqdfrAP3g4EHjRu3okCi5wCb4Ub3a0pVkIMlcHS033TWlSN+uBPQPJpHPm2jFYC
 ikUML4QN2ZQaArklPik1Nneo3viaXSmYQCG8wpS9e4/ri1GoLp9vPfo6b8nc2XxN7uCNMW4W7
 PY0GUhaJW9JXMGPjGPmvqghSEuuVCHuUCq4yEW2pZXLe25RC1gK0WebBdq8tHyjZ2JPC8aB1s
 xtvSLnh5XDznvzDt5vZoJjXQ1zUI1B8BXoTUqZr+uG/EPI3ML9LhWC06egjtoc5Kj/Y9n/Sdv
 DbAYSR39wOVl1uF3Cpv7NzovE8XpHZApBKo8impdHqkQ5rg+XsC4B6o8/016lnjO+f/zXZJ4Y
 TyligLg3Fh7EZNPgXH6hthyq6QzAaMUnGFij11TiGgFdZRNuZpsUkNVzpQf8j28sZaO6VMAqS
 6iJYjYXfGxVK+iCdam6Wc/ZbIzVuFySFWc8C9AK5Cekm3b0kNkEIgVAlDpJSKfScJJlWL12yN
 corlqEXBgMUfpCIfRUjCGSQ4p1pctWT4cb4RfNlcstlRGqy8BZuAl2SwtIgLFXMH+Tavepw2t
 UxpLuFpquQXiOJmdUI/p4bXj8OcC9vYwgCZC4+TulbiGjcYxyIMSqJPXIvIembYiDqLy31Lkh
 XOotXZ/OgFXpGrFTVqNmwzg1GGURQ7JavnMM4ks+W5dsUzDIzfSzhATHyrJRSKNSo+tZyzXO5
 OF56FyBDRTLWGxJqvmL0PKQakWMUnDCbYIls8amLJH8p2xTjiSNESo93ScwGMmVkMevKoNe6w
 6woyb8Q9Q7EDkT1OV+hqbdi15L3qkQ1xJpg6iTcEa+3c0FwjVRIYF7teEPSUuFEbJH7eV22jZ
 Jd7ggE9Dvis/EtL4OBTRbFJejuqAevv6jTNoy33lzE6Cx4IGF6eUtRYK3dhSYlUbUv772MAMT
 OjvSGKlzAqsawNJ7kgKaabpSnDEulObLesFdFgSAbw6Ll1XzTEOwFxR4gefG9SeeF07/HJJrX
 +Vq63c35939LLDhHeybxGWNnf8Dz8m6V37B1vLBmEVrMouCAWjl0jdPnkH/0EXbaw+ezz9FtL
 WQ8zGFgPJS0xm0UxTK1bnyD8SUqPzChI7o3wl4YDmuh8xu6TNzfFXexUThMQ3E/N16Mii9xQx
 CbS6Y4080sfIvfb1he+mVjgb8F2dpcvLgv91HUZDeQCJQekkck1GBihiC6PQPBXveVr60OaIO
 bSBpQ1/OHCAamhk6AYgoS07RY6wZR3cBrFVMdlV+4nZisqYaWTrhO8cdiop3B+IJKyC9Ie7tu
 UPdzTJsB2Jr53im+mSJygl+mXTX4OTdBRYAyI9Wd5zR5qI2vtxNv20CzettPkw7SnNlZ/jCbs
 m2KG3vXAMmmNPJzgeagyJZGnVfiD44PPwlzdKGUOqsHyVP15wTl2cuIS/TkL6k4LG/cfofXrl
 smx8L6I8gm0PJh08s5wOzEOlKDMr0CCtuemxZbb6yniySHLZTiifQJiN98ECqXq4kbxAoRCJu
 rT7WQ6O0MPGpjEvEN13WeJq4Zvaa08ciN/1ydReqZeSBKq2eMCoWKSIVtn/cGvcV5y99M9Myf
 V0yVBwUWoo9pSh/fIhxLn2qpUjFM+DH2/8uEKJzSoTZbHbEOm47i6U23Jgm9xSNmhoDdHLLEI
 z+XMBBvrkS+LorwzM5ZHzrKzKsbcJK28v8ohnZk/AsnJ+3iqGGQtzPGuQd5LiHzhdqiqz/Jqj
 DdJONBc1Fgz04fhurCBzuwMhYtlflE6Z/3k6R87VHq81qb2spyTwwVJOWhgZRi25bvicGgwp7
 W0n12xaS1ppT2MPtRdZE2OMtUR9G6AZHSPrfvZEPhwoGh4u66YpKjU214x7O7VIpfA8KJit+Q
 PKPFkAa22ZTxcdrsAL50LDkCrBhSqYxrdnfYeDcVUgPXozIfZB78mc4vr8ZVZ2wfMvRpMujFQ
 WXW11Zfu67bb0tOFsik9pr9Zcy+XnZ/4jWOoYMdI7gok1fX+9PDqNPqX5VSAYso4h3FUQ2Gu3
 BZMMVjjSkVUbXhK14Xmn+ampMnHRjXpMpkKJAH4bYm0GiBVQ3sFlFlxdBoImC+go5JnpsVikc
 wOpMRIckJ0ujYo4N/Cm0QmlRY7f9iqVdYWl0OgL5GpcP1+98YF6pS4NhEjUKA32SNyIfS1MSL
 UuNsdbZXMkEevm+eYkFU8vXK6i9RI5uyE/NurBrKJdm/A=
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 24, 2026 at 11:34:11AM +0000, Len Bao wrote:
> The 'nulldfa_src' and 'stacksplitdfa_src' arrays are initialized in
> their declarations and never changed. So, constify them to reduce the
> attack surface.
>=20
> To make this possible, it is also necessary to change the 'unpack_table'
> and 'aa_dfa_unpack' function prototypes to pass, as a first argument, a
> pointer to a 'const' blob. At the same type, define the blob exact
> pointer type (pointer to const char) since all the calls to the
> mentioned functions use this same type.
>=20
> Before the patch (size lsm.o):
>=20
>   text	   data	    bss	    dec	    hex
> 128768	  28028	    704	 157500	  2673c
>=20
> After the patch (size lsm.o):
>=20
>   text	   data	    bss	    dec	    hex
> 131264	  25532	    704	 157500	  2673c
>=20
> Signed-off-by: Len Bao <len.bao@gmx.us>
> ---

Friendly ping.
Any comments are welcome.

Regards,
Len

>  security/apparmor/include/match.h | 2 +-
>  security/apparmor/lsm.c           | 4 ++--
>  security/apparmor/match.c         | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/apparmor/include/match.h b/security/apparmor/inclu=
de/match.h
> index 7accb1c39..4a92cd044 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h
> @@ -125,7 +125,7 @@ static inline size_t table_size(size_t len, size_t e=
l_size)
> =20
>  #define aa_state_t unsigned int
> =20
> -struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags);
> +struct aa_dfa *aa_dfa_unpack(const char *blob, size_t size, int flags);
>  aa_state_t aa_dfa_match_len(struct aa_dfa *dfa, aa_state_t start,
>  			    const char *str, int len);
>  aa_state_t aa_dfa_match(struct aa_dfa *dfa, aa_state_t start,
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 3491e9f60..3f995b6a7 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2432,12 +2432,12 @@ static int __init apparmor_nf_ip_init(void)
>  }
>  #endif
> =20
> -static char nulldfa_src[] __aligned(8) =3D {
> +static const char nulldfa_src[] __aligned(8) =3D {
>  	#include "nulldfa.in"
>  };
>  static struct aa_dfa *nulldfa;
> =20
> -static char stacksplitdfa_src[] __aligned(8) =3D {
> +static const char stacksplitdfa_src[] __aligned(8) =3D {
>  	#include "stacksplitdfa.in"
>  };
>  struct aa_dfa *stacksplitdfa;
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 3a2c6cf02..c6f7bea1e 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -31,7 +31,7 @@
>   *
>   * NOTE: must be freed by kvfree (not kfree)
>   */
> -static struct table_header *unpack_table(char *blob, size_t bsize)
> +static struct table_header *unpack_table(const char *blob, size_t bsize=
)
>  {
>  	struct table_header *table =3D NULL;
>  	struct table_header th;
> @@ -311,11 +311,11 @@ static struct table_header *remap_data16_to_data32=
(struct table_header *old)
>   *
>   * Returns: an unpacked dfa ready for matching or ERR_PTR on failure
>   */
> -struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
> +struct aa_dfa *aa_dfa_unpack(const char *blob, size_t size, int flags)
>  {
>  	int hsize;
>  	int error =3D -ENOMEM;
> -	char *data =3D blob;
> +	const char *data =3D blob;
>  	struct table_header *table =3D NULL;
>  	struct aa_dfa *dfa =3D kzalloc_obj(struct aa_dfa);
>  	if (!dfa)
> --=20
> 2.43.0
>=20
