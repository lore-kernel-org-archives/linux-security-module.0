Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC961A841F;
	Wed, 19 Feb 2025 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001795; cv=none; b=pAvSBS3eSYb09EUmmGS9J0ijus46KEPb/G+r29/3kpxSF4P8kLnGL/osuW/0KG3r6sr58aqhf/LZGrLwt5OLPcyoe1/cF53IPaYToIKg95VYZnpDLFxkp1q9+Ydd+/Jmbzdiy7goir5LYc8Sc1QTdWPyE6drVQbEf24CiFcGYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001795; c=relaxed/simple;
	bh=3PKt05ljZv8g2rQYsANwxhIafJZUF6GjM/CyQA+RHXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cafIZsh8mDjxNlMZ2w3N8WxZRuB9kZ5GghczsXTUlManodvoxYxOI5RhRkDYGS8ZLT3f93B1FEo76MLcjuvSKl717HYPI8fW1jSkkRS1fCuHep/JCpP3HQaS6f9N6ZvJTKPkATTjp5fNaGFijIqEeqBu3pH4H3CpGnAx8vfV8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7rDDLg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7rDDLg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0D0C4CEDD;
	Wed, 19 Feb 2025 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740001794;
	bh=3PKt05ljZv8g2rQYsANwxhIafJZUF6GjM/CyQA+RHXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P7rDDLg0/NCf2tquoieOcye6rWhvmASWCW0v3bn+EgkM3XCej1xKVqdLx82TNligb
	 w+5FiwZkCDxlm1mZ3IDHOEHvt2kffc+yj9RL94rZqsAR1NoAgov/uApR7w1gh+IQy3
	 LyglBhRh9J3O7Zdygu0kmlpb0TW6uzfiaWe0DW3CK4fOIGcrd4YqIy/0oLqKerIu/T
	 ZKS/wJSz+sEW1IvHcFDfCaDGEGHIfDUkiKh9OviBg1oBMd8utIa6opI0WTkmj1WhPk
	 fEYsbuFb8vwZxM6tUf2vptC8L6uzaFCmAzPMkwSbHB+AYgNEbiCmqRfW4kqIJybKOk
	 Cfo3mjGUjt9YQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fb8de54da9so1563937b3.3;
        Wed, 19 Feb 2025 13:49:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHwKh2RMjwPxh6Ttv+sFSG7PcC8cjpwhrHK33Yg81SnpwiaVB/uz7wUyVMrl6ZKYmbELLCJJvWjJwG9wf9@vger.kernel.org, AJvYcCWSfsT4+D6PyRdwpuqZa0v05PDFLfCGIVPS5yeUzPxSc1nYffnLcxUSwMUMIAtYi7sK8Zc9gz9um4s=@vger.kernel.org, AJvYcCXo1NJ91+HPfAFtkQv9/yuOxOi4ONMtEXAP21eSZKTKcZxUOsZ4vyISQB9AYwIVip4M7GeoRAMjc85aTyYmyikf44ZyYhW+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5y/JRi2wflmK6pE1husxms+ceyz73c/oo3u/sKzvkckq+mo+
	00cb7VNNZjfiaOw/ydRcmujPOPeFIwz/3j5nU7yi8yOHtlJ79thjxT0EG0a7/zpIWEq6nkUrDqg
	Tx9byMrqEh1Xer7WGgkyEBuPqsFY=
X-Google-Smtp-Source: AGHT+IFfW/kTsMF3/b5hGSimcnQ5syQeEWvWlsiwfRMqHDODCQa+tqQ8gb1rxKxnSSJM9fZXa3IafkaERJrxgJAwG9A=
X-Received: by 2002:a05:690c:6405:b0:6ef:4a57:fc98 with SMTP id
 00721157ae682-6fb582a192fmr191129947b3.16.1740001794053; Wed, 19 Feb 2025
 13:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1739569319-22015-1-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1739569319-22015-1-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 19 Feb 2025 13:49:43 -0800
X-Gmail-Original-Message-ID: <CAKtyLkFg2+8ciy4DM=g+vcTVvuRPNL2SHbN+m9ObErxtYXZYPw@mail.gmail.com>
X-Gm-Features: AWEUYZl1mRQGqsBn25Luyk_5Z6YcizuwBL9mpTiqYU4QidVils0KwxhFvIM9t4E
Message-ID: <CAKtyLkFg2+8ciy4DM=g+vcTVvuRPNL2SHbN+m9ObErxtYXZYPw@mail.gmail.com>
Subject: Re: [RFC PATCH] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, eparis@redhat.com, 
	paul@paul-moore.com, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-audit@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:42=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
...
>
> AUDIT_IPE_POLICY_LOAD(1422):
>
> audit: AUDIT1422 policy_name=3D"boot_verified" policy_version=3D0.0.0
>   policy_digest=3Dsha256:820EEA5B40CA42B51F68962354BA083122A20BB846F2676
>   auid=3D4294967295 ses=3D4294967295 lsm=3Dipe res=3D1 errno=3D0
> The above record shows a new policy has been successfully loaded into
> the kernel with the policy name, version, and hash with the errno=3D0.
>
> AUDIT_IPE_POLICY_LOAD(1422) with error:
>
> audit: AUDIT1422 policy_name=3D"boot_verified" policy_version=3D0.0.0
>   policy_digest=3Dsha256:820EEA5B40CA42B51F68962354BA083122A20BB846F2676
>   auid=3D4294967295 ses=3D4294967295 lsm=3Dipe res=3D0 errno=3D-74

This doesn't seem to be right in the error case, I suggest copying a
real record from a running system.

>
> The above record shows a policy load failure due to an invalid policy.
>
> By adding this error field, we ensure that all policy load attempts,
> whether successful or failed, are logged, providing a comprehensive
> audit trail for IPE policy management.
>
> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++-----
>  security/ipe/audit.c                  | 17 ++++++++++++++---
>  security/ipe/policy.c                 |  4 +++-
>  3 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index f93a467db628..2143165f48c9 100644
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
> @@ -450,7 +450,14 @@ Field descriptions:
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
>  1404 AUDIT_MAC_STATUS
>  ^^^^^^^^^^^^^^^^^^^^^
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index f05f0caa4850..f810f7004498 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -21,6 +21,8 @@
>
>  #define AUDIT_POLICY_LOAD_FMT "policy_name=3D\"%s\" policy_version=3D%hu=
.%hu.%hu "\
>                               "policy_digest=3D" IPE_AUDIT_HASH_ALG ":"
> +#define AUDIT_POLICY_LOAD_NULL_FMT "policy_name=3D? policy_version=3D? "=
\
> +                                  "policy_digest=3D?"

How about AUDIT_POLICY_LOAD_FAIL_FMT instead.

>  #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=3D\"%s\" "\
>                                     "old_active_pol_version=3D%hu.%hu.%hu=
 "\
>                                     "old_policy_digest=3D" IPE_AUDIT_HASH=
_ALG ":"
> @@ -253,6 +255,8 @@ void ipe_audit_policy_activation(const struct ipe_pol=
icy *const op,
>   */
>  void ipe_audit_policy_load(const struct ipe_policy *const p)
>  {
> +       int res =3D 0;
> +       int err =3D 0;

I would try to avoid using these two variables since this function is
fairly short. Also please use Reverse XMAS tree declarations in
future.

>         struct audit_buffer *ab;
>
>         ab =3D audit_log_start(audit_context(), GFP_KERNEL,
> @@ -260,10 +264,17 @@ void ipe_audit_policy_load(const struct ipe_policy =
*const p)
>         if (!ab)
>                 return;
>
> -       audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
> -       audit_log_format(ab, " auid=3D%u ses=3D%u lsm=3Dipe res=3D1",
> +       if (!IS_ERR(p)) {
> +               audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
> +               res =3D 1;
> +       } else {
> +               audit_log_format(ab, AUDIT_POLICY_LOAD_NULL_FMT);
> +               err =3D PTR_ERR(p);
> +       }
> +
> +       audit_log_format(ab, " auid=3D%u ses=3D%u lsm=3Dipe res=3D%d errn=
o=3D%d",
>                          from_kuid(&init_user_ns, audit_get_loginuid(curr=
ent)),
> -                        audit_get_sessionid(current));
> +                        audit_get_sessionid(current), res, err);
>
>         audit_log_end(ab);
>  }
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index b628f696e32b..0f616e9fbe61 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -202,7 +202,9 @@ struct ipe_policy *ipe_new_policy(const char *text, s=
ize_t textlen,
>         return new;
>  err:
>         ipe_free_policy(new);
> -       return ERR_PTR(rc);
> +       new =3D ERR_PTR(rc);
> +       ipe_audit_policy_load(new);
> +       return new;

Auditing failure here is not correct. ipe_new_policy() can succeed
while the following security fs nodes creation can fail. Similarly
insufficient permission error is not audited.
I suggest auditing the failure cases in new_policy() and update_policy().

-Fan

>  }
>
>  /**
> --
> 2.34.1
>
>
