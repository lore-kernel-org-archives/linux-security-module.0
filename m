Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342258;
	b=j+9zIBKVJkVVVplCXBM4GRZ2sBtEr1ucbyeOorVEwhsXFxcCsXxTRBubjlvLBeCTsaUO
	 ohbJEc0RglekOmHYbYTi1MJJr6klYXPL+cCKpa+k7uBB9WhcFQd+Zpp23W4W1E+WuxRMA
	 EZ0T+U1SRLD7BeWtB9cVj9ay2jeA3c8NP7YAwY1k8Ymvg4Bm3kx7962706VFlFLTr/mG8
	 2ydhK2aWIwwkE47d2oSu3NE5Rk5ASpSbVaIbeYgMV7O+nZZ/D9J5vjWQ+z8TpaYD+5rUz
	 PFfQx7s7hPB6myPpRZpJEvCPIASCb33mH67UcDZHF+sDHJuSRw7XDWBmlfKB3BO66Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U4CgF1MujLyKKs4MDsPCH+PRIQeRT4qSq6PrwqdYMBE=;
	b=DkGXOZKySA1tHWRYGkzFA5/0yt76v5kJ1D18F0/E83dnRa/QuW7tl/bTt7pvRs1Cs6dM
	 R0lxP+Da/fm/60Wp4GT9DHF7hGctEPei1QhAUhLtTkQwePSCSdmPrCZkVWRfjR2uxr4hC
	 F4xqiytvxE6WtvAHybssNxe929Bm8uSb9kSnbuOoqf/qlfM9nKJVTqYdW/dlYvUz5clGg
	 gDx6wTzvo2uUiU/GKeuxDca8J+MligXATpQmDSaeAMYnByPlvoK5h/u0muuEVFWZ3QACj
	 ++hEXhN3BjuE5L9kryO4TXRRUmb+NXh5WaerPLrX4+7nVywK8Wz5fJNT4Bh+yHTXdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H4hDUkdU;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A70606A8B7
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A70606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H4hDUkdU
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so1837753eec.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1794342257; x=1794947057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4CgF1MujLyKKs4MDsPCH+PRIQeRT4qSq6PrwqdYMBE=;
        b=H4hDUkdUIfu1aeYFa/L+wCqKQAJ0W4KsVOg5CzXESlt1fRutvTVtYX6HvPZVIukiIO
         9ZQslFrDJ/ij82d33lbDyU4lm3hmMo6nIxPv+EklBZBOgqEKd6WpxDDNonBK91F4NWqm
         yJmBkHqDm30KDaioG4f9vYO/ei5iwzPZrlK4OEbR1x825UVqbEO5q8dS6FPQDq4qTtAO
         EOmQzGzoF64BZh8t+lpu071QWr/0F4T5s/8zAAKXsT16PiV/fwwbfXRy/WpLSVfSw3Nk
         RTAJtZNQNuRHb40nWwdtrJO/D8Fw2pGjTRmWlT3X/bRkbsBFLpqJf++BrNFyFVsupyOs
         SIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342257; x=1794947057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4CgF1MujLyKKs4MDsPCH+PRIQeRT4qSq6PrwqdYMBE=;
        b=MLYe6XT9NMzyPKLHF3kTB2jArM2X1suIX1YZY/vkZOU83Eh95SR/7j6H54B6hc+BMc
         lIFJPH5xvZ1+ASTpp6s+Y62p+XFbuWDw7Ipca6K3GS0HXCdVVBl928XDfxxxs1vkKiLw
         3fGW4BOXGXWOFOplipGHaHMZLrRFN0s298jNS6s5UomRgqVX8gMYLVKmvLOxV/8Q5nKE
         vqCYDdzvFRg/7qBhgJOx+1Ck8EaZ8obsU3HPUpuIdKtsIaFfdUjWcNpIuVDYrBJUul9+
         4SGenPFlEAVw0ZFqYoiAIznPAP8jcLOVwHMKUCKmTB/jSsNJ9bK8HN/rsI+yA5JSgk8n
         uA6g==
X-Forwarded-Encrypted: i=1; AL+hErHdbUvZ6n4tFz/LvKFWzu6WHlHax0UhTuChuYLI9d10Am1bZ0h1EWsVc+IUrmDhDsJAsMClhlES5rBMNQ7QD47iBTyAjHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KjqBMQ0Fi9+rSWoX6vCGhUjF54ddFjcW+UZMdXmxvOHzUvH9N
	6YMk7szKbkzFbaBaeE5z18Ki6pzf1G6hsj/qOM+wSiAj7vMPNKGN7DAajO/gHsoDOopk
X-Gm-Gg: AYBFou04ymrFZtt+T25zS7GkKaGXEa3M6nbTCmZ3yT61/Pq1K9s9LltEMK+QC9ROogz
	M2YHxUH+6tqSW6fqLERh5bgftD1aw5k5grVhBfznHPt8cKE0jgWDXTlTkeMQcBUxmKT8LlIGNhE
	6dFoif7yqZvxVU9rHaXnOi5LRnWKpCTRE8aAec4k4TeVbS6/SHXqxHYsslBhYETBIyNP31Vxi0E
	2NrwtnntdR29NYJrmeC+8EOssRpB0m07ThDlLaJ+bwnnG+ynQOITabPUO/ZZ2qKNLsWQKI5H64s
	mDqCED+/MqCo2jWWNIsVqco+uouRuUZ5Ho2ssjL6ff0OpWuXaq9vo8mABSeNtCkv2Od6HCGGc5f
	ohGnz2vc1Y0DJWbJ9ZnDrCG7XxF82a6Ra49cYW85tBtVQl/DS/Fgjgb7AelB/oPrmV6dtdhldoC
	7O61OerfI5zIaGnZl5HofKtVKPCRQVUgdMTgTZd/P3MhRAQ4Pm+aMN8zpj7VeZzrJ9tmbOEWYHu
	WS+TzF06Y1LrCKyQZEbuxToL7ZOLHToJWsFIw9sBfX2xs3RSla116+ipEtue7Oy7Gzpe0slcyEM
	PU92k6U9Y23MOk6sbMLIpqIajqdEl2VDCRm3+X1z36Fs7NbOmd6lF046O1mRN3b1hJlDBBJLgSM
	V+QVaqiEyHR4HBNIQ0TZNFZcC+Je6PHRvPGyw8PIBoxq0ZMlRo1lXXg==
X-Received: by 2002:a05:7300:b282:b0:368:2548:c08b with SMTP id 5a478bee46e88-37685896be0mr560200eec.21.1794342257246;
        Tue, 10 Nov 2026 12:24:17 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:147:2742:6545:702a:2431:7dca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm10076615eec.21.2026.11.10.12.24.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:24:16 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>
Subject: [RFC PATCH v3 5/6] kernel: add KAP checks for unshare and setns
Date: Wed, 11 Nov 2026 01:52:45 +0530
Message-ID: <20261110202246.274-6-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202246.274-1-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check unshare and setns against the bound task's authority. Neither
has an LSM hook, so they call KAP directly. Every namespace type is
checked, and setns checks the type of the namespace it is given.

Unbound tasks are not checked.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 kernel/fork.c    | 4 ++++
 kernel/nsproxy.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index eb198c8..4216a2d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -52,6 +52,7 @@
 #include <linux/cpu.h>
 #include <linux/cgroup.h>
 #include <linux/security.h>
+#include <linux/kap.h>
 #include <linux/hugetlb.h>
 #include <linux/seccomp.h>
 #include <linux/swap.h>
@@ -3276,6 +3277,9 @@ int ksys_unshare(unsigned long unshare_flags)
 			 current->fs != current->real_fs);
 
 	err = check_unshare_flags(unshare_flags);
+	if (err)
+		goto bad_unshare_out;
+	err = kap_check_namespace_flags(unshare_flags, "unshare");
 	if (err)
 		goto bad_unshare_out;
 	/*
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 3fb1595..d41d7f5 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -25,6 +25,7 @@
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
+#include <linux/kap.h>
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
 #include <linux/nstree.h>
@@ -589,6 +590,10 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (err)
 		goto out;
 
+	err = kap_check_namespace_flags(flags, "setns");
+	if (err)
+		goto out;
+
 	err = prepare_nsset(flags, &nsset);
 	if (err)
 		goto out;
-- 
2.53.0

