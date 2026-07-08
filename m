Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1F37E307
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517997; cv=none; b=S7XhQ3mjpaa0XpTwXOMtFP/G+qHKHZWeGI91b3b72vZTVNYOuWt6TyPv4/IMsTbN06RX3hQivZvi7JzAYHL8tJgIMhGkV974PgrAt9ZLVtzlBGN3cZg5gYXHyIF4ZS7mo3m4pYL758s5g3lsBLSvyVSAJNxiNbDTxKXXJFoDTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517997; c=relaxed/simple;
	bh=EfgRCJzdwKtQeC+ptOLTH1ALZqbkPTSpfIsSP0tHbf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZPLeGf3OVt515L1l70QvIpoowFclQCwI3wMg5ubGzC9D5GAdDobXvycHCmjK6WbGdTXN6ADoBiAdMQIgJIc0gNpP5slcT/GLiwFMC0IfrD0AUQON9RCPPepdd85YglPI7qZU2BEvPkVlu4lcj53PvZMOJGckDUEpZz2B3fZIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2PvN4cf; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2PvN4cf"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6626b5ace23so2511589d50.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517994; x=1784122794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dX/On/fEvkz88OtmZnG2fe/TvHSHKMys3RrO8o42iFA=;
        b=j2PvN4cfQleWmPZo24hnBo4b26LyHX97TDEp2y17NQOl9Cm2W3t7t/dNVXxdHy1eof
         bMdSQt7vcz3Ne3l3jU5eSVUPkjujKZeoNI7YY3zM6XlPUPn6ia5IJ+0uIfmH2csASFJi
         3AeRLeXxFHXaUj7G8YKh4TAWiILuSB8AZSKNSgmfV7KGM1caMbbpnDKVadgh5wKaZdFK
         XMmkJQJFyHlOaSrr0KOefo+PKPqfehIx+2EBGZ2aN6SB4/q10NoAGgZSAUuC+zAgKcCX
         s7kkAG5fLF19NHc5G6V4Uyxb/AdbuX9jcaKmk0hDSvJGC5SbRHTRyzgnItesnRBLCWuG
         xFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517994; x=1784122794;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dX/On/fEvkz88OtmZnG2fe/TvHSHKMys3RrO8o42iFA=;
        b=hRXb3UnZKfdjstPmOTUmKO4dcyQk1WkMj+KagmoLJGGpEPcEZlRA1naQttk9Ohlr8B
         RJc2VWkFQeUXUhOn+ZkfkFMkQhy58V5L3+eW1mBkqTvdXnzEWwBNLyKOIOWF68x/snmf
         sEV03MtVnGp0Z1VlBbbcNYNr2GWaeNldAmEh3JCJblrmkLrFmb9zsOEVvm6VXpRROX5D
         2UGnWGoGyUWtjMKOagEUiu6yg3+GXooaC1Pyi3OvUGLUcuVJA2C27LihD8QS5QHPZIbI
         CmVJVh1hNAps1ReMaxHl4RBvXL7KCKRQiuwGc1WfUP5EKWrAg8cfOi9qUMLeqOL1Y2vM
         hjyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp42mYMvfPf5bQZEfkpSWLwjWL5rkUcI0610aYXbGfCZUrk0+O1KGNywd7VXdCYdkxO7TzYOmbL7K8yDPOmvmUvNmBSvzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJIUdNzTxV9iYAUA7xqIC2v9gBelpUkamOZUOume1bQAoln5Y
	814kRDBX/m2AMF2JYR6nlDQtIKJrSFQ808wVCYRyP+a/QJYDL97YMo/SMsQPj7n5
X-Gm-Gg: AfdE7cmfeHrqudZwG4QqzGi2TYPt69+eh9wCJblZRWxXOS7lOHSKr/2b+J8WHDoYCLy
	/Nfp7sjQ/E24p6HeDTLZus0FD07eDbu3IR9rgrvB/FeP/yQNf3c1B1KBTL1NXKrfl6yxSaSeh+X
	hev0Vcixzlacke7x7E8heIZOIhHKkqdHwNqlPazTDZqe4L/FO59KAn8CoYX4Irobp106HLI5PlF
	UviUvrF/MMLgvUFnwVSw0qW9Lr6WsoYkeqQmvo3LdLMwyPRCzzrCP1RHza4L/NUofKjbepS3U+4
	TsAErej1pFmlv2pzgdqlxTZ2ivkpxZj7Hg8/OI9ANa+7HwU0BtaEcHZiAYfYvCL1s4bR2M/kZ3Q
	t/EBgA7rKxw378YeV2j6i1T2n9AumJmy6q8e0yFyy/QRPH+FDcXgfdUWBuAmdIwwktzfUELLLOV
	7KaHQikjhv7eJOmhf8z0A6h/rTP+4qaZ/VxQ4q5mZgXACXX0A=
X-Received: by 2002:a05:690e:2485:b0:664:dc4d:4f with SMTP id 956f58d0204a3-66788f65f75mr4026641d50.38.1783517993868;
        Wed, 08 Jul 2026 06:39:53 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:717c:ccb8:c362:d995])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a2db1sm2087969d50.6.2026.07.08.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:39:53 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net,
	linux-security-module@vger.kernel.org
Cc: gnoack@google.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 3/3] landlock: Document LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Date: Wed,  8 Jul 2026 09:39:27 -0400
Message-ID: <20260708133928.852999-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708133928.852999-1-utilityemal77@gmail.com>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document staged no_new_privs on exec, following the same compatibility
section style as previous ABI additions.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5a63d4476c1c..1d779dd7bb5f 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: June 2026
+:Date: July 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -789,6 +789,25 @@ when at least one sys_landlock_add_rule() call is made for it with the
 ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
 object without this flag do not clear it.
 
+Staged no_new_privs on exec (ABI < 11)
+--------------------------------------
+
+Starting with the Landlock ABI version 11, it is possible to stage
+no_new_privs so that it is only set at the next :manpage:`execve(2)` of the
+calling thread, past its point of no return, using the
+``LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC`` flag passed to
+sys_landlock_restrict_self().  This flag may be used with a ``ruleset_fd``
+value of -1 to stage no_new_privs without enforcing a ruleset, and does not
+relax the no_new_privs / ``CAP_SYS_ADMIN`` requirement of the system call.
+This flag does not change how the next :manpage:`execve(2)` itself computes
+credentials: set-user-ID, set-group-ID and file capabilities are still
+honored for that execution.  The executed program then runs with
+no_new_privs set, with its usual effect on subsequent :manpage:`execve(2)`
+calls.  Staging is per-thread by default: when combined with
+``LANDLOCK_RESTRICT_SELF_TSYNC``, the staged no_new_privs is propagated to
+the sibling threads along with the rest of the Landlock configuration, and
+each thread then sets no_new_privs at its own next :manpage:`execve(2)`.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

