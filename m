Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7D2376FD
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683124; cv=none; b=jDcitCFVYy1ss4UiEzUfBv2WKgDu1AH5jaLkwZxY3r+Jid+9ZW7uMkEpoCEcZFdwebKyo2ypgkcHFqpXBDyuTp98tNmJluLfOjDbjQs+1iiG0N/PQuET6mweiVpErb6flS1eCKUhsthQb2B1SsRyvbbllRxOUBLsoGpiuV3YEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683124; c=relaxed/simple;
	bh=6sdCZW/+GhpSl+RtKW0x7XG0A6+UV4qkX3rQBHvdm4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpjkn3cn1ysBhuc43lmNqAp9Oij2GK7bWtCRJ46m07V8/OQNpfoz98mL5sDPJe9hJ/voaFUKAnmqD6KlIe3uqhQ+IEKqC6movvrMK6n/csnUwGpf8YjouwUqbQzV5ZL3TVHt6IqfUEyTmAW/yUfbh0cwaeaiO4zZn84uuV5mgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2KnsuCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2KnsuCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8413FC4CEEF
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749683124;
	bh=6sdCZW/+GhpSl+RtKW0x7XG0A6+UV4qkX3rQBHvdm4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J2KnsuCbBMwX/XPshJbcYXORIh+8IPTm3nG+q69w64koLkZ0HGuugnQmwMk5cGNmV
	 U1fRaRrp5fEBFNvfYqGKSV/iyGKofMSA6Fxrhjj0v/tpqvSmlA9xbuco4Mx01wvZf5
	 vu0SPnyUg5G44KT/LuZOxU2MHIhZqKELmWvrjGGC/UlmZQ/mJ866xmHNDld0CL8qJ0
	 qK2ZfOAXAF0zpsKRfug/bSuBkjRaESuS929I+V4uZ2fdf95OplFH8pK70EG60Supng
	 fJyMGOJlWK0lnAseb0KlgfJv9lgzcsZzayMhOs58GMU48MdhW3bTvjRmCWqXqEW4WI
	 uW8IDUbyaGEPg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so663748a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 16:05:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCgxoYgGuT1beGgz8/5OgyNw0rWO4Mycr/S7mUQxEpgFOkw9/KCkANpQMrQ2ESnwnybQX6gfJqT9247h5y3wv8S7RVjDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzIWEWLp5fg7Q+nhRNyIdVuxviqtMsfZx+LXsv7DeOKSMsSII
	k97AptWwk5296IeevQVBAYrSuuNGotUJnGVBKqgAefTU+87tEVwbEQMla+EWcQVl2J93/NOzRfO
	k7kNf8ho8ss+njGYGICotn88aDJcUhq4q1x7Hr8e3
X-Google-Smtp-Source: AGHT+IGqLuGXesUn9zIoncb8f8aS9r6D6qdVTN6Nv6A9YlUfmlExwFuYhMKW+GFByuLazj9cCB2r60LtXKpbGweQuu0=
X-Received: by 2002:a05:6402:5190:b0:607:f513:4800 with SMTP id
 4fb4d7f45d1cf-60846aefabfmr4727809a12.10.1749683123066; Wed, 11 Jun 2025
 16:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-4-kpsingh@kernel.org>
 <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com>
 <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com> <CAADnVQK5J2REAWXp_KrLThOp9n1=QA=ugxB2Mb7=JmXnSFxQYg@mail.gmail.com>
In-Reply-To: <CAADnVQK5J2REAWXp_KrLThOp9n1=QA=ugxB2Mb7=JmXnSFxQYg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 12 Jun 2025 01:05:12 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6zmgrOBzTKoQ_Ta9cwyQAC6H0H=JcbX2d-9tV36SoEVA@mail.gmail.com>
X-Gm-Features: AX0GCFvzJxE1np6RWJHBCz1Jzuv-8vyIb2oF73EMf8JTPyKVshfCKExZX012zhk
Message-ID: <CACYkzJ6zmgrOBzTKoQ_Ta9cwyQAC6H0H=JcbX2d-9tV36SoEVA@mail.gmail.com>
Subject: Re: [PATCH 03/12] bpf: Implement exclusive map creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 2:44=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > On Mon, Jun 9, 2025 at 10:58=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:

[...]

> > can add inner maps. I think this is a valid combination as it would
> > still retain exclusivity over the outer maps elements.
>
> I don't follow.
> What do you mean by "map can add inner maps ?"

Ah, I missed this bit, a program cannot call bpf_map_update_elem on
maps of maps and such updates happen only in userspace.

Thanks, updated the code.

- KP


> The exclusivity is a contract between prog<->map.
> It doesn't matter whether the map is outer or inner.
> The prog cannot add an inner map.
> Only the user space can and such inner maps are detached
> from anything.
> Technically we can come up with a requirement that inner maps
> have to have the same prog sha as outer map.
> This can be enforced by bpf_map_meta_equal() logic.
> But that feels like overkill.
> The user space can query prog's sha, create an inner map with
> such prog sha and add it to outer map. So the additional check
> in bpf_map_meta_equal() would be easy to bypass.
> Since so, I would not add such artificial obstacle.
> Let all types of maps have this exclusive feature.
