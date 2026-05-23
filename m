Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6E2F5337
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549176; cv=pass; b=HCF3+pVKyNIfvHnYto7OovskLkXUHulPcy7TV9EBEe7ekZF1MxPhg2rmkvHyYVFGMq5AWTyxFcIJMLC1DhX1m+5ce3JhAI/T41b8dQh6mnBKMGC4BGIL8DSbS3d6/qoKKP9Imma7hinN41OJf6ni3YKnGQaORS3p1lOFw1UtppY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549176; c=relaxed/simple;
	bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVOfnKL/M1m6kOYckFpe/pt2hS6jwiyFhXoImIQftlokDpPcLlhERqFOO3bYO6Qz7Fb0o+5msqPxDoREZGmtvz/ftyClsqMPKBWZFQq3iiX8qedmL/ZzViQpnLlNrWf02cVm8Cu7wQjzfGrMwI4f7mIgTUS1+pGg9JEEa/kXTws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTo0ODJh; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTo0ODJh"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd01481e592so1158047966b.2
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779549174; cv=none;
        d=google.com; s=arc-20240605;
        b=avFTWlzKP450Br+8tlFyqBBjt8LW9F4+KEXljVfbZDTh6gq5eaYRossZ6JUtbbQu+m
         Y357R6CoCROoInNUX9GdJ4MvtYZdSF0m9iXZdq4YCi/d/9gwrKhV+Sd8cbGcFezfvuLR
         VlTJkiyZvBc4s0ffluwZ4BRfDXz2bOXQ8Muc3CejRYlJHsFh4QurGDzBh5ck+CYonLYx
         KHK9uwxqeoe9AAjw6wA7cYnx62HEYqy27ovDVOKAhIdutTdoBihJapJfH+JpFkalo8n4
         mcBozCIztHLIyGQ4E4oom7I8P28WxDxHDZHz+EJ4Mzw3UxGH3HVDVScpkI1CDt5FEhc4
         sYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
        fh=1Kd1d3L04TN5bOU5O0e+WTcAoQw3/0ObONTX8HHQtiA=;
        b=JVJY+rzqmMoJdCz5lgS1aYTBZDfXRM5yKY5gckh2IiZvqr6zlHIYCf71S8NgAa8Saq
         7bXxVDfMsaX0KfwMUb/jn5TyFUajJn99m288y3ve1Is8VooRTSspFxko5SZsA0wuiXPI
         XWbS4Cn/mKQq9Z8vVLcQAwxJw/swCa7HP4Z/4TrcsmztaEyT2ypdIAhPD0fi4BKRTROi
         Ca7HuQ/W4+Y8BgEB8yb2a+Fiv/y+5irZ96vzrYA+P0eaELsv5zV3aO+ri/Rkn5DYCl6k
         Foj7ZntzKvcFHzCnOQuaMzs1PuKEvWz7EdIkmrNrZ12aejkxM8eGumFZ9KTuZxVyfVKl
         eL8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779549174; x=1780153974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
        b=sTo0ODJhSGgTPaLOFXzFX4HdjIkATRqZW+6paWIZBh/tFbagXigSvErYZaxmiO2If+
         LIUlzW4fwspUx3XxDEDYtUW4pGMTKgLQk9VQjEOV3cIySfPEp1ej6fW5fv1auxASY+f7
         AvYQh5EI1UgGlmzZTBpoBjqNXJNFdJdUUxGEXTmDigpjLlJcO1xXsxknCx42bZnv9Ckz
         zX/oXNN0DF0yECo1W727AGpOyvL07CB2AvNJ8ipDHPxkOcgfjdstA/WpOHQOZxOWiPvc
         Nh/JrjB9kkmYw2XxDtqjc7JOJ7riD+li9CdtMJZZCgubRLGsHioimyEpGO3omLmA4BMY
         yiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779549174; x=1780153974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXweQlSTY439N5FsVp9L79ILRWkzGCzUAOwk19AKHIs=;
        b=ElSNiGKD9ZguzyxLfOEdN4/BOwBptYtk8DUXuKaiGSdYBUIRqpVl90d9HlP54gs7Li
         B9VRg4cTJe8b1KU3OzEciM/42+nBmej95Mx2d16QpgVnL1Sc2vUthS5ii90i2ryq4s+A
         vKD4hRKCd0p6gsuuEw8NGukMbJ5dZ2tN/bOUdDouFfy4oxw92RTR0mF42mhnFsmLEK2y
         zRgSwNijJI5pC63cfwjXBCDH3HGdoKinLxKyWe8zQlaP0m5EoKZfDU3ujPUW/WL8pBXC
         pt4oh+mo87O+8vLJGci/9Jk2xbbiTFm/VqRXLkYDVH0gCs1X5uMqvp9lfE6xasOvOhmk
         Lvgg==
X-Forwarded-Encrypted: i=1; AFNElJ+P1AcZGusy3zOaiwxHn3x/vVfGn0Aew6axXYR7H1mknerQ8qTWmc8Labp6NCka+Gwa2eGjEDc14KsyBYAI5xYK7hWgVFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEOh3j48OUK0p/nNv2jlrfp2/nTJoOQU7EZPEt4WNF2/ewkbY
	42Mt4dIx0ox/f1FODMvXPfP04SYhzf7u/9ji6EwW5shhYoaViJlK5wGKcGHmtEZzZ9JWa+qaQ9b
	mGHo6IWtLdtfg99aYvdJ/oPuhIbfC4tU=
X-Gm-Gg: Acq92OEM9h8wPr2MBgahr6ZP6C1ltsQ9ByT7TJQPf0KMRkmWBWHmqmstqXBvUJn+gtV
	ksBFFej7ylMvRg+CuU9Sn9P20AgA01hV3hSFyXonttLa+2N86TCOFdAmKmKzyqiZO4i9ktCahX2
	bNXyvaNJEYjlbRreF8w9N4tfnuhEAcJWwnE7gnT07iIlOSt/Q89LGL6t+FMinaxxl2r0MWYt1IU
	XcqJw9lKyt3bteNUG5Fnco0UJS2LnRFfrs/iRn+/q2bOj0i4187FntcLUAefNZsnv839uHb9zLL
	zph7hvvMMJv6epUKomRWpDRxmoM/wIDVB1KXb0TgNcPHQ2oBF7Uua4eKirZBrhkWlcexQmv97c5
	Nhf4=
X-Received: by 2002:a17:906:8f15:b0:bd2:fcd8:4cee with SMTP id
 a640c23a62f3a-bdd269cc4abmr545521566b.44.1779549173807; Sat, 23 May 2026
 08:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522215337.662271-1-kpsingh@kernel.org> <20260522215337.662271-3-kpsingh@kernel.org>
In-Reply-To: <20260522215337.662271-3-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 17:12:42 +0200
X-Gm-Features: AVHnY4JSIMlMLQk982pu9YISI9sy52gJIfolrDB7dAzvIyROzeyE2dWq6fSbhP0
Message-ID: <CAADnVQLJsvCfRxyLT-NJRubwSPTNd0k5bEp45Zyu9q1B_3oG+A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata
 maps in the signed loader
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:53=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> The loader verifies map->sha against the metadata hash in its
> instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is calle=
d
> on the frozen map.
>
> While the map is frozen, the loader must also ensure the map is
> exclusive, as, without exclusivity, another BPF program with map access
> can mutate the contents afterwards, so the check passes on stale data.

Hold on. How is this an issue? excl_prog_sha guarantees
that only loader prog can use this map.
Are you saying the same loader prog will use the same map
for the 2nd time. Ok. I still don't see a problem.

> Place excl_prog_sha right after sha[] in struct bpf_map and have
> gen_loader bail with -EINVAL when it is NULL, via BPF_PSEUDO_MAP_IDX at
> fixed offset 32. The 8-byte read of the pointer field limits this to
> 64-bit kernels; gen_loader needs target pointer size tracking to emit
> the right sized read on 32-bit (follow-up).

I don't think we can go from maybe-racy to certainly-broken-on-32-bit.
So only applied patch 1.
