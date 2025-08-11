Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F282222B2
	for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950593; cv=none; b=a1MlH8vsAOHLEW3MClsICGcIDEfqpRZLmdJlJZLB0RRqnHloPonl8yx4F3Q0BlDFu7eDMIIVQo8G2Vdj8JvTk42RO40kQuqZfKiOhOGZewNnrEwV/zWJDpE2VJf/PUvaJ3DhKRJ3m3CQLGP4kCZ7xGANHRpTyYRXoygVMb+yPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950593; c=relaxed/simple;
	bh=GrIDU9hKg1ojbpM4sjTFuGbLqy2bl35Mpjb30slA0D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SLWe1K0VrI04WCjk5ysj8M4YT/jlDp6NbMj4eMarAIkv1BOchhYe7pKH9HYozmdapJqZi0Z03iATcRQdhqs3QXznqAo/9xPeFSml7cLDTKYS8Vtzdown8n0SOiSaNy40H44876+vd9bkVngpdMzdMtipoGoSi6iS569bf/vsg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XpT4G/li; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XpT4G/li"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso6685266a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950590; x=1755555390; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPmJBXvsk166g4IHWngrPgl5dTya8+DdsBQmLuGtgB8=;
        b=XpT4G/liPwfWsvLB23QDkbe0oaobzcNtjj8XSpsxrYTmaKgNXXbLl6J3c+4iNTvzdu
         wdSb5pXK4BXYe70yBmBJXjrSODYwwy7cqRT+65Kxi2BfGyAeH2i9EiLdtROxdHRNpts6
         rbJ/WFrEsoVfAvC9cUXt6LE0ek/lZYabHp9SdJHwru0VKHcOCK955VPHGXdKYcFhK+tT
         N0h9FkQTU8iJ1hALwM9JsSiZOyZCbjQN0nd7u2XbEwlc7XuZwAMPUETOiiFQ3kCJx4NU
         w5FD/eD0YkdVyfGOCC/tCkfE7a96N4o41uVy4tLQbc6ynNi/nB//+Qhiy1NJqXRe0z1U
         h4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950590; x=1755555390;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPmJBXvsk166g4IHWngrPgl5dTya8+DdsBQmLuGtgB8=;
        b=WOk4IlXoRGqTMyaJ8zUeycW7ta2wjsOdis6/5ztmnpD+3UiNYe5UtJSSOULiXy/zGy
         GOjQ1dPe9xoPClTfOuqzG1QI2mfzKONTdhEAaQ/0oOncDYWQbFO++WDQuDg9si9CkwVc
         fcKWhhAG8KXgZwioPF8IDJjMHLMd1YRlU7MGP01tA10sRt7GaL9UNs00tfRiLhvKoS8C
         HgtvOuW6sfH0PNYD4BVDLfS2oohRsbXIowQDdMEvpqSq8Hekk3XprWppbYXCAEb6NcZA
         9/IWgsdJFMysSRTWWmIQMDIEL/5BaxlfPI2qBXVHuvqRds0HUl0iBKeiVlDXf7T7yIDT
         22UA==
X-Gm-Message-State: AOJu0Yw//zwldLiUmG0k6RGNxqLoja7hRzuGezLhCSRpHeOiw5TS9RVq
	HHvVURZkQ8briGWc0pRoUT3YT/vyex/GybwQaotq8Rmzo3Vw5AA/qOLpD9IM9EObhwoGMgbeIoe
	RcfAW0Pe8CpnJ1MALFhj325QuNjrpGHIKquqztoPUL66V57saFA4=
X-Gm-Gg: ASbGncs1R+jkD6ldhtEkbkriYtHhYsPYCiNxyrZtPrZOzuFR69Q47OfP6+soZWNnadS
	gXYMQg9Hafc536m8fjZNrx3DRTa94p6Sr1pEcj03mukHhPgRiWdUfDl8L3tXV2g/ltU/psjV3fN
	Hej0ioBuMVQAAenAc8G21+PlTng6DoPM5ppFBNweKbGBJnnYIuWjVE++Z9cSOeobSv7Yiihc49g
	2cpl9s=
X-Google-Smtp-Source: AGHT+IHoKHzc3Vhv97LylF7mnjRgdDfPAqnhRR9I93BRnSe4EdB2mvVtc3fq8JAHkQfev1y9xWi2llCbN4pf9NPdbpU=
X-Received: by 2002:a17:90a:f944:b0:31e:c630:ec93 with SMTP id
 98e67ed59e1d1-321c0af2ca9mr1693627a91.16.1754950589727; Mon, 11 Aug 2025
 15:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806212552.240730-2-paul@paul-moore.com> <CAHC9VhR1rTnv0ARUhAPag2O+bEXzxoww6UJa6pkesHZTEa-BHQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR1rTnv0ARUhAPag2O+bEXzxoww6UJa6pkesHZTEa-BHQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:16:18 -0400
X-Gm-Features: Ac12FXyfHnQ4xdCI8cSD1qn3vUyUcCGJjFQSbALuN0rubeDgYf1iUwo271mGkZc
Message-ID: <CAHC9VhTqToHEe24Me28qvN9RtS7dnFNtr=SJ+E9QT4QJvmV3ng@mail.gmail.com>
Subject: Re: [PATCH] lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 9:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, Aug 6, 2025 at 5:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Convert the lsm_bdev_alloc() function to use the lsm_blob_alloc() helpe=
r
> > like all of the other LSM security blob allocators.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/security.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
>
> Normally I might let this sit a bit longer on the mailing list, but
> considering how trivial this is along with a Reviewed-by and an ACK
> I'm going to go ahead and merge this into lsm/dev-staging for testing
> and lsm/dev once the merge window closes.

This is now in lsm/dev, thanks all.

--=20
paul-moore.com
