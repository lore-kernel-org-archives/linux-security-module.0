Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C30481D1
	for <linux-security-module@vger.kernel.org>; Sat, 30 Nov 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732935487; cv=none; b=OYVVrsCzXkIchcyVbEe0x0BxakVtRQSV8M+NxPYg4lwEpLTCY5aUHHpmD/ePqBbLRTVdBTqIlBKveOzfPDu1JZsBoc9xyhacfP8wW8/dv/8JDwjIrV1GEg0wghco6r7km/YhuucjUN/kxrdw1vDmRrWWMPWdcBS9b5V+1rb1LCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732935487; c=relaxed/simple;
	bh=Nu3QewCXsIbhquPm2uAwA5tbAqEpjcUOCuz+Z230TmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmwTyFtf5MoO4mb6xFoCrsydhPdhxZuDJpqxroj7WIGU+R64bzmlPW7yxCSe9U7FGx4kPc7EgdR+UcYon/PLuSbuCjmjk/b1qVskx8C+5HhsHohBR9HNmwU7J8xbaTYy5m79yNnUdo+to5w9DB4arqOROtlIHprTdm2w9dKVDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMGNJzZd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMGNJzZd"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef66a7ac14so8171987b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 Nov 2024 18:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732935485; x=1733540285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gul2c7IY4cdIw9dvigC/KghZFAEVBI0kHJe5Zx+Ao=;
        b=YMGNJzZdFcru8eDIMDu2Gvf2k8jRb3I5ChfE9QghqzRzRLRoJIjwniWNyC6cpgPpom
         ct1UQnybsf36qhaA/CPL9a46Mdt0V7HvNWl8P+2dBZ2gCC2Vj8luebBW4cvH9o6kSd0X
         yXxCpRobkMlapbbt2v9WEVR2sgTZNDfu8gxnWpVWHwBkbYOIqZKXi+mO+CS8BTSRd2Lu
         190OE2tmLb6j9tTb/hJ51rjZLLi9WOErmennscsurP2VQXSeMoyOsrWbcZxODnbVscvC
         +yIn70xbKcaOPjhvICqHC423dDslJWPBG8S7WW3HSfk/k1/hSdoASD1aYuDlLSNHR4C4
         cIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732935485; x=1733540285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6gul2c7IY4cdIw9dvigC/KghZFAEVBI0kHJe5Zx+Ao=;
        b=jSlKiFgxje7qoiZJvQYtz2giv99Lx+CxZSE791rTuzcvrs+RkXKFzv41HI5k5Yy2Nf
         mnZygC35+16SRk58s08DhkTp9KLrsLzqfL34Kjk04IDtrccmbjb/ZuoFD8Y/QauRgRzU
         WCaR2tzZLm6A3JwK/JNoK28vy6TYs+4QApYGzscHESgNL49s+Oys9cHma7YAVMFm1VrU
         zx86ZY8/gkSD6olr1oQWiVKzrTnGGPHq91Xk7QT8FF4mqCg2JNUN9EwD4PVyQ5DV88aR
         JNPMwwmodgQE2gQtQZTiL9KwJl4iBboVn+jigEatujsXkpHCwPpyqHj22U7Yq9FEOo6I
         413A==
X-Gm-Message-State: AOJu0Yz1C7G3HOuo4P3DPfYrKX6H+hf/eRghkx5WU8XJN4eZAXC1PQe4
	oKbbriHbTuomrfXGLpsJsfiHHsTK1w2L/AF59zNMCDLrUFcAXvEvizqDxCzQh8mGzoqIAQIJRSs
	P2e+3HematpVvL/EMMjmCi8vdt8y73kYg37ig
X-Gm-Gg: ASbGncuuHVRpRiOPGMNcD9KjHXNWb7NtK4Vb/GKssxJFyCEQK9m2AeQNYSznhP8O94j
	VKes4So+SwH72UywANQxuWqbjMmeajQ==
X-Google-Smtp-Source: AGHT+IHSdo4niy+RHraptwbjH++BGNhpJMyrtVeOAo+Nl9H/zbgcBZxWSyAeMnfFipAvLfo1M4hag4YesJOE8bOYJ6s=
X-Received: by 2002:a05:690c:4883:b0:6e2:fcb5:52fa with SMTP id
 00721157ae682-6ef4a0fe282mr95799337b3.9.1732935484978; Fri, 29 Nov 2024
 18:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128224849.3774367-1-linux@jordanrome.com>
In-Reply-To: <20241128224849.3774367-1-linux@jordanrome.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Nov 2024 21:57:54 -0500
Message-ID: <CAHC9VhSds8SKprWxN4NQiCJ090eYk7bzTZ=yy0KOAYLHMqOUJw@mail.gmail.com>
Subject: Re: [v8] security: add trace event for cap_capable
To: Jordan Rome <linux@jordanrome.com>, Serge Hallyn <sergeh@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:49=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace in which the credential provides the
> capability to access the targeted resource
> - The capability to check for
> - The return value of the check
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 57 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 57 +++++++++++++++++++++----------
>  3 files changed, 97 insertions(+), 18 deletions(-)
>  create mode 100644 include/trace/events/capability.h

I'm personally not a fan of the helper based approach here, it adds
unnecessary complexity in my opinion, but I understand that was an
edict handed to you.  Otherwise, and within the other constraints, I
think this looks okay.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
