Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719070;
	b=Ge9jh3w4BHAF8xxorxCOIdWx2TKPdUBo/zMdYJENxS7+ri9GlClqOSw6DGMn/WETNS99
	 0eGBA22cfLwVIJ0K8DTzbcN91Etk4tQ4dytNkgB3asi3L2UFm2ctCl9uyDEWyLSABwhqQ
	 rOau0dtNFik3Y2t0k7E/o67YVSpw3v41HfF3Fj4X1DKYQECZZldRIJOMZYFzkdGjGt49I
	 saLVcH28lfZugFWE18guZHEnVHxz+5y75HC0ntNhT+x8wFSbmbNmO/btSLjXD8J/rhhwe
	 JmhR1HnZF5w+VVwqtSy1lWVljyEQxMFA2IIwnUIXzRHlU4oxNHx7cHowO0EmlRTAFwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
	b=xEt3jyR4qw/FmK8Gv6eZR6ro9DBnkn6zI6Y8UmAvlEHblqG37YNc35zzkfi55wWlCltO
	 0CsOE8aQSMfxo438OKsuJ5+DOrCVwaiSqikY0oF5GkNKbyMsqQq47iE3uF3MyhkMAp/YN
	 b3aSEmVhOsiZktFy8byIfLyr22dHg5bvmpV4VFRMSatbMe1E0nsAzXtJ5VAZ1d5DSFgZf
	 NOCq+/SoJHPDGtfTgDsHNpQRRXeEvhgD33t3K+j7jc+IQBq0t4J2MZVxqxUQXQwushVcZ
	 WRORF5EDogjM2K3S7UkYlMntJMZVS71OohPyQRTmKDVWTJRnpjVxCguBZf0+tHiQvAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UTWV8h2n;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92D606B250
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B92D606B250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UTWV8h2n
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2773453a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719069; x=1794323869; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
        b=UTWV8h2nFTZ0eInmgrs3DEF7YRTvpPFa3wXSTzrgbTJdxS8o6LX18nP95bFPdtGbel
         mhOBG2L0OGKLRHHR5Df5WGSB4ANOi/n6F8HnF4gGjy7OOMbjUQlof9V2g4MRUDoAwbYS
         /cttKPQyPKLAjztUy3DJqrlEkWxeSKvdMeTW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719069; x=1794323869;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
        b=1BwfhKNJnc0EoIMRZ+SLKf050Hkf1c37mfMRP1ivR8RPXAfmBoSZiObEv0QkLgUGe+
         CfZqe5l6LvwLBOKfbe8KgbbhoaGRxRTia0SE1v+7DOuP9YCIzJeS89hVkt3S/QlfKKsS
         W4fTY/iVURIliX2A479uSJB0AwLYGB+5tFr6PsNxw0xjcAWYPBpzBMpnsPGhtucT0doD
         E07eBgFz5o/G2evo2xauyiCcGRy42K+oBXXOW06skh6knItlxkaaIWNZ+yNwaTJ+YYHG
         kKqYxY30kFgJDIUvz3PMs9YY5RQaV+Zzug1awdky3KJZHrD/zQfryOPZiUZlJGty6jCC
         3lxg==
X-Forwarded-Encrypted: i=1; AKwUvByjJX7EpBICgEBR8UbBH7SGF3FSMK1bmTEFLQ6ieZNwiAnkM0ZOIKSCwaPnx02oYM9YaIoFIFJ/rSvUePr1UtDCzUt6eGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QGdIpoQcIpqQvu0Y9TR1bCmDl3htCwOBlHOVWutr/xgnQnrrg
	IjYdWoj6fXZ23KBp+/+PIM9FT+NfqWtU/dc0EoZv2D91aEGf/FTwunjdWypl8T23qIs=
X-Gm-Gg: AYBFou2DlkzPCTFrhTmmA1FiykF9CgXV1+0jq9r9Dn0A487VzewgIHalqDov20nXqzw
	1MMW4kjEUwTUBgn5DMihAhxWd9by0maM7EgmKY4dp/t211s2Bcm6xr5AsdmOxIvvbCnTBuyKPDx
	tiHjCtQ1I2hiQxjKfDPDSgn7GVr8t7Cb783QYDPckkyoP0VE6/myWW3zUUwJtrBipRqpehBP2Nu
	YOyZ9MhW2kMcc2ltFfqW2Y0C+YsKeivui1zTKzfCXxu2rlZ7EmTdxpdhr1AEBBoRjWEE27kZe6Q
	NbghAoCwTUesm6FbasCnwkb4mWIIB17utbJOhY0vW4FzOJSx3Nk/yXv8ZKfesVX9zhOf2Id9A/l
	VE5DZbkxJtjYBM/6UdfB5oFt8CBKA9r0jau2bz5D2v8JdElKGC1WkH0XZuAtrzx6ixPURSE0d/T
	FqJATfblDjyxlgZ376+uEHNQszyN0Gs50Ay1iGGe1bzQw25IWpizsh8djIMv/Hm+ptD31Lwkncq
	MUBdFVonCqrVhGQkMKky0EmVSZS5BcaNhqyhqY5rLEH1aEuiq84ecq0osnl57f++Gmpn1Np5eQd
	m+KB/fH3iOEdY2WOc9gTBZ3m/JZZoFMfcMQ9gR5a9eoa91es6izVh+NUdbk9nUl8Pv30+queubH
	zieWwI7vkV8exaNiaMdXtfnp564VwCoUSbYdZKkJpUsS8BmyNDXq3zyBwrGMZlLQK4BDDJ6aajh
	5GAHpu8xZay89I4s43pA==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr10813768a91.11.1793719068633;
        Tue, 03 Nov 2026 07:17:48 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c62984bsm4849760a91.9.2026.11.03.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:17:47 -0800 (PST)
Date: Tue, 3 Nov 2026 23:17:43 +0800
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
Subject: [PATCH v2 0/8] mseal sysmap: Choose system mapping sealing at boot
Message-ID: <cover.1793718940.git.chris@chrisdown.name>
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
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

System mapping sealing is currently a build time choice. Hosts which
want it and hosts which need to move or unmap these mappings therefore
need separate kernels, which is not ideal. Let's allow the administrator
to choose at boot time.

v2:

- Skip destructive vDSO tests on unsealed 32-bit x86 mappings
- Move the sysmap tests into selftests/mm (Lorenzo)
- Use shared vm_util helpers in the sysmap tests (Lorenzo)
- Use PROCMAP_QUERY for the vDSO lookup (Lorenzo)
- Keep test changes in separate patches (Lorenzo)
- Put the enforcement tests before the kernel changes (Lorenzo)
- Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig (Lorenzo)
- Remove VM_SEALED_SYSMAP (Lorenzo)
- Seal mappings in __install_special_mapping() (Lorenzo)
- Leave a sealed uprobe trampoline mapped if optimisation fails
- Replace the boolean parameter with no_mseal_sys_mappings (Lorenzo)
- Drop MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON (Lorenzo)
- Drop the CHECKPOINT_RESTORE dependency (Lorenzo)
- Document the software which sealing breaks (Lorenzo)
- Keep Kconfig default-n regardless of CHECKPOINT_RESTORE (Andrei)
- Retain sealing by default when built in, with no_mseal_sys_mappings as
  the boot-time opt-out (Lorenzo)
- Explain the security rationale (Lorenzo)
- Describe the Meta/Reverie use case (Lorenzo)
- Skip general checks on unsealed kernels (Lorenzo)
- Add expect_sealed for strict CI checks (Jeff)
- Use the existing -T filter to exclude strict checks when needed (Jeff)
- Test that no_mseal_sys_mappings leaves mappings unsealed (Jeff)
- Add the vDSO mprotect() enforcement test (Jeff)

v1: https://lore.kernel.org/r/cover.1793094611.git.chris@chrisdown.name

Chris Down (8):
  selftests/mm: Move sysmap_is_sealed into mm
  selftests/mm: Skip sysmap_is_sealed when system mappings aren't sealed
  selftests/mm: Test that the seal on system mappings is enforced
  mm/mseal: Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig
  uprobes/x86: Leave sealed trampolines in place on optimisation failure
  mm/mseal: Seal system mappings in __install_special_mapping()
  mm/mseal: Add no_mseal_sys_mappings boot parameter
  selftests/mm: Check that no_mseal_sys_mappings unseals system mappings

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/userspace-api/mseal.rst         |  12 +-
 arch/arm64/kernel/vdso.c                      |   9 +-
 arch/loongarch/kernel/vdso.c                  |   3 +-
 arch/riscv/kernel/vdso.c                      |   2 +-
 arch/s390/kernel/vdso.c                       |   2 +-
 arch/x86/entry/vdso/vma.c                     |   5 +-
 arch/x86/kernel/uprobes.c                     |   2 +-
 include/linux/mm.h                            |   6 -
 init/Kconfig                                  |   5 +-
 kernel/events/uprobes.c                       |   2 +-
 lib/vdso/datastore.c                          |   2 +-
 mm/Kconfig                                    |  23 ++
 mm/mseal.c                                    |  12 +
 mm/vma.c                                      |   2 +
 mm/vma.h                                      |   8 +
 security/Kconfig                              |  21 --
 tools/testing/selftests/Makefile              |   1 -
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/config             |   1 +
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 tools/testing/selftests/mm/sysmap_is_sealed.c | 259 ++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c          |   5 +
 tools/testing/selftests/mm/vm_util.h          |   1 +
 .../mseal_system_mappings/.gitignore          |   2 -
 .../selftests/mseal_system_mappings/Makefile  |   6 -
 .../selftests/mseal_system_mappings/config    |   1 -
 .../mseal_system_mappings/sysmap_is_sealed.c  | 119 --------
 28 files changed, 345 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/mm/sysmap_is_sealed.c
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/config
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c


base-commit: 734a9da61a5bc5d82b496a86bacc097d11dc6871
-- 
2.54.0

