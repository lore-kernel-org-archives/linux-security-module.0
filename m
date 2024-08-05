Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F715575D
	for <linux-security-module@vger.kernel.org>; Mon,  5 Aug 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858882; cv=none; b=ajTr/mFRj8ebmFV7MLLpEieNCScsiP9UqJKDfiYSDJFnnXpqDNaSfr6eLtcpL1HCFVeBsR9SE8NJSK35HYIq5eju2kfFSlO7hTfkm4+ZgfLIyvVVa/U40k2Ngu5Ue5xvwAns5lyB9UHceu/Ry3Y9RJvTN9Xh1YABDDi+leOEevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858882; c=relaxed/simple;
	bh=xCLopviYo2ZXTYyWMOwauyIB+j+mPVPtuS1184F3o4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oXcW2mIcdRtOKfMvYvsl/alL57wXnvgVm5apwITKETiKfD8yAN1PCkWuZvtirXP17zNG33mEGGiJXHGpzGr46qVexUkuoa7kaIX5zUz+udpbeY8jZDhb91e2x1Y/DXwWS3qoEhmUhYZph1f3Xm7YrfQDJln4V4jQnq3qoDbUu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AT14iRrm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AT14iRrm"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so11244a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722858879; x=1723463679; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkOFFi3fndDmXAZbQGGoKZ5kT7GLEe3o2kwoNptV+Do=;
        b=AT14iRrmKC9hXh7gngFQxc2mwSzf/UuMhBnTlfDjVRQfVsCbuYD2EgFlixahsJjb9S
         10awegSSHI5aQYTRcobSGFtBS1Ual7z/Vr6p4sfMVFRd0wGqHbmv4NJeEyYWH1LgOGPc
         SnNzwVKx1pLrv8jvWxGgeO/foBSlCxE0Hv3EpAvlYeUuql35DmkZAACeY87c8NSIuj51
         PNRKCkDRnCZnz+I11jVrLQPMr+PQJPTzTdl6gsQ/07Wwt9PcCdbVgIl/cBf+NV5NUxzK
         4Z8eQ/TdWBqGFRSuhPyB9tBgXqe4mumP9/HVuvGOxpL3XhrNdAjhZ23lHXnPFi+BGOA8
         EJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722858879; x=1723463679;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkOFFi3fndDmXAZbQGGoKZ5kT7GLEe3o2kwoNptV+Do=;
        b=fnVcqoZhp+X8S/WqmcijVyKYJ3kNiXDgL76hBlpov+CBWjO2UqxSJdryexrJq0ICWn
         RPbHcJw/2oonEyU/7wHymTORy4V82V8i/r4RzsqbFOKiAnoUWBvq/mutwOtY3Sd0x/0w
         hUQylL06k+gwVch+EI7lDkZ3K9OwwqPI47DBrRQj+p5H7b4nLaYF38ImW4Oe3LYqZH/A
         fHFj4TsnQlXZJTcLSn6yEkMedIUvWT/pBJ/2qMZg9H5mL76r+gO7yypL5Fub3PBPrlrc
         w+PMZrSKxLIVnwOMxTnUIT7/rCFIm/0KDmXcctkceZMVh3lYINUsOUwo9D3Ivz//jvLm
         H44Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaW3YaN2xYvwBtvXueYjJRHrAnNkitrl5KxEjI6bokao1LSGmjX6EViMm51bFCR5ulaw7hcAhBsSgskk6HsM42tFu+9aPZxMP/bKW6jEX1D2K/cKu2
X-Gm-Message-State: AOJu0YwHbh69sE3P3Dmlk1Trp4wgEX7E614ptLHgehBNhnhuG49Gbham
	IJknDYVqYmXv4AZtHPAqWtQGqHVoyYhqfCL58Xz7VPszvVWYV4OP6WTO/C+GsA==
X-Google-Smtp-Source: AGHT+IFTCqm8BraRgc7Arigoqd1xWwnDt8TRL+WMTE5E5SwinOm4fQ9FXs3JPpX3++/idLohQVMSeg==
X-Received: by 2002:a05:6402:520d:b0:5b8:ccae:a8b8 with SMTP id 4fb4d7f45d1cf-5b9ca81f252mr255490a12.3.1722858878268;
        Mon, 05 Aug 2024 04:54:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:ca74:8a49:a6f6:b872])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd02a451sm9692149f8f.63.2024.08.05.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:54:37 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v2 0/2] get rid of cred_transfer
Date: Mon, 05 Aug 2024 13:54:22 +0200
Message-Id: <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+9sGYC/4WNQQqDMBBFryKz7hQTRWpXvYe4iOZHA9WUiYQW8
 e5NvUCX78F/f6cI8Yh0L3YSJB99WDPoS0HjbNYJ7G1m0qWuy1upWbCEBB4Fljcxa3QQrtvKVEP
 TNtZoytOXwPn3me36zLOPW5DP+ZLUz/4JJsWKh8rBKThtLB5TCNMT1zEs1B/H8QUqzJ30uQAAA
 A==
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 John Johansen <john.johansen@canonical.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, 
 selinux@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722858874; l=1982;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=xCLopviYo2ZXTYyWMOwauyIB+j+mPVPtuS1184F3o4k=;
 b=X1YK2VuUQ+t/xY7wS6QgxaW1YAPtVGWEsoyQYHdus9WOgQNDyKe+ws3PN8RwStB6L04tlxDBd
 8FXsPZmZOHkCS7IJdSgQL8iclT3gCaPM5MZVPBlypka153iZM8VQVCl
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This is the approach I proposed at
<https://lore.kernel.org/all/CAG48ez2bnvuX8i-D=5DxmfzEOKTWAf-DkgQq6aNC4WzSGoEGHg@mail.gmail.com/>
to get rid of the cred_transfer stuff.

What do you think? Synchronously waiting for task work is a bit ugly,
but at least this condenses the uglyness in the keys subsystem instead
of making the rest of the security subsystem deal with this stuff.

Another approach to simplify things further would be to try to move
the session keyring out of the creds entirely and just let the child
update it directly with appropriate locking, but I don't know enough
about the keys subsystem to know if that would maybe break stuff
that relies on override_creds() also overriding the keyrings, or
something like that.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- use interruptible wait instead of killable
- split into two patches (Jarkko)
- Link to v1: https://lore.kernel.org/r/20240802-remove-cred-transfer-v1-1-b3fef1ef2ade@google.com

---
Jann Horn (2):
      KEYS: use synchronous task work for changing parent credentials
      security: remove unused cred_alloc_blank/cred_transfer helpers

 include/linux/cred.h          |   1 -
 include/linux/lsm_hook_defs.h |   3 --
 include/linux/security.h      |  12 -----
 kernel/cred.c                 |  23 ---------
 security/apparmor/lsm.c       |  19 --------
 security/keys/internal.h      |   8 ++++
 security/keys/keyctl.c        | 107 +++++++++++++-----------------------------
 security/keys/process_keys.c  |  86 +++++++++++++++++----------------
 security/landlock/cred.c      |  11 +----
 security/security.c           |  35 --------------
 security/selinux/hooks.c      |  12 -----
 security/smack/smack_lsm.c    |  32 -------------
 12 files changed, 89 insertions(+), 260 deletions(-)
---
base-commit: c0ecd6388360d930440cc5554026818895199923
change-id: 20240802-remove-cred-transfer-493a3b696da2
-- 
Jann Horn <jannh@google.com>

