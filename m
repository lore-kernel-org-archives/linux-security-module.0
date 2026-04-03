Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621B3CF69B
	for <linux-security-module@vger.kernel.org>; Fri,  3 Apr 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236149; cv=none; b=nR2ofwkxFZdr3g99bBGxo3yVNM0Ns5IbA9MfcRbzBqZUFwn5eV7+ZwRmShGNdPp65dqRDgToz6XPROGIgVWKUNKpHjK1WVxhMce+1z3V2Agj3aoLFZ+7In+6OQf0S6BYa1TnNcmNTfnnjr03dkxmm5G0TuCMnHWOq74rxeDkzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236149; c=relaxed/simple;
	bh=ZlklJEKfH/WRO+EUZPs7YkN6XdgDhkMxRf+i5ma5MA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku6SaYgIF03VGuz/0yuHFhq6qMyGYLSChD3DtVgJBGBGXuQZHJ2k2ZXgeaoJORMe4QDrVmzY1kQ8LSrZb4Rjab6st7ok1jD+lkEvVA55Qv4NH/L9R+RMu8qKuAzEnDAp2xy8DAjTTgxnreGFTWgu5PYsb+iFqCgUwslTS3WcILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qVvSlwnK; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qVvSlwnK"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fnQDT483Kzr5N;
	Fri,  3 Apr 2026 19:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775236137;
	bh=5fYyptLt80MJGU3BYZf7WCfFcSlen8EdsO5N4+/rj8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVvSlwnK8wEDizsA09V+dSiD1qTViCDNv57UBEr8Hib3ZRg4fnz+ZI0Muc+8+EX9M
	 dSUUUQ/ExmXG8mv/28yAUSSl84MOTx/stAgWfJGwR0wocLXsNqaxBZ7NVuJO/AbIUT
	 NU8P3pd92L+7W6v8SP+SFsyW1CAXYODcmuRndoxk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fnQDS6wr6zGmp;
	Fri,  3 Apr 2026 19:08:56 +0200 (CEST)
Date: Fri, 3 Apr 2026 19:08:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v3 0/5] Fix Landlock audit test flakiness
Message-ID: <20260403.aimeisieB4ei@digikod.net>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402.eb5c4e85f472@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402.eb5c4e85f472@gnoack.org>
X-Infomaniak-Routing: alpha

On Thu, Apr 02, 2026 at 10:52:46PM +0200, Günther Noack wrote:
> Hello!
> 
> On Thu, Apr 02, 2026 at 09:26:01PM +0200, Mickaël Salaün wrote:
> > This series fixes two classes of audit selftest failures plus two minor
> > bugs in the audit test helpers.
> > 
> > The main issue is that domain deallocation audit records are emitted
> > asynchronously from kworker threads and can arrive after a previous
> > test's socket has been closed.  This causes two distinct failure modes:
> > 
> > - audit_match_record() picks up a stale deallocation record from a
> >   previous test instead of the expected one, causing a domain ID
> >   mismatch.  The audit.layers test (which reads 16 deallocation records
> >   in sequence) is particularly vulnerable because the large read window
> >   allows stale records to interleave.  Patch 4 fixes this by filtering
> >   deallocation records by domain ID and skipping type-matching records
> >   with wrong content patterns.
> > 
> > - audit_count_records() counts stale deallocation records from a
> >   previous test, incrementing records.domain from the expected 0 to 1.
> >   Patch 3 fixes this by draining stale records at audit_init() time and
> >   removing records.domain == 0 checks that are not preceded by
> >   audit_match_record() calls (which would consume stale records).
> > 
> > These races are more likely to manifest when additional instrumentation
> > changes kworker timing in the deallocation path (e.g. with the upcoming
> > Landlock tracepoints work).
> > 
> > The two minor fixes (patches 1-2) correct a snprintf truncation check
> > off-by-one and socket file descriptor leaks on error paths in
> > audit_init(), audit_init_with_exe_filter(), and audit_cleanup().
> > Patch 5 fixes a __u64 format warning reported by the kbuild bot on
> > powerpc64.
> > 
> > Patch 1 is an exact subset of the v1 combined patch, which is why it
> > carries the Reviewed-by tag.  Patches 2 and 3 extend beyond what was in
> > v1, so the Reviewed-by is not carried.  Patches 4 and 5 are new.
> > 
> > Changes since v2:
> > https://lore.kernel.org/r/20260401161503.1136946-1-mic@digikod.net
> > - Patches 4-5: fix __u64 format warnings on powerpc64 (cast to unsigned
> >   long long for %llx).  Patch 5 is new.
> > 
> > Changes since v1:
> > https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> > - Split the combined drain fix into four separate patches.
> > - Patch 2: extend fd leak fix to audit_init_with_exe_filter() and
> >   audit_cleanup().
> > - Patch 3: also remove domain checks from audit.trace and
> >   scoped_audit.connect_to_child, document constraint, explain why a
> >   longer drain timeout was rejected.
> > - Patch 4: new, add domain ID filtering and timeout management to
> >   matches_log_domain_deallocated(), skip stale records in
> >   audit_match_record().
> > 
> > Mickaël Salaün (5):
> >   selftests/landlock: Fix snprintf truncation checks in audit helpers
> >   selftests/landlock: Fix socket file descriptor leaks in audit helpers
> >   selftests/landlock: Drain stale audit records on init
> >   selftests/landlock: Skip stale records in audit_match_record()
> >   selftests/landlock: Fix format warning for __u64 in net_test
> > 
> >  tools/testing/selftests/landlock/audit.h      | 133 ++++++++++++++----
> >  tools/testing/selftests/landlock/audit_test.c |  36 ++---
> >  tools/testing/selftests/landlock/net_test.c   |   2 +-
> >  .../testing/selftests/landlock/ptrace_test.c  |   1 -
> >  .../landlock/scoped_abstract_unix_test.c      |   1 -
> >  5 files changed, 119 insertions(+), 54 deletions(-)
> > 
> > -- 
> > 2.53.0
> > 
> 
> I am still getting flaky audit tests even with these patches, I am
> afraid.  It differs which of these tests is flaking, some of them
> still do, for example:
> 
> #  RUN           audit_layout1.remove_dir ...
> # fs_test.c:7281:remove_dir:Expected 0 (0) == matches_log_fs(_metadata, self->audit_fd, "fs\\.remove_dir", dir_s1d2) (-11)
> # remove_dir: Test failed
> #          ❌ FAIL  audit_layout1.remove_dir
> not ok 191 audit_layout1.remove_dir
> #  RUN           audit_layout1.read_dir ...
> #            ✅ OK  audit_layout1.read_dir
> ok 192 audit_layout1.read_dir
> #  RUN           audit_layout1.read_file ...
> #            ✅ OK  audit_layout1.read_file
> ok 193 audit_layout1.read_file
> #  RUN           audit_layout1.write_file ...
> # fs_test.c:7221:write_file:Expected 0 (0) == matches_log_fs(_metadata, self->audit_fd, "fs\\.write_file", file1_s1d1) (-11)
> # fs_test.c:7224:write_file:Expected 0 (0) == records.access (1)
> # write_file: Test failed
> #          ❌ FAIL  audit_layout1.write_file
> not ok 194 audit_layout1.write_file

I never hit these issues and I cannot reproduce them.  This patch fixes
the async events (i.e. domain drops).

You can try to increase audit_tv_default.

> 
> My kernel config is this:
> 
>     make defconfig
>     make kvm_guest.config
>     KCONFIG_CONFIG="${KBUILD_OUTPUT}/.config" ./scripts/kconfig/merge_config.sh "${KBUILD_OUTPUT}/.config" tools/testing/selftests/landlock/config
>     make debug.config
>     echo "CONFIG_RANDOMIZE_BASE=n" >> "${KBUILD_OUTPUT}/.config"
>     make olddefconfig
> 
> and then I run the selftests in Qemu with these flags:
> 
> qemu-system-x86_64 \
>     -nographic \
>     -m 4G \
>     -enable-kvm \
>     -append "console=ttyS0 lsm=landlock no_hash_pointers" \
>     -kernel "${KBUILD_OUTPUT}/arch/x86/boot/bzImage" \
>     -initrd "${INITRAMFS}"
> 
> This is using my own selftest runner scripts which builds an initramfs
> with the statically linked selftests.

Can you try with the check-linux.sh build kselftest (which also set a
lot of debug options)?  You can also try with qemu if you set
ARCH=x86_64

> 
> Do you have a hunch what might be missing there?  In the test run
> above, I have applied your V4 patch set on top of the current master,
> 5619b098e2fbf3a23bf13d91897056a1fe238c6d ("Merge tag 'for-7.0-rc6-tag'
> of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux").

This is weird because this is related to FS events, and they should be
(almost) synchronous events.  Maybe the audit event pipeline is made
very slow because of some audit options but still...

Anyway, this is not what this patch fixes, but we should fix your issues
as well.
