Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE32063FE;
	Tue, 18 Mar 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338270; cv=none; b=tvCMKqQ1Syxbemqll4tXsmZM8ZWUmSN3itv1E05/+S2TOnc/TCZdYINYEOsZK8sCW53Q4OyEWJlJrGCgDz0NIJhZDWDhU6nwANeFpfyzCV3/6ilP/Y/ODg1eqq4rBfPF32dvQG2ygRGIB34HLMRL3Gh9OWNT5trZr6krufYLEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338270; c=relaxed/simple;
	bh=VVmm5qJe9dwbIlANjI3AgRxkODh8ApI2KbJHlCI9RWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVIvvGpP6QdcuaOylcAZ/OE1XxOkizGoiwWC27ChS9CZRPCLms0b8WUZO5W+rr2kK2Ar3JnUGcfbpfwsQ0yZKqSgpWAZVEL80D4ytPQUGxSt60VV/WEkvJbbKoMTA+PQxRNRwYA4rciNuxclTMYQx4wPGmobTFp/h65JA6D8XeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAVDKK6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAVDKK6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4B0C4CEDD;
	Tue, 18 Mar 2025 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742338269;
	bh=VVmm5qJe9dwbIlANjI3AgRxkODh8ApI2KbJHlCI9RWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EAVDKK6GABD21xIzzH9iJVgp1KnvrfqdT4YJm5+2kpXcQKgTL6b4Y3hx9MfH+UxBf
	 43EUwBQ0IL7Eb+ntiEhlrgc/W9R04WEsWDNGij+pW0LYB0j0mMTziPF98xy5wvD9Km
	 j6dTJ7e2hhlchC7gSiBg1a8c+csTpz6HTN1bkG2uxGBTFteZDeUeWDzMbq01l4q/6r
	 uC0gVNDCnMV89hh96fPbMMFYPiIjzTcUmp/E3LQXir5TGZoOu55t+nKb2fEwyzB4H3
	 Ed942wyMfdicPT5mELzQU+ToF9b2Okjzo/66yYTe+9Bs4FpCxvdkq8Kt04EJujXex1
	 VHy/ZQVa56rLw==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so5999757276.1;
        Tue, 18 Mar 2025 15:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnvTknItmz/PQrYzL/4wE9DXWhhnWwPak97i9pi2OdNwKk7LvpSJNpxYKNbv3r5pJYgRjIlGeSyQXJTJoIMtd2x4oE92U8@vger.kernel.org, AJvYcCWBrYP4cmLoc4mr2DsTWTWp3ewwE669RxIsz3cGcVXJNaQ2TLhtutsFXaffcduwvD47oSPXrA==@vger.kernel.org, AJvYcCX93M5ege5Oi4SA1KNXrZGULlBokhgQV81KXAw3rx0JluuPdWK8dfjfZYvW3NZQB+Ss8npuCRt0pu2XZovB@vger.kernel.org, AJvYcCXHCmQS+oHUAgcp6QYN1InMGAtyTwuDKLZZ835t9WRo7JShxEcwL3STFE/5rAYK3Mo059bJsB07OLZD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qXP5/YJYwjJaWTnMtSiJcR58ywoJKWvJU57/hY+z3mpDdp3l
	0jDWUV5p/GgNO1PczxyRZuO7+KTTzU06oeAp+eopy7iENaKIlz4f3VyfPlW/tl+Hcg+vnSkIAYW
	RdjZbrnny2hSHlksY2rzuaUppGPE=
X-Google-Smtp-Source: AGHT+IHtWrWG9q14SFtqmCK3AD8VjveTzse+0ACAXhWDDSbBM11VEK9SbV1XqbYGyrMXedtzt9WqakWtI5DtyrpKZ2g=
X-Received: by 2002:a05:6902:1b83:b0:e63:6715:4d72 with SMTP id
 3f1490d57ef6-e667b446649mr766504276.42.1742338268586; Tue, 18 Mar 2025
 15:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1741902661-31767-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <1741902661-31767-2-git-send-email-jasjivsingh@linux.microsoft.com>
 <CAKtyLkGuRraMbArSQCGxb+m5p+M8G5WZCTHk-7dKVfQd2EJYxw@mail.gmail.com> <CAHC9VhRPU1C1-B=PUwUcheOmYhSDzHJMmcpg3j9z0DPiMOHydg@mail.gmail.com>
In-Reply-To: <CAHC9VhRPU1C1-B=PUwUcheOmYhSDzHJMmcpg3j9z0DPiMOHydg@mail.gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Tue, 18 Mar 2025 15:50:57 -0700
X-Gmail-Original-Message-ID: <CAKtyLkFRpu5n_Bp5Fm=VcKrBcXKeapZM8=4pRs7y65=6WhmTpg@mail.gmail.com>
X-Gm-Features: AQ5f1JrWQ7_DK8jvagvgBhzrdsf8P0o9soiY5JDo-E1dwIaB-x1ELuRlLKyfMww
Message-ID: <CAKtyLkFRpu5n_Bp5Fm=VcKrBcXKeapZM8=4pRs7y65=6WhmTpg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] ipe: add errno field to IPE policy load auditing
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@kernel.org>, Jasjiv Singh <jasjivsingh@linux.microsoft.com>, corbet@lwn.net, 
	jmorris@namei.org, serge@hallyn.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:04=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Mar 17, 2025 at 4:59=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
> > On Thu, Mar 13, 2025 at 2:51=E2=80=AFPM Jasjiv Singh
> > <jasjivsingh@linux.microsoft.com> wrote:
> > >
...
> >
> > I don't see any other issue, if there is no objection from the audit
> > folks, I will pull this into ipe's tree.
>
> No objections from me.
>
> --
> paul-moore.com

This patch is in ipe/next now.

-Fan
