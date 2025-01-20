Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE987E1
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jan 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344638; cv=none; b=LvzFylo4A/pwfvIIYPJXH3rs5Sm9EziiugYyhJhQBT3ZYXCc0u4kf6DOeBI/WrggqRfZtp8BYWcY+WdpK+sw4bZGKnxv1tjabp96hCWOccNdHyVxUZzvMbCAIP88YtERNvwg2+hEm/CDoF8HZKo0Q4nSg9VZX3cmKRpPSQjNyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344638; c=relaxed/simple;
	bh=z+LLUr6f3Y1rhtf1pxVMAO31WySAw5iNp3rbn9WJbAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+uAl8q0Rqq2+Kwjalyt/SRARyuUK/HRPYRki/ywcY4a6l809OuA+olV7U7Cb4kNgCxV9nbxNrOACVb78nBa1bjVqKgpv/owpTO0Lbhm1xtURxvNlRHL3s6ZPWfNS8QuVpPNe3KTSDKZpQFj3P1QBnFq93CE5RNA7UybdsdcoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBZMaSJk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBZMaSJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EF2C4AF0C
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jan 2025 03:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737344637;
	bh=z+LLUr6f3Y1rhtf1pxVMAO31WySAw5iNp3rbn9WJbAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CBZMaSJkCCsaCUlUzqBjKTomZ9fz9JnScmun0Wr1vWGq/5vwiSBVnnNkFBgkZMxxe
	 9mCQxt/XqaVUSrJ1yfEwaKQ3JDGwIxNdbn8v0sHij00tAiDwA2wlc4SlYAT9jxHS/q
	 hUXAMUUi1a+inLZGLzps1K4TMdKJX2tg9LlhW81uGIe7r7LfoF0d+a5EDTkUqPFxhG
	 0k67Vf6IZId667rga4Bn5epNry7YvDbt2bIM7FqN8DsyuPeE7cqWrYVyNxyJLiSTiy
	 2TcezOcek6d812vtRBMJU195TXhDod3rNbrYLAs9BMPbsCSojQ18ats4eU87K1WTrq
	 +XuQIwsj2LT7A==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso5814798276.2
        for <linux-security-module@vger.kernel.org>; Sun, 19 Jan 2025 19:43:57 -0800 (PST)
X-Gm-Message-State: AOJu0YxR57LU6IC7ty4pjRQ5WOfGhI00/QjtthjKVhbPnPB4j6VNAsOP
	ZK7NzEILDitoc3iwykg+Tu0FKLYZ5FrDRfR4/RIHZg/tVn25p96NPbHHCTAaAuyABstVmH0ZYn2
	LErTMEHvtt0BMxsFFvfP2Yrhu4Yk=
X-Google-Smtp-Source: AGHT+IHsnsMelP/nrT+e5i3j+m5/P8Rh2/nNRDygvPw0NxurIBlX62A1zvs2+LxxoTyuE6j1iLoLTbGf2COYKZN2mGU=
X-Received: by 2002:a05:690c:314:b0:6ef:7d1e:bffd with SMTP id
 00721157ae682-6f6eb941082mr87061917b3.37.1737344636596; Sun, 19 Jan 2025
 19:43:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111063318.911062-1-rdunlap@infradead.org>
In-Reply-To: <20250111063318.911062-1-rdunlap@infradead.org>
From: Fan Wu <wufan@kernel.org>
Date: Sun, 19 Jan 2025 19:43:44 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHSv7Vwh4y70wWXjH1TK1qUYiykuRSQpRM-6oc6UaJZ9A@mail.gmail.com>
X-Gm-Features: AbW1kvYWtigIS5hPwT8GtEclfAIws5ljyxjJrbXI1al-1qBC6dTJsul9li_S5r4
Message-ID: <CAKtyLkHSv7Vwh4y70wWXjH1TK1qUYiykuRSQpRM-6oc6UaJZ9A@mail.gmail.com>
Subject: Re: [PATCH] ipe: policy_fs: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-security-module@vger.kernel.org, Fan Wu <wufan@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. This looks good to me. I will pull this into the ipe tree.

-Fan


-Fan

On Fri, Jan 10, 2025 at 10:33=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Use the "struct" keyword in kernel-doc when describing struct
> ipefs_file. Add kernel-doc for the struct members also.
>
> Don't use kernel-doc notation for 'policy_subdir'. kernel-doc does
> not support documentation comments for data definitions.
>
> This eliminates multiple kernel-doc warnings:
>
> security/ipe/policy_fs.c:21: warning: cannot understand function prototyp=
e: 'struct ipefs_file '
> security/ipe/policy_fs.c:407: warning: cannot understand function prototy=
pe: 'const struct ipefs_file policy_subdir[] =3D '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Fan Wu <wufan@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  security/ipe/policy_fs.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> --- linux-next-20250108.orig/security/ipe/policy_fs.c
> +++ linux-next-20250108/security/ipe/policy_fs.c
> @@ -16,7 +16,11 @@
>  #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
>
>  /**
> - * ipefs_file - defines a file in securityfs.
> + * struct ipefs_file - defines a file in securityfs.
> + *
> + * @name: file name inside the policy subdirectory
> + * @access: file permissions
> + * @fops: &file_operations specific to this file
>   */
>  struct ipefs_file {
>         const char *name;
> @@ -401,7 +405,7 @@ static const struct file_operations dele
>         .write =3D delete_policy,
>  };
>
> -/**
> +/*
>   * policy_subdir - files under a policy subdirectory
>   */
>  static const struct ipefs_file policy_subdir[] =3D {
