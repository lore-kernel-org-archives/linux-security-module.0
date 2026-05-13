Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E109496915
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688361; cv=none; b=kA03Nrmb/T81s11ETVdUIJSpz2/PwkwqzAvSyPWCPNsCLxuABaSqs2fvZZXJHBDOnCsMQzdw7PmQ/zOiju07kRM2FFrHzzNibPYFhsmlslDwSogX6Dxjwy870QvwXrltqMgIWsRwNwnthHyOKIimwWbkeoLCLAXCM97/se4jIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688361; c=relaxed/simple;
	bh=/o4oTTr2NgVHfdIacsfwX52GgPLpytVIy0CfEovQNz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F+3bigE6qDhKGxkePMnPO1lVqGZssjCrM2yOu5cQkDB5H0BUXVNPB3sq4wBu04p7UFBE8bZLM1mYx2yLU9/rXwJCssgjUFVu63mx5LSoKuQGz4NxZi8plPBB8mMrvO0RtgzA43PwTQ/mWrKXCKRc8YOWTD3QeX9QaVdpoHsAm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kytCh5Qe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kytCh5Qe"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso59009695e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688357; x=1779293157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPk34p2pzcEw2+T+KlGS+mAcpW6C5PjFQM57Z7UVSSk=;
        b=kytCh5QeMoApvxnTx1ljjLFBuyds90Dqb7aclycHVpH9kcdNPNvcf5Hcv1CflFKROp
         r8Wh7rmVlGylfvYs2KljUy/vQ6dNRq1+npb3BP3uX6Gpr7Fk6K1X3l4Cmg/xh0vyRBFP
         5GsT5r5BUZE4c4YgqvGh1Hvgjf8bYUaiIikRhWrlnTh0rYt5r2JYXwJR9H2JmXplQgD1
         F/zftf/MsJAJ28a3yvFnYdhaKH6NGX7+SUU9QPjtiglgKgk+psxFyxWfWZC5/mjwDWDF
         h1F7EBzkES9tVbWfLmCLIBTAaclAc/Kzul3ZPhG5Mp/RIP4Kzk4IxZOMcYbh9g7RFeSr
         HaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688357; x=1779293157;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPk34p2pzcEw2+T+KlGS+mAcpW6C5PjFQM57Z7UVSSk=;
        b=pXSNQ27fSNPP0hieLaEd2IVjR6+OQ7NbZkHHDLyU/2BP1tix1n2vabsEh4iB/8gw2Q
         VHJsplp2yW10vmDlyXOSRwOt7jPosgKQ8zmjtwvx2Cl3q22rVGwgSVHELiY4ZWJAFJiA
         FLdCI+F57E8JI24WPknztdHFUjFhwSbZSl5lK46sb9tG5Xaxilvtee2JyMO0vzadv8kD
         ibXv/evgTAVLcG8Gw3nqUTUcJBxZ7R5fm7QHB6YDLkP9O/He7T39B3gfDcN24wWC+fl/
         B1kiyfM7oaVKI4+y1+iAop59qD6m0edGRVl8wrnCLebScgFUzyot6WyCEbtZn7Sjl/qJ
         9VCg==
X-Gm-Message-State: AOJu0Ywsfz4U4mvpgMAHgYA1RTBi9pFuCtOI1qPI47EtV5FE8mdn/kJt
	MlYnuAWyVGZw4zGM5lfC8D3CSGc9VHG8FNUByFVtIEm7jI2YHdQeSmESX9pERsPWkjzN+8EqbP2
	PyNDhPA==
X-Received: from wmcn1.prod.google.com ([2002:a05:600c:c0c1:b0:485:f1d7:164d])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c104:b0:489:1d7a:4537
 with SMTP id 5b1f17b1804b1-48fd63334d4mr1878425e9.3.1778688356534; Wed, 13
 May 2026 09:05:56 -0700 (PDT)
Date: Wed, 13 May 2026 18:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513160552.4022649-1-gnoack@google.com>
Subject: [PATCH v2 0/3] landlock: Restrict renameat2 with RENAME_WHITEOUT
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

As discussed in [1], the renameat2() syscall's RENAME_WHITEOUT flag allows
the creation of chardev directory entries with major=3Dminor=3D0 as "whiteo=
ut
objects" in the location of the rename source file [2].

This functionality is available even without having any OverlayFS mounted
and can be invoked with the regular renameat2(2) syscall [3].

In V1 [5], it was discussed that whiteout objects are not the same as
character devices, and should therefore be guarded with a separate access
right.  We are therefore guarding the operation with the new access right
LANDLOCK_ACCESS_FS_MAKE_WHITEOUT now.

By introducing a new access right, that change is also exposed by
incrementing the ABI level and does not require a Landlock erratum.

Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The RENAME_WHITEOUT flag side-steps all of the existing Landlock access
rights, which are designed to restrict the creation of directory entries.
It is desirable to restrict that.

This patch set fixes that by adding a check in Landlock's path_rename hook.


Tradeoffs considered in the implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Should the access right check be merged into the longer
  current_check_refer_path() function?

  I am leaning towards keeping it as a special case earlier.  This means
  that we traverse the source path twice, but as we have seen in Debian
  Code Search, there are apparently no legitimate callers of renameat2()
  with RENAME_WHITEOUT who are calling this from within a Landlock domain.
  (fuse-overlayfs is legitimate, but is not landlocked)

  It doesn't seem worth complicating our common rename code for a corner
  case that doesn't happen in practice.


[1] https://lore.kernel.org/all/adUBCQXrt7kmgqJT@google.com/
[2] https://docs.kernel.org/filesystems/overlayfs.html#whiteouts-and-opaque=
-directories
[3] https://man7.org/linux/man-pages/man2/renameat2.2.html#DESCRIPTION
[4] https://codesearch.debian.net/search?q=3Drename.*RENAME_WHITEOUT&litera=
l=3D0
[5] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/


Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D

v2:
 - Introduce LANDLOCK_ACCESS_FS_MAKE_WHITEOUT access right
   and guard it with that.
 - Bump ABI version

v1:
 - initial version
   https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/


G=C3=BCnther Noack (3):
  landlock: Require LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
  selftests/landlock: Add test for RENAME_WHITEOUT denial
  selftests/landlock: Test OverlayFS renames w/o
    LANDLOCK_ACCESS_FS_MAKE_WHITEOUT

 include/uapi/linux/landlock.h                |  3 ++
 security/landlock/audit.c                    |  1 +
 security/landlock/fs.c                       | 15 ++++++
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  4 +-
 tools/testing/selftests/landlock/fs_test.c   | 50 +++++++++++++++++++-
 7 files changed, 71 insertions(+), 6 deletions(-)

--=20
2.54.0.563.g4f69b47b94-goog

