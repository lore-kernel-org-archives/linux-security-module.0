Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1E36EAB8
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138031; cv=none; b=oc6IIoYBzceCG5sJQnpXF+JdA5unj+DQgrK8M/Jz2sivXQ9caMrI8/WXa4zF0SkJPO+ko0BYVkSygPFuySJf+oXyJum8flMStn4smeGCU0mApa6dPugUJ5LRrIZ30QP6+XfS2xR0ZBYJI3AyG2sbe4jmu6sIb1iAlSIAtkdKS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138031; c=relaxed/simple;
	bh=dcMfYcrZvJo2odetIockDZHB6TyER2n5DIFvd4jrOOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/22e4cBiPonVJ2En4pDXvNmBhEplftVcfs9uS4facvukrH9TqRY+Jz/amxjH0Uecnz2rbAvXuGV/7BJ8wrG3FIrZ9KZhf1ic3ZVZCDU2eitU2A53xMIzHyswkDI8Dd2wmG9JeTs6uz+2y13ygH/WlHkCJUR6jqCPWTl6fHSeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fp1SIsTT; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fp1SIsTT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356f6bso737536f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138025; x=1789742825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAWK/0nRwHnvVvMYnd/Ub3wFPGnd0x9DJjP7YOulvgY=;
        b=Fp1SIsTTjVyRqL0gIvM9vDPjIjd4izJyKEciKHm8TONmq1ag0xCO5x8W82arGdh9Xz
         4Z5VG1L95LuGQrrZfZFlCNhUqTPojhGUc7m0c9dbmzYLvDhLFITGryupFkwF1I4B5sGx
         PGiAF0Uz+do2dBAfXZjkAY1nhermD+CNJ2GhgHEC8USAwpOnbw+sC6iesnt9K6n6IKU3
         CVIJFRc6zSGTKWFrAbM9r9/BFfCG5eYbh8zcCvbOyJTkfGBNiaKjkIQsGdbTwWiWza9S
         WE2SudaMNSBYAuSj7OTRbSA+JozgvDM9Med1Ltt4Xu2X8kr5aB0A1Uzyo6Rn/D5Ll3Rm
         W5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138025; x=1789742825;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAWK/0nRwHnvVvMYnd/Ub3wFPGnd0x9DJjP7YOulvgY=;
        b=dc6SFyTDcMqe4QlQcMEaZwpzoQn+Iz/UycWuMPzfx8KmnesBve/C+4+BH+kj7KGYwO
         kUkfN7aq4nwcFdjheNZCliPRii7xEiafSSd3z3Qd9vIrXJr/RKWIBaoMxL4XAoxQ1FhS
         fo/bK1K66Lyhlv2xKYvyvJusFciPTfcFfbfkahr0njPI0m25v70qLh7jnx6N5BVFIZp7
         qnqK+vweBX3kFO8gngPV1/Vi6/pWEjuEIBVPJ1yzyvRCn2cY+WvjtAhm8J/5Z+l9tSaj
         1ocxr0QgNs9cKY4jgbPsVa7oKoJ/1e/OV+WhVhfHObYbvQqEiIF9yZDuEKQRtYcfdwVS
         oelQ==
X-Forwarded-Encrypted: i=1; AKwUvByovMpT3EgUKrZVjztxiNKiH3++AuBv/94jhvSpzk3GmKVaYx421QKs6wsmwZhNo+ikRPH+1ctnUdM9riDej717sOnlXt4=@vger.kernel.org
X-Gm-Message-State: AFuF++mNQ6tu5G6f1Y30aIT0lOeZMjZtPIWnta+gl6snz6WImufxVBZn
	ewc3krAWVe9J8OAzVvEsCO0PDbkhMJ3VzKeNnaLYPmvb0AxgoWQvgz85r3ePC9jKGiM=
X-Gm-Gg: AYBFou29M1oOPjO+v8PoOj8blVeScXxbd+TnpeOk3Oelz4JFYc+uMxdiLNsSQiKPdBY
	vQA9nUuILgAQ3b0bSzcz2zvA/S88et6u+d3oQnipST3QqOSm4kgJyor3dgqkw46TyizjtnKk946
	RczB3H4APeuf6GOaBqHY4zeeJiO9aHYTl2mgKmuI/BTD4MzHNKTNlY6ibszAEyGLRCtBhvp3lcb
	8G9pQk0BuKJMexIH4PfuxihbhDkstTfm2kYFKOspkrTfN4NuM0+qA16HnRavRumgPj8xOnHhWPJ
	lLYr7dO3kEeRtWpPooY34Q+pUeVKX/BBLRQc7hc6oU6BLvsM+WI6KFq7iF1JfwsaUm5P12J3HkQ
	DW5BGo2b/lmcYkmQHc9EFx9gcMtWv91uYs8AB1h/jIov3fTWk7aLiv2L8vATSeW6DmOck/Q+FM6
	QNskoZJG9ebmZ54PLBvpQ2YE9pxmeVBPCNMUkDN1qvyx1WVb2++RkcgEhspadcl6C6GkgK+4FRa
	C5cnA==
X-Received: by 2002:a05:6000:26cf:b0:482:f61c:7cdd with SMTP id ffacd0b85a97d-486eb1d8541mr10746731f8f.4.1789138025130;
        Fri, 11 Sep 2026 07:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:04 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 3/3] module: Bring includes in linux/kmod.h up to date
Date: Fri, 11 Sep 2026 14:46:16 +0000
Message-ID: <20260911-module-include-kmod-v3-3-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value

-- 
2.55.0
