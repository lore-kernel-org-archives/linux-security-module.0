Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40E23C516
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673639; cv=none; b=X/jqEMzuw61YweLLvND9t19FRjMridRlwY1bT0NTWul3ATROMINf14b3f5+qo9oKoDFlMROOzGLKdrIajM7O6pf5BvBWe/uf7saVEK+5D2EYhAbbzUdGmBFgDZ/K0B/FQm37Sw7Lo9+Z8YU7G4kqV4s+sYiq9tJ9gQ55Z05brf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673639; c=relaxed/simple;
	bh=b462XvDCSfMevaIQxn3sYyGpMaL7uBHahet9/QOpJHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaP+kexVDurR7jXozHEiVFDxNnX3gFXQC+eluLrqpMk6RPgZrJqVkZE0wdG8ta1zBi3ZWJK/rE8bYdS11ZyzEid2CcCHgy90By8LEj6G8c0Fl6AJu54HQien+23wvwRevPHMG+ydiObf46IsWFN8h88ikm2esSmw3kNhsn6AyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eLn/4Us8; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eLn/4Us8"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7111d02c777so1594477b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749673636; x=1750278436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3H1uAtO+gZJCXVOFgln/U+eNFJCAoQXkaNwNc9tito=;
        b=eLn/4Us8K6pgDk1K37yxhLgGDY/R4sI3hM6xguaNs6VXi9CZy6IS7RdfW8Tg0J3mR7
         X0G3ijtJngWy5hdPSq7ARs94PS86Xq9Ix92Pm9X2Q1kVkIKaqHMwflTzpb1phnfi4md7
         Iwbm7h1bhQuRtbAT1eLOdxYLM9GycF272IjYpnjx/98DK4pd9JARNUHp/7IjVLyrWzqH
         iLpJf5YRVXU1pLb5J+uOW3q+S8Jb9MyypZ/554NCMz1coCtNEuVnxbjYTMUSyPR4EDxM
         Dogv+t5JtOLT0nO+kLANyAsVQYAkarVnn2Z/PrBFlApv3tCQ5n4TgsX9hw3aWRSGgulb
         8XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749673636; x=1750278436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3H1uAtO+gZJCXVOFgln/U+eNFJCAoQXkaNwNc9tito=;
        b=W1c8L8dCrGvgh2lJ7yUbS5Tn47oMaNyUxHiJbDDB4zxQWM5JP1NBUwXKh59PDpCxIx
         1n8O3uAUXq1Lw7A2o+dNfowRI6dGdrYJd3LDNGPF/UHeEaPrXJDiNuYkGmapfqeMUseN
         jTGqqwmuJKpzKWGBzodQibue73NaTxBGpWybnMLL7yI1dWo0pbAl1LYvjN9E2v2SSa6I
         APw+RItRpfv6qWW2MVtpEZilQXoFjifk78g1hkWngDHzmSPzqXq+Q3PfO4+LmHjKA350
         SG7yRSSCcrRcJBClitt8rhghT9TtKXf6bvNwT7HdckokdZ20Y41TQ26cgBuew5vZfWEj
         WszA==
X-Gm-Message-State: AOJu0YxAWymZXvlLwuUYOA89k4Wumh29oHKEf+o6hKv1Ub01HninBVhU
	tEej8SMGoFU/6dtHC1742zi8wR9oDJuTxBMFSc54qeZzKEhiH4f3fGdbUz/Uu8en2udkqXHCi8v
	waoyJC9Qyqc7UkOhjsiKQgIj1E7+a+wrsIXmg2InV
X-Gm-Gg: ASbGncsCx6dXGAgKjKEDeoEtn/4Ux1TiqbgJDcWG++TQeyQfvNB83ocBo6TSPjqV6I3
	q9tBsPmR/YHEPxLTQP6zEEvpWxwW11u7o7sfeB8jcKg/eQzpBzoVFVLu+eYdxrnDN+rZSICJ9rc
	R2r5659K332slqwqYZm0qZZ49mr5qEQMSn7/Ch/EJTsXo=
X-Google-Smtp-Source: AGHT+IEVVLEbhs1siAlIrgblMXiy7/1GYb0zZZID5dw2ruoClMFtAoDqtrQDzTOvm/A3WlpYxkgeMG1oUpdy8wiHzZ0=
X-Received: by 2002:a05:6902:2408:b0:e81:e0b4:1bc2 with SMTP id
 3f1490d57ef6-e820c7d6b2dmr752984276.10.1749673636310; Wed, 11 Jun 2025
 13:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-56-paul@paul-moore.com>
 <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
In-Reply-To: <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 16:27:05 -0400
X-Gm-Features: AX0GCFtB1BfHO9UnqaP7qiGZ525Kvp-h6Jc_bADxlaJPbPrl5km3UWt0_EFnhUw
Message-ID: <CAHC9VhTfNQeu3gcWii7kUrGY+fVygXs6j4UhybodPqjuSzA-pQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 6:04=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2025-04-09 at 14:50 -0400, Paul Moore wrote:
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism.  There were two challenges to doing this conversion: the
> > first simply being the number of initcalls across IMA and EVM, and the
> > second was the number of resources shared between the two related,
> > yet independent LSMs.
>
> There are a number of the initcalls under integrity/platform/, which load=
 arch
> specific keys onto the platform and machine keyrings, which shouldn't be
> included in this patch.

I don't want to assume too much from your reply, but if the cert/key
loading under integrity/platform shouldn't be subject to the LSM
initcall rework, that implies that the integrity/platform cert/key
loading is independent of IMA/EVM and should perhaps live somewhere
else, e.g. security/keys?

Or am I misunderstanding something?

> > The first problem was resolved by the creation of two new functions,
> > integrity_device_init() and integrity_late_init(), with each focused on
> > calling all of the various IMA/EVM initcalls for a single initcall type=
.
> > The second problem was resolved by registering both of these new
> > functions as initcalls for each LSM and including code in each
> > registered initcall to ensure it only executes once.
>
> With the above change, there obviously will be a lot fewer initcalls, but=
 it
> might still make sense to keep the common ima/evm function.

I'm not sure I understand, what do you mean by "common ima/evm
function"?  This patch doesn't remove any IMA/EVM functions, it adds
the integrity_device_init() and integrity_late_init() functions to
setup and populate some keyrings.

It's also worth mentioning that the goal of this patchset is not
necessarily to reduce initcalls, but rather to ensure that LSM
initcalls are only executed when the LSM is enabled, and to provide a
mechanism to notify kernel users when all of the LSMs have initialized
themselves.

--=20
paul-moore.com
