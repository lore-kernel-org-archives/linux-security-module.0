Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642417;
	b=feAx1TdVGcdSMjwrYHg0F+mgncAlD+P87h8RixumX8R9D6RHPq/6Lo72tnJ9p50jKuyq
	 QebPJ6pomr9DFbX1pM2EVw1VZtRqlPpOc8GI9AePYF/8mi07iAbkQaZe9ScG3CYf25eze
	 rkqcBDIr8NrgRBeQmBojFXSXGPS0Yhyv/ntvObqj6CylIxqR2e6D+yzixV2dDAnCdTrbN
	 kAUCS0ig+Bb7/rjq+RziaEfFvR1zSN/pDzEazccZIm8PWFlErUzrkYUMBHe+8NPkI2WFv
	 lleJxrRC+DKVf7y0rr09bPFAH04t27/il+Zdl2aZe4m8L5JzvpQo9te7lEAtBjAilZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
	b=MiRhVkQsp1a/3WyHzTjs6bfy1uzoZ+JigywSByY4At4uFwpAVPcrOzEP+N8PS+0unu0h
	 Y7h2LguwMKcw3fSmkL/PLfb4OEHESXbl6sXgdf6Td+x8h9fb6UY2ukjOURd9lkGAYsCoW
	 WIjzT8aCU1edPB6dZjRdoEo/y9h8yLb65rDcXpsiH1H2l/O/M6HDQHTyv3QpKa+umKStK
	 5dpWg+uGhc3sVaH0DpFhZpMo7JhEetfHn2tvI0pdR0t+Ns0bpEntU9MQYQFhH2WX3c1ZZ
	 dV4qJc9Kyp2wJZzUVBmNc/jviL8G7jdIxgEH94SfNAzZT9wCSeS+4ZsLlflQv801f9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyaNhQwk;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA606A329
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 21:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482DA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyaNhQwk
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2888797f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642416; x=1796247216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
        b=LyaNhQwkXbqpnZKQEFhSkXYdJnRuGKBuuLo4jMsASztOhDAKo/KLjtuUsGuJcBlEXa
         L9q5KsH0RDu7VhTtDI/7sQNdeUHKbiCE4UoTYbpDjatBwUbHY0aghBKcJ1jAy3etEkOB
         SRACMXZz5iIdXEUmV0YEGNUmGpDA+sNgu6gEYF9DmXC8KGwmX9bCsi/CJOLNgO+wTbbG
         lhvnHY38xO9YEx6YYjl+XslYqIdorjHMYTu7z3o6izDZiq+V8t7zvkDvaFfxCYiKSkSe
         OIEvBBzRuYo1TczJtkPUnW8+3ij30yPkrtXbZqfgQ434wojlx8AeDgewp82b/5hogoP1
         RBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642416; x=1796247216;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
        b=ZyjnpNXBXQKBqfwWmVpaLVtjVsNq157TkuahB/OZZHeoTN6KLBOAUTqtAU21GtIxv4
         qz9+3QBRc97hIC2reGoyin845XduzLI2N0piozCBqTrk0FO1IOcUSrEP3gdQWVFs8zQp
         CCExwJvaSYMbwK5aaEx8J6EtaUrnvEUPgsesc3jqUsgf0QN2RAV53u1OQ07ERfK+dRZ8
         enWSZKHx0YwjeUT8thvGDXCI1bMKzFBTm8t8WPX1xtImbfZbP9Tl+iiyB0GRckgXGDGX
         BnPs4ohd8zHew0Et0vOwubbvjx/IS3JmQRlMN67Rvumg1cUzfJdvKxKXE9GbR81MBiW2
         Lysg==
X-Forwarded-Encrypted: i=1; AL+hErHF15pc7byBGX+GtNL0PgHgDCMFbAoPGU0ak8AKGSquvGOTKSHRUp3jfGU0iavlDEWb6DeiGrrOEQy+lVDEnAdzRppfBEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CM487Nh6lPDvEizYQqKZaIQfFOvigYkZLeYHbK310hj1g4Ju+
	RPUJJ5LI6Gw3FJ66WZChk1FQ89rhi9onlZ5VLRiyOr9W04ObdkbCEP3N
X-Gm-Gg: AZFdTZcWeEUgY/EzDPm9M2/9ZmuohDaqeVmJqsZtxSxr55TY3Ydb5PlbKAP7Mvvz17G
	70BS8IdSwLxIWhwm9lPCuyTPmKPeZhMzp+Fwe51lvPcdaEg3xIzVJPBQIck0AZOTpbVRKOcN61t
	36wPar12k4Fam/OCIVSDnIhZU902wtjYcBorzyNNh0FMtx+PZvI8J/oo6t9ZTtm/wbapRixZmOO
	mAtw3EN4FTLnN6szyZChZngHeWrrR7vKQ+X+mEndogh5lMOpwS+wVpmU4s0/3x2OJ2HZlRx35NR
	iI7ZDqcCGOz6t+RVmWqTPBthc2CXTpl7grnfqEoXNYqWG3slZR5AUvqkG9L5LF18zhgjQz2epon
	IPwN4VEXosEPAcN3WZDpcxApt9GMJkG7oK6OFAXr3TLwzr2S9mziF3ZujKrMecOh6J0HTI368AT
	i2qZnViAPm7/rqpPnqIQ4dfqGlnZJCjcAiRairyRYJQ38Ui9qimNNSZBOwsFWU8LgPQj6bpfIj3
	Qg2ya/am1L2tYFsKPaHHHAXpHr8b4c9eu/ElcDbforKWHV+n1lY90wU/k3o8ljcpwb0PvQ39arR
	j+rxYNif6JtagOjMAgQaBAdLT67ZCr+sfV9E6Y6M4vGR5nL7P4Uhcw53Ymm0FRD0xw==
X-Received: by 2002:a05:6000:4a0e:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-4abb7787c05mr35815085f8f.50.1795642415460;
        Wed, 25 Nov 2026 13:33:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680355sm30439805f8f.27.2026.11.25.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:33:35 -0800 (PST)
Date: Wed, 25 Nov 2026 21:33:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Alasdair Kergon <agk@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Benjamin Marzinski <bmarzins@redhat.com>,
 David Gstir <david@sigma-star.at>, David Howells <dhowells@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, David Woodhouse
 <dwmw2@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, Ignat
 Korchagin <ignat@linux.win>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, James Morris <jmorris@namei.org>,
 James Prestwood <prestwoj@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>, Peter Huewe
 <peterhuewe@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 2/9] lib/asn1_encoder: Add
 asn1_encode_integer_bytes()
Message-ID: <20261125213333.23eedef1@pumpkin>
In-Reply-To: <awcBD-bp27JCVpc-@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-3-jarkko@kernel.org>
	<20261125091921.4bf40279@pumpkin>
	<awcBD-bp27JCVpc-@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 17:38:55 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Wed, Nov 25, 2026 at 09:19:21AM +0000, David Laight wrote:
> > On Tue, 24 Nov 2026 21:40:36 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > Add a helper encoding a positive integer from a byte array in big-endian
> > > format.  
> > 
> > Interesting...
> > You allow for integer values longer than 127 bytes but don't allow for the
> > much more common likelyhood of the encoding being 'implicit'.  
> 
> This is the first thing I wrote in 2024 and have not touched since
> without further feedback :-)

I wrote an ASN.1 encoder/decoder for a tcap library a few years back.
Pretty much everything was implicit and some of the tags exceed 5 bits.
About the only things that needed multi-byte lengths were constructed.
Oh - and you can't fit in a maximal length SMS if you use the indefinite
length for constructed items between 128 and 255 bytes, you have to use
the two-byte encoding.

There were a few functions for 'add item to buffer', but I didn't need
this one.

David

> 
> 
> > 
> > David  
> 
> 
> Br, Jarkko

