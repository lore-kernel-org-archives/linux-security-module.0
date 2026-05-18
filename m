Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A7337BA4
	for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148672; cv=pass; b=UtaKoej6ybOIVHLBp4FBrNxLyGPmSFeHXATSfrvzdtcuXgX+z4flBIc8joKQHZ3exkaHcRyca9WwvKV8PwXiwvNV9wTl8YkmHXFEpR/j9f+RZZ9UutU5zaLIwRAVxigjG119LCw2NSgnH1bVEO7ZV+g0TLs/157BAWNa3+IpEYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148672; c=relaxed/simple;
	bh=unqEGZFYSyCBmS401bO5UPSCWFKfUOAKb+T3Y4jxQe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYjowG9lh5YVDLUyzjmkgf3Up6jpSSJmu782cv1N0MjzyPc7wVGPxWztphvAnkfLMNOSRffGCCO39cSfpUFIHlfA29KXCDkCH7pGlkWMeyark6lK2U9LB77ZXyei/HoButRgtbNKafWRmN+HqIuU1W0+UC6yr76q8joYmq73NxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YW1xiazA; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YW1xiazA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36643b96b99so2720409a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 16:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779148670; cv=none;
        d=google.com; s=arc-20240605;
        b=CVnFJbLk4w+Q2S9ucQlMJD45fsTMLW/1CaT8JaVYdOPFvzTkvalZhIa1sIzUGK06AP
         uA9nG1aEjM5pAFCHVj3YBsxIBpS3qDHw8yfpIvvdhrpfv6Qh0vkZvdXJnmooIRdNOLwT
         eL6PKEU2Ll6xE3aDPoCUSbj1ielBC+IFZNjVrkH7rhgj0EtWkz3jr11D6UosoxP5QNiC
         PN6TwjKKuLH1I4WUGNbt7eMJqGyrggtl7ljclFMJ/X53482E0Fvr4uBsz35lKkd0+QPe
         YOKic620xiTNuqzAgl8nHg59ss0F1UTW2Y2/grfMfZt+HFAW4FZQqirCyYa+En/dDUZn
         q+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQIzRVdOE5dF5raU9qEOWy4pjYF2amwoUhs+1RS7QM4=;
        fh=37oZ2REzBooDuVXVbEgcExiHVrgtMSX3rd1DtjBHQ+s=;
        b=hZz85s0R34p539GVAJRIgKeBcKgdZMelPv8NpR5hRXpkNAlcbvSamRYw3wmn68Bl4b
         l0YocncEpnFpeMUuAQxC4zLxIi076Ixh4PkMC70OtGAQB5NYqiNw0gWJvMU79YQU528G
         kV27I63UsofvZx71Sa9vpihphrUj1xmniMPLeHikzcEQqsf3rMF4spNvNMojqyR3tYom
         tPW35NJM7o8/gONoRS/Pu5RCPJyOTMVMpKcLzxDb4MmBufxPKurqNCJ5zQBOhDs0OBpY
         cJxbZ29AOOnlsKazyJeVfMheCJUn1xRyr2Inrav2c2aqX1RueDBIP4Hi48pQbHiqzDMw
         iZhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779148670; x=1779753470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQIzRVdOE5dF5raU9qEOWy4pjYF2amwoUhs+1RS7QM4=;
        b=YW1xiazAIuoO9uzWuY8PqoK6SOdp7+AQBjShSj8YTFGoQR3wR6bW5nFHEGj7Lav0df
         371Iaezpn7zqcLSmiRbT/LfnDxDSWJIP1r9ISLxB/GdZAN8zjmyHF1MYQKW6A/gBrv9I
         4L8gjS8H+H40H8waQIhbxIsIllLqY/uEqsrvQGIsAD3FV3EbMMkON2FFZr+X1MIAuope
         +XppFw06GE7AMWQJaiF/SC66WOVHKImIN0C37Bk+9rjk70Wb1VjogJNnTSVIS2TCJA86
         HdqITE68CdCVz2ZfHjuYhUvr8NTvbUxNtJgRhUacgXWXp/QAkMNxVBuxXNvmZPP0B5v6
         lNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148670; x=1779753470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQIzRVdOE5dF5raU9qEOWy4pjYF2amwoUhs+1RS7QM4=;
        b=qWS/787r05odOQWfPVFHs9kK+C2vT/DH1vk7VpBtdG2sbtonxAdhlB9l8xQNJ7zx90
         N/+mkRZdNgx4MRLCYD7zpPMEMuVhy8ixUvOSTVwi9rbU/NGxCrI1pxH8rCOrDE/iIzGk
         bIcFxfaHzyjAjLu+Nj9IxGZclAGw3q3+nxORT7kG/5hwWG6kiEomx585mApyMuLZRKlC
         UXn5J80rrczFPF+M4KgjVKsoRJfGq7M40tdHzSUF9/RQ2ObiSLsOXZkMniFjIJv0tPUT
         cLTbiDO1w1/tJ6ZSQMtDOVT7IrTcpZMN1weEUGXl3FXCG+bCWOwcOgwoSAHMKRfJgy7a
         aWhA==
X-Forwarded-Encrypted: i=1; AFNElJ99MmQgMxrHZ7NHdUpHnEOKwqu+UqW3bXAexsQxjFAhbZzqmCgDIVXlwssdJ5sTEZeXSLzJ6j9sVK4sYLgyfqwI0XIkhCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDcBypClPH4/i4HNMLNvFxBqiskLGRt9juidwpe7LA0ybyqQm
	tbesnLBkoMepfnvri/t36cux8OKUSU9TFSUDtx6sLC115DkVepAZrPOv/jtmG3GKzKjkcZjUBg8
	05/l+KMhwmd0qh3TxbNpLq5SRjM7AOZy5DxS80XWA
X-Gm-Gg: Acq92OGNfCpxlPbs1LGTapTPKTAYU6KZQXLyCmaCbeDmPtKdB5hluYnb56yOrl6RbQG
	cZKHs+u68AeLb54BNjCCbgZ9ZYNjdd+pILilO1If5v0V7TX2P8Lg3ShywKX6RnGkMFdkHXjrE9O
	d13E8QXkvK7YnVMTP/UL/4wV1fP2z/Gapws6pSPWdlJfCfcSeiYByDFYUMuC8ZaG7mPwveHasp1
	Qpz9lzizVPm6/eFsXlZl0Nk9zlf99fj+iaR7h1st+W78gr9q1nw7530ZHUYVsvtvCKoOnHqXJBr
	KRLgXso=
X-Received: by 2002:a17:90b:5486:b0:35f:c729:de9b with SMTP id
 98e67ed59e1d1-36951cabdd1mr17237144a91.20.1779148670183; Mon, 18 May 2026
 16:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com> <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com>
In-Reply-To: <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 May 2026 19:57:37 -0400
X-Gm-Features: AVHnY4Ju9QhtCnU9X4q0Y1FoqKmXLcQYabAg7vghJP1SBxCLhKOLIiAM2oGfePM
Message-ID: <CAHC9VhTGDOJZDzEA31qc0S6FJpYNC4oD__HQ-65wqqwhng=V9Q@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Song Liu <song@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 7:23=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, May 18, 2026 at 2:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > In my opinion, making killswitch an LSM is more of a procedural item
> > that deals with how we view a capability like killswitch.  I
> > personally view killswitch as somewhat similar to Lockdown, which is
> > why I made the suggestion.
> >
> > The use of kprobes, while an interesting idea, presents problems as
> > allowing any kernel symbol to be killed introduces the potential for
> > security regressions.  As a reminder, some LSMs, as well as other
> > kernel subsystems, have mechanisms in place to restrict root and/or
> > enforce one-way configuration locks; while many people equate "root"
> > with full control, in many cases today that is not strictly correct.
> >
> > Yes, kprobes have been around for some time, this is not a new
> > problem, but killswitch makes it far more convenient and accessible to
> > do dangerous things with kprobes.  If killswitch makes it past the RFC
> > stage without any significant changes to its kill mechanism, we may
> > need to start considering more liberal usage of NOKPROBE_SYMBOL()
> > which I think would be an unfortunate casualty.
>
> I don't think we can use NOKPROBE_SYMBOL(). There are functions
> that we don't want to killswitch, but still want to trace.

That was exactly my point, but we need to figure something out so
killswitch doesn't make it easier to cause a regression.

--=20
paul-moore.com
