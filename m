Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA21259C94
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764734496; cv=none; b=N8NCvasysaI3ASCyhAJL7D7RnSH9rIQYD0lVagxj9vKrLZtYvf6nYaADQzCQhWC65dql2lo+PhztWsiovTWnYNmsH4ewKr61NhYy+hsJhpt1/7uRk23kImR0KKNvIoM3Ac3Z9gZyHB/wqzidfp2mnNfqjSZqkWTJuku3Dl2Hg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764734496; c=relaxed/simple;
	bh=14nIkzJxiiFsqw3j8qiXoSGFBB9O880C2GGC+TAW1xQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RdwwLEtauDkSmfcXhKqZGOsWPL0FzVR+RXYIdU7qlRSUIiUnQLd7Y8QTGOUi+p8bZZ/XY14mw/iNTn7Z7bfxgLi4V+1T0uw3OjVykIhWARRKo7UsDKm3vc1jInKT0zVprI5Zb6r3ihWMlvlyILCYgjIVbby+Yb078aTmaP3taiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnJ8DrZ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnJ8DrZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83D1C4CEFB
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 04:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764734495;
	bh=14nIkzJxiiFsqw3j8qiXoSGFBB9O880C2GGC+TAW1xQ=;
	h=From:Date:Subject:To:Cc:From;
	b=SnJ8DrZ7aiNJ2wPh3H0oZBR30MMHRD6V+jPUhyzSSpzyytzJ9epLMom5U6G2ohHvJ
	 d/BPdvP1CSdRa/zil69gY5OPRgKy0I/zuI6XLjGIJBXgAA7FRyGl8gPXc/K1TWN6zM
	 qctokLPXPDkZHqghovfU/9BbweIjmiiPUOVqIPjaVE8RCfU0SxHF73PaToF/5RHhda
	 lT5XDnPuZIugl5LNS5wkBmUmoc55byjsgIO8BYHcl63umnwkdTj2+2gI1fpiDpiHSI
	 bQJRf+AWH9cxIloN8i6ux7gEV4NKwpWXptd9YMl63aGmrK8YkKdoBmCKfqntKIhOzN
	 uurex2aBzJlyw==
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so7552603b3a.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Dec 2025 20:01:35 -0800 (PST)
X-Gm-Message-State: AOJu0YxMXlUlE5zq83QEZuIU2FVU4rXNoJVkVZ+6oMCNiXPu2u7nyQwP
	ZiklGHg84T57kEYdptOXOnc0v6SEWn+LXqsLP64aOyL+zs8C9nJT51FzO12JQQkZ4VagZQJiw87
	4aiN2Cg5A6rRqLRyV/vQ7JuRxXniOycw=
X-Google-Smtp-Source: AGHT+IHtvhZrceognOVyNFSSwd4xqpM471iDo3CRs7q3XLr0Y4UYkbSFNhJDfs5yZIufQHx4945XAe6w0JRMaer+Hjw=
X-Received: by 2002:a05:7022:ea46:10b0:119:e56b:9590 with SMTP id
 a92af1059eb24-11df0c740b1mr656044c88.21.1764734495476; Tue, 02 Dec 2025
 20:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Tue, 2 Dec 2025 20:01:24 -0800
X-Gmail-Original-Message-ID: <CAKtyLkEcKAnhdmHb24A2BGGckhjBJANb6XruAmo9L0CBjUMKzA@mail.gmail.com>
X-Gm-Features: AWmQ_bkFd8WOTtyIv8nZsihe7sXgoyC2YnyPMR59E-CpVWWr3lXWgXy-6U2UfzM
Message-ID: <CAKtyLkEcKAnhdmHb24A2BGGckhjBJANb6XruAmo9L0CBjUMKzA@mail.gmail.com>
Subject: [GIT PULL] IPE update for 6.19
To: torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE (Integrity Policy Enforcement) update for 6.19.

This PR contains three commits. The primary change is the addition of
support for the AT_EXECVE_CHECK flag. This allows interpreters to
signal the kernel to perform IPE security checks on script files
before execution, extending IPE enforcement to indirectly executed
scripts.

These commits have been tested for several weeks in linux-next without
any issues.

Thanks,
Fan

--

The following changes since commit 7d0a66e4bb9081d75c82ec4957c50034cb0ea449:

  Linux 6.18 (2025-11-30 14:42:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20251202

for you to fetch changes up to d7ba853c0e47d57805181f5269ba250270d2adde:

  ipe: Update documentation for script enforcement (2025-12-02 19:37:10 -0800)

----------------------------------------------------------------
ipe/stable-6.19 PR 20251202

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      ipe: Drop a duplicated CONFIG_ prefix in the ifdeffery

Yanzhu Huang (2):
      ipe: Add AT_EXECVE_CHECK support for script enforcement
      ipe: Update documentation for script enforcement

 Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++++---
 security/ipe/audit.c                  |  1 +
 security/ipe/hooks.c                  | 29 ++++++++++++++++++++++++++++-
 security/ipe/hooks.h                  |  3 +++
 security/ipe/ipe.c                    |  1 +
 5 files changed, 47 insertions(+), 4 deletions(-)
