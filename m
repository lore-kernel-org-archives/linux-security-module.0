Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6556852D
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001066; cv=pass; b=dVVIpdiYShSckGhlN0RWc3jK5i/9+JAFXOYuJnPy/uPxxZog08+64S7Nm44KAnTdk6i/cWOxnAlNqWdOrFN5rlV8bHAmHiuFNU6W8yG0WtuKn/jZf5/20GZSG+lKa1aMRiMyRtJJKf8SHQKHQviLMRfo2CgB2PiUse56sSwlm4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001066; c=relaxed/simple;
	bh=J+h7YdXElMiQCzhKnhtIRfCdNxjHv6XhdIMjoVUG7O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td9GdZAe0+vbvz0qEHt7S4L22l2JKMbZvwPeGK76QzFaKeJcgUaikn/vdJksKo5JWocWTKZJt3s+aK+W+ZkyeC0hzwr2xN7VoyB+1U5xXfXvMs29SNFrjFHiqTK4MapVhosga0qPyp26+3JGSZ5I4tqyla1ahTuuIlLvHIY2DNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io6KRGbR; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io6KRGbR"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c3ec42f4ccfso4803866b.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 11:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792001063; cv=none;
        d=google.com; s=arc-20260327;
        b=VAfPGUia5Buwbp72utvrVIPsssu9LefFWvcBMzvwPpmr+3eh8qFGSisoAu41FNtA6e
         zQzcaAUjsV6J43w0xyHeB4R48QHCk2ncI1GfFLnxUS+VKBjpSb7SSqhctEUDlyTvnuN5
         dfXlEMwX+cTjDWswIgjGnVAv4wIJBZeAAq+jh0w8qu1iNabWfZEhNDZncCYgK2iosuEN
         IscFdrViIDHhol+lDqchxzgeyM+iSCrEQ6Gd5gnACSwM6gOtEpxLSFcUUJ0QoNP+bQ9Q
         V2O8KU4w8wwwekeK4uYbZIA1IItpIf/w+E3aRioE5CqrahBXKrf4qVtK7OODbnTJwNs8
         +k1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        fh=uugAuWv5SoqC0+/f6pTYMkgNs8Gg8tl8vQyIQqwn7aE=;
        b=nrTea8AngVUTNN7jvwzsmMJCt9WdRg+EElS+YjQbQLCSTLZl+ZdNP2v2pNzM4ne23W
         Pt+HR/7yaYMex5V4dnA4i637ygLWEla2QonHzGRYPC9KLM3vZzYiKtwBUPGP1D0/FBrY
         H63+d2VzkWSYpWpH3s6dS66/r719TJi+WzDEPJ4NvHQMraJl8oD6O57VDWrL6LWjdeY1
         hUhDvG5SdVNXn4V6A3xKN+umqJlwyWkz6AQyE4v372cuXkBUrb/Pk0T6zVA0nJ2DPQKi
         tSubMV9DnVtaDS4271mK9fzsmGNBsBG++1D9SbOtGIvkhI9qwXKMzmDS19mewFCV0VBM
         TE3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001063; x=1792605863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        b=io6KRGbRqryTPXxUULFruYi3qjlA3Yh1FG+eCsD4nJwwGXDLL+Zc20XvdOXT2AyQV5
         E+irR1wuMn5uZ3OzEBxwMSHVFe6mo3kyhj0gqSCu0Q7OW7J3VH2w03AKei1N61mMihB4
         BisMGU//2Rf1SmpxFo38/aKQf89ekpE4VBL0Cor4qG7igucLNSDfuOL5bZLLfw5wXrho
         U0nU1r5/bbSFLYaqT+r36/qsRmDm5YF3e6vhDDgYNlBdL5/pZdWdnvvqMGOsTMuEfnXP
         HQVqk34YudBmKF0YSw8rL5yXYeHjtkx+LXZMxLK3zlqmKsBFe4hkmMVzqeN9c7DXh7lx
         /onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001063; x=1792605863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        b=H8S8yWSS8rQMHg+P646RO0FnxGYmTpEdmn3r61S+WXLn0dJ0E89U7Zc8n0J8rjuiiE
         y+r/7rL5VpsFzQLOwhCrRy85y9lav/K9IA44tRX6tMfJwREKf3OHpQGq8PWEW90WGkA+
         43vZjYHLDBjsVIX8Ja26GIeeN2FNLSbkJ2dUYm519HwXJ487TCbWokAKgQAhwQtgv+xa
         IHd3jHMOhPJ1KPC/n0NL3suLLbIPN+v5AcZJL7gyBHbmxiS+RQiSqqxNQjnnVDMOf3OB
         aWHmpve4Io/n+jVerXyQ9JfxyEwoWgxaZpWKG3k3IOOnzYjey+766zaf7KKdmiz5+ank
         glPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiUHDsCF6W7AIwpHuXFvhWNg2MWznrK330BgmsNSXh//GBB4NPhjDdPcQrTKWwo68GEUPuAlQZfbOArlm8PjLesxvKhlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdnEp/JF/9DAi1KO+Cp+fTlzV1TXaMkhji6wbb+tXXZEBs1Wol
	vToHiTv6mMTHAIvgWouPnZln62vXW3D6JhP5cWa6aKdjcWRRU7sFgdEVKq54o0MR1oRKD1xnbga
	vNkmrV7j8JDcQZI5p52w4D+oNbG64sUw=
X-Gm-Gg: AYBFou2NsL4J3Y0gveH/WD3VMrqLCzVHh2xgsqHuXtmJGHb97ZStmgem7ogf5gWWNsv
	DJBcHyS9Pk+Rl+o8U5NfpJynPQYq09zrcKSfc1CJ1cAMQRJrpDgBY6YzbPx++GRRk68+vGio5+q
	dr6Tx/9QmxDRU8dSe5bb3wHIxmQfjHgiLZM2onLTZB2pSpTdAG5sz340ILlEEUOph6EPJSKQpDY
	hJq+LI9W8jed+nhIiQ/meM1ZqA1e5tWS3jySUxEdQ7/9Mm0FbLq8daDeEmsZTZfENOrGjzlfGIO
	prx7Vy6aaydJGvTYrdnw00e0boWasPYbvvLF3kDprv3dni8+qQNM9A2k/VwI8zKyXut6k90cnCL
	36jJGl1v9KzHU00J9Skc=
X-Received: by 2002:a17:907:9720:b0:c2e:e3c:ddf3 with SMTP id
 a640c23a62f3a-c31a9a2d73dmr1892027666b.1.1792001063289; Wed, 14 Oct 2026
 11:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-2-nicoyip.dev@gmail.com> <as9pUYoOmLI2l5oB@kernel.org>
 <as9rFtolVVn0NVD1@kernel.org>
In-Reply-To: <as9rFtolVVn0NVD1@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 15 Oct 2026 02:04:12 +0800
X-Gm-Features: AclHuK-SQplAHNwQy93oHnQprXs6MEsIoHX8-ERaJcQyBiXLt0uOAaw9EhmmAzA
Message-ID: <CAAo+4rVHykh4cvw=wvcZ+6MqehsOi-Foq6f+DjN536pbjj_P0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] keys: Serialize ownership transfers with key accounting
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:44=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Oct 14, 2026 at 02:36:53PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 13, 2026 at 05:03:58PM +0800, Chengfeng Ye wrote:
> > > Protecting individual accesses to key->user does not make ownership
> > > transfers atomic with accounting updates. keyctl_chown_key() holds
> > > key->sem, but instantiation is serialized by key_construction_mutex a=
nd
> > > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown o=
f
> > > an uninstantiated key.
> > >
> > > The instantiated-key count can therefore be charged to the wrong owne=
r:
> > >
> > >   instantiate                       keyctl_chown_key()
> > >   increment old->nikeys
> > >                                     observe KEY_IS_UNINSTANTIATED
> > >                                     skip the nikeys transfer
> > >                                     replace key->user
> > >   mark key instantiated
> >
> >
> > Same here there's another below.
>
> This was also asked last time. Actually last time (since I missed the
> spurious comment), this was the only thing that wask from you.
>
> Br, Jarkko

I'll also try to address the same changelog clarity problem in 2/2 (so
as the spurious comment). Apologies again for the messy changelog.

Best regards,
Chengfeng
