Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAB1CAA6C
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385981; cv=none; b=ZGzsokAKiqPNNiPRQy6FkY6L6qva/uj/fD+/90QMrk1MqThqRO2JN+ptk8d8MI+Uz5Ud94f5/0c1mZ6CcX8/x/Kza7lItL91+/e18+WrG9t7aojuUXB70Sq/WHioak8UDTotzeiSmr+FdCCLbIsPSS3Q2Rz1jww5WHMMTi5yRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385981; c=relaxed/simple;
	bh=ad87AQM7onhmSNUoaSc+pJLxvG5glvi5RpIzF5Cyhsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC3dLfMMputt1ubrF9IUGstehposnmMJYeMkKOTUvGM/pxnENb0WUEAlwjgass0WfClRY5WYxugcPtC0H9sYw4JunLe7aMBrG6LmPLkhMxTj9dU0PHT7b5FUnP7gFBOtqWrXYqKI2UDCiET4oU4L9vKPRSWDUNelfkX+ynu0V8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVIsoozy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVIsoozy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E47C19422
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 23:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762385981;
	bh=ad87AQM7onhmSNUoaSc+pJLxvG5glvi5RpIzF5Cyhsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CVIsoozyuSjlfoAXmbCPqRSbT8mHch2MetbvDTJp/fS6qdf+Yv4ICD3sbi5HkLG78
	 ZiWBelrjYvGUxQrNHf3Ysr43RYbqZIEUHJxu0SGbr3QxDTmckm7T45BoTfl4C3LFhX
	 bNJ2isvx3zN2C7ZCsqsLB1eJRYb99MFf5Z2+of2YZiNxxNSP6Pvh2odbEZWZQghGcU
	 44YmuaWYdOD4ySJ9yyvbBYRkVwGPgx9NEyYXglJbnLzg8ykkRzk6D1rhHYxik3WgGQ
	 3z4EcnR2RU2jYi8Mf3amDA+pzDRcEU+c3Ot/xxMvWC0NNdlORUtLx9YfNBZx5K7loM
	 AaMfBM+Dp08eQ==
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a1603a098eso265956b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 15:39:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/lZQa3fKSLIN00tNsCkFvR6oWg2z/8f/Yh73kJrH4A2XF+DhExvhgety0uRQ+xyfd9HLkEo15ONXl9tK36nrDlagRYiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/5YHRf4HkgcdoXDeQUhxAcR89phWcjElXzmewnw+SnAXBP8g
	ZhCgw1krVkLI5nbRb3a7s2kC5wUVALSa0APyDLbjgPKEeY5esAgGmi91rxx10rFkY9WwK70xG9Q
	Za4gUMXtJleOJ8Fndf0a5kIQaJyTsJgA=
X-Google-Smtp-Source: AGHT+IGFgsWp44LDzpMdW8c/K6LA75pMzm1Rzpqpggg6Q6IM8gZfErETvOdNjrRzM710JJF02+xjkLyL0Hw+OKJTdmY=
X-Received: by 2002:a05:6a20:6a0f:b0:2d9:c2:5ce4 with SMTP id
 adf61e73a8af0-34f840138bcmr6089035637.7.1762385980658; Wed, 05 Nov 2025
 15:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105232615.720861-1-yanzhuhuang@linux.microsoft.com>
In-Reply-To: <20251105232615.720861-1-yanzhuhuang@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 5 Nov 2025 15:39:28 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHfW=cOryV9T4D=RA9-C=cea5DcH9U8jMn8OKAS30PHzA@mail.gmail.com>
X-Gm-Features: AWmQ_bmNXGHrdDJc6hWNgp1g05sL-4GIVDgJ77DbOJ69D4xJTHR2sRKHobb2cpo
Message-ID: <CAKtyLkHfW=cOryV9T4D=RA9-C=cea5DcH9U8jMn8OKAS30PHzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ipe: add script enforcement mechanism with AT_EXECVE_CHECK
To: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
Cc: wufan@kernel.org, paul@paul-moore.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:26=E2=80=AFPM Yanzhu Huang
<yanzhuhuang@linux.microsoft.com> wrote:
>
> Indirect file execution through interpreters (e.g. python script.py, sh
> script.sh) should have integrity policy enforced by IPE based on the
> rules. Currently, IPE can only enforce policy on the interpreter binary
> itself, but has no visibility into the scripts that the interpreter
> executes.
>
> Overview
> --------
>
> This patch series introduces script enforcement for IPE, allowing integri=
ty
> evaluation of indirectly executed scripts through the AT_EXECVE_CHECK fla=
g.
>
> Patch 1 adds the core implementation with ipe_bprm_creds_for_exec() hook
> that integrates with the AT_EXECVE_CHECK mechanism.
>
> Patch 2 updates admin guide documentation to explain the script enforceme=
nt
> mechanism.
>
> The IPE test suite has been updated to include script enforcement tests:
> https://github.com/microsoft/ipe/pull/6
>
> Changes since v2:
> - update AT_EXECVE_CHECK reference
>
> Changes since v1:
> - update the interpreters reference
>
> Yanzhu Huang (2):
>   ipe: Add AT_EXECVE_CHECK support for script enforcement
>   ipe: Update documentation for script enforcement
>
>  Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++++---
>  security/ipe/audit.c                  |  1 +
>  security/ipe/hooks.c                  | 27 +++++++++++++++++++++++++++
>  security/ipe/hooks.h                  |  3 +++
>  security/ipe/ipe.c                    |  1 +
>  5 files changed, 46 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>

Thanks, applied to ipe/next.

-Fan
