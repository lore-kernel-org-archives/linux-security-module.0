Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98017E552
	for <linux-security-module@vger.kernel.org>; Tue, 15 Apr 2025 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682090; cv=none; b=Ixe1gpHguHmygDgXT9px/0noNCTsNZnh2r5yI5sAh5gYj3of6V+8Psj+wDQrEXW8TX/H1g15HawAFfcZ029CQBY2UQacype+7MH0Oj8d7jTp4iVgWhRWL/UKMRXz+kJRQaQpfXBt8Vpr/fV2BfFIam0BsAquEFIjfRXY3N1fLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682090; c=relaxed/simple;
	bh=RIuEpCAWwJBwcXSxpMUxjacCf2Nd7SQD0nUn/o2H6WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCTJdy2WsS/WYraZm5wsk6nm0BPGhKichSh94yhJSB70b0XXTN54xvtYAJqHgxMvtxfBa18PKIDjkzC8/X6qYQZBDeqZjMg/HsQVkL04HoQ08ueP1+zuAfS6niFVL7WQnY5WUTMsVJ5Va2QVA4g+4KmqdbTlAs8jIeLQiRveHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FlcWpH2c; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FlcWpH2c"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e461015fbd4so4152426276.2
        for <linux-security-module@vger.kernel.org>; Mon, 14 Apr 2025 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744682087; x=1745286887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kf2HB+2t0DsSXOO3Gr3LgcuugUFp/PyDyoGAYGDC1c=;
        b=FlcWpH2ckuRZRNrpGaMccwMpvcn6AoggUaeR+7f0b/Ks2jLEqYH3E1E4kOFPi/rli9
         oAHxvyE/NaSK5zFxicoA01dMQhrmWoFyOD2Spb61QHs1ktuV4kHaAj/E+36L+PZBPddJ
         BsU5M0jz2WN7yr0kalvuGCo66eAbHLuwXrI5pkcnNwqYrjzyw0QUVbt02ojITRqJO6Hp
         ieNmLr2WFCwsXT7ktSk+YrZYsn3pzvYKKRb4QtWblQ1i5VgVQMZEDK2h31lAMYOYENyH
         OVt6TVeNRdDxeWX8yK+eegWzSnCxTKvVsYBZbSfKOYFjf9NYdLj4gxWikLNylTzDFiw0
         zKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744682087; x=1745286887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kf2HB+2t0DsSXOO3Gr3LgcuugUFp/PyDyoGAYGDC1c=;
        b=DHXG3/+wXNg6GTSUzsMz27/SYe/tOFGObJDj4h6wIEnS+vX9IjwF2jC2dmjo9khaBw
         JZ6H9UfKMoyWJ2R4A/JfCsrFAYAZXXRQn+6AC23ixey3PR6sPfMoMR3h7nAIflmanCXX
         Xvlrqh23gM4uRDNOai+VWMlbzMuwbZ8sMgMnqo/UqorjpcfFxXcudxiEP2XjxXwFoLr6
         PtPxZ4PjVfBCblBTjV54c2yvs/nF6mm3fl6DMOzda2iGat7VczQeTaMBxM+L2RhiAUZl
         dWj2VZ2duKZr357yn3aT0Sy6Lpp7kyEa8BUfs4spPWhEt+5m8mSSz0/b7J+iQugzu6y+
         kWUw==
X-Gm-Message-State: AOJu0Yy5qfz36lQrpFyxl12DG9C+cVkqADLhmsH2NXBWKM7Nw/ZqMZmO
	Ui0o/nMfq/Ig4+MFmUx5knc9QCC2q7eA5SPKbCBDAovlRytLqfGKABYJ3N9RFtJA26f8BT1WEvc
	FWy0BTAvhLyglIbsf737Y6W9JpfINkYNAb3ZV
X-Gm-Gg: ASbGnctqUNRqZSiAS6VU4yf5J99KDit/zD0ZXUNJQ4lOqYKSeyGZ7PCda8ebzHYW84i
	meqm2PhG4n8SO28DOwLzbgLjpe/hPk4qxrPxTDCs2M1cCqgpN5JiyZR1uCQTKhuaNvOVgTrlGIU
	1V3YYfKumYDkHMTQv5g9GMlg==
X-Google-Smtp-Source: AGHT+IHAvWs/9H4IE5oVAZXQLadFHf3OPEuDA39J2HxSOfQADnUIBLhlOASR5Q5rlyPVk613nwuKqqugeaFfh5OppIo=
X-Received: by 2002:a05:6902:d43:b0:e6d:e3d0:38 with SMTP id
 3f1490d57ef6-e704dfbe613mr22814287276.39.1744682087599; Mon, 14 Apr 2025
 18:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
 <CAKtyLkGWtiRRcxvA9vJSuwnS+bmikKpwHYOWkSYiFOToPFAt0g@mail.gmail.com>
In-Reply-To: <CAKtyLkGWtiRRcxvA9vJSuwnS+bmikKpwHYOWkSYiFOToPFAt0g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 21:54:35 -0400
X-Gm-Features: ATxdqUF1-XzruXrFAtcGGxs4uxnPPaDZjoullBc6BTEXhHCar2kkKxiuquSCz30
Message-ID: <CAHC9VhQtN93Z7pfQL-63ZLbm61g-UUc+RrdmzUtRiqeJyp5Sig@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
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

On Mon, Apr 14, 2025 at 5:04=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
> On Wed, Apr 9, 2025 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > As the LSM framework only supports one LSM initcall callback for each
> > initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> > wrapped with a new function, smack_initcall() that is registered with
> > the LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/smack/smack.h           |  6 ++++++
> >  security/smack/smack_lsm.c       | 16 ++++++++++++++++
> >  security/smack/smack_netfilter.c |  4 +---
> >  security/smack/smackfs.c         |  4 +---
> >  4 files changed, 24 insertions(+), 6 deletions(-)

...

> I'm getting the following WARNING:
>
> WARNING: modpost: vmlinux: section mismatch in reference:
> smack_initcall+0xb (section: .text) -> init_smk_fs (section:
> .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference:
> smack_initcall+0x16 (section: .text) -> smack_nf_ip_init (section:
> .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference:
> smack_initcall+0x27 (section: .text) -> smack_nf_ip_init (section:
> .init.text)
>
> I guess "__init" is missed for smack_initcall?

Yep, fixed, thanks.

--=20
paul-moore.com
