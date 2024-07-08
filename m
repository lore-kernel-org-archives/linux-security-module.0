Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9F146595
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456886; cv=none; b=VOn9aJn5ubLgHuf+uBLHwAY8qhX4V5WhiA7gQwPYu47+OZTG975C9it91GJO49prOoH8fhhkCKlNZnM2CHnenT2ZBTeIVY0e0wQVpKs8JJyZyxaJi3XkpHo8lxCwydP1Cn/iBhfOGxhM+hdqvVO3CQTC/tb52zovLRzXjGSPdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456886; c=relaxed/simple;
	bh=kgSwKFu/TnS6fJXWAO8HYbXIDAtOL7ia5DsT4ZaMrJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFgWfe9a+1qo93VmKudROZEmeawsf5xe6EMtLfnV+7B6iE/svJE8oYWfZln8PFaqT60shCSiXpLiTylvJXPK3KeUWcERDCeJehGCzNyCrSdHrnX0tceGmcU9jh6dxr3RkcFHuRVTbSUKyKaYuxQJxGjJfXJgLKwcnIGkCWe6dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Ls7ifb6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Ls7ifb6"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so41608a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jul 2024 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720456883; x=1721061683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5h9K8a8sSLubZd/W2Bpa7ei/SlFMORW/ZDCStOq+wM=;
        b=2Ls7ifb6v0UXptyiNOS8Qk3j0Fsn4WCN0HGGsBuOipNbtsbqctXuxei9NsUSdia8BV
         3HlsQy0z9fQWERbbgerwhh0sFBoYgB0xj80YiKL2DDZwgI5zFO7c0b62STuvA7i7fdPn
         j+SgYrQdcrxxMn4zf92QrCT8+OIYkAEmebWy65/lU/tfRXXqOELKhqCWprBFRm1aNFSt
         PeF/+Vn+BXT+PkU1nh4lfr6LI6KIjptHqyR3L3gALE/f1kTiWO7HB1wiT5F/m3TiaVmf
         jwBqSxUAuNETAr+L39b4ogXSjcBPtL2C4zsG2dWbRleOpPLBavQwv4iIuBnwzqXs2dso
         G7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456883; x=1721061683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5h9K8a8sSLubZd/W2Bpa7ei/SlFMORW/ZDCStOq+wM=;
        b=o0MsEa+S57qeS1QjnJoSJmc9H1jAnE6XW+guydUKdtkhw822f3tf73jiJvcRcc7gVn
         8PPxQlbakeJalnBI5uK1/5Lhlkx7M89+FdzjgNdAAqXt9Q+4xKv7onluvOwQG0j/8sax
         /njoxlMpMJwNCEitYp4HBeAZSAMYWyvWC2ohe2K87Xjyns1UMdXsEXhXkrZeOu5zVSQR
         xB9pxfr4YOBxY8sTaQTGjuYFuCZNTK6E2nPwlf+z8jllJQ5eUqvKiNvHT6W8AHL68yBl
         IMeOXbZNduG4CHTDQafc1itktq7VvjhLZ+qMy9tob42E5VjNcfivTpfIePrs2ahGDAlE
         Picw==
X-Forwarded-Encrypted: i=1; AJvYcCWClZITmRqX+9zcNEVcYq2LeF1GbdC39xXRmTJG4kNg75dPGZ3oNwXYCSi8kgjBlluH+ncgJyKsbYMx9eItVht1wkaH1GCmGIRMB+chNLfnGDDKlDkx
X-Gm-Message-State: AOJu0YzpGklobfm7nfhkgvxGopMyqiNbKK/dE5WzxvDB1zbpBD1Hmfxz
	YvQJTmm6Ifu1Ow7tfNmul4NEKxhZVwvMlHHlioFH88dSwsWLxM6cypanoP3nkYSWFmpRJ3iBWUN
	4LGKtAbG0lGe8Q97JG3IZfbVHje/n7dsmNnJT
X-Google-Smtp-Source: AGHT+IGnZrn5/gF0KK99nMLQYDqQtH14UdCGc9dpKYr4CJb2IgbOmv7c7MrCZL5Np69D3hoUFnM393mMoyI6bE88g5c=
X-Received: by 2002:a50:bae9:0:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-59352e1a5b2mr174396a12.2.1720456883109; Mon, 08 Jul 2024
 09:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com> <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87ed83etpk.fsf@oldenburg.str.redhat.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 09:40:45 -0700
Message-ID: <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: Florian Weimer <fweimer@redhat.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Alejandro Colomar <alx.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:26=E2=80=AFAM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * Jeff Xu:
>
> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> > libraries too ?  or just the main executable itself.
>
> I expect that dynamic linkers will have to do this for everything they
> map.
Then all the objects (.so, .sh, etc.) will go through  the check from
execveat's main  to security_bprm_creds_for_exec(), some of them might
be specific for the main executable ?
e.g. ChromeOS uses security_bprm_creds_for_exec to block executable
memfd [1], applying this means automatically extending the block to
the .so object.

I'm not sure if other LSMs need to be updated ?  e.g.  will  SELINUX
check for .so with its process transaction policy ?

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/3834992

-Jeff


> Usually, that does not include the maim program, but this can
> happen with explicit loader invocations (=E2=80=9Cld.so /bin/true=E2=80=
=9D).
>
> Thanks,
> Florian
>
