Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441CE3B813C
	for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759909; cv=none; b=Mten6UvRPwIeyRJI9Z5g3tkSQmlBxmtn/BuvV/UA6yODJ5g/dFHTD8pCkQsm/V+NsaFegGsUhO4+lz3kAr8XAVVzcAaf/3cvJYkxcRZ38bvKWTpW/w/wwLqibHemF3I75WS/Pp2omZY1BQxvSRAfLtf9zwYMwxpj91myvhNHCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759909; c=relaxed/simple;
	bh=bS4x73RKHJ+Ng/B9e79yFhTtNAXSxivKGC1Rgp2q+e4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=g/e0J2I9KuQIno8WCrn2bYnjqWA7L0UrSqWdSgQDq/P63LxYzHgYeOjHUipKx/Tyi6QYASVXntLAE78nG/29oBmVMliSK2AiTVygQ+Gh+1imhAlr1+BIjyc3LD4Zj5phXg2UixI42x2Fd5SW0r3zDeMR2p46OZ6pVwGRXCdFm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q+Jf+zve; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q+Jf+zve"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 213433FBC2
	for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787759904;
	bh=RU+b0EgUdr8YZp0QJv4qyFI+odtfNC7/mQjbnNP14uk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=Q+Jf+zve6snX3mtJ65evSS17Mretla3M36kYU4WIZB3ErdY0ev8tmEZyAxGCm9LGm
	 JjRLfOJiwbmMBEK9TXZGiXq7ltTpkSrZUJG8iD1xIxo/5WiMna3V2R1Np8j1mheAKc
	 m9giWasDfeIN4s9iiy6NXEVY/odkSkDWYwumumYK8I6HHJkydQACjIgy7pzaU9ci2F
	 ts0wIM5LKhwCIMqk+0hcc0f59q7NoAD3nj4he+Wo72Lqtg3u5oriY0i//ZYjUHw1Gu
	 PeRNOvKwO+UJzQdcqClKjsWrzNOkZhjQclLfUticoyNh44ZNohY0e+YSX2bzx7s1aF
	 EBkUPZlv2QQF8jCS53pu1SUw/wuWcw96KU79l+ftETdnEjTJkI2n3IW4a8LpTzjwxz
	 lqAdcpYfKB5iZ5B29v9VR4V7dsqNjCxd5sd570ITE5lWI8rnhmelqP9nGBvyJy40Lr
	 c+LF3MlHr/8KPL0+7JO8O1cL2ucDEPQPrsAEBtU4IIjj0zNjdGASkVriMJLLcKtYLd
	 iQ08Hodvw6nNFlfg45ITYrW+fC1C1Nfss2p/t4b870TAJ69/YegS6fnQZtargiDtCn
	 beSN9pEKHBvca8LgOV6ZRBEKGfozHsDH44cuD0AtGBissXiO3eOpuTqUJ2mob3fjmY
	 J6iEXOLKTqJJYgmdmVdE6Xe0=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso2292031a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 08:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759902; x=1788364702;
        h=content-transfer-encoding:content-type:organization:autocrypt
         :content-language:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RU+b0EgUdr8YZp0QJv4qyFI+odtfNC7/mQjbnNP14uk=;
        b=s0gM7eYQmvL7v8yIAe3FInF0cSMlGApBojYPL6A5vXE/rUo37BKkRSHZz7hDYalmWJ
         PYxqCEcErLl5w4ckitdicW3dBcytcUw/OKWQMGjbxuqSVliVzPHS81/i7kYpmSDCI7Ju
         k1+hStf2R1+fMXu/9a9w1O71l916JlzvN4829JY04k+sJl3T0u7Q0LyNLyO2WLZ5dAE6
         i1fuqXf7yUYuNpS6XWL5pxCK035u03AclPu2ZK48jRZr4vAzNqjvBr4bzY5l3EDCE0mH
         555isUPywz9KOMeExnaHux58d00whhQ33fqawASHSaVorzXUPifgPyBG3bwfwOgmqR3s
         /D2g==
X-Forwarded-Encrypted: i=1; AHgh+Rohjy698VKUVMnY99DDN5ptGyENXl8pJBOmULR11EkLY8DYTVcA8vlOHoWFBM1Rtn/oGFzFv+TANFD5pGX7WmEjjvLlHEY=@vger.kernel.org
X-Gm-Message-State: AFuF++k9jVz5Muird+iGfJLrKDlg78heSf8qKzIFKqg3fJPC+hoyS+X0
	I492tKP0g/OqSjUMA7NZ1SQLk/IqQ99z/W8iUIsuOB3YekKyhdTTCPKoU66ICAdWxcdfPze0MIK
	XPj/NNwsjCj0fMBYURTdpIb/LCeOQmIvyWyemLMgzXTB45wplSjiyTCJ5qD7c+mP2uYHAeXsD+n
	W87HZrmSWu61t6Mxvm4Q==
X-Gm-Gg: AR+sD10dZt6sFnp91sl9DdX2feiWANJf3NpAxgVwCbLB2cVC7N9iBFlYt/73hHWHk1c
	G8BuLgJa8HuUgl1LqqwOmgPfGkk09gXnV1nW3j9S18mbquNahdcwyEzBCNyfzyutHW5qw8CnJC/
	PDbhaaXr9zQK+4fDzy37t17Lrdwmr6oZcSg9wT8EYkJ5PmrC8/x1s6ti6yxMQm2lelgpGB/3HQP
	wSUkqcId/DFXhaO5wZFxfXLjswKnaRp/IvzBlJF85BgsZ6duWVcp7RlKsi14Oegk+9qw6h7ZVL7
	2tcs9fyQB1IwS9aSvu2y4et5udzTWFTnlc03ZVDuDKVJblPPkXFSxIkvbLjUZ8QKy6+g1FSMp99
	h0dXrzHk90z1dIGc=
X-Received: by 2002:a17:90b:560c:b0:396:67ed:da2d with SMTP id 98e67ed59e1d1-3966d4931a0mr17176870a91.15.1787759902282;
        Wed, 26 Aug 2026 08:58:22 -0700 (PDT)
X-Received: by 2002:a17:90b:560c:b0:396:67ed:da2d with SMTP id 98e67ed59e1d1-3966d4931a0mr17176753a91.15.1787759901747;
        Wed, 26 Aug 2026 08:58:21 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39645b07394sm8589234a91.4.2026.08.26.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 08:58:20 -0700 (PDT)
Message-ID: <997f83d3-18ef-4ca6-a1d6-39491b7a4c95@canonical.com>
Date: Wed, 26 Aug 2026 08:58:20 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for v7.3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

I know this is running late, I have an alternate PR with just the bug
fixes if you prefer. I ended up having to drop a couple of patch sets,
and pulled in a couple of the simpler bug fixes late. I have a few
more bug fixes coming but they will have to wait a week or two.

These patches have all been merge, build, and regression tested
against your tree as of yesterday. The majority of the code has had
several weeks of testing, both in linux-next and the Ubuntu kernels.

The biggest functional change is Jann Horn's fix for how aparmor is
doing stale cred updates after a policy replacement.
    apparmor: fix cred UAF caused by begin_current_label_crit_section()
It moves the update to be done during task_work at the end of the
syscall.

The current patch set has one major feature which is allowing policy
to be compressed in userspace instead of after the fact (in kernel) if
we need to hold onto it for CRIU/introspection.  This is responsible
for the majority of the diffstat in apparmorfs.c

The other major change is to do with network mediation. It is a lot of
code churn but does not do any functional changes to mediation. It
moves the code around, and refactors it to use newer patterns for
consistency, and in preparation for some improvements in mediation in
a future patchset. This change is responsible for the majority of the
diffstat in lsm.c and af_inet.c

The cleanup of the mount mediation to the newer patterns and macros is
responsible for the majority of the mount.c diffstat.

With the constification of code being the next largest contributor to
the diffstat.


thanks
- john


The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-08-26

for you to fetch changes up to 3daad923a8685adb66087e0d819559b7eb6ba975:

   apparmor: policy_int make sure list heads are initialized before fail path (2026-08-26 00:03:13 -0700)

----------------------------------------------------------------
+ Features
   - support loading compressed policies
   - add audit mode to provide a mechanism to silence complain messages
   - refactor network mediation to use new patterns, and prepare
     to for extended inet mediation (no functional change)

+ Cleanups
   - switch website link to https
   - make include headers self-contained, and fix circular include
   - constify aa_label, aa_dfa, aa_profile, and aa_perms paraneters
   - mark static tables and structs as read only
   - drop use of _confined variant for iteration
   - refactory mount to use check_perms
   - refactor network mediation code to be together
   - refactor xattr attachment, to take the file path
   - optimize current_label_crit_section()
   - leverage audit_log_n_untrustedstring() when possible

+ Bug Fies
   - initialized policy lists heads before fail path
   - fix deadlock in complain-mode change_hat
   - auditing of mount binary data
   - fix error debug output in fn_label_build
   - fix race condition in label replacement
   - fix unconfined user namespace restriction forced stack
   - fix error handling for copy_from_user in policy_update
   - fix out-of-bounds write when null terminating a label vec
   - fix integer overflow in verify_tags() bounds check
   - fix cred UAF caused by begin_current_label_crit_section()
   - use SEND_SIG_NOINFO instead of NULL in aa_audit()

----------------------------------------------------------------
Baruch Siach (1):
       apparmor: switch website link to https

Fabrice Derepas (1):
       apparmor: fix integer overflow in verify_tags() bounds check

Hyunwoo Kim (1):
       apparmor: fix out-of-bounds write when null terminating a label vec

Jann Horn (1):
       apparmor: fix cred UAF caused by begin_current_label_crit_section()

John Johansen (30):
       apparmor: fix alternate loaders ability to load compressed policy
       apparmor: compressed_data not described in aa_get_data_from_compressed
       apparmor: Fix build failure when ZSTD_DECOMPRESS is not enabled
       apparmor: fix implicit declaration of function 'decompress_zstd'
       apparmor: Fix warning: 'decompress_zstd' defined but not used
       apparmor: optimize current_label_crit_section() with needput
       apparmor: fix error handling for copy_from_user in policy_update
       apparmor: make MEDIATES_AF_UNIX its own fn
       apparmor: refactor network sock mediation in preparation for inet mediation
       apparmor: push inet mediation into profile callbacks, and improve auditing
       apparmor: refactor network socket mediation to support compatibility
       apparmor: move netfilter functions next to the LSM network operations
       apparmor: move sock_rcv_skb() next to inet_conn_request
       apparmor: reserve mediation class for packet mediation
       apparmor: fix unconfined user namespace restriction forced stack
       apparmor: refactor xattr attachment, to take the file path
       apparmor: fix race condition in label replacement
       apparmor: make table entry count last enum for static tables
       apparmor: fix error debug output in fn_label_build
       apparmor: mark static tables and structs as read only
       apparmor: add audit mode to provide a mechanism to silence complain messages
       apparmor: fix auditing of mount binary data
       apparmor: refactory mount to use check_perms
       apparmor: drop use of _confined variant for iteration
       apparmor: constify aa_perms parameters that are read-only
       apparmor: constify aa_profile parameters on read-only compute paths
       apparmor: constify aa_dfa parameters on read-only compute paths
       apparmor: constify aa_label parameters on read-only query helpers
       apparmor: fix deadlock in complain-mode change_hat
       apparmor: policy_int make sure list heads are initialized before fail path

Maxime Bélair (1):
       apparmor: Initial support for compressed policies

Oleg Nesterov (1):
       apparmor: use SEND_SIG_NOINFO instead of NULL in aa_audit()

Paul Moore (1):
       apparmor: leverage audit_log_n_untrustedstring() when possible

Ryan Lee (2):
       apparmor: fix net.h and policy.h circular include pattern
       apparmor: make include headers self-contained

Tetsuo Handa (1):
       apparmor: replace decompress_zstd() prototype with its entity

  security/apparmor/Kconfig                 |  14 +-
  security/apparmor/Makefile                |   2 +-
  security/apparmor/af_inet.c               | 565 ++++++++++++++++++++++++++++++
  security/apparmor/af_unix.c               |  44 ++-
  security/apparmor/apparmorfs.c            | 281 +++++++++++----
  security/apparmor/audit.c                 |  40 ++-
  security/apparmor/capability.c            |   2 +-
  security/apparmor/domain.c                | 157 ++++++---
  security/apparmor/file.c                  |  15 +-
  security/apparmor/include/af_inet.h       |  36 ++
  security/apparmor/include/apparmor.h      |   1 +
  security/apparmor/include/apparmorfs.h    |   3 +
  security/apparmor/include/audit.h         |  10 +-
  security/apparmor/include/capability.h    |   3 +-
  security/apparmor/include/cred.h          |  22 +-
  security/apparmor/include/file.h          |   2 +-
  security/apparmor/include/label.h         |  31 +-
  security/apparmor/include/lib.h           |   6 +-
  security/apparmor/include/match.h         |  18 +-
  security/apparmor/include/net.h           |   9 +-
  security/apparmor/include/path.h          |   3 +
  security/apparmor/include/perms.h         |  19 +-
  security/apparmor/include/policy.h        |  17 +-
  security/apparmor/include/policy_unpack.h |   4 +-
  security/apparmor/include/procattr.h      |   2 +
  security/apparmor/include/task.h          |  20 +-
  security/apparmor/label.c                 |  95 +++--
  security/apparmor/lib.c                   |  57 ++-
  security/apparmor/lsm.c                   | 282 +++++++++------
  security/apparmor/match.c                 |  35 +-
  security/apparmor/mount.c                 | 279 ++++++---------
  security/apparmor/net.c                   |  47 +--
  security/apparmor/policy.c                |  30 +-
  security/apparmor/policy_compat.c         |  14 +-
  security/apparmor/policy_unpack.c         |  30 +-
  security/apparmor/task.c                  |  27 ++
  36 files changed, 1609 insertions(+), 613 deletions(-)
  create mode 100644 security/apparmor/af_inet.c
  create mode 100644 security/apparmor/include/af_inet.h


