Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3313A86A
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728636; cv=none; b=L10H5ZGIhQKD7Kr3YwyPbIOa9IhH75MCfdeLHadRxK4ozV39PQyKSCuuXcxWvOi7ZLAa93dGfLjXIGx/6BUL1JZsMWAsxVJ9qoL4AtqLdZDgufGXF8Hp7ygEHSAEM4S0Md7Z8TJmqjZG4aVf7wTYf1c9cBX8HsO5d9YlwdInTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728636; c=relaxed/simple;
	bh=Cnh8/QW4GnHKArsA75LhoyBcCrCGkaxugbzr/rsboqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX2IWnakzL7s0/wSIWBgnqnI8PNnGociOBvxDr7LxYXBDSJYAltO8lgoWifx9rdjv6Wv7x5JSnJpsz8X+EbyqbgNRd5NQTG/Z7B4QDYrBvfg8qgvn8H2uFs6yAUUc0HTqefqd+4TXyJecNymU2IQlZSFOK1pYD6jWBZcvX5zUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DPdGRcoo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DPdGRcoo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa52edbcb63so186964166b.1
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732728632; x=1733333432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TFGSOHaTyRXi7GPfKvBSoio4FozsRk1EpyDqVZI+D6U=;
        b=DPdGRcoolAUcrng/FtAT4JpnhGK+v1EH45EXB0BsknxJ4UGBxa62JGrTr/2iiWTkB+
         CYAlkeT+RodXlRb0FPkim2VKkZCKnb6kXV6qowzgaAODpAIOfQRS06gXwPC6yBGO1per
         0i3ShsJjYl8oPN33Y9n8rIIABRKzZPHgvHJnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728632; x=1733333432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFGSOHaTyRXi7GPfKvBSoio4FozsRk1EpyDqVZI+D6U=;
        b=O9gx072rbYsTzUYVtv1e7ailTSNUQpqZLfbdhjh7zPCqlZtSqrijEqAc2opxVrKH3F
         2KDhjBLLS0tsefEwTy1mDYU2Z7CP9qPmYj2PShtWyUNTDsOWuvnBJqSMhSr72UVuEjwq
         qpOMMb73nRsjxQmyqL1t7VmS4KY99VkCiNoiFctguFNT4VJZYGhOFt1cYXaD9GBU0tnI
         QNRnbxaMLXL6Yqn2/phD//EYxSCDho2DI2yNtc0fXueut0U97GkfBgJKYrHFaKjyj7Ur
         JgDDRM3ustYZKYcdTWUnyevbX+PRUPG37eTIY5OVV5RhzcE6Ppvp5/MxE0ktmxcH6C2J
         46wA==
X-Forwarded-Encrypted: i=1; AJvYcCWfv+r+v6tHT3hYbigVb7jdumdR5TjbalhF0+7sAvJ27vaPMx79XEzXay4SQiO/87r/YnUpIgchS8NOtjnPrpQIoTncjuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdXsJpj6IZ/VTHBxm6J/usqI7BZY97ScmTCRCLNXupT5d8Ij3
	fkYEyd6KBKr+VICnntJQg8N4s7bvcrPOnD/2r5Fm4nangbyDqY4oluHv0KI5TFSvdfcJq8oVAa0
	Hx++cHw==
X-Gm-Gg: ASbGncvOGjsC4jLa/iKh3BUy1KifIxKLwVjXoiA5VqjgmaFh/KtGJJt4a1V5Ac6vsP5
	U1akrFL4TMNKH/IOW3bYIplGX6+lsGivchyYWJ+hYUtVHifXu7sLiPJKUOpPtJUqE6E3/g4N5Ug
	m+vhehDC5tYuh4RrGh5/JIJMWmNhYpc5VK/sXjBkmtEBVDU1R/cBKQquf4Fg8aCirW+4dDQqBu+
	5BbaxX0M5WpQimd6UATk0FP4Tlhhy8pl2e66XjoC+YlE5/muuTVhAIvF1jC32/bN+A7tWMi+toT
	rW8O8wHbYoJGKQcl0/HkWpxz
X-Google-Smtp-Source: AGHT+IFM4tSXVF7oT8rNtn15SNINz2CdaiI9Bb6HHeUtVb6RJqQKQ0w4+skNeQTtxyMfG76oL21xTQ==
X-Received: by 2002:a17:907:7ea6:b0:a9e:82f3:d4ab with SMTP id a640c23a62f3a-aa594535329mr20759966b.9.1732728632353;
        Wed, 27 Nov 2024 09:30:32 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b73e8sm723910466b.176.2024.11.27.09.30.31
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 09:30:31 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa560a65fd6so6738166b.0
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 09:30:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU82KMNyUcWw54k8WYITUUzOAzR29wp3f5J2fRJa0x+mEcljsGekgb7tAO4y+6JzRsSjtNAcTUrgfVP/Wuqijra6xuCi9U=@vger.kernel.org
X-Received: by 2002:a17:906:1da9:b0:aa5:37f1:ce63 with SMTP id
 a640c23a62f3a-aa5946e918dmr16712666b.32.1732728631083; Wed, 27 Nov 2024
 09:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zztcp-fm9Ln57c-t@lei>
In-Reply-To: <Zztcp-fm9Ln57c-t@lei>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 09:30:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
Message-ID: <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities
To: Serge Hallyn <sergeh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Jordan Rome <linux@jordanrome.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 07:26, <sergeh@kernel.org> wrote:
>
> 2. Add a trace event for cap_capable (Jordan Rome).

So I've finally gotten around to this, but I absolutely detest how
this was written.

It was oddly written before, but now it's absolutely illegible.  All
just to have one single tracepoint.

And it's all *stupid*.

The "capable_ns" thing is entirely pointless.

Why? It always has exactly one value: 'cred->user_ns'. Lookie here,
it's assigned exactly twice:

                if (ns == cred->user_ns) {
                        if (cap_raised(cred->cap_effective, cap)) {
                                capable_ns = ns;
...
                if ((ns->parent == cred->user_ns) && uid_eq(ns->owner,
cred->euid)) {
                        capable_ns = ns->parent;

and *both* times it's assigned something that we just checked is equal
to cred->user_ns.

And for this useless value, the already odd for-loop was written to be
even more odd, and the code added a new variable 'capable_ns'.

So I pulled this, tried to figure out _why_ it was written that oddly,
decided that the "why" was "because it's being stupid", and I unpulled
it again.

If we really need that trace point, I have a few requirements:

 - none of this crazy stuff

 - use a simple inline helper

 - make the pointers 'const', because there is no reason not to.

Something *UNTESTED* like the attached diff.

Again: very untested. But at least this generates good code, and
doesn't have pointless crazy variables. Yes, I add that

        const struct user_namespace *cred_ns = cred->user_ns;

because while I think gcc may be smart enough to figure out that it's
all the same value, I wanted to make sure.

Then the tracepoint would look something like

        trace_cap_capable(cred, targ_ns,  cred_ns, cap, opts, ret);

although I don't understand why you'd even trace that 'opts' value
that is never used.

            Linus
