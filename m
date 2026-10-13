Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977437E5D4
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880872; cv=none; b=A3nqN837E2efeBL1l7fYeCxmlI2ISijkOrNF10OTIgLL0t2OADqcPADCEeuYnpJL8CEi57FPtUWJjTOsp0F/l68kQhLAP13R342gwO9M3mSPxif/O8BYiTwsL3RjB+OyjwsaX7GVMfraHkoONj8jVsunn5n0V68WZ0/Rf5zEWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880872; c=relaxed/simple;
	bh=wQcsrZGEGoTD8tZ4mSQVDM0CA0NU/hotKN0jq7p84wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfJKsgmAs6Bmzqu5rYnNrcCXAzSnUBMVx/MFoR4HAjbw2XDDEjMDTQowG1t3NT9AwYMTNs5TXSnUHQ3vPw8+ddNXlKh5MwJ7mS0jFwaKOugeMS3fLEakStFNkcJ9UI3FMqK3HVJ4nBbuypklStzHVvTRH57okquE2DvYn4AGQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaU69TOf; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaU69TOf"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3550dd02c9cso207757eec.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791880870; x=1792485670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ogQf9jgUBIrgk7octuKzEMYSBjX+/nz7g2meA6r6ONk=;
        b=VaU69TOfE1R1ebWFhpl2jndVO6elNYFjpdO3b0KyshipPlbPN7+t0CWZ4hsMcYoHcz
         eYQQ3kMORsYT4FoEAmpKfmHRMgVM32OELKJZKEMzA6vbLJr1Fkup5mjV3Nb8yxwhoYa2
         vg6nekYyM1dUeMQi/MNb5ZJMS8k6B9hIqs0WYC+NbeVEfT1bGIDtYetfCnFcaJA8ZK3c
         iMNwjiOhbTEOEcIDx4MhUnfzMeHOvCwFPqss7Biq6K2JWNxs5Pv7v1H92ja+eoMVPNSg
         zaCHenbYbuVQPDFFn9gkGcnVKoTpptxMU3kdMbuS5LwDyWC0g0HHaVDNlTOQiK83sFWm
         6SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791880870; x=1792485670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ogQf9jgUBIrgk7octuKzEMYSBjX+/nz7g2meA6r6ONk=;
        b=ywgb9tNYonTDH2KHzBNk/j9T7QWNKij5bAzgExJ18SI1ogizOhOM4TwThtNpmBKAdM
         zNhWLLvMYkFjyo+J1zhX+ut7jGLIjewE0TaBO7v0uOSAflwbDhEgDgmZT5ug9QGOXVUL
         cXa8cgkewSUvsGNzItCwjiC+jKb4QTF5ZpvdtMoAfgBHU4xBK4mV2EB1afeELzDvCPjK
         UJYgeuV0uhEnaSDh9ohzH+wipx0FPYZJssLMi14nmZRMDcVzF4d+qZZiwhPPJ4GUS/3d
         R9UvJAc5tTs8z+v7Zyp1Myc9NGptSHT+94ovT2MsAxLveynyZIFnBgVaQraiIVGGdPNg
         JL3g==
X-Forwarded-Encrypted: i=1; AKwUvBy68y2g0aMx8C5ymPOl8qZOgXWuwyhZON+ncestSyE3OT1ozThnmRRajy2c1/nj127TrXmKeo4JeGABxUVkFkvAlVV/6QA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtdWU/LwvcT3hxkApR5fQEkbQ0r26w/IRsZr4CB1SzroUIfVPN
	rAfyPoBDKVQtTfOltYOzIw5eSELUqgE9PehYdipHUQdutw+SbhYRSX5x
X-Gm-Gg: AYBFou3jiEmXHFMpmxggFewS9LYon8Gj0QKl8eV/vjIIS75jFLgKWoRXCZumYlXhRQi
	Um+yu/zqg6zRGnh8tvMyZrQqX5FpCmKs+itI6cZmknExM4NHpjfb5Bz9IeA1p7lmCMqLuW6vxDE
	TVwsJVcYm1aScUU11MjfPHHzlNujsexZOT4Man6e1N1mwcGimFYdITBhimD2l/LVfImi1hxh4Nv
	7sKcF4gKWaGEfpE/XP1Rluaq6KQ5L8Ye2e/YB4dQC5QY9zBOHY3bc7AcbSVQloCfKZwK+IYrp1L
	/gnbnk/dWFlJIi9EL/KuEX0zGezg0UcVaHowVrWftlnJWnjyDVmLXg2ZfRMnRTEyJN4khpRMp+x
	4jVwwSpkGmjqANTbT0xu1TVO1PSv6S7Ziojx0hINEb2ezzKNiS9W9wr4MuU/IBXVdJ8RMuQArPE
	e5Wxb/VUZYS7ZTfG5HWpgexKQGMJHXTIUqfEJIXB6LEUGK9U2yqecPzZ1kP2vRiUYs7wxnu3MeO
	FrCtFknTpqXsV1NYtZXI6fxQ5vIhRbmc1FdyHnAN+04Rz+nSjV5gfxjlVhouYzC
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id 5a478bee46e88-35bcb8a919dmr6285540eec.1.1791880869459;
        Tue, 13 Oct 2026 01:41:09 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm42575464eec.25.2026.10.13.01.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:41:08 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v4 0/2] keys: Fix quota-owner reads and ownership accounting
Date: Tue, 13 Oct 2026 16:40:54 +0800
Message-ID: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision keeps the v3 topic order: the lifetime/namespace-reader fix
is patch 1, and ownership accounting is patch 2. Each patch can be applied
independently to the base, and both orders produce the same final tree.

Patch 1 protects only the three quota-owner UID snapshots. It relies on
key_user_lock already held by lookup and final reference removal. Its
READ_ONCE() pointer loads pair with a WRITE_ONCE() replacement in chown.
The reference-release ordering and lock handoff keep a sampled owner alive;
this does not require patch 2's new accounting critical section. The commit
message gives the lifetime argument, including a final put by another task.

Patch 2 serializes chown with quota reservation and positive and negative
instantiation. Each critical section is complete within this commit.
Atomic counter operations alone do not serialize owner selection and
count/state publication with chown, and instantiation does not require the
target key's semaphore.

The messages explain why keeping a key alive does not pin its former
quota owner, and why key->sem does not exclude instantiation. They map
those two requirements to the three reader scopes and four accounting
scopes, and explain the existing protection at unchanged lifecycle sites.
All seven scopes in the combined v3 series are retained. Reservation and
instantiation locking move from v3 1/2 into the complete accounting fix
in v4 2/2; no lock scope is split between commits.

The procfs changes cover the originally reported proc_keys_start() fault.
The filters continue to use the quota-owner UID, since key_fsuid_changed()
can change a thread keyring's key->uid without moving its quota owner.

Changes in v4:
- Keep the v3 topic order: lifetime/namespace readers in patch 1,
  accounting in patch 2. Both fixes remain independently applicable.
- Put every accounting critical section wholly in patch 2.
- Make patch 1 independent using existing lifetime locking plus explicit
  pointer access marking.
- Explain the root cause and every critical section, plus the existing
  protection at unchanged sites. Keep allocation, notifications and
  reference release outside the new accounting scopes.
- Correct the reader patch's Fixes tags to the namespace-filter commits.
- Rebase onto for-next-keys at 22430ae5d90ab and request fresh review.

Validation:
- Built security/keys/ with patch 1 only, patch 2 only, and both patches.
  KEYS, PROC_FS, USER_NS, KEY_NOTIFICATIONS, BIG_KEYS, ENCRYPTED_KEYS and
  PROVE_LOCKING were enabled. No compiler warnings or errors.
- Both exported patches pass checkpatch --strict with zero diagnostics.
- Both patches apply directly to the base. Ordered git am in either order
  reproduces the expected intermediate and final trees.
- No new runtime, lockdep or Sashiko run. The KASAN excerpt is historical.

OpenAI Codex assisted with the review audit, series split, pointer access
marking, commit messages and build checks. The existing author sign-off
is retained from v3 for human review before submission.

Previous revisions:
v3: https://lore.kernel.org/r/20260927162528.943886-1-nicoyip.dev@gmail.com/
v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
v1: https://lore.kernel.org/r/20260823170448.3856516-1-nicoyip.dev@gmail.com/
Review:
https://lore.kernel.org/r/asL2UQjYCxt9SF9K@kernel.org/
https://lore.kernel.org/r/asMQMzqVkmYhwgMB@kernel.org/
https://lore.kernel.org/r/asNCIs3OshLwGWrB@kernel.org/

Chengfeng Ye (2):
  keys: Protect quota-owner reads in namespace filters
  keys: Serialize ownership transfers with key accounting

 security/keys/key.c     | 15 +++++++++++++--
 security/keys/keyctl.c  |  6 +++++-
 security/keys/keyring.c |  7 ++++++-
 security/keys/proc.c    | 15 +++++++++++++--
 4 files changed, 37 insertions(+), 6 deletions(-)


base-commit: 22430ae5d90ab288b0ee2ad99ae941f4a666b694
-- 
2.43.0

