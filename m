Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92A319604
	for <linux-security-module@vger.kernel.org>; Sun, 18 Jan 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768778374; cv=none; b=gNilCugSwfnfDCmwtvrM6innt1nAtwkx233Kfe89WlmzSM/ouw/stHUmZvFT/QR+WBowjwwOZeeeSzTn2jMQWVCHLw1dnLRX6RGcwDd67VQOY2H+cySmnRTEuu9PbUiCM9EJ7B84jg8teqMDrJ9GMrWR8WM0/qU8VWL8HfEehDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768778374; c=relaxed/simple;
	bh=0L6hqoOBNIXBHQp/w0tK3e1luMfJAFlsk/jP4BVDiQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0iaZlarAGWjpnnriWrtbL/BkvZG5FXcpSFj3PECQFJSFXdNbLcKqgIafeyTsVc4cpinIZ4UnPMQuj4LgLd699Ja9E1R2MR6372vhzn3iQszaP2zjcyTrTGEHmqKzHtlchEoSgcG/gXr/bSe3W0D8Kzyz3N+jgIDGzEoIMUshHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H20zjXCI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H20zjXCI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so5794492a12.3
        for <linux-security-module@vger.kernel.org>; Sun, 18 Jan 2026 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768778371; x=1769383171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv4mlp4284HzepiNJ8I/BRl+LXM1ml+ATq/xBK6ZnRM=;
        b=H20zjXCI5crFW8pMmNlTYyM1Z/x4QPk8y9WFokbyL28ZMI88ZPoPYe+aCWd75+qY8J
         sy027Oy1Vy05bqgKWfkUXOPoeUXXcdGbN0lXmXVt2cSXab/ttol2oqkchQBiVdSXUgyM
         vn+0ZfSvCxDEY4wEsZEWEQ3brmj69ihQcB4yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768778371; x=1769383171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tv4mlp4284HzepiNJ8I/BRl+LXM1ml+ATq/xBK6ZnRM=;
        b=uNs62jiuqcZSWEETVFYp+PJ/XYsff899u3bAJlgssC/pea4uF0B/VPd91byPFiGeSU
         FgmAYgpJ2HH99JUAnEoWedOp5sbQ5HM6sN5WlSZC1tWjOiDN4CEUYN38NWPkDnU9+n/8
         ZYBKtYSL/DhycaLLiwKDnm5QmAgeVlQ5AJB+czIFzJp2ndBwdufI+CP4ga1sfXZLUhq1
         gwTwJI8SSBbzb4VRdGQmd/rP40PWWuX3AZlsjTaDDnElZpgxnleQ5CM8+M3pENSTnM59
         3e+SwE0dXN5Ot8xf/dZSCB8W7azUwkPF0H9OhwUtvA50pjr1PSJe5oK36CeXW9pVUecq
         oyiA==
X-Forwarded-Encrypted: i=1; AJvYcCXOoLt7rf8ZlXcAXZaV54+qLLelFXA/XpYXs7Gk2oIVqYRIqD0pu8IetX/dOzg3bn7p9p+uLsyzk2V/Fe8DLaB8hi7D9ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZQEkrJLCjZGPtBJ7suLbkxz8jidOBMXmDAxDrC/nApcPb/c6
	xnLjKmiNfUfDbCASNuolQM6Sb+yKP6S40XodnDWPFfk8gWXjis8z1TZkLd9ehqHlE3SrowaRZdj
	SR93Ey5s=
X-Gm-Gg: AY/fxX7mMQoTqpDOCRdI1gZi7KREJ/eQtmHOhJipqSZRqiSpV1nHPQ6e7aHS3WLn5H5
	x9gIKJUrOWtrrJNag19VhV7ljCEt2u7NCZrov1j2aaMqkYd0ykRkTG/vmH+krYKyK8kgH+MAgeD
	CYWVk9RW1gwC4hys4HEP4qWO9DWKwnhQpfVYlSkPtlQ2uz4W0gI1fb1LYwJuHsQLkzJGzLxoVbR
	4kXWsIKqMCZQebg24V130/eZJ1rUVKFo1gpCHIoLOYxaW7Y4LfLUUr33kw1/AGIYF+jWHkuTQl2
	LAPOgqKZJj6ZVQz05YmYxfYPbguLzOhvHqFyhuXqNwcBqW4DL03bdvSD9cFHPLk0FJGoiTzn94U
	I2kfen5lAXHV6YA5jBITa6yNDzPMaH+a4h3qdFy9OgMzzLWRU3ODUIioa3SLem3Dp9S6zj4UaPx
	/wRJljnhCg2kAQd37qRWIk04ezvnz7DOcxS/ezAIFtSFYIuQ66wyKAnqvbcjDo
X-Received: by 2002:a05:6402:1ec2:b0:653:e85b:7729 with SMTP id 4fb4d7f45d1cf-654bb32c6c7mr7248555a12.19.1768778371055;
        Sun, 18 Jan 2026 15:19:31 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce876sm8740407a12.5.2026.01.18.15.19.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 15:19:30 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so5794471a12.3
        for <linux-security-module@vger.kernel.org>; Sun, 18 Jan 2026 15:19:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqMnYNeTN5nQcLHSkzmZdnKU2CrE5XjzApsG8ELckS+ds14UigDtilefgza9pGMj3uBsHugWIs9jIf7ON+6XVjuerRTpM=@vger.kernel.org
X-Received: by 2002:a05:6402:4302:b0:64d:498b:aee7 with SMTP id
 4fb4d7f45d1cf-654b955d7ecmr7095356a12.9.1768778369364; Sun, 18 Jan 2026
 15:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115214740.803611-1-mic@digikod.net> <CAHk-=wgPRijTr7fZQNs9pxbhRLBVQGdE7ceZDwQFP53MXjRBxg@mail.gmail.com>
 <20260116.feegh2ohQuae@digikod.net>
In-Reply-To: <20260116.feegh2ohQuae@digikod.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Jan 2026 15:19:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3XoALswBB0Upz6MxYTSw719a-3T0zY8D1_8J3sned8w@mail.gmail.com>
X-Gm-Features: AZwV_QgKbzKfoUVy34n6FUJp3U_W2faDYXFy2dvQBfS8p1DrPKmHggvZh7C1MkY
Message-ID: <CAHk-=wh3XoALswBB0Upz6MxYTSw719a-3T0zY8D1_8J3sned8w@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock fix for v6.19-rc6
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 at 06:18, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wr=
ote:
>
>  Please let me know what you prefer.

Ok, I took a closer look, and yeah, it's mostly just moved lines that
made it all look rather big for this stage of the release, so I've
pulled it as-is.

I do think some of them could have been delayed, but ..

            Linus
