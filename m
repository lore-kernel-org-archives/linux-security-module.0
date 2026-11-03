Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719078;
	b=z2zFWoPypOwmvbSCZ26m82pUSkF92rX4CQFJsTKF+bcsv4U6tmDFX/tStA9W7tQDSkkO
	 WzFzXkXwR3nxFbaTnoSgP2SxSZWwnfzAG0Xx9mgZ7rykin8QN3A8CDcXUkCef+dnQ5rrb
	 F3vMJmG2/bVORkdeoSC5px2R7bCfDsMqwkofDV67UEqf+rL7+vEvcG0Xgeavak8NEXUt7
	 bIANsOnTiXs7XtzWEGItPC8zD0hP0XHgzJT3zoFsY6hz32DscWemuZApbXKlqWc0xpHuC
	 O6vPx0SMpipHEW3AI/kcXRtOWUR+whQO5kwCTjmo3cd9JiY5ObLRtk+26qkgXClJClA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=bbduBp3PV2PD6ZtgXv4ZkeG/rcdvbrKsRxBHo1Elyzk=;
	b=K/2UZ0IJub2LThuqV7UnGj5PCiDFFejsRUIoCXoZXf4ap3u1gxFezE5N4da4SEpFqD35
	 5p/kG2TEev2bv+gHW6AEzC+bthgGtCouhaprh0K5JYyN+IyhB8HqhuXsZ79N395Xmlbny
	 DOEKbK/S8dIXTFOAVwqq5ue5lkCMMnGPvsldC+ZyL5yOwEQPTmAd9PY647eH9HxG2SRfm
	 It/PLaD7rc7ZNsNIGZCqQuyGxGdvsLNx6NzfM2XfToooh+FjwqfpNG4h4/mTkryWX96JM
	 yeXaR9ZThLP5iaTprbhVrC97REwr9/axmoUU8sFiBvgrqa5Y8UaLPcBbMa+RBhy+Sxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=e7DD8qBJ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DC606BA1B
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 15:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8DC606BA1B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=e7DD8qBJ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso2158204a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719078; x=1794323878; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bbduBp3PV2PD6ZtgXv4ZkeG/rcdvbrKsRxBHo1Elyzk=;
        b=e7DD8qBJGpWmtjaHh/YFm9cGb2nRovcHrUcnolSCv5USqGQbrODopqD08biD7yhSFD
         FQkxV/az1Lk6tF07iqQ/lPqtwr+2a+9ZcJEQle08PfN1QLtvcrJbo+oczRXiBF2TIVoo
         unnrc+2k70Ettv3/2bG4z8DvoF9t7yb9GhGho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719078; x=1794323878;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbduBp3PV2PD6ZtgXv4ZkeG/rcdvbrKsRxBHo1Elyzk=;
        b=Klf9ONDi0CPAcUKlxISO9eckgCc8jZBcg7gndr4XX2jxTkGHslYE9O6UGrZ2sdfssv
         Buh1af/zYs3ZS0+y6tG1un0zVbVzdZlBZ934duCAdFKDsmp1IVb/pAN1KvhraZcqSmPa
         6q7OC8ddw3Q2GVYgopnka5k4d0dzVNn697EljFSrYkE+mq4Y3R3CgUu57+wRTZNHQEZ5
         I3+KigsTSCkUPoZ9mHBiiqIoesWur/I/prZgH38HHHb6/fdUMFGADk+VXvJ2XGCKjpy6
         eV8xyQ/zjo9DqkTrKKn6g0/RQTRdTEujGhnX1H/nfGtCco92RtAbHmVYltB19CjfLIMm
         Qozg==
X-Forwarded-Encrypted: i=1; AKwUvByiYCMo9RZEpPGJeMOlm11QWvZQ4NF75oEeg/vlnT8psx6pKsATpc3oEWm1y5EGI9i+H4W/g2U1EYsAfuX+1bmTJoyN2YI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MnYgtYjQwheSTetYZT8VXFFYpi96HIjEWUSS9a7pe0oEPaKWX
	AdlCe8dWFV7jfZQckNWmCF+m/s/to9FgWGszs59+/GPWDhbEkYkATSK6e4tq/NE9TU4=
X-Gm-Gg: AYBFou0Fo2wz7kVTq/Y9FVNR3JXee7FURVUK/lr/22cTcYVRyzfD+kTj8AjMjp0n0db
	xLRn6RKdOAcXo82K0li9ty9rQ9PuhODcl/djxjtzwUxNVTbCLHoHbGeZK8usIgu4hojxi0PN3we
	d0dJr7/HDiM6hJks+3PWVMZ9rhDL1Iq6rpNcztppgmiUdb2QW2/ajsyJRNVEkIXCFM3VsJsfB+2
	uIm+sRcixRjP8ronNeT/QvdHRInMMv3IPHO7o7FCNmvx/SRCDD3Pb+9uRy63f0bPYKYOp/tzP1r
	XOtpNpe+MCbWl3Z0JRWhOmULisDdF27XeW/DTFrpjqu/bw55+60hRfs3pdHO8k6uu51rMQEX5vI
	3rKBaglhrb3U+WaJl1iZWQ/DXQV7rNgjPHmrK8k9lybfPhpQUp6zw93KBuD2F9Hy0Gskzr+L74N
	7Tp4DsJYUNchCrilEAwYOXhWR4im4puR4dDcRH+WlAkO6CaqS1cKDmqGadS0sb5hZwEVeiZ8VrS
	oH4ojjAzGIn5fzQpJNP6f0iGte77qRjJ2KlNasCyadhpf+2ElynHTlG4gBp0nrZ+lhjSGNFrlQd
	Q5C2rTZB3viEGE384F+8lMEGMDi0f8+gKV5Esmfjq/4OL2RQES7VjeGVdY3PUK4fl5ONNE4+53Q
	FWfWcTEGHiNKgp8pi5ZZFELqZtdp4IPCewXRmc1uaTrK0RDLlo1vqAdT1irbSQ+x+E+jLwe4s
X-Received: by 2002:a17:90b:4e8f:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3ae89806287mr10222361a91.49.1793719077568;
        Tue, 03 Nov 2026 07:17:57 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f69605sm10791677a91.2.2026.11.03.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:17:56 -0800 (PST)
Date: Tue, 3 Nov 2026 23:17:54 +0800
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
Subject: [PATCH v2 1/8] selftests/mm: Move sysmap_is_sealed into mm
Message-ID: <1e2cfbe24810f976ee6e176346598900295adc73.1793718940.git.chris@chrisdown.name>
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

System mapping sealing is an mm feature, but its test has its own
directory under tools/testing/selftests rather than living with the
other mm tests.

Let's move it into tools/testing/selftests/mm and run it with the mmap
tests. Its config now comes from mm's config fragment. The test itself
is unchanged.

Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/Makefile                            | 1 -
 tools/testing/selftests/mm/Makefile                         | 1 +
 tools/testing/selftests/mm/config                           | 1 +
 tools/testing/selftests/mm/run_vmtests.sh                   | 1 +
 .../{mseal_system_mappings => mm}/sysmap_is_sealed.c        | 0
 tools/testing/selftests/mseal_system_mappings/.gitignore    | 2 --
 tools/testing/selftests/mseal_system_mappings/Makefile      | 6 ------
 tools/testing/selftests/mseal_system_mappings/config        | 1 -
 8 files changed, 3 insertions(+), 10 deletions(-)
 rename tools/testing/selftests/{mseal_system_mappings => mm}/sysmap_is_sealed.c (100%)
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04..94276b1310de 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -84,7 +84,6 @@ TARGETS += mount
 TARGETS += mount_setattr
 TARGETS += move_mount_set_group
 TARGETS += mqueue
-TARGETS += mseal_system_mappings
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 675ec57d47de..94e305643c8d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -110,6 +110,7 @@ TEST_GEN_FILES += folio_order_check
 TEST_GEN_FILES += khugepaged_sync_check
 TEST_GEN_FILES += khugepaged_race
 TEST_GEN_FILES += soft-dirty
+TEST_GEN_FILES += sysmap_is_sealed
 
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 06f78bd232e2..b93b49cd675f 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -14,3 +14,4 @@ CONFIG_UPROBES=y
 CONFIG_MEMORY_FAILURE=y
 CONFIG_HWPOISON_INJECT=m
 CONFIG_PROC_MEM_ALWAYS_FORCE=y
+CONFIG_MSEAL_SYSTEM_MAPPINGS=y
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 973cb715b326..573da5006268 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -307,6 +307,7 @@ fi
 
 CATEGORY="mmap" run_test ./map_populate
 CATEGORY="mmap" run_test ./droppable
+CATEGORY="mmap" run_test ./sysmap_is_sealed
 
 CATEGORY="mlock" run_test ./mlock-random-test
 
diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mm/sysmap_is_sealed.c
similarity index 100%
rename from tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
rename to tools/testing/selftests/mm/sysmap_is_sealed.c
diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
deleted file mode 100644
index 319c497a595e..000000000000
--- a/tools/testing/selftests/mseal_system_mappings/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-sysmap_is_sealed
diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
deleted file mode 100644
index 2b4504e2f52f..000000000000
--- a/tools/testing/selftests/mseal_system_mappings/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
-
-TEST_GEN_PROGS := sysmap_is_sealed
-
-include ../lib.mk
diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
deleted file mode 100644
index 675cb9f37b86..000000000000
--- a/tools/testing/selftests/mseal_system_mappings/config
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_MSEAL_SYSTEM_MAPPINGS=y
-- 
2.54.0

