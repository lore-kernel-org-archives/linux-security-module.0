Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F173A963A
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697369; cv=none; b=IBydiY16e3Kq+rm5fwMkreWLQ+Hh5TdyJVcj9z6kUJGTrz8CXR1fhiZmJvOtt7rDjxihKaMk0WjFmTgRNnU+RO7QH9RKIA0ZfDIVD1BTrMfOLSTFcWD/JHnUJCMLkTAP4DazzCmFzlhO1p1CA4urs0zsmUaSFpyXVA6DmZhQW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697369; c=relaxed/simple;
	bh=5i5ggbJDToYjr2+UInbpK0MRjhOMp8AcYCW10B2FshM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=KVDfyqO5GV8EPhvWgahHVQ8DETHiYZtFc1zPUuovtXhsKVBOprp/B9Ue1RSj4HA79FngOeRpvEFUFFZaMPhClfQF64mqO3OJU4znQZgyEjbGBvzFvkJ/bfzkHC4ql+5TdacqSoSXalN82QgSOxI0kmg0KpLSBI3Y5T11nj/F5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KGxRQJR1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KGxRQJR1"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-910bb291688so18065585a.1
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697366; x=1779302166; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXPN4dHTpE7jfcaAdc50cGnTTg4+LOwthwt4QuAKe2U=;
        b=KGxRQJR1PaCSVZClxfVIJVKeHxwPD3cWdY2pOWYMa10LLM/TsqddgqP7cvfTgSO+H1
         gzE1SVSINyajtBSKI+LoPZHPrurcJiYQ7O9sZu1LskrXDFCCNUq8YNCdPdQFadR/lHAj
         9surc6QjEfE6cO5+IOmm1eO3JKcnorrFZGsCMcLm/ls+Q/ecpch06AO1zIZw13ms+/cK
         ornXau18SPFp79eXCa6lb+uVnYwvT5niFXADrp7JYjC3RwA3Kyz+OiQ+Ii545IsqNKBW
         a0wLaG8GZ+yD7+QCOTHSajNkYF8SrB4rNBTCipKPUYaflZzXkOkB9KUGrQUelMQF12oA
         KyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697366; x=1779302166;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXPN4dHTpE7jfcaAdc50cGnTTg4+LOwthwt4QuAKe2U=;
        b=tJRAWtJYKzYHayD+WlpSXd2klMW6WTDHjdj+dRMdO/goahBBJOr8Iv/MA6JkzYoq6y
         8jRc/ByoDypvaVTd8cia0rkiCFBAd67TtCy5lLEThRYn2v+B/5UXB5AahNGFmTuDshIb
         Tt4+wFjZMUqw3NiLGYFlT5LtwKrJdv5yu1fw+PLVuqhBWnB8DEPL2LKcjyoxE9ulVyW0
         BJMcMFF/TELyOxeOpCWUUzwa337fXhJP1mEvVi2SLuqhmolhovHxldbEfwVRt/TrFEtV
         tFN3ti2SlCiJgY09J68QnTcWlezYagoYeu7qnyhu3lbdB3nEigMagavPvQ57/GfT74x8
         Xm6g==
X-Forwarded-Encrypted: i=1; AFNElJ8I5Wm5hHgdK7jT0jkanW6sMj/lSH8Fzpqx9LP7JD/J+QEqPcYOsZACsgsefHcgJhyhnFsjpzdqWxhEZvznyBy2xFeYbnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0LudSYn/jcwSpntOmx5OD5PXtAycqbVjX0PYT17GcsNM3+kX+
	3zwVQ6WSEkm+4wyPcoH7UypWDTYgs9u6wG1gXI6xMc2TEfyJZ3gsxzSdiMVURCkEJg==
X-Gm-Gg: Acq92OFXpt6X965SwdjlgEQpk0X9zW5Iyp4LJfq8JZzmKGe3OyPVz3LNVik0SWp/VMl
	PE9on5IWG1bMiwQMysI0wl522xpmYmKN16dZHnNXwFU/1pK+/dlw0VzqSP9czikrTVXyKw3fvFX
	olPNR04L9BtTNd5a1/R2+lAXcIWV5lmUY+BiKyEPY1cmQwZdJz1D9vIl25Hp8D+xY4NOs2ovdAc
	BRxQlNCswb0t6XNPNrMLQde+RLfn+It7844/TzynMWHYXN6+Jo46SfwHzk9nH94hCgwILSRlKOw
	Fn8lkU9TlJfFjJJ86BQ3P9w2kYYIIS9UpT9CsHNxtclTbOVGXL8GIE5NIVgBmjgIpz19cZZAaQf
	mxFjMtaI1rMKa7aRjsUSvynHwv+09sD7AZZUuBjoobOsnZk2Ggf8husV5GkGHB4SrWywXM0PbU+
	v1RsXLxHyjwqEq0xsuvaXD4q7FOblUfrxkNoi1rbWQjZJ0uHD4kRVyLfd8w2vJoUdmjmsoFaYY3
	Z5m7uA=
X-Received: by 2002:a05:620a:2584:b0:905:ec5e:bdf3 with SMTP id af79cd13be357-90f8afef681mr641592285a.49.1778697366269;
        Wed, 13 May 2026 11:36:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc93d0casm29988185a.23.2026.05.13.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:05 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:05 -0400
Message-ID: <283fb822eadeffcccfa519cbb582a363@paul-moore.com>
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
Subject: Re: [PATCH v7 3/10] crypto: pkcs7: add tests for pkcs7_get_authattr
References: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Add example code to the test module pkcs7_key_type.c that verifies a
> message and then pulls out a known authenticated attribute.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: David Howells <dhowells@redhat.com>
> ---
>  crypto/asymmetric_keys/pkcs7_key_type.c | 44 ++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
