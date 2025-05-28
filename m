Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC716136672;
	Wed, 28 May 2025 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748396493; cv=none; b=U4iEXwq6bVQeiLpyH6uEhwK89dqrh2Fo+vyETFxdqf5CYsjN9XEkfYMVRHTUh9bLQ0OmpeRtkXpJuLUpRS+ggARbs7buMkVrzhnjX4+Or/8xQ1T81+7UoLknGqioGcMKGFq3m4P2akYu+FSDhp3UBs/vK9NGg/v8AHeYUcxxhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748396493; c=relaxed/simple;
	bh=YlS9uENzu0Nhic8XVKYOHbZfuipcgIhwcq5qY2oaBhw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lwtGeMShSASvStjj5H4ezC38NOCraVCBmsvkSEK4eKfgGeEb3X/iWN3B552TcOAABNBLd4sAWbKQtcfmwv40bYrjPBEfxP8d4uf3EybNKGeJ9K9GDLUX8UpC0YntKaY/QSI6gMlWKVt3o7JuMLZiCN6eWFnbYoLhGPO9vEr00sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajff55LP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajff55LP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82D7C4CEE9;
	Wed, 28 May 2025 01:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748396493;
	bh=YlS9uENzu0Nhic8XVKYOHbZfuipcgIhwcq5qY2oaBhw=;
	h=From:Date:Subject:To:Cc:From;
	b=Ajff55LP496GOO57ExvC4elis3Ij/HOMBGdXfdEEV07Rp9074q0XwLQJTsKdby9GR
	 3rV+qc3PvhBJMCX7+FnWP29v7yQrI14k1uf+lHQbKmSqQpuEU4XIicfXWfLtJO1Tuh
	 Wqkoag/zva7xO3pv6SKDmEYV3ngY048pRZZGJtRNJPE2ZOGa5mx7PVi9bV3IF3pzBF
	 1tq0IaOiXfkUm2zAYXNObjCbzL/kD41kmhtD92MdVDFDtODHfYmL51XaraE2fSv8ZB
	 I7M1y2VWAltgs6h8QG2UhpYXOJHTr0d4KOkuRlnEhGmOOOmfAvlXhVotufs6/eWXgv
	 CsQaz4ExhVQeA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e3980757bso3751047b3.1;
        Tue, 27 May 2025 18:41:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfMzCLNkg79qQPtOkMwqEqWaoMP9bomuQKLGogaVD15JACkWg68LoYCd2RhtM2Udu4IKzoiw0pDmjnkpGb6xyDyCaENAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLpyYza01jF/nnaJIaOSJkvwdv8UvthX7cL1jC6QkWN6lGU+9
	5jwi18Ep56OKLptzBNUvWxMh7aoTx3gsRkW8lyCQDPVhMvGqOv4syUcdtCTvTUxa6ldifgTRCre
	G6aJDCjmopKReSE9wAP1m5kP+mSaZMFQ=
X-Google-Smtp-Source: AGHT+IG0AzwPVbHW/FoMkNfWC3X+QcIb36uFuCtMa8Os5JdW20itCToqIzsLkgZUVU4xQ+lAvP+Xry82c6qesiBgwFw=
X-Received: by 2002:a05:690c:720a:b0:70e:61b:afed with SMTP id
 00721157ae682-70e8332210fmr42914747b3.7.1748396493033; Tue, 27 May 2025
 18:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Tue, 27 May 2025 18:41:21 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHcU8EGFjYp7fDV8tFqDE6VgQ_q4KQO+1Yy4SYYmveGWw@mail.gmail.com>
X-Gm-Features: AX0GCFsW3H0Xe4ZaOSVl46ag2mnYGHRPiP0VbQPTYb_lzggwBNsRmkgIt6l-iRs
Message-ID: <CAKtyLkHcU8EGFjYp7fDV8tFqDE6VgQ_q4KQO+1Yy4SYYmveGWw@mail.gmail.com>
Subject: [GIT PULL] IPE update for 6.16
To: torvalds@linux-foundation.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, 
	Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE update for 6.16.

This PR contains a single commit from Jasjiv Singh. It adds an errno
field to IPE policy load auditing to log failures with error details,
not just successes. This improves the security audit trail and helps
diagnose policy deployment issues.

This commit has been tested for several weeks in linux-next without any issues.

Thanks,
Fan

--

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20250527

for you to fetch changes up to 1d887d6f810dbf908da9709393c95ae1a649d587:

  ipe: add errno field to IPE policy load auditing (2025-05-27 18:08:51 -0700)

----------------------------------------------------------------
ipe/stable-6.16 PR 20250527

----------------------------------------------------------------
Jasjiv Singh (1):
      ipe: add errno field to IPE policy load auditing

 Documentation/admin-guide/LSM/ipe.rst | 69
++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 security/ipe/audit.c                  | 19 ++++++++++++++-----
 security/ipe/fs.c                     | 25 +++++++++++++++++--------
 security/ipe/policy.c                 | 17 +++++++++++------
 security/ipe/policy_fs.c              | 28 +++++++++++++++++++++-------
 5 files changed, 113 insertions(+), 45 deletions(-)
