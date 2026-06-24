Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D15388E5A
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287550; cv=none; b=IV2fDy58pG6O9OTSNtrIsQRs7WVmZpSHBsRqCxXty98LrUUtuupgllkftGwt0WVC+ARyT7xYVwM3JlbAk9vKL8dCPmiGDV/N8Cqms9HftaClbAY23b6Ugak98foelroutor6AmoY6jKW9H6CI1lQUE/vVnkIicK5lKS9Uct7r58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287550; c=relaxed/simple;
	bh=BNHbIhI8fYlY3Gz/ljttwoab9P6cOHHKthP5tZ7A4Qk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=YILwzbTiQW6UYLhNHVpFhQrMXd6iRRI/fPkRqz0zxvaWwqONXHREG+IFmfdREK+NpsmcWUrJEBuBGrIoUEM5bUi+vrPL/VWnyZGTl9HFltWE+E78oLPIwIguP4nrgV1XeDLAV8yLmYySC8s2Dtjg8eqNvA9OR8G0uy9+xgvjmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=huvVevHj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="huvVevHj"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A32EF3F7BD
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782287540;
	bh=zyuDThvFKNA9hKZ6doSi/S2ledcLIeUnidYZypZ8L6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=huvVevHjaaYDXX1KsksMN+aaDH38fmT/GMgusjAkokzP0qyWDUQxSwpa7h7bA+U4h
	 BQ3LqHgsMupSdbpjfk+Ivo2ObUohWb52Zmk9BZ1qikHaC6LzGboP+FtJ2rrgPLavhb
	 ZgyQGCDuDZr792U/hRDoUyzzfeslE89bFw8dftBX4pqoemzpVnIGrfZLW+DISsJiyS
	 7EvjIzmElXKgwU3jZt5KjkF6DguCHgIjNuuoBvijpSKTS3NIMxHM9rEetd3EKjVv34
	 LBmSp2P6Y9FnBRh0rrJFlgpANetE+PyVop8vPvz3G9RwPq9gzbV4cs7e9BxX7ET1IG
	 A3vAjn6pd58GKqJc+Doj5c0XZVc+xFgjtBuQfZuclLOIYfGXp+3rh+RGvmFmNgrZi6
	 f1k1R+w3WOkEeU1hDx/nqNEV4M0Vv1qGNVirG4lMm+VZN7uMRZM8s9/qBH3NcYsC8N
	 Y++REVgok1eAqtZdgTUtyTCJoRDQWJteDuuCFcKuYj2P/RG0JHr+baeFzzW7nvd0kI
	 scTqXM7Na/lY9wziaAUQ+9YeYPurpgq5O+VtAPus8fYz5jTWjEDCWY0Br1HzwjDbAM
	 kHdmSkidbnH5p7LKgP4NZLaRpTfSNi82CQSdcAudBh0pTC47RMireqYt5o2YyFHf/P
	 HHOd0z3N/0jFpFnULURog7hI=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-842446a3851so574584b3a.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 00:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287539; x=1782892339;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyuDThvFKNA9hKZ6doSi/S2ledcLIeUnidYZypZ8L6g=;
        b=nOAEFhYIQcLUKkAw7Iuge7hhWeVQ0neM0125MchGdlUvylhWSU9XGDECV8RyB/h5Wl
         6HAXSBved9pvIxpnTXMS+Jspft5RvxXpUOxaH1/3aCh/ATHqwArVA1YsqAYuH53MAdxr
         EBNdEunKIRc+FH+TcFebKKk+4gF2tYB8hOm98hJ+EK4IxRffIY4r0Og68jfTUx75/NEL
         FH5xR8eAJhPBU7rZWlILjxlyVLuCmHK8+BHKy9+90Wvz6R2oyhsxXfr3vPRYH42GDbk7
         Ni8/eaSwd9xe2YHPZ/NbEnFAyPjn6z6tZwakVvRRxKYMolkDuCBTyRJHMBlv542dESv+
         U5NQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2QOfyaQJJc73KTa8e1wNZNAZ5Y7c6Ja+GP/7ZIjFjzNsji8apXAANVUCKiX2IO+lwvfwHSOTinF09FOxPe9anHkZEz68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyCMOLL9MecmEQDMpSRvJZCtpPArG5QXrtys036A9/q9DIPlD
	lVZzc6zSSQ0h3W9KVX4wCNYqq/k+o6wa9TpiS8R3plHP8v5WVkdOTyqSwB+bExmwyJ8/0lte7lW
	bUq2rwfmszJCBo9fd8cQ+Ko5JdaELU9i2MOeWk1rO3GMeg0z9ITAVWUWY+Qu7CdTwACrwvGzw1q
	71zVZgP2Ly7H5Os+nOsg==
X-Gm-Gg: AfdE7cnxMJKymGGppUexBLuvJBgs3WopsXqitNFwaWFblgzyVg8eSSo7AsQg+G+VwWn
	02zMJQ1h95ExENMPo3HoJ89ABGEy4sefJ4tFC2CQkf4e9/LQ74ZsNAFrMiOf7U3ZgcnOWpp2c3C
	3BekjOLHh/2owGO6ylhi877i1s68ljXwQPxz2v8iOmHARLm7sppkaVonfF2fulWyBQIf6h4PoUb
	Kd2y+NmeRILJKPDbAX//fwTMeIy1a00M8oFbJXwNFtdToIMVmeJ6g5zaSgd3PI5MaJWWAXRyU2G
	Y3ehdif+nBU02UmXm519/7e/PcAag3AMgfDu96wTuqW4II9zN8fT/3WTKhAzB8Qygd7VXw0uGKa
	OKslAiykzaWqImTAszTwNrhYScw==
X-Received: by 2002:a05:6a00:4105:b0:842:74e3:48a9 with SMTP id d2e1a72fcca58-845a26f7998mr3045736b3a.12.1782287539189;
        Wed, 24 Jun 2026 00:52:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:4105:b0:842:74e3:48a9 with SMTP id d2e1a72fcca58-845a26f7998mr3045710b3a.12.1782287538784;
        Wed, 24 Jun 2026 00:52:18 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-845a41474cfsm1361545b3a.61.2026.06.24.00.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:52:17 -0700 (PDT)
Message-ID: <bdb6dcf3-a0c0-45ee-be64-d135c973ec90@canonical.com>
Date: Wed, 24 Jun 2026 00:52:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 Georgia Garcia <georgia.garcia@canonical.com>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

This is another round of bug fixing and some code cleanups, there are no
new features. I ended up pulling in a few bug fixes late, and gave them
some extra time to bake.

The biggest thing to note is Georgia is being added to help co-maintain
apparmor.

Everything has been merge, build, and regression tested against your tree
for Monday June 22.


thanks
- john



The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-06-22

for you to fetch changes up to 2f6701a5ce6257ae7a64ddc6d89d0a08d2a034f8:

   apparmor: advertise the tcp fast open fix is applied (2026-06-23 22:15:15 -0700)

----------------------------------------------------------------
* add Georgia Garcia as co-maintainer of apparmor

* Cleanups
   - replace get_zeroed_page() with kzalloc()
   - remove unnecessary goto and associated label
   - change fn_label_build() to return err on failure instead of NULL or err
   - free rawdata as soon as possible
   - use explicit instead of implicit flex array in rawdata_f_data
   - use __label_make_stale in __aa_proxy_redirect
   - return correct error by propagate -ENOMEM correctly in unpack_table
   - aa_label_alloc use aa_label_free on alloc failure
   - add a conditional version of get_newest_label

* Bug Fixes
   - mediate the implicit connect of TCP fast open sendmsg
   - fix C23ism of label immediately before a declaration
   - fix kernel-doc warnings
   - fix spelling mistakes
   - fix use-after-free in rawdata dedup loop
   - Fix inverted comparison in cache_hold_inc()
   - fix uninitialized pointer passed to audit_log_untrustedstring()
   - don't audit files pointing to aa_null.dentry
   - put secmark label after secid lookup
   - fix aa_getprocattr free procattr leak on format failure
   - release exe file resources on path failure
   - fail policy unpack on accept2 allocation failure
   - Fix return in ns_mkdir_op
   - remove or add symlinks to rawdata according to export_binary
   - fix NULL pointer dereference in unpack_pdb
   - fix potential UAF in aa_replace_profiles
   - grab ns lock and refresh when looking up changehat child profiles
   - enable differential encoding
   - check label build before no_new_privs test
   - conditionally compile get_loaddata_common_ref()
   - fix unix socket mediation cache update, and leak

----------------------------------------------------------------
Andrew Morton (1):
       security/apparmor/apparmorfs.c: conditionally compile get_loaddata_common_ref()

Bryam Vargas (1):
       apparmor: mediate the implicit connect of TCP fast open sendmsg

Eduardo Vasconcelos (1):
       apparmor: Fix inverted comparison in cache_hold_inc()

Georgia Garcia (3):
       apparmor: fix NULL pointer dereference in unpack_pdb
       apparmor: remove or add symlinks to rawdata according to export_binary
       apparmor: don't audit files pointing to aa_null.dentry

Hongling Zeng (1):
       apparmor: Fix return in ns_mkdir_op

John Johansen (13):
       apparmor: add Georgia Garcia as co-maintainer of apparmor
       apparmor: fix shadowing of plabel that prevents cache from being updated
       apparmor: fix race in unix socket mediation when peer_path is used
       apparmor: fix refcount leak when updating the sk_ctx
       apparmor: add a conditional version of get_newest_label
       apparmor: enable differential encoding
       apparmor: fix rawdata_f_data implicit flex array
       apparmor: free rawdata as soon as possible
       apparmor: change fn_label_build() call to not return NULL
       apparmor: make fn_label_build() capable of handling not supported
       apparmor: remove unnecessary goto and associated label
       apparmor: fix label can not be immediately before a declaration
       apparmor: advertise the tcp fast open fix is applied

Maciek Borzecki (1):
       apparmor: fix uninitialised pointer passed to audit_log_untrustedstring()

Maxime Bélair (2):
       apparmor: propagate -ENOMEM correctly in unpack_table
       apparmor: fix potential UAF in aa_replace_profiles

Mike Rapoport (Microsoft) (1):
       apparmor: replace get_zeroed_page() with kzalloc()

Qingshuang Fu (1):
       security: apparmor: fix two spelling mistakes

Rodrigo Zaiden (1):
       apparmor: fix kernel-doc warnings

Ruoyu Wang (1):
       apparmor: check label build before no_new_privs test

Ruslan Valiyev (1):
       apparmor: fix use-after-free in rawdata dedup loop

Ryan Lee (2):
       apparmor: use __label_make_stale in __aa_proxy_redirect
       apparmor: grab ns lock and refresh when looking up changehat child profiles

Zygmunt Krynicki (5):
       apparmor: aa_label_alloc use aa_label_free on alloc failure
       apparmor: fail policy unpack on accept2 allocation failure
       apparmor: release exe file resources on path failure
       apparmor: aa_getprocattr free procattr leak on format failure
       apparmor: put secmark label after secid lookup

  MAINTAINERS                               |   1 +
  security/apparmor/af_unix.c               |  73 +++++++++---------
  security/apparmor/apparmorfs.c            | 119 ++++++++++++++++++++++--------
  security/apparmor/domain.c                |  97 ++++++++++++++++--------
  security/apparmor/file.c                  |  12 +--
  security/apparmor/include/apparmorfs.h    |  12 +++
  security/apparmor/include/label.h         |  32 ++++++++
  security/apparmor/include/lib.h           |  21 +++---
  security/apparmor/include/policy_unpack.h |  21 +++++-
  security/apparmor/label.c                 |  26 +++----
  security/apparmor/lsm.c                   |  20 ++++-
  security/apparmor/match.c                 |  22 +++---
  security/apparmor/mount.c                 |  17 ++---
  security/apparmor/net.c                   |   3 +
  security/apparmor/policy.c                |  35 ++++++++-
  security/apparmor/policy_unpack.c         |   6 +-
  security/apparmor/procattr.c              |   2 +
  security/apparmor/task.c                  |   2 +-
  18 files changed, 368 insertions(+), 153 deletions(-)


