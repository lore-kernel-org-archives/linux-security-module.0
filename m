Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AFD376F7;
	Fri, 15 Mar 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502754; cv=none; b=a6L+nSYafwF7jXLqPYPGmqVvrJEtOdtERh0iZ3NypvYbNVDC5e51D3ajVhhYiFNmZDcQfHc/3nMoU18cyv4zrhz3eGuBNdMVsCcq50UKLKN7z9zFA77/tBPm6rrBphMfOHd8Glf5t0plsYIm03sdHHAy9PcFNhYFmfuJKeV5pIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502754; c=relaxed/simple;
	bh=QJAmIMr/R/qhhP5iLDasE89v7Qbj3vjixbDFiOF37Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMpHdYFBblhD/L1XvAIBVoTDk9qOJz/bq31tmeFQa0Z0siM8RnG/bOEhtuuNTxd9IqJjXN8yNTOK6OdIA6wXlmKAYayRzPsD0IhxVAzY1HIvBBVEViNU2JdnPzsHusOhjUsjSvg82qTYGTjsvnO+2c2MBGMFgC/BUAiJPZtAZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=l2qkCp/V; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l2qkCp/V"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so2671037a12.1;
        Fri, 15 Mar 2024 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502750; x=1711107550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J800dkEvUqC+9b6xP3IWWKhHbamO/WxBgmp71qC+xx0=;
        b=l2qkCp/VYsITdhK9L0Enp1yzESEd702Rd8DhLJ4vRRmKxG0ibqzWx0Y0ES7ECuXdwN
         MUol7nlV+0wAUWZ3Etu3d4PXTxx05G7ZWylHC6yanng/6W+RbNfMwrZ22OIEj+IflpYL
         vZPyJIN49Q8zZzb/AkMMUiRW/zDSH+yQ2nMfxjiHJ9BTKPI9zo3HNvCmg1l/QBoYIuIU
         Riq6o5L023zjN07/eTzQ4fX6ClrQB4IvRjkKHskcEYR0le8McjyPC4mRLL5kaoY05lfm
         ATZ1N5YtyNzoQNSy5VIwxhHwBThwPSuewQYx0EMhgeV95NmmIP9eridM7BU66/oSR7V3
         qtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502750; x=1711107550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J800dkEvUqC+9b6xP3IWWKhHbamO/WxBgmp71qC+xx0=;
        b=L1ycpTM7+HK4CJhdxWaYW5KbyJ//7SwRQhI2wJKQdxxdfu8Um2UeZxcqNKb1zk1IYk
         PasGoOZbvaZKtFqee2h5LsYQHerBiH0IYyvr23YZZq2VFjSGjl1kxe8VKC/qCtnJbP1F
         c7aoMeL5VTOj+9gL9q7Ai3alMNKlCn7JWLkVxpy+owNqUG5dI9PZSFyJ5lpWo3bDe++0
         hkncy++iDGCPKvg0oofvY2qo4RmBoY9gKUlXEVa7FjxEcMrOWevCpiziFRP+xBZ4ZYn5
         v9NxCJqwKcUwlBPTOWDuxdrrXdmliRu9FIuPNg3jsNbYruX5ADBLGYJUkYdW/QJiDclB
         UyvQ==
X-Gm-Message-State: AOJu0YzVBs75vVBUSLijYhqpEajS3o2ZpTkS5tbs7F/r3s82wnDr1sA4
	5e4+rVgyd/MGYmYMMswzK+gGfwxDhMyiM+6HRSHFwh6W4DwjlbrcynLch0NjobvqCA==
X-Google-Smtp-Source: AGHT+IGYY4/LaoZpt8ijS3sfjpeG9/VcpayZNgfU3V3G2vZHa7AuywD2+rv0mGnp6CsjzdQ0tiZcgQ==
X-Received: by 2002:a05:6402:5252:b0:568:b418:9d74 with SMTP id t18-20020a056402525200b00568b4189d74mr942705edd.7.1710502750486;
        Fri, 15 Mar 2024 04:39:10 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:10 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH 00/10] Introduce capable_any()
Date: Fri, 15 Mar 2024 12:37:32 +0100
Message-ID: <20240315113828.258005-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the interfaces `capable_any()` and `ns_capable_any()` as an
alternative to multiple `capable()`/`ns_capable()` calls, like
`capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
`capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.

`capable_any()`/`ns_capable_any()` will in particular generate exactly
one audit message, either for the left most capability in effect or, if
the task has none, the first one.

This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability request will create a denial
message.  Using this new wrapper with the least invasive capability as
left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
policy writers to only grant the least invasive one for the particular
subject instead of both.

v4 discussion:
https://lore.kernel.org/all/20230511142535.732324-10-cgzones@googlemail.com/

v3 discussion:
https://patchwork.kernel.org/project/selinux/patch/20220615152623.311223-8-cgzones@googlemail.com/

v5:
  - rename flag to CAP_OPT_NOAUDIT_ONDENY and internal helper to
    ns_capable_noauditondeny()
  - add check for identical capabilities passed to simplify bpf call sites
  - make use in bpf code
  - add coccinelle script
v4:
  - add CAP_OPT_NODENYAUDIT capable flag

Christian Göttsche (10):
  capability: introduce new capable flag CAP_OPT_NOAUDIT_ONDENY
  capability: add any wrappers to test for multiple caps with exactly
    one audit message
  capability: use new capable_any functionality
  block: use new capable_any functionality
  drivers: use new capable_any functionality
  fs: use new capable_any functionality
  kernel: use new capable_any functionality
  net: use new capable_any functionality
  bpf: use new capable_any functionality
  coccinelle: add script for capable_any()

 MAINTAINERS                              |   1 +
 block/ioprio.c                           |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   3 +-
 drivers/net/caif/caif_serial.c           |   2 +-
 drivers/s390/block/dasd_eckd.c           |   2 +-
 fs/pipe.c                                |   2 +-
 include/linux/bpf.h                      |   2 +-
 include/linux/capability.h               |  17 ++-
 include/linux/security.h                 |   2 +
 include/net/sock.h                       |   1 +
 kernel/bpf/syscall.c                     |   2 +-
 kernel/bpf/token.c                       |   2 +-
 kernel/capability.c                      |  73 ++++++++++
 kernel/fork.c                            |   2 +-
 net/caif/caif_socket.c                   |   2 +-
 net/core/sock.c                          |  15 ++-
 net/ieee802154/socket.c                  |   6 +-
 net/ipv4/ip_sockglue.c                   |   5 +-
 net/ipv6/ipv6_sockglue.c                 |   3 +-
 net/unix/af_unix.c                       |   2 +-
 scripts/coccinelle/api/capable_any.cocci | 164 +++++++++++++++++++++++
 security/apparmor/capability.c           |   8 +-
 security/selinux/hooks.c                 |  14 +-
 23 files changed, 293 insertions(+), 46 deletions(-)
 create mode 100644 scripts/coccinelle/api/capable_any.cocci

-- 
2.43.0

