Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAC1624D5
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865518; cv=pass; b=nyVu55z4ziPmfuBKP5CPC07BaQskfB1OO3EG87hJPWU+G20kOJZkAfshzoem6z7qByKWGIV9Mz4kLiQToLcHn3ceFMjhroTbv8i7RDNpOJ0wXywCPuRd2xPbtGuD2vKsFLIOPhS5e6Cr1ub0a35/ivUjydpRuga3gOfr9RdmPyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865518; c=relaxed/simple;
	bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afTinAqKQvPzTHlJ1lxxm51j7l7idCDua0NAjkHwse2KYLZcRwdWRMcP/Xf5/Eyg+QzV1g+mnQyh3Gg3gJqnCty7f3pzYze8+Cet8G/ZeUPzF/Jx35nyN63AfWrm1KlRrDPPa/QBf+6+Td9LP+012AnG3Yc5yvJ7e/Kn8xXMH1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G/Jd15XW; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G/Jd15XW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso2975496a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 15:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768865516; cv=none;
        d=google.com; s=arc-20240605;
        b=fFP6FioJ7OKcpRHNRsjLaCSY7rQP/gdXzeXdesvDqnvCTpiG/EqkzecV44NQ0G/Sqr
         KW1KuWiSlCg8GGoHooeJCm7hWbiHBxwpJtYElZjvoVJLlIlfvkxxQFnzkURbF3J9u7m9
         uMBtShBQEMDU3Wjy3NFlHR0x6s9t9RFx49xLaQMhUaG6Ir/04By2SOk8n1DVfhfLMivs
         67DmbTrAbEUtzBpIHcZHwrbvmsLAP0SVIK1HvVpfQPAje+rnm1LQhBXu6ee3QjdvfiAf
         Z1XWDfvxzpvnCglsYj4dNov2HQB0QmDVaFiDu9OW7EnvSXDovGJp7aRuJCu5WmHYRpwD
         ogLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
        fh=wE5QSx/N8k1KiUWWFGT/Wh9VBK+QkKw5RdB11sRi5Q4=;
        b=ByX8ZTP+zz7hy8rS+HYaxO3781eiJ4A/A1BEUMa45y31ZmKbtcN/qoNo7w2OOoIRte
         KiTIcW8EKNREvWgAQXcMn0OM54aGhFvKwPYz+Y4egIiKksvfHrPvY0g8bylm0bUOd9gT
         e6d+HaQR/LFeBl9jF2kGiCbbxv84oNmHHnUd4tcRv9MOfQucBIthpUHGyL3uBug/ktZH
         AY1ba1+zy8cEtTulFfpMw5R5137N+Pyjlzhkufq+0BcwxmrI/CBiJRd5kEF7pMJAX/9f
         KNiaNtywRhWMm1ONN6OKok7d6yUFcU7L0X8No4gd7iR6bH+n0YX0+t3AtpNI/Lzs3VYY
         HsqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768865516; x=1769470316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
        b=G/Jd15XW0rNztVU1/K60oVoYKmJiXSaeIEt4rZLSc0/OjJYxsZ1xdu/AhVNY8qW58Z
         Fu+prL/hNN3xHeduocfglK8gpdo6k3rcJ4yajdGC3i8CO/X49b9RjpYeUVDFbnMpkk0/
         c3f4b5uYzRm/jEit/UtkT95AeiexxGXrI/Zv3/DN6wz/SzhT4ahY7AypeEao7GrjYiZT
         HTOPxqVt1s91KLn3uKdNtYzis0EHBvA8CFGs0Bt/WxgjJtKyNgf9v7olJy36AgLRURvf
         tPPmNDmxuImaYlc/gl1Ui5jh8VVO0ARUmRdp93oQkuIY2pL+cz9Wc3Q68WjDRDTlJXlL
         v7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768865516; x=1769470316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuBegOhsLC7Fed2e4wyoLTmC+E9EyIwYR90cs4vY0qs=;
        b=csKyRO6dAwwUFwL5slNvhW5jZgZGq9EfbC1C/SxBX6mgnKVFzm2NPKm9JJD8vilvqv
         HT02cmOJsHN0NlHPzxakiiSKT+QtWWDpjNT6Mat92Cumswjef0K3XaysgKp3HE+OqqQI
         l6g0/K9MflbA5sS77V3PKn7s4jMmof/Xmy3dEBvYt6BnszoHVgQ5g/DyP/cOxl87f2na
         /C7KC72rByBSTZ+BZKcN1ni8tlSMiwd4SWmuyQgn4SKZSH1Hx5jWuMbWu0oUr0XzlURL
         4Ms3TCdLmK82ZDWWxttixrpANRgg8EOpGknphnP/OtpPm5xd30ZTmgsQMewkNoFij2Jl
         foCA==
X-Forwarded-Encrypted: i=1; AJvYcCVbvkgGW8Nm1wMCuUR9g+THPY5cStS0GteqDZvpPVjMLeZxr/IMSheaLsjqPki/6woX3FyuP/e0se6Q6wJTxRINvdzP5kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG9xN9eLvv9HaNgCQ4J6vCjk8tQfxLRdIO50YtHYg9lKZuQn6
	G4flf6kvj1DO5BL+OZAxX7LKVWx6bwpBvQzBTz5SUaDQN+5FGQcDJgn6m1hEiwaJDD8yEqLPV6Y
	2UnQe9/OzSqcSanElvYyD89z+Gmg4PN6k7DkfGdyd
X-Gm-Gg: AZuq6aIdQr8Z+CMacHxWQj6gLKFD8Rvk7O7Jk+A0NzlOD/eQ61n2WPrj+o0GvhT5GDB
	H+RLC4Uw9IlCBgqj/G0nd2Xl/pDRxw3whdRUWAQFFnshFyf79R+oWPq3OIxw5TqV1SxLAXbi5eU
	N7c9myYWZXVuU4Jafo5RZDohJT0ny4osBqQqL9n1cSq3YCNLqlx9IT3BOW24QWhOBwnt6V4QjHG
	RsDkjgwDiekflETCCNbLCGi8ZOay6Rn7OAaLMFuI73D9SdioOZg3cUnAeHpjUR+7u2Ug9v1cvHz
	3ya71w==
X-Received: by 2002:a17:90b:3884:b0:34f:6ddc:d9de with SMTP id
 98e67ed59e1d1-352678fcf6fmr12723525a91.16.1768865516220; Mon, 19 Jan 2026
 15:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW6YMA11KFzSkgfw@gmail.com>
In-Reply-To: <aW6YMA11KFzSkgfw@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Jan 2026 18:31:44 -0500
X-Gm-Features: AZwV_QiFd1darNJ4-NmTZegkEnbH1-U4PfcCWwUcHetbwfp2L9PL0OETFXKKpSM
Message-ID: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
Subject: Re: ipv4: cipso potential BUG()
To: Will Rosenberg <whrosenb@asu.edu>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:46=E2=80=AFPM Will Rosenberg <whrosenb@asu.edu> w=
rote:
>
> Previously, it was discussed that skb_cow() has a bug due to implicit
> integer casting that can lead to a BUG when headroom < -NET_SKB_PAD. We
> concluded that it was not worthwhile to fix the root cause and to
> instead fix the symptom found in calipso. The thread for this issue can
> be found here:
>
> https://lore.kernel.org/netdev/CAHC9VhQmR8A2vz0W-VrrhYNQ2wgCYxHbAmdgmM2yT=
L-uh4qiOg@mail.gmail.com/
>
> I recently reviewed the use cases of skb_cow() throughout the kernel and
> found that cipso_v4_skbuff_setattr() comes very close to triggering the
> same BUG. However, I concluded this was not triggerable. Even though
> len_delta can become negative, leading to a negative headroom passed to
> skb_cow(), we do not satisfy the condition headroom < -NET_SKB_PAD.
>
> Nonetheless, I believe cipso is using skb_cow() dangerously, but since
> the issue is not triggerable, would it still make sense to patch it?
> I figured I would throw out a quick email. Please let me know and I can
> make a similar patch for cipso if necessary.

Sometimes the easiest way to get an answer to questions like this is
to send a patch; since I would expect this particular patch to be of
limited scope and very small, I think this advice holds true here.

--=20
paul-moore.com
