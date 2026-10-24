Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878210;
	b=XvB+McanNCUk41c8gdOOvXtr8yHKECfwYfeDxVU4+L8LYzsQQBNytoR+km9jgfsHq5P9
	 iwr6PGRCIMSmV/F5bWTOHPwHzbQT6/mIlleyg6bciVDHrVkr55UM91BlENnv1jCc+M+LT
	 KM+C6Bfox2UdI79VBzUTUN5Eo+MpFBQDthDyxB91PimDidjhGfMCbUx28VPLi2UZPaNHe
	 dNLe763A1i/lFKVzvnoiTwQUkZzcxXWOBf1J+jQvy0dutZWmu6/O1lwg2r8gufvQ4pM/A
	 OKq0Svf7dKa+zRRWO9u5HvlFxJwt33LuV/KWEDkTcM4L/DxT0iVBMBUnEBGIz5KPZLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3UXVe85EdeFNcxpcFxDAp5kR4bnXLI0O4+ZpE8jB/ao=;
	b=nv4jb3hWKbEHF/QGKGa1H8nGduBkYEPVFUMEiN4/pa6O1xqLYiaMTYreXqZ6hhartQAG
	 l78JISz5VrO+AdwhTzCOV1bD7Ya0xgQs9z7Sqo8iAt4P9CTyeEAJDenOWE5KMEi3gRQoS
	 UelIIZRZQBrRGs54ulrYLPRZgjS3ldYMewTe2H1IBghWt7gc8ZuBdV3k+Eld6shf2R6xu
	 B9UqDnwt5ICCEuKK4sNZyQnJTAb85VgoRJ/sn5ydCo29p8sUyTHtLVnREEi2WO8rlaie8
	 UZn68VodPTteF73STGV6LyuxrnVDZe/WrAN9qcTzB3Az2qnY0JEl4ZmYf34h1EHh1rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q7nBjGrY;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE4606A31D
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 21:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66BE4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q7nBjGrY
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0f59a5fdeso15275257b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792878208; x=1793483008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UXVe85EdeFNcxpcFxDAp5kR4bnXLI0O4+ZpE8jB/ao=;
        b=q7nBjGrY9g7kt/F4pBV+TbcxWh3uw6vi0Nxk5mssyr9PIfi9EmZ5hFh3gYmXREwPWd
         qsN0PD224j77dsc6FX9Alpbr71uTHDlLWpSCKNPT2WfR0hnnT1TdzzDgysccM6zhGKz5
         dVTbCIHMGnqVsXsejSecTiGiA7WGpWwayKl5LqR4NTrFtAPTHdoz88Da0QoZuYxqOMPl
         fju5eZ3/tIUuWWFdWBPitEWHdEaglsQevXV6TookxF9uU6GYw+1ZGERp8e8nSV9O5JHT
         XrRcuSMsdcp8bF/ixaXe67qNn/x6IjqDF9UAi38eGzxCy0M8S3M6/fLloMoa/OrywNf4
         HPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792878208; x=1793483008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UXVe85EdeFNcxpcFxDAp5kR4bnXLI0O4+ZpE8jB/ao=;
        b=WzcoNu1qotZNXDSmjmfU40Cdxt4d6rl3tXy8ZtUHSZArNXbzQMUcU6VEQLymKk3iXn
         RSBrJNTdWY0IrR2+NSWPUKdnYX65zNFkQGrA1HAfF0ugj4WDJATndlwWekHy69s6ryKY
         Kz72Fw8e/eG7UsxBQcSg0Ny9VxD4NfoPi9guthXx4ZG3Xz7CaZ1cDeJmOUU7NOgEXsoY
         GQVeJaDxYw7g/0G+WdsU4l+h6/ebD/WT94byFaig1KlcB4fudaToVYzdtXhtKo6P7j2t
         7hVqvvANoXsJToHrc8cdC2hvXeDL8z0wEFDyx4AF4PxuZFjOxabmW6DI5q8YuCMZwqpB
         mrLA==
X-Forwarded-Encrypted: i=1; AKwUvBzHT8xTnw5KpZZVwP8dxL4I8LlcgTNVn5JYogEqlG43mgZBpfTLfJ709btdbWhEAoqnozUKnE28jRyAItX6lkp946RkpdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFemBzV0oMBWKKyFK92UKYNIhlDWKG6ln11Ihny8e9/m+uOL56
	NB4d6iPX7FSrlRmeveeywHTr7fRBCJ4jCsaEl00ScsjN4t331FvnZ7mp
X-Gm-Gg: AYBFou2GDbHbyIXI+FfI1GVlm21XQugo3aD4pKIydxO1wqgDeres9ByIWg/R9L/NEmA
	s81HGCfdt2v9/wzYmQklgOva85nFLsE9PZamTBn3phBr+YTr5NArd/lGSjdpkL/xRXJhNAy6WWn
	uXoIdrCtMjcmC5ZlilAQ97Q+cvDm4jcsjdSLZjUivu4C+62HsEoVDaiOWOGfeXwc8ggCyWmqkCO
	jkHmiLwVhprcNG+3yXuOFWoinfuDJ60ZDdAC/qOfB7I5JeFZX2FlYZYAwxsXN818XiXBbBDzrX5
	8LwGQcMYrpt+ntC/oPD7H1ZpWmoIY1+npm3BnAYK5VTl0NYV6yh6Bq2Xo6oHRlxqqaOY64cIBNC
	EyxTxigcWloA2NbDg52SmETZapF/0yIKdnNPGlpH8AEpnLM6q+cRo1jQIpjs5zPBIzoVCoLJsf7
	xxQGZITxn2jSO09ElFz+gRznuuSWfqtwc1yyNsj+to0egmQbVGOtG8XYFvWOHxiM49p4jYb7m1+
	XWw92mXLERm5m8v60L3F5lQ3pACo3fzUBI/PVppx5j08jZy1n0tF62SkRagUtflUJG7IqKe7XrA
	Q9o=
X-Received: by 2002:a05:690c:fd5:b0:8b0:a8cf:f46a with SMTP id 00721157ae682-8b166cd9439mr22677767b3.69.1792878208273;
        Sat, 24 Oct 2026 14:43:28 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f15a:4eed:c4ba:3585])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166dcf529sm13199467b3.12.2026.10.24.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:43:27 -0700 (PDT)
Date: Sat, 24 Oct 2026 17:43:26 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	John Ericson <mail@johnericson.me>, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] landlock: Add access rights on created files
Message-ID: <at0agiPbtxz5zD41@zenbox>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
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
In-Reply-To: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>

On Sat, Oct 24, 2026 at 01:39:16PM -0700, Farid Zakaria wrote:
> This is a proposal for an idea to add support for landlock to work
> better with build systems such as Nix where they want to apply
> restrictions but the paths may not yet exist.
> 
> TL;DR;
> ========
> 
> Landlock rules attach to inodes that exist when a ruleset is built.
> That makes a directory shared between trusted and sandboxed tasks hard
> to confine: the sandbox may create entries there with
> LANDLOCK_ACCESS_FS_MAKE_*, but no rule can name those entries ahead of
> time, and granting read access on the directory to cover them exposes
> every other entry as well. This series adds a rule flag that grants
> access rights on the entries a domain creates in a directory, instead
> of on the directory.
Hi,

I'll chime in since I run nix and have a little bit of familiarity.

Looking at my (admittedly bloated) nix store.

[justin@zenbox ~]$ ls /nix/store | wc -l
259356

That's a lot of inodes. And a nix derivation creates hundreds if not
thousands potentially throughout it's build.

My main concern is that rulesets are generally considered
immutable after enforcement. This allows for well-defined semantics on
inheritence. This from my understanding would mutate the ruleset after
it's already enforced, so changes wouldn't be copied to inherited
domains automatically.

My other concern is with the overhead of automatically generating an inserting
a rule for every new inode that gets created. It seems like a complex
way to tackle this problem.

But beyond that, let's go back to your usecase.

....

Basically from what I'm seeing you want to grant some access to certain
subdirectories (including newly created ones) but exclude others.

Presumably in the nix case, you want to grant /nix/store/{abc,efg,hij} and NOT
/nix/store/{xyz}, but still allow /nix/store/{foo} (the derivation
output) to be created and written to. This would allow the nix build to only
have access to certain inputs, while being able to write to the /nix/store
and produce an output. This is a valid usecase that Landlock cannot today
accomplish.

There was this NO_INHERIT series I proposed a little while back.
[1] It's sort of the inverse of this (removes accesses inherited from
parents rather than granting new access) but would accomplish this
goal.

With NO_INHERIT, you could grant whatever access rights you want by default on
the parent directory, and place NO_INHERIT on any specific entries you
don't want to have inherit those rights. 

So for nix use case, you could grant no_inherit on everything except the
inputs you need, then add READ/WRITE/MKDIR etc on /nix/store. The new
directories would inherit this by default, while the ones you added
NO_INHERIT on would be restricted.

Additionally, you should also examine the mutable domains proposal by
Tingmao Wang, which could also facilitate this usecase as well [2] (i.e by
dynamically adding and removing rules with some fanotify/inotify glue).

That being said, neither of these two patchsets / proposals are merged,
and the playing field is still open on this.

So the problem you are pointing to is legitamate, but the solution still
needs to be considered carefully to avoid complexity.

Justin

[1] https://lore.kernel.org/linux-security-module/20260621035223.2651547-1-utilityemal77@gmail.com/
[2] https://lore.kernel.org/linux-security-module/cover.1741047969.git.m@maowtm.org/
> Motivation
> ==========
> 
> The motivating user is the Nix build sandbox. Every Nix build runs in
> its own sandbox, and a build may only read its declared inputs in
> /nix/store and must be able to write and read back the outputs it
> creates there. Nix enforces this with a private mount namespace: it
> creates an empty store directory and bind-mounts each input path into
> it, one mount per input. Nix has paid this per-input cost since the
> sandbox was introduced [1].
>
> The cost is paid per build and grows with the size of the input
> closure. Nix is moving towards much finer-grained builds (many small
> derivations instead of a few large ones), so the number of sandboxes
> grows while each build's own work shrinks, and the sandbox setup is
> becoming the bottleneck. A typical build has hundreds of inputs; large
> ones have thousands.
> 
> A microbenchmark sets up and tears down a Nix-like sandbox (user,
> mount, PID, IPC, UTS and network namespaces, pivot_root into a chroot,
> removing the chroot afterwards). It compares one bind mount per input
> with a single bind mount of the whole store plus one Landlock rule per
> input. Median latency per sandbox, one sandbox at a time, Linux 7.1,
> ext4, 16 cores:
> 
>   inputs   bind mount per input   one bind mount + Landlock   speedup
>       10         3.2 ms                    2.3 ms               1.4x
>      100        11.6 ms                    2.8 ms               4.1x
>     1000        79.3 ms                    6.4 ms              12.4x
>     5000       400.1 ms                   24.4 ms              16.4x
> 
> With Landlock, an input costs an O_PATH open and a landlock_add_rule()
> call: there is a single mount, and no mountpoint directory to create
> before the build and remove after it (removing the 1000 empty
> mountpoints alone took 17 ms).
> 
> The single bind mount is only sound if the store listing and the
> undeclared store paths stay unreadable while the build can still use
> its outputs. Without this series, covering the outputs requires a rule
> on /nix/store itself, which makes every store path readable again.
> 
> [1] https://github.com/NixOS/nix/issues/179
> 
> Series
> ======
> 
> Patch 1 lets an LSM observe inode creation through the
> inode_init_security hook when no LSM provides an xattr. Patch 2 adds
> the LANDLOCK_ADD_RULE_CREATED flag for path-beneath rules and bumps the
> ABI to 13. Patch 3 adds selftests.
> 
> Testing
> =======
> 
> The series applies to the Landlock next branch (3e271a27c46f) and was
> tested on Linux 7.3 with that branch applied.
> 
> Without patch 2, the five new tests and the ABI version check fail.
> 
> Open questions
> ==============
> 
> - A created inode stays pinned until the layer's hierarchy is freed, so a
>   sandbox that creates many entries in such a directory keeps them all in
>   memory. Should this be bounded?
> 
> - Creation is detected in inode_init_security, so on filesystems that do
>   not call security_inode_init_security() created entries get no rights.
>   Is there a better hook?
> 
> - Through overlayfs, created entries get no rights either, because the
>   upper inode is created with the mounter's credentials. Should overlayfs
>   be handled, e.g. via security_dentry_create_files_as()?
> 
> - A file renamed or linked in keeps only the rights it had at its source.
>   Should it get none instead?
> 
> ---
> Farid Zakaria (3):
>       lsm: Call inode_init_security hooks without xattrs
>       landlock: Add access rights on created files
>       selftests/landlock: Test LANDLOCK_ADD_RULE_CREATED
> 
>  Documentation/userspace-api/landlock.rst     |  42 +++++
>  include/uapi/linux/landlock.h                |  18 +++
>  security/landlock/domain.c                   | 182 ++++++++++++++++++++-
>  security/landlock/domain.h                   |  28 ++++
>  security/landlock/fs.c                       | 176 +++++++++++++++++++--
>  security/landlock/object.h                   |   6 +
>  security/landlock/ruleset.c                  |   6 +
>  security/landlock/ruleset.h                  |  14 ++
>  security/landlock/syscalls.c                 |  20 ++-
>  security/security.c                          |   9 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   | 227 +++++++++++++++++++++++++++
>  12 files changed, 703 insertions(+), 27 deletions(-)
> ---
> base-commit: 3e271a27c46fd591d1011c7de5a644a41e2010f1
> change-id: 20261024-landlock-created-rights-9340b00a8c4d
> 
> Best regards,
> --  
> Farid Zakaria <farid.m.zakaria@gmail.com>
> 
> 
