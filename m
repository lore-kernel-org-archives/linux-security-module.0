Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80C4315E
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776861; cv=none; b=OhVBsPdzji4xeyAHd9KrLwe4hVsDr8mLW3bgds+TtMeadOOfi/Q3SgABbOPH+blc12Eg9ZSeld8YxWUq4ObS4BMe/Y9dEWRyQ75dhRJTBhFIsoimkGCUwoBrIjbu30vhwjAoEBB+gwgu3gOCqz5xFkCy7UFK2sl2Qtiku78wD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776861; c=relaxed/simple;
	bh=AmVqrJ76OwdjEXGBbxG4GnI2QXNXsrWG0X01vnKfxPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWzWNw1gxq+fjRNobE1p6tHkEBFGFx7etWJvbutuGxdubCzVx1RkgmeeJAfJ2eBcMIg2owI6ZEiYp+QOBzHeMYbDEQcgJuc9ZN46AAExxJvUdNKvxTE+kt4zd3GzJru6c+qO6K/LPtYnF6D84WqXLbVShVpDupXBWmAOHsU0s9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+QyNSCg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+QyNSCg"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so10207a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736776858; x=1737381658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmVqrJ76OwdjEXGBbxG4GnI2QXNXsrWG0X01vnKfxPk=;
        b=i+QyNSCgkb7nRNx6zab9Kr2RWTBQ/KPJRU0z8p4am/7y/jnp0q2tw04KptzEYL4Z89
         r/yEar28Vk2npI5+XpyRKSHFfL/yGZLBbQHzCAnvPANH8ezTUWzydFyYYHW56oE/5/2L
         6dwt11NugFqMC6xF6h6hcgk7J2y7E1VKTLt/QuFTWc1tlnD/VwiIwR58uU3vfn62aBti
         llBQ8vQlcKpNpD7I2ckImzQIvE+JfkwWxeN53xBXn7sj8brFQzozrGZSLKa0L1TDjYNP
         UnH4bF/OKWCxDlfKCIzzAzgJHZyQO7sUPLXCJrPKqoaUFZrkbYLJaGn7RsHTqU7X3ZBS
         SVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736776858; x=1737381658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmVqrJ76OwdjEXGBbxG4GnI2QXNXsrWG0X01vnKfxPk=;
        b=tOGNi7hj6OCf/1AnnRGxZ0omdZh0LN6aX9kvXPpAgVBvyykT3eaM86qwaiOH3e8n0y
         80uvgJzO7KtAyn0T2DqHttI5ZrNhLa9EYM67KtqxhOeN7+SciJcwEc5hz+we3ZPITAql
         d+ITYXNPx96homxnMg3jjR/xn+6VTHRPJrswYBndw6jZ5xNKxegjJjDGp3TE8ltUT+kh
         q2TdNnMl0CgckhOYnHBclcqqZtLO/ATFFTFzC7LroftNsDsfHaJ7KNKpg2SMm9eql5Qh
         56KgWUw8Qes4UTTLGZFH3s1e+ELihLXLJISNIo7ILYuT5Uwl3wCfiJ6BYsG6AAFZbrxw
         k+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBwdQif+mvM4rHSs8zUxxXBJK0bk6/xOnAWSsrVyCJZ//dUKQWIrSvxqem/vCGJIdSArEyWBhcrXIoLsKGDdjgogY3QaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn0s97LkpYmHhmKLYZORwDm8KU782dUSWm6PAMy82wu8ybUS4
	RYtRXvxNlSDqBfsoJhTSK1tFEfacfhpGgVO+uO3kg2bUeGxjUtl5MD8tHrkFmrCnIIZ2adKiEQs
	JpelFVnhbFt3YGiuESuTJEoBklX1/D4YMXR98
X-Gm-Gg: ASbGnctNYNrvgGRHFf4eb/PBmEjhH6Z4Ss+7vKJHcrtLb+ye2MqKZ/gM2xxbr7FV9xX
	TXe8mjNcQcl7Vrn2ejDTrFkVpR1VpNAiQhE6oEABkudggddPaWcQqOKBDPYHClHEHEQ==
X-Google-Smtp-Source: AGHT+IHKZ693r6Symww5fH4Feom3gw0SaQrsRBWb1GldoG/HaGHvayUaIeg55n9HFelhlGnGfmWOwP+TP6vIw15HFZ8=
X-Received: by 2002:aa7:c596:0:b0:5d9:5a5c:f2f9 with SMTP id
 4fb4d7f45d1cf-5d9a0ce240emr238092a12.7.1736776857045; Mon, 13 Jan 2025
 06:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108154338.1129069-1-mic@digikod.net> <20250108154338.1129069-28-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-28-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 13 Jan 2025 15:00:20 +0100
X-Gm-Features: AbW1kvYBx8dcH5RfbC3sOaT76fCVvwDa3bMTGBf2ix2X_eB1y7LoeUR0Nuu-9l8
Message-ID: <CAG48ez25VjcbUUkJiPru42LEX9AbUp0tfVrAcujo15ebozb0ew@mail.gmail.com>
Subject: Re: [PATCH v4 27/30] fs: Add iput() cleanup helper
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> Add a simple scope-based helper to put an inode reference, similar to
> the fput() helper.

Cleaning up inode references with scope-based cleanup seems dangerous
to me because, unlike most resources, holding a reference to an inode
beyond the lifetime of the associated superblock can actually cause
memory corruption; and scope-based cleanup is designed based on the
idea that the order and precise location of dropping a reference don't
matter so much.

So I would prefer to either not do this, or at least have some big
warning comment about usage requirements of scope-based inode
references.
