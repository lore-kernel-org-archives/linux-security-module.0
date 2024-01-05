Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56E21A11
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ct+78WEs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso19268215e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704487575; x=1705092375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=ct+78WEsaxtswbrnH0nbA8K18ycZPa8iYHooRrEE1Za6+klL8RUjepj0Tn+zB5tMSc
         am11I5yjssnhLnaH0Bhhyty0fb0D2gWbcYQyT1rQfEZk6/yd+YpqP/ZPj4ifWaxZTuPr
         FFU5NadMx00DuzveSMqN7ZEH4aIGRrkBTu+is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487575; x=1705092375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=Kn5PDJgD++myIohPrAQ6hoXZH66EtHCOUSqY5IVSn/mv1//3jGYJgQHWRo1v/z2vD0
         pF1mHxXqPFV2lszCe4w1edt8gTzm7Bv2QOBnRZKRnOgDnsQNvz+01JlJIPoTgEqqR+V7
         MUkwK7VZjbkVER16yR2ncfFeWq0ZAFovQj/noo3LK5DTBqcGH3FqGcs7EyXgEImMySKA
         nly9T+rhQ95sUvI8pkiYZElXcXcw73avUY8jvJtj4MVnOMc5ce26MIEyVRl5FfOyrPHp
         XfVP1fqm7agaqdkLjyVLbJk7N2s0wd/rzZ1TctZglcztk069Z1rr56FjAAO5oXMvURrR
         Erpg==
X-Gm-Message-State: AOJu0Yzb08J+W2UgLTVwXucQK5fvbc4cHkQAkIeKCmizZByn/i6i9bak
	GyOReYm1qhCxhBtkOKtc2KlcX8NerOp7tcQRVDl+Af2JOXtr0NaB
X-Google-Smtp-Source: AGHT+IF5FbtrMtDOQaH0jhgVXpBBfgAkTKszq3uuxMHnXwMjXJgfiH30UgMOh9CtcC08WzGMEtBGKQ==
X-Received: by 2002:a05:600c:3483:b0:40d:aa42:b417 with SMTP id a3-20020a05600c348300b0040daa42b417mr35838wmq.90.1704487575797;
        Fri, 05 Jan 2024 12:46:15 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id b6-20020a170906708600b00a268002274csm1246595ejk.52.2024.01.05.12.46.14
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:46:14 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a29a4f610b1so51847666b.3
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 12:46:14 -0800 (PST)
X-Received: by 2002:a17:906:74c1:b0:a28:fab0:9004 with SMTP id
 z1-20020a17090674c100b00a28fab09004mr943524ejl.86.1704487574561; Fri, 05 Jan
 2024 12:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com> <ZZhncYtRDp/pI+Aa@casper.infradead.org>
In-Reply-To: <ZZhncYtRDp/pI+Aa@casper.infradead.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:45:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 12:32, Matthew Wilcox <willy@infradead.org> wrote:
>
> I can't tell from the description whether there are going to be a lot of
> these.  If there are, it might make sense to create a slab cache for
> them rather than get them from the general-purpose kmalloc caches.

I suspect it's a "count on the fingers of your hand" thing, and having
a slab cache would be more overhead than you'd ever win.

           Linus
