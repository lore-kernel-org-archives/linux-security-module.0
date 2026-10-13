Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509351DDE9
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910097; cv=none; b=Nrcl/NmNH2hCVsS9qe9jvNsvPEEQ3P0nwrde8FB6CzGNsHKUY76r98SenMA/kPYZb7RnKo9dCs7ajAQO0pJLIvXYVLqqnPREiBMAklxOOg1xdvm/uofu+AEyNqYOYTS5YA/1ZHT4zitpJGS0+Leb7giLNJYBhWLFedsFy4M+g24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910097; c=relaxed/simple;
	bh=fxGS0KDBWStjrqyKtmCx3JA0nIxD5douxgGJQijWt4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXo9kZ44xTmU1sFq22ELPjowbOuZEzw1PVRv1+KHFEG/MvFhodmvheXzWh5f0XhxncAjjXEPQMNBwqe4F6iNuygg0ph5iWidnZSx/dJdCA6izNgzSdQUZVKntXhquaKGbZZ1+OqUUQTjr9TYgnDwiq1oj1dnQnH+Mj7OD6foYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At4VtRdY; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At4VtRdY"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6776efd4ff1so2684087d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910094; x=1792514894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F/tCO70XLvBQZ+VECtj2XSlthzSz2vi6dAShJcsMRWs=;
        b=At4VtRdY3S/4VyjeBEk4k0oigcfYvJeXrsJmEbFJ8sbbQqJ1LEH+P8+kroUbWFdH+1
         s4fYPclCWVhFG/pVo0PzOEJXWU5VY8cMHA/H3k/6LD4roIV+YX0rM4+0qrk8zafCGNdy
         M5bPNpsB+TLUY8j3X94X4HcT/Eny1Ml6y7rQ7BXCDSq/IT9Vt6Fw/T1QrOqzCwAcfJBh
         4IK+3rM8veizHNGr6Nh9hrhOV9W6Aai8Ki/3FxcePdau//2Rg50qsSKmVAADpCsXUX7s
         +iXo423ah42PUn6PdrknaN8fowULFc7KVuS7u8s1la4hhtIpSyXtcGLjVF6ZHzpz/lcp
         qsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910094; x=1792514894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/tCO70XLvBQZ+VECtj2XSlthzSz2vi6dAShJcsMRWs=;
        b=EVsHBqL6Je07Aszv2yuZUK8QA8yr5k7lRiG88lbxDQqRHmRitY36vlhb7gGm2WIRY9
         Lu75DsqQyNF2adz/YMFlch3CUQsTQ/vI+v0EGyzP1MIh5S83IxadZ/aWBDStPGKUGc2F
         21nou2SLN6rc4lpttG29MeAL9qB2h/enmWkrbUazo3wMKSS2Jtv1dD8GFL91wsT9shNL
         TAg4dwF8ZdDueN2DeaSfdzFctcqj0FJJeLR07IlzyE2y5/lbpTpvMgOH3yP5n5Oo4r9j
         +CD4T9Mq3XFw0uLgEsLbYbwQqqg+ptaPoYR9UJEC/mHDUG7Hjji5nMMbvHNWF7y7c6kI
         zAMA==
X-Forwarded-Encrypted: i=1; AKwUvBwJYL4hUAGj7x9n8DZBAZdtJvNQSqFmFkANEFlG2hb3ve4MihWB4IJO/5Zf7BSt8EcK3NUKGRtDWw3HwTVYQ9YtA+ncuXU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUPFKHPyMoOy9LElCeqfID1x/djRqwcpg5BkkQyH34TMNfDmdF
	RgOeQM8a4tIiLH+XJ8aIqzrRv0m9OchiwqI2H8tCG2KPvVq2hFBrlOzn
X-Gm-Gg: AYBFou3KvNI9YoMPdYZDJ546+8npPcJIBFPTfPaRJo5Zk18N+jYT/qrlwN8OliEBn9B
	Xgsz3SLNkvK67tz7uXABjGgzLHnnEImpjrGutYvy9hobr5znUr+Fxx83MC+D5i2IGU4cxdjN8KY
	JmZ7fpyYgWYLXhw+jcBF+RauXdOJss0V9K1Dop5OL/D4Xd2RlAlA5s4e7A5El0fhocL6UYGzi1S
	38ENUhGW6/EXKSULWJoFWmJmicFnTmd0R4rZfbd0ayFZdhLKgt/rnm7bEQIvyMvM07NSwigjRFn
	wQmZVkFYlqMvXuJivY7n7+AZY6SR+FeqVxtcbie8NGHeZeeF+gXMbpQqsIByit9Hz/NhrIxr250
	HTxZguKB2eAvmxjXnlBSbFA1NarzstWknA+FOH14NYBPJHY7m4zyKYBs5zsWr5l0+ralvSWHwrJ
	uXuSxLbzfe+9m9IKTlAlGk76b8n2SnulbPjG3c6VFSkIvyOeYMRKfQZCLUmz0rKT7cj0R3bvMx
X-Received: by 2002:a05:690e:1383:b0:671:7e90:70f4 with SMTP id 956f58d0204a3-6793678d44dmr4486938d50.10.1791910094243;
        Tue, 13 Oct 2026 09:48:14 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:13 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 00/11] fs: unified VFS ancestor walk for Landlock and BPF
Date: Tue, 13 Oct 2026 12:47:49 -0400
Message-ID: <20261013164800.2906577-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Howdy folks,

This series adds a VFS API for walking a path's ancestors that covers
both path-walk modes (refwalk and rcu-walk, plus the hybrid walk)
through a unified interface, converts Landlock to it, and exposes it
to BPF LSM programs.  It picks up Song Liu's bpf path iterator series [1]
where the discussion left it, and tries to be the synthesis of what came
out of that thread: a combination of the callback and open-coded approaches
proposed there.

The structure is unchanged from the RFC [2]: a stepwise engine private
to namei.c, a callback front-end for in-kernel callers (Landlock
is converted, fixing the follow_up() race Al reported, hence the
Fixes: tag on patch 3), and open-coded BPF iterators over the engine in
referenced and rcu flavors, with bpf_path_ancestors_legitimize()
escalating from the latter to the former mid-walk.  Patch 1 is carried
from Song's series.  See the RFC cover for the full background and API
listing.

This is v1 following the RFC and bot feedback, and some of the sillier
mistakes are rectified.

Biggest change is that Song's patch 4 adding BTF_TYPE_SAFE_TRUSTED is
dropped, following [3].  This code wasn't an issue in his original
patchset, because that implementation was refwalk only, whereas this
one handles rcu-walk.  The problem is that trusted types acquired under
RCU don't propagate their RCU-ness to their fields.  Thus marking the
path trusted allows you to use the dentry from an RCU-acquired struct
path outside RCU.

Verifier fixes propagating the RCU-ness to trusted fields can be done,
but it's best as a separate series where the idea can be examined more
closely.  Then marking the dentry as trusted will allow you to use the
dentry xattr kfuncs.  Nothing in this series strictly depends on having
a trusted dentry, nor will marking it trusted require changes in this
API.  See my follow up [4].

Other changes since the RFC:

- vfs_walk_ancestors() is introduced already built on the stepwise
  engine, and the RFC's restructuring patch became a pure exposure
  patch (patch 4): the engine is no longer rewritten mid-series.
- vfs_walk_handover() carries the position's flags over, so an
  escalated walk no longer drops VFS_WALK_POS_MOUNTPOINT.
- A failed bpf_path_ancestors_legitimize() marks the destination
  iterator with BPF_PATH_ANCESTORS_RETRY instead of leaving it
  indistinguishable from a walk that completed at the root; a drained
  source returns -ENOENT, a lost race returns -ECHILD.
- vfs_walk_start() warns on and masks unknown flag bits, which the
  engine shares the flags word with.
- mnt_undo_legitimize() asserts it is called inside an RCU read-side
  critical section.
- Selftests verify the walk actually reaches / (position count plus
  end-of-walk flags), use an acquired position only after the iterator
  is destroyed so the program's reference is provably what keeps it
  alive and retrigger when a concurrent mount anywhere in the system
  legitimately ends the lockless walks with RETRY.
- Stale comments and kernel-doc contracts fixed; notably, rcu-mode
  callback reads race with concurrent changes exactly as in a
  referenced walk, now stated at vfs_walk_ancestors().

Stuff deliberately not changed:

- vfs_walk_handover() validates the seqcount before taking the dentry
  reference, the reverse of __legitimize_path() [5].  That ordering is
  what lets a failed handover leave nothing to put inside the caller's
  RCU read-side critical section, and the window it opens is
  indistinguishable from a rename landing right after a successful
  handover, which any referenced walk tolerates anyway. This matches
  behavior with in-tree existing rcu-walk implementations.
- A callback that stops an rcu-mode walk gets no final seq
  revalidation [5].  This matches rcu-walk practice: may_lookup()
  returns hard verdicts from RCU data without one, and d_walk()'s
  D_WALK_QUIT skips its seqretry.  Keeping a position is what
  validates, via the handover.
- An "__uninit" iterator argument is marked initialized as it is
  processed, so a later "__iter" argument of the same kfunc aliasing
  the same stack slots would see it as initialized [6].  Reaching that
  needs a kfunc whose "__uninit" destination and "__iter" source share
  one iterator BTF type. The slots record the destination's type, so
  a mismatch fails the "__iter" check regardless of aliasing, which is
  what makes this immune.  Answered in [7].

Landlock kselftests pass in full (914/914 under UML) on this revision.

[1] https://lore.kernel.org/bpf/20250617061116.3681325-1-song@kernel.org/
[2] https://lore.kernel.org/bpf/20261006002020.2890858-1-utilityemal77@gmail.com/
[3] https://lore.kernel.org/bpf/efdfa80872c26e9e1b6fe11957ecba8e1b5ffcdad421e34281ed3ebd017b5752@mail.kernel.org/
[4] https://lore.kernel.org/bpf/asUBWNVtSzLXkXsF@zenbox/
[5] https://lore.kernel.org/bpf/20261006003305.44F761F000FF@smtp.kernel.org/
[6] https://lore.kernel.org/bpf/20261006003716.CC7791F000FF@smtp.kernel.org/
[7] https://lore.kernel.org/bpf/asUK2i4229DNzXLI@zenbox/

Justin Suess (10):
  namei: add vfs_walk_ancestors()
  landlock: convert ancestor walk to vfs_walk_ancestors()
  namei: expose the stepwise ancestor walk to fs/
  bpf: add a path ancestor iterator
  selftests/bpf: exercise the path ancestor iterator
  fs: add mnt_undo_legitimize()
  namei: add an rcu-walk mode to the ancestor walk
  bpf: support "__uninit" iterator arguments in generic kfuncs
  bpf: add a lockless path ancestor iterator
  selftests/bpf: exercise the lockless path ancestor iterator

Song Liu (1):
  namei: introduce __path_walk_parent()

 fs/bpf_fs_kfuncs.c                            | 248 ++++++++++++
 fs/internal.h                                 |  22 +
 fs/mount.h                                    |   1 +
 fs/namei.c                                    | 380 ++++++++++++++++--
 fs/namespace.c                                |  65 ++-
 include/linux/namei.h                         |  17 +
 kernel/bpf/verifier.c                         |  44 +-
 security/landlock/fs.c                        | 266 ++++++------
 .../selftests/bpf/prog_tests/path_ancestors.c |  86 ++++
 .../selftests/bpf/progs/path_ancestors.c      | 146 +++++++
 10 files changed, 1098 insertions(+), 177 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_ancestors.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_ancestors.c


base-commit: 763187dbbf83764a57d5811168ef9de7b9a60e2d
-- 
2.55.0

