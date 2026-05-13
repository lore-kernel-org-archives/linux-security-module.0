Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AF3AB271
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697368; cv=none; b=BdoLpqSRkhcUamz8FmKpN4nI5dP/0zmmW3G+o6cTar1hOQu125p+ur4ly3LfmI9znWMxTM+kbmB4quY9SXs/4lBYSQ/pU1akgrNxkO+bqNEZOxliJ0zTRKcjDphK2zaoffaqDZFFHu821ks1CT+xsGhqyWFsIl6cIAKDrLfEe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697368; c=relaxed/simple;
	bh=+TqM+PtcKsHz4Xzb0T/t9rjYOVVf8Wg55mJJ72MLd6A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=koGTdTXP0tZZH9H0R8XjNNYW2HLrMTo76WrpTXWsB7j7+Mn36t+lT2gLbK6KI/Y48l3SYMhXpsPeLOsNtz5ggW+bXpyiNg6iKX9ZvRxe7swPbK6/I0s7otfOAor9CEDbHV+XE338kf9gHq4XQBNRFHHhFtSxhzuzhRvHhdu5v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZIKMEq8x; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZIKMEq8x"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90fc979d84cso76681785a.1
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697365; x=1779302165; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmWhw8+BzycLbCZdUGo17yGhh7wc4olKhqN+RMzekS4=;
        b=ZIKMEq8xkGrjNG30QC3AIMbJd4ZWWAHLxvfJ94Q6RCyNGZd9fwLroog1punB40QvFw
         h8KizRwT7DCSOqhahlu5AoaV+rubVpQRLjun/HFcvoTThml4QjLWlRQoJ5hnpDsmTHE/
         Gv5QJwFxNbvZpBjI46IdVB9Aao7868mlGoIKkjM5khsE8oQ6T9Ln5Zg9TYWPUXmtcW8V
         vdYwMl3mbr/4A3Zr2aXuX6gpQOzHHZ/+i0IgjYz+Y0zCB3fwyhxIT0i2WmCRsL6dOeH9
         /9fDED+mzZLL5XvzHn6CW3wb7jj7pt1a8irMpLgDj7cT9O0VSwV1DbsmhhA6TU4UJ0CJ
         EMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697365; x=1779302165;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmWhw8+BzycLbCZdUGo17yGhh7wc4olKhqN+RMzekS4=;
        b=IgaILwGI9ZPlOUWmHAaK376btfWxwCY4W3Y3Frto/37+id6GIZmCzoQ8XedzN5i4v4
         qa4eD2LFtNiaHFeMkawPT3r6TsnXhmBXjquYUourOjXGulL75QgJhaiLSMh1qAI+5GwZ
         4QqIHvQwO6h/Ng/pFVaf2eQDvM+ZzghQDuNlKWYr2isi+limvDZEO5iDf7XqX0zMd8fB
         NmTd5ZpinBK0mouoYrfecg2W0KuF/2Xq3B3cXa804euN5GCE2YniSJTWc8f9w5/t/Gdz
         jdzSQhJbU49EteGh/xTbJnymKKyNJyy/TFerEpYQK4SO1FX+1gY5peejJrVUGTbUHXow
         KODg==
X-Forwarded-Encrypted: i=1; AFNElJ8QoXjs+DfqGttNiYO3kx+U4RGBO6rg33UiHjsaGf4yAqQF2o6AXbYEyTwde5gPW/deGjC59BHlCw1O3NGLgt0HG+Gsu98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlJhamJuvnDAnFw+xnwoGB4lVJXbC793FGAb7S5zyPOtmZGIp
	aCpmyBLg6obBWgU7nCqXFf0E4e4r3dmIj5UeE/PPra6Z5JdU9wg49/HDU14nEKA3cg==
X-Gm-Gg: Acq92OFzk0syvgX12YepLO7jLiPPfVj+qweYTOZvvSyMlsZV4ZD5o/A/TDX4w4Wyjm+
	1MyBU3CuNV+UmmQ6lQYMfSsH4yQ4S4Ocu6+U+jf8ncL8XGHQaKrxgqVHLS/0ir2BOAYpe4gHSkm
	FbktSPRdeBA4RmnleYgvnnwb+UyHDL6bTrqBbIhnkPMo2yIknG6kD/lZ90DJ9jZ5Hs1K3iaE1y/
	BrL8cuoKVZzu1yTt6/ROjV+KuXcLj+lJbkSilyts9eYyW3W4akut9wIfDHn3O/tyCw7pzfdOyP6
	+DSXLnXFdjIiSkowkuD9iDoKoapPhLvTb4uMLfbYp7fnmdcc9SEe+0N2xbuwp4t7gTelFmz8lpP
	rqBuZvgMftePX6qnsTwQtiMzMx4RYVXBzF2B8h1Pr2t9xa+FpGyQxD9b7pEkDosE9Pj39bQVCMx
	+YBCzoBdyQ71/KFnEdXMg3VZtUOkwe2PLlcv/wATeZD5A00N7+aZEXt/eZQSwhUy1cxUlA
X-Received: by 2002:a05:620a:290d:b0:90b:9dca:2187 with SMTP id af79cd13be357-90fad385651mr655950285a.38.1778697364951;
        Wed, 13 May 2026 11:36:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3732dsm28874785a.33.2026.05.13.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:03 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:02 -0400
Message-ID: <64548a3cec806e2080ce4515777b4a39@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 2/10] crypto: pkcs7: add ability to extract signed  attributes by OID
References: <20260507191416.2984054-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-3-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Signers may add any information they like in signed attributes and
> sometimes this information turns out to be relevant to specific
> signing cases, so add an api pkcs7_get_authattr() to extract the value
> of an authenticated attribute by specific OID.  The current
> implementation is designed for the single signer use case and simply
> terminates the search when it finds the relevant OID.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  crypto/asymmetric_keys/Makefile       |  4 +-
>  crypto/asymmetric_keys/pkcs7_aa.asn1  | 18 ++++++
>  crypto/asymmetric_keys/pkcs7_parser.c | 81 +++++++++++++++++++++++++++
>  include/crypto/pkcs7.h                |  4 ++
>  4 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1

Merged into lsm/dev, thanks.

--
paul-moore.com
