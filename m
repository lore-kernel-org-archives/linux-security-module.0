Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292069;
	b=IS8UvaWfwtMbBZq+QEQbkxNy5SFIG7vo5LxQ2oUMafBLZTkvj+qHOXa7OawptOpULC8Y
	 aOcL2f2Jzb0neBdKI63Uxk/Wdhv0FXermPbpnFLxV0OM3wXbzaXmSZ92STuMzL8GxHEfq
	 wjWRLaQae3z87mp04JGK+kOQhz7ntjRoie1D0ZmiL+7XNluS/Z0+eRZ2Yf26O2XVh3xxh
	 jgwucUGlpGtWDnr7kntWy5jlkxAG8++VwCh/DkTg59FiEkoZOr0HVNCD09stdQPTJNbxz
	 KAuH8eyph/ABBglsxLIlQVuYAt0twpsPXd4yCYHAAIKKGhNg/3HEC2vmVGc69QeU/HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292069;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xIaVelgG3iKr0vUc0CeNr3kvoJjxr3r74nvfKNYTmzg=;
	b=BaLoob0uy41b5ikWZA7UUvRNVApnw8dxIOAezVySGGhVtVdsYB484FmysM1pZqqbKRvX
	 tQ8JGyEbl+BGK/NbBn3jbDIrUBCxH99yS6NFzRJC6QtUNr3jnHt489qbBD9wZD5x7jmXT
	 0yHICUg3RgCkAe/90rRIPZdnNkFiewYgi+PkbpB4JyGH/SRlaeFb3Dc61dJY96GIErYhr
	 XjeIo+W0DacXd17amofiutTC7a2IZoVWOt/OpIdQfA0aq+DwzGiYsHAdKVqhpEqEBGmFy
	 NjuttFTNtiyb0I/3G1RxVoGia0hFCOdZkMTwtQsDQR3iLSak/mqVcEhtEZCZ9MKA3qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G10Qf0Io;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA23606A31C;
	Thu, 29 Oct 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G10Qf0Io
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454381F01816;
	Thu, 29 Oct 2026 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292069;
	bh=xIaVelgG3iKr0vUc0CeNr3kvoJjxr3r74nvfKNYTmzg=;
	h=From:Subject:Date:To:Cc;
	b=G10Qf0IoKNknYxn2cWpn9WtJX1M7rQZoSA4hZrHteyTf3p7K46rIcXRZ1i0uGpps+
	 C0B2FvFf2jjraySVM9xRk6K28+Xtmq5K69PHpLKzMvQp4VXGhMVO9GsCIS4AAsx/FE
	 n9QtotPIp3+0HrDREHFu4L8ngjg1NLBgh546cmzS0GYxbisniEi+AO02jqpAAWp2ud
	 wMzYWGdptDa07W4uRM1XQ/qCzYLSD8x7a9jGD8grbeMF9tauB0sNGHyixbX4EFfkCs
	 D1zY6hO5phHPAsje+V+ItnX4IWQX3KOZ5ORrDeDHHn54LBVRJF8Ac1rYbscXTD549H
	 crP4WPecN3iCw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/7] ns: fixes for the namespace LSM hooks
Date: Thu, 29 Oct 2026 17:40:55 +0100
Message-Id: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6tgYwirryHoaYafmFihYzA6gx3
 F2KF3DxF+/P5OV/lIA9RB2Tj2KMXnwXZshXibINhRraVzOrPM132Rz97LjVAjuw79860B3yIIu
 LY0AXRG5/MFuTplCz4sFw/rXoz+WPZTBX2D4644chgTZMwTaxupP04HhovPQdv5dhYxYFf24YM
 51q52gDY1yRmerUggNu645rVU7T9AVsFTJE9AAAAA==
X-Change-ID: 20261026-work-security-namespace_free-7aaf89b5b00e
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aibw0ecUu/mSCbaP2VJxKpwSnHUs0UEmrzP6RFE9law=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9LpfnyCzWKeh//enb4okv9Q84NjMEvJKzu86e9+vBs
 WPiiZo+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxYGf4K+91yeqJXLIW+9dH
 /S47FZ1XBz9eIv8i95zDD7XDftsC5zL8d92kxbjsv6qU0b35IZfzGO+cakxqyZwQ6lKoKbyyeYE
 rBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I tried to switch systemd-nsresourced over to the namespace_free LSM
hook that went in this cycle. I explicitly developed it to work nicely
with that. But the version that is merged is broken for that case.

The namespace_free hook is never called. security_namespace_free() bails
if ns->ns_security is NULL and that's only allocated if an LSM requests
a namespace blob. Nobody does. Landlock doesn't care as it only uses
namespace_init and namespace_install but a bpf program attached to
namespace_free never runs. And it can't work around that either. We
could make the bpf LSM request a blob but that would just be a way to
make the hook fire. So call it unconditionally like we do for
superblocks, files and bpf maps.

The bpf LSM also marks the arguments of namespace_init and
namespace_free as trusted. Curiously that patch was also dropped.

namespace_init is called before the namespace is set up and if anything
fails afterwards the namespace is freed without looking at its reference
count. namespace_free is called on the way out. There's no kfunc that
takes a namespace yet but once there is one a program could take a
reference to a namespace that's about to be freed. So add both hooks to
untrusted_lsm_hooks.

The namespace_init hook also always sees a namespace id of zero because
the id is only allocated after the hook has run. The id is the only
identifier of a namespace that is never recycled. So it's what a bpf LSM
wants to use to track a namespace from namespace_init until
namespace_free.

The inode number is recycled way too quickly for that. So allocate the
id in __ns_common_init() before the hook is called. Then ns_tree_add()
doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
Landlock now logs that id instead of zero when it denies the creation of
a namespace.

I'd want to get the whole series into v7.4 since the hooks are new this
cycle. Otherwise v7.4 is the only release where namespace_init sees a
zero id and where Landlock logs zero for a denied namespace creation.
The systemd change I have for this uses the namespace_free hook whenever
the kernel has it. On a kernel with the hook but without the first fix
it would never learn about dead user namespaces.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Drop "landlock: pass the namespace id to log to check_ns_type()".
  Landlock now logs the real namespace id for denied namespace creation
  and its documentation and selftests are updated in "ns: allocate the
  namespace id before the namespace_init hook" (Mickaël):
  https://patch.msgid.link/20261028.oonaisai0Doh@digikod.net
- Link to v1: https://patch.msgid.link/20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org

---
Christian Brauner (7):
      lsm: always call the namespace_free hook
      bpf: don't mark namespace_init and namespace_free arguments as trusted
      selftests/bpf: add verifier tests for the namespace LSM hooks
      ns: allocate the namespace id before the namespace_init hook
      nstree: drop ns_tree_add_raw()
      lsm: fix the security_namespace_init() kernel-doc
      selftests/bpf: add a lifecycle test for the namespace LSM hooks

 Documentation/admin-guide/LSM/landlock.rst         |   5 +-
 Documentation/trace/events-landlock.rst            |   5 +-
 fs/namespace.c                                     |   6 +-
 include/linux/ns_common.h                          |  16 ++-
 include/linux/nstree.h                             |  29 +----
 include/trace/events/landlock.h                    |   3 +-
 ipc/namespace.c                                    |   3 +-
 kernel/bpf/bpf_lsm.c                               |   2 +
 kernel/nscommon.c                                  |   7 +-
 kernel/nstree.c                                    |   2 +-
 net/core/net_namespace.c                           |   4 +-
 security/landlock/ns.c                             |   3 +-
 security/security.c                                |   9 +-
 .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
 .../selftests/bpf/progs/verifier_lsm_namespace.c   |  38 ++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   5 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   1 +
 tools/testing/selftests/landlock/ns_test.c         |   7 +-
 20 files changed, 323 insertions(+), 57 deletions(-)
---
base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
change-id: 20261026-work-security-namespace_free-7aaf89b5b00e

