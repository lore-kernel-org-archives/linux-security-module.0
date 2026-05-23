Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521993126B2;
	Sat, 23 May 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554059; cv=none; b=jTBlpvvg2hTkSuh8LmY7BsisZpYNyVAsMldULI6VpP4MZKIkQU8Q4ntL2i18HmW72DEbnIlHaJIwyf/l+QXArL0PB6vkxZ5lCjd4R/x5WP42gX4c57h9mhUAz+MmSGFK+qZT+kQyfezj6tLc1QHcAf/jEk/mBEtSKTj9tBJgImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554059; c=relaxed/simple;
	bh=zJpbRK+spR4AAepQhqktXQDLIFedy2vf9XrINIAkSX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9qKRuc0hiaImdkTpcZdIbzPz0L62wdszKTrG025jSR9eoQwNJERqBLi2uZzNECIfbjgkPxrrP8DoOioltwOnxbTNytY5qqlWTGRDPT1W6aLcX+Hoyl0ooAnYV1/Pjj6piYa3dXVpjnJjONDWrOnSx9c5Hfuj/VZfBVHDrotEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cEcDhSjY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cEcDhSjY"
Received: from narnia (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD73320B7167;
	Sat, 23 May 2026 09:34:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD73320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779554044;
	bh=U4leAVB7OtKdXWVp1V9CzgIsDrw3fxQD0ULtWz2UQ00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cEcDhSjYggO8CBqPMuCObRwjTlatvmih1t4UWRBmguW4+AL9ISmBUn2SfNRhzqY4b
	 g/15/2YxJZnInGSPOoPuGbxih5U2f2OgpGuHrMAOA154278Tke15meP3D9H3dGfqdn
	 tm24oCVXtuvQgHw4oeOEjwbt7G1GZjC+LBOLsif4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 James.Bottomley@HansenPartnership.com, paul@paul-moore.com
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
Date: Sat, 23 May 2026 09:34:10 -0700
Message-ID: <87zf1qxeyl.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

> This series continues the "Signed BPF programs" work and adds
> the missing pieces needed for an LSM to do policy enforcement
> and addresses the concerns raised by the developers of Hornet.
>
> One signing scheme, please.
>
> BPF does not need a second signing scheme. It needs a policy
> framework that consumes the verdict the existing signing pipeline
> produces. Two parallel signing stacks is harmful UX for Cilium,
> bpftrace, systemd, distros, and everyone shipping signed lskels.
> Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
> on layering and TOCTOU grounds.
>
> What this series adds
>
> - prog->aux->sig (verdict + keyring) and prog->aux->is_kernel,
>   populated by the syscall path before security_bpf_prog_load
>   fires.
> - bpf_loader_verify_metadata kfunc -- the metadata check is now
>   kernel C code, not BPF bytecode. The verifier injects the
>   calling prog->aux as an implicit argument via KF_IMPLICIT_ARGS.
> - Loader-side prog BTF with BPF_PSEUDO_KFUNC_CALL_PROG_BTF so
>   the kfunc CALL is reproducible across build hosts and resolved
>   at load time.
> - security_bpf_prog_load_post_integrity LSM hook, fired by the
>   kfunc on a successful metadata check.
> - IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
>   two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).
>
> This series address concerns raised by the Hornet developers:
>
> * The metadata hash check should be in kernel C, not BPF
>   bytecode -- Blaise Boscaccy [3]:
>

That's a gross misrepresentation of some of my previous statements on
the subject. We can go back and forth on this until the cows home with
increasing vitriolic rhetoric, but that's really just a waste of
everyone's time. Your "trusted loader" design flat-out doesn't work for
our security requirements, and those of others. You keep screaming that
we need to "write our own trusted loader" and that isn't really solving
anything.

You just posted a trusted loader bugfix here.
https://lore.kernel.org/linux-security-module/20260522215337.662271-1-kpsingh@kernel.org/

What's your path for that now and in the future? How are you getting
people to rebuild their out-of-tree trusted loaders if there is a bug in
them? Are you expecting sysadmins to subscribe to the bpf mailing list
and watch for patches to libbpf and then rebuild an entire corpus of
eBPF lskel programs?

What if there is a security vulnerability or a CVE in the generated code
that gets emitted, how are you handling that? We have processes in place
to handle updates, bugfixes and vulnerabilities in the kernel. None
exist for your "trusted loader" paradigm. You can publish a CVE for
libbpf, but there is no way to publish a CVE for an infinite number of
random unknown bpf program in the wild or to notify users that their
programs are effected, or for them to know which programs are actually
effected and which ones aren't.

Also as an aside, it looks like some of this patchset is copy-pasted
from https://lore.kernel.org/linux-security-module/20260507191416.2984054-11-bboscaccy@linux.microsoft.com/
Which is fine of course, since this is open source software and all, but
attribution would be appreciated if you use my code in the future :)

-blaise



>   The bpf_loader_verify_metadata kfunc moves the hash check from
>   inline BPF instructions into kernel C code.
>
> * LSMs cannot observe the verification result at hook time --
>   Paul Moore [4]:
>
>   prog->aux->sig.verdict and sig.keyring are populated before any
>   LSM hook runs. Furthermore, security_bpf_prog_load_post_integrity
>   hook fires after the in-kernel hash check for consumers that want
>   to observe or gate the post-integrity transition.
>
>
> [1] Alexei Starovoitov, NACK on Hornet (TOCTOU + layering),
>     https://lore.kernel.org/all/CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com/
> [2] Daniel Borkmann, NACK on Hornet v3,
>     https://lore.kernel.org/all/798dba24-b5a7-4584-a1f6-793883fe9b5e@iogearbox.net/
> [3] Blaise Boscaccy, Hornet v6 (C-side hash verification rationale),
>     https://lore.kernel.org/all/20260429191431.2345448-1-bboscaccy@linux.microsoft.com/
> [4] Paul Moore, push for post-verifier observability,
>     https://lore.kernel.org/all/CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com/
>
>
> KP Singh (13):
>   bpf: expose signature verdict to LSMs via bpf_prog_aux
>   bpf: include prog BTF in the signed loader signature scope
>   bpf, libbpf: load prog BTF in the skel_internal loader
>   bpf: add bpf_loader_verify_metadata kfunc
>   bpf: compute prog->digest at BPF_PROG_LOAD entry
>   bpf: resolve loader-style kfunc CALLs against prog BTF
>   libbpf: generate prog BTF for loader programs
>   bpftool gen: embed loader prog BTF in the lskel header
>   lsm: add bpf_prog_load_post_integrity hook
>   bpf: invoke security_bpf_prog_load_post_integrity from the metadata
>     kfunc
>   ipe: add BPF program signature properties
>   ipe: gate post-integrity BPF program loads
>   selftests/bpf: add IPE BPF policy integration tests
>
>  include/linux/bpf.h                           |  19 +++
>  include/linux/bpf_verifier.h                  |   6 +
>  include/linux/btf.h                           |   1 +
>  include/linux/lsm_hook_defs.h                 |   1 +
>  include/linux/security.h                      |   6 +
>  include/uapi/linux/bpf.h                      |   5 +
>  kernel/bpf/btf.c                              |   8 +
>  kernel/bpf/check_btf.c                        |  18 +-
>  kernel/bpf/helpers.c                          |  65 ++++++++
>  kernel/bpf/syscall.c                          |  76 ++++++++-
>  kernel/bpf/verifier.c                         |  58 ++++++-
>  security/ipe/Kconfig                          |  14 ++
>  security/ipe/audit.c                          |  13 ++
>  security/ipe/eval.c                           |  57 +++++++
>  security/ipe/eval.h                           |   5 +
>  security/ipe/hooks.c                          |  42 +++++
>  security/ipe/hooks.h                          |   9 +
>  security/ipe/ipe.c                            |   4 +
>  security/ipe/policy.h                         |  11 ++
>  security/ipe/policy_parser.c                  |  20 +++
>  security/security.c                           |  17 ++
>  tools/bpf/bpftool/gen.c                       |  21 +++
>  tools/bpf/bpftool/sign.c                      |  17 +-
>  tools/include/uapi/linux/bpf.h                |   5 +
>  tools/lib/bpf/bpf_gen_internal.h              |   2 +
>  tools/lib/bpf/gen_loader.c                    | 127 +++++++++++---
>  tools/lib/bpf/libbpf.h                        |   4 +-
>  tools/lib/bpf/skel_internal.h                 |  67 +++++---
>  .../selftests/bpf/test_signed_bpf_ipe.sh      | 156 ++++++++++++++++++
>  tools/testing/selftests/bpf/vmtest.sh         |   4 +-
>  30 files changed, 775 insertions(+), 83 deletions(-)
>  create mode 100755 tools/testing/selftests/bpf/test_signed_bpf_ipe.sh
>
> -- 
> 2.53.0
