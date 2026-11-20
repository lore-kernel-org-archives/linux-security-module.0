Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177823;
	b=PAgfBreb94ULvDLgPJQb51im6BeXR1ZFyWTr0oBH5JJCjyLRNHvB/ARTVbh6rpCd+E6O
	 Y6IlZ3mal0vCjehJQQhHVZeoH+Y0xCpmxAPYUDnxdisWIpMciNfYu3bq5nhJ0FwY8yXeu
	 Y/JmrMypUy0LGFl+sk7Vszc5HN1tpLE/oFC+zv3l9vTm3lLfUN4GzUApwYndi7qQ63qM/
	 J+sVJWyJaRJETkJjN3lZTFRAmTLTrN4njmYzHsefP8iAMJCDfAQqUqOWTDDxaH4rKHAp5
	 Ro0kpdYAyukXeqjKaWghOZrrC0sIU6DSOJWGfGgXziHHrbLh1kJZuiL62xlX969F2Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177823;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Nu6y8JHW5Df0o6sO4oBlG4kTY0V7kEbp4hSFTKiENgE=;
	b=rHr8FiP60q9d4mtCcJcQae5fgOlZeJhQ1IVjsNDWwlyBqvy+91dOejRPMtW+jvwjtFdS
	 A2r5PlMksYhiI7+8TYmSnosbPw/tjxMg/Em55zjJudU8XgqyU2ir2KDsA/skE9qR0A89D
	 EP2QktxSUgf47lxZtAMhhwygrVg7HFZ44rUdI1picApXgb9J4KmR2sO/rc054GLkSsphV
	 OkDD0gdLdcq9TvCyrwt5RKg4CXBk0e07FATPxYsvv4jNm7CsUBw4i+hQ8w+TA2iom6fBu
	 P8PxgNpM0p7PbeQtpWkXzrLIjfH1gubTxjduHAuJ+XCHLojo3aotCctYjwNMaIg8HYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/mCumau";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1A606A320;
	Fri, 20 Nov 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/mCumau
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E281F000D2;
	Fri, 20 Nov 2026 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177821;
	bh=Nu6y8JHW5Df0o6sO4oBlG4kTY0V7kEbp4hSFTKiENgE=;
	h=From:Subject:Date:To:Cc;
	b=m/mCumauVAHQN+cNVCLG8uLyJ5BHSxpoaADkrpiPl6WyY+Sz416gaxvEeVMYsZARt
	 LXD1C8HuvPOF6JA4YM0ApI8/eUPsjcB3tQlZN7We9Ethpoj6PrEUCTcGmi9Vdt9w/N
	 2DtL8sxb88DHaoM6EaN63weHpmeEh54SLh4R+aeVVAR/6RaK+iEDETJ6Dd+ePUjQFB
	 zrdM/+vuI3Dy6/lPOHYHcYuHtBdAmB3nTHaj911MRu4hzqFMCOR0JsqQTTDSTVO+RZ
	 zKLXiO9RcqKiWiBQE1gXTzUQhqQsw/yrK1k48yH1XcwRcaDBEACJefnGNwlLPwfcF4
	 x2dx9UuVS3FAA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
Date: Fri, 20 Nov 2026 13:29:57 +0100
Message-Id: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMywrCMBBFf6XM2glNEF+/IiJ5TG0UJ5JJVSj9d
 xNduTyXc88MQjmSwKGbIdMzSkxcQa868KPlC2EMlcH0ZqO16fGV8g1Z8J4mLmeZXMlEGNZmb8P
 WDDvroX4fmYb4/naPpx9X9Uq+tFgznBVCly37sU0tq1jUX1Y1CZblA94YtY2mAAAA
X-Change-ID: 20261120-work-ns-mount_subtree-d429ad72f8ac
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 bpf@vger.kernel.org, Zhiqi Zhang <zhiqizhangg@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i5kezm/Q/pwCPFzOEDNb1FPGNWMleCBr+q8gYcME6Ro=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz2Ia5P6y56yDIOSXT6WWxfWDR11qxYG6ZWfk/l218P
 7H4089zHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP538/wv+7Ni1zTySuY13M8
 W6y1rYzvZMAjnX1/ju06Zn761iY1w1xGhsuPkqNNVd4dDLHqe2u5mKPNsqRC5Px97m/1TvxSKu4
 LGAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

mount_subtree() allocates a private anonymous mount namespace so that
automounts during the path lookup have somewhere to go. btrfs goes
through it on every mount and NFS on every NFSv4 mount and whenever it
follows a referral.

Since the namespace LSM hooks went in that namespace goes through
security_namespace_init() like any other. Landlock enforces
LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a
sandbox that handles that permission without allowing CLONE_NEWNS can't
mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even though
nobody asked for a mount namespace. Zhiqi reported that and sent a fix
that skips namespace_init for this namespace (cf. [1]).

But namespace_free needs to be skipped as well. Otherwise a bpf program
attached to namespace_free would see these namespaces go away without
ever having seen them being created. Right now that can't happen but
only because security_namespace_free() skips the hook if no LSM
requested a namespace blob. So mark such namespaces as kernel-internal
and keep them away from both hooks. The first patch turns the anon
argument of alloc_mnt_ns() into flags so we don't end up with two
booleans.

The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
and fsmount() are handed to userspace and keep going through the hooks.
Landlock covers them on purpose.

I tested this on v7.4-rc3 with a btrfs loop mount and an NFSv4 mount
in a Landlock domain that handles LANDLOCK_PERMISSION_NAMESPACE_USE but
doesn't allow CLONE_NEWNS. Both fail with EPERM without this series and
work with it. unshare(CLONE_NEWNS), clone(CLONE_NEWNS),
open_tree(OPEN_TREE_CLONE), fsmount() and setns() are still denied and
the Landlock namespace selftests pass.

[1]: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.com

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      mount: pass flags to alloc_mnt_ns()
      ns: don't call the namespace LSM hooks for kernel-internal namespaces

 fs/namespace.c                     | 31 +++++++++++++++++++++----------
 include/linux/ns/ns_common_types.h |  2 ++
 include/linux/ns_common.h          | 20 +++++++++++++-------
 kernel/nscommon.c                  |  9 ++++++---
 4 files changed, 42 insertions(+), 20 deletions(-)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261120-work-ns-mount_subtree-d429ad72f8ac

