Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DEB18872D;
	Thu, 23 Jan 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661712; cv=none; b=BOHhoA0476z3/5TRqmIFM0G46eVWpuIiFj4qwNjudqrze2zxVNES4I3yCl3Pp0JMHTLeptvGwTfGUapOpd/4QJE9cC8IkwotlOuhUaJbBQQcZqE554/fYa/Dd8e5z9SMpI5Dns61S0jA97O6WrX1Arr22hQkxMwW3lsD4arHSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661712; c=relaxed/simple;
	bh=NuVtlAXxonMhqh9RYY3q81ctUqt11M14T0GzXAvF4Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aacc+HDVWg5M8UkpA11B0iFL7XL8EgeL4SUMMazfS/Jj/ma8EacktqBmcB3Li6rQEATOyPoxJl/j7ViGd5hiYbqGkWn3LubTqt8z5qNJV+ufnF5sq6QsY6TB3XKirjk5HVUGNrDMBTP9dpK/AEOu7YN32Hdw2yIlNbDwI5ek7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw7PLNWU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw7PLNWU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so2574153a91.2;
        Thu, 23 Jan 2025 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661710; x=1738266510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDbzEEjj7IXYYLbCpl+1f4yVi5aNctB68vm0n7Ny/lo=;
        b=gw7PLNWUnmZjFpU1rGvpgRub2hHVKKZtuBIyF6+tiCMKBN1do6jwFr9DjG8nkPsMge
         2KpE03Vs0fQzRn/v5C/rfCfA64n9cwahCqLz1NeRPk8CUG3IHdOuya5b64fkuOD/4kq1
         D3QlbQKDMmBu5OTRPY0UF9M1to5J6kuLDi4Gr1r8up1CcQSoyUApzdRECm9Q7EV0bYY4
         gbj8ty9AWfwXZzSw5MJj+e4NpA/CO0JqUMtWr4nYFdTPxLPLFJOtPOnbM/FemRvII/et
         gMQkscqqPd1ikeeNronnoDlJPxbHDrykNahD9KqyLA+0uFLqKQB0oLjSG+OUoy/Km781
         Ed0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661710; x=1738266510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDbzEEjj7IXYYLbCpl+1f4yVi5aNctB68vm0n7Ny/lo=;
        b=hAHDvaQgbXUCkku6J+cXnL6s8InoWcGeeW/SxocdNlfYM+eWWMfzL3SyDtKJv1SBem
         x2SlkLvmLrMZopJBs1RaXnVx6EqRsZszUiWj62cu7+pjIPcmF8UznGhqr5GEfiYKnLlh
         qQznWUHthuJqn0r0otVJk7PUQ5RHnX355uoxyOHeQisa9D6qFB9EMZnmbvyV2Ifizuod
         1lYZvcxvTFt1/2pKeY5IHYnhRuxuye5ohZkFhpb8HCT1aY3UHdQTKC4jMGYtdKb2X4V9
         PwEj9uyPLDa3ErA+rjuHU0d99R639LwOVWJWEu1QnT9jAkz4j9qub+/mnidRkKZFwORD
         dQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUSPMvad4K4lSm4Dz2hMEmSmYFvHaOs6C8fZiUJ26Ds3AbAQHG+v5Q7t/BGuLzHKXm0uvJzSwnhp7RLZoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZZ1nIiPDZp0I9zerUZJ/dOQr/qvtvVS3m9klxZDnmbNDjMxO
	Y66MymEg033HQQGVkVFH01Y2hAO2oOJFoh2lFvRjU2KO7LFJRB/I
X-Gm-Gg: ASbGnctmhs0BNkC6DZ7bdOr+6o7o9ebb8IWljTRRjuAH349HOg2zlEFthmnGX06pKJn
	Nt/FdcRisbRuw0ROs4YPOIU+ntB6tJyL3ygfDPcJlJ3iqsQMHRmrYx5Hzx/a8benHiveH6f4Kr2
	HtawPeGW6YL/2m7IYcNEgmv5Mv+H6UVRAXI+geOA4rex1eaqwa5GBtjt8ZfB6K4ginDNuKxw3N9
	JWLQ9jR+YsSHhxrD69LwJ5r3PBZpoNX51Eys8dp2FpZ/TIVrBh5ebuIZII7BT6kBSsMlEA+z81l
	2g==
X-Google-Smtp-Source: AGHT+IGsJwobmrrgEFKH0Z/0DPCOu4irsCPtYB7q1wid6HODeFM/LtgmABD8zKRT/O3L8dHf3giyLA==
X-Received: by 2002:a05:6a00:4fd3:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72daf9becfamr43475560b3a.3.1737661710308;
        Thu, 23 Jan 2025 11:48:30 -0800 (PST)
Received: from localhost.localdomain ([122.174.87.98])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ac48fa81b1bsm251947a12.27.2025.01.23.11.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:48:29 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: zohar@linux.ibm.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH] tomoyo: fix spelling error
Date: Fri, 24 Jan 2025 01:18:00 +0530
Message-Id: <20250123194759.2759-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix spelling error in security/tomoyo module comments that were
identified using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
Original discussion:
https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com

This patch set is split into individual patches for each LSM
to facilitate easier review by respective maintainers. 

 security/tomoyo/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index aed9e3ef2c9e..9a1928be707d 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -913,7 +913,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 #ifdef CONFIG_MMU
 	/*
 	 * This is called at execve() time in order to dig around
-	 * in the argv/environment of the new proceess
+	 * in the argv/environment of the new process
 	 * (represented by bprm).
 	 */
 	mmap_read_lock(bprm->mm);
-- 
2.39.5

