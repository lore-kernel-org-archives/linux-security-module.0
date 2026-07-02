Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8C3C5DDB
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031592; cv=none; b=URpbGiXGFagyRm9ZGZTf/sxt+qhb5g4vbXEfMt1BBRC5IVjsfh5dwRm9M0GytQxMZyeR9BGt3qXu28N4okqtTRDw9yQ3zGDXAo2SyCH5T8ekFtl7WubocNba90MCrfSe5rI1FpqUUaiyMG7fPptfQGZVbB5rVdLgpP3OjCB/S8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031592; c=relaxed/simple;
	bh=g2TLxqmYsDcWlbonN1FiCOaGRb1Al5ceMdi+LTYuhG4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MptreQjR0eKcI+PInXbwWif2I7ZXyp6BHRs5kN1FnWt8IkXwzQfrTH4tBir1dw/TpWc0+FrePRfjEMxeebTu0eH+MvasFoRltDCc0YzUNqQTZMfr6LKmFgZU3b3WDa71IQClRySHYR4ED8gbDGwwFKTFGp9Acsu+5o42y8dOFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfX0AKNk; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfX0AKNk"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a18e363d52so987099eaf.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783031587; x=1783636387; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzsqf9gTGwcZ883+EjWafMl/QLmheDnAUcy/59Dlq2M=;
        b=CfX0AKNkR98+VtyMs+zHftNOHI6rI+iRuZ33w7BnZMBr1SBYDfAiHi5ilq0HkLdtEt
         yjb0+ROxMTH7sY4+hZRxKeSOAT+Q3lztQeflQU3+3cIxH59t9x/2im/CeSUIspb5byBq
         BxpfPJWh8yqYN5lB3ta9ho17myFvpyS36lKsoUXE4iIIkjMHJf54fj1p4TaDj1QJ18cQ
         cTR0a5teGeD2j8w3sh1iNx79EWRRQ/qKGx8lgRJL7VbKiYC3Ab5Hk4yrmIYP+ACBVEM+
         8/Ee4YsJPpHKjNhjCQ8jQWOgTc5ooLmfchsVF8+1c1MokUjHNHvN0jl/bqZ2PQCGW8vU
         Pc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783031587; x=1783636387;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wzsqf9gTGwcZ883+EjWafMl/QLmheDnAUcy/59Dlq2M=;
        b=jqRaZlWJsDqcVhguu0HkL4u/lhoKbl+sd3JaflNCG3YUcxRwB8TDVMYTnUvEi3J+3d
         AgJ32nH4hzgT8qpQY064PMrf28dlNA/9QzrL6jZyjEJq/uO4++9t6JVLzL3TDIUBDOi8
         r908/Cy91rzlKHpgSzEOKUg25tUDc9dOkOaEOc/gloa7ewVkSG3p11UV6SnilKyFEg8o
         fy2ncUy3vp5VYtbr+iS+6Boy1oAE7YRO1yPVgsqM0fYZVVJTs2nqo7KA5pCDRc+x/nEt
         XxAxRhdUGcPFVAcvhXYS5Yvw9tLJEgK7byGtRY0Wj5WPViHW32hE67nb7gm/bimu0QkI
         UnQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kpZbHwARF0MRNsQKqzXRavoCQ5NEzktIuGsuFCSUdTGEOqo9xX4O/wbJaT3iSXkI62PibefoNd30z5n69YrlR6m4hNJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX5LLwbkjijUAWGUWjq3b6kpp/wR4oreSb2ILg89QBH2dmXOS
	82nq7dBJkIXynsX2Fi39mqqR93QqexsdexS2pOxg0OCNVtt5TQ64P4OXDkFTcg==
X-Gm-Gg: AfdE7ckUlu9I0g+z+TNebUQQS6DNL/f5pDID+ChSuIYRu0aNyezXxhiZKmDOfAbGxEO
	3WxAk9PTv+R8lt3nPcXjE7mNKdkQuv/3vb0EU/lhOZ0JzfGe55NeINdiWeChE/N2b0kR78m9LL2
	R0OMKRcsxSxIQY+g2YDgwxr/coTjS2AIUC3hAMBcDDrb8IHTRXMX45/6nAr/Afnfsp6TD9MnkTj
	Ur7MPD8bXHbYAsfR7XBBg7Rg7JUdz/FgMGqjAcVTU7Qn1AG1jW+27AtvZE/LeGqsgkio/SJOrnI
	+yrPlA1nv6gLARMbKy0ktUTdHIF4osZmniK8nfp6uI24yGl+moa1O5BS6ISzV4laCRcFQ8449WD
	sO5S9EOmwa8q3eIbsguRcJ4OPGGKmPFdyPSW2G2V1obFSQU+9F70Kn2kt7bqBtXdBr7F/eYFzXb
	1bOYWYmEoa6LYM0hMImF7hkIWz1qN0726U7wWFVVR5RqectjoCu22uxWK0NHc3jQm34jsFhVMoQ
	ReyUw==
X-Received: by 2002:a05:6820:1b06:b0:6a1:93a5:cd6e with SMTP id 006d021491bc7-6a31d501303mr856042eaf.35.1783031586590;
        Thu, 02 Jul 2026 15:33:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310020e13sm3009434eaf.7.2026.07.02.15.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 15:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:33:04 -0700
Message-Id: <DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com>
Cc: <ast@kernel.org>, <kpsingh@kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <bboscaccy@linux.microsoft.com>,
 <memxor@gmail.com>, <torvalds@linux-foundation.org>,
 <a.s.protopopov@gmail.com>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at
 load time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260702143605.252797-1-daniel@iogearbox.net>
 <20260702143605.252797-3-daniel@iogearbox.net>
 <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com>

On Thu Jul 2, 2026 at 3:05 PM PDT, Paul Moore wrote:
>
> As I mentioned previously, the security_bpf_prog_load() hook should
> not be moved.  Its placement was deliberate, and moving it as you've
> done in this patch creates a security regression.=20

not true.

> Without this patch,
> for processes where SELinux is preventing BPF programs from being
> loaded, it is able to do so before the process allocates a potentially
> very large chunk of kernel memory, up to one million BPF instructions.

only when signature verification is requested and the hash over insns
is what your hornet thingy did too.
So no regression whatsoever. Exact same behavior.

> With this patch, even in cases where SELinux will prevent the BPF
> program load operation, it is not able to do so before the process
> triggers a potential sizable memory allocation, opening the door for a
> local DoS attack.

Not true either. Worst case is 1M which is 8Mbyte.
Not even close to anything DoS worthy.

> In an effort to work with you on this, I did bring up two alternative
> solutions: a new LSM hook for the signature verification, or the use
> of the existing security_bpf_prog() hook.=20

Sorry we're not going to add new hook because Paul has
non-technical grudge against bpf.

> While I don't like to do this, you haven't given me much of a choice;
> the security regression can not be ignored:
>
>  Nacked-by: Paul Moore (don't move bpf_prog_load LSM hook) <paul@paul-moo=
re.com>

of course. will keep it and let Linus decide during the merge window.
