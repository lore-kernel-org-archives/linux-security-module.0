Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3C80B
	for <linux-security-module@vger.kernel.org>; Tue, 15 Apr 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682303; cv=none; b=bhFkW2iNpEjL0SfvYiEfdQw4t+QR/ueHmaysCfKnENt/5l7crVwAtqhKCEQuMlzJCtjX8pIgK4dgNSFg097W0C5oEKxVWk49hTV5LCDUyy5IkurDLEmGm2CzZVsBmf6RSGxIzXmDMlyfF3SZLX7lKVcVCVCC6i4uYvXK/IXhn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682303; c=relaxed/simple;
	bh=rxUfE/v2nDHJxUYj7jPx7y6EB83OwOnUI3i7DLmxAuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGIAY8rywLjD228cSG1P+NI5wNGY4KEDkx7MMb38wav00hRZcrF0lwgDCsyjS/nwjn/rXxcGYYKKSmO3N/t025yDOu2HeOWa9Oi4LpFvti90qYDH+h2758UdhGUf0hTTNqXKzakIbvaRGRbFMzdYOnhrFgTz+ZKqL9fBnYItRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XEflOkZV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XEflOkZV"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e6dea30465aso4234046276.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Apr 2025 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744682300; x=1745287100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgNnzJLDju9A10e50BztXbFlpGHdbLWVEcQRfEr8Uao=;
        b=XEflOkZV4UIL5V+xKBe4TLQXozbELihpI2uHHbBzD+r+H3lzBlic4kfWhJ9kHcKhcH
         XeVrog6gXYuqMB7fszOIMcq8trvx145vOFl46WI19+SvbBc11Q1Hw1w49KpSFlFDtVw+
         7DPvA90IrdT9oZ+MR57IQ2RA8OkmBhAEvzcY8AEamCxB0qH8ZdHT9XYfSv+/SMoc6uq3
         RCjy6OeJaGYPM33YRzr9DLX5w/bvWXEfA1K2o3xAkktaMGRk50TjROE+z0QIStoDyZw1
         l0VQ+v1t66dyShfkMDMkndzD2K9nJkZu0LjNU9cYw6Xf9Lz4JBEM6zjpJwA0kCFx1+Fv
         ck0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744682300; x=1745287100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgNnzJLDju9A10e50BztXbFlpGHdbLWVEcQRfEr8Uao=;
        b=mO3duv+FI01HVQvEGYsqCzoPmcvAnfYm5M7EPDyVfWk5tNr+3YN/+CvQS6rTIoULkV
         XBNNgtDbwpWwwH3znvWd7fxKbp8KmdYLVgco5c1r7Ah/qn9CeB75vhsAVAQGq9oxaR2/
         UDdBreUkmEZL+zn1uUDhLwhrodhuCncrATdtBVa7ztgVVB0flq7oJCMt/mQWUKlZ3f5Q
         RdEZ1IBMnkx2Ao2fDvr/NNqz4BlSaagXF8UK6HKVIbOTpztrFV2mvIgWk+qZqzmIsh2F
         7aZrw8x4t7tNk1iNHkk6ndYdhw/V86U01GVfMiK/kjOigV+orrunwB4iFTKdhc3dvQgB
         AHHg==
X-Gm-Message-State: AOJu0Yx9rGtxqCdEyt+sUW61Vaz6ImRM5X4njDzPcmuYSEPaoWMUXuDZ
	1iEjkv+z/6qZNBR8MPhfXDSGAELipZMQ3wDrLfyl+erFD/MkXR5zDRFk0eFbrTBbvLozad6Uumk
	+1wscadlPcX4yh7VvRT8mygz6BRPmthUNbzc3
X-Gm-Gg: ASbGnctSvYkemahtEd2Nosep1UtWSZpnvTHCyQGihW4lLQjsa+lb8W0csM1lr6glRZq
	L5IymhwSz5zjYN6UAZT7FN655i7ofxFy4nMgP++pSqUimiXuJU3VId0hk11wMwcyEVGJVStQcGZ
	0o2rrnKXpc2M/IQ34v+yVXJA==
X-Google-Smtp-Source: AGHT+IE+O+qaO9IzOFxYmwdXgL5o4sY4lXcGxON+fCx0AlD3dy29wINp9CXDcgL2xssdQXTCuf5oMj4o1y2NmO59pkc=
X-Received: by 2002:a05:6902:1606:b0:e6d:e183:4e0e with SMTP id
 3f1490d57ef6-e704df5f8b0mr21296050276.22.1744682300213; Mon, 14 Apr 2025
 18:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-50-paul@paul-moore.com>
 <CAKtyLkG3PEwpNV55mpsntp=pbRjaZVhoYOc2wWGCsoEdqnFS_g@mail.gmail.com>
In-Reply-To: <CAKtyLkG3PEwpNV55mpsntp=pbRjaZVhoYOc2wWGCsoEdqnFS_g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 21:58:09 -0400
X-Gm-Features: ATxdqUHXTqHh3BTd3Af7U8uMaRUAJKrsIIuJHmSbWNQTnuyizJTe74CXY-81aIE
Message-ID: <CAHC9VhSDqftrOS=maqPhw6A46X7H3X+QAc1AFXeb50GRdjbm=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 19/29] ipe: move initcalls to the LSM framework
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:19=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
>
> On Wed, Apr 9, 2025 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/ipe/fs.c  | 4 +---
> >  security/ipe/ipe.c | 1 +
> >  security/ipe/ipe.h | 2 ++
> >  3 files changed, 4 insertions(+), 3 deletions(-)

...

> I have run the ipe's testsuite and all passed.
>
> Tested-by: Fan Wu <wufan@kernel.org>
> Acked-by: Fan Wu <wufan@kernel.org>

Thanks Fan.

--=20
paul-moore.com
