Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E627EFFA
	for <linux-security-module@vger.kernel.org>; Tue, 16 Dec 2025 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853514; cv=none; b=NeE4AvZfPR4oEhppE6qD/Wua0dfJES24UsCGrbCAxHuwiL3RkEhZxlwkwrsiwCuaf7PiNdWnhZ0lY6NpqQfJm6xeMGIJ1PIC9mzJu9uid8Fcaxs8GCGR7KPLtOr1IozdVnTn8W/0IkLqqxm9+WhIebVn5AvH0oGCJ8g5fOFQ9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853514; c=relaxed/simple;
	bh=V+8SFW9yEGjv8r0Rmmttsp+QjUmfglzdrODtQh4NINc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KgdtI6CHKI2kdUN11lntGHfe10mYN8acRw5wwxZa7OGTI40zeGlVa1bgJjeU5wGmUdKgl0x1WF4MzCMcDz8pH/lfinGfF1WZBcBzjdnzS47GrvUUBS3sRwv6bXOjbdZ3CpgrK5XsOuBsnCMEkMizTTjRK8YT+BgaCvB7Yvw55+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bgl0TrT5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bgl0TrT5"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8888a444300so28992796d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 18:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765853512; x=1766458312; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owNyJcbfSj8G+1UC1yCETkOzy1/4s7ICSRGSTRNixHw=;
        b=bgl0TrT5ieDjgQwXTYt3Hrrd2NJ4iCn2A/7yrw3mhzeB+Jy6BsO6tPRYEsnKSgprKf
         BiTXmotefz3Gq6At0hZtO5M8Wi0U/lxyhNnSY/BJeIfjEGn/3YV3nxzvPI6DVW9WMVrB
         77msk3/blTpuNVor3i9+9LkrtFzXyEOX1CbaigHAlkrK2caisppmLRTRyB+0tSOO5GaQ
         h1tGmuh2GnEsNjpjG8+MByXlOq7KGiDm0V6v94sujPKrsdeLmWEq09xN8CXmvtA0+7Pi
         a6+2DcD0G6CBfdIpcVPRLtZqeXzEROMy7Fzeb4go5W5n10rBeM8GlYr099JqXRVAeJSj
         lW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853512; x=1766458312;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owNyJcbfSj8G+1UC1yCETkOzy1/4s7ICSRGSTRNixHw=;
        b=nnIwBz6jndaYWWvoU0m0vODssZc3c40TaCSIsyqlHtJURg9pBRxLeIL7jZj2sp0kV1
         9TLAhvMrhvN62S8OtlqLv8TJTbaUA1QuIRUzyMsxktFl1ikoyM1U8tuMq8gK0b2IK62E
         Sm8awU7nbkZE0WNPfKCoqQeS2EaZbwgujEAVFOzpKG9ZPie94DQlFiskapUoVpBCViaB
         M3op80Q4TIKZzP8i+9zMhWp2oije1Ry1BNG/gNWbBsfsLmyIxmZt92sOrl2i66bXKhO2
         J8Q66bvEEgzgmX3JAmFFQjH9Wq+14wA9hJUdBM9c4O5iY6OycAiTP5MrxSVL981WvdL3
         XhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4QROlQ8JAXLQjTeTHZio9kTUrlrg8wX44kChw6oxbIDJ5n6R9DreRNIVnina1+xYLSnG7iI96r2L1uxhOBxDoHOnsnKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnZhB13862wu9IG0zw/hQc9jPa+vPl5bwdjuJAH74KM+U52pN
	BDhE8TsYcLuj3C28M0+qGLutSI1a4/tJfN7b7IlmFNbvBPmx43PHiSGcxa7zbPSqTQ==
X-Gm-Gg: AY/fxX5eYWoPHnUZ1LU3p8zLGTgf02CIKKnpk1JnbarZfzZ0uehkA1RTiNvcuqPraoc
	AGztAvPq3JvcLWiZa2YrZXBpt+XNypr7R2Ol+Q9LDOaHeNhUAMLuZLj9Chk0uni86WQDmPp/b8Z
	vfdBM1rstBVUnriPz9hLFQJ7SUGvo+VCFwsKJoXI0yqyzCyQOjk3PfcOTzpHcA92qCcRM/v1gcA
	Kq8z0gsDUXgj/GUs10kkaudBL0TL7tj2WmkneWBVhnGz0ag2RBQvUjEwotiIXMlIW3orXMhNNq4
	uZirj0C223ZjXU2H635vrpZPrxplY7QEbJZ4ytsdZS3yJXzkUKjOjH04keJe0+uJAYwGwm+4gf+
	KzYHmdBXmP2GdFcsOk29SM+KaIP6H7B4/EHXmLjr7E28uZenWVgfaUPeuum4jcXnHX2P14mBucR
	vD0wyUKwRTuC/BW8Su4CWtB1jj+E6G0rCmYTPKFEfeo0XQBxW8gDojGmkD
X-Google-Smtp-Source: AGHT+IEMqHttnDTZnChnTJMgZ+vRj3m6pgvUAgcud9zARHPxAqUZB0u47RS1U3Wdc1+qrq1TO0hW2A==
X-Received: by 2002:a05:622a:5c13:b0:4f1:cd55:d9af with SMTP id d75a77b69052e-4f1d05a92f9mr170372191cf.47.1765853512073;
        Mon, 15 Dec 2025 18:51:52 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345b4b894sm7763971cf.12.2025.12.15.18.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:51:51 -0800 (PST)
Date: Mon, 15 Dec 2025 21:51:50 -0500
Message-ID: <e9393fe7171f848616036f0708b1cada@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251215_1137/pstg-lib:20251215_1136/pstg-pwork:20251215_1137
From: Paul Moore <paul@paul-moore.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: fix kernel-doc struct member names
References: <20251214201539.2188497-1-rdunlap@infradead.org>
In-Reply-To: <20251214201539.2188497-1-rdunlap@infradead.org>

On Dec 14, 2025 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Use the correct struct member names to avoid kernel-doc warnings:
> 
> Warning: include/linux/lsm_hooks.h:83 struct member 'name' not described
>  in 'lsm_id'
> Warning: include/linux/lsm_hooks.h:183 struct member 'initcall_device' not
>  described in 'lsm_info'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/linux/lsm_hooks.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Randy, merged into lsm/dev.

--
paul-moore.com
