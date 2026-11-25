Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598365;
	b=qC95wQitkFReGTwRKQzTLoK0ZbELz5W2e55XqBkhs0dQXv5W+/5XgV6ZXYjXGYwhssqN
	 uBi/AntHXC4BjMIB3+p7F4QpthH6ZO/nU8kcTLsz4eTMRQ+9FWX5R/kxi8b2jX3zbT5LY
	 FcpnJwYeiIxEI0w+MFJjZg+T0g3nFDDiX1ITKKRr3nBc+wHNf1dl0FQWSbBTfQVuUP9T/
	 XrpehhZ8fr28aTqgQc4MS44lDqGbqhOXiV/qpMfePeo6HwnXUsK7RXrFZV1u46TOUq5bp
	 csWQvSVjn1qqyaWHSxlwN3Ac7wILX47vNvUm1+TkU4sk7yIj35zQAIUBhOMUq5QTLaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HM/80FJuhfrnMxC/IfbUvOR9owLp0+IkW3x6Etq4fS4=;
	b=AnqQjaHLRJJ3XdP9jP+O+rUoD7q816k0qQNeR3R6IBhlR+JEKhK5aocCG96g4ntZ78zx
	 sPBDgRNS16TaHUZjLDEpcrHZXOfjq/hkQXX1BBsTrj7/KujquzXgdyVDTrFWoXMYrp6M2
	 v+WexS/ZbGiu8SPCZQvMxR5bUtGAwk+c2mwn/CkR5rvRCebnQcwfg3dEG/nC2gzI3R4Iq
	 jdmpzwrxh0tfq0E1LPY2dz5v97wCxrwkmwLEaH+yQYStoVGZ7/PdDveaHyxBBewwTLUl8
	 JJAcEsnHaoaU3piSs7be0ASii1kGWfhdoONAl4AiC4pg0yqHZCiIyt9ZRDjBqFqo76A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmg4qrAM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14147606A693
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 09:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14147606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmg4qrAM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so35740645e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795598363; x=1796203163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HM/80FJuhfrnMxC/IfbUvOR9owLp0+IkW3x6Etq4fS4=;
        b=zmg4qrAMEyL+6l/4oysXmbs6l1nqhC0voMmFglVAX4rEfGv9PDMaZF9yiMvP8KOc/m
         9IHUI6UU5taUhdpu8AXhe1ivoR3R1si3RvjmEmtzBHlSdJUZfc5WTrI8RI4LJRHRBd4U
         XnWI6h9PeS1F+bBNm0A6uQKTqMX/poXGwI0tZ2CEWUpt6B9j8yf2a/SCOUyBw95K8lE8
         BDCno7072yeJloNnuvBcPhoz+eV7xLeZRQ5JjgPA/p0WH1gjsHNz3d0Aet3OWEyymye3
         YO+8AyxbGx99Z03rk5RzGLFeUuwSRQ8MpxhOUTKQIIPqqx5QTbF5/pwR1H0z+WXROOiR
         qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598363; x=1796203163;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HM/80FJuhfrnMxC/IfbUvOR9owLp0+IkW3x6Etq4fS4=;
        b=CCTvNcdk8/ukOYtNVRmCk2JlbAOfMNkVgoi7y5w4siODwy0E/9Eb9OOwjBdM69g4tF
         J5L2uETZqMZ1zs9hhZkbJzAuZ3EFU/+opBXVV5FSsaKmUh4FXhxwFQ4TIFV21Nz1j+lv
         6yG2OC07e3buI6Wr+0UAgNNejhpBwDGTB8j/QwUN4TOKabfVTDqBMzXRrPdC+u5Qz9af
         Pd5e0MqLYXy/4jTsE9AUPC5PmmagEDUKJeqiu11LfCalsxG/j/q/3b/BcL+zrAKdpHPf
         BTz3fQEsiKvJ9BQPQDY2t3s+XPbEHxmDEnS4qpnuu8QgLnkTcEgEyf4g2EPlwhUL3Xjb
         KjyQ==
X-Forwarded-Encrypted: i=1; AL+hErHR5QbHQAiXd05ykRTS1lZGSUfcVknIr++WjH87cUhUejXxhvw9PG6SlNbePRuVNSEl5x1FqiumaLBQdT4S79n9dB62Bz0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZTHi0e4lXXJUuNtiPIp+R7ztLzwmWuJkw3WTXNS+k2+jyzxQe
	X56a6tnmvYlkj1grb68L50+lz4ipDStyOpR2CJx6mab/7QsqPtdb6sIL
X-Gm-Gg: AZFdTZdTN5xjdiV3Jv6+7usbloVef7U2rcXjlCDERf0BqBypU4Xhe9yNaJ+/2lOmwvr
	jiqjzeH+JVCrEyLKfSzIhjU+Vvdjo1FwWT1q3AWSXdr4y4H0BiEHPRmwhTfuVWsIFvM+3J7LMTB
	/W34Tv4FkMGeXq5g1CrSDjzQZE8pBRRSlC4q4QLVUSHK2lhtG7dFDoD+ahfKhtqn8Gfvyp/gsGU
	kbX0x9IuJ5WYPgdWFnsU3qFSnEooh9LO/q7OuIQJ5WBUbgLn5Zh63aAkE+R6DdOscqB4rF67sq6
	jOvPMb8hyzcxM2XeC+sNHZeygDbg1qkd+riAuwBlZY9snsFRqf5YA0ddM+EA/HKLNq5AyzfFZoj
	uwhNGLX9rZ0/HEecd0LMuL2tEWX/qQj0S+fF+ihKQcPwXdqhJJrlpdh/IM+sYNCipP4B5LIL8vv
	FH2BLOCCSxMjH2Xe5lSE/56YctG7sy7hvFMqKH+5J45V9rKMFTtR/OnucQi5g8VQnA3jOV2b0Io
	hk2Qy6t7ciFXIgIIkAkIeM7xlMvn2Q3YWmSizuk73qXHe06p7WDs/nA9WpGAhlqgx6SYbPFVaQL
	8OtvyLRc2cJkeVNihSNZGmvqe8n+uNG3bDNVHNoX+mhEzHIkl/RI5o8aE4i7X8XtEQ==
X-Received: by 2002:a05:600d:8449:b0:4bb:8e95:8ce1 with SMTP id 5b1f17b1804b1-4bb8e958ce4mr235915585e9.23.1795598363338;
        Wed, 25 Nov 2026 01:19:23 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm461330575e9.12.2026.11.25.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:19:23 -0800 (PST)
Date: Wed, 25 Nov 2026 09:19:21 +0000
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
 <James.Bottomley@HansenPartnership.com>, James Morris <jmorris@namei.org>,
 James Prestwood <prestwoj@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>, Peter Huewe
 <peterhuewe@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 2/9] lib/asn1_encoder: Add
 asn1_encode_integer_bytes()
Message-ID: <20261125091921.4bf40279@pumpkin>
In-Reply-To: <20261124194043.1651679-3-jarkko@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-3-jarkko@kernel.org>
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

On Tue, 24 Nov 2026 21:40:36 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Add a helper encoding a positive integer from a byte array in big-endian
> format.

Interesting...
You allow for integer values longer than 127 bytes but don't allow for the
much more common likelyhood of the encoding being 'implicit'.

David

> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  include/linux/asn1_encoder.h |  3 ++
>  lib/asn1_encoder.c           | 56 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
> index d17484dffb74..e206bd425854 100644
> --- a/include/linux/asn1_encoder.h
> +++ b/include/linux/asn1_encoder.h
> @@ -12,6 +12,9 @@ unsigned char *
>  asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
>  		    s64 integer);
>  unsigned char *
> +asn1_encode_integer_bytes(unsigned char *data, const unsigned char *end_data,
> +			  const unsigned char *integer, u32 integer_len);
> +unsigned char *
>  asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
>  		u32 oid[], int oid_len);
>  unsigned char *
> diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> index 92f35aae13b1..8fea70dc0846 100644
> --- a/lib/asn1_encoder.c
> +++ b/lib/asn1_encoder.c
> @@ -10,6 +10,8 @@
>  #include <linux/string.h>
>  #include <linux/module.h>
>  
> +static int asn1_encode_length(unsigned char **data, int *data_len, int len);
> +
>  /**
>   * asn1_encode_integer() - encode positive integer to ASN.1
>   * @data:	pointer to the pointer to the data
> @@ -85,6 +87,60 @@ asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
>  }
>  EXPORT_SYMBOL_GPL(asn1_encode_integer);
>  
> +/**
> + * asn1_encode_integer_bytes() - encode positive integer bytes to ASN.1
> + * @data:		pointer to the pointer to the data
> + * @end_data:		end of data pointer, points one beyond last usable byte in @data
> + * @bytes:		integer bytes
> + * @bytes_len:		amount of bytes
> + *
> + * Encode a positive integer from a byte array in big-endian format. Strip
> + * leading zeros.
> + */
> +unsigned char *
> +asn1_encode_integer_bytes(unsigned char *data, const unsigned char *end_data,
> +			  const unsigned char *bytes, u32 bytes_len)
> +{
> +	int data_len = end_data - data;
> +	bool add_pad;
> +	int ret;
> +
> +	if (IS_ERR(data))
> +		return data;
> +
> +	if (!bytes || !bytes_len)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Strip leading zeros: */
> +	while (bytes_len > 1 && bytes[0] == 0) {
> +		bytes++;
> +		bytes_len--;
> +	}
> +
> +	add_pad = bytes[0] & 0x80;
> +
> +	if (data_len < 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	*(data++) = _tag(UNIV, PRIM, INT);
> +	data_len--;
> +
> +	ret = asn1_encode_length(&data, &data_len, bytes_len + add_pad);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (data_len < bytes_len + add_pad)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (add_pad)
> +		*(data++) = 0;
> +
> +	memcpy(data, bytes, bytes_len);
> +	data += bytes_len;
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(asn1_encode_integer_bytes);
> +
>  /* calculate the base 128 digit values setting the top bit of the first octet */
>  static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
>  {

