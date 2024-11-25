Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD9EACE;
	Mon, 25 Nov 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556931; cv=none; b=EUoe8y1u8E93ImjT0rRG/h/Te2KUi/oIXvtzdpbj2MasgpqGNp0cSNB1gwnrgkDxg5lRKXTSA3QNlNSkfCrKLr7xg3JP66rDXE+E03zPrbPldUlLCJrV52CxRheXtsKrGAFdVcbZ8KKDLoWQSPecIk4eGpr7tRnpfhDS+JVK90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556931; c=relaxed/simple;
	bh=QU8g5W7ycN5999cNHJxmTMpGkTWfIsiOVebqkoN6bxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AGXEKCFA1liXY6FjE66dA/nYuGFNDbDaeZC9bCR5b8fK/s7RqlSaLc6QQS6axhLvx9MDjvAjXqwqrmeKheRyLuNm3Fa2OizJQivVqf11yUgFRSsVGpEZptPRggMOTzxqLVVWtu8DhqHzOHUkZAPDhx1Y9iyO8MqY4n5k48byq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TJgNoJI2; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TJgNoJI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732556901; x=1733161701; i=markus.elfring@web.de;
	bh=Mw4IHOf7vuSM3IgbSeZEcpM211mmeelhIoAZ1bfoszw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TJgNoJI2MYd5w1uysLg9IeyY7WEVw14PC7DqSzFVM5ma3TQOFvgpqyYK1WC8THT3
	 +muG8P3Pjhx+iSgWtwkuUbrr0N3UT0u7Df1d5Su9sSg9JtxhfvGmir41BH/f4YHz6
	 7zKOb/vsCru1fcioIkrd68KRekdgMCKbPsHTM+2TBLkzHYfv1hMjSugyZw4+Mdbgd
	 yosrduCBEStPRRIQy/dhBS4QUBoenDjZvhNRkirz5/mvuME7gmYbVRXLqApjtXHhr
	 fgQFHrKnlYu+OTi7oH7ugVDa0KW9p3GM54pJDYc4s6bnkZp8N2L6TihPyQ6KxPKgk
	 VjSTUOC+o7dBXB03+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWi5s-1tDRJl1N8q-00VWJG; Mon, 25
 Nov 2024 18:48:21 +0100
Message-ID: <8b3f42a3-7053-42de-a66c-92426749e246@web.de>
Date: Mon, 25 Nov 2024 18:48:18 +0100
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
X-Provags-ID: V03:K1:9YwCxDC03gCGBHpBkoeUKi5KqlFDtnkJJ4WSt5E0FX2uGRLnXiV
 F7W3Zyc6nb7acaCArfg6jSskMAi9znnmE0VhKyraqEXLwbRKHtJM1z8BetCa2U7JksN0EcH
 jWRSPYJ0xMZPN9ex0Y8Yo+LX+LmIMw7hT2occdk8R9GEUSBV0vky1XA69hpZnzoKw1LCuvf
 uJY/cHIvrs66THymFmLYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ehWcrQ3/VbY=;FtAuX92aUZrmdkgXRSxEzHYFW1F
 0bH1o4r9y56HlLyRzjmljqQw7O09t4hXNL7T8YVOi5lyJaLk0yi/efoa7EZ2RSTB0rqsRXiyn
 p8+/77QDxh39ZGkyTc1gV7OI1fAPo4UITDDWrUoOhlPKKDo6uEXJ6gwHCiQ3Gf4FrLMAO44Bl
 oZ1xcZEFBmN9lnHpsTBjW9CKdEm/UQIMvnI4h49/v9CbgzmNmENfHXWE1TbJe27I8+rFoCWJb
 o8xCItiZHLvAEBalLsuHtBd89NbARhQ51HSN3v3MiKwPr8PRXmUnGHVnY4ABJKSoJg3bhOMlM
 tVRvWyXNlwVMOQ1r+gixZBVIXNGhaVXf0kDfHFkv/9XGlqMjki73hAk6q97z0sDZurpNnM91X
 6SfBdtatkIWcIoTGFR1AqjVVMIyco5m2YJu3htu7s6gT6a0i42vxIwOMXY6rR4qvxHQrGd04g
 G+UYFisO75EyBKTFQk1/LlAOqM5LROEfmYadCkZtVxDzFKtSjGfErBGf+urX6hCqriEJgbRCI
 6nBG5fDjCkSbn2f7U9pIjwRgR2wP1QtG6NfbBMxL20mT5cOgpynSGkmyyyR+35KLknhyFG94w
 3TcMb4jpYy/lDY4dUukRMuatMMBLOBevpAKXCynHets5Ob9K6gPayJFPRKNrKhte+DTmpX1HW
 r4FnPK+HQd4lnn16Y9rWrSU1XZVWCxUBcRmkPne6kXP7cxM6/WgqBdYTUAyewf4j4kvEe+Y2Q
 vz8Jls/rKkUhcbmQdE6nVBtkU58/p4/PYs7oFnbMqn+YvhNtgOnVuzSFej0WbyZ3zlSjgrzQT
 XufWNsNl6dayayZl40kmoR4PjLtbV0zL6tt4yckH71AEB9l8F8Ze7U7P102K76g3QiTATmZNH
 YRXehYzCzXw/7pw6hYdXn/N/uJ2WmX+wfVmTVJNbj0pgltWMV6+ldi4/9/JyUUJ9L7pJee6Iv
 wsj3RkkjOneFWwpq9h8+3XLiKROaMxSC6lGQHVUoCtEiQgWzUZwMH9q35T6rjxl3NCOBk4PPX
 Sc5ImFxzYgwcmTz6fndWjEslGMVUaGKob4ZhbApkaG7PsjwMBRmeZgZi649HEQZiGjNYHyhLZ
 2BbK5ni70=

=E2=80=A6
> +++ b/scripts/coccinelle/api/capable_order.cocci
> @@ -0,0 +1,98 @@
=E2=80=A6
> +@ignore@
> +identifier F1 =3D { capable, ns_capable, sockopt_ns_capable };
> +identifier F2 =3D { capable, ns_capable, sockopt_ns_capable };

May a key word repetition avoided here?

+identifier F1 =3D { capable, ns_capable, sockopt_ns_capable },
+           F2 =3D { capable, ns_capable, sockopt_ns_capable };


=E2=80=A6
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------

I suggest to omit such a comment.


> +@ depends on patch@
=E2=80=A6
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)

How do you think about to omit extra space characters at the beginning
of any SmPL lines?


> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@

How good do the provided data fit to the operation modes =E2=80=9Corg=E2=
=80=9D and =E2=80=9Creport=E2=80=9D?


> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------

I suggest to omit such a comment.

> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for capable reordering",p)

How do you think about to use a statement like the following?

coccilib.org.print_todo(p[0], "WARNING: opportunity for reordering of capa=
ble() calls")


> +//----------------------------------------------------------
> +//  For report mode
> +//----------------------------------------------------------

I suggest to omit such a comment.


> +@script:python depends on report@
> +p << r1.p;
> +@@
> +
> +msg =3D "WARNING opportunity for capable reordering"
> +coccilib.report.print_report(p[0], msg)

Can the following code variant be a bit nicer?

coccilib.report.print_report(p[0], "WARNING: opportunity for reordering of=
 capable() calls")


Regards,
Markus
