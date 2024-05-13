Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5B78283
	for <linux-security-module@vger.kernel.org>; Mon, 13 May 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629636; cv=none; b=DGLxyYm1WvEoEcrxGOozsx9CV5WXR+IIX3vK+PXJQgKPCX1+/ZOQ0dQsWoWQVpT4hXU5WyW2ziOegnlBJVwR788rjZOZgUd5xs/MRDGf/NxJM/cYXjQLP1q00vl426uNAD3gTfBdZiWHot3o/u5JBr1bczQn2XN42+6iKHNpyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629636; c=relaxed/simple;
	bh=abzpbAIsGffQZOkQa0awGau3E+v6Yze3gFJC/Iqx9l0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=NnbzIAJ8Etq8Ulc71P6X1XXH0vM97G6hSMwJy0IKAOFodZTktzjfzA+SC00DTYdcreTuX6IHNi1CLfqOA8TwzXUMDSD/oFtXKCbKhy/SYO0M0poPJiq8XUovCW0++TKDUrBn5t6wiz9zWNY5Rf4Goa3OqS9k+FSayUf1KAGQ9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SD4eiciR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SD4eiciR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43e06d21a06so24204061cf.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 May 2024 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715629633; x=1716234433; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPAXonk62bozSvr0eSu1klLU+I6EFV7iB0W5dHC6XiI=;
        b=SD4eiciR7hVomzdJwU+AJgkWpMZYYwRYeDrME1P3huKBTwfOgSTJ3wnCmLPw7RC30h
         zZ32DCWSqHXTIo6+720HNd5Jeo0UxroXEQY/vCyaiubOFRr1GFf7KeQvJsp1eU/tKYJV
         T4fIt6OPUWJg3WOKc5ppVpRGirkURu2l7fTr3y5N+udKk9qLtIUcFoGRIfh97GOgSQXK
         UM5O07e/imgSb0/PvM0foIxHTwVoDx9e5xG8q1R16bwucposikElKPi4ds2fgOnWjD60
         t5ME1RBQeHxeD8+kRRw3WAoJDmbWmkL2bEGS+aWOBCKjjX/bC6CPJCnPjKx6ke+xUOku
         KgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629633; x=1716234433;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPAXonk62bozSvr0eSu1klLU+I6EFV7iB0W5dHC6XiI=;
        b=qz+bGTG/DJXLa0i+1+iCxJ6xcfZkkRwt98lyIw6QcZ1Od4TDKwsuCRz5W+YbO1r5vZ
         M+HFfrMyjnn8baboRCZAeIlWSyBpg1WZvQtHfONDUlSfbSsozhsgFUsEG+yWDpYwVfb6
         7Jo0BekCanuXjpqF7RCCQjf4O6Tne8OAbCKUKkdSN6U5VLPwtuRlgyK2pz8gO3dtZq/c
         T98nQlAqRFzbxIONk8cVIg6yNWtJ3i6YNf/I9DuJs6isC3HCIRyx/V5pxZU6AZVeQgcm
         gcBIDnVZv2t+3SZbQUXfhFw7h9AnUaV4deriSuG5G8xwv7vATb6T/v48n7IXiee6deQt
         VtBg==
X-Gm-Message-State: AOJu0YyTKoUjQqNqhdx3oe1fDVXQTuefMFImsDu0CTg6mSNldbs1uyLs
	wwHZPyQj1tms9X0CZdd+4XehBB9ebtgtz20f1exUWDZW2f0ZlhUHAtrzGjj5tQ==
X-Google-Smtp-Source: AGHT+IE45Lj4C6YXKvuuRhlkZ3gkoUCzPlmS1mjfW7AJ5KkG7So4V6WMEY+Smut2GJdr40+/DM86QA==
X-Received: by 2002:a05:622a:64f:b0:43a:a965:b0f3 with SMTP id d75a77b69052e-43dfdb4915dmr128250611cf.49.1715629633462;
        Mon, 13 May 2024 12:47:13 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54b58c0sm59974371cf.9.2024.05.13.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:47:13 -0700 (PDT)
Date: Mon, 13 May 2024 15:47:12 -0400
Message-ID: <eb9e94532b792619e4161de6c0a397db@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240513
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Three fairly minor patches for the current merge window; highlights
below:

- The security/* portion of the effort to remove the empty sentinel
  elements at the end of the ctl_table arrays.

- Update the file list associated with the LSM / "SECURITY SUBSYSTEM"
  entry in the MAINTAINERS file (and then fix a typo in then update).

Please merge for Linux v6.10.
-Paul

--
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240513

for you to fetch changes up to dd80c7465029dd0671e6f9fc2678ae0fbdf785ac:

  MAINTAINERS: repair file entry in SECURITY SUBSYSTEM
    (2024-05-07 10:56:15 -0400)

----------------------------------------------------------------
lsm/stable-6.10 PR 20240513

----------------------------------------------------------------
Joel Granados (1):
      lsm: remove the now superfluous sentinel element from ctl_table array

Lukas Bulwahn (1):
      MAINTAINERS: repair file entry in SECURITY SUBSYSTEM

Paul Moore (1):
      MAINTAINERS: update the LSM file list

 MAINTAINERS                | 4 ++++
 security/apparmor/lsm.c    | 1 -
 security/keys/sysctl.c     | 1 -
 security/loadpin/loadpin.c | 1 -
 security/yama/yama_lsm.c   | 1 -
 5 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com
