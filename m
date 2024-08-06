Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B394EB45
	for <linux-security-module@vger.kernel.org>; Tue,  6 Aug 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970616; cv=none; b=pe0BrNmLzKAKDs4VswA+Nqdl5Xkdw7oTWLP92svzJTrBjQ1i6eyR2mJjjHnxCoNyPQ9qerpO8DkinKuV9LHJxApPw1XCKsJ+EwjDYi8scZn+dCo6oXEajCOPkl7b4cRN6kYGjUbecauXUpRdZpf9gHs7TYZ5TU1BcXoGJWYJpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970616; c=relaxed/simple;
	bh=DciIyaltMFYLMxZvjIfQj8LL3dvXxfc6HZ7aYdssDhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHWYnYZKVYMxMUjD6hwq0iPZgU0AIA4lY9/2AhEQSfC+7G7+Vijj6VVt+MQSO06H/zxCQoYSnow46GlhpAEDpBhZ6T+HPmSFsjfGVQH15sYiOTJp6vHW0Jt8SQsKibiXUyMO3+tfawmWRbydFSt7uZQDxd1idYhuCTVlF9QjyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aV+zU4PX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aV+zU4PX"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso21654a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Aug 2024 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722970612; x=1723575412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hlr295kPt+eGh8NSlH0Dz/t5X1B6Heu59VkOJqUybg=;
        b=aV+zU4PXNTM3fn7rhD4ZMQx/n/x65XZ+uP2lKo2ir5PY188Wb/if0lQbJT8F61dur0
         1bCHxYpWmPB1Mx1bjzaF744Hc9kXkEAgZN+SZXnkOuN9N+wsyS2fWXeMASgw7cGMtGET
         UvbtdDLmBk2Hss6GGok9oFW91Sf68TktMQ5BmTTOYrMEu2KDR9wvDjeZndP1ed39RuS9
         0CXFKNP0aT06azyXqHt8LbliWdt0A7nb5Q4x8UeGIzLBfk7sU9eY9ZK21OatAl+4CNju
         gn38DN4JZmihZ1mWzPGONn4cj/uCJrobJD/KgSp/WFoKX1SNJ2Ku5/rDZWfMplR0uc11
         q6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970612; x=1723575412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hlr295kPt+eGh8NSlH0Dz/t5X1B6Heu59VkOJqUybg=;
        b=MRO1jRnBVt+Wmj+/UxVIloqjA2p2nzMqLgjiSCaoJCHOHvJpOUL2ZZa9KWRWdz4h6P
         la/Bub6qKOSjF06ce8rV0xTA+qSV2IdPwU4eMt9GZmPG7Oq801EpiFtg332Cu3+W2PRr
         sM2RQdlocAknjV41dYHrKtxUMPyxywjUlKuB6hxB49jiOxehS5L6dH3QVTa/WHv+Hn2C
         DcbKnd3+pRE2c6OENAQtWU0tekA8hjT/uD67qInJa5vk7Bg769hJ9V6b5NWrf65tMCb7
         seWZ0HqmIxHbAMd0uXswNLfkSVQCPRnL8hpDbUFSvzYX8TheVVzeFtUD986dYxSDuo6X
         ZhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+2W1V+SpgPsYUlUaOq9AnrxWt6WO9ttOR0P2WQ9TsrKg7sHfT4Y3qQL+C/a7igFhN90/2yxBRhM1pjVZEMczgrxwzTArCKeOVknMNPRaXMKxnCS/8
X-Gm-Message-State: AOJu0YxConqgZVgFOwNmTcU2uAhVqCY6dPr2cnuCaFPtFbwhD3SHimLq
	wU8kDsb+LK/o6W6vUL/ewoIBCis/gCJJeVupmo+I4uTSYF4UvsvInNaaPLL/DQ6mNkNJR0HMxbu
	uXB3l/bvynKo1S0eoDF86jyUa6M9XxjIEgTkL
X-Google-Smtp-Source: AGHT+IGqnjXhVQ8xTsbaWkcVIDDJvOxlZLSRQjKaeRvd7cNiXjReNou5GDw7DnmVT3rHal8ocqevhsdfWvubnFMhvKc=
X-Received: by 2002:a05:6402:84c:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bba28bb22amr26688a12.4.1722970611142; Tue, 06 Aug 2024
 11:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
In-Reply-To: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 20:56:15 +0200
Message-ID: <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> Currently, a sandbox process is not restricted to send a signal
> (e.g. SIGKILL) to a process outside of the sandbox environment.
> Ability to sending a signal for a sandboxed process should be
> scoped the same way abstract unix sockets are scoped. Therefore,
> we extend "scoped" field in a ruleset with
> "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> sending any signal from within a sandbox process to its
> parent(i.e. any parent sandbox or non-sandboxed procsses).
[...]
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 7e8579ebae83..a73cff27bb91 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -261,11 +261,54 @@ static int hook_unix_may_send(struct socket *const =
sock,
>         return -EPERM;
>  }
>
> +static int hook_task_kill(struct task_struct *const p,
> +                         struct kernel_siginfo *const info, const int si=
g,
> +                         const struct cred *const cred)
> +{
> +       bool is_scoped;
> +       const struct landlock_ruleset *target_dom;
> +
> +       /* rcu is already locked */
> +       target_dom =3D landlock_get_task_domain(p);
> +       if (cred)
> +               /* dealing with USB IO */
> +               is_scoped =3D domain_IPC_scope(landlock_cred(cred)->domai=
n,
> +                                            target_dom,
> +                                            LANDLOCK_SCOPED_SIGNAL);
> +       else
> +               is_scoped =3D domain_IPC_scope(landlock_get_current_domai=
n(),
> +                                            target_dom,
> +                                            LANDLOCK_SCOPED_SIGNAL);

This might be a bit more concise if you turn it into something like:

/* only USB IO supplies creds */
cred =3D cred ?: current_cred();
is_scoped =3D domain_IPC_scope(landlock_cred(cred)->domain,
    target_dom, LANDLOCK_SCOPED_SIGNAL);

but that's just a question of style, feel free to keep it as-is
depending on what you prefer.

> +       if (is_scoped)
> +               return 0;
> +
> +       return -EPERM;
> +}
> +
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +                                   struct fown_struct *fown, int signum)
> +{
> +       bool is_scoped;
> +       const struct landlock_ruleset *dom, *target_dom;
> +       struct task_struct *result =3D get_pid_task(fown->pid, fown->pid_=
type);

I'm not an expert on how the fowner stuff works, but I think this will
probably give you "result =3D NULL" if the file owner PID has already
exited, and then the following landlock_get_task_domain() would
probably crash? But I'm not entirely sure about how this works.

I think the intended way to use this hook would be to instead use the
"file_set_fowner" hook to record the owning domain (though the setup
for that is going to be kind of a pain...), see the Smack and SELinux
definitions of that hook. Or alternatively maybe it would be even
nicer to change the fown_struct to record a cred* instead of a uid and
euid and then use the domain from those credentials for this hook...
I'm not sure which of those would be easier.

> +       /* rcu is already locked! */
> +       dom =3D landlock_get_task_domain(result);
> +       target_dom =3D landlock_get_task_domain(tsk);
> +       is_scoped =3D domain_IPC_scope(dom, target_dom, LANDLOCK_SCOPED_S=
IGNAL);
> +       put_task_struct(result);
> +       if (is_scoped)
> +               return 0;
> +       return -EPERM;
> +}
