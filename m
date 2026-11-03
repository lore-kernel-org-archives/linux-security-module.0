Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719108;
	b=cxMbvVY04AiVOFiK851idydyZcoZCelu3MWL+d/3veous2fGsiYBF4/QiPeSV7GN6d1y
	 GV7kZ5Rx1734J87uBb60iQGFGbNKL0tEYfVgl6Hy21IXQaiSOwfS7DAZqd8jeffI5qIGB
	 PKEiRv4V3266LWvZ4I7COCQfmoE+PY5L8MbWfNTu4waxFprKPJDR8j9GI88yh/8UVpz5A
	 Xu61LTiNH8IH4SO1tA5iuJYyQFRqJNiqpMA6vEeIR3gYT2bUS9dKRH8p/8BTGXnuReLrD
	 lMDIGuwP56xG82sH4cYcYE2RFEBG0Oi6bVW2t9RsTtXx8BLqOD6Qvo50OX0f3i5pMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=DEpA7EB35ETX+QEM+S0rPeRue+CXb/aqgZ9fcs/1WrA=;
	b=eJUSCf9MpgN7sx2GwMVgDFZ9VI2X6KZc/qKMJ5zwP0CeYsbSTEOXt4QOo+C2pBFm48Ay
	 QKMGQGCRWWDZ1JxDI9QeizMHAxZZoNqnfjIZh0fG9vOR0kymTb/PGMNHhspvir9o8Vwb+
	 DnzcO/E5GRWqLqzF533NjJnEsWjulqLx+gR91ieCJW3FcNlOHah3rLFE5OyknrH+9Kr54
	 62kJZVfA4imKHxy4/ODMqK0RCL/L7UwKLdneBLlIkR6+InQyn34S4Nmj7zzysQy2Y1Qn2
	 mB+rDKz+ji+UpKz8YxGhlZAj00p7K8KAQgtNxe6PiZf/tM4zJse4rlCmjcZjwPfALhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=iJQAdWul;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB0606EE8C
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 15:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBB0606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=iJQAdWul
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea94541adbso18875935ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 07:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719107; x=1794323907; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DEpA7EB35ETX+QEM+S0rPeRue+CXb/aqgZ9fcs/1WrA=;
        b=iJQAdWul3W/CUJhIrS5dvX0eM6WuXTz1S48rZb7FrM5HAGY2k2eULG3UN7fMf2HesU
         BgcewLwYarj5CoCIUK0cf985AauuA6PTll3ljWMb/GhZikHr2S8DKVa6H7UHtVmQA1VC
         Y1mKhneDjNU802KN7Ay4+ex61G7mP1iOn6T9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719107; x=1794323907;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DEpA7EB35ETX+QEM+S0rPeRue+CXb/aqgZ9fcs/1WrA=;
        b=efeoNn29Dpg4Q3y/70jmMXQyS2TvGBwn7md00gk+U/WptPKl2OI5s89DfoIYpuVCKD
         qjyPNyb5Y+Js0cfyiICtAaPHuyVptWkFubiglTQw3fdW+APTCb3B7lMin+7aBLvR8qCX
         r6sapcJOdxJYGJesDwwh0SZz7CqTa3CrV7li6if2UURD+s43v/8miBETRK/G1rlsfz1x
         TSh8v8PL06n5UQOmm9BxP4mcSINYZsOO3pr5Zoddh6CfuFlwOuKyc2LiTJPI6r9j0cG9
         v026fnHZAX4M7pFOQfU5m04iChZA+z1HsMCob9ent/A/FCyTn2ubZVGMoiYOblt0XGsI
         GvPw==
X-Forwarded-Encrypted: i=1; AKwUvByY0bfi9dFyk5QC0lNekuyH3lJHW4s2Ds9Fh9T1DWCZByAIZx8IoIMKgSm8mOYzZHauICfM2HqJhefq0t0wfD73pPdE8T4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BfUy18wq1rVAadDp2AWJs6v3sVG8nYXvdWiYRbuV19nun1hjh
	6R0spiNxJoIshPlzPAGfE717E5+aeLqxN8mTPwwCplY3FA0cVd39h8t4XD3/d4eZ7S8=
X-Gm-Gg: AYBFou0Soxy6f+NMiGbkbPbqeGJGlNMjFG9VePPFh85ZaNExSTisEW+SxFCe3rDk+7q
	DkFC53oi11OlSTQGQOEkdmILu8HAJhpVBkyAxdOODMpkkiNz8bgOBVWdR13zbXDaNacGmsDMaXs
	UI6zPU/N5tNdCGiB/HomzmsDD/EvVyz7dX2Bqa8s00y+aE0Kr0a7eaLGzivqoiXCw0AyaHXfHF1
	G6EYfZwKD+hwepYCg+tBJtTL8SThkN8wYlxrPHRCXDpzxiZsIA5o9iqLSnJY56A53w+fu/ZNP4K
	lZGt+HyEv5Uo0vMHTWCyD47RJ60EaxN0D/cTBQAxC/DMLrEKkfLY2vJFRZGUmk9F4YVolli5XGY
	Kxuv5FCbmWWBeYm0+SgW0d1pUQMr7plZgKg39A8KIUXL9cnu0BuUToR7cATGg5fDUBJgv4PuOwU
	oCehhzdDHaJdr3x6NeuG6luXIT0ohq2SVMWxAWaVaT8L0FcPcuRuFBukPVPUCOj+77JypYH79OH
	sI5brBzf3IDwjbXCH422oewACkm0xnXuUzHFPG+l1WhzV3P7y1UeL8uc1cC9hLJnlMNz40x1R6t
	NSRLlT7ioO+/l+YJApAcYuaU1B8W/NkhiuGBp7PejNnjML7CJ/6Y48O6iLmHjT/X7Qmi+KhfDsm
	VEiMivT/2NPXT6SfqyTt2n0aPjPoIH/DvUwlMTrmu38Yf64R1DlNZ8gcJzJJnOPxk1Fn7iHRGKO
	CVFIFisIsmKKCkCE4S4Ro=
X-Received: by 2002:a17:903:1aef:b0:2e2:f2f9:b1ef with SMTP id d9443c01a7336-2eb364bc076mr131151785ad.39.1793719107092;
        Tue, 03 Nov 2026 07:18:27 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392613bbsm43426035ad.37.2026.11.03.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:25 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:23 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 4/8] mm/mseal: Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig
Message-ID: <6d72b96fdd36c8870393d8d6e67a811a9bce9e4f.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

MSEAL_SYSTEM_MAPPINGS is in security/Kconfig, but it's an mm feature,
it's implemented in mm, and changes to it need to go past mm.

Let's move it to mm/Kconfig, next to the other VMA features. No
functional change.

Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/Kconfig       | 21 +++++++++++++++++++++
 security/Kconfig | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..40172787dfa7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1355,6 +1355,27 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config MSEAL_SYSTEM_MAPPINGS
+	bool "mseal system mappings"
+	depends on 64BIT
+	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Apply mseal on system mappings.
+	  The system mappings includes vdso, vvar, vvar_vclock,
+	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  WARNING: This feature breaks programs which rely on relocating
+	  or unmapping system mappings. Known broken software at the time
+	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+	  this config can't be enabled universally.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_ARCH_USERFAULTFD_WP
 	bool
 	help
diff --git a/security/Kconfig b/security/Kconfig
index f7bf6cdc6229..1679e8d009c3 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -49,27 +49,6 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
-config MSEAL_SYSTEM_MAPPINGS
-	bool "mseal system mappings"
-	depends on 64BIT
-	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
-	depends on !CHECKPOINT_RESTORE
-	help
-	  Apply mseal on system mappings.
-	  The system mappings includes vdso, vvar, vvar_vclock,
-	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
-
-	  A 64-bit kernel is required for the memory sealing feature.
-	  No specific hardware features from the CPU are needed.
-
-	  WARNING: This feature breaks programs which rely on relocating
-	  or unmapping system mappings. Known broken software at the time
-	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
-	  this config can't be enabled universally.
-
-	  For complete descriptions of memory sealing, please see
-	  Documentation/userspace-api/mseal.rst
-
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.54.0

