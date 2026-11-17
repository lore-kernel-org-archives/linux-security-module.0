Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910737;
	b=QRnqbFy7dD4HPW0js0fIt0996oHlxbyD5OYTyxrC8afvUKkNmA86mN1/sKEeQjqr8ChN
	 4V+aoTGC4P6cCPSGo0BZQqDKRUGN7DL6cJ3nWFYAnjAd1cGJfy+VoWhC0W6U6v6tgEY0w
	 6UKJPkrhav+T+0f7hdgbOkGs56iFZXxspq6ewUHMiwp1ln/Gq0Zy/G1Hc+I5qsZdBvh/1
	 YcEkGmE8rqqpBc2AjaabAlO4Ao0KE3IsCT1NYVjDkHHHek9b2R9UIKvTCIC2tNc5r+pYm
	 NFxTWotAlYNpiMR/GQFIW54dV8VQcyvRKXDxNwOgZBuW+YVkvROrW+vusF+BYyVOsDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910737;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=ChHC2pG1ERdXi+oTY1FkF++RG4lH/5E3W8mTcB8dgwM=;
	b=fQmI6KFQkA/Qm/KIxs6NEo48dqEjeDXZZ2rgs5B/2TPEywnsAi6qs5MtUYnN49CnkUG+
	 9jvNEvw4iAe54/GFzeFhJDb4OEKceTOTIhE80rEWxWkbk63AYrDJIj+THLsLf94RhwgcX
	 vB2Cinji7QjzIAM3klpo7pN2p8FjmuvoSdR+Dc/g1+8JAR1OCBQx3JXx1ax+KGbP3LuH/
	 SwilH7mB/HietE6o3Q+nfpy1U2ljKmsccSbWMF4NE1edVVnOcv1zU/y8Wmn/Dvd2o6Piw
	 nlDXHVUrOnRleO5gGHiIcSNtBhv7RCltraSzQ0IIVRiZaXCO6wNHQZ+r3YxgdKPB5Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Q6yLxN+8;
	arc=none smtp.remote-ip=83.166.143.174
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D0606A339
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 777D0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Q6yLxN+8
Received: from smtp-4-0001 (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLL04GkJz1b7;
	Tue, 17 Nov 2026 11:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910728;
	bh=ChHC2pG1ERdXi+oTY1FkF++RG4lH/5E3W8mTcB8dgwM=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6yLxN+8p94eq4eTWoh/lkjpxIn/U+IwWRYIrBovY9PD/mhN0tTERgC6mjnLA0qnC
	 e1pcB0MDoLWbYcrUAPhEnEpRndJokemiQ67sW+Lzen4RtWp7pPrRJQaMnUkNw120aH
	 Qooh8aq0wyIwJ0AFMjbGkBAyNNRuqzzMKlMJLiWM=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLKy6pWJzVLq;
	Tue, 17 Nov 2026 11:18:46 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jmorris@namei.org>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 0/6] Fix Landlock mediation of capabilities guarding LSM policies
Date: Tue, 17 Nov 2026 11:18:37 +0100
Message-ID: <20261117101845.2523770-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This is series 3 of 3:

  1. fix Landlock mediation of commoncap's capability checks;
  2. fix PR_SET_SECUREBITS mediation and add focused Landlock tests;
* 3. fix Landlock mediation of capabilities guarding LSM policies.

This series applies on top of series 2:
https://patch.msgid.link/20261117101738.2523492-1-mic@digikod.net

AppArmor, Smack and SELinux deliberately check the capabilities that
guard their own policy with cap_capable() instead of capable(), so that
other LSMs do not have to authorize them:

- commit db59000ab760 ("selinux: only invoke capabilities and selinux
  for CAP_MAC_ADMIN checks");
- commit f28e783ff668 ("Smack: Use cap_capable in privilege check");
- commit 31ec99e13346 ("apparmor: switch to apparmor to internal capable
  check for policy management").

However, LANDLOCK_PERMISSION_CAPABILITY_USE, merged for v7.4, restricts
capability use in general through the capable hook, so a domain that
denies CAP_MAC_ADMIN can still load AppArmor policy, change a file's
Smack label, or set SELinux contexts unknown to the loaded policy.

Patch 1 adds security_capable_lsm(), which these LSMs call instead of
cap_capable().  It checks the capability with commoncap, then calls a
new capable_lsm hook with the LSM_ID_* of the LSM whose policy the
capability guards.  LSMs that only implement the capable hook still do
not see these checks.  Patch 2 implements the hook in Landlock, patches
3 to 5 switch AppArmor, Smack and SELinux to the new helper, and patch 6
adds tests.

Calling the other LSMs' capable hooks instead, possibly with a new
CAP_OPT_* flag, would change what the capable hook sees for its current
users, including BPF LSM programs, and would require every MAC LSM to
ignore these checks.  The new hook keeps the choice of the commits above
by default and follows the hook guidelines.  The trade-off is that an LSM
restricting capability use in general needs to implement both hooks, as the
kerneldoc says.

As the capable hook, the new hook can be called in atomic context and
with another task's credentials (Smack's SIGIO check and ptrace rule).
Smack passes CAP_OPT_NONE, so Landlock logs every denial of these
capabilities, including for the override checks that some Smack hooks
make before their label rules.

The new tests are skipped unless Smack or AppArmor is active.  With
lsm=landlock,smack and lsm=landlock,apparmor, they fail without these
patches and pass with them.  SELinux only checks CAP_MAC_ADMIN this way
with a loaded policy, so it is only build- and boot-tested.

Paul, an Acked-by for the LSM and SELinux patches, and for taking this
series through the Landlock tree, would be welcome.

Stephen, a review of the LSM and SELinux patches would be welcome.

John, a review of the AppArmor patch would be welcome.

Casey, a review of the Smack patch would be welcome.

KP and Matt, a review of the new BPF LSM attach point would be welcome.

Changes since v1:
https://patch.msgid.link/20261110203042.2410140-1-mic@digikod.net
- Fix the AppArmor test for users without the root UID or GID (reported
  by Sashiko).

Regards,

Mickaël Salaün (6):
  lsm: Add a capable_lsm hook for capabilities guarding an LSM's policy
  landlock: Restrict capabilities guarding other LSMs' policies
  apparmor: Use security_capable_lsm() for policy capabilities
  smack: Use security_capable_lsm() for privilege checks
  selinux: Use security_capable_lsm() for CAP_MAC_ADMIN checks
  selftests/landlock: Test capabilities guarding other LSMs' policies

 include/linux/lsm_hook_defs.h               |   2 +
 include/linux/security.h                    |   9 +
 security/apparmor/domain.c                  |   9 +-
 security/apparmor/policy.c                  |   7 +-
 security/landlock/cap.c                     |  23 ++
 security/security.c                         |  47 ++++
 security/selinux/hooks.c                    |   3 +-
 security/smack/smack_access.c               |   3 +-
 tools/testing/selftests/landlock/cap_test.c | 240 +++++++++++++++++++-
 tools/testing/selftests/landlock/common.h   |   2 +
 10 files changed, 331 insertions(+), 14 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
prerequisite-patch-id: 365071039dd2be439f67707944d12edbe1422d60
prerequisite-patch-id: 021705fb5147cdc8edcac9dbe53c06b854cf976a
prerequisite-patch-id: 1dfd782b28feeac47423e702764778031b850d6c
prerequisite-patch-id: 0bf745b08b99168d266461ef5b0b943a2b71eceb
prerequisite-patch-id: ad96449ac2b66342bdc171582d400276372ce386
prerequisite-patch-id: 39d6ce2bdfc170b545eb2d275ab781e15c9e887a
prerequisite-patch-id: 8b180590cb598fc5be4aa403be233b80e0de8dcd
prerequisite-patch-id: e56fbdef4bd6316e80e50ec8e8493ffb707dc76d
-- 
2.56.0

