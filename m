Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E391B4F0E
	for <linux-security-module@vger.kernel.org>; Fri, 22 Aug 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827978; cv=none; b=VLlPLqt33B6ACTzLyiCS1+ayANGI/Hw8LMU2MbjK8dXqa4qsJmucbzTjhGI6dkRZiWt0Ug1998dQXKtIUA2NdMa2FWoF4/oir+YcAchb8Zt3ZasXxismvmagsYn5ItZpre6wHq4OS4C3LcHLgSZTH+Ira9hxlzBo5kd4yFWps/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827978; c=relaxed/simple;
	bh=TsNvDlSM3gTmQZlPmCWdbzWUbbUcf6kgb6BjCZfXKWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRu757NsYBR9XudYcN70j+QeeldaGEI8Y0xV7BZeNRp6YkucC4jHrKsFqxZaIb59mTI19nLFn+Lecl18dbIQuwJDZbwylkptGt70awEY/ZZ0Yt15C2Io1U+cEEAfUlNfqA4C3xu7/Zuqi6FWNp4xjdtffjNfYJF7IglcSn+0q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MERo+fdJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MERo+fdJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso2204607b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755827977; x=1756432777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsNvDlSM3gTmQZlPmCWdbzWUbbUcf6kgb6BjCZfXKWU=;
        b=MERo+fdJcSrwdNWzlgZXn2nqkb/atm+apeRvsEPfNXHeWjYCGlYLuZGh3Jy+Hg3NRY
         7yC/9bZBiYGn0+0kiU/UYBYnxJR30TwOSZz6x4jy9cQTKVxn8NY1RM93vTA0abMlmLRG
         9/LcYKJAvDIBN7ii5507YK8yRPLhCid+u1/jWcBgqR6kXi2MpimY1GODT36m3oewPpFX
         Dyyj8kZ1bMlL07n1Z3T8ju6nk1U8MGv9kjHe/52IgIPlrakewaIx3d+QwetXxGCCbTfv
         Qxg1dw5Bo+ctyW1q+cwhPggxUd9ZzZkXSQzDAPEfcRAft7+i054+dJ7gfS/1Fl+21Ld1
         aB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827977; x=1756432777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsNvDlSM3gTmQZlPmCWdbzWUbbUcf6kgb6BjCZfXKWU=;
        b=BiJlE2SVowghbGeFrDF2ADRKmkaZCaaruxFMygqFW21eFbARab80nCbfOGrnYdRF95
         MqWIMf/MY70rmdj/oAuXk0zHL3l/XzqA/AnPTgNBvhbE6oCoez5zWQGnmP1dFzW0VBjy
         yqZKf6hyTezBkPEHuyp1x/0bLsDEqvXixMxDmvfpKX2QHyEI14ebbVANuvCa3D89Hg73
         /qaie2lLy40wIShab9gUiXv3r6ScW8OLH0W8NbFggjQtwLS0MSqvZQ5p3T9naBbnv3yX
         qVlC7kLFTcz76gc5Vv7jdMYSr5bjQo04WalHC3Kj+zdcr+1h6B9TP/UzSIcXn/vilflU
         0ToA==
X-Forwarded-Encrypted: i=1; AJvYcCUyGh5rS70o2PP5MNK16ipJx87fTBbBNoahkYMKBNzrn5iTcFNPnURxT+Gm3nbwRq1Xxsg0AWRGeqFia1BnGy9lSRecWdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oGBHEvj47siJ3pJSb6edeLQbhvEZpLE3RazeLkFXpVwbhlKz
	vuolE/8Cq0w7iob319ITF2GHgFUjdQwesjXozptbjvJfMhawwjwiU9id9xS7FB1VygnC3dIR4T4
	UN2FV9zoBYP1CS6WINkuhXecqlC6ESjlKHc3yfnm1
X-Gm-Gg: ASbGnctREwTulQRq9nz243pArk9+nskIVcDaLxSCflvw3KebdziBZahnx+aT/dEUfaf
	o7gI2z0haHLhJx/AyHbody1FCdGhnwfbr1VTqS3TMJcM7caojzS1fBEvR8dj+alZAoh9tFjRhF3
	K+QYS7GJoz+T+dLv0ejULeFamUoRObyUcTdMCuds14AuxrGbrpEInD8wiZNUI4y+gb7eiO1h7rP
	U4nGgs=
X-Google-Smtp-Source: AGHT+IHGNO4iEBDmIi3DVZcy3lafa7NWsHIA6a9tO/5Ie7EVox8OrGnAGwKfGuYi3Oa7zqhlrzLYPlyi8GEij6RXFk8=
X-Received: by 2002:a05:6a20:549d:b0:240:1090:76f2 with SMTP id
 adf61e73a8af0-24340ccf1d4mr1803058637.23.1755827976647; Thu, 21 Aug 2025
 18:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com> <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
In-Reply-To: <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 21:59:24 -0400
X-Gm-Features: Ac12FXwauI7eA7Trf3V22GYm2aQdDEQlqqrtcS1pjjrc1NspBpwZU8gWgWLTUaQ
Message-ID: <CAHC9VhQ1hR4Yowf0a2X9jvY=CobcXVa=4uCwa+qwvktBGReUUw@mail.gmail.com>
Subject: Re: LSM namespacing API
To: John Johansen <john.johansen@canonical.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:46=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/19/25 10:47, Stephen Smalley wrote:

...

> > This is handled for other Linux namespaces by opening a pseudo file
> > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > do it.
>
> That is a possible interface, not one that I like, so I would like to
> explore other options first.

Fair enough, suggestions are definitely welcome :)

--=20
paul-moore.com
