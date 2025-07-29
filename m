Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49294A23;
	Tue, 29 Jul 2025 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755358; cv=none; b=ZdXO0sIfykOUZDgiS5VUtKOi/0BDNxNUvg7zJUWyyyGUMQJjTd9SndY/N+09p3NWgDCLe2s8BJi0J89xvBHDhaRHT9oQjTFU1SymSwiFuQLJFlf38oB4FDaldDKC2JKFfNzNrNoqeUwqWcM8lhYrjbYl0iU6tJ7fFkfOYSAfHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755358; c=relaxed/simple;
	bh=fgaF3JYWiesxie2b/8woXZbjAbW5F20267YHTL7iCNw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ebEtd8KCGKWtlv/an9bo4EQpuCE4vd/4rKNrZhhFq+Sjk47pRfPMQgqvH47pkeRL+xG4/jKo9u/QQeAA6W+UyZvsi/yqv6GKmIosFR54DOR96XGbg9casjZOE7qyQQw6q0WuVDmegpukkbMQqAwPwTsXSQp+NCZ5rBaE4yfYwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mijs1/uE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mijs1/uE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43778C4CEF6;
	Tue, 29 Jul 2025 02:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753755358;
	bh=fgaF3JYWiesxie2b/8woXZbjAbW5F20267YHTL7iCNw=;
	h=From:Date:Subject:To:From;
	b=mijs1/uEDLy23gJHICvKh8ZNtEGxMQQtOjyCz+SSaU0wOoJJpMSiiSF2oLeeRyntQ
	 bNgjpfZxiCjDN9o7taWA/a4n6G9dPiy6kUUxXGCJDBKOsrUB9ld6WKHQzUgae7mocX
	 nv/H+SXTlbMjIIuX5zxffqbtxXv1LPPFrKEeBTrFUKsOVUTB7N0fDDxp8RL4iEGDZT
	 igaho/PJHhnZ3vQ81448H0N9bQeW+DyzfExJTDlUgSR1IxfO3sNl7+oWS2zFPl/ujX
	 AQYfmqF71O5ecFt3YNJrabw9BYpQDLM3MZry2q4zdPHXW4Vnjtk8s4CXHIqTzsZjhr
	 VDC+9g99JpCkQ==
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8e1ae319c6so1191060276.0;
        Mon, 28 Jul 2025 19:15:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdDWssyQWcT3f87Twt1Cgkq39O+kT3HLZt5Co4sT+squ4CEbgUqEDymeBehT9FTk7Fd7f7W8ETXjWwsJU=@vger.kernel.org, AJvYcCWKgbf7OXNiainlSE6wHkEi+Fwah3lUYqjaUHAjOcHVN2yeIWv/BlgZa5gmYPX5L/fmrqrm8jc5nDwtUI/RQNaR5Ai/a8xz@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGrEAIdS6asfrtF0ivN/2b6DgA0cF4G/+ziVzKI0o6kGAnfSm
	WK6He9Vn2F6eHOTCfr/WBJKswWQeMottyWELXUSI+pPWSqMHQkbiZcNdy00WPx6I8pZSDzUgMPL
	Cjsrp21WNXgcTZ6FJaF7vQ/nJyaUcN6I=
X-Google-Smtp-Source: AGHT+IGLn9yD82vtmJcDSKuzRhByMYfngK4NyIMaY+bn+DjnQBQSFZTLaZJ8YcLLzt6f+J9An+0cak4bkfV56xxAOKY=
X-Received: by 2002:a05:6902:2685:b0:e8e:1911:293d with SMTP id
 3f1490d57ef6-e8e19112e9bmr6217229276.24.1753755357537; Mon, 28 Jul 2025
 19:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Mon, 28 Jul 2025 19:15:44 -0700
X-Gmail-Original-Message-ID: <CAKtyLkFWt6+5iKWy8BKJH2L51OpfPsEFkpjjn-EQGfHaSRnqAA@mail.gmail.com>
X-Gm-Features: Ac12FXxEXD_s42XqLW4v2wfyHe0T_ER0l7GNW_Lq8iuS6adhApZyu7aNN1I9xew
Message-ID: <CAKtyLkFWt6+5iKWy8BKJH2L51OpfPsEFkpjjn-EQGfHaSRnqAA@mail.gmail.com>
Subject: [GIT PULL] IPE update for 6.17
To: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE update for 6.17.

This PR contains a single commit from Eric Biggers. It simplifies IPE
policy audit with SHA-256 library API.

This commit has been tested for several weeks in linux-next without any issues.

Thanks,
Fan

--

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20250728

for you to fetch changes up to b90bb6dbf1d60d70969f8f8f2f30033f49711594:

  ipe: use SHA-256 library API instead of crypto_shash API (2025-07-28
18:54:18 -0700)

----------------------------------------------------------------
ipe/stable-6.17 PR 20250728

----------------------------------------------------------------
Eric Biggers (1):
      ipe: use SHA-256 library API instead of crypto_shash API

 security/ipe/Kconfig |  1 +
 security/ipe/audit.c | 33 +++++----------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)
