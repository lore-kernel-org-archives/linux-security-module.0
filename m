Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065BB3D953C
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325812; cv=none; b=Ve2+qRG8I2r2WiCTvg69u7+eFj55eKxcZGttULuJSfyPoDuEbIbDjX/WO8B1Cz+qVL+OfVSu/YfZrchCq9CI7wsSzyeYQGmeYDuI3iXclABnh759gF7jIaUG34Q9VVAgXmyDDefrVuVNuxmCC65rM3jW01Igol6xqFWj2OQkmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325812; c=relaxed/simple;
	bh=MLaA97l8p2IZZ8Xe64yutrw2N77FxczzxEeMgMY7QSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRkfhX2d4uI3hxUeUamtRooL+68JoiQixsoc+2z9LujhgHuxuY8aJ6kmGEqFviMN7bDxuLMrC9lJ2EnWDH78hnM49XaA1X/9H+bGgN0vrpXROkBi5xWIr0SslcHXwpxiF5yaXaw1aYUTrtM8xHIsXLEg9Cc7PWupYug9aI2ejFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qB6gBzNz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB6gBzNz"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e8fa1b8d6so80196967b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784325810; x=1784930610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkAx80M7CPkgX1m6JU0rx2ViDCFTK6PMOQlfA80wRaY=;
        b=qB6gBzNzK1GGW7QoLP0/OffnLVcj+zY9JrMBnvkTXiqk7AipnQ+TWY5kHtC7yQrVgS
         CJLhh3onAHdSRvmLHIjEKX0LzNs2eSFiw4yt5IaXRpDdiSXdteQ27UUf8UIltuZXOarj
         TRJZ7WidbE77PqewhRk0ZIe8ola6juTk14O3nVb6OHIOarbD9j4RS8tD+zUaJ15hnQgl
         7U3fNVMiMSRe3t18tkb1+HqjMZ/xqg7ruOzZOhUmYcgU0Qe7Cln2ihwRPBTL/v2moodS
         HTgk+DDcWrZaTW/Na2BaQO76CN828hKJddLurvlAlRMs1hgL9hQmyZR7EiyN/k3SQoEx
         3jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325810; x=1784930610;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rkAx80M7CPkgX1m6JU0rx2ViDCFTK6PMOQlfA80wRaY=;
        b=Zo9U9ivHAxEdZOWCMcFJN1VNiUQM0LptbR75yDzHbCCWUP/a9v9OLnYKi+8Ss4Vu10
         f9kWRXRiTzuiYpBxMdveZNQetkrS9zO2U1P8nO5LfeqZWE3SSaVuseI/6LeoAfy+R/UM
         D8v9T5uK4Bg0uXFFjX7n4HsejjN0H2k8qdUQCjc2i7MiGMCUGZUrt0SJ3l2+g1ikSrdO
         G9BegQKQj3xPfdXI8PRhvdXCnEWBzU4uaHssyPZJB/CN1w578j115aAQT6mWQL9c6xsA
         +X5m5NEdJpXeWtBlAXTiM/7TFMgcjPY/tf/uEgVUUIMPzPPS3duE5WAZ/mAJCOGzbrAo
         RQhA==
X-Forwarded-Encrypted: i=1; AHgh+RogOmndl4VASNaiohzG4HsH8OLa/1I/r49o/Ci4P8flHPl7jLEarMVpdp+g8nrcogm0SuF0XOsCydmJjJuvzJgYi0Ilyjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR29QnHp69LOl8L6LuObXNmezpO0C82/XoBrDJ8KsF49nZH5SW
	CtgUveVQr+ErYu97Q93HxndtL6PNQse+vOTnNrYR5caBjpUiPG2UQHIT
X-Gm-Gg: AfdE7clP4rZpNfGjB6Niw9/45I4X+tg+etTHdIYg7quPxcSZxT5vXQqoGCPRMQcQXYM
	nHlKfCoA3zrsi6iL4IILNvXnNvtP+0VVd38qupwwk8+l3ewcYlfbPCMxR5fK+vVHsSCYkZQ0D91
	M/Zd5HOXmOU2EZm1ux+hCzSAKrfwYVxT2Lop144URZecvoRF3NJ6OEvxTwCmfE7tajgZmTky//E
	Tz1+t5AvJwRSwOABjnzN/PRE7+f8K/T9+hDj9XqnLGHTz5T6px6IHNhnjLaU+tCyUfpREXacKKQ
	bqG4CCpDM+cESBoJf51rk0uJL1ETO/unYAuo0ovIWZ5dxKwfl5kg2f0DcjdQUnzlb+e36brljUo
	H0qBtn2Tu5X9Js8n/GGbS7cxsmcXiuWAHR3G1FSGP0ca8aGPvPsYV/vX9N7Fq3arjGStgFomVmu
	jgGynHvKWWhoB/H9imwovXNxWmx1iJobYqj+I=
X-Received: by 2002:a05:690c:63c6:b0:81e:cf49:99ff with SMTP id 00721157ae682-81ef286ec6emr16513507b3.67.1784325809672;
        Fri, 17 Jul 2026 15:03:29 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:ee56:9b10:53f4:188])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef401728asm20572037b3.9.2026.07.17.15.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:03:28 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 0/3] Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Fri, 17 Jul 2026 18:03:16 -0400
Message-ID: <20260717220320.1030123-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This is a redesign of v1 [1], which added
LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC, a flag staging no_new_privs so that
it was only set at the next execve(2).  Following Mickaël's feedback,
[2] the staging mechanism (credential bit and bprm_committing_creds hook)
is dropped entirely.  The new flag instead sets the no_new_privs
attribute of the calling thread atomically with the enforcement of the
ruleset: no_new_privs is set if and only if the
landlock_restrict_self(2) call succeeds.

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
does.  This also makes it possible to atomically set no_new_privs
process-wide, which prctl(2) cannot do.

Unlike the v1 flag, this flag requires a ruleset: calls with a
ruleset_fd of -1 are rejected.  As a consequence of the fulfilled
precondition, an unprivileged caller passing unknown flag bits together
with this flag receives EINVAL instead of EPERM; the selftests pin this
error ordering as well.

The reason why -1 ruleset_fd is rejected is basically then we are
making a Landlock-flaved prctl(nnp) call that doesn't do anything
special. It seems better to be able to have the option to define
behavior later rather than have a useless feature stuck in the
syscall abi. So we reject the -1 ruleset_fd for now.

The Landlock ABI version is bumped to 11.

Test coverage:

base_test checks that a successful call sets no_new_privs without a
prior prctl(2) nor CAP_SYS_ADMIN, that a failed call leaves it
unchanged, that the flag requires a ruleset FD, and the updated
EPERM/EINVAL ordering.  tsync_test checks that TSYNC sets no_new_privs
on sibling threads along with the domain.

Changes since v1:

- Renamed LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC to
  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, per Mickaël's feedback.
- Dropped the staged "on exec" design: removed the credential bit and
  the bprm_committing_creds hook; no_new_privs is now set atomically
  with the ruleset enforcement.
- The flag now fulfills the no_new_privs/CAP_SYS_ADMIN precondition,
  a significant departure from the v1.
- The flag now requires a ruleset (no ruleset_fd = -1). Otherwise such
  a call would just == a vanilla prctl no-new-privs call. This is left
  in case we want to repurpose it later rather than defining useless
  redundant behavior.

[1] https://lore.kernel.org/linux-security-module/20260708133928.852999-1-utilityemal77@gmail.com/
[2] https://lore.kernel.org/linux-security-module/20260709.Eaphooyoh6sh@digikod.net/

Justin Suess (3):
  landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS

 Documentation/userspace-api/landlock.rst      | 14 +++-
 include/uapi/linux/landlock.h                 | 13 ++++
 security/landlock/limits.h                    |  2 +-
 security/landlock/syscalls.c                  | 28 ++++++--
 security/landlock/tsync.c                     |  8 ++-
 security/landlock/tsync.h                     |  4 +-
 tools/testing/selftests/landlock/base_test.c  | 65 +++++++++++++++++--
 tools/testing/selftests/landlock/tsync_test.c | 33 ++++++++++
 8 files changed, 150 insertions(+), 17 deletions(-)


base-commit: 55f82176ef8dde632ea3eb94a6224950ed809d7c
-- 
2.54.0

