Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642014;
	b=s779pbC5gdHQsXTGZHcYIzONzm0ONgLF3br6888MBpWS0chZ1VSPYh9IM+NWycu5G1qX
	 SbHleO61+TX2oD/kKXmjKYdd2zzkmKO9bvISKAzKdpjbLTAv8EOtmbFhvVAjYzHc+slqd
	 gQl2ddNt7ub6YRa6gsT+WRe8sbX2hy1JuctjE66TChntLwhUOdRBU7ST3IkYVNA/x5c1X
	 hExFcQ5lLbKBtifUmoyileYqLTCsg11n3ZUqxsLncr4T1GMUwuB4gu2GRwUcRARMnsqp+
	 vfN/qfwGrgAUKpBWVPq3nCFG47NtU9gva7rNeKueS1/bYVqtL7ABiL7oWo9U2v0t5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
	b=z7h7X8Mh7HCTalwJfXVQh92kgqO8ZDqIHhBc8HNkn2osCPjBeJzKGNnv4TRBb0x7SprM
	 O7C5fSYwo/5T4w77Jxiv4TenbiDRxE2eRUmTgKK6okbKR0A577HqClxkpcHvZo7IjxIKp
	 4MXERlDgpysxbrvmGIPfxBWdppzbemh/HsOW+BGauyc35Xx18CpBfUDvASJIUpAXeTP1w
	 yYX/wlwRjwvjasPWuSJlX0sQCk3ucFWMDWCfbBxkHSxrUSzWzJVUCyYchNKt6G/OthFKO
	 inOpv2igWE/A7hoCK8I2h6+E9yVAt+2YlZp54aOCzxMUevrhsPwBr6BKBj3aw/gTElQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khbHvIZS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59D606A33A
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 21:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D59D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khbHvIZS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso58544445e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642012; x=1796246812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
        b=khbHvIZSswKzRKScFBxEP5dKyjo1fhxkUl/Tm9a7vooLiIEIc3+D/8+f+l2qOQAqqt
         NkhbUqa1fNS3fq7OMj0WJMaJl1khGxmmDggv3i+SWU85FgAdjmbQ2zLZepZPts3zxApM
         +6QfPBplV6uwffDVwMTmMBw7k1e3de0G6FQe/sfuWrH5Ds6lbEvkXQTXgjHFZ3p+bjez
         1kr4qDOVCP9dTt5FKMHZl8AC9yxsqKbDOwSROd6mExDAJeQ3K3/NchHUz2ApoMTPzZeQ
         /uhnbwnb7ArGmTHzNkayy/FGQamuBbJ3FEoi6BqwxfvCMlyHosFKu+w8DEKRCPmU15eV
         1whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642012; x=1796246812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
        b=xS8pCp/sEC19Lp4upWMl32llg681CkIoaxL5agiQY2yISlDe+HyWp3y2c3ODwJyMmo
         UwXbkvSjxhBtW7L80l0Ujs4y3RDsP3RD45AkIRZIIr/t9+ZBQ/J+D0VXl/lr4YAtu8J3
         pyiSAXzuvxBOieTWLd6qKWXO/KdeEXl94PKQ5d3P/RcxbVdIbTvPvMc0sCf1LDX5rvbc
         v8CIQ9XOCO0zrYq4HIdak5Ist2f2uNu8X+rMRuCmqZ+J9vRgN5+p2uyXHDt35sSuO+Nl
         i8HKtYGLpYIMn47axeoba9k0RH/1ItgENDE4iPMz/R/lffJjOw8c4svZ2gyMhxsP0JV+
         cQXA==
X-Forwarded-Encrypted: i=1; AL+hErFAUYiGvy9SAxucdO8cBKPDLDW5uXuXlsrFzU3qWz0qGmnkFy6bLcm6HfdubK6zO+U/Wzjh4kbiIMdbUDwMc7d693BfmUQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RhKtzeuy3UC6ZKZSP7q3LjnFeieIv/aG0I6B5uu1M+g7JGATF
	oSiAhMpCuIS5TI5Hniv+S3w0lU8n/1sg4yF51OJXFYubGQIZ2O0kttYP
X-Gm-Gg: AZFdTZdp00ckHdjLsw17AGAhz9MZYJw43z/ppB6bhgjRwd3W9THdifT3QfU2OU0iIdO
	r6gWZNdU+B3QHDCUqZjdyKwruzoRdBsqWUp1abietkS3uo8Kpc1vgKtKuW/2rTplW08ZdJ2O073
	ySJilANKydVNve/Lda8PAu2nPT2iLNuIXFyKQbSzwphL6br2F+eg6fNPgTI7Cb6n8MgDf9QHNcG
	G9Y3bbTPxzZcHJHBadutV6xKMWRPeklaiixqYVxflr6lvxJeTbKAc1E8eCyYyEOogAp1XWGUe6L
	s895BPCOV+Lg6EQLNhyxe558vAWgbvQq6Xk4PDCQwGdLE3YGXEjOHHzlj8X9Bv4RKc6R1oswTdV
	ErihZNI0cO8eUaxBWX1wWbXB1g4Ru2ilT6pGYmb9y2OnOBb1CODNRWUG6576aaL/SDjYtJj2PFr
	vvfEKfZHqYbl8R/NP559PR/kpkJoZlCrpBCNnOgkJ0SZBYJet0keASOsbjNjYTJ4kdJL0vIY9c1
	oTw7l4NWFOYAZFUzfA3LtmnCmCyH32rqQM967XFI9hatHq8tIdB9DiNBXSyWrAa69zbbYl3BRIq
	EAViQDOjK2ERC59/9bQJbWhuHhZWx5vHTH7hQbsXluwvd8TWQplk77pFzxwD/cF1Tw==
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr433032475e9.31.1795642012525;
        Wed, 25 Nov 2026 13:26:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906cdcc1sm310815745e9.2.2026.11.25.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:26:52 -0800 (PST)
Date: Wed, 25 Nov 2026 21:26:50 +0000
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
Subject: Re: [PATCH v2 1/9] KEYS: trusted: Allow ASN.1 TPM2 sealed data
 shorter than MIN_KEY_SIZE
Message-ID: <20261125212650.479bea7c@pumpkin>
In-Reply-To: <awcAeLUROL0l_g3X@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-2-jarkko@kernel.org>
	<20261125090930.698d8f1b@pumpkin>
	<awcAeLUROL0l_g3X@kernel.org>
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

On Wed, 25 Nov 2026 17:36:24 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Wed, Nov 25, 2026 at 09:09:30AM +0000, David Laight wrote:
> > On Tue, 24 Nov 2026 21:40:35 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > tpm2_unseal_cmd() rejects unsealed payloads shorter than MIN_KEY_SIZE (32
> > > bytes) with -EFAULT even when loading an ASN.1 TPMKey (OID_TPMSealedData,
> > > 2.23.133.10.1.5) blob.
> > > 
> > > While kernel-generated trusted keys ("new <keylen>") and legacy old_format
> > > blobs are at least 32 bytes long, external TPM2 tools allow sealing any
> > > non-empty payload up to 128 bytes.
> > > 
> > > Keep MIN_KEY_SIZE for legacy old_format blobs and accept 1..MAX_KEY_SIZE
> > > bytes for ASN.1 TPMKey sealed blobs.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > > index 30188a0ec676..d7336f25b514 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > @@ -559,9 +559,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> > >  	rc = tpm_buf_check_hmac_response(chip, buf, rc);
> > >  
> > >  	if (!rc) {
> > > +		u16 min_len = payload->old_format ? MIN_KEY_SIZE : 1;  
> > 
> > There is no point using u16, just use unsigned int.
> > 
> > The same goes for data_len.  
> 
> Hmm... or just int?

Unsigned int can generate slightly better code - especially for
array indexes.
I sort of prefer it for values that can never be negative.

David

> 
> 
> > 
> > David  
> 
> 
> Br, Jarkko

