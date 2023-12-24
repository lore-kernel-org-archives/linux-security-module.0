Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1209DDB6
	for <linux-security-module@vger.kernel.org>; Sun, 24 Dec 2023 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SRl0W3cY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e75005bd0cso30951917b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 24 Dec 2023 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703447916; x=1704052716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmcVQPwGjjUY9XTbKfzg3lbGQPvGiD0vLAjWo8rnhBQ=;
        b=SRl0W3cYZDpisUjwm9Cdsa5lL22PatpdQ1lwN4L8rsdgijB8cm/dJRZMmfCaBe+N9P
         oJIkvul5DqxNyOHh9ak3C12NnVpe7xqUrtAWeWN1G4GVCcW8uraoy9vcSpfH8HcLycGO
         gLqltSTLnvE3R/U8J4VpmmOXa3x15YDr/Y9XQn4q2ykOv7K/tZjbkM0dqLe2MzPYquq2
         bBhrArobc+R0uTCOry+7ysLAccGJy0lwsjX4/TxqepAwvBGNbViV2a3kamrLsIcJR1B2
         IoiMRK3DY3reIO+GfvglV0armuw8uFdrfvOL4H4sM9kS5PQ7kvp9Q6FBjlQPubHhF/Aa
         vTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703447916; x=1704052716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmcVQPwGjjUY9XTbKfzg3lbGQPvGiD0vLAjWo8rnhBQ=;
        b=UVewYb9qC76ay07o/ddJddi7AcOXWZghlJTOMMu4Pgv427bXQoLI7G0emeCDQ0egd6
         x4pqZSd1p2o3LemhR71PkKImR/A60RdE44WkCxrI22v9WEAR2PD+2VtXjCUV5fJEpSkF
         /1Uu7UWV8ky3kUciWozaDKAE1xYZ/Wzt5vu6KdTxnLHCV2p9oAyQm2D24pPhIeDCd7Kl
         9G4xIX/MQENgIj34InJMQFh3ziQdP3v7H8HZW0eqrTIt/tl+IZ/F4O/ORwVmsqzKnKnG
         1c2bwoYlmoca7KzW9g05dlge9FQ9eEtMfcIabHxYikCEmbGzH2rDS4CbkkZLrNzhUbA9
         bkNQ==
X-Gm-Message-State: AOJu0Yzym/hpLWNKMNLaVxSBOnV3guXpPTZVqtmitFU0a+olkIABbKHM
	24MUwLkLwssZty5aY0qnO2ZKqAHvA/79VUw7hPHhyMXzOVOt
X-Google-Smtp-Source: AGHT+IGy44q+tnMyqe0jXQ+RNpAK+IeAmGOXK3azlBtSANBmgv2b8x5gogyq35v8wuusXib7Qm+Qw0By+70l3jFZxQ8=
X-Received: by 2002:a0d:df91:0:b0:5e5:7254:2c2d with SMTP id
 i139-20020a0ddf91000000b005e572542c2dmr3160011ywe.53.1703447916657; Sun, 24
 Dec 2023 11:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com> <57ce7089-37c7-44c5-a9da-5a6f02794c42@I-love.SAKURA.ne.jp>
In-Reply-To: <57ce7089-37c7-44c5-a9da-5a6f02794c42@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 14:58:25 -0500
Message-ID: <CAHC9VhQoEVvGXzH6HjnTsQVa1=ZJ0cOpk6pEgPeYdLKJpmsUbA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alfred Piccioni <alpic@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 5:49=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/12/23 10:23, Paul Moore wrote:
> >> -       /* RED-PEN how should LSM module know it's handling 32bit? */
> >> -       error =3D security_file_ioctl(f.file, cmd, arg);
> >> +       error =3D security_file_ioctl_compat(f.file, cmd, arg);
> >>         if (error)
> >>                 goto out;
> >
> > This is interesting ... if you look at the normal ioctl() syscall
> > definition in the kernel you see 'ioctl(unsigned int fd, unsigned int
> > cmd, unsigned long arg)' and if you look at the compat definition you
> > see 'ioctl(unsigned int fd, unsigned int cmd, compat_ulong_t arg)'.  I
> > was expecting the second parameter, @cmd, to be a long type in the
> > normal definition, but it is an int type in both cases.  It looks like
> > it has been that way long enough that it is correct, but I'm a little
> > lost ...
>
> Since @arg might be a pointer to some struct, @arg needs to use a long ty=
pe.
> But @cmd can remain 32bits for both 32bits/64bits kernels because @cmd is=
 not
> a pointer, can't it?

I'm not worried about @arg, I'm worried about @cmd, the second
parameter to the syscall.  I was looking at the manpage and it is
specified as an unsigned long, which would be a size mismatch on a
64-bit system, although now that I'm reading further into the manpage
I see that the command is specified as a 32-bit value so an int
shouldn't be a problem.  I'm guessing the unsigned long type persists
from the days before 64-bit systems.

> > I agree that it looks like Smack and TOMOYO should be fine, but I
> > would like to hear from Casey and Tetsuo to confirm.
>
> Fine for TOMOYO part, for TOMOYO treats @cmd as an integer.

Great, thank you.

--=20
paul-moore.com
