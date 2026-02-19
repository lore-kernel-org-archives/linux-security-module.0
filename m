Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDB3EBF3E
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460390; cv=none; b=Bo1u3wqi3o7wKP9k5bRJkHq8fDSbySKV0Yt/kdpQmpatfgMdEB5UiQYmKkOB2QCA2HD8q8MGTsYkPb7QhbZvxBrgPNDMJfUAebfbUTosTMaBEx3u+MLTy2lfN9YF4PHiXBwTLJR0itAvul+nF8WDD/MkMnXYrLNsDwuv6j7h/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460390; c=relaxed/simple;
	bh=IAOX0jWZ82ui0q5Uvj8RK8BgfOdKBVkn8I2EU4xOy1Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nHUNH76ryOqfCkkFycWK2+fYjwMCXoAlODUHt9CWwHAqB5rtvcufx3YSaDlgSMaZnFFGr2N3o2Tsj4uxF/BGc+IcOaMyNT9UPNmNgwfRjf1bCvkYqVwYi3Lqx41oTEZZIetzfi9bEq8zW/yRM0P/gbNYpIqZ11XQM90g3S8612c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=WgCFBElN; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="WgCFBElN"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93BA03F201
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 00:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1771460378;
	bh=fDcnLOj5MRChFFcJ0EDGI1T1wH0m1QXlXfukfSer5dM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=WgCFBElNOuooXEn9mYXhnwJgeqrGnDxJKWdp6mXT34FCmMSnoFiylpryLKQ0A+Uj4
	 cX3Gsu4isoZOqAKqxNx2otnhzVoO29K7xles20t4cugtxq3E9u4GuVnwegVabjxDDn
	 HS8vu3dbdKU25SeSAI2fh+JVUtfZbiR7bS9W+QHxGNldxbQy86EOR7g48+5EvuFv+n
	 dLZNUs7HG8lR0Jb5Ue8nH4ifMj3FZObNawl1E/IZ5sOriitLNTEt336Q256ayfPcAC
	 VPLmLSbukwFpUGkrOlZL2sBqAAqD2hUPO1JbgQT0m3IcDHLfe1lajmn+1ZIChdcpTA
	 Jik/fVhnw0Yvvk6hFFnyMR/mlalVahcVUgTmyQW+ICBJd8uMp68X1SSxgjPxkS0ROR
	 +OMJ9/naJkVstAZ/o/5JoIN2M0vjQfOAV6gwsTAHvaoBJGxPaeQ9ZF8JZaOTC2NbZb
	 FGcBcOCW7y5bucD9HWqmYCfwPsiyR0Ob0wAu4xgvj12eUNqyWuBkoIPnHnCxuy1wZL
	 0zIqMh3obQLViZCs2yjM5f5avbTrjgYPOnOsJF9jUqxMVszRvn5RrGMJvpR1l7YCkW
	 aSF4hrqTXg5UTsnZ7Q1CWqQknA9KmxJBh2aI5ZKgh0kOP08wZ8WsewVqZfXDH3TZOY
	 cY8ZjLGiIxOvGzdyacdZO0KQ=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3586e7cf42aso1390527a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 16:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771460377; x=1772065177;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDcnLOj5MRChFFcJ0EDGI1T1wH0m1QXlXfukfSer5dM=;
        b=NI3Ap4UqibYJIqgbXuEVDVcsaI9Km65YYNCcOXnrVwf6vkqa4jAVQ3/Awr5zGtfDaz
         ArCaW0mJj/qq3HOkttIaU/w7Ths0pqrL3mQrwM8+DoSEBMOyXTZ05Kve3bh3pW5OPljB
         PvZrVS3FTyFgAC2ZtUuCLYErMZ+OxSiPyc+LswJb2U7zzgc4rpuIT0N98hdYSWsBtg2S
         1Qg/chocbTs6bxitM97pXsLFcNpKYnSmayD/8vHIyUo9MnaqHI7gxCI+84GTAfDxf3IN
         tAGrymnzaw7pGSqhkE1y0O40IBa0OFNO3UzqbFZXqAS0UTzPrJ++tKiTD3KY4hjHaQIi
         Xhiw==
X-Forwarded-Encrypted: i=1; AJvYcCUt2ibnpWMpRQCVjauduSNGfivvcftJMPghF0svgj146QbQ8j6MT9oqQ04l3/Ekj1DVaxf44jmCyeEImblFlwTSrtT91FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFwNj2LqFX4KB+M8H6StOnnIezT1yYpQ4g8y5kmVCP5BZSH4I
	DdjgnaIpvdZnYY6+WQ8+9qrd4wwzeCQ5QWkfrxqurjJMNw6jcaER5iiX75BBeHsX5N3d6PwwVN3
	Z7ykrSpBPhsjRfZ9zY1HuhSdeqa/ODyaczr/W8gHrMO/cwVmRZCDmSgCf/LdkEm+HgU53CXP6rR
	GNKO4v3Q/QENt3Y+4Zww==
X-Gm-Gg: AZuq6aKfaBs1pW92+NHlINRdRbyDCjA/5Tj9E0ejXcDHcBxpVY77c6QIn9wl4i5Rhri
	GBkWGrZWFZ6eMg5GWuf3gWMy2HdlRNBzt/21lo629Nl4HBYXA1STJtZFISkn7oZ4r+puHLbZYvc
	EXrQ/PUnvqeJaUhQkEaTaw7VvjNAUtj4mLz41x+wBgV8Y0U7j8EVENy2h5zdzToVtUlwmLi0ESh
	tiwwT3lXfEIpFze88+5Tzyc6zH/hUNBpgvt+iYwqV3SZHmvTSqLQfFH2MtjtC0PL04DUmDX/G3a
	Syg1Axs35niLHI2VrLQSpWaUPwpjGOSQkwtE/sNkHtXK9WIBdpSRSe/SDzJqSb9rJg6wYYJDUCp
	DREKAa8WiFDR+ibHeuBefGP6bnKwoLCTU+r4q
X-Received: by 2002:a17:90b:1b41:b0:356:41c2:896f with SMTP id 98e67ed59e1d1-3584481ab30mr14734931a91.7.1771460376799;
        Wed, 18 Feb 2026 16:19:36 -0800 (PST)
X-Received: by 2002:a17:90b:1b41:b0:356:41c2:896f with SMTP id 98e67ed59e1d1-3584481ab30mr14734917a91.7.1771460376348;
        Wed, 18 Feb 2026 16:19:36 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-35896ebfbd4sm137495a91.1.2026.02.18.16.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 16:19:34 -0800 (PST)
Message-ID: <53c39cf4-d9e4-4ccf-ae16-dc5b143c9681@canonical.com>
Date: Wed, 18 Feb 2026 16:19:34 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Below is the AppArmor update PR for 7.0

These patches have all been merge, build, and regression tested
against your tree as of yesterday. The code has been in linux-next
and the many of the patches in the Ubuntu kernels for testing.

This PR is mostly comprised of cleanups, and bug fixes, with 3 minor
features, the first being an improvement to our kunit testing, and
the other two extending the information available in audit messages.

Because this is coming so late in the window (sorry life happens),
if you would prefer I have prepared an alternate PR that contains
the set of bug fixes that apply without the features, or cleanups,
available via the tag bugfix-2026-02-18, which I can send a PR for
instead.


thanks
- john


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-02-18

for you to fetch changes up to 08020dbe3125e936429e7966bf072e08fa964f36:

   apparmor: fix signedness bug in unpack_tags() (2026-02-18 11:50:20 -0800)

----------------------------------------------------------------
+ Features
   - add .kunitconfig
   - audit execpath in userns mediation
   - add support loading per permission tagging

+ Cleanups
   - cleanup remove unused percpu critical sections in buffer management
   - document the buffer hold, add an overflow guard
   - split xxx_in_ns into its two separate semantic use cases
   - remove apply_modes_to_perms from label_match
   - refactor/cleanup cred helper fns.
   - guard against free attachment/data routines being called with a NULL
   - drop in_atomic flag in common_mmap, and common_file_perm, and cleanup
   - make str table more generic and be able to have multiple entries
   - Replace deprecated strcpy with memcpy in gen_symlink_name
   - Replace deprecated strcpy in d_namespace_path
   - Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init
   - replace sprintf with snprintf in aa_new_learning_profile

+ Bug Fixes
   - fix cast in format string DEBUG statement
   - fix make aa_labelmatch return consistent
   - fix fmt string type error in process_strs_entry
   - fix kernel-doc comments for inview
   - fix invalid deref of rawdata when export_binary is unset
   - avoid per-cpu hold underflow in aa_get_buffer
   - fix fast path cache check for unix sockets
   - fix rlimit for posix cpu timers
   - fix label and profile debug macros
   - move check for aa_null file to cover all cases
   - return -ENOMEM in unpack_perms_table upon alloc failure
   - fix boolean argument in apparmor_mmap_file
   - Fix & Optimize table creation from possibly unaligned memory
   - Allow apparmor to handle unaligned dfa tables
   - fix NULL deref in aa_sock_file_perm
   - fix NULL pointer dereference in __unix_needs_revalidation
   - fix signedness bug in unpack_tags()

----------------------------------------------------------------
Georgia Garcia (1):
       apparmor: fix invalid deref of rawdata when export_binary is unset

Helge Deller (2):
       AppArmor: Allow apparmor to handle unaligned dfa tables
       apparmor: Fix & Optimize table creation from possibly unaligned memory

John Johansen (19):
       apparmor: fix NULL sock in aa_sock_file_perm
       apparmor: make str table more generic and be able to have multiple entries
       apparmor: add support loading per permission tagging
       apparmor: drop in_atomic flag in common_mmap, and common_file_perm
       apparmor: guard against free routines being called with a NULL
       apparmor: move check for aa_null file to cover all cases
       apparmor: fix label and profile debug macros
       apparmor: refactor/cleanup cred helper fns.
       apparmor: fix rlimit for posix cpu timers
       apparmor: fix fast path cache check for unix sockets
       apparmor: remove apply_modes_to_perms from label_match
       apparmor: make label_match return a consistent value
       apparmor: split xxx_in_ns into its two separate semantic use cases
       apparmor: document the buffer hold, add an overflow guard
       apparmor: cleanup remove unused percpu critical sections in buffer management
       apparmor: fix kernel-doc comments for inview
       apparmor: fix fmt string type error in process_strs_entry
       apparmor: fix aa_label to return state from compount and component match
       apparmor: fix cast in format string DEBUG statement

Massimiliano Pellizzer (1):
       apparmor: fix signedness bug in unpack_tags()

Maxime Bélair (1):
       apparmor: userns: Add support for execpath in userns

Ryan Lee (3):
       apparmor: fix boolean argument in apparmor_mmap_file
       apparmor: account for in_atomic removal in common_file_perm
       apparmor: return -ENOMEM in unpack_perms_table upon alloc failure

Ryota Sakamoto (1):
       apparmor: add .kunitconfig

System Administrator (1):
       apparmor: fix NULL pointer dereference in __unix_needs_revalidation

Thorsten Blum (4):
       apparmor: replace sprintf with snprintf in aa_new_learning_profile
       apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init
       apparmor: Replace deprecated strcpy in d_namespace_path
       apparmor: Replace deprecated strcpy with memcpy in gen_symlink_name

Zhengmian Hu (1):
       apparmor: avoid per-cpu hold underflow in aa_get_buffer

  security/apparmor/.kunitconfig     |   5 +
  security/apparmor/af_unix.c        |   2 +-
  security/apparmor/apparmorfs.c     |  23 ++-
  security/apparmor/domain.c         |  60 +++----
  security/apparmor/file.c           |  49 ++++--
  security/apparmor/include/audit.h  |   2 +
  security/apparmor/include/cred.h   | 100 +++++++----
  security/apparmor/include/lib.h    |  37 +++-
  security/apparmor/include/match.h  |  12 +-
  security/apparmor/include/policy.h |  32 +++-
  security/apparmor/label.c          |  55 +++---
  security/apparmor/lib.c            |  29 ++--
  security/apparmor/lsm.c            |  66 +++++---
  security/apparmor/match.c          |  22 +--
  security/apparmor/net.c            |   6 +-
  security/apparmor/path.c           |  13 +-
  security/apparmor/policy.c         |  31 +++-
  security/apparmor/policy_compat.c  |  10 +-
  security/apparmor/policy_unpack.c  | 336 ++++++++++++++++++++++++++++++++-----
  security/apparmor/resource.c       |   5 +
  security/apparmor/task.c           |  32 ++++
  21 files changed, 687 insertions(+), 240 deletions(-)
  create mode 100644 security/apparmor/.kunitconfig

