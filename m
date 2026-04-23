Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D81C5F13
	for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988394; cv=none; b=EA28+vQ1UOqjdiZGmo5dW4FI5bnnkzDV2MLNGnJomE/SAnadfUyfYn+pOXID9bPO90U0gdwrXdQPzBPaVtkHEgGiTVteMBBofUthiEqiLb4sopqlyVmObY8Oqu7dUOiuznA6bP/fFMyfryBp5KcjUS6TeiCRNfeRRaBwdNNe4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988394; c=relaxed/simple;
	bh=LhxYvujlhvaEtdIVuiDzIqyDfC6QuACp7JiNpGURol4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=M4zvZGYbHb6Yfe92kqh3tYm6g60QRK8lUEozv2maEZ020yRw1llSzC5L9qHzQ0BFmWWPhJAcimsKGOJoRYvAmaGATQiDMfrGTxSi7uAh3wUTB7KhuJFkTsJzEqXdyyw1ayuyyZHrNc5aRlLLvtIQef+1C1+wp/kKFFyJt9q4BD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=qLSYyRwI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="qLSYyRwI"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D92FF3F7B0
	for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 23:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776988383;
	bh=0yd4d0HAXZzH8riizFR8SVnDYMLgEHOHuyRaksZYiTs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=qLSYyRwIhlQLbwYvhMsXdLRRKZYA7QF/pxfWIL0go7NiV5yCmPn3FQy8lVxmPyOXe
	 nHlmNYytkALDklq5rjq0v5ok7qBCTV+Z6kVEZemmI5/ax5k7Y2MzAWQ4NKj8gqsX08
	 bM8clD955W3hXyklKEmEwNduquyGPPCuVE/O9s/XnUQZRn7cP7HrYy77s0sD6iVsrm
	 U6gPzTWvWrDC+IAQ5bhq+0y7d4ZXwYEWhIbzccJyFKs0VYqGVlXewU/nEOshQ5UQUt
	 bw2xcgJ9cfZqmzwFS4k7sRBYNm8uekKc66N2Pur9OpovmihBr6Ow1v+1OTy5Xk8hwB
	 M36gSHGjWaPw0hQ2nRC8K3taOo1q2Si4VYDjhJZWDPQ6PMq2tScCj0nrjDw7+aZ3s/
	 P0BL/Xkrkd4ukgArm74NfVnO76JTgib0xedZhVkN0Oz7W9g/RYy0k31YjOIgPjdaIA
	 jfWPyAv9hqBZ7kLVegLniLezLOLKXcKg+EO4rjt3OrVI63SdbXxydjQxK5qiaZnJ3c
	 U5yf7ranqjH7krg6Z1hfrbLL/ILRUNjAKVP+kpaTWVNubRtj6vK65WpqW+Il93MCZE
	 waEtkev7kfWXtwjqipPoZ3d2ZUllzTI4s9PJINAwGRS2m20SEWnkYq9EumR7R56JfE
	 O2KiNyCIhvx3rOJF7Mfw7Aog=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso6349891a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 16:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988382; x=1777593182;
        h=content-transfer-encoding:organization:autocrypt:cc
         :content-language:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yd4d0HAXZzH8riizFR8SVnDYMLgEHOHuyRaksZYiTs=;
        b=NamGonyUg7Kh78wNQkOpu5jsupJtlYyjknWxFEONUlBheBADClaqKFp8tSRgZ8Bo1T
         2drBpXUJUQd/0gMmLsiXWEa3a/sllH84iERWJJ17tRBGe9d1pqtSWHSyJKnUiUGLwzAp
         xuLVjHMmjKyrVy4OpUEsC93ljbi2OBQgiN6BdRmCMMQRp/T8PqILbrpUG1vvuvvN03g6
         wPZAUXcqJVgZVraNxbLAr/PvyMTGBiWQfCj0k/eZXovoqnJzfpj4XKytL8wtuR83qFzp
         YafSxetmbvinjQ9wOxJO0afENeSgdPPQFMhpY6Of8CweI0M1C0+SmYw502f5FnWiynLz
         zydQ==
X-Gm-Message-State: AOJu0YyOx8lGw5AIiW1h56OETCpmqCT/t4iS7qlA7zVtg6riBOpwWCS+
	mPjDnXKsOHbOCYzPeOhlQngOlZy3NLIxKgFr4aqAIjRkoEUoE7Vz7UdpMFgG9FmzDswhvA4VA5r
	rU7Eh7RGixZdjVgdOeLdDnGdzW0lCGWK2e2QTrDRaikwUMpWwCe3zTfgzOvyKH08NrdSnWKMXvV
	olOdasBn1CCAk/AlUjIRJ2DfiKpg==
X-Gm-Gg: AeBDievam+IfAyKmsI2dKY6yY6eTp90j3pqM1KYU4nB2s6OJn8eCdMBpWyD9YNk9fqY
	3iGnr1FCt/3JOVgDTNvSAEgkXJTu1DtP1oJCUHXlVcYXWsVONWTRm5o9v3e9SwMMscL5YkvDrma
	SPng3nR0/55Rw0dsw9mxrbsfiMfhWEiaRjHehGl4VbvK2EsYuRER6BsgLp+GVoED99O8CFPmnit
	eMZJT2nMTsJld4V7+HO1ZYvJ5DNvrfcAK+yErT/e0I4nnSLs8c/rGVH6fjVtH0v2H1cU4po5sxN
	MDV+8I/bhIA4C+cJMqg6YqRS2FO0aMsk6qC3DcnHWAZzrO+AYhg4mB75dx8iFhyT1O0c34kwHG2
	pQvhKjhuaemOhlu6vxWaK9HQQoxiLwbvTdSdl3yk+vXtzVng=
X-Received: by 2002:a17:90a:910:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-361472e4e85mr17432246a91.26.1776988382537;
        Thu, 23 Apr 2026 16:53:02 -0700 (PDT)
X-Received: by 2002:a17:90a:910:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-361472e4e85mr17432234a91.26.1776988382125;
        Thu, 23 Apr 2026 16:53:02 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3614198f775sm25966928a91.16.2026.04.23.16.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 16:53:01 -0700 (PDT)
Message-ID: <1d7db151-f119-4270-aee7-b3fb568c47b2@canonical.com>
Date: Thu, 23 Apr 2026 16:53:00 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 7.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Language: en-US
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

We ran into some issue with what was going to go in this cycles PR,
and I am still not happy with the revisions.  So I am just going with
some bug fixes and 3 cleanups that have been queued most of the cycle.

This has been merge, built and regression tested, against your tree
from a couple of days ago.

There isn't any thing all that exciting in here, separating out the
changes.

+ Cleanups
   - Use sysfs_emit in param_get_{audit,mode}
   - Remove redundant if check in sk_peer_get_label
   - Replace memcpy + NUL termination with kmemdup_nul in do_setattr

+ Bug Fixes
   - Fix aa_dfa_unpack's error handling in aa_setup_dfa_engine
   - Fix string overrun due to missing termination
   - Fix wrong dentry in RENAME_EXCHANGE uid check
   - fix unpack_tags to properly return error in failure cases
   - fix dfa size check
   - return error on namespace mismatch in verify_header
   - use target task's context in apparmor_getprocattr()


Pull at your convenience -rc2 even later is fine, and if you want I
can just send the bug fixes up during the -rc2 window.


thanks
- john




The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-04-23

for you to fetch changes up to 11b7df0952663f20ce72c9a22a3cf9278cf84db7:

   apparmor/lsm: Fix aa_dfa_unpack's error handling in aa_setup_dfa_engine (2026-04-22 20:11:08 -0700)

----------------------------------------------------------------
+ Cleanups
   - Use sysfs_emit in param_get_{audit,mode}
   - Remove redundant if check in sk_peer_get_label
   - Replace memcpy + NUL termination with kmemdup_nul in do_setattr

+ Bug Fixes
   - Fix aa_dfa_unpack's error handling in aa_setup_dfa_engine
   - Fix string overrun due to missing termination
   - Fix wrong dentry in RENAME_EXCHANGE uid check
   - fix unpack_tags to properly return error in failure cases
   - fix dfa size check
   - return error on namespace mismatch in verify_header
   - use target task's context in apparmor_getprocattr()

----------------------------------------------------------------
Cengiz Can (1):
       apparmor: use target task's context in apparmor_getprocattr()

Daniel J Blueman (1):
       apparmor: Fix string overrun due to missing termination

Dudu Lu (1):
       apparmor: Fix wrong dentry in RENAME_EXCHANGE uid check

GONG Ruiqi (1):
       apparmor/lsm: Fix aa_dfa_unpack's error handling in aa_setup_dfa_engine

John Johansen (2):
       apparmor: fix dfa size check
       apparmor: fix unpack_tags to properly return error in failure cases

Massimiliano Pellizzer (1):
       apparmor: return error on namespace mismatch in verify_header

Thorsten Blum (3):
       apparmor: Replace memcpy + NUL termination with kmemdup_nul in do_setattr
       apparmor: Remove redundant if check in sk_peer_get_label
       apparmor: Use sysfs_emit in param_get_{audit,mode}

  security/apparmor/lsm.c           | 36 ++++++++++++++----------------------
  security/apparmor/match.c         |  2 +-
  security/apparmor/path.c          |  8 +++++---
  security/apparmor/policy_unpack.c |  2 ++
  4 files changed, 22 insertions(+), 26 deletions(-)

