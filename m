Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD32356D8
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664268; cv=none; b=U8N7uvK4ZvtcME8cCrUjlrk1OgE2Omjs28ZGhx0l6c+NjPXeWLB/C3Gb4/xse1lGLsqymIUjX4DIJ4l3PNZTD6rYwgyJXfuq+ytcduHCIq+k0pqmuJ91q52yJpr+J/YMwKy7iIBWAj88kawJ3jYLtB9FjtJQJm9J9Y5rc9CYdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664268; c=relaxed/simple;
	bh=eGNFqynuBIFAxQfgXXE+O2+YXzwRJnVxUyYET5WrhRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPPevGIhpwbVO/ev49hJ0JW9OEtb8Wq1ROHzpWXIzcUsI53qVcz5X4pwWenPdkoNNm3VqJ6C4k6NAgy0O15s8sUALXm9lXp+4Pc/AisBJPKQ2Um0Gc2of8OIIqk/ctlSRtPrmx4fxwiQqsbB70LCModZLdLcFsysCt9dXElSUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RI0tmLNY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RI0tmLNY"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so169230a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749664265; x=1750269065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNMRIvDjI5OxxkQoJ1BipcgVGMNLMdRP7oKxRHfqUb4=;
        b=RI0tmLNY5QEW5WNz0qYhzTduHbXV9A7XSCW+/T1xDaZ6lNU7X9SCDyLEhST7TaBc93
         MBdGjX86j6RXXcx9PTiIpK8iMo2omJxdB92F3S09lzu5yMNukm6D9AMlFRyK0V3slTz4
         kDPPlWnT2G+ZnNf68deFFKwujeMXh5uhZpsYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664265; x=1750269065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNMRIvDjI5OxxkQoJ1BipcgVGMNLMdRP7oKxRHfqUb4=;
        b=AEBMbgA7RiUd2d+yF9LBgfSBXelu8iCqcZ8ZYO3cPykSKuIgS0z9M6mDKzIKD7vrcg
         8H1QiV8z+JsbT2EkEwxkTyzq7NR3ifYNJDLlehvUoYs5G9RM6FPbSo3Y7ikqigjSlJ8f
         6UZrasOnHGMwf6zw09+P7chPUfb6wqhE0lRNngGuQe8XBlIkjNzRrTVykC7ASzvj/DPi
         ZRTM3gpddfxiopH51G8qQFLf1FbL4MFlu9CRTDpfHYbVLDc8IFAxdFVu1dQsSXF2Zw5Z
         qGMV4QW+LWuN7afU/P0e3oYUSwCIpKH9QL60Brv79TjLHyQZsgkY8WVOj3gj3PxJAB8y
         nDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpW6ri/C2GndlFlVdvpmF0blNQSDoElZn9dkAFwrpxJYBIymMwzvUG/q5LdyLx3y4+9kI6FIjXDoS0sonLqA0fe+REiGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgz9DoCZIpeD+bEXY3h7IsuBA6qCOF+lOrBVAfkoMCL8rki1fD
	LKenkqHfLRUvLR6aeY60DKHyg8jfNLQ1pBM4JIEuLa1kyEUADXEKRpb5vWYJgHnCRm+PdYVjmOI
	KQ05udhQ=
X-Gm-Gg: ASbGncvvuAoNuleWiYIFyDuLoY0LijvrBqCr8t5jgr5Hly/eaVX1wJuKg9zEQlnUAax
	yYVedmq7MVItIJbXdSEXhupmn9FmtF62eiAcovNcuuqophZo9E5YmcTBa+3Q4aU2C/ZhxE1LSrW
	byVX8IZTz3eHtAba9LzGrUVqEtexFDp3nIBoyVeY5W7Ff1re0qQbS6B09fD1lE5YGdggxD1RZAi
	/8TKoKwg9sbw3UueLUqn6GyMeYsep4sK4OaA3J5oGVGF2PbOyfmmSwNEq4EOehGVC1SgVa/YwuM
	FTF1+zNjPiJ622MthklecLKWhVDAliubGRagmEz0KVzsxCFpLl1VDOOkLXg5vR+XljsB5RWC3Aw
	H2A7ntUSgE+Vj+K1LcRSVm8gbxjbAvqnJHBeNK/F9vx7jTd0=
X-Google-Smtp-Source: AGHT+IH0SGe6guLObZSHjSTAsFNd6EeHYfBw9agz0AecvVn2QHE34ONgwtvKHSWfiTj2EPoxw+cQOA==
X-Received: by 2002:a05:6402:26d6:b0:604:5eee:6984 with SMTP id 4fb4d7f45d1cf-6086660b242mr419453a12.7.1749664264654;
        Wed, 11 Jun 2025 10:51:04 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6082d59fe90sm2792739a12.62.2025.06.11.10.51.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 10:51:03 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so2267448a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 10:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVcyq2CWhm5F3i5YOgH2jyYC6mGLUwAInRvu0KIrh9RhjrZYyR6aF/BJiZQ8ZgnSHlmqsbc3knMeYDOPKe90UylC4cTDk=@vger.kernel.org
X-Received: by 2002:a05:6402:430a:b0:602:a0:1f2c with SMTP id
 4fb4d7f45d1cf-608666342e7mr349953a12.9.1749664263059; Wed, 11 Jun 2025
 10:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
In-Reply-To: <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jun 2025 10:50:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
X-Gm-Features: AX0GCFvhYmOiGos_n7MIyKSpEE5Y2P1Gb8BenhLqBoBcFZYUdrTRYSzOg_XV1WU
Message-ID: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 17:23, Paul Moore <paul@paul-moore.com> wrote:
>
> It doesn't look like this has made its way to Linus.

Bah. It "made it" in the sense that sure, it's in my inbox.

But particularly during the the early merge window I end up heavily
limiting my emails to pull requests. And then it ended up composted at
the bottom of my endless pile of emails.

I guess I can still take it if people just say "do it".

            Linus
