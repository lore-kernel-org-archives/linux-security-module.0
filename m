Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20531326B
	for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863574; cv=none; b=sK0slTYx7pg63yRg2QfEYmGpzF/3sgNw+d/kdIJGDS0ZNvZMbHoSZw45y8/SHl0wokcpsBdjtHJiKK1ipRO1x8Q7QNd2IDtt57F6NQTm+W5lV0X5j8hbRQ22bp52wAk0e5WUoEniQxqH6bI5Jm0WDBPxu65uj8cb4NRtdrf/1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863574; c=relaxed/simple;
	bh=RjKD6/7f0V5Pv8dDCdBDZirn9vm90RAC+82O3MrCRRU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=fOT14to6NA0AwxFkqDGOxCe3BKs8yEaacUNMwFRSm4HMziyh6SRa2864UgWVjRjaeA2clzTPAYvFr8AgX8K+H4SEkrLE82JNjbVKQBNX56nOuJ05u08kS5POMAUMkySCpNDOTgHNaEoQ9E7Uxa81YsUEG30LQc+mhoO5mswVMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BMH8lXfl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BMH8lXfl"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b69bf5638so28462991cf.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775863572; x=1776468372; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKeEg/Y0drNcc2Fnb+CIsFkFz7BP00BXAJeV9myWHSc=;
        b=BMH8lXfl4nHqxsnBJVqLTP9jrD/+5fkMOJxB/Znhmp0DO+4Jb21IHM/aW2KZZWseVM
         VCIfAafNwRWsinzuGCrfesC7ysy2J0jX8BDmFyBI1N5cCmHESqXCcYEb5F5paW1U1mJN
         mKEfBa1rky1FrRLCviQ3/O9m0n2GNmmqSTJm76dwxQlnn/LT++cngXGXN7wiaMAAsNJ0
         Y+bqoEr1jAEPORBeXqLKcvSAHFCnGzrWlejOqYEv7hCQStX9cOy6C6gJ8Mqui14OwNSW
         Rd0LXgOeKMQk10cIrWayAY0STjTZMpaj6j2taeAZox8j+r7hv7FkKp1BG5kZBNRJ4GeZ
         7D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863572; x=1776468372;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKeEg/Y0drNcc2Fnb+CIsFkFz7BP00BXAJeV9myWHSc=;
        b=mrRNkoIl9BX0mpgrTjx5UjavZsNJBjRvhKuE3H1VvBc7WweMh/dXC1t7neogK5lYSv
         4ch5rVOKLmxd7xIdGFS8Sd7R+lAtBuY8F+UgtXPUeCENPnoWc80fhrWQilHT0EzZlBbw
         Y1oMnrbpD1YPmg44XNprCj4OYfYKUT7nxXkhxj46VBpwPyygADKRY7ZXpXOPP/ESuseQ
         zudo0RfKhWVqWCQNvhRkuo1eXaLo0K0niBdy/mrSK7WiDsKtmlF9TEIfbfB40J0Lx7Cu
         /g4IZ9qxsMccQg6jPJHTDOIOp0mgdHLhgnHy28Hj+UgpL09fA368mHUvbb4akl96yc43
         IClw==
X-Forwarded-Encrypted: i=1; AJvYcCW+GZXSNeNTR5tUZKsaKFqZKCH75bRmdbR+uvetxl+BxQVxQOkLIFiPrpAoe1LW4sQ7TSWbbGBLkMMSxDS/zVT1lImE3xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Mc6tgaD/MyfzzDePdE6cJ6JcilgfO74ryCQMI4vhUFqDCEB8
	SSPLrAZge4TA33CMfmn0L9F/Gj9IQ4DQvNNFBJdHtlt8E9W3PfuA8Qli18ogljtdyQ==
X-Gm-Gg: AeBDievWDlOS0einldMtzOSurp/dowXvuWrR2TW9XqJODpcwpXUyX8Ecw34m96gbQSZ
	EaCIHNrEvPviTQFdplYvWv3zj5oPl+B6an3DVYOW5uBzyQgCXTRisaL/G98lJt7FwhyeTyc0sK9
	L9+uJDlkTDhi8XpADSf3FXisaVW0T9vT3cyswc+h2QrwEahz0B2TtoKZzt0+j5ck5+0zquakvok
	PpzB0FM1WGNJJIAAZyPwOZSvr1HU0MlG7nKEYAzwOG0oTBrsBnhd1wwzQHbw07qByox0xwfesja
	fifBYQmcOYOc2bGdKlvuxGbz/HwGuycwSImVGVTv9MVcesltEL9SEcfT7YFXV+IXceLJZSPIYmy
	h2WB8wzw2wu0LAk/r+sbUYLL9DTiQXDIO0UKo1OUpJnIqo8RB43yMmU7CCC51M+900yU9Yj2Iea
	/dZAMTyKzMChDbWFoUZWtxBnaROF99ChubaFyn54zcJku/4YZj3g6kDvzxoPdVlWkEQdVoh0h6f
	b9JQV8=
X-Received: by 2002:ac8:5d89:0:b0:50d:6d90:31fc with SMTP id d75a77b69052e-50dd5b95d29mr83445011cf.13.1775863572287;
        Fri, 10 Apr 2026 16:26:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c4af3dsm33861406d6.31.2026.04.10.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:26:11 -0700 (PDT)
Date: Fri, 10 Apr 2026 19:26:11 -0400
Message-ID: <60af9bced9ea23be5deffcb469805ff5@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260410
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Just a single patch from the SELinux tree for v7.1, although you will find
an important SELinux fix in the LSM pull request (if you haven't processed
that already).

- Annotate a known race condition to soothe KCSAN

Paul

--
The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260410

for you to fetch changes up to 8dc51459ef702bcc0ef5fb26bb4d362b38aa56c2:

  selinux: annotate intentional data race in inode_doinit_with_dentry()
    (2026-02-23 11:14:29 -0500)

----------------------------------------------------------------
selinux/stable-7.1 PR 20260410
----------------------------------------------------------------

Christian Göttsche (1):
      selinux: annotate intentional data race in
         inode_doinit_with_dentry()

 security/selinux/hooks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
paul-moore.com
