Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6882E7378
	for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121024; cv=none; b=BCKYHO7YuAjK07ftD7GOJmVup7jmMS9g7d+VJj2x88ZGmZB8OX7EzVlb8WQrjCycUftHFF7EdCZO4KZO4d+lZoLCpGDxBy2Zh6yis2Y9XfXQmqvzwGylfdwm3rMAet8jpnUNeG+NSF4lnHcGD2UbO9u3ngQp/nrLOsBDL6R/JuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121024; c=relaxed/simple;
	bh=izBMh7eVZhkWs1WnjxZ/AvcCI4mp9b+oIlFEmuKE7Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZ/sAKBzhi05z7/vmiYySjTaXkI/omzRJMWSNKuytGD1PVNXCXIDOnf1TM8QEM+TLYF/bsHSY7rg0ASCG0R+PdLxlImVKmdGmJDKere1JBg8o9IeRnOOKjbyMonGKk7xxrZgsUadBQ09TFhFy3Nct0xt8xVukjs1/a7q/O75vmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k62v4C+E; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k62v4C+E"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso18019335e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 30 Aug 2026 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121021; x=1788725821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRVinZDK/Gxcrvk2NhV4IrbRKPZZNwFZwWSNmf32j2I=;
        b=k62v4C+EpxXgltqaqTq/3Kw5vjMNOyz70pSJcS3NSRi1vTN0bfP7oXcASvo9eAg5AN
         LeYAI0epzXKLm3dGWz2omfDp1/nzcQTEXZZ+SEPI9n5aI3cGjLgMKeQjERV3gOkuT8on
         1HfBEGe94vD8AHWJMuQylJC+PwpdFg6znYjWDNSgNuAQLGIq/5dl0dGNU+mZgyQ7VmvU
         lbC3ED1rh89iuHe/cRpDbRqyujyKmPSolp86MgoQLCmJcH1jIMshrG2h+VwykskOmjBo
         EcbxBDFQBWy6wLwSoRqx/yoZdZTnSmrpFzYcbmnyskmFmFbHf3bGmZd2K6t9ofOQAiX5
         SoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121021; x=1788725821;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRVinZDK/Gxcrvk2NhV4IrbRKPZZNwFZwWSNmf32j2I=;
        b=FC8P9c8JSBtLOgfhAKTjDSKO2aFXhXWiolvV7iyOb4sZy+jHo+Rim/PzGlXUH4vX4P
         0gwJ1dNk/13qRv790U3sPvzS/JHKXx1dmYF3snsMV2zGiq2J3NFb1/kg8skqU8Bk38Ot
         lqZW7mykpEdWN8MEipBbD6ZDuDjZ/4joZTTFqlOLoEMFIV+pMczyDbLlyQ6Wi74fc1Fa
         61SdCLxlR3jsNbn+34OaDV+EByC97bzL9I2ifoNZC8H4bJxAFYYgSQ8XYP81PA0ZKw9A
         IMtBillAeIvlzsjfIePkofP7N+gzEnbpQSYex58QC7imX5NCBn9Vph+jC6c0DpZEP+8T
         hWWA==
X-Forwarded-Encrypted: i=1; AHgh+RrtrcuMIfzEZQ4prQx3VLbIFEjXsbg4oLs82upYnu8E0diXauYNAcajPyhuFaYp/t4hNQ5wAP5tiLnNg/cUXaZjJAUK7HU=@vger.kernel.org
X-Gm-Message-State: AFuF++mVr+4F8B+lP10UEmq72jSnkLaZ48uloSHtN2l+zXB7GUfZtB0N
	TA+87t8KaVhUMc5QtQCacKSiWWuF7MHmAUh+0l9A4vsKSztujIXKxlJF
X-Gm-Gg: AR+sD11sMGJaC6aZbRDinwbvqbhlKUyMQ1xbByBA9zJLUE6JYjsgp9z1n5HxlfY8ysz
	txEwCgSXij+pkyXnoxA3VAgth6yhuMkoRbWbBjQ26tWwIX5QQbsRSGMVVzzzEmG1SEL1Bs2+g0y
	v9oWRvDW6i6M5v4Ns1KSDpicpRZO334n5aDgWOg4qPe5lKaUK+yeXzGoFpKu6ChEqcYWY26gIvd
	xa7eoTVvaNgba+qlkVZqMK3tYQ10rDmDpSkMhXFlV6qAlewqSIAfRPXI1jo/wPPrT8OQKVqvpZM
	iXwos92S0B5u+QzCBXjNRKtsoWOpQXFn8OFbhE5jcjjK5TgAbfgOh5W3hqFLJ/83jFp4kfIQbcg
	2iAYbpaYpZc6gm03kCnDyljOerNnMIeyuacHuYC6krs2IXoVry2l887DKqr+H50bEaiBusSj+zp
	ihiFdJ7J3TFWbhP642cKa9cF38cljZyPq3gUfw83ZEsgLRg9M5ZPdfCDy7hopDFP42fgDUsRSTt
	lOMFArFYeYzTdSYGyFOA3MW2A==
X-Received: by 2002:a05:600c:4ecb:b0:499:d95a:44d with SMTP id 5b1f17b1804b1-49b91bd885fmr303712975e9.0.1788121020425;
        Sun, 30 Aug 2026 13:17:00 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c44feb966sm205868655e9.6.2026.08.30.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:00 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 0/6] landlock: Support MPTCP bind and connect restrictions
Date: Sun, 30 Aug 2026 22:16:44 +0200
Message-ID: <20260830201650.67050-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch set makes it possible to restrict MPTCP bind(2) and
connect(2) operations by port, adding the access rights
LANDLOCK_ACCESS_NET_BIND_MPTCP and LANDLOCK_ACCESS_NET_CONNECT_MPTCP.

Motivation
==========

With MPTCP operations being unrestrictable, some aspects of Landlock's
existing TCP restrictions were not useful.  Notably, bind(2) and
listen(2) on MPTCP sockets was possible, sidestepping a bind(2)
restriction that might exist for plain TCP sockets.  This patch set
fixes that gap by restricting bind(2) and connect(2) operations in the
same way as for TCP.

As listening on MPTCP sockets is backwards compatible with plain TCP,
it has gained more support and has become the default in common
networking libraries such as Go's net.Listen() function since Go 1.24
[1].

Historical background
=====================

In the initial implementation, Landlock's TCP bind(2) and connect(2)
access rights worked on IP stream ports independent of their protocol
as specified in socket(2).  This was corrected in Landlock erratum 1
in commit 854277e2cc8c ("landlock: Fix non-TCP sockets restriction")
[2] [3], but also meant that MPTCP sockets were now not restrictable with
Landlock any more, even though MPTCP operates on the same TCP ports as
plain TCP.

That MPTCP should often be treated the same as plain TCP was also
pointed out in [4] and [5].

Implementation notes
====================

* The tests are an extension of the existing exhaustive TCP/UDP
  selftest coverage.
* MPTCP subflows are separate connections with their own port numbers.
  As it is the Linux kernel which negotiates these ports with the
  remote system, the ports used in subflows are not subject to this
  Landlock restriction.
* MPTCP Fast Open is treated the same as for TCP.

Apart from these, MPTCP support is a relatively straightforward
implementation, mirroring the TCP logic in most places.

Alternatives considered
=======================

Making MPTCP sockets subject to "plain TCP" Landlock access rights is
technically feasible, but would undo erratum 1 [3], which could be
confusing to users and might introduce potential incompatibilities
with existing programs.

Open questions
==============

I am on the edge about the helper functions that I added to the
selftests; maybe would be better to flatten these decisions out into
the fixture data for improved clarity and to not run the risk of
reimplementing the same code that we want to test.


Let me know what you think!
–Günther


[1] https://go.dev/doc/go1.24#netpkgnet
[2] commit 854277e2cc8c ("landlock: Fix non-TCP sockets restriction")
    https://lore.kernel.org/r/20250205093651.1424339-2-ivanov.mikhail1@huawei-partners.com
[3] Landlock erratum 1, security/landlock/errata/abi-4.h
[4] https://lore.kernel.org/all/49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org/
[5] https://lore.kernel.org/all/1d1d58b3-2516-4fc8-9f9a-b10604bbe05b@kernel.org/


Günther Noack (6):
  samples/landlock: Implement best-effort fallback for network rules.
  selftests/landlock: Generalize net test helpers for multiple socket
    types
  landlock: Add MPTCP bind and connect access rights
  selftests/landlock: Add MPTCP network access tests
  samples/landlock: Support MPTCP access rights
  landlock: Document MPTCP access rights

 Documentation/userspace-api/landlock.rst     |  27 +-
 include/linux/landlock.h                     |   5 +-
 include/uapi/linux/landlock.h                |  24 ++
 samples/landlock/sandboxer.c                 |  72 +++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/net.c                      |  68 ++--
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 341 ++++++++++++++-----
 9 files changed, 425 insertions(+), 118 deletions(-)

-- 
2.55.0

