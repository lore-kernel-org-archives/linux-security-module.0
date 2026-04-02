Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FB345722
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163172; cv=none; b=Mw6bJPm1EW8k+R8qewYWF1qVjHiEN5XzWVKFt+nwReTXKgvKje8WzDwdmiyea29Blyfe8m5pANlhojU10ZLdJv98pRbSr2EL2LszUKi8twIXI10Kcxb1jTtB/faDZQx7IT34EyN58VaUR3m5zcyW/ovE0zOfz5UBrQNLoaNneG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163172; c=relaxed/simple;
	bh=IShvUrbBonzsNtasVVWZHVDgwB3II331EyLkZPw1a6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk8lpikJAVWyYjuV+/lfi6nwQ1a1GgJjR0jPY8BosoTwxt9rcMzRJabbr0PBFpHSichE+DNxBoRS2taw93vemlteywUO0a/lyvQEcFeQ0BAOoLoil0rkyxfjg2zEvnLa42E+WvXTY/CxiqnTgHX7PI6bINMEaJUGfkp5eQOl0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHlpjfy6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHlpjfy6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso11885865e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775163169; x=1775767969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0DwIaUjm3HmsZNGXG4j5FEt0XwdKKGoxWAT4q6G4Ho=;
        b=mHlpjfy6YJvmpTtn5ZzwaJh5Mn5aKY0GHqUPXhzgnMEfMC9z40aSHNarIa+/fbw9CO
         yETOUOsHMnIHWKt8n95x8IFzmxhDKW/7mStIEmrhh2OXMK3Gq+KUkb0MEjBxctmcbQly
         fNf5Yb3r/sLUfZWzO9gd2kfV2BdmuriQTTIwKoG9Qcryz9repYZVnMzPaxLTcoCXGdy2
         Himh6jU1UWECUYDAwOta2Lz2qaUQwln068aa/D2SOlmVNSjL+Oe5XUWuuYmCYf4M/qyP
         e34B0l9gs15hNkDMIxEXw/H+XBWeo6hB/W5KxC3a9KOcoe1CrArd512t8OjRVE8NzfOA
         1eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163169; x=1775767969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0DwIaUjm3HmsZNGXG4j5FEt0XwdKKGoxWAT4q6G4Ho=;
        b=nCZqdDVkck3HF6d5ASQ1fJhLalFguPsndwM2ZrkQvGdoQyB+yAvUN6f7kTr8mmjXd0
         TxNR339shcAay1tK0e0eX5A0TcAACrdSGj4x2H1l6hl1z2nJ1kpzZ+gyeBjhI7qf6NkE
         E+2HVc+86/iH/ReC2XtWG46iu+bU06yMW5n0pUzId3wYXbluRT/2y+jBYrPBnYtE67Cm
         oBbtHdIM7sb4tbw4w5pLTqOHb8kyIHDv6bidsmjeW7FxkiwB2SACWRKE74xxODCm27BQ
         OnpmzpaoUGnZPC6FOrpc5hv1RLNa03wOirmskT+mp26MG6NShq9ggUV6iBZqlXPshzr5
         Ci+w==
X-Forwarded-Encrypted: i=1; AJvYcCW5n7XDvcb/MbEgg91dVwRp98CdH9G7jniFUcBT1LHPecXzxDMCb71+bma5tBUGRE8Gwxu5fdZpfBaNVPyfrd0/84N8Lyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzN8rQ/dL23MB20LWddFCcu+XFDkxLu2Ae5yBKdFykFTeGWcYX
	05ACfXyIJzCBMnWDCGFj69NCkSZmAy6J6ZzMjWLVTUng/H8kiIzE36V7
X-Gm-Gg: ATEYQzw8QHGN8yunR9M2/A7A6OquOgmzklwM7sH8qpYeFjxXQKoeFA93FnVPgNnr1Wh
	9EmxDyW3PsZyr62Hg17QU+rQhSctzDfr0+muSmhtHYBSygO34rHaZ0O+lqdHAyf1OPdFiJf2SQ6
	OV6RT6XSp9Q80UxQ/RaoV3n2uvPPT2Ww0FNpJG5msHAkVmkJiWjtnN50YbZbHhVBBD1pkC1n7m/
	3k622Z//Iy8iiHZQ9L07CFYLQ07TeddhjdUhpm1XF9I7jBpXBZpvZBDpLp6eDzW6YnhzgHovque
	IyIFcTxpufdoB/r3HJ16weafro7j2f13LA5DetpIzUJ88GYDaWxx7kxwhfW7eajEtx6xmSI0ZcG
	VX7OoOUu8n3LaFn3fB6oRQdlIF7gE0AOlB0I/w3FSG0NPIPeS9VfjGZHF1+IgGcdsGOkvUeu2H6
	hST/9j+8YHG5Er4TR9gTHZAovxgi48wvzMwTspwB00ADeFFHSR
X-Received: by 2002:a05:600c:3f16:b0:486:fbc8:8dfd with SMTP id 5b1f17b1804b1-488997bd943mr7980015e9.23.1775163168660;
        Thu, 02 Apr 2026 13:52:48 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488980db973sm8291765e9.3.2026.04.02.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:52:48 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:52:46 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v3 0/5] Fix Landlock audit test flakiness
Message-ID: <20260402.eb5c4e85f472@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-1-mic@digikod.net>

Hello!

On Thu, Apr 02, 2026 at 09:26:01PM +0200, Mickaël Salaün wrote:
> This series fixes two classes of audit selftest failures plus two minor
> bugs in the audit test helpers.
> 
> The main issue is that domain deallocation audit records are emitted
> asynchronously from kworker threads and can arrive after a previous
> test's socket has been closed.  This causes two distinct failure modes:
> 
> - audit_match_record() picks up a stale deallocation record from a
>   previous test instead of the expected one, causing a domain ID
>   mismatch.  The audit.layers test (which reads 16 deallocation records
>   in sequence) is particularly vulnerable because the large read window
>   allows stale records to interleave.  Patch 4 fixes this by filtering
>   deallocation records by domain ID and skipping type-matching records
>   with wrong content patterns.
> 
> - audit_count_records() counts stale deallocation records from a
>   previous test, incrementing records.domain from the expected 0 to 1.
>   Patch 3 fixes this by draining stale records at audit_init() time and
>   removing records.domain == 0 checks that are not preceded by
>   audit_match_record() calls (which would consume stale records).
> 
> These races are more likely to manifest when additional instrumentation
> changes kworker timing in the deallocation path (e.g. with the upcoming
> Landlock tracepoints work).
> 
> The two minor fixes (patches 1-2) correct a snprintf truncation check
> off-by-one and socket file descriptor leaks on error paths in
> audit_init(), audit_init_with_exe_filter(), and audit_cleanup().
> Patch 5 fixes a __u64 format warning reported by the kbuild bot on
> powerpc64.
> 
> Patch 1 is an exact subset of the v1 combined patch, which is why it
> carries the Reviewed-by tag.  Patches 2 and 3 extend beyond what was in
> v1, so the Reviewed-by is not carried.  Patches 4 and 5 are new.
> 
> Changes since v2:
> https://lore.kernel.org/r/20260401161503.1136946-1-mic@digikod.net
> - Patches 4-5: fix __u64 format warnings on powerpc64 (cast to unsigned
>   long long for %llx).  Patch 5 is new.
> 
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> - Split the combined drain fix into four separate patches.
> - Patch 2: extend fd leak fix to audit_init_with_exe_filter() and
>   audit_cleanup().
> - Patch 3: also remove domain checks from audit.trace and
>   scoped_audit.connect_to_child, document constraint, explain why a
>   longer drain timeout was rejected.
> - Patch 4: new, add domain ID filtering and timeout management to
>   matches_log_domain_deallocated(), skip stale records in
>   audit_match_record().
> 
> Mickaël Salaün (5):
>   selftests/landlock: Fix snprintf truncation checks in audit helpers
>   selftests/landlock: Fix socket file descriptor leaks in audit helpers
>   selftests/landlock: Drain stale audit records on init
>   selftests/landlock: Skip stale records in audit_match_record()
>   selftests/landlock: Fix format warning for __u64 in net_test
> 
>  tools/testing/selftests/landlock/audit.h      | 133 ++++++++++++++----
>  tools/testing/selftests/landlock/audit_test.c |  36 ++---
>  tools/testing/selftests/landlock/net_test.c   |   2 +-
>  .../testing/selftests/landlock/ptrace_test.c  |   1 -
>  .../landlock/scoped_abstract_unix_test.c      |   1 -
>  5 files changed, 119 insertions(+), 54 deletions(-)
> 
> -- 
> 2.53.0
> 

I am still getting flaky audit tests even with these patches, I am
afraid.  It differs which of these tests is flaking, some of them
still do, for example:

#  RUN           audit_layout1.remove_dir ...
# fs_test.c:7281:remove_dir:Expected 0 (0) == matches_log_fs(_metadata, self->audit_fd, "fs\\.remove_dir", dir_s1d2) (-11)
# remove_dir: Test failed
#          ❌ FAIL  audit_layout1.remove_dir
not ok 191 audit_layout1.remove_dir
#  RUN           audit_layout1.read_dir ...
#            ✅ OK  audit_layout1.read_dir
ok 192 audit_layout1.read_dir
#  RUN           audit_layout1.read_file ...
#            ✅ OK  audit_layout1.read_file
ok 193 audit_layout1.read_file
#  RUN           audit_layout1.write_file ...
# fs_test.c:7221:write_file:Expected 0 (0) == matches_log_fs(_metadata, self->audit_fd, "fs\\.write_file", file1_s1d1) (-11)
# fs_test.c:7224:write_file:Expected 0 (0) == records.access (1)
# write_file: Test failed
#          ❌ FAIL  audit_layout1.write_file
not ok 194 audit_layout1.write_file

My kernel config is this:

    make defconfig
    make kvm_guest.config
    KCONFIG_CONFIG="${KBUILD_OUTPUT}/.config" ./scripts/kconfig/merge_config.sh "${KBUILD_OUTPUT}/.config" tools/testing/selftests/landlock/config
    make debug.config
    echo "CONFIG_RANDOMIZE_BASE=n" >> "${KBUILD_OUTPUT}/.config"
    make olddefconfig

and then I run the selftests in Qemu with these flags:

qemu-system-x86_64 \
    -nographic \
    -m 4G \
    -enable-kvm \
    -append "console=ttyS0 lsm=landlock no_hash_pointers" \
    -kernel "${KBUILD_OUTPUT}/arch/x86/boot/bzImage" \
    -initrd "${INITRAMFS}"

This is using my own selftest runner scripts which builds an initramfs
with the statically linked selftests.

Do you have a hunch what might be missing there?  In the test run
above, I have applied your V4 patch set on top of the current master,
5619b098e2fbf3a23bf13d91897056a1fe238c6d ("Merge tag 'for-7.0-rc6-tag'
of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux").

–Günther
