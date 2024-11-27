Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8917591;
	Wed, 27 Nov 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707939; cv=none; b=B3l2YmYpMgy1i2PggxCNiX7nJOMsQNx6PRgzIjbqDG4fwqsgOHmZ3XfYVOCh7JgVTwMRobozpZyuf1Iz9nZY+WE9qrI3RgY7I6+UydZCEE8Cc8lLjGcJay/A8iPKEQxcJtiBEjir3FvOYfDTr6pK+u2u0JtEY3CnX0bS3oOD+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707939; c=relaxed/simple;
	bh=YsJim3X/59akWviqfsnVfzcGmh+By4dRga1zXN2BHMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IjSCAmJ8jDjip2QSHok/f7eNesIaFKZNFWtp7j8k0jz+1EEkyajdcHDnOkzvV3PiZapTi5Me1R5BXN+Jjwum9N1BK9bqx8mhogE0rR5KopLtMly2iSFSKBnmbUdGfQSJ2cZ1BOgXXnWvwQco6qmKzO4WLxyDozbbfg0fkmkasI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UMmasBpd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UMmasBpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732707919; x=1733312719; i=markus.elfring@web.de;
	bh=wsTkpJ0crrbiKCw//zEGB71MSjoQsz2INPw4o65ZODw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UMmasBpdiKjjnuub+miyWcxiisBtRmQsorQ9Q1IDBk1b/eLv69QnVXvMjUNLpKEH
	 C7r0hlGNMVj2hXu1PSnsJ6qPxbIIPnZi5ppqP0OhrbiLmdbHxehp1oUV1QxmPCgMo
	 RybkAQZG55e+YUx1ND9jzNg91n9zFegTh9aNzUt0ut3PuPzrnGMNmZL2F4ANnxiuO
	 oGRxiJUsJ7Po+V0yM386x6YQvbmfMamAX4BmH0Mj+kEigmxYlVBCPB8cHXGGEjGYN
	 gmnIjqpTGTljUizj9HUaB5eXzrZQU9jdcT01f07DyOhaqADT3blT+IDwuN3xMAvC2
	 4Rvcv07JRFLq3gH/Mg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOdp-1u0vBA07lv-00lKvI; Wed, 27
 Nov 2024 12:45:19 +0100
Message-ID: <056e599a-f1f3-4ef4-a0d9-04cbe99f198c@web.de>
Date: Wed, 27 Nov 2024 12:45:18 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder capable()
 calls
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c3z75ebXs5Vvec51bTijuBJ89sciEkl5vT69C//yxvbWjzQ69bj
 6b2xXMO5j383+Av9ioHLroYrBtP+7cR6EkqAx2WX1bE3Ek126hEo0YbN2n98AGKuHu9cSOo
 BD86XgkY7y10I1YH70J/WzQaFoKcwmbzZfhGYncJWBp7G2E9nseOmODgxfD175nBkJV+Fc4
 OhW4+0CaIDBMKrlezuo2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EERdwdgsqjs=;tQJriFa/CF00kg9HEyf9Jz2Xzfg
 GEbf7XRlswfFTo92k73LvwyyjuldmWapj2wOkdCfJDf2pQV7blO/e7Tn5Awo/9wDA0Or/awyB
 oaK1p8zNZtwoYgNo7K0eRRLW6+e0ZwyN0Dt3k9PTXbkFepcbh4pO3E6/57K21t9TbmYjXerZR
 Xr62/8itvY/6SN73rueLJZG1w9wSilsyzsTCB0Wb01KKtjYc0iBfmvIVv7y5DYPDmoJCnNV9x
 jFuknWRua9wRYshpPINz2iO8JZHco+c8kyptlQwC0Q+PEDhTjQz7BQwCigFt74ON8p4pR47F+
 RK2nV9Jlz5fGqrP1+yc0Vx79aSrCnsazHyf9IdzQMGieupwbvU25gpFA3mIUTlqebWR3RZxil
 eb+uPL0nGufuv4XbDM8+Xr+xnGG0QVO1jPoUXB6gT1uYYY5JfuIccYU7uJdfe41Qv2wT+EWWz
 Hc3tNJW4uXG4Yk8WcNFNUII8dNnDiJsoGPsRI39jy0mYwD23bTzZ0bxReQgg3pMYZaf1ILHzc
 JmTOM0aNg3dRpgRUPRAagNSUtEAuWkVlNhR6p6NQV9DRNygBxMZuiBf4XDZfVfPdx4Q+4C3vG
 7QNKo76SXHq0lzER7XVha1QnrshPRDVkOdJvHLq2MD+3MVQTejfZtKCXJbodEy/iJpIqB3Gr2
 5a+nfjF7+ObvnemK+Hht0BAXIyWcHck1bOLJPSqJszkGCRDibuLHAH1JY2dLkkT9yXFyzm3Ai
 CQJP3JUrkz5OR4YXaxKiZWPhUojq0J5KUUtyLnzBgldKe9U8rth+ryVwYfKpNaaiern4A6F6y
 tjNW2dbtuDHxT4x3UbdUvbeBg++TvD+dKc7KCJUfpbWrfWjjaipMxBokmqeE8CdsHy7hUH6fg
 mouxJv5LetFST1feBWxFScP+4rDUtbEwMAJh8o/OI3N07zJAnXGbNYwGT

=E2=80=A6
> +++ b/scripts/coccinelle/api/capable_order.cocci
=E2=80=A6
> +@ depends on patch@
> +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
=E2=80=A6
> +-  F@p(EL) op E
> ++  E op F(EL)
=E2=80=A6


You would like to reorder expression parts.
How do you think about to increase the precision for such
an SmPL change specification?

* May only operators be taken into account for which
  the commutative property holds?

* Would you like to support a varying length for the affected
  operator chain (=E2=89=A5 2 operands)?


Regards,
Markus
