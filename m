Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A15367;
	Thu,  6 Mar 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219692; cv=none; b=bTKoyJRf/DH4hv9R1T5OAiyr1wAS9hBvsqQmae+Xtb25fML7ZvesAcGp6SJFtzfvMMHXQJjPd4RA1ReuFaO5Qx/2bRCxMFk04capSS+moNsioqpEUB0tuqR+/pz6iVxjLWD0n5PZ6dsjTGf5O31UIFL2Y0FBTEHkr4genGiUyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219692; c=relaxed/simple;
	bh=jHcXou5Sz5uJwsNjZkmahX4Asibi4r5E88O5sxADoU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxRbnTJYfn0FaF6RfOuH1Hj8YVLe4qTGncam/rjcYGkxkb/9g0vVWJdgxqot+3N0pMMvHVhUcFyB3ksuPa7Q6BU7+2macu5J23Eyh0lqBQT97y1i1MR3xiUhGByt44sNSAaTnSvaSvtykmPhsGXQq7GYyZe9ZXLuC9cNv+Q8zr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyfEurbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyfEurbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7A4C4AF0B;
	Thu,  6 Mar 2025 00:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219691;
	bh=jHcXou5Sz5uJwsNjZkmahX4Asibi4r5E88O5sxADoU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZyfEurbDBERJ1HmoY8WUhD8+MZY/+liGkRjovmvk58CYEslnOHPAP6c23oZqE50tZ
	 e4dVUjkBl/jNwbK7bGzz9n2Ep29JCF1tiYH6+9afOQPUpPhKgpqsFthPEXU++3GYU4
	 jw6KWIYWnyGDPbZfISwN4HDDcCPptC/JxvzX+z93WafZ03dgrg5ezZoZwxWmwxYvBJ
	 ov2aTluoUyok7UKx9DKo7HL9ZEp3nXIKEL7e+GHC8fzsUJn7aOIV5tVcAy2LZlI1mA
	 aNqxJlakRIUd9zHf9TvVkRHwARpoPyqbl1cxYW/ZcTT6Z+kTCYJrRYtXWfS9nlQ+u7
	 TIpUQv20hqGCg==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549be93d5eso58150276.1;
        Wed, 05 Mar 2025 16:08:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVToZIbWEOt8zIC/FjINrAlBad8z84/NtOChuY7h2KjcP+hrY01vogFr14tzcH6O5ZiUkt/BYPLG3gFwIiTutobnBUN3KLQ@vger.kernel.org, AJvYcCVyexsotb6Ji/5E0ul1/DnnSmxyXGXO1qbvIwkrKAgmqFs/MuWkgdYsPe3z9BADfMusHr0Jeg==@vger.kernel.org, AJvYcCW9I7B6jUH9NiZmc+FhatLeEr0y7jjKKxqASIERaOowGiRGzPMgxqNQrf+nLLfHKiyGAclXxC2W69e2wWEe@vger.kernel.org, AJvYcCX70oU9ZD5VnN8dU42nWmqT3+MDjTDfpwtgakvO4KIYf45VXgBfbAkAvVMd/spJxseI1wtPOtirUdDf@vger.kernel.org
X-Gm-Message-State: AOJu0YypWtXt17xzfZc9ROkRB3vB6x1pighU5y+dvfXSeQKQm7p2m5JB
	1mU4WHTpaVq1OnP6vi32ckAAnWcIzrQqtmFqNoll7DcWKKJ9qJytwR4hBvdV/wbhoAodTP0+6/s
	IBmKWyt4lmcirYCn4s1YkcqT7L0k=
X-Google-Smtp-Source: AGHT+IEZ1qra7BnNhKazDRTEd03UN0781gYS4zWBq9ewiUm4ecWq7+lXmsWypFaXLgMPy0sn8BkXc/vftI/yDz9OwwI=
X-Received: by 2002:a05:6902:2882:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e611e1b0720mr6437379276.18.1741219691059; Wed, 05 Mar 2025
 16:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
 <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <CAKtyLkGV4cGJzbvVUAeLBp=evc_QAWPD8FsskHNVvx-1UZJB-A@mail.gmail.com>
 <0a5e586a-9b55-4905-8663-6ef0112aa32d@linux.microsoft.com>
 <CAKtyLkEveJbJ9HAufC1_x8J287qqDFYZOhK2Y0MEaPo+dkJm2Q@mail.gmail.com> <5a9793e1-e31c-4dfd-ab36-48f00f66ac7e@linux.microsoft.com>
In-Reply-To: <5a9793e1-e31c-4dfd-ab36-48f00f66ac7e@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 5 Mar 2025 16:08:00 -0800
X-Gmail-Original-Message-ID: <CAKtyLkGUrf1txbKo2QWLn7vJ2jc=Zu3NYQPWiBh9h5fU8FT_nA@mail.gmail.com>
X-Gm-Features: AQ5f1Joxnmy57aHmlR4MdOLkI8NPizMPMUFew2U7JlnlxM0aHx_tKskqY1nCqDc
Message-ID: <CAKtyLkGUrf1txbKo2QWLn7vJ2jc=Zu3NYQPWiBh9h5fU8FT_nA@mail.gmail.com>
Subject: Re: [PATCH v3] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: Fan Wu <wufan@kernel.org>, audit@vger.kernel.org, corbet@lwn.net, 
	eparis@redhat.com, jmorris@namei.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:27=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
>
>
> On 3/5/2025 1:23 PM, Fan Wu wrote:
> > On Tue, Mar 4, 2025 at 4:04=E2=80=AFPM Jasjiv Singh
> > <jasjivsingh@linux.microsoft.com> wrote:
> >>
> >>
> >>
> >> On 3/3/2025 2:11 PM, Fan Wu wrote:
> >>> On Fri, Feb 28, 2025 at 3:11=E2=80=AFPM Jasjiv Singh
> >>> <jasjivsingh@linux.microsoft.com> wrote:
> >>>>
> >>>> Users of IPE require a way to identify when and why an operation fai=
ls,
> >>>> allowing them to both respond to violations of policy and be notifie=
d
> >>>> of potentially malicious actions on their systems with respect to IP=
E.
> >>>>
> >>>> This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD=
 event
> >>>> to log policy loading failures. Currently, IPE only logs successful =
policy
> >>>> loads, but not failures. Tracking failures is crucial to detect mali=
cious
> >>>> attempts and ensure a complete audit trail for security events.
> >>>>
> >>>> The new error field will capture the following error codes:
> >>>>
> >>>> * 0: no error
> >>>> * -EPERM: Insufficient permission
> >>>> * -EEXIST: Same name policy already deployed
> >>>> * -EBADMSG: policy is invalid
> >>>> * -ENOMEM: out of memory (OOM)
> >>>> * -ERANGE: policy version number overflow
> >>>> * -EINVAL: policy version parsing error
> >>>>
> >>>
> >>> These error codes are not exhaustive. We recently introduced the
> >>> secondary keyring and platform keyring to sign policy so the policy
> >>> loading could return -ENOKEY or -EKEYREJECT. And also the update
> >>> policy can return -ESTALE when the policy version is old.
> >>> This is my fault that I forgot we should also update the documentatio=
n
> >>> of the newly introduced error codes. Could you please go through the
> >>> whole loading code and find all possible error codes?  Also this is a
> >>> good chance to update the current stale function documents.
> >>>
> >>> ...
> >>>
> >>
> >> So, I looked into error codes when the policy loads. In ipe_new_policy=
,
> >> the verify_pkcs7_signature can return a lot of errno codes (ex: ENOKEY=
,
> >> EKEYREJECTED, EBADMSG, etc.) while parsing the pkcs7 and other functio=
ns
> >> as well. Also, In ipe_new_policyfs_node used in new_policy(), I see th=
e same
> >> issue with securityfs_create_dir and securityfs_create_file as they
> >> return the errno directly from API to. So, what should we return?
> >
> > I think the key here is we need to document the errors in the ipe's
> > context. For example, ENOKEY means the key used to sign the ipe policy
> > is not found in the keyring, EKEYREJECTED means ipe signature
> > verification failed. If an error does not have specific meaning for
> > ipe then probably we don't need to document it.
> >
> >>
> >> For other functions: I have complied the errno list:
> >>
> >> * -ENOENT: Policy is not found while updating
> >
> > This one means policy was deleted while updating, this only happens
> > the update happened just after the policy deletion.
> >
> >> * -EEXIST: Same name policy already deployed
> >> * -ERANGE: Policy version number overflow
> >> * -EINVAL: Policy version parsing error
> >> * -EPERM: Insufficient permission
> >> * -ESTALE: Policy version is old
> >
> > Maybe make this one clearer, how about trying to update an ipe policy
> > with an older version policy.
> >
> > -Fan
>
> Thanks, I have compiled the list based on your comments.
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
> How does that that look? I will update the documentation with this list
> in the next patch along with suggestions you mentioned.
>

This looks good to me, make sure to also update the function
documentations in the code.

>
> Moving the memdup failure discussion here:
>
> >>> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> >>> index 5b6d19fb844a..da51264a1d0f 100644
> >>> --- a/security/ipe/fs.c
> >>> +++ b/security/ipe/fs.c
> >>> @@ -141,12 +141,16 @@ static ssize_t new_policy(struct file *f, const=
 char __user *data,
> >>>         char *copy =3D NULL;
> >>>         int rc =3D 0;
> >>>
> >>> -       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
> >>> -               return -EPERM;
> >>> +       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
> >>> +               rc =3D -EPERM;
> >>> +               goto out;
> >>> +       }
> >>>
> >>>         copy =3D memdup_user_nul(data, len);
> >>> -       if (IS_ERR(copy))
> >>> -               return PTR_ERR(copy);
> >>> +       if (IS_ERR(copy)) {
> >>> +               rc =3D PTR_ERR(copy);
> >>> +               goto out;
> >>> +       }
> >>>
> >>>         p =3D ipe_new_policy(NULL, 0, copy, len);
> >>>         if (IS_ERR(p)) {
> >>> @@ -161,8 +165,10 @@ static ssize_t new_policy(struct file *f, const =
char __user *data,
> >>>         ipe_audit_policy_load(p);
> >>>
> >>>  out:
> >>> -       if (rc < 0)
> >>> +       if (rc < 0) {
> >>>                 ipe_free_policy(p);
> >>> +               ipe_audit_policy_load(ERR_PTR(rc));
> >>> +       }
> >>>         kfree(copy);
> >>>         return (rc < 0) ? rc : len;
> >>>  }
> >>
> >> In case of memdup fail, the kfree(copy) will be called with the error
> >> pointer. Also how about refactor the code like
> >>
> >>         ipe_audit_policy_load(p);
> >>         kfree(copy);
> >>
> >>         return len;
> >> err:
> >>         ipe_audit_policy_load(ERR_PTR(rc));
> >>         ipe_free_policy(p);
> >>
> >>         return rc;
>
> Another issue I was thinking about that is what if memdup works but then
> ipe_new_policy fails, then we still need to call kfree but the above code
> mentioned by you will not do that.
>
> I think we can just use "copy =3D NULL;" after recording the rc value fro=
m it,
> instead of the suggested code. For examples, we can look at selinux.
>
> -Jasjiv
>

Yep this makes sense to me. We can just add "copy =3D NULL" and still
use only one out: tag.

-Fan
