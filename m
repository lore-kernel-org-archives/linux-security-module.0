Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B802153DD
	for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793539; cv=none; b=Po5dAm37zekpqM8ntYlDfn4yC+TS4ubfzqczUj1/bm2oWtb+9j/zl4301B8R869/hgV2PNUR1w3ejQg93cQZRbcM+UPaqsfCkOL4S0SFgpdPTIIFKe8vIIEo2vaZ9NuHi2k0fOLNH0RZKkOUMpKk5pAJzxUqDySaZan6lwdiwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793539; c=relaxed/simple;
	bh=LGHA7kSXDJ+acUeALqJkXXIxAC/7LMsVhJSunkrC0ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auMh8kAvVOAKJ9ScFfF4sZPe5jcv22sdqKWFWMoKjOvfBE5ec3G22cGoNyXB5KiCwWmRoyXUzZpWpoBqx+dW/+o5Utu1hwCh9S2vWVbGJ27XHezYh2OSGqAZ41Ah+/AAbXDPQBE4Kx44jKruJDNeUf10aF+KO0XLjZEBsLgT83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTkB8PHK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTkB8PHK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb81285d33so298592966b.0
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739793535; x=1740398335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaIXPrVsnekGZ6+y+FuiHvhs8/YBKFNcBPjcA8hkexg=;
        b=sTkB8PHK2ynWPczClwn1tSPgElj4LYx+3vAXc7WrrHZBCZOOPtYtR77QXEhkyZ3dUR
         nknQ/vnCmC9DNIBNiVbvM5zfYYf56U+q3ug89YuKqluV3j6u8lvH1MjoOHVSvKhUhACZ
         FmMFM2hYkg2R/VJRwclpeCDjl4i+6EJFzMbzEKC7koKsqlSnxlV66W/Gj1deoRjrIy6e
         k2FXo+A/LlM61/MhZOHJbryRM2R6+Bwm1EnhrRSzQgeAjuS2xk6JD/cMxUq5tNEC1W1G
         trsYFTTWDw5IQAcCEJJsUy1gk4zqlYFKlSMqK/hs826L3+f2W+laZhoSPetMWa+sPWrN
         jhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793535; x=1740398335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaIXPrVsnekGZ6+y+FuiHvhs8/YBKFNcBPjcA8hkexg=;
        b=bqOOhaEdiFW/MnY6fj0DwIVJhwgrP+vYgJgZy03wvI3Qxx/d4dAfPCcJDjodYgRih6
         /62NJkIFE4H06UwDpIsVX8NwftAx414zS8ywXW/WS2HJaeqLdl9bM4dHuZgfuIDQ1iBl
         XyCuDXpJUGMNl2xI7VfonvIcW/DC5p2rTOagUTHmKV3Wx+/8zaUaP/Yx6+ENCzFP8Yhx
         foWLcNPFJVOMDnJmiSZ9k2FinabXCAe8ZY4hYi/BG+sHj2cclm78zI0MI54Ep/Pks8QW
         XS+cLiSRkJu/jT99KKr+KdOcG55PHJoNCLlXd+LwX0u95maarbBCRJkb5/I0LlEmY57w
         TPiw==
X-Forwarded-Encrypted: i=1; AJvYcCVfqBsd5yhRFdKdG80E/RUe1z6Pc6ZE2KSeAXVM44FFP2+x5p7WWcNZ6JOahu7PljbdpCewxsoeLLseGES6vWH+HE+dYXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrD2A3ivZqnXvmIM5NwhgNnrLpjf/gqDH2fcPqv7M9PXsvp9Kf
	HRellcubx8+3lvOhBKeEtq7WV3J9CIy8bG8RY9YmUKyJIBwtYzjL9C+/z+wY1TTTr/PYfAcuw6y
	pMA02RDdMLVvtx9c3VFQ1zMKQgjixw0DEHolB
X-Gm-Gg: ASbGncuWU4EQn7kE4dKgBYEo+84KwZ1gJKFebx/pOjXp+lebkmD7UjBUHYop8UoRCti
	JgvsO980tiyBTaItUdv5ZEfNHaWMgFUh1B2qCORyYC0sFQ5PivqqEku7G+jQhf2ZdDashYGR7UQ
	==
X-Google-Smtp-Source: AGHT+IGQTHcBd/2PvLwdIDrdzY1gITJeTXr12QGHG667SSdoKqwNmhWpZV0+hJ2mRbHEz5uu3eBkVx/QqrQsXHUlZDA=
X-Received: by 2002:a17:906:6a03:b0:ab7:9aa2:5043 with SMTP id
 a640c23a62f3a-abb70de2922mr1112341866b.46.1739793535471; Mon, 17 Feb 2025
 03:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
In-Reply-To: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 12:58:44 +0100
X-Gm-Features: AWEUYZmGQcf2SAE7ihBT6VvEcWgoxnUVjpdPLy3YcirIjnOYyCmIfpW7akpRbaw
Message-ID: <CANn89iLZ9SuWnKD1cVu_3cvVYD9jzziq6P=AJy=nUyQUOe4T4g@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: drop secpath at the same time as we currently
 drop dst
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 11:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>
> Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> running tests that boil down to:
>  - create a pair of netns
>  - run a basic TCP test over ipcomp6
>  - delete the pair of netns
>
> The xfrm_state found on spi_byaddr was not deleted at the time we
> delete the netns, because we still have a reference on it. This
> lingering reference comes from a secpath (which holds a ref on the
> xfrm_state), which is still attached to an skb. This skb is not
> leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> skb_attempt_defer_free.
>
> The problem happens when we defer freeing an skb (push it on one CPU's
> defer_list), and don't flush that list before the netns is deleted. In
> that case, we still have a reference on the xfrm_state that we don't
> expect at this point.
>
> We already drop the skb's dst in the TCP receive path when it's no
> longer needed, so let's also drop the secpath. At this point,
> tcp_filter has already called into the LSM hooks that may require the
> secpath, so it should not be needed anymore. However, in some of those
> places, the MPTCP extension has just been attached to the skb, so we
> cannot simply drop all extensions.
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> v1: drop all extensions just before calling skb_attempt_defer_free
>     https://lore.kernel.org/netdev/879a4592e4e4bd0c30dbe29ca189e224ec1739=
a5.1739201151.git.sd@queasysnail.net/
> v2: - drop only secpath, as soon as possible - per Eric's feedback
>     - add debug warns if trying to add to sk_receive_queue an skb with
>       a dst or a secpath
>
> @Eric feel free to add some tags (Suggested-by? sign-off?) for the
> code I adapted from
> https://lore.kernel.org/netdev/CANn89i+JdDukwEhZ%3D41FxY-w63eER6JVixkwL+s=
2eSOjo6aWEQ@mail.gmail.com/

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
