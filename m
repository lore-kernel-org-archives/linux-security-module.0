Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597779;
	b=D+RvMWxr7V0iwnMhGiY0bbM4GKCMh/GthkieVtvHMxm89P+MT7UQozEV+bwpthlTf2+R
	 +mxk4Y3sROoQD5cGEr/7gjikzB9xn9+ASZLkVJXkOFb2qZiNw94QAzZacepN8dO9TGTLd
	 Tj1GZN5IAozcrkKnvkJUAnuBySWhpEuQQr9dOQ1XutZEbozBO39TvmNUcG/+XSuC6Ps/j
	 yh6htFoYyTtnRMtJlTgumy9vqos4uqo6G2YeK702NvdY5hZsfRwqWO6/QpXgQWrobUIC7
	 66KeVJF0ps7vhLboOr5cMwFuqPsnhpc8ylxt48kHNDQemSBkSyKc2ADxQQ/LufFGR9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qm/FI2mE1ewe632JTFSK32XwvOS0GNyWzPRE758QoDs=;
	b=mrzzgiHyQW9Y8IUkRbYEBRXEOcIJgPvwttLPGu8EapbaWH43RnHP1ci85u1srn/VF2cc
	 LCRoBAlu1NOGNFGkDznpfBzU1+UGdyrlWj7E9DawUS+zuwFNlMgvrUtJz62lcWJ4uzxFX
	 XV/R56ApHhSOqZrpJ1+NLb549vXoK0dJzlQDGH3g8rNeTOmwr6nivjNRpMjAUdaN3GKTW
	 z4HJzB+HS6AYSN4dpKhzdxEPRXGMWsXOI05qJ5Iin1AsU19Pc91qCWLz/+KpxupQKLJPb
	 Zhnu/rzIDQXaucIB9Ynhmd9tcLrS1mlqUNlQu45VQ9lY47s1XMGyzR8Ys8V2xswGPPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGuiiqVQ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF3606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 09:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26EF3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGuiiqVQ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso52230415e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597776; x=1796202576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qm/FI2mE1ewe632JTFSK32XwvOS0GNyWzPRE758QoDs=;
        b=AGuiiqVQqunjoBCYAQf0+aaIX9u8Idwr4BsqXiFG1Y2GXVcd2nGAwNB2bzu0OZsqvt
         JBQWV39Rzw0Nejmv3JjqTkzRxtSB81AvLEnWqd3BIlVhavaIMQto0Hj4ItwMuVJN5t9m
         qDDTsY+zGckYze/eL0Fh35Cvy9GGXbsePdi8hxB00PegW5V2xSwtYpgnQ+XID8ik3L5c
         ETRwW6xnMEEQ916w2d83q83ZxbDdUag/69/1p5CzvXoFbS+9l6yLn8rKodkjDPPM+Rpi
         9t2xYHAx0GtrAFVGzYv5GsoMxIqDShH+sPkkV4Fh0S/+l/GBUcpTn7YbFICB2vlEmz20
         X+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597776; x=1796202576;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qm/FI2mE1ewe632JTFSK32XwvOS0GNyWzPRE758QoDs=;
        b=ZMa0wdqXF+rZMu5UAegLEKpo7p0FrnOJsqc9rhosJSb8SnWCOmb5HTqiku5DWLJwmN
         b6fnfBDBazr7njFreFGWNQV7tIqMQR6SOl2TmZKHWxF+xnZOxHWy5WD/WuVfrRQUsRtC
         Sf0YwskCEfCw4xufCdJK6vQg/sxnxBTC219K6HsW7TJZQSQQTJgtYU05E2lMBgdpa6mG
         uOKoH/9tWRK/1XN3ioy59eE/qaUOjpWEAKD9A9wMnjB5XJtat1K8mdM4+agVd3RWy9+e
         keFdzQBOSVX/RVfs7BquSrwDEPL4wEn+eA+z12Yr7WTUIDmsXr30K1O/Gmg7lLNWna40
         vWpw==
X-Forwarded-Encrypted: i=1; AL+hErGe8oqy2WJW44Oe5ssoIzMyrzjKogJSgKTrfuvFYhVwH/MN7eyz6/Zv/w9u1iLeOQznwYVjGRBhZMJa4inTL2oOzZqlaq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YYS/g0zNjUrh9G5Nd7u00xUFY59d5Y3NQ3V6cni4gyUVO6cxk
	JG9DimMmHXJ0Hbque0fe2yKMHnFyZfquqLlgSX+mWjXjuBKBp7aUbT0m
X-Gm-Gg: AZFdTZc4ujpe/X2ZNTTH/QCPBXh3h/zdxKNeMFEVjC/Xpvfuj4S6DV0HOWj0tZEE62o
	O6mnxJl7idR/YfcnXvvlETgI6HqAM6lMTL2pm9XNTJ1uCijuPi3a81+hri/t7HwFWZ78u8b4G7B
	v/Zs7XREafJgU0kzQFtPC00TS9zYM/ktvUHSdtCkJirHDCyM0hObSrxXYMXLKDWgCZwSDg6JhKO
	n+xdLe5KNVJ2qbx4NG1maofDhqrlkcqajeglbgUl1IejdC4DSSa9bR8wtrf1yZnI/T0GZ8CNma+
	L12QaFAQ/4pfflpvKtYM8kcM1zoNf+uIMZNTijb51aEjDym3nhSlemUALq0mS6oHE8yaz+N65kS
	kTyETlADqwui36MaUz8KBXNMgaOvt429l1kUdqf5C5mhHHNgpoEUD1K1BGxGqE23+/uN7L5QfL2
	o9NKUzhAZmwJ2/kJptOiLAVfApEImmvTUh7DVrCbxh1PDktGf6ro2ODvXAFAxqsocGMxsm5l5L3
	gI55/UfA8yrnRpzUwwJUwyZ8XffP08+Xn4mI+atS1zq4lPd40XgIfinVO+BSboUHu6O3+33F/Lr
	c2m0LASVMNzzMg2inq2twuBhw5hQu9rfEXCYioSlSqlnq4c51Ooo+aony3Jm3yPinA==
X-Received: by 2002:a05:600c:3509:b0:4bb:76f6:d23a with SMTP id 5b1f17b1804b1-4bb88814d16mr374824975e9.21.1795597776397;
        Wed, 25 Nov 2026 01:09:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm558503985e9.12.2026.11.25.01.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:09:36 -0800 (PST)
Date: Wed, 25 Nov 2026 09:09:30 +0000
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
Subject: Re: [PATCH v2 1/9] KEYS: trusted: Allow ASN.1 TPM2 sealed data
 shorter than MIN_KEY_SIZE
Message-ID: <20261125090930.698d8f1b@pumpkin>
In-Reply-To: <20261124194043.1651679-2-jarkko@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-2-jarkko@kernel.org>
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

On Tue, 24 Nov 2026 21:40:35 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> tpm2_unseal_cmd() rejects unsealed payloads shorter than MIN_KEY_SIZE (32
> bytes) with -EFAULT even when loading an ASN.1 TPMKey (OID_TPMSealedData,
> 2.23.133.10.1.5) blob.
> 
> While kernel-generated trusted keys ("new <keylen>") and legacy old_format
> blobs are at least 32 bytes long, external TPM2 tools allow sealing any
> non-empty payload up to 128 bytes.
> 
> Keep MIN_KEY_SIZE for legacy old_format blobs and accept 1..MAX_KEY_SIZE
> bytes for ASN.1 TPMKey sealed blobs.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 30188a0ec676..d7336f25b514 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -559,9 +559,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	rc = tpm_buf_check_hmac_response(chip, buf, rc);
>  
>  	if (!rc) {
> +		u16 min_len = payload->old_format ? MIN_KEY_SIZE : 1;

There is no point using u16, just use unsigned int.

The same goes for data_len.

David

> +
>  		data_len = be16_to_cpup(
>  			(__be16 *)&buf->data[TPM_HEADER_SIZE + 4]);
> -		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE)
> +		if (data_len < min_len || data_len > MAX_KEY_SIZE)
>  			return -EFAULT;
>  
>  		if (tpm_buf_length(buf) < TPM_HEADER_SIZE + 6 + data_len)

