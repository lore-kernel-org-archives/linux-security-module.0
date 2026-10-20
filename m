Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462966;
	b=L9Ma2kvo3JapCofsmDuv6Dw1aw/e2T/JCeb4JEFpBOeZaV3uOTnZBse5M3JQ3SZ0EPFt
	 eQB3yndYX8+j6ksutH/RHYlgcHVSSjSGcX9nFzlh+yYfB1FrIPbvyb41FQmqo4F2Vj+8w
	 4yhMOwBkbbPWQJkjgDQ7j6+AHopBE5iFKEwVNyKucUaf3mb5vqWHkknzQIqoPIKQFRep1
	 /AR8vTZPAPXZt8l1rfxffkAuIbg6daJHK6Qy0hsvsloUKtyHK4osGgsUlh2ayJnwtl63c
	 Lf9AljPwwssCO3N9b8w93kJzXiAHuXQq+3CXl3ZHs+C1m1uPuO0aDw5DOxre3mSI00g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462966;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eI64DZ+ukr7FZWp/2WNMGTkGtr8XOw1qflCT06bI7PE=;
	b=15+i7WTWdKk3wZUhfnib2iC0dNulT/P9Ao1jS8yKf3Rr1H4J6YxyGVouTa+v18bK+wug
	 ORq6R3qUnvcIiPsCd6es2vACBlGHZLNSdRgNoVRbqADonxJI/hIFbrzXnlHvU6hHxFLpL
	 xq1+AHy6erhUlrRUi6TDOZIugvSzlitQBaOJ+bMQNk2ToxY9yiKtueX/XD+GdWG4+sWnk
	 HSsLLVYWeq35Xs4ypq3eDiPtv6uxNmvcL5oKnY8VFOCWXvrM8Y+W4bsgDzKEBeVZqWkvM
	 NshFLYdMuxlXDzXWxs5asF+/EGaU3HCc5BmsGx8P22cNXz+Z/+VONNUxW//ojw6mrzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDQJBgiA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2ED606A319
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDQJBgiA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4F71F000C6
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462965;
	bh=eI64DZ+ukr7FZWp/2WNMGTkGtr8XOw1qflCT06bI7PE=;
	h=From:Date:Subject:To:Cc;
	b=jDQJBgiA232TrP5tV+A18OEWQtfyuZw184HXAcJ0PlhTza2l/si6mq3RTjAKlyMeu
	 xIGtykNH2zYUY4quTgB49XQPDs3jTe8tek9xIb38pQcAgm5iJt9Qi5MmTZIc9M3dvG
	 ceVHr3Hl0PnoluoisYxg1usKy98pxedsqvrWRGWdupv5ch1DLxhsBJI74VyAoZSq1O
	 LTE8hMhTQcPJfMAT3lL+lhsunRyCow3tUSGeelke0IZC5+8xHUYm3kV5/VnowZsea6
	 O70vLM7Q7ar5PWLAHTTWoKt24TwP8yWqjljZ45hnJ/mB3Oyf+ri8yqPXgYcZxVvdJH
	 XtA5r3gF3oJ5w==
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-157fe9d771bso1478621c88.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 19:22:45 -0700 (PDT)
X-Gm-Message-State: AFq9FYIHQtlPFY4h7htOcbo9E0/NitGWdbTtt3MPufZ9pyrdAXgF2hPs
	WW/kQRv4VhAapeYxgkZgQeVlJq2xhZzxelzadPdReLi19M+Ue+FWvCp6T1VhOIa49En8EwCVOin
	6kfrxtyIJG/zOsEjEqNwD3HFd+FeITMI=
X-Received: by 2002:a05:701b:21c7:b0:151:ece6:b171 with SMTP id
 a92af1059eb24-18512c38171mr12004012c88.14.1792462965049; Mon, 19 Oct 2026
 19:22:45 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Mon, 19 Oct 2026 19:22:33 -0700
X-Gmail-Original-Message-ID: <CAKtyLkFZqpVB5+Bvj0OQhVkkRWfQQ2Rh1F_fnDxZfxeMrKo=bg@mail.gmail.com>
X-Gm-Features: AclHuK_ulsMvo3NRF65SP5skc32sV2D3MuD3iJFiTNo86No41tRVlWmCTs3EuWU
Message-ID: <CAKtyLkFZqpVB5+Bvj0OQhVkkRWfQQ2Rh1F_fnDxZfxeMrKo=bg@mail.gmail.com>
Subject: [GIT PULL] IPE update for 7.4
To: torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Seven IPE patches for the Linux v7.4 merge window:

- Fix an extra empty audit record on enforcement changes

ipe_audit_enforce() started an audit buffer but logged the state change
with audit_log(), which emits its own record.  Ending the unused buffer
produced an additional empty AUDIT_MAC_STATUS record every time the
enforcement state was changed.

- Keep the name and token tables in sync with their enums

The audit name tables now use designated initializers, so each name
stays bound to its enum value, and static assertions on the policy
parser token tables break the build if an enum value is added without
a matching token.

- Constify token_default() and correct a comment about policy text
  ownership, with no functional changes

- Fix an invalid sgid value in an audit event example in the docs

- Point the docs to the new IPE website and test suite repository

These commits have been tested in linux-next for weeks without
any issues.

Thanks,
Fan

--
The following changes since commit c03c1a14507dfaf8b856c2608f9ac216021fc222:

  Linux 7.3 (2026-10-18 13:14:58 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20261019

for you to fetch changes up to e2f08fadb48509c239e47cdaf81438c162395932:

  ipe: update the project and test suite links (2026-10-19 17:21:22 -0700)

----------------------------------------------------------------
ipe/stable-7.4 PR 20261019

----------------------------------------------------------------
Fan Wu (6):
      ipe: constify token_default()
      ipe: use designated initializers for audit name tables
      ipe: check parser token table sizes
      ipe: correct policy text ownership comment
      ipe: fix enforcement audit
      ipe: update the project and test suite links

Manuel Ebner (1):
      ipe: fix invalid sgid value in audit event documentation

 Documentation/admin-guide/LSM/ipe.rst |  6 +++---
 Documentation/security/ipe.rst        |  2 +-
 security/ipe/audit.c                  | 52
++++++++++++++++++++++------------------------------
 security/ipe/policy.c                 |  2 +-
 security/ipe/policy_parser.c          | 10 +++++++++-
 5 files changed, 36 insertions(+), 36 deletions(-)
