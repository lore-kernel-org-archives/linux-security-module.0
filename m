Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530812F0676
	for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862135; cv=none; b=ZByT2N1zcAXbpqr7IFs+4GrzOd2FDshy1XC6hiLiRY726W5ZRuLkCLZmpnNworqAooK/MkrfkxjBi/vctkxzqnfwUXbF4kGRQ2OCNPiaxdimx7BTtz4TL5ggtX0VSLysbQsN4TpAMx5RHUQRBuzS4Fn61QctVR9lrWGHZBaE/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862135; c=relaxed/simple;
	bh=QCaxQQp22Ou0uBRcqdmljdY4A1uwLgCFWyFq2Al5hH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhMGLB83hxXBRy99rn+fNN0lFMrq5QVposNuew6urhx2vLMaeM8mEFAqExc0dFU02ZPuzyJXI9fYkQLYn2jzh8kRlTCizqiZt8YxczRnC5MDCfqRmUFVkHsBHa26bo3eC3oZpZdBitva4fH1PQQsdJ6774UckO3oe1tfNPL+/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuv4oOLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuv4oOLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0661EC4CEF1
	for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761862135;
	bh=QCaxQQp22Ou0uBRcqdmljdY4A1uwLgCFWyFq2Al5hH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nuv4oOLn1T4nMLdqbCNuzl0x9YUWtMIIav7oZMEPLyzSI9jZSAH3ixOWmH3g655NT
	 OT2H1DzuvDV+vQTh+fN18t5YPY/ZS3bCVI1J9jjAhRKw1tY/dQgt/hip+qTVxCDmHE
	 M8SXwJUbKyLD9SdmybWHOStuEc1s35vR5tDrjZVq/tan4ai5vRZ+A7KwZ9fl83cPE6
	 HknJgXdSH4SMPTV3kcphvEEfBoty8u9u2t0k9FYbDaBwFPv2U2LmgKFqtPPQ9Q3AiH
	 zwQPS4ugvZi2Q93qc8M6MTP0KghAjFdsu/hWJ0N0gghNin2pIw9Q2gttp1yuDsuVf0
	 KKCWbMPGYP2lA==
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso1208498a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 15:08:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGdzWqb/ZmpFzlwO1J8h9uc4nhGwZzT3y+EVh4aqEGQxDh/9KqhTpUzWwHlfMmBQd9FTAH+MtEgALUlUS0ZLlFpbPAYWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFRzzRTnWg3sO5Wt06YQK5UvZxKNJ2AbXBi2Hf4WHH8cE1Rfqy
	veu62WJ7cP3AReJgeySkDKLg/8aoeThK+/+XeGLtdo1KKDnVIjHoAucf7J8g8erM7zdm+asb8ye
	iB6HgwqvBlDSpAtTEnm8Ut9pNAONiAeY=
X-Google-Smtp-Source: AGHT+IHEHiUBfUwlW3je89mFpeopWhX58UhG4swXErqOcigIFZnDoujTVPO1LSZCUlt8UHyapOY1EcH0H4JbtJ5zFbU=
X-Received: by 2002:a17:902:d4ce:b0:293:e0f:3e3 with SMTP id
 d9443c01a7336-2951a440d24mr18670675ad.29.1761862134648; Thu, 30 Oct 2025
 15:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com> <20251023233656.661344-3-yanzhuhuang@linux.microsoft.com>
In-Reply-To: <20251023233656.661344-3-yanzhuhuang@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 30 Oct 2025 15:08:42 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHVQuR+5N5qimAb=+GpGFpDt7YRq+jYC07R4wfRE6xUgg@mail.gmail.com>
X-Gm-Features: AWmQ_bm80q11eSbg7G-yU6QtbTi5-vtrJoIqly0ibkMkpjNe7gqJ2xgghoMMvTc
Message-ID: <CAKtyLkHVQuR+5N5qimAb=+GpGFpDt7YRq+jYC07R4wfRE6xUgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipe: Update documentation for script enforcement
To: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
Cc: wufan@kernel.org, paul@paul-moore.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:37=E2=80=AFPM Yanzhu Huang
<yanzhuhuang@linux.microsoft.com> wrote:
>
> This patch adds explanation of script enforcement mechanism in admin
> guide documentation. Describes how IPE supports integrity enforcement
> for indirectly executed scripts through the AT_EXECVE_CHECK flag, and
> how this differs from kernel enforcement for compiled executables.
>
> Signed-off-by: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index dc7088451f9d..1063256559a8 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -95,7 +95,20 @@ languages when these scripts are invoked by passing th=
ese program files
>  to the interpreter. This is because the way interpreters execute these
>  files; the scripts themselves are not evaluated as executable code
>  through one of IPE's hooks, but they are merely text files that are read
> -(as opposed to compiled executables) [#interpreters]_.
> +(as opposed to compiled executables) [#interpreters]_. However, with the

All looks good to me, however, we could also update the
[#interpreters] reference to userspace-api/check_exec.

-Fan

> +introduction of the ``AT_EXECVE_CHECK`` flag, interpreters can use it to
> +signal the kernel that a script file will be executed, and request the
> +kernel to perform LSM security checks on it.
> +
> +IPE's EXECUTE operation enforcement differs between compiled executables=
 and
> +interpreted scripts: For compiled executables, enforcement is triggered
> +automatically by the kernel during ``execve()``, ``execveat()``, ``mmap(=
)``
> +and ``mprotect()`` syscalls when loading executable content. For interpr=
eted
> +scripts, enforcement requires explicit interpreter integration using
> +``execveat()`` with ``AT_EXECVE_CHECK`` flag. Unlike exec syscalls that =
IPE
> +intercepts during the execution process, this mechanism needs the interp=
reter
> +to take the initiative, and existing interpreters won't be automatically
> +supported unless the signal call is added.
>
>  Threat Model
>  ------------
> --
> 2.43.0
>
