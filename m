Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB94AD4BB
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056885; cv=pass; b=PAKG8M3Mg3xIige6jJVCqoVeePV+o4YiRSaN5sLnP14EThDy3UYXctr6B7zXuqldPwyt9ToPznZlcf+mx4PWxPU5mvGo921g0W7bC66mp6KPJWfH8c/ro1+IFQ8Rz4vRs+HmH7/TFkFqMhPX8ItB+UCkam7bm9T5FNSnZG+ixjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056885; c=relaxed/simple;
	bh=AIdeJfpL79Jnckoa3vMq8Pu7laRqtN2LS+kT46oxafc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJBj+uGh2ksrfacKld1jUclqceci+Vozkz1HCAYFt8BlKL2k0KZGCtBsKpqLqcO6XAHobLI5EsmNynAYbHPjtx8yxhTSE9tuWGFfy8tM7LbBl7SDgBxvTQsZvH+wMQ1I5vZdxjR3Vgu4Naj7qH4mn3Yxtr+C+g9wcNff6M/2GuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3gozuAj; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3gozuAj"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c1847d64so111a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 09:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056883; cv=none;
        d=google.com; s=arc-20260327;
        b=PkFR6ILPhHqay77Q+Y8GcwWAuBdajH3gIPm4nrqYKD54fDdhomtubx7vTz0vpNCNtk
         1dYIltVS/JJC4fiCa+KPSarIiaXG8XPQJUnYYEhzhBR260qrtCkLkNXrdcOond2EA76r
         BU9qaN9HJl6WDfaUTaUA6wnenKgNjSaqOml6pbYuVHEfDgT+WmR7daF+BpmxcquvGBaX
         IFFATxQBNrXrgvb6P0fGWqFMfH7SrDVgDZkPzCAapD0aj0l+Q+A9WqwGWpFFWakHwgix
         r58y4PAouprwVOZB9CdEMa7wtlsySyNZuKDzfMX+I/atGiUUskkfOIWw6sZAbqTba4BL
         bZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AIdeJfpL79Jnckoa3vMq8Pu7laRqtN2LS+kT46oxafc=;
        fh=Pawz1Y2AzsFGnfzVPZRMIazPJxhJNX7+whVJd/K00w8=;
        b=oAK7kI50jxnPRE0mbWZ+D/xN5n2kuiEOWVx6yGbhCbi3FC9WxCehYY7YZ8Ytwx5vUD
         hbzxlhEiCobnhTyBtbVrswHor1EWRo2LRLMIvnTQylz5+hycTmOw36vMzzEbqPb0VTDf
         TWG1tdTY5u2ctnYWyG6+PwrqJVe0AZFM/7t+bgvsnHnF/ay7/0DFLOoxFy88QdJJsW39
         H9cKKcDpW3j5vn9m0Mbgf5TC9BAHx2OnZC6ET9XHdD3yECwZ300WeKhiUPUtQG6xefV9
         gTGb3wyK328JNPkE1ORkk/siT0zZYj+yYCLdEONECRY0CL/aBdc6a8MJciAibu3mU35l
         RCFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789056883; x=1789661683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AIdeJfpL79Jnckoa3vMq8Pu7laRqtN2LS+kT46oxafc=;
        b=F3gozuAjfDDbMeZ/dLSy2CXjr+RjB/+c95R3VRdJY9j2ECNnpTLl8Ln0/Lsa3i+JEX
         o20WRjxX1ZltoNB1JmAgHuVAuaIjPxEo8VOgWNy+leeH0FUSFgibVbT8AJcrIvgJmDXH
         qmLqVy58lsjL2JVFPjtlCMeURg8mL7ZasrPHhYHjYSl5xLCBAAvVQbUhcOEvxE4tRyUM
         lNA2SXaxmN8czo1K9iLlb76i49BLzFUi96zKi9dyF5/u4ziPQ6ZcJAU9Aqf1JAzkUZaN
         h1BcG2aQKgJAXkHLkhpDLlDglKIkTVEA3TraZg/u+YYW3RWb5kHwwLnYTb42JnRZx528
         TIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056883; x=1789661683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIdeJfpL79Jnckoa3vMq8Pu7laRqtN2LS+kT46oxafc=;
        b=o1VJV/9I4YC6O3O3IuPzzxcUU7hElwL9Rrhhkgh4E+acweE+SNNuWKqJsu7lbthle7
         3e8FuSUYBHtVhIjrVg2vOuJ514lfqjfXHERyBVp7jYuW/eUp3XzmqbS9728nRD5dqNu3
         HN+DHXYMoZNk7/eCzbKqQdzHNUmAOPzK95pRFiCGrkLAq4PfxfY6dL8GSjZyidpD6Adc
         eT4chlzoq+rtjJEDDFJv8gvjQ/9z1VU+/q8NeXAzWSLwKQzyf0BnVaK7hg9w7BIH2yCW
         EtusElH4JJUEdNx3Tpl9Q432HOSMtnDjEXGTaOnrT3V/r9HnTjQ9YQKTzZPCYk/R70Xj
         Q/xw==
X-Forwarded-Encrypted: i=1; AKwUvBwmyd3TD11JRJkouIihqQhxZcealaSbkhEK6QvMLxUO5GhdS+HtMZ3GmTDUaqIm8ftj18JpedBxSgORt8iiNJDpyIkaPrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kKfgImyZDztUjY9DngcYn+evQ4xWgAIypXG38INPKl3pA4vBRW
	VJ66ADvK7pfmnledLXhi9r77mv5i0INMn6D4QMpx7bbRmt0ENwmBd9biqsp1VjlQu18UeaXZ2L/
	4RaPmARYTimuAp9etXqKW3G1sebl0PDk=
X-Gm-Gg: AYBFou0wWDpf1Lt8rzhqt0Q18F56qDcr1p+ZeIKNsIGQYIDmAyHDtVbbrvZz18GY1Tr
	iarS2t2uxXjDct82Cpicypzp8+7Gdpq9Dt+9sIOPe9dMx+Jp/SneB1EmeXnFCatDkYgvTUST0RU
	naB4bEzrWKBnYehBsqSeClf9pQZiBdT2Ag810EyPt6LACck3nAn7+VGbTLm0opRFUAp7PkgGG53
	WujN+F/jL4qOxeeDu62eE35BgHzqRQjVUj3wuB8DfAcUAMTBqPy+mn8kl1utW4IFRI72XWZeMwy
	kUHwFDUI2ShftKAnemo7okb9DHOiRKhkXVpxGc6A0pGb3FXPhtEDL0SUZzPqpAzFAxAYu59Je+G
	rkfFU4j842eRNKVKmp8NavRpQ1V+DNKeMECi/sheMnC05uHyhFazd8dJUk02pLWYo4U8DMXcGCJ
	K3s72ltwFDOm8PldUcFIhILR84cLHvSXjTqnGErC4PwuQbkpfpY6E=
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr37403886a91.6.1789056883468; Thu, 10 Sep 2026
 09:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828024335.946-1-nils.lehnen@proton.me> <CANiq72mn2vvCL2VP8yJxmzXM4n+jfV4R7arUcj4UXSi04y5sfQ@mail.gmail.com>
 <CAHC9VhSuuNmdRQ5puaxWh5ez3Dz9LhtAmZU40SUGgEAL8Sn9-w@mail.gmail.com>
 <CANiq72m0yYRj75RQBRprcHTrqfd7=m_OnZAAQfZdO9T3dfUQdw@mail.gmail.com> <CAHC9VhRjjJpv95AgF6cnOdh4g3gC4zViRoiHVehMLx-Fv9b1vw@mail.gmail.com>
In-Reply-To: <CAHC9VhRjjJpv95AgF6cnOdh4g3gC4zViRoiHVehMLx-Fv9b1vw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Sep 2026 18:13:00 +0200
X-Gm-Features: AcwNN1VxW1A9qw4fmjGeQ9XUhu8Og04GW9DSoVdDsQNP46Gy5I2b0ZJEDU2k5-s
Message-ID: <CANiq72mY_Sjg=WnfEEhSx9XZiqwDgqZqSqHa9Tsc4-qR-X8UEQ@mail.gmail.com>
Subject: Re: [PATCH] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Paul Moore <paul@paul-moore.com>
Cc: Nils Lehnen <nils.lehnen@proton.me>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur Ozkan <work@onurozkan.dev>, 
	Atharv Dubey <atharvd440@gmail.com>, Ke Sun <sunke@kylinos.cn>, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'm not sure we have a "usually" yet with the Rust LSM glue code, but
> I'm happy to take this patch :)
>
> Since you've already reviewed it, can I add your Reviewed-by tag?

Sure!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
