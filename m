Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDF1A9F91;
	Fri,  4 Sep 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533339; cv=none; b=c4In0L0bA2l3LGK7vIOfzH1WWASfDrzMVsvYb3Dy5UvWXHQBfTEPksF4afen/e9iOeAB+GlSLDrSjCkTfhR88nyAi6JctY8/eaxhxVwREYYwNwUycH2BJYVS9TIffSX3ulRD4jXrfkW7YvbthOFw/GyT6qOStEzFMh8ofSn+BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533339; c=relaxed/simple;
	bh=RPZk54L1rty0ICmm5Vw6nd84czl1ctT8mF95svoe+s8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hn8lVFazl4ZfxfjzMCrNpG0TcXWu7IiAMPVR/smXedIfD4w42XpIhkAflG+C61iaOwL+etdJWODZ+HEpq8r+SFjdnYXo95b3DOa95cm49I9zojzdG7rqf/qHwc45UsUQoxGpqwlfDGw/cGuZX9rIn4+RHKV/Z/N5DkNnrCvnf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntr7V7Sk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntr7V7Sk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D57DEC2BCC7;
	Fri,  4 Sep 2026 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788533338;
	bh=RPZk54L1rty0ICmm5Vw6nd84czl1ctT8mF95svoe+s8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ntr7V7SkevS+N/58ZM46AZRxYxyPElIdjeWGTdmh71AX2IdqvZoobFMwzw8X4BVHG
	 bH3QvRGZUHcqcCoQ7/Z8rvYVV/qpjH+ZuBWf2BqaB1t3TEd3668/HX7ezNRJ9xP2h3
	 +R3jYbdCBmJu0fUABOvfFrKCDBftKaFbbT/K+lQdRoufiOI3SzHHDrp2Z9TtocPJJP
	 Q5aeOi3Am6UYaC0ddHfERIk9ooX4RYfRIpuslX2PrITXbCWLNIdlxuV4M8JI+CX4Cs
	 9qWG1hXIjq11K//ZfKqfqeLklqVkexRHssPJFQ/LQSWru7Yevr4H3kJxuR+zLo+qq3
	 oNP5kXlpJDgaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB782C624DE;
	Fri,  4 Sep 2026 14:48:58 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Subject: [PATCH v3 0/2] lsm: expose mount idmaps to inode hooks
Date: Fri, 04 Sep 2026 16:48:54 +0200
Message-Id: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PwW4CMQxEfwXlXFdxNkWkJ/4DcXCyppuK7KI4u
 wKh/fcm9ICEqh7HY78Z35Vwjizqc3NXmZcocRqr6N42Kgw0fjHEvmpltNnqnbFwlgRpmsdSjUQ
 XAdc775w9MRKqenbJfIrXB/Jw/NUy+28OpXHahidh8JnGMLRRIimcmzFEKVO+Pcos2AD/5C4IG
 rRFS25rMew+9pTmQv7M72FKqkUv5slwGv9gGEDoOl0/6JF7Mi+MdV1/AAR5/AciAQAA
X-Change-ID: 20260824-lsm-mount-idmaps-9d9b994fe1a1
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Daan De Meyer <daan@amutable.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788533337; l=2257;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=RPZk54L1rty0ICmm5Vw6nd84czl1ctT8mF95svoe+s8=;
 b=db8BeU4lBmswjj71tam6b0ZlFa10vg2dFktxgSM+aFee3/ldCqywM6PQAqYiBnQM3rvsm/Qak
 yP9wQ00Wh6oDrq5IInU6yk6X8pKX5VkKltBRcRZj244BJ8RLE2N4KxQ
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com

OverlayFS performs upper-layer operations through inode-based security
hooks. Those hooks receive the upper inode and dentry, but not the mount
idmap used by the VFS operation.

The security layer cannot distinguish an identity-mapped upper from an
idmapped one or make the same ownership decision as the VFS. The VFS
layer already passes the idmap down into all relevant inode operations
so this just brings the security hooks to parity.

So pass the mount idmap through the create, link, symlink, mkdir, mknod,
and permission hooks. Update the in-tree security implementations and
non-VFS callers accordingly.

systemd has been shipping systemd-nsresourced for quite a while now. It
relies on inode and path hooks to perform ownership checks using a bpf lsm.
To make this actually secure we need to be able to calculate the on-disk
ownership from the idmap.

---
Changes in v3:
- Restore the two-patch split from v1.
- Add the missing Signed-off-by trailers to both patches.
- Link to v2: https://patch.msgid.link/20260901-lsm-mount-idmaps-v2-1-3309b9d1eda2@amutable.com

Changes in v2:
- Squash the implementation and selftest into a single patch.
- Add the missing Signed-off-by trailer.
- Link to v1: https://patch.msgid.link/20260824-lsm-mount-idmaps-v1-0-0414a9641c85@amutable.com

---
Daan De Meyer (2):
      lsm: expose mount idmaps to inode hooks
      selftests/bpf: verify mount idmaps reach inode hooks

 fs/cachefiles/security.c                          |   4 +-
 fs/namei.c                                        |  18 +-
 include/linux/lsm_hook_defs.h                     |  23 +--
 include/linux/security.h                          |  58 +++---
 security/security.c                               |  40 ++--
 security/selinux/hooks.c                          |  19 +-
 security/smack/smack_lsm.c                        |   9 +-
 tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
 9 files changed, 410 insertions(+), 71 deletions(-)
---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 20260824-lsm-mount-idmaps-9d9b994fe1a1

Best regards,
--  
Daan De Meyer <daan@amutable.com>


