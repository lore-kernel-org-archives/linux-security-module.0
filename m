Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07ED2609D6
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365640; cv=none; b=IdRm7fP24aUrZgx04/pf60vLPua2yOtVbb6JlKhlj3DmH4ryf4BTTzVgSlVg75V0D/E7LnOgb6M3mS9Lzs0AWZMqV2fPk0PMU81DppL+4TQ/7nbP8v4lB2T3ILjr+5KEKrG1xP0lvAighmeZleiRdzSt9JXzKLFOVD4A2JzaVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365640; c=relaxed/simple;
	bh=5BbBznXQTow1KHJnCYxzJ0cp7oC/SzTbNF06vLrk3hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WraP2exzGYNC20E8UkXoPN5+sAAviAs4dAiWXG2Pg2MkgY1CUvjT8/2gfWwGg2vaApIKweEgtWY6oFzqX0reJS75Fejjp45eQwEaVlDDK5mNkM1BRny9p6uQrF+DIeLCqKA5aQdqv8/iBI2dU6Cm5cDA4NTHSvOIBuFNyVREbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbfRITeL; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbfRITeL"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63f74b43db8so144145d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365638; x=1762970438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJq7BTsG2XzZic/SgC5UxGpcf1RJzc4L7T51KtvfLyo=;
        b=jbfRITeLfkC3jyllh5vFvmEBS413uLHtHuwrVEmofRwjophmGmMeQoPxoO68IQLnZH
         Dq7BG5hcaLDUxNeJ6ZtirRiXUG3y8Nh9f96lXp6urCH9dL9nsGC7FQNOts5xunBzbwne
         4qObNYnH3SonpeY5RcqvuI5WnksXZWVMX1xbasdftx32QrsJj1x9yNl9YS1OR4bX6TTN
         CXyBjb96T4NWYcDCuKmJoX22Hf1H+EYBWWeLe9TmC/EtipNrTOx7r8Mo31HmnJbm1a7p
         CLyTgZzNCCpYXlJt7ItsoCpmF8S22k3RISX9f2ZXEtsUAL65U6YAffGOKWaCd1zPfeYO
         6Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365638; x=1762970438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJq7BTsG2XzZic/SgC5UxGpcf1RJzc4L7T51KtvfLyo=;
        b=Vl7LRDceGxgN0i7gS/7vIO/K1i1XPC+WR0QjHcR+nNX7BOcin7vpGaZLrF0WY2Dch3
         HhOZNcOJFAszFtFPoT64reA/XDYbuU3/SER2RWvdv8blm9294n+3aZfsA2p+AuUhJLU1
         UQXEXAC9hsXI+CdZ37CtzrctchV4Zlfb14abtYYMNv4nR9Ow3r32HaNsjIrSQPZpMtbU
         FAFHP+K5NJISlhe4yVvfhx5jJqClrfXtYhhQf7Otd/6x/vnlQiTpw9DAp6vKZBBzWbQb
         GR++j1ddEgfj5HWFod3diq2oa8f0L5hEYBNi/JtJ3z2I/Jq/a5eCnPh15GPHHeO7FhCo
         4iJg==
X-Gm-Message-State: AOJu0YzhXfTn0o108rc1VnGzCwBfPSFASfumh5lUYCdFWGMyLXvoSIVD
	RvvytypmXQE74uVNreugxk3nzJf/INOaH25VoXrSVfRgPH22tSX3xCB741VIUGgu
X-Gm-Gg: ASbGncv6qfkv94UQp4/AO2ywCTmq7XetiPC+y7x5Uc2UGSs9QK5SivHkBksu4gt7C0l
	k+yH05DZL4Qa8CZ7tyP403qtEkNMMuLT+HEyI/3DTcVZ/IOXxcO17EWoDKyRkVK90/uiB2fF1Gp
	aaEFaFzOCJ2Hhn5j9WumJLPPLzt5ww5xpGAQCfJSHqUgPSP8vLzI5nXYkymoiESQOvf3txmhl/I
	gB0s1Trr+2UfjqulhOpXzTnE/pkle6qjO4yu/Ra0F2kcEd70n62EBz2FY0nHlbTl5YklSO9HmqE
	2WXHJtelb3oQUGw9eW0wrmnJ84kpyAna5Bm8IlsXY1Ct2SODMMvqWR3PZzg8sFiWCgNnWZfgOsq
	2Xzprh5daO1zN52qa5sERNABPwcnFVol06IDga8u5HICFMY1WOPdtD6yU3XDFmMz8mqG/q/EFXy
	l4/kduBXlOC4z5WVY5ZWqaAQCDzNh10c4C2AAv20u30vBn9NY0P7fvH0Vu0u7/08CY/IKJnR8=
X-Google-Smtp-Source: AGHT+IHJhb83m7DePL2YikfAstr8Qv2+gLKMyO8Ssfa/CA6JOslz59L+9lICNzIwodNBtzjfEIsKbQ==
X-Received: by 2002:a05:690e:c43:b0:63f:b18a:7819 with SMTP id 956f58d0204a3-63fd34c5224mr3432199d50.23.1762365637458;
        Wed, 05 Nov 2025 10:00:37 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13faf56sm756657b3.19.2025.11.05.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:00:37 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 0/3] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Wed,  5 Nov 2025 13:00:16 -0500
Message-ID: <20251105180019.1432367-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch builds on version 3 of the the "quiet flag" series by Tingmao Wang.

v3: https://lore.kernel.org/linux-security-module/cover.1761511023.git.m@maowtm.org/

It implements a new flag that prevents inheriting access rights from parent
objects within a single landlock layer. This is useful for policies
where a parent directory requires looser access grants that its
children.

For example, within a single ruleset / layer, given:
    /a = rw
    /a/b = ro

Under the current featureset, /a/b recieves rw permissions because it
inherits the w permission from /a

To solve this, I add a new flag LANDLOCK_RULE_ADD_NO_INHERIT which
suppresses parent permissions.

For example:
    /a = rw
    /a/b = ro + LANDLOCK_RULE_ADD_NO_INHERIT

This grants /a/b only read permissions.

Design:
- When this flag is added to a rule, the landlock_unmask_layers function will 
  track encounters of this flag in the rule_flags as it traverses up the fs tree.
  When this flag is encountered, the access grants of the current rule will be allowed, 
  but further access grants by rules within that layer will be suppressed.
- Access grants made by rules in other layers will continue until the access requirements are satisfied.

Demo:
~ # LL_FS_RW="/" LL_FS_RO="" LL_FS_RO_NO_INHERIT="/tmp" landlock-sandboxer touch fi
    Executing the sandboxed command...
    ~ # ls
    bin   dev   etc   fi    init  proc  root  sbin  sys   tmp   usr
    ~ # LL_FS_RW="/" LL_FS_RO="" LL_FS_RO_NO_INHERIT="/tmp" landlock-sandboxer touch /tmp/fi
    Executing the sandboxed command...
    touch: /tmp/fi: Permission denied
    ~ # LL_FS_RW="/" LL_FS_RO="" LL_FS_RO_NO_INHERIT="/tmp" landlock-sandboxer sh
    Executing the sandboxed command...
    sh: can't access tty; job control turned off
    ~ # cd tmp
    /tmp # LL_FS_RW="/" LL_FS_RO="" LL_FS_RO_NO_INHERIT="/tmp" landlock-sandboxer ls
    Executing the sandboxed command...
    /tmp # LL_FS_RW="/" LL_FS_RO="" LL_FS_RO_NO_INHERIT="/tmp" landlock-sandboxer touch fifi
    Executing the sandboxed command...
    touch: fifi: Permission denied
    /tmp # LL_FS_RW="/" LL_FS_RO=""  landlock-sandboxer touch fifi
    Executing the sandboxed command...
    touch: fifi: Permission denied
    /tmp #

This is my first patch/contribution to the LSM subsystem (and the linux
kernel as a whole), so any feedback and corrections on mailing list
ettiquite would be appreciated. 

Very Respectfully,
Justin Suess

Justin Suess (3):
  landlock: Add flag to supress access rule inheritence within a layer
  samples/landlock: Add no inherit support to sandboxer
  selftests/landlock: Add test for new no inherit flag

 include/uapi/linux/landlock.h              |  9 ++++
 samples/landlock/sandboxer.c               | 39 ++++++++++++----
 security/landlock/ruleset.c                |  8 ++++
 security/landlock/ruleset.h                | 10 ++++
 security/landlock/syscalls.c               |  3 +-
 tools/testing/selftests/landlock/fs_test.c | 53 +++++++++++++++++-----
 6 files changed, 99 insertions(+), 23 deletions(-)

base-commit: 77903de728f2a1ef40a31a3babf861b8fbf9530f
--
2.51.0

