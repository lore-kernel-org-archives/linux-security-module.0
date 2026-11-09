Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=27.86.113.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257193;
	b=Tg6NOJogj5e2N4s5Ssi1uVB+Tpjn6NJE3bDfmz6seu/OM24XGksPDCg4UwfYnjuw1zDy
	 Kl2nY4h7s2pGejAE88t0aQdYMOj6vZO7D2/DdjX8nTJRHDLOzbuassUCFOB831bSyPnY3
	 5tHSxN99EATbADZizBpad/dMEZDPnWVFpCOH1Sm+gvLcsutY809BrL+OFsZDTor1gFX/X
	 g3mhuPWMRLGX4S4T+4fd4v+srd0KiUK2+Ty4+UHzCpYzMUqvlpZMWHKKOCqhowIBCrh4x
	 gHqD1tc5UKkG3u5K1a1L4GC1Vw3ESinhBarFkTFsFDm4NQv/1ROA8k2xGDaFCc8csPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257193;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Biglobe-Sender:DKIM-Signature;
	bh=3yVsGFxRFoCPyyi5eWjuFBzqzuVf47LuNporb1xN8zo=;
	b=qBngdvs9F89SmJzuaYKfyhtwPsGOlVWfHw8bBSIDAxHdFMWZecPIOnVDn0KaIfKzPdbL
	 xnLYBmlHMLt1McrnKcvK/D2JZNtQwgCGPduuWFpboDzRh20hJAsW/QB0vpY0JkrOlITvv
	 Q50DzMccsQXMBfRCr40IxC438s+TgPbsGNJTmpHjrWBwkxag/gKEIPpIiaPDLRTEaeSzF
	 rh+QluoFEQ/DXh/HpayMkEaY8D3xJ0iuOW9fvg6cAhGA5N4r4umqwZQPzIZ22/4hho2AJ
	 J97AH9FUoM2/VJtpd1pBdN46aoY0pk/TZlym4nx43RxXUxiQBl7WwpxOuCTJAwnJRCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kjb.biglobe.ne.jp;
	spf=pass smtp.mailfrom=kjb.biglobe.ne.jp;
	dkim=pass header.d=kjb.biglobe.ne.jp header.i=@kjb.biglobe.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b="W/5PVn+4";
	arc=none smtp.remote-ip=27.86.113.20
Received: from mta-snd-w04.biglobe.ne.jp (mta-snd-w04.biglobe.ne.jp [27.86.113.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA249606A331
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 20:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA249606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kjb.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kjb.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kjb.biglobe.ne.jp header.i=@kjb.biglobe.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=W/5PVn+4
Received: from mail.biglobe.ne.jp by mta-snd-w04.biglobe.ne.jp with ESMTP
          id <20261109204620611.ZPNI.105100.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Tue, 10 Nov 2026 05:46:20 +0900
Message-ID: <fdf1ae20595a58302267f886dee1b9b69fdde7c0.camel@kjb.biglobe.ne.jp>
Subject: [RFC v2+] Kernel API Firewall (kaf): emergency CVE mitigation via
 loadable policy modules (with pre-disclosure defense appendix)
From: Nakashima Seiichi <s-nakashima@kjb.biglobe.ne.jp>
To: kernel-hardening@lists.openwall.com
Cc: keescook@chromium.org, paul@paul-moore.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org
Date: Tue, 10 Nov 2026 05:46:20 +0900
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Biglobe-Sender: s-nakashima@kjb.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kjb.biglobe.ne.jp; s=default-1th84yt82rvi; t=1794257180;
 bh=3yVsGFxRFoCPyyi5eWjuFBzqzuVf47LuNporb1xN8zo=;
 h=Subject:From:To:Cc:Date;
 b=W/5PVn+4tQ6VdWXrvGRh1Jhub4mVACVRo5Vv+JYveCoF5F1vD6+JNzxTgOsPOTQmJ626gmGt
 GV1Uq5ItXBhRVi+z1w8VHWdvVPtK7lccRVdtc7eAj6aM0iX8toqbFISsnlrfgHNupagGk5svCg
 FzdVJTMkFE1rewZqNZ2tG2Ghoq2cqQhpcC8dfcmzmtz+ZIOezJlv38MBNIOvyuD1BVAfXpIDRn
 FBQtqS1DdkZERzFkoc9hQUvR5JT0ekC/FHGVqlQGVOJ2M+x/KsbMsUOqyWdNEPLrsOeAvzrkNy
 Xl81l7qu+FZlkgWCBYO4fppzmiIbYY4H1w1b0zf/eGIfngUw==

Hi all,

Thank you to Paul Moore and others who responded to the initial RFC.
Based on that feedback, I have refined the scope and design direction.
This v2+ focuses specifically on kaf as an *emergency mitigation
mechanism* rather than a general-purpose security boundary.

(Note: This RFC was drafted with assistance from=20
assistant.  Technical details are sketches for discussion, not
implementation proposals.  I am not a kernel developer and seek
design direction from those who are.)

1. Refined scope: what kaf is and is not

kaf is NOT:
  - a replacement for seccomp, LSMs, or other access control
  - a permanent security boundary
  - a mechanism for general syscall filtering

kaf IS:
  - an emergency attack-surface reduction mechanism
  - active only during the "patch gap" between CVE disclosure
    and distro patch availability
  - a way to block specific vulnerable code paths without waiting
    for a full kernel update

2. Motivation: why this matters now

The patch gap is the critical problem:

  upstream fixes:     24-48 hours
  distro backports:   30-90 days (some variants longer)
  user exposure:      the entire gap

For example, a container host running Ubuntu 24.04's GA kernel
may wait weeks for a critical CVE backport.  During that time,
users currently have no kernel-level mitigation available.

kaf aims to give distros a mechanism to ship *temporary, targeted
mitigations* that can be loaded and unloaded without a full kernel
upgrade.

3. Proposed architecture: three layers

Layer 1: Kernel stub hooks (minimal, permanent)
  - Small #ifdef CONFIG_KAF stubs in target subsystems
    (bpf, module, kexec, ptrace, io_uring, net/ipv4, etc.)
  - When disabled, cost is near-zero via static_branch_unlikely
  - When enabled, calls into Layer 2

Layer 2: kaf.ko (LKM, CONFIG_KAF=3DM capable)
  - Framework for managing and invoking Layer 3 policies
  - Loaded/unloaded by the distro as needed
  - No policy logic itself; delegates to eBPF programs

Layer 3: kaf-policy-cve-XXXX.o (eBPF programs)
  - One eBPF program per CVE or vulnerability class
  - Distro ships these as emergency packages
  - Example lifecycle:
      CVE discovered on Monday
      distro ships kaf-policy-cve-2026-99999 on Tuesday
      kernel 7.0.0-43 fixes it next month
      policy is unloaded and package removed

4. Example lifecycle

Normal state:
  - kaf stubs are present but inactive
  - kaf.ko is not loaded, or loaded with no policies

Emergency state:
  - Distro loads kaf-policy-cve-2026-99999.o via kaf.ko
  - Specific vulnerable code path is blocked
  - Audit logs record blocked attempts

Resolved state:
  - Kernel update ships with proper fix
  - Policy is unloaded and package removed
  - System returns to normal state

5. Why existing mechanisms are insufficient for this use case

Paul Moore correctly noted that SELinux (and BPF LSM) can cover
much of this territory.  However, the emergency mitigation use
case has specific requirements that existing mechanisms do not
fully address:

  a) Unified distro packaging and distribution
     - Distros need a single, well-understood mechanism they can
       ship as an emergency update across all variants
  b) Temporary lifecycle management
     - Policies must be explicitly temporary and auto-remove on
       kernel upgrade
  c) Non-expert administrator experience
     - A sysadmin should be able to see "kaf policy X is active"
       and understand what it does without deep LSM knowledge
  d) Zero overhead when inactive
     - The patch-gap mitigation must not cost cycles during normal
       operation

Existing LSMs are designed for permanent policy enforcement.
kaf is designed for temporary, emergency, CVE-specific mitigation.

6. Open questions for the kernel community

I need help with the following design decisions:

Q1: Hook placement
    Should kaf use existing security_xxx() LSM hooks, or does it
    need its own CONFIG_KAF stub hooks in target subsystems?

Q2: LSM vs independent framework
    Should kaf.ko be implemented as a new LSM, or as an
    independent framework that complements LSMs?

Q3: eBPF viability for CVE policies
    Can BPF CO-RE / BTF provide sufficient cross-version stability
    for distro emergency packages, or will per-version builds be
    required for each kernel revision?

Q4: CONFIG_KAF=3DM feasibility
    Can the stub hook mechanism work cleanly with CONFIG_KAF=3DM,
    where kaf.ko may or may not be loaded?  Specifically, how do
    we handle the function pointer / stub interaction cleanly?

7. What I can offer

As a non-developer, I cannot write kernel code.  What I can do:

  - Test prototypes on Ubuntu LTS systems and provide detailed
    operational feedback
  - Analyze real CVEs to identify which ones could have been
    mitigated by kaf and what the hook conditions would be
  - Write user-facing documentation and admin tooling
  - Provide feedback on profile/policy design from a sysadmin
    perspective

8. Relationship to prior work

  - seccomp-bpf: complementary (syscall-level vs semantic-level)
  - Landlock: complementary (filesystem/network access control)
  - SELinux/AppArmor/BPF LSM: complementary (permanent policy vs
    emergency mitigation)
  - io_uring restrictions (Jens Axboe): kaf could leverage these
    hooks for emergency io_uring CVE mitigation

9. Sustainability note (not part of the technical RFC)

kaf is intended to be free and open source.  Long-term
sustainability for CVE rule development and framework maintenance
may be supported through a Linux Foundation / OpenSSF fund model
and integration with distro vendors' existing support channels.
This is outside the scope of the kernel technical discussion.

10. Appendix: pre-disclosure defense

The following appendix was added in the v2+ revision to address
the pre-disclosure window: the period between a vulnerability
being reported to a vendor and public CVE assignment.

The pre-disclosure problem

  During pre-disclosure, the vendor knows about the vulnerability
  but cannot yet ship a patch without revealing the issue.
  Attackers with early knowledge (e.g., from reverse-engineering
  vendor pre-releases) may begin exploiting the vulnerability
  before any public fix exists.  Current mechanisms offer no
  kernel-level mitigation during this window.

How kaf could help

  - Generic policy modules:
    Instead of CVE-specific policies, vendors could ship
    *vulnerability-class* policies (e.g., "restrict all new
    io_uring opcodes introduced in the last 6 months") that
    reduce attack surface without naming a specific bug.
  - Silent deployment:
    kaf policies can be loaded without public announcement,
    and their presence is only visible to administrators via
    audit logs and /sys/kernel/security/kaf/.
  - Gradual tightening:
    As more information about the vulnerability becomes
    available, the policy can be refined from a broad class-level
    block to a precise path-level block without rebooting.

Risks and mitigations

  Risk: Overly broad policies break legitimate workloads
    Mitigation: Audit-only mode: policies log but do not block,
    allowing workload impact assessment before enforcement

  Risk: Policy itself reveals the vulnerability
    Mitigation: Generic class-level policies do not name specific
    functions or CVEs

  Risk: Administrators disable kaf due to performance concerns
    Mitigation: Zero-overhead inactive stubs and per-policy
    performance counters

Integration with embargoed disclosure

  kaf policies could be prepared in advance by distro security
  teams during embargo and held in a "pending" state.  At the
  moment of public disclosure, the policy is activated with a
  single command, reducing the effective exposure window from
  hours or days to minutes.

Thanks for reading.  I am looking forward to your feedback on
the design direction and open questions above.

Nakashima Seiichi, Sakana AI's Namazu
