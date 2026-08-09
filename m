Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF71C5F1B
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290350; cv=none; b=PZKuaqBiHPjMFCBAgCXfYjy/elFbQk+B0zAYxX+BjuA0RXCesOCaAnP3rp1jLYg0WuHGndNeIz246t1idt8NWPxdzBNzvJvjNQBf/LPuQylsIhd5ivqI7OWSJNlcv2o0SqGnS+9CFJTd2AzTK/r8uOu5/eb+I9FVqhKHJG6SZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290350; c=relaxed/simple;
	bh=ysnBicCDwxuO81IecwMGK1tcJiUcuObz1V1IN1LAf14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mITk6dQvLeUE/FMYVE8AC4q9ebr6+I3/GP+vO5a7wmhWSwfQEQMNUQ0Q6gbh5TKVbF7+kawk5rpUJ8ORCJr/kovG6Y6nLnaP+ResZCH9z8kXoREs3mH4wYuNzq09X4v4AdMVpEMqWjtIw0yuhm8Xn15448HbPI2JmdZvEuR/8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPxFqeg9; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPxFqeg9"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66ac4d40da4so1562372d50.2
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786290348; x=1786895148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNmZ44RSWlW8pQ+b91zrT+hdXn4Kmnq58HEKWqOPuH8=;
        b=pPxFqeg94gwt8ApXbCG8BfwyElgilyIHlampedc4wFC/DJip/4i9k28uqz31167BVq
         zfAVxtZFod2yABbgOYU8+ZncmdQKNAYd3fqzxcsdgw86V5aO/pv2PBI0z1kSGMM7Pswh
         BSVD4ubNk/FrF7F7XsRQ6DwLkMVWr/Z1r0Jmpsh5vN7HqKbteeC8C0J+G1wxPkDjGPBj
         4/xo5DEsQJcEaEPyVnAJEDoMQmI1SOU62ZWdCHYBzn5MkPZlW1Jpxn+rlfjCvwAb3Y79
         lwLd1HBt9VFaSBgxrvQauyW2SvKHass61Qv18nGJltf52QXEp4Pk3blhUFr7qQG/wCjI
         MlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786290348; x=1786895148;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNmZ44RSWlW8pQ+b91zrT+hdXn4Kmnq58HEKWqOPuH8=;
        b=HlGHlF81Cv9sreTAYdR8Tuh2m9IxjGyktnf4+xjzJpbekynwhFkpPopi8zFO/Hl277
         Tk3ZZTjuFPKKx5zSBXaYgMJyM+Y04hZn1e+HQHtV0UxtehqUdixMKJ0pjwl/yn2XjJOD
         XUk4AKNH9et40SnMTwN0qVlMfaKUmckhqiZQTF1+5lr6Xd/J2kRkBkCYdgMj+4nojB77
         KoR/A0YDvHfxg0x0NMgSaQZ/2NtQrPpxFY9YckNwwwvs+r9xqehggw6kQCMPbvz5NqnM
         Cb6CxJ6aKB7YQp0otGIc2rasKfb3WIINb0ZvdSwoKxJHoXrOvSobOK14IdYbJ+DbrfSd
         /ofg==
X-Forwarded-Encrypted: i=1; AHgh+RpqtYytZjSYceHuNp3+BnwvPYiRBgizrhgKATlDXvRGft2xMxS4zm5je7/Y5WsRCcQvaH/cAySx8Mts1tQKlnJpsrY3rSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVrktvdghzQnEglOr0Hw6Tl1n7zMAASpeQhNBM4a4qnyiyMZS
	516Q3LCzQow6PBTjnLBdgemo55ztNad/0/0eqRzsqM9UyDxg2uQIS5uy/mT2iYUc
X-Gm-Gg: AR+sD139LlP9E20W7Rz2ClS1qgcz+zwncXo0lXG2FyiGo/frOwd12CuBP8c7PoAvQVN
	AtmEmHDJOut0+Z4Wuq9eWaVAVu4B216FRWgbh/9ZHzNbTMFi4ertOftxzgI7Vimc0vFwZHoZrwp
	8Z+1UeMuZvL2+lla9B14saQO69vSRxwaMOnj0a9y7m7vzmVpZCZW2+n4j0OVjT34OLulEvQEwDU
	k2pTOkux4/TkzKIZjiJOoiZRu0Nd11xwDR57n/pzuUAA0L+aT4BcdpVOv5ucJLBMj214xHUGFJd
	OsXjPzFTx8KaHCS0p76Vxk0YMZfVr1Kc2aXWUGqYfl0q50iXHOJ6nrTrBQPhJ6tCdGTjw0qf9TS
	zKbEbY2rQOQ8YKhHgWmW2Ep9IUVjwCQBVqvoFIQMhE2PEcF6hCwBdi1o36grQl5BKgD1eeQQ5yd
	xJrI2bhGJmtQqkC/85gEywhkRzeLhbus6k+cyxnVJYZ/hsQ+TfH4WLzhteyOo79NACVg1EHhQ1N
	04GLxS3WqQ49B3E2WWDZ+5HTVDysHbujw==
X-Received: by 2002:a05:690e:408d:b0:667:c09c:4a40 with SMTP id 956f58d0204a3-6699ab8eaf8mr24054809d50.51.1786290347851;
        Sun, 09 Aug 2026 08:45:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbea9sm4838001d50.3.2026.08.09.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:45:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v4 0/5] Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Sun,  9 Aug 2026 11:45:18 -0400
Message-ID: <20260809154544.1253100-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Howdy

This series adds a new landlock_restrict_self(2) flag:
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.

The flag sets the no_new_privs attribute of the calling thread only
once the enforcement of the ruleset succeeded: no_new_privs is set if
and only if the landlock_restrict_self(2) call succeeds.

Semantics:

A single call replaces the usual prctl(PR_SET_NO_NEW_PRIVS) +
landlock_restrict_self(2) pair.  Because no_new_privs is set by the
call itself, the no_new_privs/CAP_SYS_ADMIN precondition is fulfilled
by construction, so the flag is usable by unprivileged processes.  This
is safe for the same reason the prctl(2) pair is: the executed programs
can either gain privileges or be restricted, never both.

The two states cannot diverge.  A failed call (invalid ruleset FD,
E2BIG, ENOMEM, interrupted TSYNC, ...) leaves no_new_privs unchanged,
and a successful call never returns without no_new_privs set: the
attribute is set past the last point of failure, right before
commit_creds(), which cannot fail.

Combined with LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on all
threads with the same guarantee: each sibling thread sets it in the
commit phase of the TSYNC protocol, after its all-or-nothing barrier,
so either every thread gets both the domain and no_new_privs, or none
does.  This also makes it possible to set no_new_privs process-wide in
one call, which prctl(2) cannot do.

The flag requires a ruleset: calls with a ruleset_fd of -1 are
rejected.  Such a call would be nothing more than a Landlock-flavored
prctl(PR_SET_NO_NEW_PRIVS), and rejecting it keeps the option of giving
it a meaning later.

Following Mickaël's feedback on v3 [1], a new preparatory patch first
moves the no_new_privs/CAP_SYS_ADMIN check after the flags check, in
the same order as seccomp(2).  Unprivileged callers passing unknown
flag bits now consistently get EINVAL instead of EPERM, whether or not
the new flag is involved; the selftests pin this error ordering.

The Landlock ABI version is bumped to 11.

Test coverage:

base_test checks that a successful call sets no_new_privs without a
prior prctl(2) nor CAP_SYS_ADMIN, that a failed call (invalid ruleset
FD or layer maximum) leaves it unchanged, that the flag requires a
ruleset FD, and the flags-before-privileges error ordering.
tsync_test checks, through variants of a common multi_threaded
fixture, that TSYNC sets no_new_privs on sibling threads along with
the domain, and that a TSYNC call failing on the layer maximum leaves
it unset on every thread.

Changes since v3:

- New preparatory patch: check the landlock_restrict_self(2) flags
  before the no_new_privs/CAP_SYS_ADMIN requirement, like seccomp(2),
  per Mickaël's feedback.  The EINVAL/EPERM visible change now stems
  from this patch instead of the new flag.
- Folded the minimal selftest changes (ABI version, last-flag, and
  checks-ordering updates) into the main patch to keep the series
  bisectable, following the commit tweaked by Mickaël in his next
  branch.
- Dropped the set_no_new_privs local variable; the flag is now checked
  directly at both use sites.
- Turned the multi_threaded_{success,no_new_privs,
  no_new_privs_max_layers} tests into variants of a common
  multi_threaded fixture.
- Reworded the documentation: removed the ambiguous "it"s in the
  tutorial paragraph on CAP_SYS_ADMIN, and used the suggested
  "call (or CAP_SYS_ADMIN use)" wording in both the compatibility
  section and the uapi kdoc.

Per-patch changelogs are below each patch.

[1] https://lore.kernel.org/linux-security-module/20260803223109.707353-1-utilityemal77@gmail.com/

Justin Suess (5):
  landlock: Check landlock_restrict_self(2)'s flags before privileges
  landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  samples/landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to sampler

 Documentation/userspace-api/landlock.rst      |  47 +++++++-
 include/uapi/linux/landlock.h                 |  13 +++
 samples/landlock/sandboxer.c                  |  16 ++-
 security/landlock/limits.h                    |   2 +-
 security/landlock/syscalls.c                  |  35 ++++--
 security/landlock/tsync.c                     |   8 +-
 security/landlock/tsync.h                     |   4 +-
 tools/testing/selftests/landlock/base_test.c  | 104 +++++++++++++++++-
 tools/testing/selftests/landlock/tsync_test.c |  96 ++++++++++++++--
 9 files changed, 283 insertions(+), 42 deletions(-)

-- 
2.55.0

