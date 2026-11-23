Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434295;
	b=lNB+eLym2Ea9DxOza1zpAi+1seM7W+hrmn2lNPPYyqrbfsbkw73fV5QSHwVaqpuGsQjg
	 KFoonnvs7y9FwnqPXvbDqQ416eG22S7hCEvrk1701McxoYKAdChRFX6pItQNWv3nytLwj
	 rP6zqdyutIuFX1P7J2fYRaFNuhz3sNryEu14URX7zxaBiIOyKeY8JVQeHFKscGOuERBa3
	 L4Xrda/57qgsgYWiX2pf8se0bs7/plyh4UE7WdScTv0ti1d53aEbajDLIsJ+ASvtgzylq
	 9LXowpMm8+s2Q6QoKiiIhczZnWlhrcDRIod3wJmqVqwXEGkTpM8HFAr8iZ55ghBEvvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wao1lDLNbUFd8H98o11hNOXj6BtvvuLII7zQ8aDHCoA=;
	b=VIKSxp4egOVwqbLLeOfuQprK69QJR/gY6e357aEQA/+v+ejH69oGW9C1ulLFLXilzCFy
	 b/3Kv5C2jZPIeMNOjXCInP9GneSIloAga35h0DAS8jdZ8vMBjKBUQVOoQSc+T93l0l3ef
	 su1NiyhGaeZ+OITeXLDRWOG44ay7EHoaOtlrP8iODjBo1IlqkLTxlEcEccHPcQssM/0hS
	 wEM9j8bYFHfpwTJJ+xsDMp6vHTyiX5NpVtk1nZ8GhmZRnxTz+aKPoZ6kLZg4VA9zf2M+q
	 j9+ncQ8mrSSRD8jH/4asNL1AXXyIaYw4DE6OB16aKyvcwNqQI8OtyFKp7TDq2JaP4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="uX/T6Jvp";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEB606A327
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEEB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uX/T6Jvp
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso6909474eec.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 03:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1795434294; x=1796039094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wao1lDLNbUFd8H98o11hNOXj6BtvvuLII7zQ8aDHCoA=;
        b=uX/T6Jvpgqm1tJlOq8nd1n3yBngZOJJsWljAE8ngjJ67WjO4XcppJpZfI9LcuZjO77
         QMzuIZtP23iIDtYgHN4p9h1zhO1JKDoGN4t6lsyrSG9EDI3t8GTLyjWGhV1PTfVHB+54
         CUxMOF/uoHWZ6c+JuONYE2YtLDmoxCSwGiCsTZq8ENXKvGGBaYamhtETB4BBmyA2qkRz
         p6drrH4nAoZe+ndXq4r9t4H7kpC7P/4t4v7uWGf66RqWNJtsK7aEDadnMhewlwC3KNS5
         YPnUzwofxCDqc3rgq7ybcAhFbhK0oF16fThefr54y7ipHGq+t3sdDMOYzVAaj3L2BDlS
         hzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434294; x=1796039094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wao1lDLNbUFd8H98o11hNOXj6BtvvuLII7zQ8aDHCoA=;
        b=RFomCjzLko3Z8Q839DdZ+aCRMxX7JE2wQBHxaSQAWngZPmbqEK8XYZjzt47FTP6IOk
         WabNSJxAJ9Wkn5uMAOLrSPx26OgNuJSb/fNTbDhAvzx1QOJQcmZb73g+mycDuundFlGP
         57+rvQ3vyczid9UzKBjXKUdj9rd0OOG8rlB07/w8FJJeOD8+rm99g8UGizKWXO5yy+V9
         7AIlea2C5Aq2tGnQsCiAnjuRSrFP/qEkHz6sgTzhuROc/R/pTG/z+ibkkA1v1qsAZVp3
         bN7xzcHJ8BEagjDTh87z2Sv1ap8fNRUl9ZVai7qf1C6VxxotCRZdI3P7pQ2iRmeLXp5V
         eWvQ==
X-Forwarded-Encrypted: i=1; AL+hErGvW2mL2tx12GXjzEEoE3kg3233ShuvHl9RXSMbqGJxMAJ6w7iJnyN4CyNx37gAc6JQy/RMy28KpaxUh6St+aV7H5rw910=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WJ3oaGbv3J7SXa/N2M5pXq/zgkDINzYQtDTKhsRHuGTL4tED5
	5MC2iG2rPXULROespDM9iTGB7DBYz0dJJTkVycpzJN3lewSbvXAl3Jyjhmyt8/gaqXk8
X-Gm-Gg: AZFdTZceS37AbLwXpM+BosePDAOytCR0LNiZeKWxTApMj6SGYbYPQefzbwAmT+GZoCd
	6nu729criKY5frOjci1l/XmbYR1v9fO7h494CL8X6Z0THa4cELuOLEEPaeGr34G0laapkwXk9Nk
	Fh92Pso58zpnE5Dz63HrZfPs5nP7WUmgwz+mMFogKoR0hhLyYuR5cx721UoFH0Ynw9TyZcTfL0O
	QgaSaU5swTx5dJRGg65P4n1pUkBgZxvij1hy59nin9V0XkYl135vIHNJKqgrQfzmXizIHedDbo9
	vs0MLvZEKSzoaQGMU05BpGvQLzwcBj4ekaRs7aLdK+oZnCpC2MsFFhi/3EPX7c6T6epC46EyCAV
	Wr3Nk0Lb53DHOh1Q3o3c872PR+u4+Ca6jUt2KnNhjdvrCj21sQ5b4osVVtAlRfjOW6ywrmxSJ6Q
	wQv4iWfMFbm1li8oTo/4kZho8ED09IMmBihro7XLT8hBOFc+clNwzO1Nwc5GOyc72zaN9UUSYgw
	F8HUtuQ7IbT7SOfdEngfWj57JivUwx+M/iGC9ai6rokNUEyjGYCYs+HyBfRehpLYDQPCLPv3xW5
	Kz+cOJshyZbCzN0cIGfk/2WvLcXlDyet3FAMx2L+pKbccKO26BH9ZVG0LajQJmabZdegWJuRUea
	XwXCRnG0Tgsi47zAyp50o6P1WIQ/mGd/rGjiQkL7ffGfeK8jTWwIapA==
X-Received: by 2002:a05:7300:f797:b0:386:95e7:848c with SMTP id 5a478bee46e88-38695e79009mr9525592eec.7.1795434294209;
        Mon, 23 Nov 2026 03:44:54 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14e:94e0:654e:d7ff:13d2:447d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm41943583eec.10.2026.11.23.03.44.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:44:53 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Cc: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [RFC PATCH v4 5/6] kernel: add KAP checks for unshare and setns
Date: Mon, 23 Nov 2026 17:13:07 +0530
Message-ID: <20261123114308.8103-6-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123114308.8103-1-harisudhan@armoriq.io>
References: <20261123114308.8103-1-harisudhan@armoriq.io>
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
index eb198c8df..4216a2de3 100644
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
index 3fb1595a4..d41d7f5e9 100644
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
2.43.0

