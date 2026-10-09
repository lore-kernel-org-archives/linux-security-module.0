Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36B4E325F
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546721; cv=none; b=cFz3wPthRuh1y7EVfspr24DFVZM2gTejkXIhmaBSk8J7VTokXh1fjlnxL0M/1i69U+h5+DtHRvJ4y4p12zzSAqxasgsbj4k6x8TKoS2jF/p0WM3ggZq0X7DKUmbGtWd+8ef1/Jplxn4HkdcNB337W12XOXk/kHL4+WdOsdvsJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546721; c=relaxed/simple;
	bh=9c10fv+8RlbffEaqllSZarWYu0IWQKMv/n0/uRyLBSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeYjv27+HpCINi0qy5zsGbIuRJTRQ9wMEOP62hVtNWCPiv5wvmgFVppefQwnjFPvYz1k4ekByFG3hZk5OmKCLuv90s72AlIIMWD+nrItH+PPUtsjddp5Ux8wP0Iuv3B6mNokb1KKvja4h1B2MZfNDJ6rpeh0ka8kKJDk/W+vGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO6Eh2ZQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO6Eh2ZQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-917a707f37eso44853796d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Oct 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791546707; x=1792151507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrr3HiCUZJnv9aA8BpT1SjaAKZ8xaCXAbRRl/khQOqQ=;
        b=jO6Eh2ZQJWUVs1XkFGOQ2/kkXQqsVbEPVNN3maclXC/GNS0mhJEB4C+Na3oyNMh0bf
         PgjtmOtYu0AIhLiy4JraPjedasoRm1RjN/ef250aNI/zA4Tmuq4WiT2QBxVMi9brA68N
         pQEG5tisvimfiiQdObaZSmoTEKX6i6BQI9BA/sfuiuPKQ2s6lztZX0Kx/UbLZwJCel+L
         Vx2w6J1rjFe1wu8BuV63kPPRyOQ+rPyprI9DV2GjUHSJOErdaO7WIzJMwEtO2RsIi0fJ
         KKQeGiMBETj2Cxff+ro1B0X8Qc2tXZ/3b5P9Ydyta0sahvmbnNitAo1KvmVYD54toqxW
         ynVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546707; x=1792151507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrr3HiCUZJnv9aA8BpT1SjaAKZ8xaCXAbRRl/khQOqQ=;
        b=WIOY3q27ScRTCTCRHgzq33IWDW8aXsSRSn2ZYEBzeEnT+1WgCvizNrxT1fc0WpYEnr
         iGSzojwfUIvGqhS/v5f0NT7PrsmLDmTgy4Q9T4I8IVyR66ttCxdpgp2rutdGZWDDiCYR
         kxtblwFA/VPn6krBlJlN4gpWf5Sju5Zg2FlsYhViHy9s0XVRsK3MdFrYlzmzRTiZ8LIN
         c0P2o1L0ApuLiQ4Ia8UoddPlD/NLkkfMBTO7XKie/ieAQ3lG7eoVZwsTUaSZcnlnQ0iP
         F4QpVUrL+cQ+vGCHca0hWQ9zUFbXB/BTm/ilcTPjjFRCL7tyK04gCkI+RdL2flUR9ckR
         ysNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ0uCrtJFnN+ZHFwu7zExT0ZgB2rrK3FftFXAWIEXJzCj9x4gGyf/p2vsuoghK717l61NrDN4iRwtwoKyVvNWy7ZNXQtY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7Ig98s1+KaQYRcGxL5KPasueK2ZBPpheeIjzd1FiQXriFZEae
	xe6YusHHz8SjJM0WgJjxT8geIjX2eYoDKfzv1rmI9p3Lb7BdNOhLa4JZ
X-Gm-Gg: AYBFou1yawbnJ7wR1tf7MRTwHUB0IrIb7AP3wj1FSRy9NRfpkNCnd08wfW9rHDF0gGW
	Np9u0LSsY8aaQkcsA7vziqfjBiZgNdhWFlsxl1TtvTVukmXJnfOqThqsnQfLz29TdOinpZEd/b7
	o4v3Zp9tPsCkHDMAIFWPEiG6IabGTcwkYUsHcCtuFVzf8HJFxl2F5sWSoCv/OhFw7Lvf+wp54Cf
	RbTBnJXtXjXNRsqPeA+hFmz2g71Km7nDtNNuSTk7EjengyfuhrVuEd4obE9lbVkDCh25KgmYY3C
	vVfK1c7c8buZexwqfhspGhjlkNHqfH5SJ0ndCmoYbruM4rCvCY+/zfjnc+u1jusptgAxWC8GANq
	/BZLfkqNrR+XkPR1oRkvi5tBn274DD30NO332Hlpzy3t34BTVJUOG72ktK4aF6ImhWvmCYPcZLb
	Vy8cFRB/NXkVRMztbLVoWHVT/OM8Pve05sRDdTJadq/P83klDlF2BP6y0inlVFvSwt6eQp5E7uD
	qsrEwnOtp4ohkJOCui8sIYSQB7vkvp9Hr+QY3s/RARlh2vuSWRMHTZ+FoIPhmXwYhq3SHlyiS8p
	soqDP7C7QOqU49M=
X-Received: by 2002:a05:6214:2f05:b0:918:c4b8:fc57 with SMTP id 6a1803df08f44-91b554f1bbcmr27272116d6.9.1791546707414;
        Fri, 09 Oct 2026 04:51:47 -0700 (PDT)
Received: from mobile5.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b54e7f6aesm16537346d6.2.2026.10.09.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:51:46 -0700 (PDT)
From: Mike Bommarito <michael.bommarito@gmail.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the anonymous union
Date: Fri,  9 Oct 2026 07:51:08 -0400
Message-ID: <20261009115108.17819-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 07, 2026 at 07:28:30PM +0300, Abel Vesa wrote:
> With Clang 20 and CONFIG_FORTIFY_SOURCE, stacking Landlock domains can
> trigger a fortify panic in the handled_masks copy in inherit_ruleset():
[...]
> Based on next-20260930. Validated arm64 Landlock object builds with
> Clang 20 and GCC 14, with CONFIG_FORTIFY_SOURCE enabled, and checked the
> counter load in Clang-generated code. Not boot-tested.

Hi all, hit this issue yesterday on x86_64 (Framework 13, Meteor Lake),
v7.3-rc5 built with clang 21.1.8 and CONFIG_FORTIFY_SOURCE=y.  I triggered
it simply by opening the printer settings on 26.04 (through xz, see below).

My build tree was recent v7.3-rc5, so I applied the patch, which was clean,
and then went through the repro steps after rebuilding.  Everything works
as expected after 10-15 minutes of use - no crash, no other dmesg/journal
issues.

I hope you don't mind, but given how irritating it was to track down
the issue, I am including some of the Claude output below to help others
find the root cause more quickly if they hit it.  I checked the
disassembly and ran the tests below myself on this machine.

<CLAUDE>
This is easy to hit on a stock desktop.  xz 5.8 sandboxes itself with
nested landlock_restrict_self() calls, so on an unpatched clang build every
`xz -d` oopses:

  memcpy: detected buffer overflow: 4 byte write of buffer size 0
  WARNING: lib/string_helpers.c:1037 at __fortify_report+0x1f/0x60, CPU#6: xz/9888
  kernel BUG at lib/string_helpers.c:1044!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:__fortify_panic+0x9/0x10
  Call Trace:
   landlock_merge_ruleset+0x353/0x360
   __se_sys_landlock_restrict_self+0x1bf/0x470
   __x64_sys_landlock_restrict_self+0x16/0x30

On Ubuntu, simply opening GNOME Settings -> Printers runs the CUPS driver
helpers, which run xz.  With kdump-tools installed (panic_on_oops=1), that
panics the machine.  Nothing more than an unprivileged process is needed;
the reproducer below triggers it as a normal user:

  prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
  for (i = 0; i < 2; i++) {
          struct landlock_ruleset_attr a = {
                  .handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG };
          int fd = syscall(SYS_landlock_create_ruleset, &a, sizeof(a), 0);
          syscall(SYS_landlock_restrict_self, fd, 0);  /* i == 1 oopses */
          close(fd);
  }

The x86_64 codegen matches your arm64 analysis.  Unpatched, with
num_layers at 0x24 and handled_masks at 0x28:

  mov    0x28(%rbx),%esi      # "count" read from child->handled_masks[0]
  shl    $0x2,%rsi
  cmp    %rdx,%rsi
  jb     <__fortify_panic>

With the patch, num_layers is at 0x40 and handled_masks at 0x44.  The
count is loaded from the right field, and clang folds away the fortify
checks after the WARN_ON_ONCE(child->num_layers <= parent->num_layers):

  mov    0x40(%r12),%edx
  cmp    %edx,0x40(%rbx)
  ...
  call   memcpy

Results after booting the patched kernel, with panic_on_oops=1 and
kdump loaded (the configuration that used to panic):

  nested restrict reproducer:  both layers succeed
  echo hello | xz | xz -d:     ok
  lpinfo -m (CUPS -> xz):      ok
  fortify reports in dmesg:    none; kernel not tainted

The layout change grows struct landlock_domain from 64 to 72 bytes.  A
one-layer domain is still a kmalloc-96 allocation (68 bytes before, 76
after); only stacks of 7 or 8 layers move up to kmalloc-128.  That seems
fine.
</CLAUDE>

Since this is reachable from unprivileged userspace on any clang +
FORTIFY_SOURCE build of 7.3-rc, it would be good to get this in before
v7.3 final.

Tested-by: Mike Bommarito <michael.bommarito@gmail.com>

