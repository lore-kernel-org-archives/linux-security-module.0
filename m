Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5D276D23;
	Thu, 27 Feb 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699699; cv=none; b=boH3IrsMC6OjrVQlTUxAv+xM2TyQ/Gk8nY3k7KMaHBi1WvCh4j+gQqxtFUaRXUYk/EG12Rtpc6hL04TFgNQP0BHAgc5EhbHuNkpe4k+Eb70/fWWmbtsZ5AguGbO0H+wrmT2LseOCsr4/SGw533y2k5Q8CpPvz3Lu85MAeIzEy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699699; c=relaxed/simple;
	bh=1tU3+ozNm3RX5VFE1YDJZ+W2QGdJ4V27XWteIDBhW7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYmCcx3u52uqq1ioMzjnfbVy+zUwnTSsxoBXJhIKXgnZLJrqzRLEe7R41MDrw1olXIVjDlOeBimSPxiG2vmBu+J649hGO1/qUoqdptoYRowqAoNRs85KFGcpj0Y+kU5aMVI+7ESJxzXotxCadE6G/joJl7e8+w03iNaB6N7CjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TArWM/v3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TArWM/v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DDBC4CEE4;
	Thu, 27 Feb 2025 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740699699;
	bh=1tU3+ozNm3RX5VFE1YDJZ+W2QGdJ4V27XWteIDBhW7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TArWM/v3Pf/blJdR0NTf+xz1pAKb/H4mbhsPRg30GAfLq3Vnj/s3O0KQ/BBm+OK8a
	 Kx9u0/J4hlD6MoZwu7c595U4kswy8eayuNoWGhQXIc4pRM9lIJOzYa+8c7mZ1MWjAt
	 JIq7gRZ1B3bi39cvQ40QZuXRKQmsyxDc+o4J7+jwUj5KAZRse4PGC3aJESH5LQHQ31
	 nBwbTBTRQ9Sl/LGti7dkGv9hXAHpTbYz0u6Q91Hq+8ps1RzFdbWimx3k8eihVHakD5
	 YVbhn4I9aGthGKmPf4MhQaCfIIq4iBhyJjGYZoSNoRDIUE51VcEY9UWconF02RtNOn
	 XlWr6yEI6KeTw==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f88509dad2so15220997b3.3;
        Thu, 27 Feb 2025 15:41:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi/IRK64LskCGKNRbvgI4VnpuY/s74etwHFbeQKGahfxDJS/5c5hnlwzHkSzj89Gs2Y3DOQnhvxubdkBEK@vger.kernel.org, AJvYcCVkkvnBGYEuITSsz8Dr/Fd1X/vY8CyN2gnwsFcUsbYtzYPbxNjrd7sh6zCtGrUHWwaXSYWRTw==@vger.kernel.org, AJvYcCW9UFWvuf4Csde2ZKE/UREjwMW657b0GJKMDuGPbuVKFGsXDzp6TJAT+ugRffHFzaP+j8Ig7xClvNoQvejG+pD9TjbNlKep@vger.kernel.org, AJvYcCWTUZYekdNJtHdUd8Zxz8XFAQN/aFOyp4t2IUOTp/NqHYYHKG5dykKNZQQAlgV4izUgbWPkvkKLAi24@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX9ngZCibW7DsB86MBXB8ZWDgv/+CbJQbY4EuROjlDGos45Ti
	VUxGcsysaYBAeS/l2rAfYrix1g5Lq5jmhwH/NQAhbwBayYAaXokiT7f+ToZfnp5FsQn3OZkkk/C
	Ym6h4PFcwpgHCy+a+ZVPvEauGFzg=
X-Google-Smtp-Source: AGHT+IGtxSEgYIBq4gfvypTDq1mQ6f9IWC8rh1ZC5QmPUpe8DTHZIh0DiGqiSCJdarqXBnLu1IxgJ6NYxSfIJNtsqpU=
X-Received: by 2002:a05:690c:9989:b0:6ef:5013:bfd9 with SMTP id
 00721157ae682-6fd4a04b3demr18394197b3.10.1740699698422; Thu, 27 Feb 2025
 15:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKtyLkFg2+8ciy4DM=g+vcTVvuRPNL2SHbN+m9ObErxtYXZYPw@mail.gmail.com>
 <1740696377-3986-1-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1740696377-3986-1-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 27 Feb 2025 15:41:26 -0800
X-Gmail-Original-Message-ID: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jpyw71LHr7qE8c6RnzWmXjrG76Ce4qwZD2HcZmcYYWARRgof66mCoQDUHQ
Message-ID: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
Subject: Re: [PATCH v2] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: wufan@kernel.org, audit@vger.kernel.org, corbet@lwn.net, eparis@redhat.com, 
	jmorris@namei.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:46=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
> Thanks for reviewing it. Here's the example generated from real logs:
>
> AUDIT_IPE_POLICY_LOAD(1422):
> audit:  AUDIT1422 policy_name=3D"Test_Policy" policy_version=3D0.0.1
> policy_digest =3Dsha256:84EFBA8FA71E62AE0A537FAB962F8A2BD1053964C4
> 299DCA92BFFF4DB82E86D3 auid=3D1000 ses=3D3 lsm=3Dipe res=3D1 errno=3D0
>
> The above record shows a new policy has been successfully loaded into
> the kernel with the policy name, version, and hash with the errno=3D0.
>
> AUDIT_IPE_POLICY_LOAD(1422) with error:
>
> audit: AUDIT1422 policy_name=3D? policy_version=3D? policy_digest=3D?
> auid=3D1000 ses=3D3 lsm=3Dipe res=3D0 errno=3D-74
>
> The above record shows a policy load failure due to an invalid policy.
>
> I have updated the failure cases in new_policy() and update_policy(),
> which covers each case as well.
>
> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>

Please merge the old and new changes into one single patch. Also the
commit message is supposed to be used to describe the code change.

> ---
>  Documentation/admin-guide/LSM/ipe.rst |  2 ++
>  security/ipe/audit.c                  | 10 ++++------
>  security/ipe/fs.c                     | 17 ++++++++++++-----
>  security/ipe/policy.c                 |  4 +---
>  security/ipe/policy_fs.c              | 24 +++++++++++++++++++-----
>  5 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index 2143165f48c9..5dbf54471fab 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -453,6 +453,8 @@ Field descriptions:
>  | errno          | integer    | No        | The result of the policy err=
or as follows:        |
>  |                |            |           |                             =
                      |
>  |                |            |           | +  0: no error              =
                      |
> +|                |            |           | +  -EPERM: Insufficient perm=
ission                |
> +|                |            |           | +  -EEXIST: Same name policy=
 already deployed     |
>  |                |            |           | +  -EBADMSG: policy is inval=
id                    |
>  |                |            |           | +  -ENOMEM: out of memory (O=
OM)                   |
>  |                |            |           | +  -ERANGE: policy version n=
umber overflow        |
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index f810f7004498..8df307bb2bab 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -21,7 +21,7 @@
>
>  #define AUDIT_POLICY_LOAD_FMT "policy_name=3D\"%s\" policy_version=3D%hu=
.%hu.%hu "\
>                               "policy_digest=3D" IPE_AUDIT_HASH_ALG ":"
> -#define AUDIT_POLICY_LOAD_NULL_FMT "policy_name=3D? policy_version=3D? "=
\
> +#define AUDIT_POLICY_LOAD_FAIL_FMT "policy_name=3D? policy_version=3D? "=
\
>                                    "policy_digest=3D?"
>  #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=3D\"%s\" "\
>                                     "old_active_pol_version=3D%hu.%hu.%hu=
 "\
> @@ -255,9 +255,8 @@ void ipe_audit_policy_activation(const struct ipe_pol=
icy *const op,
>   */
>  void ipe_audit_policy_load(const struct ipe_policy *const p)
>  {
> -       int res =3D 0;
> -       int err =3D 0;
>         struct audit_buffer *ab;
> +       int err =3D 0;
>
>         ab =3D audit_log_start(audit_context(), GFP_KERNEL,
>                              AUDIT_IPE_POLICY_LOAD);
> @@ -266,15 +265,14 @@ void ipe_audit_policy_load(const struct ipe_policy =
*const p)
>
>         if (!IS_ERR(p)) {
>                 audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
> -               res =3D 1;
>         } else {
> -               audit_log_format(ab, AUDIT_POLICY_LOAD_NULL_FMT);
> +               audit_log_format(ab, AUDIT_POLICY_LOAD_FAIL_FMT);
>                 err =3D PTR_ERR(p);
>         }
>
>         audit_log_format(ab, " auid=3D%u ses=3D%u lsm=3Dipe res=3D%d errn=
o=3D%d",
>                          from_kuid(&init_user_ns, audit_get_loginuid(curr=
ent)),
> -                        audit_get_sessionid(current), res, err);
> +                        audit_get_sessionid(current), !err, err);
>
>         audit_log_end(ab);
>  }
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 5b6d19fb844a..40805b13ee2c 100644
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
> @@ -161,8 +165,11 @@ static ssize_t new_policy(struct file *f, const char=
 __user *data,
>         ipe_audit_policy_load(p);
>
>  out:
> -       if (rc < 0)
> +       if (rc < 0) {
>                 ipe_free_policy(p);

> +               p =3D ERR_PTR(rc);
> +               ipe_audit_policy_load(p);

How about ipe_audit_policy_load(ERR_PTR(rc));

> +       }
>         kfree(copy);
>         return (rc < 0) ? rc : len;
>  }
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index 0f616e9fbe61..b628f696e32b 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -202,9 +202,7 @@ struct ipe_policy *ipe_new_policy(const char *text, s=
ize_t textlen,
>         return new;
>  err:
>         ipe_free_policy(new);
> -       new =3D ERR_PTR(rc);
> -       ipe_audit_policy_load(new);
> -       return new;
> +       return ERR_PTR(rc);
>  }
>
>  /**
> diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
> index 3bcd8cbd09df..74f4e7288331 100644
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
> @@ -288,25 +289,38 @@ static ssize_t getactive(struct file *f, char __use=
r *data,
>  static ssize_t update_policy(struct file *f, const char __user *data,
>                              size_t len, loff_t *offset)
>  {
> +       const struct ipe_policy *p =3D NULL;

This var can be avoided.

>         struct inode *root =3D NULL;
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
> +       if (rc < 0) {
> +               inode_unlock(root);
> +               goto out;
> +       }

This part seems unnecessary.

>         inode_unlock(root);
>
> +out:
>         kfree(copy);
> -       if (rc)
> +       if (rc) {
> +               p =3D ERR_PTR(rc);
> +               ipe_audit_policy_load(p);

p can be avoided, see the above comments.

Also please update function documentation if it has a significant change.

-Fan
