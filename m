Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCF143C5B
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399907; cv=none; b=abC3Dl0u4jFI/oGsWRxxWXLYz3EsmK05Z0/5mQK6EhDk0Tot2rjgdmo/vOtxGdRQG7H19AaiaHyCi0RH4LIVsF0sMZGdtb4nra7wtQwbOn0XL5076P1oeopJSImZt/0Ri5r38M+2e13pXdoFChcI7DXTuf20IPWmQWVBjECU1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399907; c=relaxed/simple;
	bh=3aciCKn2C/o/gcIQNjenoGJmglB3BvsgYJj98ymPKks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5F3XtnSmsj1fF/zJinoYrx1VaPUEtuVIRxSxoJZvKAiql90zPnXO/9Zxf/IYuehRJsnAu9xNbjlmg78rDu4kNUNzFKkeQciI2G6dFsZkqQzW3njgr68UsnQ7ZQoQwbexobI/Cj9pWM/bGPvO7Maw0wi/LqGLaUl2+Mo9i0uiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDr7EHc1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDr7EHc1"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso1350a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716399904; x=1717004704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46egnT16tVwxmfnNBO145wZ0ppbM6j0s2l6EqdlS1tY=;
        b=bDr7EHc1MQM5ge0wW8OyziytM+KI9E3eZrfmhBpB7f0+41x3yLL9B1B6ElILkf29yO
         Pk8CobJhB3P8uOybyqMajfjrh99bd+lgZo+zxeBdSiJpC7BWjSFdtt2wnwuZ9t9H+Ycd
         b1/Pb4jUGgbxIUoPA559+8ouk0/BKWUo9Hf79eerxdA1XwJpx6KzXMwes3KXToRoZPvu
         MVe3Zz+NNTK4CuFUwIVrMzK9XJ5QLzrnAT6T3tl/er7MmBxzu8mgRuhx+1Nmsg9RdGTC
         AfUE5qhwqdndruylfGtcaxXTqklGRid7IdYw3uY0QiLCeI4lEI4l/c5HezuDjyn6hpqF
         1Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399904; x=1717004704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46egnT16tVwxmfnNBO145wZ0ppbM6j0s2l6EqdlS1tY=;
        b=l6TlbLr9Vrd1RYBx3ziK0q1vMF7doYF4QUdAOqJdmflH0jLykXt0T0PDMBRToFxDMB
         5XyioenD50ZF37aoQjYr2un3Yc/a8fZAR/2rfLK2FCpblrG5MzQ+rnZMhCzeEGWnJsXd
         SvVhwjWk5stvIl3kA+JhrEDhJ/wVUi/JqyS0XSMRr4wQxqCDu5bpFMEU1tEhrv+jIBwA
         uh+3+FMpm8rHiQkktsKYI4hmDhfPBb4fDSsKZYPjp9UXDdLK1JzlzZxCMYPJQ5sjpFm9
         nns6sdXxnZYC5atG66XPtr9saeB33MYh8uEVe+E8IGU8f6E2QVCPQj3WeS9GwkQOTYTG
         5qXA==
X-Forwarded-Encrypted: i=1; AJvYcCXuXrA5eaOvlGev/ruhmCKbGK8bJhXk6XA8GyIc5dsT7RvEu6Ah0OQz6oRUgW3OK57LAzTy/r5my1y14JmdXxbMK/MVmUS4gH/sYjvG+5fP3Cw4Lx73
X-Gm-Message-State: AOJu0YyBEiWq4+BW/gTRlGJcdQa9C6NB+NgYVrsRvxdcQYGfXMY5y1LK
	3c1GTRHPX1XajvhkvLHlxmiHevolPjint4tt/PT1meS42lO1a/gTg3BOvHa9J9gss/d4k06cYS2
	Oi/uLw5gKfCg3XUpZFTniQYTsbevrbajlJDgS
X-Google-Smtp-Source: AGHT+IEv8xe30GVN53LXujFuOLIK2Susr76GRSHxvaCa6Bcn17UOTkMRnicosfESbnqEFHs+NH8WrFmg8Sb7+erv/0Q=
X-Received: by 2002:a05:6402:2685:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-5783237b9e4mr236808a12.7.1716399903775; Wed, 22 May 2024
 10:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com> <6caf3332-9ed9-4257-9532-4fd71c465c0d@linuxfoundation.org>
 <20240522101349.565a745e@kernel.org>
In-Reply-To: <20240522101349.565a745e@kernel.org>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 22 May 2024 10:44:36 -0700
Message-ID: <CAG4es9VZ3r34sUkp31+GCrA_XOq6WqwUUitPMQFViLL83mezYg@mail.gmail.com>
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 22 May 2024 10:19:33 -0600 Shuah Khan wrote:
> > On 5/21/24 18:56, Edward Liaw wrote:
> > > Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and remo=
ves
> > > redefinitions of _GNU_SOURCE from source code.
> > >
> > > 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> > > asprintf into kselftest_harness.h, which is a GNU extension and needs
> >
> > Easier solution to define LINE_MAX locally. In gerenal it is advisable
> > to not add local defines, but it is desirable in some cases to avoid
> > churn like this one.
>
> Will the patch that Andrew applied:
> https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/
> make its way to Linus? As you say that's a much simpler fix.

Right, this patch series may be unnecessary after all, since the
problem is fixed by that patch.

It might be better to drop the series unless it is desirable to
centralize the declaration of _GNU_SOURCE to the root Makefile /
lib.mk.  If that is still wanted, maybe a more palatable approach
would be to surround every instance of #define _GNU_SOURCE with
#ifndef _GNU_SOURCE first, then induce the change to CFLAGS in lib.mk.
That would prevent a partial merge from triggering build warnings.
