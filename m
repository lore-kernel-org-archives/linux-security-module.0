Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81834A33;
	Wed,  5 Mar 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209817; cv=none; b=G81UNSwEIrY/0BYURt9m7IWB0lL8wlGa6OIxFbGD8enRMP/bX42gazDlnyBEak4hqBAMN92yc2ww658Ngy0RR2PSGb2cMIWHLlutIK6GhfPNWMv6ykMne6nlgBhyXjJEPxqtG+Mxrf1MnVWS06g98dcovrfmNN+QJNGi1w1X0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209817; c=relaxed/simple;
	bh=DvbHalLpCxkuRiwdqtO8seg1Zu43gShTi+7ZD18U1h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEL77KhA4W/Pmn28sTopP7ME3bPBKiV0t+bNvGdo5rjxgFbimQkf+Q1RUivef+Lk/FspEw/RwcOyYyoRMsrX7K7AfwO5/6TciQriHF9lh0Hfi1e3Ulh1/z8Zi7ofmeXn0FZ/HXIh5uwI5+JyzquhvgV2CookGk8DGRcM8XpeRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udubEywU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udubEywU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56472C4CEE8;
	Wed,  5 Mar 2025 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741209816;
	bh=DvbHalLpCxkuRiwdqtO8seg1Zu43gShTi+7ZD18U1h8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=udubEywU4g28gFPq/9N5lLM2nPK1lMawQ+GWUGIQt4obxSNbK7tbvj1DBi5YN/eM3
	 2E1ekg9Wg36v2x08Of2jLE56mTUfeOMzOLoSWFjY8SA9zqgLY7qAfWJyTSRnkuz3C3
	 VbLBIxk1bLSO9xongCpc+qWD9eBWh0d3z6PWABYjx3Iv0Ipmxia/DgeJtpTaXwFgnT
	 vumj06ol2aIc4cN1EMP5Wr3OxlXmZ24xPqztZVnyZDHrDNCf5aZ0IrXN+Qh5MYC3In
	 8rgqPuxDMH0A1CF5Pa45HOkyTtNnmW9BDaXb9Hmo/ThrparhMqIAc5PQ3YT90rDaIG
	 iCM+4IundHthA==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6119fc5e9bso1330683276.0;
        Wed, 05 Mar 2025 13:23:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyjZiARvlwfsy1T4b2XFZW2yNvVTJGv9I3P8Jg4sS9zmTlhW1Ar0yV7LJACzToeT63qlrYV6zYu5gX@vger.kernel.org, AJvYcCX0reZlse+DT9mvOySasA05Y4ega+fwlfYq2ea+K2gL1VQoC/VSRdSkfCcECyhhMM7LvNwY428miYkVOj3c@vger.kernel.org, AJvYcCXkGPqCQF0cEh8kovKNNznQLDo/mNYhBHq+5zK647IgT6nSpa/JLGcA3WCpZVF1qze2dDeYUntbhCrVFif5VLO+rWLFYlB6@vger.kernel.org, AJvYcCXwsXCS7kdCp23mD3C14viPssDHhkXT4Y327FJAgwl9KyYdAepS/F6XaAu1Kb5ebTgJYxPhBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59/eArWnYIvynSYImC0hwU8AHN9VwKxbrd0e4gxWG+Pldi6Sc
	amDvu/ZM/irSzKE1+RDsCfVLd98ANiFW5ebfpW8ID6PhYYZhWvMXrTCPofXLLO+RwbrYEWzdyW+
	38sbxKNebyitgnr/bse322Yuy810=
X-Google-Smtp-Source: AGHT+IFclP7iVxvi0j9ekZjfJdMyS78JlgW+fr8ZvybEcumnXEaCDKm5SlFT/PVINMVVVcf+Uzsy3DGg4vx2Z/JvQhA=
X-Received: by 2002:a05:6902:2a42:b0:e60:affa:673d with SMTP id
 3f1490d57ef6-e611e333584mr6233902276.48.1741209815692; Wed, 05 Mar 2025
 13:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
 <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <CAKtyLkGV4cGJzbvVUAeLBp=evc_QAWPD8FsskHNVvx-1UZJB-A@mail.gmail.com> <0a5e586a-9b55-4905-8663-6ef0112aa32d@linux.microsoft.com>
In-Reply-To: <0a5e586a-9b55-4905-8663-6ef0112aa32d@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 5 Mar 2025 13:23:23 -0800
X-Gmail-Original-Message-ID: <CAKtyLkEveJbJ9HAufC1_x8J287qqDFYZOhK2Y0MEaPo+dkJm2Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpnHsTCDFfoCzh84MJkz2wEhzTGjo9BEiGagwu5LFjMWyeoqQInPgwF4J8
Message-ID: <CAKtyLkEveJbJ9HAufC1_x8J287qqDFYZOhK2Y0MEaPo+dkJm2Q@mail.gmail.com>
Subject: Re: [PATCH v3] ipe: add errno field to IPE policy load auditing
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: Fan Wu <wufan@kernel.org>, audit@vger.kernel.org, corbet@lwn.net, 
	eparis@redhat.com, jmorris@namei.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:04=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
>
>
> On 3/3/2025 2:11 PM, Fan Wu wrote:
> > On Fri, Feb 28, 2025 at 3:11=E2=80=AFPM Jasjiv Singh
> > <jasjivsingh@linux.microsoft.com> wrote:
> >>
> >> Users of IPE require a way to identify when and why an operation fails=
,
> >> allowing them to both respond to violations of policy and be notified
> >> of potentially malicious actions on their systems with respect to IPE.
> >>
> >> This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD e=
vent
> >> to log policy loading failures. Currently, IPE only logs successful po=
licy
> >> loads, but not failures. Tracking failures is crucial to detect malici=
ous
> >> attempts and ensure a complete audit trail for security events.
> >>
> >> The new error field will capture the following error codes:
> >>
> >> * 0: no error
> >> * -EPERM: Insufficient permission
> >> * -EEXIST: Same name policy already deployed
> >> * -EBADMSG: policy is invalid
> >> * -ENOMEM: out of memory (OOM)
> >> * -ERANGE: policy version number overflow
> >> * -EINVAL: policy version parsing error
> >>
> >
> > These error codes are not exhaustive. We recently introduced the
> > secondary keyring and platform keyring to sign policy so the policy
> > loading could return -ENOKEY or -EKEYREJECT. And also the update
> > policy can return -ESTALE when the policy version is old.
> > This is my fault that I forgot we should also update the documentation
> > of the newly introduced error codes. Could you please go through the
> > whole loading code and find all possible error codes?  Also this is a
> > good chance to update the current stale function documents.
> >
> > ...
> >
>
> So, I looked into error codes when the policy loads. In ipe_new_policy,
> the verify_pkcs7_signature can return a lot of errno codes (ex: ENOKEY,
> EKEYREJECTED, EBADMSG, etc.) while parsing the pkcs7 and other functions
> as well. Also, In ipe_new_policyfs_node used in new_policy(), I see the s=
ame
> issue with securityfs_create_dir and securityfs_create_file as they
> return the errno directly from API to. So, what should we return?

I think the key here is we need to document the errors in the ipe's
context. For example, ENOKEY means the key used to sign the ipe policy
is not found in the keyring, EKEYREJECTED means ipe signature
verification failed. If an error does not have specific meaning for
ipe then probably we don't need to document it.

>
> For other functions: I have complied the errno list:
>
> * -ENOENT: Policy is not found while updating

This one means policy was deleted while updating, this only happens
the update happened just after the policy deletion.

> * -EEXIST: Same name policy already deployed
> * -ERANGE: Policy version number overflow
> * -EINVAL: Policy version parsing error
> * -EPERM: Insufficient permission
> * -ESTALE: Policy version is old

Maybe make this one clearer, how about trying to update an ipe policy
with an older version policy.

-Fan
