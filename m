Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CC3806B8
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2026 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680359; cv=none; b=pf4/eJwUY1GcPwA05labLadn0XLFy9XQfSiseU6h5VUPo7eyyzmTILcojqXig5rotresQX1iT9RVOC11KGspOhqQo5zzTPEjURWCSSpK+QMQAzhkg/zkjsl6rRY//NjYV0V8GND5WEW94gtm/f/sioNJRfrXl56fnVquw/QwoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680359; c=relaxed/simple;
	bh=HdIZAQh/9RFpUDLiDHRlKc6fZPdDRKlHrJyvQhmJD6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfsllLsS6wkF1V+9FqfBWIwH1yRvvEyCUUt6NCVWlXFvKqX3RVc3NeEnXGgvdJaGamZPhY//cEf1yY0Q5b74VpjFLMYT0eO0l9jH4dEGowy3OfWhm9Vd7fCtIOHHL/OHxQVahfS01CM7b9V93TtVo0yiAwcDDvAL2lBlUSfyppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yst11GOQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yst11GOQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec3f69d343so337275366b.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2026 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780680356; x=1781285156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eClztFfJ+DkV18cFEkoMrmwHyQzCIK0BXK6wGWgeyF4=;
        b=Yst11GOQQVVuCP6r7ByVJkGVFpO9E/xzY3xT3EVMuAaeDy/oWbAVKzNi/uZhSzGzFq
         g/800g4fuPMiU3DWXijkKsWlMCfpqb+yAkXv2Kd7rrVofmNBsXR05f9nY4ofr/zhJbL3
         ZlbuFVK8xHhPEO1uqhS86kvg06V43jpDpIQTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780680356; x=1781285156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eClztFfJ+DkV18cFEkoMrmwHyQzCIK0BXK6wGWgeyF4=;
        b=i0NSIqanPdT6xB/8GY/9kFKZgXtnnfpNBgKE7Dq+Bqt9wBn/8D7qanUROBrmV/sQhr
         yl4E7H2MKkv+LKV9RffuuZdcMOObP7P1yCNeDTTROFx3Zgg+nj0OJput+mXIj4ao0MfQ
         y2mEMq3w4rf5PSvi2EexzPpnVFG/iuHTcHLjwfBL4YnSD890tQMiT9NReSJhus9g+h57
         CTCD7uce/ti7cewnhZln4diNMRD03q8FPgAqEicIXCCg1fGIPQzZ2CKUaLTxVsoX9ijV
         xokZXfLEBPBNS1IGiOmZ85p27c6lA7DcT9SZGYIkAwTVu8YCD37Znu8NWVpdMT68YrrJ
         2xiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KukLrlL5zZIv5mt5Q/BZcZPzH8bSspsLVEXixCkNX8yFJRbTCKfm6u1C5cL6GrTEnO78DIfQK5eT8bjjz/RhMO1736N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhrd0f2M+TrozDSCuIdQHV8+32YS1NQD3vvQWQuUaQuyhGsfvD
	crCc7+eLL3BEY13NZjkaZtO7l5lYGnSQXegM/Ip5AxupMSD2EUfVzBCz5jCXQhhvCt+xZQPc3Lw
	Wqawip2MCWQ==
X-Gm-Gg: Acq92OGD5WBzEuqHjMtZGE4Lj50iDh6/FHkx0EDhp3F3V5VwAQVQFDkHCWhpE/GaQ2G
	aueOZ6vZwwhjAONudh1+UEeUKwpwhEPH9lVYHh+LkjGkj85fg+fwymVmBrkst3SCAzzkVQWIuZb
	e7EZFB7HbudjsVicxmtAmVe0aOgYhWml988wlBoNRBnaCZG+eQVeAUTwD/wgdhX6lu58tHk2Ie0
	L01u5VCPz1YCcLItdCjsL1iBWtmuqyrTZrKQiLWD4Q+rjTj5LO7zPHFxcTlTwOLBvjzBSNyIUiw
	SCeaReJeREeuMU+kKuvjJqyPA24/DDHRcciCou1AkZNK7EeYk2QlYcQcGeUX364CG/ppQmwZ9jH
	LEVjocUKgiibXGeARG5ZN00cLNU0PF7rn0YeP5ncQ9CHqwrORmihqx3y/e6b9FQ1mzRZRIbJGfA
	TMnMo84+oEiXg825Aqcn8ECsR92/mWXbTQLRvEYBgM23VRQh/BiJugLxaZ4tggs6IGJnCbExf7Y
	bcodC4q5gk=
X-Received: by 2002:a17:906:d552:b0:bf1:1d19:cf95 with SMTP id a640c23a62f3a-bf37077232cmr291487566b.12.1780680356056;
        Fri, 05 Jun 2026 10:25:56 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055500875sm479022866b.53.2026.06.05.10.25.54
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:25:55 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec3f69d343so337272366b.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2026 10:25:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/BfqPuK5BDQvl1qACcDfh1sn+y2RV4DZtXmZz3zRNWxYBGK8hWTlQmXIY+VzAykx2OhbXM70REd/DNWoZF5hPqlexW390=@vger.kernel.org
X-Received: by 2002:a17:907:cf8c:b0:bf1:7897:9477 with SMTP id
 a640c23a62f3a-bf370b6008dmr245196866b.18.1780680354400; Fri, 05 Jun 2026
 10:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
 <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
 <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
 <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com>
 <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com> <aiLS4wOtpqrpw4pA@mail.hallyn.com>
In-Reply-To: <aiLS4wOtpqrpw4pA@mail.hallyn.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 10:25:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7Zk0X=FyYc8gJpR1=U0wWJiiOzNzpDUj5PdJHd=ryiQ@mail.gmail.com>
X-Gm-Features: AVVi8CcLuRe75DJKrgOu14xG1-XM3Ks93m94kU_UVSFKHwmay-oxCn6KrAS5ua4
Message-ID: <CAHk-=wh7Zk0X=FyYc8gJpR1=U0wWJiiOzNzpDUj5PdJHd=ryiQ@mail.gmail.com>
Subject: Re: -next status as at v7.1-rc6
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 06:45, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> The two most useful threads I believe were from a year ago,
> 20250502184421.1424368-1-bboscaccy@linux.microsoft.com
> and
> 20250528215037.2081066-1-bboscaccy@linux.microsoft.com
> which includes the proposal by the BPF side:
> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/

Ok, so that's not a thread I was cc'd on (and I'm not complaining -
this is not code that I *should* be cc'd on), but that does seem to
match what I saw in email discussions I've seen.

There clearly *have* been alternative proposals by the bpf people for
signed unprivileged eBPF.

And they have apparently been ignored for various reasons. And it's
not clear to me why LSM people think they can just ignore maintainers
in the subsystems they want to then check.

Now, again - I'm not claiming to be a subject expert, so I have to go
by maintainership trust. But as it stands now, I really don't see why
I would override the bpf maintainers' NAKs.

And that "as it stands now" obviously very much includes a "maybe in
the future I can be convinced that the bpf people are just being wrong
and overly difficult".

It certainly wouldn't be the first time kernel people have been ornery
and strongly opinionated and just loved arguing.

That's the kind of people we are.

                    Linus
