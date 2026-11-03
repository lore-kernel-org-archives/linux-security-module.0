Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719119;
	b=SYkghaBh2vdQGxrY8YfM2a+25i2RB/boGFhrDgFBj9/jPjubpraWzB/YCKQdCPhtsPZZ
	 BaMI07Xx+L9RM2oMBCSpsSbaZolfVpSenfZpqwd3sLGAbYQxw6J3+aFu8MWqhlkiisG2A
	 ws7V1M1BP0LGZdzW2/urKuhVOhIcmQpMbEB4PiM7W0qNFhcuqNGyjUU3Xm9WTeRV8y5cT
	 G2dTNwzQGPSvmuqW9ws+cYM/Ai27kqfkluD93kd2ufzcJS1N5sN10IqWphtlLAdu2srl4
	 /qsHBzAfptSmqZsEz/aVdPkax/+hP/ImgjUUbiTtpraFreBF4zQrmKv60raePXZXymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
	b=2xxMamRSj4AMEb1/gM7qv9/NIyYTiNiINIQzW8t5TI+YbIXpZkQ7HfCMUTmnXPc3eKvN
	 MzYtcyhXZZTLU5FSkRLWya5Cdiu5JHCk/YX9t8eRxikruwpcWnYA/FzwhBqaZup5oEuwZ
	 K9kPFcwNx8KOUINaDppBTdudTPRkumH3ZGO8mM2sUL8ptiz6u5SMgfwMhTGUMniMC8eMJ
	 9sOSNl0dmwgaIc1r3x6JFSawyMbkKSESIAmhOYzgrO13bsaoiYdgQUUGuJ8wdBGb2Pmh4
	 9qLG6y6OWxQD4BRilugysaqDaU43Q4LwVLmt27MHrmGLJIYyXSwE6fuvLfJNPvN0ObQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29C606FCF4
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C29C606FCF4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070781f63so1783681b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719118; x=1794323918; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=NzH9v5uEH+MPtdumNErHcLU8TI7esovID+0FCTg4cq4Ny7OB6Jbv2iuLnSDCRB39Vh
         z1jm9WbnlKgC0FM/ImPLdCDbfHy1wPtGKCnh7nLr66I2ZWRMh6r61Gw1Myi8kqqxygS/
         MP+GB+led6l0lrR+WCQZnEEeUcd7JizQOJMcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719118; x=1794323918;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=Gx2NcnFFDLTM3pkNzXeTHtM9nm6dneJdoTIFCpkJohGiLv+XFhLVOABfvPkZ4Sg17R
         C5jrFTos5plLwV+KJV4j4bynYQkVG1X3Rx8YIGcPEJVKzuZ9W4yLzeJ0Dv4kWex78C4l
         sM6EE7nCkCTzayXzJUlCp8i/eksSB9HHON995le1idFobXPf7HcaV/UZKFFVOuJHlzIR
         OZHPrGCGPdY9I8paccUB2cSx37asyWbep+0GKMebrXNRoIsLyUaSS04WuBcbLsIrOy4b
         JzdRGn+bm1HYkc71ylOhpqi5uttMyNImb4S4T8mEZ877SHQjFqfmc6lL3KSCw0jXbOy/
         NHLg==
X-Forwarded-Encrypted: i=1; AKwUvBz6goswBzWeK9vAQKWgTWa0ohAnOc5CpZRglmm3wg3QrYU8m5+yZ/veHwpCCO4BskIqoQZkZ9SOBIT78MuT8nDGrg3zBh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AqUXYReNMi2fIVcGt9S6tV97puDm9mF8OcFYSoMgOj8soxtEU
	aJLlA7rBPozx+THrMMVE0aPtx0fhcSx3g3V/XuVFAM5FCG7DuNoA71g4oUyyvek8s4k=
X-Gm-Gg: AYBFou0DByUZENKsZb/T2XYyj72cg+kMJEHPjOvUX9+Gb8hp6VvfHSEzMMkeKK8OqTm
	CQVMd2bRKSe/C2OaapuzzkaT+yy8hs7BDBQFrw/G93TUQQfnjU2qsa0eZxzEVtModHnyUoxbljL
	5M2KDBNkg9lGZaFLrTjwcEdO4V/JoqyYcsnrcXuqLfWmJQlKFLvhLUbV0IvRfJHHgZ/CdTHjH2M
	GYEmCrkaUttRNhzKkhF5LsIhOWiGpgYa4dYLVCEdabgxDBKWgYRXOJei2tAdGMvEkKTvjlMsGwh
	uT9NMA7aJZxmLx6cNHWwVmKLRqeVs59YIhws29tpU1FsPnNEi/DjI2CUm6WOAinCZ9e9pxLScsE
	6w+IyiSDUGmJISGNECsyxDnEEY48OIV2cpHDJiNtqSuG7xkJ5OQ9G1llWla2iDsqcQDZvzQgX1A
	bHxjaHJfFeGoLlhYUhgDGm713ruSyGTZDmn4Yen7wEL0vnv4WUXo7uBU9Cn0qi44x8dd1u4xGce
	4FsQR3AVBRSZMxNe5rSXo9SM5erRyo/7fC1edgZjkK+CiKKbMzDX3YE5cYXQaBPaDA66gdM1/SO
	gxkpbm7KBE/Ah5++zc0/vUtES9bE7nJmelBGCLEjIrrsilcvzTdJbcyJQuhO5lcdFJ8f4WOmQQv
	rTn25ZvnHE1c4I4IX2WMgnnYavrtYKonBfSsu38zXYfRmHfsp9fsl5n4DnKGDiisc4YM62sR/Ah
	pJI1fVwqThNd5lRbcscQ==
X-Received: by 2002:a05:6a20:914a:b0:3dd:a009:3182 with SMTP id adf61e73a8af0-3e928e2909amr12529216637.42.1793719118513;
        Tue, 03 Nov 2026 07:18:38 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb362ab313sm1592131a12.0.2026.11.03.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:35 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:33 +0800
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
Subject: [PATCH v2 5/8] uprobes/x86: Leave sealed trampolines in place on
 optimisation failure
Message-ID: <eafd3da2cd2c3e2c4d137a46f50351dc6290c5ea.1793718940.git.chris@chrisdown.name>
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

If swbp_optimize() fails, __arch_uprobe_optimize() unmaps the
trampoline it has just created. The next patch seals all special
mappings when CONFIG_MSEAL_SYSTEM_MAPPINGS is enabled, which includes
uprobe trampolines, and then this do_munmap() would fail with -EPERM
and warn a second time.

Nothing is really leaked if we leave the trampoline mapped in that
case, since get_uprobe_trampoline() reuses any existing trampoline
which is in reach of the probe. So let's just leave it in place when
it's sealed.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..fb895bfc09e0 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1183,7 +1183,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
 	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
-	if (WARN_ON_ONCE(ret) && new_mapping)
+	if (WARN_ON_ONCE(ret) && new_mapping && !vma_test(tramp, VMA_SEALED_BIT))
 		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
 	return ret;
 }
-- 
2.54.0

