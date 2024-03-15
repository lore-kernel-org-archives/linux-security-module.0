Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844C1EB2C
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534175; cv=none; b=DswaeINcyZqENBzFfzCLfM5qPED3ffNrMBA9v3pEpQBZY5px5FQ1gkrAFjHr9izRpRM5cOm81DnwDyjHAdxguHcuZioaJsM+0i+q+8LzjXd1Hd2yyLJK6LWznPbORlqDGllndx/dFVOlarWsS7KdzI0MkagDUCU9NC43sAheytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534175; c=relaxed/simple;
	bh=xZSS2f2gCT0y1k6tpzS9qV9cCYSPvpyvWSzVNaUjPrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjFUqtu9zJXfZphpLnhhPg5qDc/6kWYhKs8K/B7aW8mJbfOH/TekASfhjXCx7dBgTaSpEyD1DXoCdKeD2aWAjhSpHklONfEmlv/p9gw5yEh33sqBgWUeJQa0XlFFyQQC17yov53JlLaHSu+kYYEgFKyY4DPq8Ez601YKxgPKMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XB4ZyyJu; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XB4ZyyJu"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2391735276.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710534171; x=1711138971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBonRzz3p7T5k46qGOTqJyZ8xFk1UhNgPyID6ocUfTs=;
        b=XB4ZyyJuzM7rgGL5nryd/WaB2TWhPjhRsn4w7PCVt3H4AAt/9gwSMlpzS+ETTG4zmU
         tB1t/CpAvmJH2R7vGaI40QB+HawuYmGfzx6HnMIs2YcDh0EKwMAMZVRrHspuuezdeOr3
         5m5N4Fzx71mQtMebd4jhOJ0SgDzSmFgUUzlPPLEBNHFEI+waRxflmbDMCerS2DKWC3gG
         N3TmrUzhX7j0+Bx1bf+o9v1KWVghOTst1Nd8vaK6rkQJM5rGU9n4yJy6Q6Ff96coSVJm
         JLXR2uo0jPYN0YNyNGRklgfrHHczlZUkdG9Awt65u4h6124MR5a0ThZ3gviNyhybJ1MV
         9m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710534171; x=1711138971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBonRzz3p7T5k46qGOTqJyZ8xFk1UhNgPyID6ocUfTs=;
        b=NjeHtHt/TErU4YGPFJaOBW99zUoNnMOH0eO04iLIeC4UyPZw5rC3MWUYASxh2/v8ai
         kBCDeZ2YeVKyeaaxmUqYK1y8rnN1pnXxhcsaOLQZ04Ev8tA4mqON2kfkBEIelpwCXIU9
         hZ1Z4VCOqVNVYZUPSylVBxWoe4GjbFNrZwh5f6NV12hnrBZ6q4NdKHFKgxmRIDynj6XN
         ETQqpvbEbN5/mRxF6rexGaEksGOHFOmviBCVEDffekC25r8dQZn0CCDWD5OK4kM6rScr
         O80HjrKs6r4kzOqgN8KphM3Wr3aiOrydwiACIINPjLq8bnO8KfzVMcsw/uXeracLHbxz
         ZQMA==
X-Gm-Message-State: AOJu0Yxh8aZryu/Ts8rQvpMxE3rKKlm2mq9yw5HdQaCgeECz66dAUgho
	3CzJp0V/pS2dRPTqL24P8z6WAtdVZOwz4GuKpugrvcT9I9457TkUEq4GF2D0Q9ChLIa6dTtxQZy
	bb0N/q1uP+zRsBhiOqhP5zt3TiMvZqyEagHDG
X-Google-Smtp-Source: AGHT+IGSDFt1vIKYhod9g2539+aNN1VmiBEvQparnLMX4WXbzqChdKXl44697jo5nxySNaWvQPnKlRRV0GqAJ8FZpbw=
X-Received: by 2002:a25:b31b:0:b0:dcb:aa26:50fe with SMTP id
 l27-20020a25b31b000000b00dcbaa2650femr6505753ybj.15.1710534170699; Fri, 15
 Mar 2024 13:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315181032.645161-1-cgzones@googlemail.com> <20240315181032.645161-2-cgzones@googlemail.com>
In-Reply-To: <20240315181032.645161-2-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 16:22:39 -0400
Message-ID: <CAHC9VhRkawYWQN0UY2R68Qn4pRijpXgu97YOr6XPA7Ls0-zQcA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexei Starovoitov <ast@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Alfred Piccioni <alpic@google.com>, John Johansen <john.johansen@canonical.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 2:10=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a new hook guarding instantiations of programs with executable
> stack.  They are being warned about since commit 47a2ebb7f505 ("execve:
> warn if process starts with executable stack").  Lets give LSMs the
> ability to control their presence on a per application basis.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  fs/exec.c                     |  4 ++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 13 +++++++++++++
>  4 files changed, 24 insertions(+)

Looking at the commit referenced above, I'm guessing the existing
security_file_mprotect() hook doesn't catch this?

> diff --git a/fs/exec.c b/fs/exec.c
> index 8cdd5b2dd09c..e6f9e980c6b1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
>         BUG_ON(prev !=3D vma);
>
>         if (unlikely(vm_flags & VM_EXEC)) {
> +               ret =3D security_vm_execstack();
> +               if (ret)
> +                       goto out_unlock;
> +
>                 pr_warn_once("process '%pD4' started with executable stac=
k\n",
>                              bprm->file);
>         }

Instead of creating a new LSM hook, have you considered calling the
existing security_file_mprotect() hook?  The existing LSM controls
there may not be a great fit in this case, but I'd like to hear if
you've tried that, and if you have, what made you decide a new hook
was the better option?

--=20
paul-moore.com
