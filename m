Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C01EF0B1
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jan 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254578; cv=none; b=NN8g7/2yhLUuYYYJQSuPfKcNmXohZ+nQzxZdfM9xaNKmq7y2pWLB/9eFxZdztFjwVhE/4sLKo2JczBMUAKwAN1aYMbkDKJxarrJY/DnEXdWuMnbNihuitMv1hgy+cbJLtD8mWe5makT8USjbt6T79/1yegS6/kOhabyyQyMvFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254578; c=relaxed/simple;
	bh=mhjI5XJs+wlmeptweqROi6JQ9QOeOFdceKqB0fLjzng=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aYqPCSFUnEOsJN3qXD4Bpbe0lAEi7x2sbyNyx5PY0Em+asVRR8LaVsAV6HNMYxpW8NdrOTGSe56THV0PqajtczdmNr9YtCAcBi9vIyfAJ3hb21TfUDannSYRqmqvvLZxSm1j2LcVyxeZQ16vZRTuOcsnrN13TRynmCIgsocK/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=oAAdNDJE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="oAAdNDJE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so25529035e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2025 04:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1736254572; x=1736859372; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3ZCQbwToICSm537L8Sy2gP7aNDk3KXPLLCsJPGfnhw=;
        b=oAAdNDJEJ8VtwnjbngputK7jhZAlRPGLevRm47nr5NWcX4W3pQmbLFrSLLL2pEbRue
         t1nHYeufDY0YIMmsDoqKG9r8XJw/03JMsfHIZu1tC0x3paVyDu1DxydjzNuR2PXsThCs
         zCZr0ubOJsetBrE+lMmnMNC9keQjqzGxLB6Og7IHc5iF/tmvVlPMpaB4ZtvnGtvp92oR
         j2+iYg8RsiNrBUL/yLVmlapCgyXtqN1dJpuTthIbSTlelmM3T2MznXakUDsp5vyxFQY+
         hJ/ojDCeHk15UJvDatgAO13Up6/n5hpJefqI/1y483A14q4SsCX8jckDlwTNlaODXEhy
         0JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254572; x=1736859372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3ZCQbwToICSm537L8Sy2gP7aNDk3KXPLLCsJPGfnhw=;
        b=oQrMq7lFEoW/FZZoXI/T0jyVh8poxD+x8vRvjTW3urqIa/sBYZGvkMomRFJyF8JU3s
         YdM45FBZbidIDfCBKjMrnJTsQ1pXGiafxdOHkdNbE6TDYZm4mIiT80Nq8ztph3AA4Vwr
         zpljtnjlrrG51xkeNhUCb043owT4IfSEfyf8aou++AxnlNmBP6Mz/qckP2RjgOUBRGAM
         0OxeQuscgwra3X3K+skV34hLt8blgl2RXDUpaiC3KiG9AJmkboijTh7aZkFkNnFNgQKP
         aNK/+yVZfgSpyq/ve1ji6RtJP0O4ahbXNehIhC9EyA99ekVVkIiLWLh70Q1mUP8vwi54
         FIqw==
X-Forwarded-Encrypted: i=1; AJvYcCWBhYC8ZiIdPgQMccNVVmdkt42cggS0MMskkCjkbBpaU0ZKA7vANrS2JvhLL7q7GUGcdAjwf0rkW+B+1/VDmoNMLkwxbgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2e/IsNBEQtO5VyQ5h3X5MwAG3hEeLM1nJCwpR/lxXywXKSxhZ
	DdHsAE+45GvBTyJAP5+1SRkLV7QJnNMengrKTYQE3PCdWoqmsClXxQB/xOcvRCg=
X-Gm-Gg: ASbGncsb6To/S/Rw5d5Jg97dG/oKw+o1NEhoBKEANNIUFZHBjRKn82n4e6IZgjRei+u
	+5eJO9ztYWnAdrThhIdhPS1XDIhn9kr0Yh4aJbOqsb3r7VkqHdbg0rCJHiNYN0Ww+mM/hGWIwxy
	/ONi7toqfZMxCcu+UceZRuVikcQtanEMdUa6GLqcr2Brt6kc1Rovw4Bl/pQzGar61wgKeiLA6cL
	ldv4XSsYkFnskLxSJ4mIBhUcNpBzBpWbLO1+hCOi75WUblhy3Lb7qg0cove1sNAHrDiexY=
X-Google-Smtp-Source: AGHT+IH3LnvvjrofmboXcdOA469qCM6U4NR7fF54KLrYPLcSCkDti2tVbLL3RQaJvGouHlnnaL3mEw==
X-Received: by 2002:a05:600c:45cd:b0:434:a7b6:10e9 with SMTP id 5b1f17b1804b1-436686462f9mr571258605e9.17.1736254572516;
        Tue, 07 Jan 2025 04:56:12 -0800 (PST)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a546e822bsm24831226f8f.22.2025.01.07.04.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:56:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] KEYS: trusted: dcp: fix improper sg use with
 CONFIG_VMAP_STACK=y
From: David Gstir <david@sigma-star.at>
In-Reply-To: <20241113212754.12758-1-david@sigma-star.at>
Date: Tue, 7 Jan 2025 13:56:01 +0100
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CA61EE6A-F2D5-4812-96D4-4B1AF3B8B3ED@sigma-star.at>
References: <20241113212754.12758-1-david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 James Bottomley <jejb@linux.ibm.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
X-Mailer: Apple Mail (2.3826.200.121)


> On 13.11.2024, at 22:27, David Gstir <david@sigma-star.at> wrote:
> 
> With vmalloc stack addresses enabled (CONFIG_VMAP_STACK=y) DCP trusted
> keys can crash during en- and decryption of the blob encryption key via
> the DCP crypto driver. This is caused by improperly using sg_init_one()
> with vmalloc'd stack buffers (plain_key_blob).
> 
> Fix this by always using kmalloc() for buffers we give to the DCP crypto
> driver.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
> Signed-off-by: David Gstir <david@sigma-star.at>

gentle ping.

Thanks!
- David

