Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACE130AC5
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979370; cv=none; b=cyekVmDmmed24x1gVkyyQfXBNYt9lBOvbpiya83LzyZVKzwsQKCzxJT/D2dZ6JFIXIUHP9JgVqbK0/pUOPNlInjOEi0EbCPAZ22J6lPOqGBAjTshkqb/+2tcyUSKLFZADeydubHscmEzbRU2ibj2Ra7EUjj0E0aLgYLFooMOcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979370; c=relaxed/simple;
	bh=QxHMa8tXHRVUnwvw9mD2wDd93p39Q3LXyym88+LBQsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjRcoJsuser3Fw9vKaLzdBW8BJg8D3dJw04tE8CVtsaaumsDkIZ8XIMA8yJCzahvt3WTBvyTcS0Hnr6gpryP3JeL3oxeQXU1VY10BbLhBNXoyKzyS9uvrXGbi0BQwvy0Y5CBQiqIf0PEyCha7wsg3+SCR/LGmYirF1x+L/Vn3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXUH4LYt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXUH4LYt"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51197ca63f5so5324200e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708979366; x=1709584166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=kXUH4LYt0O+PcJSbQibj7bUR7GS3p3pHNY+97jePEAWM6mstU1LXPsKaj0lU/+8N7C
         a666jEF++XwzafrndzIg3MCT+lqXplSbXR9Q5dOEtP2fyWl/TmEoEor3dDLM9Xb9UiFG
         a1kxSmGodbTYdmNgGzzjy8k4nVrkFm7FRnGew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979366; x=1709584166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=m3tr0g9ZcBROBfnA6uuQTeAxChXeAaGG9KctuzpwO2W6XZNxvoiliIwxnNUZrxLHNu
         2Jb7DhcjWGEOG1prfkWkJC3qQoPYjv38XJJlbbl1f9R/4eBFURiIdVQ5b2CBIHqW0LI4
         9OALubW7DFkPjFQro9ujw/fbTemmiyBvHV6W8RgP0L5GnlkH98VKCLuEXRF3f/AERyRm
         9UG03myIs+xyVBAJQDFy4WJhWH7cXNxsUVy6zfqyjpTdZEGmh1yA/kdcNZaRAPzyuWrt
         BsACiuFngnfzrCIXKLggO6kOxsZRVQAkVOmzWVZZmONQjoVVn9IbnTyZ7l20vdV37DZQ
         2Ggg==
X-Forwarded-Encrypted: i=1; AJvYcCUt6jvgjPfIPhaR34KkwHkVmNQ0Hokm8fpvEPUGom3lMZbFSXWZdJzZ/vXVi4WaaAVZwfr0xAez+UFVO5cbw59Gj0CF5o5VoZDtGKaAZujlRX1c0Rnd
X-Gm-Message-State: AOJu0YzI3K5tVnTgTJclrzJXtpOnvdqjEotkiplLoLPsPBqw6zfi7YWW
	i6cowOeSTIRBLw+9HYNOiZkmYwr/IyK7kL9V3yT+Ju5iOLxlPsRmtxsh/Ua7YGTDm4I1OKGwyb8
	ijeQT2t59V6dLifd+SXAQ9/RFofNHdGJPSA3t
X-Google-Smtp-Source: AGHT+IE4y/QI5ASnYlnv6FmbjUzGGENEjUwIiTvu+iC22zSP9/uqeaEIobfef09+sc2WB6Z9VlPhm8xH62y6EUnNoXI=
X-Received: by 2002:ac2:5d4f:0:b0:512:a4ce:abaa with SMTP id
 w15-20020ac25d4f000000b00512a4ceabaamr4861210lfd.48.1708979366487; Mon, 26
 Feb 2024 12:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook>
In-Reply-To: <202402261123.B2A1D0DE@keescook>
From: Mike Frysinger <vapier@chromium.org>
Date: Mon, 26 Feb 2024 15:28:49 -0500
Message-ID: <CAAbOSckyxGka1vWTpuYwA8eH=17sJbGMUOuCwHs2gE_FPnXG3A@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com, 
	Doug Anderson <dianders@chromium.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(lemme try this again as plain text)

On Mon, Feb 26, 2024 at 2:24=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Mon, Feb 26, 2024 at 09:10:54AM -0800, Doug Anderson wrote:
> > On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@coll=
abora.com> wrote:
> > +     if (ptracer_capable(current, mm->user_ns) &&
>
> It really looks like you're trying to do a form of ptrace_may_access(),
> but _without_ the introspection exception?

to be clear, we want the check to be "ptracer is attached, and the
process attempting the write is the ptracer", not "does the writer
pass ptrace access checks".  the latter opens up more angles,
including shellcode self-modification, that we don't want.  the only
use case we have for writable mem files is for debuggers, and those
should already be attached.
-mike
