Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AA28A3EF
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577989; cv=none; b=DfqS9noQUWD5fFazWUwVWAgh5PZon1VDpUMaKYuO6UzrocMClvvFe+0nU1TeXfqCusyjZKpK2jwOx1fpfJv9yEs64fb6xn8czL7EKFCj7kj9URg5B9V69WgiKhuwfOdSHJsBcwqW7jzgwf49U/gcKazbfUo9v8v59DwNhrGWT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577989; c=relaxed/simple;
	bh=NrxcGV9SRKTH90U9r9TiQBRjMm9wgcBgK/JoZCvLbI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz+YJT9RSrCOCQ4IVkQQ6L2xGBlrUJlVxbNlyj11GbeR+DPZWy0Bn2eyFmvWxbm5eswArjRnkkWrki4ZHBhDPMg9ZopB2pzFqV8G4rxbraJLzpZgaA2EAgIh5LfsMtshloxdqFi0pk1X2n/6TfLPawKKiivBnSU2MX2M2AeqSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MpKMTw3m; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MpKMTw3m"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so3864014a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758577986; x=1759182786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBCpPhJ55NBZXeBegJaYDf1Vz3ukosPuvPoKyErH30U=;
        b=MpKMTw3mB8cS+wLKmM8B/FN/L+1iE0pQQmRWOZVXGS4mSCm0K1pU1gDJEVuXtxVxXo
         uuMqijoX2yPKTU1SBmZueh5b+sdLN7pZhuv3kLaRjZKGkXSOAC9C6ESuyUwF7clq173b
         yJ5+EDg9rdkHiJpIiH2w8y83fZllQkrhUxph1nzJ6HHpN1IXyUdfWT5KaRdNq89s93H/
         s4E3t3++vYp9s4hsJ7Gfua+d6FrHIhfJh5A1HbKlOc0yW2LG5bobwoUgQN7S0HOCniAv
         j8qU/IC82212UsrQDCFGVWpN80TV1jKgkAsCMjorxmHvBUCWKKFn8l6dizk8iES8rIOW
         zlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577986; x=1759182786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBCpPhJ55NBZXeBegJaYDf1Vz3ukosPuvPoKyErH30U=;
        b=W8M22ixMHWvqot+S8/S90cCGy87h2Bp3pnkIHHXrmSphzQ65H1o2QFXi8RD30miLQD
         tZawR8fthlP3X1H+1y0nO+WeVmiAId0hgDQRdnKhQq4VdG0MXVD9i7JgBpBs7vVmJemS
         rATGP/odLQKIr+offq+9fHiXhcmiODYSsjRQSmq4ZJAW3ZeH7jfYnHL3MHcZw9trsEcN
         VzWHfZbqY1yDlglNr6XFAzOaW++EEBj6WSotSw9Zi1dwkmrHeNZI0TedkrKj0IRAazMD
         TSj9RKDScQLkyvG67aDD3uP3E7DnS77r2p60A2cZDQFUP1MammVYkFTf0EsFNwOogzOf
         h/FQ==
X-Gm-Message-State: AOJu0YwqaY5Or1gEsSYGjdRtwVuz4Z1VYuNQcTx1IzgoG3rVHf5TXXSV
	j3qR2Rbkatfyllkt2bKDQra8el1b57KLK+iHsCIJKa6qtV3Y1/mCx2r2qanVUHgdIaj9Kyc5Rj0
	f+QcL7AQ56vKWVimmwCrvgFnCxnlUXDI/VqxhzJMN
X-Gm-Gg: ASbGncujTIbO7HNTUqEscmpruIY9PiQD1EzS1MRBXO061IXdwBFnod3/SzmpPqrk6Fx
	0kLJva8d9TXyShM3Xai4s5anNI+yQh94ArEDt4JugaojOCZ/XGoUfsE1i+lSwVuU5+na2Wn4l/Q
	0GpOc+tB3Wc0z3q561Ud2OHSwtwf24PFHsSS/QAWuYIkKkSIqags22k66NKKmL7Yikma6IJtHjh
	rZIFOM=
X-Google-Smtp-Source: AGHT+IEIQWA5rKW43P5Fcmt7zmtt/MYBDfabS+vBWJKdvNBhoSvEK2C+yUTl6EB3o0bQhS1oiKlOiaKg1oXWzn0OcwI=
X-Received: by 2002:a17:90b:540f:b0:327:734a:ae7a with SMTP id
 98e67ed59e1d1-332a92da6ebmr455889a91.11.1758577986004; Mon, 22 Sep 2025
 14:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-47-paul@paul-moore.com>
 <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
 <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com> <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
In-Reply-To: <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 17:52:54 -0400
X-Gm-Features: AS18NWCouzv17lHS4hgSMPjWiUR_MwHmSY1fDXCtAlsYtCf1VWHhUgu34JpGZtw
Message-ID: <CAHC9VhR94kuqcwP6DcdG+QpcruU8dMnP55CmTXiQ-k+u5yOT1Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:53=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Sun, 2025-09-21 at 15:23 -0400, Paul Moore wrote:
> > On Fri, Sep 19, 2025 at 3:16=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > >
> > > On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > > > The LSM currently has a lot of code to maintain a list of the curre=
ntly
> > > > active LSMs in a human readable string, with the only user being th=
e
> > > > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > > > generate the string on first use and then cache it for subsequent u=
se.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > FYI, checkpatch.pl complains of unbalanced braces, otherwise
> >
> > Looks good to me?
> >
> > % stg export --stdout lsm-lsm_names_cleanup | ./scripts/checkpatch.pl -
> > total: 0 errors, 0 warnings, 139 lines checked
> >
> > Your patch has no obvious style problems and is ready for submission.
>
> Try adding "--strict", which enforces
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-b=
races-and-spaces

Ah, yes, sure.  FWIW, I view checkpatch's findings mostly as
"advisory"; oftentimes it can help catch important things, other times
I think it's kinda silly (and no, I don't have a list of each, so
please don't ask).  I often tell people new to kernel development that
it is generally better to follow checkpatch's suggestions if you are
uncertain, however don't be surprised if a maintainer prefers
something slightly different.

For those reasons I don't ever bother with the "strict" checkpatch mode.

--=20
paul-moore.com
