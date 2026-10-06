Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B02224AF2
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246029; cv=none; b=ZpWCk289EY9907ygtfHEvG9l8YtpnnkkHLIvm8uwl9gS1rSiK380vTm2ZrCETmDvVi2LjOLoFJ9GzcBLaNfpdADQC/uhlFSW6MHnjpGtfbpox7prabsVGUW4j7ngF7nyj686uBJP2QsKk6TmC1FLhtgzdT1UThbiR28O1vf1pY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246029; c=relaxed/simple;
	bh=TpMfAkQOd8+Mla05vi+uHKmTkXRGQJLZjtsApSsTiH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nB8VdBzqsKfyRKU/LT/jxADtqXLDdnf1H89yuAP5G33znsps7xRCj5N/GMUrIw6dogDcDQJUq+sxWw0C5pbtLyB1lgavsuYoKpv4MNnE/xMZBpi6v6pVhvSXMtkjBlBHfQpm4sgzXL8rS2T5CqC/9XWn3RWG8pEMh+wKL/IfpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT/rY8ME; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT/rY8ME"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87fe69060so17233437b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246027; x=1791850827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpCO6yZpRdgZ70rjDM9Ihk9lRlcko+eCmioDcjOGtsc=;
        b=HT/rY8METsqN5L0ydbSn94v4EobVoPBsOcS/6/AWgPgcEZunR77vMlX9oiCrzqYNL3
         3DSsH2UUE8aesraRZj4jhokda5AYsp/kr3JHde0ZR64PMutkb95jNou3HD8dyTgAENDL
         rvNnl03HhoeWlQ3ckC9ocYLhQEdF4a18HmJnSie3eETu+xIJBzQgwaWpgsdYe6vJPv3s
         QdtgYCjeN3jNQa+sY+sI9vuc3vX8h4+/vEHSB1+rgK7Gym6mhmDM7sK+kOXChMzgoELF
         tm9YCPaSIYxuSUW0BtRGaBtRGqct0cWLXfaCjy60SsNad4Npm88wc2rb4Wg5jeXC1bwP
         EQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246027; x=1791850827;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpCO6yZpRdgZ70rjDM9Ihk9lRlcko+eCmioDcjOGtsc=;
        b=1wJPJYoh0VkLWHPOY5uHgWr12tJDs5sUKt0XiH+4L8SfF2Z3j69VE8bHIR/k5GL7ZH
         4YexzjTjbFf0TOo0u12CyFb1eENzlDvJpTsZ9PyZeXLPkihuWWeRYTIFykQnUl/gbF2x
         M1P5/Qsmblwi110BdVJ3vdNGPT5ksI1uP9gobvc33pA2BPfz0FzpmY2hiAO+m+V9FX02
         4JrPpK6MLqww82rdNn+eOrUeQX8QEwwULM1VqSXT2BitJlX0AmZSu4dzzN8ecFQZGmTA
         81gesXBMiNjfW9rs2QksW9zkHy5k2UgfV6U2Y2nL0GZHEIhYHRDnt37QD5NyKDD/O3+a
         lSSw==
X-Forwarded-Encrypted: i=1; AKwUvBy92aBvYsOIMCFmWtNy6C6mQJmBSsRi3GjV2mwZGTx+uT98ywK2P1L+/RR+/PLYgMOT08Z+aRUCDtfxvxMfBOwdNSacGsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYInf7sFz5sbg6VYdfDiEStRs7LPLXNie0QX3OClioUZZ00Cmv8D
	fLjw0iKe7km6xXkpjoUHGCo/969SW30OaewaAUQUpWl4nbmQj9q5KBKd
X-Gm-Gg: AYBFou367OIqlgEraUIgtQ6f0UqhMbPGDeCfrWJ1VVklVZCvbAHun8S8uV4lHN+WJmL
	F/IWu+/ubyMb3OIKFCnWbdJ5R1GF5b3HWBebTKcZNJBkCu26wAUbU5XtmxnMtpyx05dDH52hJGv
	tN33GjFq8VyMYzD+348Xtt03/SwGH9txqJJFGuED8yTMTf+K67OuL13doCsY4MA4fjMQ6kDAbCx
	+At/1gqJjH3O1OzkD9K4XKqvXkbTtOKvxpx/RRJtTYWkMno7nAD9p4u3jhfIa0SxeD3LDjMPQD+
	Cur//DeDnBjislmWReiXspMwawvht8kgQrYNnuiZmS4g9Q/yEg9HWPJjmVVGGrlZ4jM5zIgZl6l
	R7qQzbuvNTzi/Z1OQBoA4ExzJtkxaa782I4bme//MstrlQ/N2FnF5wjR0HXvEomdl6MHPJ4ZL0V
	KqP2+yifxlGR/4FpYB4phhJeg6TJ7xfZkrwcN+Tg0kXeFIWaZ628JKn719pmOQeIDBG/okmeoD5
	A==
X-Received: by 2002:a05:690c:2605:b0:80d:964f:88fd with SMTP id 00721157ae682-8ae36a07c32mr49535007b3.5.1791246026392;
        Mon, 05 Oct 2026 17:20:26 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:25 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 00/12] fs: unified VFS ancestor walk for Landlock and BPF
Date: Mon,  5 Oct 2026 20:20:07 -0400
Message-ID: <20261006002020.2890858-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Howdy folks,

This series adds a VFS API for walking a path's ancestors that covers
both path-walk modes (refwalk and rcu-walk, plus the hybrid escalation
between them) through a unified interface, converts Landlock to it, and
exposes it to BPF LSM programs.  It picks up Song Liu's bpf path
iterator series [1] where the discussion left it, and tries to be the
synthesis of what came out of that thread: a combination of the
callback and open-coded approaches proposed there.

It's a bigger diff, because it tries to cover the whole three-cheese
enchilada of VFS path walk: refwalk, rcu and hybrid. I figure doing all
modes at once is best, even if it hurts now, as bolting on an RCU api as
an afterthought would make for a miserable experience for in-kernel and
BPF users alike dealing with breakage / migration.

I'm RFC'ing this for now, as I'm still not 100% confident on the design
choices, especially on some of the weirder corners of VFS (disconnected
directories, MNT_DOOMED).

Much credit to Song Liu for the inspiration for the initial design.

Background
==========

Landlock evaluates filesystem access by walking from a path to the real
root with an open-coded dget_parent()/follow_up() loop.  This works,
but the semantics are difficult to get right. Al noted that follow_up()
ignores the mount's disappearance, so a concurrent umount can leave
that walk operating on an unaccounted mount [2].  BPF LSMs (Tetragon et
al.) want the same walk and today approximate it with racy probe reads.
Song's series added a step-up helper and a referenced-only BPF
iterator.

This attempts to bring some of the lessons from Landlock's VFS walk to
VFS core code, and exposes the same API to BPF. Other callers can be
converted later.

From what I understand from the feedback, Christian rejected merging a
referenced-mode API now and bolting rcu-walk on later, and asked for
one unified API serving both use-cases, with the callback design Neil
sketched as the accepted shape for in-kernel callers [3].  Mickaël
additionally required that disconnected directories be well-defined
before anything lands, and suggested the layering used here:
"the best approach would be to have a VFS API with a callback,
and a BPF helper (leveraging this VFS API) with an iterator state" [4].

What this series does
=====================

It's a path walking API for VFS, with BPF and Landlock consumers.

The core is a struct vfs_ancestor_walk driven by vfs_walk_start() /
vfs_walk_next() / vfs_walk_end(), sharing its step-to-parent
cores with follow_dotdot() and follow_dotdot_rcu().  The engine
owns every invariant: references in refwalk mode, d_seq/mount_lock
validation in rcu mode, mount crossings via choose_mountpoint(),
which is what fixes the Landlock race.  Both modes live behind the
same calls; a VFS_WALK_RCU flag picks the mode and nothing outside
namei.c sees seqcounts or nameidata.

On top of the engine sit two front-ends matched to their consumers.
In-kernel callers get the callback design, which must not sleep.

  int vfs_walk_ancestors(const struct path *path,
			 int (*cb)(const struct path *ancestor,
				   unsigned int pos_flags, void *data),
			 void *data, unsigned int flags);

@cb is invoked on @path, then on each ancestor up to the real root,
and returns VFS_WALK_CONTINUE, VFS_WALK_STOP or a negative errno;
@flags takes VFS_WALK_RCU when the callback copes with unreferenced
positions.  Landlock's walk converts to this, preserving its evaluation
order exactly (including the disconnected-directory semantics of its
recent fixes) plus the mount_lock-validated crossings.

The engine itself is declared in fs/internal.h:

  void vfs_walk_start(struct vfs_ancestor_walk *aw,
		      const struct path *path, unsigned int flags);
  int  vfs_walk_next(struct vfs_ancestor_walk *aw);
  void vfs_walk_end(struct vfs_ancestor_walk *aw);
  bool vfs_walk_handover(struct vfs_ancestor_walk *to,
			 struct vfs_ancestor_walk *from);

So the one consumer that cannot be a callback (BPF) can drive it one
step per call, from fs/bpf_fs_kfuncs.c. Here are the (numerous) kfuncs,
many of which are thin wrappers around the engine:

  /* referenced, sleepable: each position comes acquired */
  int  bpf_iter_path_ancestors_new(struct bpf_iter_path_ancestors *it,
				   struct path *path, u64 flags);
  struct path *
       bpf_iter_path_ancestors_next(struct bpf_iter_path_ancestors *it);
  void bpf_iter_path_ancestors_destroy(struct bpf_iter_path_ancestors *it);
  u32  bpf_path_ancestors_pos_flags(struct bpf_iter_path_ancestors *it);
  void bpf_path_put(struct path *path);

  /* lockless: positions are borrowed, valid until the next step */
  int  bpf_iter_path_ancestors_rcu_new(struct bpf_iter_path_ancestors_rcu *it,
				       struct path *path, u64 flags);
  struct path *
       bpf_iter_path_ancestors_rcu_next(struct bpf_iter_path_ancestors_rcu *it);
  void bpf_iter_path_ancestors_rcu_destroy(struct bpf_iter_path_ancestors_rcu *it);
  u32  bpf_path_ancestors_rcu_pos_flags(struct bpf_iter_path_ancestors_rcu *it);

  /* escalation for hybrid walk. Mirroring unlazy_walk(): acquire the
   * lockless walk's current position straight into a referenced iterator
   */
  int  bpf_path_ancestors_legitimize(struct bpf_iter_path_ancestors *it,
				     struct bpf_iter_path_ancestors_rcu *rcu_it);

The lockless constructor is KF_RCU_PROTECTED, so the verifier forces
the whole iteration into one RCU read-side critical section, within
which everything sleepable is already rejected. Each next() is still
namei.c code, so the walk invariants stay in the VFS even though the
loop is in the program.  A hybrid walk runs lockless until it needs
sleepable work, then it escalates. Here's what hybrid walk looks like
concretely:

	bpf_rcu_read_lock();
	bpf_iter_path_ancestors_rcu_new(&rit, dir, 0);
	while ((pos = bpf_iter_path_ancestors_rcu_next(&rit))) {
		/* borrowed position: evaluate, but no sleeping allowed */
		if (foobar(pos))
			break;
	}
  /* converts the iterator from rcu -> refwalk */
	bpf_path_ancestors_legitimize(&it, &rit);
	bpf_iter_path_ancestors_rcu_destroy(&rit);
	bpf_rcu_read_unlock();

	/* sleepable kfuncs are legal again. */
	while ((pos = bpf_iter_path_ancestors_next(&it))) {
		bpf_path_d_path(pos, buf, sizeof(buf));
    /* refwalk gives you path references that you gotta free to appease
     * the verifier
     */
		bpf_path_put(pos);
	}
	bpf_iter_path_ancestors_destroy(&it);

Nothing is allocated during the escalation, so it cannot fail for want
of memory inside the critical section, and the sleepable work lands
after bpf_rcu_read_unlock() by construction: the resuming next() is a
sleepable kfunc, an ordering the verifier enforces.

A lockless walk that loses a race does not restart transparently: it
dies with -ECHILD (BPF: BPF_PATH_ANCESTORS_RETRY), the caller discards
what it accumulated and retries in referenced mode, so one lockless
attempt bounds the retries.  This is simpler to reason about than the
restart-signal contract discussed in the thread.

Disconnected directories are exposed first-class rather than papered over:
positions whose dentry is a disconnected root are flagged
VFS_WALK_POS_DISCONNECTED (plus VFS_WALK_POS_MOUNTPOINT for the
mountpoint a crossing landed on, which the old Landlock loop never
visited), and continuing over one resumes at the root of its mount.
The mechanism lives in the walker; the MNT_INTERNAL allow-and-stop
policy stays in Landlock.

Supporting pieces: mnt_undo_legitimize() gives a failed
__legitimize_mnt() an undo callable inside the RCU read-side critical
section, deferring a final mntput to delayed_mntput().

Secondly, for the bpf_path_ancestors_legitimize, a patch is added to allow
kfuncs to accept an "__uninit"-suffixed iterator argument so a generic
kfunc (the handover) can initialize an iterator from another one, since
KF_ITER_NEW allows only one constructor per type; and an acquiring
KF_ITER_NEXT's drained branch now releases the reference its acquire
bookkeeping created, which no in-tree iterator needed before.

Patches 1 and 4 are carried from Song's series; patch 3 is derived from
his Landlock conversion and carries the Fixes: tag for the follow_up()
race, per Mickaël's request on v5.

Open questions
==============

- Whether an open-coded iterator is acceptable to the VFS as the BPF
  front-end, given the engine and invariants stay in namei.c and the
  verifier provides the discipline a kernel-owned loop would.  The
  callback shape was the thread's endorsed design for in-kernel
  callers; I believe this split is what Mickaël proposed in [4], and
  the alternative (BPF programs as the callback) costs considerably
  more verifier machinery for a worse programming model.

- Whether VFS_WALK_POS_MOUNTPOINT should exist at all.  It is there so
  Landlock's rule evaluation stays bit-for-bit what it was before the
  conversion; if matching rules on crossed-onto disconnected
  mountpoints is acceptable as a behavior change, the flag disappears.

- The retry-on-ECHILD contract versus a transparent restart signal.

[1] https://lore.kernel.org/bpf/20250617061116.3681325-1-song@kernel.org/
[2] https://lore.kernel.org/r/20250529231018.GP2023217@ZenIV
[3] https://lore.kernel.org/all/20250707-netto-campieren-501525a7d10a@brauner/
[4] https://lore.kernel.org/all/20250704.quio1ceil4Xi@digikod.net/

Justin Suess (11):
  namei: add vfs_walk_ancestors()
  landlock: convert ancestor walk to vfs_walk_ancestors()
  bpf: mark struct path trusted
  namei: make vfs_walk_ancestors() stepwise
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
 fs/namei.c                                    | 377 ++++++++++++++++--
 fs/namespace.c                                |  63 ++-
 include/linux/namei.h                         |  17 +
 kernel/bpf/verifier.c                         |  49 ++-
 security/landlock/fs.c                        | 265 ++++++------
 .../selftests/bpf/prog_tests/path_ancestors.c |  77 ++++
 .../selftests/bpf/progs/path_ancestors.c      | 134 +++++++
 10 files changed, 1076 insertions(+), 177 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_ancestors.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_ancestors.c


base-commit: 99dc1ba542420db6b8df209744f55cc52466ad91
-- 
2.55.0

