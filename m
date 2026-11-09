Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253745;
	b=m28jPo7hj/ZIK38S2K9UXet3U1KmXZwbYV1TVHANU3AGXvFCsgLDNZPJQdElny0Swye6
	 3F5hYXf9YtSAeDtpMV8QXxz/3YOrO7Z95qQtNQi/gkqUDmHS2jkissUxPfJSrw48+29xY
	 JMINdlUeWQUFMXhga3/HunNJLlFmwVgOU9cYkK2RuKZMHh4sO+4TUg66L911AXiZxtyC1
	 Ov3hqLK3cZJCOuHRK8ChMEcMkhZdiEpUxN3ceAM5PBLooh0jbemCqKLGpc2mrWm4VrH6x
	 Ff8ktcq2G+vQ0w/aRFhFvQvcshZuCtc5k8RlR5yIUXZTc4ofb5Rf71AaIXSLcIQjJJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253745;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ba2Q7AJDVOznKzIVSG4WADmv5TxkLP7hX7pgseAgvN0=;
	b=iuUTdIGdiYSsrzJSygmRsKOwOrq5j2jldi6UzwYRy1RF+jca7813TuAMc/VlmvDTA6Rr
	 IZQnKPuR1f056C5mIYHHEXJQIm7XRVNwrLN8HeiCgNxcQoCCIxN/0twfcyzUsiF4ARze6
	 XC4c/n+IuboDNmFWFbAAz7ay3wDloMvxTEcNkBuHOQzQHai8JqUrCVONg23SpF7JDx9pF
	 wWuXLdbKCmqVJJSiejjn1NDBqe6l5QoXlAq/fBA2MDb59WPi1y7F/5AKo9wzBjpVQ+XFF
	 C6lKd21Pdppp7SaYz6tu8DNUlnpnYVA95v/cBRLPkw9pWpgczTegtA++Uf1d1v9MJZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C0606A332
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 19:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 423C0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so18226345e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 11:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253743; x=1794858543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ba2Q7AJDVOznKzIVSG4WADmv5TxkLP7hX7pgseAgvN0=;
        b=dtLMPH+WLgohNFOpBqtx7FkYAyMqFevLa/cDvd6hYKEgCOqEr5a3B65RlVc2whm8nh
         vRLEZSJoUagfI95hxzBddJr1IZ2unzB1nZU2oGQyA5yA7WZ1qM52yvGu1o/OGifrxYX3
         ISpHggwuyLrvGBI/Qf52/r51yEQK5uTl1X+CDv2qFCET1uIsNZZT1IRO3LwCRj6Ic8vo
         yg4L/040XU6HCLX3hPQVHnEljqJabGWtf5kVbaY86tbpYdOeQWg/9COOD9xvo6uDnMjn
         LmkpR+RjJ8ig6cUhA8eLFvp7ozS08e9l2qrlD9PWs1JCqQBIKEKR710rEUm+Huhkye02
         iMjw==
X-Forwarded-Encrypted: i=1; AL+hErFw6AlmMLAffuqL8z3hp1uhk/6LKj39rtB/+VSwP8BLhZK9G+fC+2hXpY2LEg1zN1JIVbrL3fif18rK+Lm4OhV7TvFlY2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1NVT27R3JcmAqPq7VqDfRj8o+xKKKaVc9huh2JxESmZLbBau9
	w8weGxHW99MZfQEpAddgxyaLwZ3HJMntwfbSYXTxwlyCV5pOQc7kKcv5
X-Gm-Gg: AYBFou0CJgTB2IJY6EFuAjkKohqeKP2CuSf/dmy63vrGH6nmnSFu8k4LfcFskmFX23V
	T2YC/vMT1muCnAVA3zHXKg/SlwgL2u4YzkwBKqeQabBcKbpQhLejODZGculXnxnJb9CdFp+Yhv9
	7X0eTbt61K2d8+XQhTFmvsI2bUayetdvwo382EXrWvWH5dT5/HxHmEmgeBY61dJmeXApLevrLhh
	ohoXOy3xJJNhV1TzZPXe5WiBH+tCPpDKaNK6BgxC/aSC2KuH7nkepf7CrSWkc0XCETheiBpoSiZ
	s6EkLwpBCwtraj9XGgs5uRCDHE81zu4DhCuV5VWUd9luKyH7l2GXxZ7XWqC14HLmU5X+VkU0is9
	jpgqq5GRRBTsA+Wd4IWVo6AG+SK68P95N+l0JTTgRmgv9o+yar6yVeGFVewjTo0pcaj056+EUFs
	lgsZCWuWqldQkBV1El9mmjetFv6E1XI9vqoLi4GX/50rhbbLd3fBCBr4vmwNg7FwwReHIgd2wxi
	ipStrQ+Lkxr1JRcsMM/7qsQrD5lZljXUK8xTbZkfczgf9VrD7flHamkChZnBtxIPmSzY4eeChr8
	vmPR5g1xpesk1JIF3bUbUPdx7wWI/zqj9hxAh32ADFrGTiOFQ2GVK8q3xiRnxL33xEHDxbzuE5o
	A7XOX7Mplm13TMx6II5bhw7rinTy5rVlC/Sviq7AM2BkUvONchxjftHy60ToMmno=
X-Received: by 2002:a05:600c:1d29:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba023376d4mr4246085e9.11.1794253742529;
        Mon, 09 Nov 2026 11:49:02 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02300988sm6618615e9.0.2026.11.09.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:01 -0800 (PST)
Date: Mon, 9 Nov 2026 22:48:58 +0300
From: Dan Carpenter <dan@cryspen.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avIjqp3n29DKkpPp@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
 <avHelQ1nxsDVcQkZ@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avHelQ1nxsDVcQkZ@kernel.org>

On Mon, Nov 09, 2026 at 04:54:13PM +0200, Jarkko Sakkinen wrote:
> 
> Are we migrating to C23? I've not followed this too closely.

Google AI says that we will adopt C23 next year or the year after.
I argued that it would be would be after 2030 but AI said, "No, there
is too much juicy stuff in C23 for kernel developers to wait so long."

I don't have a pressing need for this patch to be merged.  I was
just playing with some compiler related tools noticed this.  It's
the only place in the kernel which uses "bool" as a variable name.

regards,
dan carpenter

