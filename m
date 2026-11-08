Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169463;
	b=fdP4O0I2eQ2xIdBbJjr/59utv54VqVZIxjwVT5Dz6Wr4VRaawOYTSOSMI/7BqqtfmBLf
	 XsjZ8uaPoy0PtqetPeTdCCxK5A1aJWQHQFUWc8T56iHKqJnNmUhmfT18wq4Y9UeQbBIXj
	 PB5G99JXv4+4WHyQHQ3CX6yaoh2HcPAUZn0nhl2U/JK47gqn6vqxiw9LhQNBW0/sGyZfC
	 lj4XJ8IcUwpCYrs192lP5QwFM0fepAvmGIkGMS7tdjDcof0nbhO0/WV25b5JR4GG97A8q
	 t2Q9BpMZjehLcgTnOIfQlOJnsdA8+hBLAtQ7240X6WoWBD4+Sw/ghvD/pUStsxMLXsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=U6Ai3RX3XOfep+2NZPYc+asEVycV3qACLtEG8MfT9tU=;
	b=FW9anH8F/rwLbmIcaUlyJIaIWshUbFmQonb4rF80syhCVXym4av7pdhKpwuq/y6wvr7w
	 5LHCbV/wUgoQukUjWBDBTcNdeWjRTqQFFqX2M/Gpdev5lHBa9F4mhj3DWuC9PetIMpDXX
	 5ZT/jIe5ujXcU7eeZVsEAAZ14CRZQeFpQf2yy3Txi+aGKzVIHQnkBcF39N8Y1vxSTISmk
	 9L/Hk+9Ua4rtMpGRBC8mAmLMx6p83Duk5DEIkqx4bm+UIsCDmC0hzcnh/uRhr3GOopVRX
	 JTuFgIxAOWOG9MUtRh4V3gZLEQ/qbkZS65lzeZcHDlqRXxsu7WNiwX1lNXSRkG0Y05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHTLLd4f;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745356079D83
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 745356079D83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHTLLd4f
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e4831c028so294270f8f.0
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169462; x=1794774262; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U6Ai3RX3XOfep+2NZPYc+asEVycV3qACLtEG8MfT9tU=;
        b=jHTLLd4fpz/icE7NfXAZClbnA8xkbQscrSmCRQpuELsK3h2USWg26Q3W6X8Vavja/L
         YLuhSHHIG97DX4Vku+lKQ2EJXlBPD/S7j+2GLvRFfD2GgzMkrv7scQDmx7PLk6QJ1GgM
         PWl/PkvzVNw4VyKwJyFRKazgq68h2GJlW7EhU+GrXvvPro56OQPXNhQqGpeX/40ymLxj
         7tR/YLUgNyo8tuk6Uk9aJHZSZmUdSOHYHEUPJLAjhJgoaJmYUBqB+4vV+axs4J55hgKr
         2hbYZSc1NAORavxZXXtqrACfeAFj/iDoiX+nZltzr1sjsdOsP5t3BHwzH8Yqt/vVBiRs
         Ej9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169462; x=1794774262;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U6Ai3RX3XOfep+2NZPYc+asEVycV3qACLtEG8MfT9tU=;
        b=sGt5vIIOt7wpXefJZZ2VFkEtRvQPEQiVmClF6KZNw1oQhWEHpk8He+cijqTYUpuBwz
         Wxkuv3bwGdvKhswOqquYjqh504mixld2bJYSW0SBKzk2MiUyJ9oMsPaYx4Lbx2QeDMih
         Jq1bOstV8Gfb0kZ0pBxDuXwLZxiUZI9S/pnCXJsoz7saEAy50AjJcpME1PUwa6IkQ5zG
         rgfepl/D6UdgoI6Phin2KyghTL7bV5oY7PpbZhlV3ujduGW/zqOfLU2gYrzNcSOZldwJ
         cPUKcX8Jbw5yJykOSDlZ0BNOLveibtWQ98iyMjjgIHNt/EAdCsJamJtQ8TQ/Upeb+wJp
         nRQw==
X-Forwarded-Encrypted: i=1; AL+hErEGYOiq29Po6NBJM86XYUlQLVADhx8zGmCw8cx6kO8cDQ6r5gS+iulzrPQljeLuJ24p0jFiiicPNtiQYDaezNjbovrYdw8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lu+g7xuVLAK6SmpiHPFGXdDhKMyotwidIhB4M4B6DcPzRetKf
	o2BieCMxXaPnCGy4WJ+/kJdea3pasU+eC2hbTo0PuPTvTeXIQNUPPw6cPYKUKuus
X-Gm-Gg: AYBFou2xb8S7d7U0WuwRbUXnuzXox0cc0UtnuiEigXdjhlV9FVdy/TcRgO3MldCXWsR
	YErHTOSK1UQtVO0qXBPj7pa+DaxiM2z++HqluMxb2nBAKCoT0vEsoefwQ3H3eKK0sRDpib2Dc+g
	xQPuXhuvEuNlOGfPJMJH6Szz62QTAfykVxdCr8arCgpoDmTBo1qrVg7iGJwFqkaB6kyrjOPD3va
	CDSg6RCX60MdthjeZqVkRjDDTva6+7lEAX9crVrIoO15W9188Q+lsf/RdQK8xUiZW1Tyf1CoTGb
	kQC47D878CzE9yrvjXa1pmJhrxmRNEj2bvwpj9B9ZnMN7ITmuEuGqvuw2W9/i3WSr/wnjxIkWgs
	hVSk3+1pOhJDmRcPgYCs/GaTE9heDbuCktQKOkO0jsz8VpzWEe+M0uDnIEw1l7VTlMKOibpSUlq
	XJw8aNn04zr3i9X6sIqYcGmQn/x396kByjX6QsbYhDgOZqSxKNXAZXIZ9/Fb7OkRPFEy6v25qpQ
	AiVsaMoh7sQbGm96HKPzpKEScc8eG50GNlrLBTYdbr6srjADRm/c8eSoKdaCjhXeBfK/KhqvbFI
	BnhfbqepXv/WgwSiC71MGp1NZ/LZ+yPlSO9wcj2Ftm5Pb+RRsg5fBg==
X-Received: by 2002:a05:600c:3e88:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b963c8809emr38276815e9.35.1794169461719;
        Sun, 08 Nov 2026 12:24:21 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fc31sm5714139f8f.48.2026.11.08.12.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:24:21 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 0/4] landlock: Fix REFER in layered domains
Date: Sun, 08 Nov 2026 21:23:47 +0100
Message-Id: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOwQ6DIAxAf8VwHqZFtrid9h+LB8CqTIUFnJkx/
 vtQb33Ny2tXFilYiuyRrSzQbKP1LoG4ZMx0yrXEbZ2YCRA3RCi5lnxQrh686XmghgJ33jUxLZc
 0N7UqtdEEWkqWGp+k2N/Rf1Unx69+k5n26G50Nk4+LMcDM+7eeQsKQBASMUdxL68ceeu8Mn0BA
 M92VHbIjR9ZtW3bH7NpTwjFAAAA
X-Change-ID: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

This patchset fixes a bug in Landlock layering,
reported by Dwi Siswanto in [1] and [2].  (Thanks!)

The bug
=======

When Landlock initializes layer masks for path walk based checks, it
unconditionally adds the LANDLOCK_ACCESS_FS_REFER access right to the
handled access rights.

This leads to a wrong layer composition, in cases where the following
layers are stacked:

1. A FS layer restricting REFER, but also allowing REFER in a rule
   (e.g., handle REFER, but allow REFER on /)
2. A non-FS layer (e.g., networking-only layer)

When these rulesets are enforced **individually**, there are REFER
operations that are allowed in both rulesets -- the ones that 1
allows.

When these rulesets are enforced **on top of each other**, the non-FS
layer starts enforcing REFER implicitly as well, and all REFER
operations are denied.

This patchset
=============

This patchset fixes the issue in three commits:

1) The fix, which should be backportable to older kernels
   and which is CC'd to stable@.
2) Regression selftests.
3) A more elegant fix for newer kernels,
   which is intentionally *not* CC'd to stable@,
   because it would break on older kernels.

   In newer kernels, we already add the "REFER" access right to the
   handled access rights when we merge the ruleset into the new
   domain, so there is no additional calculation to do for it.
4) A documentation update to clarify the situations where the *_REFER
   right is implicit.

Please let me know what you think!

–Günther

[1] https://github.com/landlock-lsm/go-landlock/issues/66
[2] https://github.com/landlock-lsm/linux/issues/67

---
Changes in v2:
- Rebase on master and resolve conflicts
- Fixed documentation as pointed out by Dwi Siswanto in
  https://lore.kernel.org/all/20261101125114.19009-1-me@dw1.io/
- Link to v1: https://patch.msgid.link/20261030102411.12985-1-gnoack3000@gmail.com

---
Günther Noack (4):
      landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
      selftests/landlock: Test that layering does not break refer
      landlock: Simplify landlock_get_fs_access_mask()
      landlock: Clarify implicit handling of LANDLOCK_ACCESS_FS_REFER

 include/uapi/linux/landlock.h              | 17 +++++++------
 security/landlock/access.h                 |  9 ++++---
 security/landlock/domain.h                 |  9 ++++---
 tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 15 deletions(-)
---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44

Best regards,
--  
Günther Noack <gnoack3000@gmail.com>

