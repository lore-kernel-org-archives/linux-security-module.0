Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD91315D39
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121777; cv=none; b=gPbw7A4+gStD1Wu8SUrIwmLoEvPjVkC87rVgGqHW6/H0wRR/kY2ft2TqN2Wek1t/hRv5IaYF6YVToxHaalmFxFktmTHF5HAeXNCq8lIuGS8P/mDdxXjMJiTkoSPDXbsLMVC8a/ST0YaBisw09jGs0wxlHoF0dEO8RSE/4IN4AVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121777; c=relaxed/simple;
	bh=bHsa/wkpNRGmJkvC4cfVcPB4xzDeBGvLudpDOEe9H60=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DGnRp/T7gHPRdS7roHGM7bE9R8zDmWHWhYRBUYJAsd7k4q9daDN+JV0QdWNyl64KgDRYlOhEJJsxiAKSfwWe/7rctI9HIi2VLHOBQ7RRgmfk49N72bsYEKqRKGTv+zOH7iIvjvvnNQPo6GuWIOz63HkVd9CbtRnIWB2fiKWUiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOI3w/TV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOI3w/TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B099C2BCAF
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 23:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121777;
	bh=bHsa/wkpNRGmJkvC4cfVcPB4xzDeBGvLudpDOEe9H60=;
	h=From:Date:Subject:To:Cc:From;
	b=BOI3w/TV2CUU0pLvY1v9IkTDq74IMvQCGXtHaS7fJhjEAW8htSWWYofi1etEi27H0
	 XwpR3T1tpHK2ce+iWIjmBOpECC6cJm1XwmnD1eRNQg22Vh/+4erZTVzp1eQ6j/uRz9
	 a+cb2NCu+1ceLMaIZHIkSntFhAsM28LkzTFtLafiBymmyjHVqmHAKp0Qb7CJjTO6zd
	 BUAqfpPnDmwTyy/9TvRPaXm342Kzxb6IhXnJAu71KeTykEBmycK3ehMPVuOEiawvVY
	 t3SObHmgZCs0Gsom/K7RJ3HiCE71Y8QRAkK3VDazkN6tg/B0JUM0d/pB7aTrMNgl9o
	 5ZTcf+ZtcXqhg==
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c080efc1eso2965399c88.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 16:09:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9x+m4rAaTCRpcPmsD9lxqxxsGDy1ntGUA/F+/ARl0rwyA3XZ/ESZn8291mkERwLhOmeyKHcdE+Syc44Kg+LZKxQnzk2tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqgboA7GDGoVozxamPGTSWT5/XAyECHV6hVNpGp5xrOTusrzV
	Q3EHdJlg88uWpEldvLNy7RT5SofpPWC1lnoYgaW9HJuysAMN/QDSxhohqRXk1724x2SH0avgbto
	k6gRR8kkulahhJARUKZTaajOzWdHbp+8=
X-Received: by 2002:a05:7022:439f:b0:12c:d3b:f0eb with SMTP id
 a92af1059eb24-12c28bff23bmr9229667c88.8.1776121776676; Mon, 13 Apr 2026
 16:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Mon, 13 Apr 2026 16:11:23 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHLk0o+fqLOjf2F9_ixkcgjW6rDpARQs0H7GPn+OJ2c4g@mail.gmail.com>
X-Gm-Features: AQROBzDf9S3UGWTbl4WKhy1z3QH832eNZ8M50tZDLQ6agJwqs5_4nH7VkiG2I70
Message-ID: <CAKtyLkHLk0o+fqLOjf2F9_ixkcgjW6rDpARQs0H7GPn+OJ2c4g@mail.gmail.com>
Subject: [GIT PULL] IPE update for 7.1
To: torvalds@linux-foundation.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE (Integrity Policy Enforcement) update for 7.1.

This PR contains a single commit from Evan Ducas that fixes several
spelling and grammar mistakes in the IPE documentation. There are no
functional changes.

Thanks,
Fan

--
The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20260413

for you to fetch changes up to d46515ec0b1d4ae07f8f437515c43cfb6eb61ffa:

  docs: security: ipe: fix typos and grammar (2026-04-13 15:58:49 -0700)

----------------------------------------------------------------
ipe/stable-7.1 PR 20260413

----------------------------------------------------------------
Evan Ducas (1):
      docs: security: ipe: fix typos and grammar

 Documentation/security/ipe.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
