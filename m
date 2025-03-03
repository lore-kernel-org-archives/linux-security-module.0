Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C322ACD2;
	Mon,  3 Mar 2025 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039909; cv=none; b=ma7ZWWBFTYsSYinMcjcNxTNgOJsEdfGAT93yA8aO9+k8YNNp5ulhqFLWjfpkz3d3mjcsO6bvjdTwEO4jx9UqyBNpEX1BX9nPtJ7S0Vt0m0FaZkqBNpy9FUeNYppi6xvDzdpsMmBGp39/cbHzPCdZKGE647NXDPF7GcsTVed7ZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039909; c=relaxed/simple;
	bh=gOqBGsbuoBoviwlQbN5mRhIstf0TSd/jjYEsRUjx79s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/Ce/Vi7A0BYi0Rx9gtrVmFlc4oQ+g9UkZBg+WBXjCfTMw8FyGEjDFZewx64vIOBCjIu3RWaopQlW/qEwvdvRdKdiyhLGiUt84ctKv+RRTdpJBObTH7F3yRr6DaAJ1xuczu9GFUKtup5RxhGq/25Bl4zJz4eZSJJCJuGMzUL+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGl3NGI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGl3NGI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE81C4CEE9;
	Mon,  3 Mar 2025 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741039908;
	bh=gOqBGsbuoBoviwlQbN5mRhIstf0TSd/jjYEsRUjx79s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OGl3NGI/rA4V/SHBHU3+SjdzOFUEW4O7O6AOxGnbKJt3t8DtbDWatR2PhYlqadUQZ
	 r5HXrxuvJpqQwpHSwAuePk/bxKRcGJLOl8lctFQpHFSz5O5JLwDB0xdWxByQE9W+6g
	 Kvzpg+h+pjsgFCJQBinVRfscqULojXY5MB8q7rbxvQ+phM7SId+PqA2RJ0t0TpL6j2
	 51o87gNYLAZZuLUt28gYckTxzSYe0Z28cWE4mLflSMAOCvweL00dId62Pbo6Jfpkiw
	 CvHeGsRGgrIU3KplTjyxHo9nG7cB7AMejlPpozObxgs+m2f8h+CVCuhyhUna/DlndU
	 E6IAGmxKj8crA==
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e4419a47887so3733404276.0;
        Mon, 03 Mar 2025 14:11:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBMltDBIOR2gADjlDLXfN60r6W00wdOqxLQ7AKWcypilozlXsfJk4IVxrNhCY6ItgHHif+NdRdIJLmfy4s@vger.kernel.org, AJvYcCVELOrCCR5OA2dnlcS6LVwGsyMqTluDhNOq7azlSr/7k09DTiEgt2XBr70Uf0kFJ0CVaX4tcO7qQp3LJ2n3dnoKSeI+cDvB@vger.kernel.org, AJvYcCWVfQmTuDmODDu3DiqfTL7wcSp6GNkeXNhs526nJnSzLbJJOkcBB/NZrk/KaX+b9I7/fRu+aw==@vger.kernel.org, AJvYcCWwluvbQqmlokE3EAtc66uhx3D6gpSls+cIe0vj3OltC92sX+F9jKGl48dHKhgJJgcWlOnhTy4Bk/VI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mPp5tlUWk/sVN8W4bp+pVNT98sI4qaUr/ym1tRDWTJcIxFYY
	9hFaWySnmgJpSg3IqAvZg/a+0DmFpOr4aQrnHHTJGoKJBQbl4U2mvef1uVrTcZpBT59xlJn4Tkt
	EmWhdhhCbq68abqEQ90EeRTlQQrM=
X-Google-Smtp-Source: AGHT+IGE0pfvG8tW3dNvL0eDiGD3L2/GVowq3C94UqhDyDMworT0XksWKMeiLQs15jGcPVBpkRXMbxVXDf2Nv6E8qt4=
X-Received: by 2002:a05:6902:1b03:b0:e5d:ac3c:9e07 with SMTP id
 3f1490d57ef6-e60b2e8dddfmr16167840276.4.1741039907516; Mon, 03 Mar 2025
 14:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
 <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 3 Mar 2025 14:11:36 -0800
X-Gmail-Original-Message-ID: <CAKtyLkGV4cGJzbvVUAeLBp=evc_QAWPD8FsskHNVvx-1UZJB-A@mail.gmail.com>
X-Gm-Features: AQ5f1JrVaFR0iTvSqkTQt_tlcJV-Y1giK2s0oAmOJYrkSj92cb2mYmN1nn9jj6A
Message-ID: <CAKtyLkGV4cGJzbvVUAeLBp=evc_QAWPD8FsskHNVvx-1UZJB-A@mail.gmail.com>
Subject: Re: [PATCH v3] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: wufan@kernel.org, audit@vger.kernel.org, corbet@lwn.net, eparis@redhat.com, 
	jmorris@namei.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:11=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
> Users of IPE require a way to identify when and why an operation fails,
> allowing them to both respond to violations of policy and be notified
> of potentially malicious actions on their systems with respect to IPE.
>
> This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD even=
t
> to log policy loading failures. Currently, IPE only logs successful polic=
y
> loads, but not failures. Tracking failures is crucial to detect malicious
> attempts and ensure a complete audit trail for security events.
>
> The new error field will capture the following error codes:
>
> * 0: no error
> * -EPERM: Insufficient permission
> * -EEXIST: Same name policy already deployed
> * -EBADMSG: policy is invalid
> * -ENOMEM: out of memory (OOM)
> * -ERANGE: policy version number overflow
> * -EINVAL: policy version parsing error
>

These error codes are not exhaustive. We recently introduced the
secondary keyring and platform keyring to sign policy so the policy
loading could return -ENOKEY or -EKEYREJECT. And also the update
policy can return -ESTALE when the policy version is old.
This is my fault that I forgot we should also update the documentation
of the newly introduced error codes. Could you please go through the
whole loading code and find all possible error codes?  Also this is a
good chance to update the current stale function documents.

...

>
> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 19 ++++++++++++++-----
>  security/ipe/audit.c                  | 15 ++++++++++++---
>  security/ipe/fs.c                     | 16 +++++++++++-----
>  security/ipe/policy_fs.c              | 18 +++++++++++++-----
>  4 files changed, 50 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index f93a467db628..5dbf54471fab 100644
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
> @@ -436,11 +436,11 @@ Field descriptions:
>  +----------------+------------+-----------+-----------------------------=
----------------------+
>  | Field          | Value Type | Optional? | Description of Value        =
                      |
>  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> -| policy_name    | string     | No        | The policy_name             =
                      |
> +| policy_name    | string     | Yes       | The policy_name             =
                      |
>  +----------------+------------+-----------+-----------------------------=
----------------------+
> -| policy_version | string     | No        | The policy_version          =
                      |
> +| policy_version | string     | Yes       | The policy_version          =
                      |
>  +----------------+------------+-----------+-----------------------------=
----------------------+
> -| policy_digest  | string     | No        | The policy hash             =
                      |
> +| policy_digest  | string     | Yes       | The policy hash             =
                      |
>  +----------------+------------+-----------+-----------------------------=
----------------------+
>  | auid           | integer    | No        | The login user ID           =
                      |
>  +----------------+------------+-----------+-----------------------------=
----------------------+
> @@ -450,7 +450,16 @@ Field descriptions:
>  +----------------+------------+-----------+-----------------------------=
----------------------+
>  | res            | integer    | No        | The result of the audited op=
eration(success/fail) |
>  +----------------+------------+-----------+-----------------------------=
----------------------+
> -
> +| errno          | integer    | No        | The result of the policy err=
or as follows:        |
> +|                |            |           |                             =
                      |
> +|                |            |           | +  0: no error              =
                      |
> +|                |            |           | +  -EPERM: Insufficient perm=
ission                |
> +|                |            |           | +  -EEXIST: Same name policy=
 already deployed     |
> +|                |            |           | +  -EBADMSG: policy is inval=
id                    |
> +|                |            |           | +  -ENOMEM: out of memory (O=
OM)                   |
> +|                |            |           | +  -ERANGE: policy version n=
umber overflow        |
> +|                |            |           | +  -EINVAL: policy version p=
arsing error          |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
>

Might be better to create another table to list all potential erronos.
Also please keep the capitalization of sentences consistent.

>  1404 AUDIT_MAC_STATUS
>  ^^^^^^^^^^^^^^^^^^^^^
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index f05f0caa4850..8df307bb2bab 100644
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
> @@ -254,16 +256,23 @@ void ipe_audit_policy_activation(const struct ipe_p=
olicy *const op,
>  void ipe_audit_policy_load(const struct ipe_policy *const p)
>  {

The documentation of this function should also be updated since it is
also auditing errors now.

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
> index 5b6d19fb844a..da51264a1d0f 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -141,12 +141,16 @@ static ssize_t new_policy(struct file *f, const cha=
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
> +               goto out;
> +       }
>
>         p =3D ipe_new_policy(NULL, 0, copy, len);
>         if (IS_ERR(p)) {
> @@ -161,8 +165,10 @@ static ssize_t new_policy(struct file *f, const char=
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
>  }

In case of memdup fail, the kfree(copy) will be called with the error
pointer. Also how about refactor the code like

        ipe_audit_policy_load(p);
        kfree(copy);

        return len;
err:
        ipe_audit_policy_load(ERR_PTR(rc));
        ipe_free_policy(p);

        return rc;

> diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
> index 3bcd8cbd09df..5f4a8e92bdcf 100644
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
> @@ -292,21 +293,28 @@ static ssize_t update_policy(struct file *f, const =
char __user *data,
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
>         copy =3D memdup_user(data, len);
> -       if (IS_ERR(copy))
> -               return PTR_ERR(copy);
> +       if (IS_ERR(copy)) {
> +               rc =3D PTR_ERR(copy);
> +               goto out;
> +       }
>
>         root =3D d_inode(f->f_path.dentry->d_parent);
>         inode_lock(root);
>         rc =3D ipe_update_policy(root, NULL, 0, copy, len);
>         inode_unlock(root);
>
> +out:
>         kfree(copy);
> -       if (rc)
> +       if (rc) {
> +               ipe_audit_policy_load(ERR_PTR(rc));
>                 return rc;
> +       }
>

The above comments also apply to here.

-Fan

>         return len;
>  }
> --
> 2.34.1
>
