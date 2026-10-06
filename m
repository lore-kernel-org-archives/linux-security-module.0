Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CD3EC81D
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288908; cv=pass; b=TD0wiL5/JtAzoewYYmTJRuM5z6XCBPxnLb8oekCcrLb68M8oji5Ql0RigufsEuDIdxyocG05tr6oFbKAXOpkrktbsI9+QbgzlH7YycxClNWtR2pMQo/YfGTPrTam+5oK0yObp7KLIJcLSkN2y1QVhCd1/+kYzM1l2zD+fgrL5VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288908; c=relaxed/simple;
	bh=20SoLCTlUosZH3gg7t5ypYAOftvZZuBui2tmg5aXxP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK6fd8P5PKsbZF5/HAQTB0503ccvqO1K0pmAjZsrzlIQ1Vlyv7a75IG+XRhnJvXPNEFbieW20QvVfM4U6NMGex4wAV8bfpcE97EQHvrk23dJ9K0cTyRBtk8mXqs26GiwztdeQr7ZPf2NiRoHIRDj9o9kNROq9LAb4kAhx6GGa28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gd+rM08t; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gd+rM08t"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so328692a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 05:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791288906; cv=none;
        d=google.com; s=arc-20260327;
        b=iaJpf7OdjMRJCcaDIthTKwwcHsTao05/jEwpv2va5BYlQByTnqd7v6WEb/6edfB7LW
         YYrLxqrqVisw9tgQWlwLIF7siRLkAvujoVBVYlvXM8+SR1CKUjR0CWlQKNiYnWqGCs66
         TU/tWJ1kOfaYxgktfsGv3v0BPE3Xx+SyazAktiWMNlCY2QawX+KdBSmD3KQULM7MKjMZ
         HX7tHbbWN+3I6/TNQZu7VIcr6sUzL39BUTEZOOEibPfjURcAX5izODBXLR1mLP3zY4x3
         Q3OKKIlTFkHZMeUjcnFedJUs1I/3HkkrWlux5oX0r5vEb2QTC53FBX+v1sl73YPcq/Zr
         T7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhU5kMp1rxGMciu/YZ1tuWYg/j9SOf7ZmdFtxjzJ6YM=;
        fh=y0lFCNBrynTCwTcF2WKJrLIwL1QD8PMpof/j7eFJ71A=;
        b=nlzE4SsQN/4UY1tY8TvIE01bmslpBEim4DCDsCt7eJtvMVgu6MGIpyTt3qxCvu7cbT
         G03t7qtOaO2EdGfOjazz/sUiiirNavnBoVh2mzURLQE+vaDIlI+X6LaCIWyWeNGuJB6t
         82OcDCm5i5YfaDc1QLOis/sY/VGvusts4HhkSmygXTPl1CUrAKot08tFnL3jI7SDQC8b
         jT1N5quk/aMACeM8aU3CEpHMw8iQnJ9zSJSHiZXP452yejsdoMgF6jfqur1zW8SgQmu0
         HX/AeqkpsOwiu1NCSG8zi/g2jJP2WuUlb9TwIIPmrFQ+lBxP5A7IM9pY5a6EQQXcouCI
         2/5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791288906; x=1791893706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhU5kMp1rxGMciu/YZ1tuWYg/j9SOf7ZmdFtxjzJ6YM=;
        b=Gd+rM08thoFmZVQsnxAwprenjbH0SYu18KM8fEyZ0sBh0rXCK7d7SiBMrE19MMoOsh
         hpz9SL3g1RbTJoXWYKTQXwhCY/gVs9xzpEt//LL9ObB5XLlLEg+govE7cZHs3b1iVL23
         f4SRZvH3Uq0pdAyZr6JxtvY9wS4lEQ19ofVanydHry/DcVrCMop0Xyrhvze7cQw1d4f7
         qbpU+wQk3L3Patl7MKlBTbPCmKWYzVWo3V29JWDQZV/l0o6BGjiTrKc/8nrns1bzHsBT
         +91vXgEIytdN87qyxJSm/HMb8fn6fuAKh6oGPG8GpRXxMdxNWFUT9X9SM2CkbPBmB0/k
         P1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791288906; x=1791893706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhU5kMp1rxGMciu/YZ1tuWYg/j9SOf7ZmdFtxjzJ6YM=;
        b=gdlf6/nU4ZVCV8alBiPlqH/6S0U3igBjhkdY5xUgN35FJTYciVNINe6KWFUJjqfwC8
         HcM0vluKKnlnah63ySiZVY8weT6VPlMDQiVSVlwEcoFQjIqxWKoCl3Cl9amiYEy040MV
         uS1gGP4qEaLsBQo6AitqGi4W5VCmha6Uz7A2o6a8vr4CoRBQb0XGCCNllGXgQoa9Q9bW
         MrlsquuUmuMZlIahWaFK6DmAjoYeOSNYT1FG05uKLXlmyXS9OFcebHjkZ0tgTShfXn6q
         jqz3A69vHcJiRLDb6lzwPgCZc3SWuWKFzf6uyPVWECKA8u7uyLiq5L6Ma5tvf9CClAHJ
         02VQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8vXdvXNeeu8oJUqHbfhsBDPk05Rae982n0NxwSAHdaH4xijRaAIJgjlEiX9CrZB4GE+pmrcb6KkFwsNsLzdxpqqSkgxs=@vger.kernel.org
X-Gm-Message-State: AFuF++kr2SFp62fL7gWc+2P3oQWC/XYXJ+81z0kQoEaUA84MrAXdc2Eb
	bg3uDzYfHF7QOb31tdF523RNRI+NgjC+wn3zjQ8etdYNKWvNPdq/r1tWSrQmLeJjbwQOXqSXbqf
	eHH1Pv1eIhXR25Ls0pVFOrkvh1Az1yilpDOOj8rw7uaxwRBH1MUhUl50Y
X-Gm-Gg: AYBFou21BKTWgNbPcCtmxG2UMMgT4SD+8LOBEOiXrokN6bIUGAfEfCkHa9VFkkzLKYT
	S3NC2UsdBuhCCc5VXXcpBC+DIIlI5goXxNUuHF7VpPshCtQWw/Q8YwVidpM/VOIHK1H4rx0p3hW
	JZpzoQ92FG8cWUt/jFYPHLDXvjw1oRv4NMDjsQY9639vfdwuIji+CqN/On2Nyzc1acXHk8pdfQe
	JXdrxDpVMywrrchAmLyIs4waOekAG6NVydyM8uqw8IjmOPu51wFz1WCFNNNkJDEdzVF9ZWQdQV+
	d9enw4HLHRhvAb9e1QCwsy+PY6hU5B2uRXSubfwLv2b8zjN4o9RJMQWcvWEejhtZWhz52fiA9qd
	p5FI4k1UH
X-Received: by 2002:a05:6a21:8284:b0:3e1:2422:1d4b with SMTP id
 adf61e73a8af0-3e124221e5cmr890709637.36.1791288906570; Tue, 06 Oct 2026
 05:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006035108.3101440-1-4ncienth@gmail.com>
In-Reply-To: <20261006035108.3101440-1-4ncienth@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Oct 2026 08:14:53 -0400
X-Gm-Features: AclHuK-0rgBX0Rc-BZAEtLzd-Bv2KqLRMjK2L8kmkoDKLlRupZOtGrn3yq5-x8I
Message-ID: <CAHC9VhT1upbG7_0pB6KTZyBEbycbdkaWCw=-rYARmkmBF519ZA@mail.gmail.com>
Subject: Re: [PATCH net v2] cipso: adjust cached option offsets when removing CIPSO
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 11:51=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> cipso_v4_skbuff_delattr() removes the CIPSO bytes but does not adjust
> cached offsets for options that follow them.
>
> For example, with a valid 10-byte CIPSO option followed by a seven-byte
> RR option, parsing records rr at offset 30.  Removing CIPSO moves RR to
> offset 20, while the cached offset remains 30.  Consumers such as
> ip_forward_options() and __ip_options_echo() then access the wrong bytes;
> the latter may interpret packet data as the option length and copy it int=
o
> fixed-size option storage.
>
> Mirror cipso_v4_delopt() and subtract cipso_len from the srr, rr, ts and
> router_alert offsets when they follow CIPSO.  cipso_len is the distance
> the first memmove() shifts those options.  The later header move and
> network-header reset relocate the bytes and their offset base together.
>
> Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove =
the CIPSO options")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Changes in v2:
> - Replace the parser-invalid 8-byte example with a valid 10-byte one.
> - Move the offset updates beside the other option metadata updates.
>
> Link: https://lore.kernel.org/netdev/20260930140400.2955466-1-4ncienth@gm=
ail.com/
>
>  net/ipv4/cipso_ipv4.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
