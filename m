Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362188;
	b=GRSjUabBhRctYGQUlye8SrPNxwn26Ex0/lAlnemFzyNYebGDnA+W2RwxWCRM3qcsmcTS
	 RpSZM1egVq/EUDIse0gBuNwqf5KbAtqVRCtAFLys+sxTDEaCcNoVWctA9WAzGRDDxDSU6
	 ps8F5qQTAwjxTa7tbT3Hv7/Iu40XuuMKDTG55JLRTxCj9sEY6FqdoorD700XEQtrdGC2N
	 TPVi4ajMk9rQMf9vvHDxP6+u2dSP5u+slChpenIMg3cd1s4UeCQb5ulslMam/d+x3QuxH
	 lHu6Pt6evlfJW1EL3Yk+dEIY0tLeqQiiuMGs5V2LamnWZWHMk64RpPi8+0rg1VWWrgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362188;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Infomaniak-Routing;
	bh=CHiOHhGM8wF8lZDketcUzQJ4hUyzLdW+kg23E8g6Q8Y=;
	b=i2ROPCSYEGggblB1MwcGjHyxvBezUJVT9kGTV7zx42tk1coZ/IJ/Owuq5Eq0sUp6kMpX
	 WU34xyjcQgu+DcsxVtAD78gUpXkICSnMRia5iytLA86Atv56KzQlCCM43yo4iweb7H2h1
	 VdXSRU0LSYoeHRhob7i01p6zAlWl6n9Y/Mnos516+XSSc18hfBopFpCMtx4vfkk9nUlZ5
	 Qpuv8L8zfbg4iWj9blw0HsvEM1o11KcYENMoJSU+oNlWXvqPsQwnO8WJXzr9Glh1UTL/I
	 bg/cCctIRDngxqQpMQkkcQNgX5gtqPtfpbGlGr1EDQjzINV9KyYDw5ow0Z8/WMck0bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=hK77lSuE;
	arc=none smtp.remote-ip=83.166.143.173
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCE606A31D
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 12:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DCE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=hK77lSuE
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGKfB3PMCz2kVC;
	Fri, 30 Oct 2026 13:09:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1793362178;
	bh=CHiOHhGM8wF8lZDketcUzQJ4hUyzLdW+kg23E8g6Q8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hK77lSuE5wzFwhCRobE9qXWskjQ3zxNRilzRvFrQtPauZ2z/+6poqRZVQebnFDiJ/
	 1wzkAGB0/h2FUJeLSQC2e4E48yWXjrgs+Cy+sAJZc51JcSXjfYYSs/oDCVT/jY0PwE
	 UhjntZlEcLXvsUm91zESPOyaZLrU9HbrzVtBdLNo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jGKf62QN9zdbQ;
	Fri, 30 Oct 2026 13:09:34 +0100 (CET)
Date: Fri, 30 Oct 2026 13:09:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	John Ericson <mail@johnericson.me>, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] landlock: Add access rights on created files
Message-ID: <20261030.ohkopheePh2a@digikod.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
X-Infomaniak-Routing: alpha

Hi Farid,

Thanks for this RFC.  The Nix build sandbox is definitely a valid use
case for Landlock.

I didn't have time to do a full review of your patches yet, but I'll do
that next week.  In the meantime, I have a few questions:


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
> 
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

Did you do this benchmark with this series?  Do you have the related
code to easily reproduce it?

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

I'm wondering if the Nix build sandbox can create the store dir per
build before the actual build.  Isn't already the case with the bind
mount?

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

Only the sandbox creator should pay for the related kernel memory
allocations, and this should be at creation time.

Another property that would be nice is that if a sandboxed process can
create a file, the related policy should also make it possible to delete
this file.  Is that the case with the current approach?  We need to
think not only about the lifetime of the sandbox, but about consecutive
creations of such sandboxes by/for the same program.

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
