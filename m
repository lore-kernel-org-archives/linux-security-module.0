Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194D275103
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461051; cv=none; b=MZ5tQdrGBOJRlTvxtmaCve5UsL+vpHNF8pd3Lk/OoQhuezMj/RmUWpItM7NF1vyP+5syFdI2oXmgMcqY2MOePZu7WBRabwy2vEOVqbnCIDQmT7RJTbKgBFwK3Au+onrT2yA1Hne7regn98CHShJdSi3iqZNPG1JLYAN8gLZ2bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461051; c=relaxed/simple;
	bh=MkBWoexUNuPm89yzPO9r953l1XFedX2yqDktEhA1TuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgqgec8C2CemXeyFG8RrwQC/QuQLLl8Wy4a36p8I5g4gTZUeIzAYwEwL76ZX2YqGDbblFXbSujtfH9E7ayoHzfSncLfStSTpThUzxUTQ44Xx0iboS9/u4y65g+bSqh7vUR10SlU/vXrsTUZOqxNflBRWZIZQqC526V72P/I8IMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P9mFCleB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P9mFCleB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d5bf3300e0so166921785a.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Jul 2025 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751461047; x=1752065847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1U/jcJUt63/R9ojtJdyruc5PkgT9HoGw/OOSpSJ154=;
        b=P9mFCleBocJg7k62fstc6AF8qbEQelyuzhLdz0POfDWpOv6o68Fb3iWlQAeCpWwZ2g
         EWhIbNE4eu2d6kvawbhIMbEz6B6qJBKsUA16lUiGgFm4M6pDy43N/8xVh/UTEyTbm6wJ
         WsboMueXheasQPWLSF/PbtDiOmUZ1cbdqC8rnLVAAGZZ/xmz7pnMkXOj2hJJYWRWgNfA
         BNBn3P+pwaTX6YORtEAMmR+fQC4xlY3GfWen3TUG6DkClcLPZmBD91b3abfWNnDOvF9S
         i6U1vyOaqqTYKLVCS02hT4pixeT4g2/VBdtpg3vvHHwgSuPK000ERFHx7lVr1CSuIRw1
         UMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461047; x=1752065847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1U/jcJUt63/R9ojtJdyruc5PkgT9HoGw/OOSpSJ154=;
        b=W8exVxdVJOCN3RRSpujFfBnbSbPYdbHnm5fGFQf0fddWDAjygZyhe28Q9rO9wWWzcI
         0fggqVwQ4f1HzT1SZ/IF1CIHyPBbBYrcXwGD1jPwoLEYnV8Dd+xOWX+muazj7RsuAEnR
         ouHoHGfDqM6f/BSLLmYIPNjf9p1TK4q/eDEvU4g+gm8Y3U7K5LC0Mnda/xA0PKu5HZ0E
         UjKo70JQkHIs0zU1TQ2D35lKM+Kh2AYDjRlQZdXem2qJPyuHjo76DE5OtXsSpVoI0dOW
         bjI20xvgI4wUoXgoETSiWeZanHZ17zHkub29bVtz/BSkxO5mx8MJpe2TxME3fmFfU+eu
         k+TA==
X-Forwarded-Encrypted: i=1; AJvYcCUpJV9y+zbnIOeW7javnU2gkn8Z05kq9TDp3bEDyI4cXxPsNv4GO4JfBIQkmxoJAlvZ88z7+8qaK7It2YUhy+XjVDTbUBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSYCnBTeK1j2GNMeLfndr5qiA/9qwuwZJ451f3025oAZm8Flu
	IQzY20/nMycCpZWT9pwBfqVqoHmy5u0nUXqNGbetCGIw+N3aI5l8HxfoZ/ADh3F97qM=
X-Gm-Gg: ASbGncsp+1Ne0TZ3LrLIJQQIzjVR0g9eFmLQ+th3ZDFTzUcq6W+Pz7C8dAS/+aW6FsD
	1En93nAU05bXRzaGUOSHT1RZRbvf+kWIGUYQEZDH6c0UFl4Qwr7rJ/cq67rZxQJuNqKmNAKIBpu
	Ry46FDuOsn8sfh1wvfjVciTtcPmgph4ClIriWVmP4jP1zKjcJ8TbcJDxPHtEERRGFyKI3u2CYhj
	kkz0OXIdYbx7v/da7nQzkKnqeltGVxQHSN7Oq0SSKozke1icsimxLQuGfNMnQP+GO1Gyt+Rl/a7
	6MWx6u+jrN+oFz/5SZQVU20kaFzz7SifGtPX
X-Google-Smtp-Source: AGHT+IHUMiBPjG0eWEZJypXuRy9Vl0pcPIQatE88RekI/5Jeu9Byi7LTA10RE7s734tKjAic64bqaQ==
X-Received: by 2002:a05:620a:2492:b0:7d4:4c7b:9701 with SMTP id af79cd13be357-7d5c47831e7mr344047785a.35.1751461047340;
        Wed, 02 Jul 2025 05:57:27 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443204feesm933663885a.56.2025.07.02.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:57:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uWx1h-00000004bTR-3GW4;
	Wed, 02 Jul 2025 09:57:25 -0300
Date: Wed, 2 Jul 2025 09:57:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4] tpm: Managed allocations for tpm_buf instances
Message-ID: <20250702125725.GA904431@ziepe.ca>
References: <20250701145136.82726-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701145136.82726-1-jarkko@kernel.org>

On Tue, Jul 01, 2025 at 05:51:35PM +0300, Jarkko Sakkinen wrote:
> @@ -32,28 +32,30 @@ struct tpm_readpubek_out {
>  static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> -	struct tpm_buf tpm_buf;
> +	struct tpm_buf *tpm_buf __free(kfree) = NULL;
>  	struct tpm_readpubek_out *out;
>  	int i;
>  	char *str = buf;
>  	struct tpm_chip *chip = to_tpm_chip(dev);
>  	char anti_replay[20];
>  
> +	tpm_buf = tpm_buf_alloc();
> +	if (!tpm_buf)
> +		return -ENOMEM;

apprently this isn't the style guide, you are supposed to write:

  	char anti_replay[20];

	struct tpm_buf *tpm_buf __free(kfree) =  tpm_buf_alloc();
	if (!tpm_buf)
		return -ENOMEM;

Jason
