Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBC23BD02;
	Mon, 24 Aug 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578103; cv=none; b=WjW+J4g1NRJ/CaY4ImZjS8v0H83g5P9i5KeAwHkW645d972ocH5/CnS6AX7nQIA+/+w+UfmdolEKJdvdlm78kODXJOiwABc4ItQQ2FUhTWkO44k0lL4K3++j/vuvAh/ru3O31vSQz0APJ1/iPkVsIejDjba7xNParXJCmicYPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578103; c=relaxed/simple;
	bh=prDA2HVVe2wMa35Q1aFO3/S+aVUUWrB3TV9rg1BQDic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ER/IOJJp+Lrq8z+Mg6YjbgyS/ezV3yroVtr5BuU8oLsWD+UErAbQLDedf/dKmsNkQOo03ZyQsWLQmmZS8QNIFCEEO4eIcb1sfdvjrorrqk+LJ3zv1S/gE1p8a5YQDy0tfdOrD6LwN3vdN2dn+U1wUKGxU+PlhBnE+aRoU+U24NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZC3mdsM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZC3mdsM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2615C19425;
	Mon, 24 Aug 2026 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787578103;
	bh=prDA2HVVe2wMa35Q1aFO3/S+aVUUWrB3TV9rg1BQDic=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HZC3mdsMAK6FPOBo0BwImofl8m3dPeOcgInnZes27IdRjV9EZ2rEWSOXI5J2LTNTj
	 MGZgDRuTlI0yxcYkwoBe9Q3PcJS7YGdxz2xM8jh6W8VLG1Er7UjoNEgQSStmqufqvT
	 EnGmco7jmSSNs+ZxnYHODuwQbzAZ5IwWyxMCuqmjPxidg2LGiQ2xIfa0jhetFvk7TP
	 XUQKRNItlkzuNOoaCxecpkOEkHmOopt9toJSXxD3SruitbgE4+1RXSQbe22lP9KUIQ
	 SIoETmvGMB61lnDAQqQksI/rn+HSCl+FE2mZJT0/ff7RgLcBydY2EntkbktImgfXyc
	 T6JGTHyQ0mF1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E0C5DF94;
	Mon, 24 Aug 2026 13:28:22 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Subject: [PATCH 0/2] lsm: expose mount idmaps to inode hooks
Date: Mon, 24 Aug 2026 15:28:11 +0200
Message-Id: <20260824-lsm-mount-idmaps-v1-0-0414a9641c85@amutable.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMTQrCMBBGr1Jm7UATihivIi4m6dSOmLRkUhFK7
 26iy/f9vB2Us7DCtdsh81tUllTBnDoIM6UHo4yVwfb23F/sgC+NGJctlVpEWhXd6Lxzw8SGDNT
 bmnmSz095u/9ZN//kUJqnLTwpo8+UwtyiSFo4w3F8AdC/pU6NAAAA
X-Change-ID: 20260824-lsm-mount-idmaps-9d9b994fe1a1
To: brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, 
 viro@zeniv.linux.org.uk
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787578101; l=1818;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=prDA2HVVe2wMa35Q1aFO3/S+aVUUWrB3TV9rg1BQDic=;
 b=yUjMxFE0LjiFTitSfdtCLTLoIEb9XI0bxeb4aHimp4xChKxivwZm18qcqoUxP8itXdh0R8hGs
 i/a82nK0eHLAnKOk9oyRyi1xtd/wlWUjvfGM1bERJy6EIDFsYjpMlhL
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
base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
change-id: 20260824-lsm-mount-idmaps-9d9b994fe1a1

Best regards,
--  
Daan De Meyer <daan@amutable.com>


