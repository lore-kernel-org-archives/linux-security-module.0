Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BC1DE8AB;
	Mon, 10 Mar 2025 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639255; cv=none; b=Rs0TnuIjqcpG1So0VfzPTqLCT3BLQH8JXXu7xxTMsBiR0r7qmJcEHRs7pkyPqoBxAWa48AG7zD8KkIoE1Sumxor1lY/5erSfKVt5+d7OfP4S1RqNhXG5mD97cY369dGzFGP16HKgR759DUJtVFxKWlnJBfnIw97H7YqHzx7oO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639255; c=relaxed/simple;
	bh=79Iy4PjlfM8x0qsncGpzq2YIDIllVdVOrTyqu2jRx7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxdqUCeS61syX1qw1xWw8EuCKb2X2PphhTSIf4WsDtdO0raPk0+ACr+wQSop5MUOuGR7qCKUztYjm78xN3bIsh8qrFeKCcMiiA4ovuWKS0kqAmIuhpxuR/zepSsBMaFm+wAZavItTVaaP+0kXrZN93iNDEbid3VWDOd5FpiucjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe62Xd7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe62Xd7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E9EC4CEF1;
	Mon, 10 Mar 2025 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639254;
	bh=79Iy4PjlfM8x0qsncGpzq2YIDIllVdVOrTyqu2jRx7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xe62Xd7vrF7V4Wl5SAQxJDeAZGz8DbCOSY5nDksQYWW8wZwVqSULAXGivzjLtmU1T
	 EbemwITk12pJfDq8jhhfF4A0cyhLYjusWif83Vb0dscUhveZYHrYezJTSJlWNw4qLY
	 IGPBuQ25updeJmypxIlmM6vnM5j/Afjb8KxF5a4sZ1QeJmRDAbPPJqFx/ubnNqHrqh
	 YzfSalAdyts208eq3VuOcd5x3cnkG+UvmHeevsh2w7uTvJUPO1gp7khmOc1fqP1L79
	 SnTA1TalSVuX5BA7TixyTw/QY3kh7Cd6G95Wf7E6aQj1hnZd1P9Xhdqboa5qa3LBOL
	 Grw2Zj5jtdKsg==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5dcc411189so4339745276.0;
        Mon, 10 Mar 2025 13:40:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsgQNogW/er8uxbu6q2CaYFl8+99Sh5+I3p44zCW2Nv5uDVZMccEz0YXGqqsbnetH8eYAM8Q==@vger.kernel.org, AJvYcCWUoXg5CUsGf4NOF97yU+sDH7sk09KrnujdYJ2lmbJFoB4j4NquoiMQWGOpS2HfeIMPaLhs5fpNYHNy4N1r@vger.kernel.org, AJvYcCWxwyT0gIiVNxyICjhi8OvDosYPYsn2avutMyw7hOb+pujmIPFNU+f2eYCPRqe0LOGYR/Ds49+Dwmqs01DsvPB8rlQeroFg@vger.kernel.org, AJvYcCXorHoThyJc/dHa9OjfZZCd+CL9dX+j+t+rsQ815B6R1F4Ot27x8f0/GYx5FUDqBzFGI2zrU5KC6giT@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4qHtOj2s3W3X5TZzL5Yj4RG9Y+Iwh2a5W9MPRhstuQOjvb1Q
	hfuBou93ARrOK/Nv+54uqRBkG87pp38t5UZl3+nYSJNlBATeYAZArBRfPjKC7Ho4m5nkqmZEvzv
	FTrwcjAYqcnKP6IhlLVqpoCCPTSc=
X-Google-Smtp-Source: AGHT+IGW3DJYCB1vqIA1aTnPKAEYaNV4ZR8s/OYmPYNC8BLKT8yN8zj7ypfY8XOqnpiLSHVUsg8tyQ7zTrG8R5Ovs+k=
X-Received: by 2002:a05:6902:2a8b:b0:e5d:c6e8:2e32 with SMTP id
 3f1490d57ef6-e635c179f67mr15276065276.24.1741639253935; Mon, 10 Mar 2025
 13:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1741385035-22090-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <1741385035-22090-2-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1741385035-22090-2-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 10 Mar 2025 13:40:43 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGcU10+rxKd2uH5Hy2impDih_=AkAgcdu35h+xTeM=+OA@mail.gmail.com>
X-Gm-Features: AQ5f1JqFWebr2Ri-dP7h4jCTkQyMh1VW_YSShcD9NrRfHs6Rl37FpE3tGPKz9Uc
Message-ID: <CAKtyLkGcU10+rxKd2uH5Hy2impDih_=AkAgcdu35h+xTeM=+OA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/1] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, eparis@redhat.com, 
	paul@paul-moore.com, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:07=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
...
> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 69 +++++++++++++++++++--------
>  security/ipe/audit.c                  | 21 ++++++--
>  security/ipe/fs.c                     | 19 ++++++--
>  security/ipe/policy.c                 | 11 ++++-
>  security/ipe/policy_fs.c              | 29 ++++++++---
>  5 files changed, 111 insertions(+), 38 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index f93a467db628..0615941de6e0 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -423,7 +423,7 @@ Field descriptions:
>
>  Event Example::
>
> -   type=3D1422 audit(1653425529.927:53): policy_name=3D"boot_verified" p=
olicy_version=3D0.0.0 policy_digest=3Dsha256:820EEA5B40CA42B51F68962354BA08=
3122A20BB846F26765076DD8EED7B8F4DB auid=3D4294967295 ses=3D4294967295 lsm=
=3Dipe res=3D1
> +   type=3D1422 audit(1653425529.927:53): policy_name=3D"boot_verified" p=
olicy_version=3D0.0.0 policy_digest=3Dsha256:820EEA5B40CA42B51F68962354BA08=
3122A20BB846F26765076DD8EED7B8F4DB auid=3D4294967295 ses=3D4294967295 lsm=
=3Dipe res=3D1 errno=3D0
>     type=3D1300 audit(1653425529.927:53): arch=3Dc000003e syscall=3D1 suc=
cess=3Dyes exit=3D2567 a0=3D3 a1=3D5596fcae1fb0 a2=3Da07 a3=3D2 items=3D0 p=
pid=3D184 pid=3D229 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsu=
id=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D4294967295 comm=3D"pyth=
on3" exe=3D"/usr/bin/python3.10" key=3D(null)
>     type=3D1327 audit(1653425529.927:53): PROCTITLE proctitle=3D707974686=
F6E3300746573742F6D61696E2E7079002D66002E2E
>
> @@ -433,24 +433,55 @@ This record will always be emitted in conjunction w=
ith a ``AUDITSYSCALL`` record
>
>  Field descriptions:
>
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| Field          | Value Type | Optional? | Description of Value        =
                      |
> -+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> -| policy_name    | string     | No        | The policy_name             =
                      |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| policy_version | string     | No        | The policy_version          =
                      |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| policy_digest  | string     | No        | The policy hash             =
                      |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| auid           | integer    | No        | The login user ID           =
                      |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| ses            | integer    | No        | The login session ID        =
                      |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| lsm            | string     | No        | The lsm name associated with=
 the event            |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -| res            | integer    | No        | The result of the audited op=
eration(success/fail) |
> -+----------------+------------+-----------+-----------------------------=
----------------------+
> -
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| Field          | Value Type | Optional? | Description of Value        =
                                |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> +| policy_name    | string     | Yes       | The policy_name             =
                                |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| policy_version | string     | Yes       | The policy_version          =
                                |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| policy_digest  | string     | Yes       | The policy hash             =
                                |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| auid           | integer    | No        | The login user ID           =
                                |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| ses            | integer    | No        | The login session ID        =
                                |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| lsm            | string     | No        | The lsm name associated with=
 the event                      |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| res            | integer    | No        | The result of the audited op=
eration(success/fail)           |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +| errno          | integer    | No        | Error code from policy loadi=
ng operations (see table below) |
> ++----------------+------------+-----------+-----------------------------=
--------------------------------+
> +
> +Policy error codes (errno):
> +
> +The following table lists the error codes that may appear in the errno f=
ield while loading or updating the policy:
> +
> ++----------------+------------------------------------------------------=
--+
> +| Error Code     | Description                                          =
  |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| 0              | No error                                             =
  |

Nit: How about using "Success" here to match with the function comments.

> ++----------------+------------------------------------------------------=
--+
> +| -EPERM         | Insufficient permission                              =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -EEXIST        | Same name policy already deployed                    =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -EBADMSG       | Policy is invalid                                    =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -ENOMEM        | Out of memory (OOM)                                  =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -ERANGE        | Policy version number overflow                       =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -EINVAL        | Policy version parsing error                         =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -ENOKEY        | Key used to sign the IPE policy not found in keyring =
  |
> ++----------------+------------------------------------------------------=
--+
> +| -EKEYREJECTED  | IPE signature verification failed                    =
  |

More accurately should be the IPE policy signature.

> ++----------------+------------------------------------------------------=
--+
> +| -ESTALE        | Attempting to update an IPE policy with older version=
  |
> ++----------------+------------------------------------------------------=
--+
> +| -ENOENT        | Policy was deleted while updating                    =
  |
> ++----------------+------------------------------------------------------=
--+
>
>  1404 AUDIT_MAC_STATUS
>  ^^^^^^^^^^^^^^^^^^^^^
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index f05f0caa4850..ac9d68b68b8b 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -21,6 +21,8 @@
>
>  #define AUDIT_POLICY_LOAD_FMT "policy_name=3D\"%s\" policy_version=3D%hu=
.%hu.%hu "\
>                               "policy_digest=3D" IPE_AUDIT_HASH_ALG ":"
> +#define AUDIT_POLICY_LOAD_FAIL_FMT "policy_name=3D? policy_version=3D? "=
\
> +                                  "policy_digest=3D?"
>  #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=3D\"%s\" "\
>                                     "old_active_pol_version=3D%hu.%hu.%hu=
 "\
>                                     "old_policy_digest=3D" IPE_AUDIT_HASH=
_ALG ":"
> @@ -248,22 +250,31 @@ void ipe_audit_policy_activation(const struct ipe_p=
olicy *const op,
>  }
>
>  /**
> - * ipe_audit_policy_load() - Audit a policy being loaded into the kernel=
.
> - * @p: Supplies a pointer to the policy to audit.
> + * ipe_audit_policy_load() - Audit a policy being loaded or failing
> + *        to load into the kernel.

The brief description needs to fit in a single line, if necessary you
can create a longer description. See
https://origin.kernel.org/doc/html/latest/doc-guide/kernel-doc.html.

> + * @p: Supplies a pointer to the policy to audit or an error pointer

> + *        to audit a failure with the associated error code from PTR_ERR=
(p).

The second line doesn't seem necessary.

>   */
>  void ipe_audit_policy_load(const struct ipe_policy *const p)
>  {
>         struct audit_buffer *ab;
> +       int err =3D 0;
>
>         ab =3D audit_log_start(audit_context(), GFP_KERNEL,
>                              AUDIT_IPE_POLICY_LOAD);
>         if (!ab)
>                 return;
>
> -       audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
> -       audit_log_format(ab, " auid=3D%u ses=3D%u lsm=3Dipe res=3D1",
> +       if (!IS_ERR(p)) {
> +               audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
> +       } else {
> +               audit_log_format(ab, AUDIT_POLICY_LOAD_FAIL_FMT);
> +               err =3D PTR_ERR(p);
> +       }
> +
> +       audit_log_format(ab, " auid=3D%u ses=3D%u lsm=3Dipe res=3D%d errn=
o=3D%d",
>                          from_kuid(&init_user_ns, audit_get_loginuid(curr=
ent)),
> -                        audit_get_sessionid(current));
> +                        audit_get_sessionid(current), !err, err);
>
>         audit_log_end(ab);
>  }
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 5b6d19fb844a..db18636470bf 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -133,6 +133,8 @@ static ssize_t getenforce(struct file *f, char __user=
 *data,
>   * * %-ERANGE                  - Policy version number overflow
>   * * %-EINVAL                  - Policy version parsing error
>   * * %-EEXIST                  - Same name policy already deployed
> + * * %-ENOKEY                  - Key used to sign the IPE policy not fou=
nd in the keyring

This line seems to exceed the 80 char line limit, did it pass checkpatch.pl=
?
See https://www.kernel.org/doc/html/latest/process/coding-style.html.
It can be more concise like "Policy signing key not found"

> + * * %-EKEYREJECTED            - IPE signature verification failed

The above comment also applies to here.

>   */
>  static ssize_t new_policy(struct file *f, const char __user *data,
>                           size_t len, loff_t *offset)
> @@ -141,12 +143,17 @@ static ssize_t new_policy(struct file *f, const cha=
r __user *data,
>         char *copy =3D NULL;
>         int rc =3D 0;
>
> -       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
> -               return -EPERM;
> +       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
> +               rc =3D -EPERM;
> +               goto out;
> +       }
>
>         copy =3D memdup_user_nul(data, len);
> -       if (IS_ERR(copy))
> -               return PTR_ERR(copy);
> +       if (IS_ERR(copy)) {
> +               rc =3D PTR_ERR(copy);
> +               copy =3D NULL;
> +               goto out;
> +       }
>
>         p =3D ipe_new_policy(NULL, 0, copy, len);
>         if (IS_ERR(p)) {
> @@ -161,8 +168,10 @@ static ssize_t new_policy(struct file *f, const char=
 __user *data,
>         ipe_audit_policy_load(p);
>
>  out:
> -       if (rc < 0)
> +       if (rc < 0) {
>                 ipe_free_policy(p);
> +               ipe_audit_policy_load(ERR_PTR(rc));
> +       }
>         kfree(copy);
>         return (rc < 0) ? rc : len;

Nit: we can change the style of returning like the one in update_policy().

>  }
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index b628f696e32b..68a2078d5b6a 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -84,8 +84,12 @@ static int set_pkcs7_data(void *ctx, const void *data,=
 size_t len,
>   * ipe_new_policy.
>   *
>   * Context: Requires root->i_rwsem to be held.
> - * Return: %0 on success. If an error occurs, the function will return
> - * the -errno.
> + * Return:
> + * * %0                                        - Success
> + * * %-ENOENT                                  - Policy was deleted whil=
e updating
> + * * %-EINVAL                                  - Policy name was changed=
 while updating
This one means "Policy name mismatch".
> + * * %-ESTALE                                  - Attempting to update an=
 IPE policy
> + * *                                             with an older version

This one can also be more concise, how about "Policy version too old"

Also the indentation is too much, see
https://origin.kernel.org/doc/html/latest/doc-guide/kernel-doc.html.

>   */
>  int ipe_update_policy(struct inode *root, const char *text, size_t textl=
en,
>                       const char *pkcs7, size_t pkcs7len)
> @@ -150,6 +154,9 @@ int ipe_update_policy(struct inode *root, const char =
*text, size_t textlen,
>   * * %-ENOMEM                                  - Out of memory (OOM)
>   * * %-ERANGE                                  - Policy version number o=
verflow
>   * * %-EINVAL                                  - Policy version parsing =
error
> + * * %-ENOKEY                                  - Key used to sign the IP=
E policy
> + *                                               not found in the keyrin=
g
> + * * %-EKEYREJECTED                            - IPE signature verificat=
ion failed
>   */

The above doc style/accuracy issue also applies here.

>  struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
>                                   const char *pkcs7, size_t pkcs7len)
> diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
> index 3bcd8cbd09df..b70d2518b182 100644
> --- a/security/ipe/policy_fs.c
> +++ b/security/ipe/policy_fs.c
> @@ -12,6 +12,7 @@
>  #include "policy.h"
>  #include "eval.h"
>  #include "fs.h"
> +#include "audit.h"
>
>  #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
>
> @@ -282,8 +283,14 @@ static ssize_t getactive(struct file *f, char __user=
 *data,
>   * On success this updates the policy represented by $name,
>   * in-place.
>   *
> - * Return: Length of buffer written on success. If an error occurs,
> - * the function will return the -errno.
> + * Return:
> + * * Length of buffer written                  - Success
> + * * %-EPERM                                   - Insufficient permission
> + * * %-ENOMEM                                  - Out of memory (OOM)
> + * * %-ENOENT                                  - Policy was deleted whil=
e updating
> + * * %-EINVAL                                  - Policy name was changed=
 while updating
> + * * %-ESTALE                                  - Attempting to update an=
 IPE policy
> + * *                                             with an older version
>   */

The above doc style/accuracy issue also applies here.

-Fan
