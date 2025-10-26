Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB62FFDDC
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519469; cv=none; b=azCuPg35WBhPoppP5yCeFqLAOKedrMRiJyLGmSj52/2jVLc+rbKtBoQnLnq3Bup3cZ+ylPkDKjpjRz3u3o/A3Wm3WCWw+pz4dd+11LGrYWJPnWrS7nPDZv7MFpH1da9lDl5Ps4g+FKqxUsJx/9Y7cleNAnLANlSXCARydQSDikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519469; c=relaxed/simple;
	bh=eTCy82dBzvhDccXGH6xtnA1xEdG0rMAxXv8v/JOl9oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIif/jFSQV2aTIisVVbozpgo3niRi8BmJj1zDZ7EqiHjToRnNO/lIUZdXWySUQyrb857aGmngbExJXFC83QggOUblCBNldVrKremES4qBukdnjTcJQhTFfIVPIXbua65RNzZCQX69TL5J/ylvfFPsAKJ7zuEtAVAMZRwEbgtxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bP3jpg8f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bP3jpg8f"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d6984a5baso581753166b.3
        for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761519465; x=1762124265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHbMSTbR4YCAeFS3lPr7vbw7nz7n8CmHdlCgaOMJXSk=;
        b=bP3jpg8fFVK7mpnD++gL9RF3t6cEmxdZZU7G2/c0EFrWf3p2KEX6esbZP68U0D2aH2
         EpfNUn+PXbHP8FGPU8EVpeTCNmbBXBI2xi7nY1e1LSkXHAiif/FM8Q4DiWZpohTSzmAh
         kib32lBJP25enVC8b08yrU8WX81m1VM5ypsPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519465; x=1762124265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHbMSTbR4YCAeFS3lPr7vbw7nz7n8CmHdlCgaOMJXSk=;
        b=uvktR4WflI1BjgW/wV8IpYshi3+u4Alg/VFNpmmQRiejqWVjVWYSY4zJmFjlRE0cGR
         h/OOlAggiUhDm7Zn+iDgL/ILTjK82g2CSS+KbLLdc0/wFW5aX+/tEcWm3niY05rnKxpO
         J+igYfSm64Ie47DxDZqyRpWkjbuqMumdCcji9trGyWauq0l32dyo0bIzhxN8l6mpcc+1
         sn3bt8or47w6jdVMKAW8dwV8l9XtlaDRYh02t67k8haEiHmRsxZbbDNsLOjUqHHw9o6q
         ptRpkLIhvHWPUYNXPe7j+GSMOs5htD72fJ82AmDoKUzcqBEIuyMj2PvP5V88gPCUNaO9
         PqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFQ/K0uFnh/15mjr+dms6rr1yrk+m/lzfRe7kqfepLzq/rZtLys08IhclRa//Puy7wUSXrWvIHA//vSXtteia+w5mO1B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/E/KSw8q4Ef2gPVf8DVV18vBfeEjRuEbfQ2xKAAPyO8jRkxXt
	t0HqZ+g0DLi5UDGgWQZaqwAutR+km6iBM2+UT9zvZJDr1xDC0b9XvH8XsE4iPRzhlzIKsiefeeS
	80vmbmWA=
X-Gm-Gg: ASbGncuumC2G/WDhWPultfmvhz7yvmEAXNAw47YKIbV1qoYUvUXUUAPJuDopxoRsYEx
	k+tYY2rgW0laK8SNLGaUCjJmlSEArvKWD3Jdnd3A4tbB/Pk4qS0xqi1s7fr2xmTcXSllDGN2mH6
	iAFiJNnMfnLsKCWf/zytMp6oPB5jjT6tHNH3PLt/N/yLbN3s5gxtK6e31ncjj3Zre3zBOs0U6Mf
	2L+KR/uYuQbWQ5zEq7LrTKW+YE1YK/JB1UCtVxxyxFeaO5uyap2Uy0t9bm00OqV11FmGdYbaI7J
	p2g8/sEDU97mUMPX7iUsQJ3kvLqQnm4qp1y/XnKtqWhppI13omtyLHpAWfrwRl1qx8YPiDRkqLU
	TkmUtr67b2ar7l172CuqrVUMhNxzT9N3niO63JHBM26fFUYXtO3ij7aoZKzZorYRapfMmoASWux
	K9dDyU3Z3Cz2Qhl3u/qnKs07Antx8H1g+33fmeALlLuCzLjW9TrGPSuXt770G0ueG54dV7XmI=
X-Google-Smtp-Source: AGHT+IGZHMeA9daaNbAJ0k55GobNITofyvvLXoTnRCHtbjUbsW+8liQQxaTH5675jXr7ZmoakGf8ug==
X-Received: by 2002:a17:907:c11:b0:b46:897b:d759 with SMTP id a640c23a62f3a-b647443b9c2mr4291426266b.40.1761519465364;
        Sun, 26 Oct 2025 15:57:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c6csm580644566b.1.2025.10.26.15.57.44
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 15:57:44 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d6984a5baso581750266b.3
        for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 15:57:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1tbdFfTonC18R5CD4nnxhYr7nh2AQ9v87kumPyPV3OCsjOHYD/G5ZHPaHGTklmssgrMe13V9VSk3FJENisVdwGlTfjr4=@vger.kernel.org
X-Received: by 2002:a17:907:25c6:b0:b2d:a873:38d with SMTP id
 a640c23a62f3a-b64749408dbmr4498715766b.43.1761519464102; Sun, 26 Oct 2025
 15:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com> <aP6OJTTWPQBkll56@mail.hallyn.com>
In-Reply-To: <aP6OJTTWPQBkll56@mail.hallyn.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Oct 2025 15:57:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
X-Gm-Features: AWmQ_bnfaSHJrBUCTUknMbBx-oNR8lppi-asKuqNpXCgeM8R3Iu1_Sv23ysipV8
Message-ID: <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 14:10, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> The keychains are all NULL and won't be allocated (by init) without
> copying a new cred, right?

Right. As mentioned, 'struct init_cred' really should be 'const' -
it's not *technically* really constant, because the reference counting
casts away the const, but refs are designed to be copy-on-write apart
from the reference counting.

So whenever you change it, that's when you are supposed to always copy
things. So that  prepare_kernel_cred() thing exists for a good reason.

But the pattern here in nbd (and the other three usage cases I found)
is really just "use the kernel creds as-is".

They don't even need any reference counting as long as they can just
rely on the cred staying around for the duration of the use - which
obviously is the case for init_cred.

> Now, in theory, some LSM *could* come by and try to merge
> current's info with init's, but that would probably be misguided.
>
> So this does seem like it should work.

Yeah, I can't see how any LSM could possibly do anything about
init_cred - it really ends up being the source of all other creds. You
can't really validly mess with it or deny it anything.

          Linus
