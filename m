Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AA233954
	for <linux-security-module@vger.kernel.org>; Sat, 30 May 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102646; cv=none; b=tO0/9CE6uJcn8zvH5MXlsGv6h385zrNqTNfLAN6rfpWbQZCdt3X5jdMNZ+TvdHtmHH9UajeHcBLhF2VH7zWmyNsHQAmc4E/sXUPC1FQN5U5tKWOUKqRsDay1GbcQ2KLZozP3b5/8Qfgl0nibfJYzt8ZN6MYyJlKH3b5v/6Xp+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102646; c=relaxed/simple;
	bh=v8oXkzDlceXmXFA3LQtTdYysCbooq6C5+ZRlxe/+7ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+GXY1vA1L3qOKJZurtdOj3+nblSD/zP7ycVNjPM6gDpwv206k565dAiP1zijZx6IFPzci4R41pQiGpjn7CXGpqCbaM7pJCbfO4w9iB7IQUCIwr6rkeEKGS/O7n+43ydqaWaSd/6FNi+Bq96ZEwBW+OsMoV+nrfM4RO435w23iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZJmJ+A2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZJmJ+A2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC571F00898
	for <linux-security-module@vger.kernel.org>; Sat, 30 May 2026 00:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102644;
	bh=v8oXkzDlceXmXFA3LQtTdYysCbooq6C5+ZRlxe/+7ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nZJmJ+A2J4gAXnmb+gSigA1s6on6CKi1IHuz++9blkWeWmoE2sFwGEVNRNV35gtGp
	 aui6MxUZ5jobsQmrGVTmMUL4i6OAcREOQCb5OuxShuJtyfVC45kEPSlefxcDtstogS
	 QVeub85ISS67lDTmOYvgL+sp/QUB8KFMFKvYWPQ6Bw/3WgimbEEUTewJzlaGvE4WSA
	 PN+qNQaowCipwMbefjfthwlo5/oiM7ffHGJy7+SOidaqA4jlUbtt6cpB+JZL85zQ2e
	 u/yXoCM7LWXVydJng+ScCxoG8V6gbhozlTBQB/l3bWvtWVnoItQY11DlKTCX5/Enq6
	 K9M5lEcYeXEOg==
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1363e78746eso11138632c88.1
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 17:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9814yHoUIikOVJfhJcHbd80htsk7Wae0TZE0nIM/BQo93kPvLs+arKMMu1MQQAuwwckn56ZSDuoGaiBJcokJkmMPqL6bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDylM96paXxMeaDZaZYQF3crJ/vavmafHQfIt1XC800KPpxlm
	TeskV4OzX98fvA+eE04H336S9H9x4/1MOEWuHvwl/MPucz1Np+u6yK2yhGKTgnUai/fdYTa/QWg
	X3TvVlwNinHjnUijtr54yhA/TEfGZU1U=
X-Received: by 2002:a05:7022:42:b0:137:567:14c4 with SMTP id
 a92af1059eb24-137d4280835mr846430c88.29.1780102643870; Fri, 29 May 2026
 17:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com> <20260528030915.2654994-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260528030915.2654994-3-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 29 May 2026 17:57:12 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHtjzP3YsDr5-Gw0GRFB7Ch2h1amZzxy5taTt_+3gSzwQ@mail.gmail.com>
X-Gm-Features: AVHnY4KwvbcFM_t0EKZuODgRc1dMwAsFPfqWCIsAaxd5iIsNN7r0rzzdKOiT-Lc
Message-ID: <CAKtyLkHtjzP3YsDr5-Gw0GRFB7Ch2h1amZzxy5taTt_+3gSzwQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] hornet: invert map set check logic
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, Fan Wu <wufan@kernel.org>, 
	James.Bottomley@hansenpartnership.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 8:09=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> In a multi-map hash verification scenario, a logic bug may have
> allowed an attacker to provide duplicate maps to satisfy the hash
> check count. Instead, invert the logic to verify each map discretely
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---

I just realized there is no audit event if hornet_check_prog_maps()
fails, probably should add one.

-Fan
