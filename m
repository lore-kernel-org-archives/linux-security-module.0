Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE451FAA;
	Mon, 17 Mar 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245161; cv=none; b=VVoo/RdFrc0Q52l4NKcjhTQx9GMCWtjJrMMdMvOq99LaxAV1vn2KtY4Bh9deoF7yWRccO12zMfd0ds40EoQitOt7a8O/dD8xsMFx9lHO4BrswaNs65IBEZcDE5KG2xZSolKRECJzHbuDyYUrPUD0Mhk8iqETcYdnMcnfQy0z3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245161; c=relaxed/simple;
	bh=vjYs1iVtvT6elCJYWvA6a39Fiy+4oldR0sImIebwG2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0apXJVJDMzp1rp2/m8DMl8cGfYcpNO1qPUavYzlDY7yVwCkbsdrlqXl8t2B5XtSaLcBAWyEMwJE+7eaDT6WX82j3+hpghDo+rKCKDIgSeumAOFOAIqQs/WX1otgOGv8sQMAbh3qopWCsd2hupQkNUQuFoGPaT07jGNfDmnw9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+6XPPrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+6XPPrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB031C4CEF2;
	Mon, 17 Mar 2025 20:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245160;
	bh=vjYs1iVtvT6elCJYWvA6a39Fiy+4oldR0sImIebwG2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p+6XPPrNuH6u+/zhkkK3a/t53bIXFuFzXp6p4RjfOjjrP8AIMDUWZjWcfJL4GZLXl
	 0/Q9HAqhNkWEiuV2u5CAtJC6V5ANJ+Hw8oAeSPzh/WoDTYxJkZZ8rX2GFxETz3E1Kw
	 Z2xdu6QRc3qaMoVA9AbFr4+HS6lqus2c8WxSUf/B96710S2bJ5L+LoUr2UFI5w8GpD
	 pBZPVACsZ9o59Ot732iVX/lYrzFinZj2eJWulgjm+zsdD1yeXHq+Vt/u+NuGMbHXLA
	 wyzdNuKA4ux607YNlhchLenPAKSwe3zvR6OxWEd0SxpmBQw/CuV7t1qHP15Hs8YvYw
	 E2pgP5r1PY+yg==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f666c94285so47219517b3.3;
        Mon, 17 Mar 2025 13:59:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2kZbAb7VLDb/QJLWYuo142Z+oL7oD2OruoPjUk54PEy3zUJp3VdpJVMFcXlFAX458QBjAEw==@vger.kernel.org, AJvYcCU5fbGCUcMTs+N04LBi0/rkM6msOXcoB7vBeEpSwSDM+od3mV6U5qJAqXnLBqucdGd7wnXCMjHGOYaCa4Gz@vger.kernel.org, AJvYcCV9yR4vv2IsOotP57gmdNWfU/bwZYTkJnc2Q7b/3ENWvu4L+ngh593JmVjs0rInLjZp+uaF+SNwqmGs@vger.kernel.org, AJvYcCXYdDLXOhdJws3tzeZiOKC9LgyFL6VWCT56RyLgp1tF+c6Qo5W6i+19B9Lo8ZmtfrKC9s0K6IrjRBUTD9JbxdKzJZMs92U+@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7yixqRgxdxG7YtYjnKsQgHyxthSAgSFDLtR+sptiKFvCGNwR
	nOTP4sd2wsb+wCgixa6s3l5gPsA/1Sg9cvkDVaIR8AYMEqtisdWSq1vYVohPwp0S0+mceY2c32A
	YD6nfYwXrQlbhVqNxfOtikG8jAyg=
X-Google-Smtp-Source: AGHT+IG2KGySkbENIEIwfPWn9Y0xEwyw2vu7R1Cg5oOaKr3QUdu4o2IoxOYJkMdYnLlTBrmK/eWhPMya6kUW2cA8aBI=
X-Received: by 2002:a05:6902:118f:b0:e64:192e:725d with SMTP id
 3f1490d57ef6-e64af124d1emr2325540276.15.1742245160049; Mon, 17 Mar 2025
 13:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1741902661-31767-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <1741902661-31767-2-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1741902661-31767-2-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 17 Mar 2025 13:59:08 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGuRraMbArSQCGxb+m5p+M8G5WZCTHk-7dKVfQd2EJYxw@mail.gmail.com>
X-Gm-Features: AQ5f1JrHOtrVJ6GMM8x4vxzrK5EKOKJCc20cPLm5ogUONaxzbIbLo2wsHktkfwc
Message-ID: <CAKtyLkGuRraMbArSQCGxb+m5p+M8G5WZCTHk-7dKVfQd2EJYxw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, eparis@redhat.com, 
	paul@paul-moore.com, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:51=E2=80=AFPM Jasjiv Singh
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
> * -ENOKEY: Key used to sign the IPE policy not found in the keyring
> * -ESTALE: Attempting to update an IPE policy with an older version
> * -EKEYREJECTED: IPE signature verification failed
> * -ENOENT: Policy was deleted while updating
> * -EEXIST: Same name policy already deployed
> * -ERANGE: Policy version number overflow
> * -EINVAL: Policy version parsing error
> * -EPERM: Insufficient permission
> * -ENOMEM: Out of memory (OOM)
> * -EBADMSG: Policy is invalid
>
> Here are some examples of the updated audit record types:
>
> AUDIT_IPE_POLICY_LOAD(1422):
> audit:  AUDIT1422 policy_name=3D"Test_Policy" policy_version=3D0.0.1
> policy_digest=3Dsha256:84EFBA8FA71E62AE0A537FAB962F8A2BD1053964C4299DCA
> 92BFFF4DB82E86D3 auid=3D1000 ses=3D3 lsm=3Dipe res=3D1 errno=3D0
>
> The above record shows a new policy has been successfully loaded into
> the kernel with the policy name, version, and hash with the errno=3D0.
>
> AUDIT_IPE_POLICY_LOAD(1422) with error:
>
> audit: AUDIT1422 policy_name=3D? policy_version=3D? policy_digest=3D?
> auid=3D1000 ses=3D3 lsm=3Dipe res=3D0 errno=3D-74
>
> The above record shows a policy load failure due to an invalid policy
> (-EBADMSG).
>
> By adding this error field, we ensure that all policy load attempts,
> whether successful or failed, are logged, providing a comprehensive
> audit trail for IPE policy management.
>
> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 69 +++++++++++++++++++--------
>  security/ipe/audit.c                  | 19 ++++++--
>  security/ipe/fs.c                     | 25 ++++++----
>  security/ipe/policy.c                 | 17 ++++---
>  security/ipe/policy_fs.c              | 28 ++++++++---
>  5 files changed, 113 insertions(+), 45 deletions(-)
>

...

> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index b628f696e32b..1c58c29886e8 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -84,8 +84,11 @@ static int set_pkcs7_data(void *ctx, const void *data,=
 size_t len,
>   * ipe_new_policy.
>   *
>   * Context: Requires root->i_rwsem to be held.
> - * Return: %0 on success. If an error occurs, the function will return
> - * the -errno.
> + * Return:
> + * * %0        - Success
> + * * %-ENOENT  - Policy was deleted while updating
> + * * %-EINVAL  - Policy name mismatch
> + * * %-ESTALE  - Policy version too old
>   */
>  int ipe_update_policy(struct inode *root, const char *text, size_t textl=
en,
>                       const char *pkcs7, size_t pkcs7len)
> @@ -146,10 +149,12 @@ int ipe_update_policy(struct inode *root, const cha=
r *text, size_t textlen,
>   *
>   * Return:
>   * * a pointer to the ipe_policy structure     - Success
> - * * %-EBADMSG                                 - Policy is invalid
> - * * %-ENOMEM                                  - Out of memory (OOM)
> - * * %-ERANGE                                  - Policy version number o=
verflow
> - * * %-EINVAL                                  - Policy version parsing =
error
> + * * %-EBADMSG                         - Policy is invalid
> + * * %-ENOMEM                          - Out of memory (OOM)
> + * * %-ERANGE                          - Policy version number overflow
> + * * %-EINVAL                          - Policy version parsing error
> + * * %-ENOKEY                          - Policy signing key not found
> + * * %-EKEYREJECTED                    - Policy signature verification f=
ailed
>   */

The indentation here is not aligned.

I don't see any other issue, if there is no objection from the audit
folks, I will pull this into ipe's tree.

-Fan

.
