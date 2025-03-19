Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC61DEFD6
	for <linux-security-module@vger.kernel.org>; Wed, 19 Mar 2025 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407939; cv=none; b=nGFCjqO+d94mUMq+s0KEMPrZ5p3EUkycwG4uQXXNt8NAN/OiyWVZBgCbm835PAMVe780Rb5HCoY8ruyaUUD6nRNXOg6HR5/HzHb/upi4Wk0qHWX72PhMgaC0HGtkbit97H/xRXAAsXSQepk12qD0q4B3gZTDvy0wCxBudoxFVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407939; c=relaxed/simple;
	bh=fFeqEDSx+gFrh11ijFVYJhwWlYSMde/JsajtuuK8bvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALFqEw7SENWfo5XDrXkkqQWmwPjvpMYzc2HAGZw0vbPd5nTXsOpOOb6ba/yHOT/I0BhZpmgjxr9IPmi/wGyveXo46njeaw+pmbg0ztFkbjnjf7UkKfCJgnVqsxRksDQfttrtVQ1Rv3w5fGYcj5Hq2+fnNWmYyE7iCsMrJ3g/b3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SO+my/8i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SO+my/8i"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso156073066b.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Mar 2025 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742407935; x=1743012735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtsDpMKG3PVh8c/2wdkRvEAKIrMwiuW7c09tD+wzsRQ=;
        b=SO+my/8iQC8Sry5gW8ScLtTJKz1xPXEWyhJqAmZk6pqTd7ZwdCTM1TQFPBDiePS1d+
         T2u39Hctl8SR4BwtPK1xiHhBW8z3V4hBhIxnOdJ3qzOGK1nSPhn5TIYUixr6dvEsh2bx
         WQPpNR+W3NXEtmu93UpOmsRDn0+jGh5+nwijw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407935; x=1743012735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtsDpMKG3PVh8c/2wdkRvEAKIrMwiuW7c09tD+wzsRQ=;
        b=j4cAnGVBgCY716mV9bZxDDxdPkNqCHUV/rY4NBuq6DT21TLxqGgBGxRr+4J5r+QobM
         3evJFAjt+3H37HGtVMgbHloHGtFZ9k0p5OKSqyc0ABI82r0OqgQKJ6Fa6Bnx+JsOtAuH
         OiTKh8dlbnwy7Mcd0KXAoyclbAhu+omUYyWWI9FnyDGmi/fEBp0zvfPHAC3AfZxpzLH2
         Nv9AfwSQGWYVvgkqMbEDmAPNyUdZHgwhZGjJafAsE4IGdvtgXdG8ZkmVxq5zElmujEjR
         58GqvJ9h58fBTIOUVOXD+cgfLDb3fJWmfgjf8uGFba5ooNMoCapU4ZNUUjfKWbpwo7X8
         H7qw==
X-Forwarded-Encrypted: i=1; AJvYcCUpP13evjvv7pZfXOG1Y/oKwfj1XwRc1gbIDAOKMh/FlkEi7DMTk5CHKTzFzq33wTWl/DqIoX1WpsS5dx/5L4h6hsY6S/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAq/Qb0eJNozE3gkS7f61uNcCXbY3WLKsZjC/Ji9jphtfMmCV
	8JRY8XkMT3Q4dbJBL+mzwm4xpZOvk+Vz7tjDZvl0yY2Vm0Ha9WjgoskJdkhmQSP/YaqQ2cnsV4b
	SSec=
X-Gm-Gg: ASbGncsSJN8uD/7iq5SjiAIzYMkKxJZRBHHU8tkbZszNrStzJMelnUvErHOL2YI1NRv
	ga9eteb6ZIToJbU1CvrioMam6zKmf5pgZ8A8OXn0GToZWysXxeOSzU3jdsU/u9EjjCb0KA2C13a
	mPw5ntkk5uxXl4ugYqdu3FlPbTEzgrXhYlCx3tWyLZ1c/SvEWtArIwEH0otn3UD5XLbjMs0kT8J
	SQgkQ2y32zGfQP12XFoY7dagE+oGEDT/yaCCpEEnMfRFkIlopEOyObbXtHo1A0At4kORR8CU//n
	l/dO2OPKd+An454awOtkxtL9SdhNjXqyIx6h0pCeZEtPDkX34asua53bgwMnPZ72XJu6pFDZ6Mu
	/6JGkT13aKgpwO7XJxQ==
X-Google-Smtp-Source: AGHT+IH3sBVWEKgP8OVf78hq3JSrHhTIdsUDN29sYSHmYHS4P+9IitE9R8AKvihZ+hA4OFSONEvsCQ==
X-Received: by 2002:a17:907:728d:b0:ac3:b44b:de24 with SMTP id a640c23a62f3a-ac3b7c17b4fmr473593066b.2.1742407935502;
        Wed, 19 Mar 2025 11:12:15 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e7f32sm1038879166b.43.2025.03.19.11.12.13
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:12:13 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso156064566b.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Mar 2025 11:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZZW24EI7FCwZj3jEGXA6BPPJ1InhAmDij15iO1dHzP5WRNn991PSWseSgT/g0eUQJOu5eVbhtjVA/gDSGYYsDQ7iFyiI=@vger.kernel.org
X-Received: by 2002:a17:907:ec0d:b0:ac3:bd68:24e4 with SMTP id
 a640c23a62f3a-ac3bd6830damr446966766b.53.1742407933026; Wed, 19 Mar 2025
 11:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2874581.1742399866@warthog.procyon.org.uk> <20250319163038.GD26879@redhat.com>
In-Reply-To: <20250319163038.GD26879@redhat.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 19 Mar 2025 11:11:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqidLD38wYUw-5Y6ztFdAvkX3P+Gv2=K+rpkFBG-bf7g@mail.gmail.com>
X-Gm-Features: AQ5f1JrIwulbm3bCXYePiRgtmwvEUEXDiL2TRjJKyWZ4_ecrDX73K-AxzmDTtIE
Message-ID: <CAHk-=wgqidLD38wYUw-5Y6ztFdAvkX3P+Gv2=K+rpkFBG-bf7g@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Fix UAF in key_put()
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Josh Drake <josh@delphoslabs.com>, 
	Suraj Sonawane <surajsonawane0215@gmail.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 09:31, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Can't resist, smp_mb__before_atomic() should equally work,
> but this doesn't really matter, please forget.

We really should have "test_bit_acquire()" and "set_bit_release()".

Well, we do have the test_bit_acquire().

We just don't have the set_bit side, because we only have the bit
clearing version (and it's called "clear_bit_unlock()" for historical
reasons).

Annoying.

             Linus
