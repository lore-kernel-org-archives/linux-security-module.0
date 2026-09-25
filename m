Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A26479889
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373299; cv=none; b=K9z0Wbmgx0J00zHBSucQIP/JEXALJA3GZ9nhuslG8xd7lRM86lbeRhuOLi4nC4ivjdeCHYU3iZhU4wyEx3dp25y3qxMA9QcuXbZ4wufeSKWKEAuCLfQ6RiRfNBpMfUVTioog5DAi8qeEHPRaurZ+9jAkbckzBk/EQqm8bvSDIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373299; c=relaxed/simple;
	bh=uL5GG0Rhy2kqx41pafopbGKUn9BWoUoGILgGIU4hV5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i/+z+KZpZjYELOe5I6yDtAWRS087CEOwiSl5Z8jZv4UW/Ezfejyhvz6TQBWbIKtlHTL6+7zXw3sNjJ3uYkcQW5fFmWkIqj3a2LeQbInetBm59nrhtZ9jT2yn8tzXoRF/NjdwUYfe0MnWoh7fNRLH96F0sDUasSuksc1c/BgEZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPrRA9Eg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPrRA9Eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5471F000FF
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 21:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373296;
	bh=cuU7iDUVNjz66/P7FWp2ZsG+j9S9ECJg0zYFXGseCIc=;
	h=From:Date:Subject:To:Cc;
	b=ZPrRA9Egj3WMNTd5GsfTyJtA5ESANI7/eobJuApg2i2bWvzhAbvdZ5jmL7lz+6Qtg
	 U49Jdnc5O3MogbAqgg0ba1Hs1+FpWRQT93HSIa8vQFim9Gykca1a5gJ9FXmIjw4/eN
	 g6TE89gj2Hn7ktmKJpXZA7bbHfJnKGXgs9lLwdqvjX3nfVQeh4xYQAZHxp7z5gk7xi
	 OHy3MzMWPg9a7b39nzf0ClMBsWMTxDCM04qZRuTIlTMaub+roPh67wwqbjynBhczjs
	 sGmKJnRptOZN7vEMwQmKBYqvUJULj2SEHU4sjIKBpQElR014VU+ZTIvYNCG/zSLAYo
	 D9yf5oaBDk4Lw==
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04be84so1628847c88.3
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 14:54:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxW13zzfcdCnS8Iek97xiWRhQVIAO/CV0EDuu2XjcuiD7GRSr7KDTtjiKydJydlfd0okQk7k9arlszEdcr136b6k1qzRRI=@vger.kernel.org
X-Gm-Message-State: AFuF++n5Y9/q9lpB6oCEMsOrgHDFgP/YP1PVUo099Op0NTGi/F3UETiE
	LkTbmi8Xq/1ovR9TWJ3pPlbAP8La57xCsquOB5fn75lPhRMJ6FUoYefpYGTpgP1dc/Prl5iaWoK
	pRqWnhBTr8Kggei6fenV02rk7thUtXWc=
X-Received: by 2002:a05:7022:7e85:b0:144:ff47:60d2 with SMTP id
 a92af1059eb24-146ce2a0697mr1522054c88.13.1790373296134; Fri, 25 Sep 2026
 14:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Fri, 25 Sep 2026 14:54:43 -0700
X-Gmail-Original-Message-ID: <CAKtyLkFPVY0zBLBZx_9A4f_t2ud3JPR7N=DtJtFuC5AsgvpRnw@mail.gmail.com>
X-Gm-Features: AclHuK86fNR6pYQI7ojQXiBVyVc4SEzAPWtq7CvxM_W04dqbFhtesH6uZSds1nY
Message-ID: <CAKtyLkFPVY0zBLBZx_9A4f_t2ud3JPR7N=DtJtFuC5AsgvpRnw@mail.gmail.com>
Subject: [GIT PULL] IPE fixes for 7.3-rc5
To: torvalds@linux-foundation.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE fixes for 7.3.

This PR contains two commits that fix use-after-free issues found by
recent LLM-assisted code analysis.

The first commit moves successful policy load auditing under the new
policy directory's inode lock, preventing a concurrent policy deletion
from freeing the policy while it is still being audited.

The second commit protects the dm-verity root hash with RCU, preventing
policy evaluation from racing with root hash replacement during
preresume.

Both commits have been tested in linux-next since Tuesday without any
issues.

Thanks,
Fan

--
The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20260925

for you to fetch changes up to 2776e9c28513a1c855a94792b292cbcc533418c8:

  ipe: protect the dm-verity root hash with RCU (2026-09-25 13:30:27 -0700)

----------------------------------------------------------------
ipe/stable-7.3 PR 20260925

----------------------------------------------------------------
Fan Wu (2):
      ipe: fix use-after-free when auditing a newly loaded policy
      ipe: protect the dm-verity root hash with RCU

 security/ipe/eval.c      | 12 ++++++++----
 security/ipe/eval.h      |  2 +-
 security/ipe/fs.c        |  8 +++-----
 security/ipe/hooks.c     | 22 +++++++++++++++++-----
 security/ipe/policy_fs.c |  3 +++
 5 files changed, 32 insertions(+), 15 deletions(-)
