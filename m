Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7E3033F5
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211755; cv=pass; b=oF5t+maeuM1s+43Ihp4DlqwGGx9qQI3xv4k9/IogXJkmZdBDN2g9noUjFVOh5uJGqeiuqvfcPh4Bio0S4hWElGs0t0mFFbrulKZ9UjRnZI0iXSstOdH5hIG9vHktZxJHRTOS8+f7UW8RAyR9KJMKYxMr+NjCwo2XcNPFWPC6uIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211755; c=relaxed/simple;
	bh=Fwh/MO9o7v7NCtTYLqcTvPNYtsTkXid+IQD5AJSnjKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIUsY/jZKZF2dtjTtD0lXSewG/7kOmIhoAX0n1DKKrGrNYOhG0f/HenqQ36ROA+/rnv6Ouvq93/Pb2c9Vvc8WBSHWEXq5Cu9JGH3KV0EMEJXIaA2Cu9ZlwZtNEFTLXrpOssaleUiUM2WQKnKGXX1V+4eslAPhh51XsGmeM5zCL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elcP7mWF; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elcP7mWF"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c4bde55cso5399934f8f.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 23:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211750; cv=none;
        d=google.com; s=arc-20240605;
        b=PjszyUL9GWB9YzG/qW054cak9ysNGhWf89yE1/AQJEPjaKM8BvKMR306R92WeeJ7aD
         hsCdK+oEPYpJRp+unyGtt1MjuUWDPPh5/Xlmx6r5MFoaRipZGK8oXBd1CgTSFeUAkpDW
         aa4VYQaUUZjwoLGOnfZ/lsWeVY2GWCtqB/e44fh11iK8C259zZKULYam902nOnbxnToV
         6sg7D38JlUTuhjB9YWUf1sKzgUbFJgveq7DQcSHNdQH0XULW+xuU+gBzD7onSCNADAqi
         27HiDZ4dHCKkoZc8m2xHJf4aR8WDiTnpLSMSNWxDQww38uvrq14YATcMiuCvPwz9bydm
         9WHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SrnqWnXBXRIKJhr9pVR4ushv0J6oSE6ak7AT4kSjDVg=;
        fh=8RXZ3FuB7AK8xOSesXSFirIrVR+xhwv89sXF722P/JM=;
        b=YrxavT001qjdh12RW5Ni/QfLMMM1TUZbKuz1O6Y6auwexjrg7ZFDZKRFiqF/vcUpox
         gUBUwdgg8sb3VkpCL8cMcUb+nw7AJhg+nGekwthql3SLrmQkv4GhrCzhzp6P6RIZNzvn
         2eBQX8nEXQ3QPWYUr1D5MR3M+oChn03bP3yftRT5rdTZAjmX5mFPsaP5y1kx0/9C1zhM
         Wih7GLV5eHUAFIS8P8Amv6l55cg/Bo2hvBbNgvCcFHpkTI7aY/5IRnYAtFRnhuS4LGeQ
         ffTBiyXJzU5vcVs9ULO6F/auyZbbuU9uTxU4Q7vtO8YZLkfqJLk547Mf/zCA4jGGIOgh
         WTgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773211750; x=1773816550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrnqWnXBXRIKJhr9pVR4ushv0J6oSE6ak7AT4kSjDVg=;
        b=elcP7mWFqtONYIFpEXj+rVXkCEvnxKYe0ctbTINVsxP0xy0Uen9AbxrmPwnjm+uTGe
         q0qoCkMjTg3UBy5p1lZX9Cs5S48IVMHVCqXL8UOxdzotW5Vqmy0KeF+TO+LM0ng/Xq0f
         1R8mwkbAF4fAw9j4JQrI0u4/Hs84tEr84uDkd8qW7tYQFtJCSaLQuhah0AvvBpXgFiDK
         dYYkiAHtQzdLQS7yMuoPz7mgMH0+AMi+hEQdLd9/0sPS4EmXoQAVC9ReLYLJAmVO7Nu9
         lUUOoZprKXgk/rieHTmyEuZbustXKDKQym7BPWoTR1LcGPhAgjPB2Dod6ahQRwGBwzyb
         EUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211750; x=1773816550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SrnqWnXBXRIKJhr9pVR4ushv0J6oSE6ak7AT4kSjDVg=;
        b=L60ertEehffEDGEFprE2fLA7ewuZz3ynlsKj07XqvjpH1vc/G9o4LmeVkfQodw1Hd6
         IrSkPu6a902uOeDHlmtmT4/Iwn3Y7p5HzzGXv4gSYTX8OvY2n6Y29ZX6jZcgaBuER64L
         BVk0w/7zU37jdNO4jmJ6Z9bAUZL41Epm1ryCeQQH2aQMmHIFc+qx8unRlh8uFmxTkvo9
         KPDV8SS0jvs+GmggSv1Ovgq+jPwTQoYRR1heWNGbc8d33MTc9xE4DUph2D6JsN1axhxl
         y0hzFbkBLuTxo2N2V0Ktk5wKea99GpMhqc3VUXMLAe3ry3DT8znwsobJsL9QcBmat2mm
         GAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaCZoAhVA/fu7nXePhGmXiwyV2nZbhsn6ox5WOGj+tlkakBRv22Q/4pcZvkP0kZ319B2savMdYAujOM9myKJDTFWtgoGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HgF9fPoY5mi2OnhkgDE1ZWOHwO7GuiOS3pGI23ZG4MglNGcJ
	dEyVQD1ZbKXD4BUmIr6t+DMGiW5CfIbxyQXzZ4Ugv/INB5ePo9cjBkb9XcaUKC6AKROPnIuSGKy
	sI/+QcehlQQjsFUOp+mvPRwAge27NVzoMmWss+cV0H6tkytin97E6J2Mv
X-Gm-Gg: ATEYQzzZv8HlkLOqnEQdgqtyVS8O0+PtgGMR3gnUgmN4Ky9hVKlbM1O1aV0xj7X2TJP
	d447U9JC5tOZKZmwFvN/WI0w5jfZm79zihUgbIPNDBsFVo3hVsM/XdTGei/DLu67Y4WC6EzkpOm
	T9hrhyZ+BMpXBG/jBd+YEyDpOLgajQPZhGPNEmNnn50FxZF8jqsLSg52JrO/Gq1pEFJii0JlQjR
	nL4p8cFgngivBr9wTGDCRwvhmi62nA0T20ZCwmVpMkRnFBZAcOUhtGXzEFj+ktHFf42WhZes565
	krZayrdmR3mkitGMKIXwrF7ReMOP9jom6sLECJhC8pDbTyv3
X-Received: by 2002:a05:6000:1788:b0:439:c799:dbf2 with SMTP id
 ffacd0b85a97d-439f81f3d9dmr2811088f8f.9.1773211750085; Tue, 10 Mar 2026
 23:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0102019cdb4c6011-735b3e40-8c94-4c16-ae3f-80c912784e51-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102019cdb4c6011-735b3e40-8c94-4c16-ae3f-80c912784e51-000000@eu-west-1.amazonses.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Mar 2026 07:48:57 +0100
X-Gm-Features: AaiRm52RB6hHkAmkJjJ7pNSI-4ccOnoHfzdE2Qw50EvTH2Nnf2GCROwwpkRGuWg
Message-ID: <CAH5fLgiQm=2YYvmG54o-MEt2m8x5V5xZrtmsqEUtuB9OZ=FPOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: lsm: introduce safe Rust abstractions for
 the LSM framework
To: Jamie Lindsey <jamie@matrixforgelabs.com>
Cc: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	ojeda@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:09=E2=80=AFAM Jamie Lindsey <jamie@matrixforgelab=
s.com> wrote:
>
> v2: add missing Signed-off-by tags, fix short commit hash in patch 4.
> No code changes from v1.
>
> This series introduces the first safe Rust abstractions for the Linux
> Security Module (LSM) framework.  It allows a complete, policy-enforcing
> LSM to be written entirely in Rust with no C boilerplate required from
> the LSM author.
>
> --- Motivation ---
>
> The LSM framework is a natural target for Rust: hook registration is
> unsafe by nature (raw function pointers, C ABI, __randomize_layout on
> the hook list struct), and the trait system can enforce correct
> implementation at compile time.

Hi Jamie,

What is the intended end-user of these abstractions?

Alice
