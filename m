Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308443;
	b=MpTH5fvHpKghSYnmcnlEzv00zmrN8Rr64VXgnkeZyLUCbuIjUVwKuMaQ3AyrS7fL46sM
	 wsDDeyDFsHt7jSXOaIh87gU1u/8zkF1GssxM0bVsisy3Xy2Et9pWfJ1QGqpagO8X3Z5Wd
	 hsdfdeMIDFI9lUtjfDex+snkMw/C+eDxeyNnTeK2L7Xo9xaYPoGFm4imq/gBs+7Sqhy1Q
	 0lmfF9P40GSgIDVk7kxQEdWAxVRH8vAAUZeZii/FmgAJ9UZrZi9LXPCixdGWpzb9X6mrr
	 9XeVpYYllsWg2zNBygYkJNrOY2T860VZOxwrBQFjzIwQ0aEr8/Ww2kjQf1n3hfHkhBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
	b=Ma1lMlpKBnZmN9apc5qzKP+ZM440GRBVcsltvRVbxEAAsy///ggorcoezm8fU9yFsuKN
	 mpZJMhLZ4b2bg+agMCOIrlFDQSPNf2UPAjhw8GistX9tKa6JbjgRa7MPLvoqWp7Z5AV26
	 9l6unMI+WBwaf5pjiNUi5qOUrMdj0SGsUPxoVkbhAdCe6EDjJaGXpi8l+6QUAKFD0F+bK
	 e+LYw3O8BYiwmzWhdatC+dCPuwU/2Nj4e1svE6QoJqBxtyViRm2BRDJ7+UA5xTxG1zrbz
	 cpFrUmEalokdOz8C+2nrU/xEVc6LKAsAsvqynZ2T/xHW7dhuxfC4H/hq9b94lUvNL0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR+oRQEN;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9060A3839
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D9060A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR+oRQEN
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so15805355e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308441; x=1794913241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
        b=UR+oRQENsNTyw3m8WPRxHakPMD/6M89G2GAH08z8luOgAuTYMwATMm40YkQjUmifrM
         0I0lYgItJ8iRTCd2Zi7HSPoiCb9Jfm897ztEJX6ly4PAjZK66S7FQpnPTnp4WfOgil71
         sS6EAeBEnAQXtYBXug/wf3vqUhZlNR/waxaiX4Vbpj2853UP0Pj/t+2kEPD3uzJ4Z75N
         Vj9xgTWOoMaDcdSmCpYtZWf8y5aFClQ9S7OCYqvtOzp0DKEA6vOIZHfTzdUKMwoECdwy
         qdoejJJ5aBD9AYCkstvgOzgJOwMHKNFwgSF/h1BLTJc5BS5UWlvnbo/XPoCHV9iRnUUh
         itTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308441; x=1794913241;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
        b=HYuproESMFb9cEHY0a3b/CAX08mcIHeZQhps+jrh9GbEFM5Ysvhp5/Ykxonty4TXD9
         exZ3InPMmvsf7JaoE6S0T7steT2qt2XO5et3gJ+xHoH5sdiycDqa7aPriHYZ/WhDoF/g
         YaFCL8wBm2W111p6rPtSRPOwcGcxx49pdwKXa6fhBQQc7PRMVGtLURgOP9YZ72GrJI3P
         GT3fh8N8JoPJoe05r17saSWJAxW1NSo1DC03aIjQ53hPDUTkvqevuxwZp/XfRa14w/Qb
         q23y68r2BKLpiQ69dgcyCTnenPLSwzPplYDgs+5fUf86vWkwvROt5T1T/tjazh16L6k4
         O+hA==
X-Forwarded-Encrypted: i=1; AL+hErG7e7fmIU1vsRQ8LhnMXLDKPnTVnoMZ33GbHcPDM1UaOMYCosbZMNFuU+01i9/Lk0aMkWEZCFbg28Qxnn2LItUMkQZRoGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zwEOg+M/F9tcYVg8ydfP/FzdXJt+BEf4oSpipl40EOi5MlABr
	XkJsBTV4OZHy3G6jQmk1CefoiTQcZSON4aa6THmjZejs0joBAayQvLK7
X-Gm-Gg: AYBFou2VQ9DVGnk1ITXgm1O7ZBX0ALGSzbtalqmdI7mIrchxvz9Tv3IZZbw0utVbGA1
	5SUQKRSphQ++uRE/MAQTj1V97oY24FsOTnW/jRd14mEubvnHAy7cA9LEm2doBz7eUS91yTPkifL
	uaNUS9vB4AuryEXa6z8q6oULoDPPlf9FmzYMN3S03HHikVlITQ7mHaGUB4T/DjdZqi2pWV57yFz
	x+5vSPWNGACxSp8KHsqSgIR6MRi8+ScOSF9nXmGCcSrNGFASxFOSJbSR4fAaXTJz8EQSbV4pm05
	bl2vQYJcYv2gc2H8ybfD894RRodCYOGoGYITNQ1/XV3/Z9QUmk0A/sExd4HAv3REe20iKmebmWX
	07puxPZpfgiX9wSrG2gesmxMgMuY+A8osVSBGZjeNN4PRr0eN6X8eD7MKPn9OVioSzYCsHtxoBz
	cZwLyj9iKC8dK0unBUcI5/eVtdUfcGW4GOAKrAeGfBx5l8Lceguf/NtoY/lRSBBlQCyYEsyaThr
	RHGj4UnFDerU5dv1dKskn2vi8fdWGTo33c0kxJLeseZfePhechJmlU2RL2I1Lhf9B4yNea4+4Wm
	qe2UzkbWXENofgCGZwlchGLsIccBEUPiJN8cZhmhuiX8jI7Pji/qX4OhXmdSETvqXQ==
X-Received: by 2002:a05:600c:6387:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4ba02349a18mr35485105e9.20.1794308440720;
        Tue, 10 Nov 2026 03:00:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02381916sm25962625e9.3.2026.11.10.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:00:40 -0800 (PST)
Date: Tue, 10 Nov 2026 11:00:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <20261110110034.0a46b9f7@pumpkin>
In-Reply-To: <avFcjHwnh9mrOEnz@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
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

On Mon, 9 Nov 2026 08:39:24 +0300
Dan Carpenter <error27@gmail.com> wrote:

> In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
> to avoid a conflict.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 30188a0ec676..2d6cc53539c8 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			       asn1_oid_len(tpm2key_oid));
>  
>  	if (private->blobauth_len == 0) {
> -		unsigned char bool[3], *w = bool;
> +		unsigned char boolean[3], *w = boolean;
>  		/* tag 0 is emptyAuth */
> -		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> +		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
>  		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
>  			return PTR_ERR(w);

Hmmm... how can that fail?
bool[] is just "\1\1\1".
I bet asn1_encode_bool() isn't inlined - where the compiler would optimise
most of it away.

It is a horrid variable name, asn1_bool_true[] would be better.

David 

>  
> -		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> +		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
>  	}
>  
>  	/*

