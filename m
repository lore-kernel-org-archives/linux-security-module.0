Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7F48CD56;
	Wed, 19 Aug 2026 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161587; cv=none; b=bDh+PKDYx9uAl1HyF8Ji/cidq5NBvm9vxHH0qFqqJEqeTbIgSzwXbq+Nj/0Ak+ulwhFWCKetFS1l9lOq7KR7HZSvRBWwOIEibah9BV6n9aWethwQ1+KGjnb0x9f6IvPqIeYztUqjPR72oJswJwLKgzwcXDCxeaozw21SMi0Gukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161587; c=relaxed/simple;
	bh=CwpOpkhs+bu8JxbI5aeFuddzl4sHz3If9A0UU7e47wM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rzJkVJZAjkcI11plysPzUxgvziTX3BnI9pVc5Xbm0NE5BYcEcXgXH8KJBLNZ0fhqfDjpER2BemMmS05wOSPRTXYV4u5NVNK8geppRxApFnRPXSa9C8RViY0GE/+nzxtxnu768T9nNv305B6U6ic+258msi8FyQLdFnviHfAd7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nTpV2B+F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nTpV2B+F"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1jsT3758202;
	Wed, 19 Aug 2026 17:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=svOdRy
	zkz85o4dQkfRTS1WfF58hwqA9bcNetq/DWToI=; b=nTpV2B+FVDr6WCWXDwZAMg
	Zftv7k51X03X3oaJggCu1YBcaiacmlyCMc89xL4aXmTIjd0wKLQ8b6+OpQ5BGIoY
	PkV7+56vppCUq+Ly359XXJtnJn8ZnL3mSHKzseTwr7rZTawMFyKR+WxWpyKEj/a/
	YYtv2NWkaCxbHBdBLUX+ko7bIuDUYSMQt/EYjjRkgtsofU6v+PD6K6p8I66EHYM9
	GRziH3XpX607RgZsIAbM770yRrz5kj3i6aLPiHp5Cftf5A9MWdhmvpNAPVJofl8R
	CQbPgG6EK3kB2/v6w0V9FDjeXcN6KbXtebjON2QtV4NRwAjPOUhE+UEUnMIpOVkg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1dbf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:46:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHfGY2013974;
	Wed, 19 Aug 2026 17:45:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqab92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:45:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JHjwil61079862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 17:45:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E6ED58065;
	Wed, 19 Aug 2026 17:45:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF3C58055;
	Wed, 19 Aug 2026 17:45:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.87.198])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 17:45:57 +0000 (GMT)
Message-ID: <a5efe5059cd261c19496e602459fb37e3159817d.camel@linux.ibm.com>
Subject: Re: [RFC] IMA: periodic runtime re-measurement of process .text/GOT
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Kuntze <nicolai.kuntze@hs-mainz.de>,
        linux-integrity@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
References: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:45:56 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a85ebd8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=UVq9kkz1AAAA:8
 a=VUU_zDYVAAAA:8 a=Y-EY-SLt03UiKusQr6oA:9 a=QEXdDO2ut3YA:10
 a=u5K0Xq2S27Hs0aPG2nEw:22
X-Proofpoint-GUID: 4CxJnKqQvNqaOI-RmgX_lIbo8Wmq3zcv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX1+4lScm+Drmk
 t355pUDPzWU5JGOZcTtyIPus8rpU6PD+tQKzacsFBcZ3fIfp2AFH/N9/KglSpqlvZAuVO1mwaxO
 pZRPX3VdELvs+AgEM6r23RtQ2uXgujk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfXxdK6DdZqXfm9
 hcyofAZtgBMfS3/ZfE6O+Vv76+7uHpwElKZEEQUcvR1001HamiV6YzQv7hFTI7F7zvo5E7NAFnC
 sHjIVWPQM33hpeyhiEk/jLP/PHtxoz7HwuSiJG7FwSg2OjBk1f4vmGbLINb5AUSv++PiBK/lJXa
 K+bnljlSW/mpjH0l5ip6LiGsbzPDWu7dCrZvtNuzr2Tl8GlSpjBnyuH2w4q11toJsthXgVHxxjs
 RpJPaV5ov5dT4+ba+vONOE/bSCsuLKglO2Kf5eRm2+bSrVePr+1Q3eQ4/feda3eDbg5HRgMNrD5
 xOBDJp/NqO/WkeBEt9awScDuY6wg28VyiE+bhIheGYwdxYy5Vc5QuMLSBkZznTBWOEPzULb5pQ7
 jKGbgbCKbj7sj+4a9ZUVzLJPz0DPsH1G8Nrq74rPtPpwAn5KGX1q8KiJaDdh3eqi12dTYuxpOcq
 t5tvgs70/8i5L8G48Eg==
X-Proofpoint-ORIG-GUID: L6fZrKoL8p6mG7Az_4CexUw1OQotwkSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190136

On Mon, 2026-08-17 at 12:23 +0200, Nicolai Kuntze wrote:
> Hi,
>=20
> This is a design RFC, not a patch submission -- I'd like feedback on
> the approach before polishing the patch series further. A working
> reference implementation exists today for demonstration; details and
> links below.
>=20
> Problem
>=20
> Every existing IMA hook (FILE_CHECK, MMAP_CHECK, BPRM_CHECK,
> MODULE_CHECK, ...) measures once, at load time: file open, exec,
> mmap, module load, or an explicit ima_measure_critical_data() call.
> Nothing in IMA today re-measures an object after it's already
> resident. A process's .text or GOT can be modified in memory after
> load (ptrace(), a kernel exploit writing through /proc/pid/mem, or
> similar) without IMA ever re-examining it -- the load-time
> measurement stays valid in the log forever, even after the live
> content has diverged from it.
>=20
> This is exactly the gap Andre Rein's DRIVE paper (ASIA CCS '17,
> https://doi.org/10.1145/3052973.3052975) addresses: periodic
> re-hashing of a process's executable memory against reference values
> derived from its on-disk ELF, anchored in a TPM PCR via the same
> extend-chain model IMA already uses. This RFC proposes bringing that
> capability into IMA's own policy-driven measurement model, rather
> than as a separate, out-of-tree mechanism.

There are two separate issues that need to be addressed:

- Systems that aren't rebooted frequently
- Long-running processes whose mmap'ed executable memory may have been tamp=
ered
with after load

The first issue can be addressed by periodically clearing the iint cached i=
nfo.
It's something that should be added to IMA and is a relatively simple addit=
ion.
It would be a good first kernel project.

The second is verifying a long-running process's mmap'ed executable memory
(.text, GOT) hasn't diverged from what was loaded =E2=80=94 via ptrace(), a=
 kernel
exploit through /proc/pid/mem, or similar. DRIVE addresses this via periodi=
c re-
hashing against the on-disk ELF, TPM-anchored.

Worth noting: W^X, hardware CFI, and page-fault-based monitoring all fully
prevent tampering that goes through normal page-table-enforced writes =E2=
=80=94 no
window, no cost of periodic checking. None of them, however, cover an attac=
ker
with an arbitrary physical-memory write or the ability to rewrite page tabl=
es
directly, since that bypasses MMU enforcement entirely. DRIVE is the one
mechanism here that says anything about that residual case =E2=80=94 but on=
ly as
bounded-time detection (via the re-hash interval), not prevention. On bare
metal, nothing closes that gap outright; DRIVE narrows it rather than solvi=
ng
it. The RFC should be explicit about that distinction.

I'm not convinced this feature belongs in IMA. IMA's existing model is even=
t-
driven, once: measure at open/exec/mmap. This feature is continuous/periodi=
c =E2=80=94 a
timer walking live process state on its own schedule =E2=80=94 which is a d=
ifferent
execution model, not an incremental addition to a hook-based architecture. =
The
reference implementation shows this mismatch concretely: it bypasses IMA's
measurement list and dedup entirely, because IMA's "measured once, log stay=
s
valid" model doesn't fit a periodic check that needs to prove this specific=
 tick
still matched.

Mimi (with AI's help)

>=20
> Scenario / Rational
>=20
> Load-time-only measurement is a materially weaker guarantee on
> systems that stay up for a long time between reboots than on systems
> that cycle power regularly. Every reboot is itself a fresh
> measured-boot event -- a natural bound on how long an in-memory
> tamper that bypassed load-time measurement can persist undetected,
> since the next boot re-measures everything from scratch.
>=20
> Railway signalling and interlocking equipment is a concrete example
> of the opposite case: field devices are routinely designed to run
> for months or years without a reboot, both for safety-availability
> reasons (a signalling function restarting is itself an operationally
> disruptive event) and because physical access for a controlled
> maintenance reboot is often scheduled, not on-demand. On that kind
> of system, load-time IMA measurement establishes a trustworthy
> baseline at boot and then provides no further guarantee for the
> entire multi-month uptime that follows -- an attacker who achieves a
> one-time in-memory modification (no on-disk change, so FILE_CHECK
> never fires again) can persist for as long as the device stays up,
> which on this class of hardware is the normal case, not an edge
> case. The same shape of argument applies to other long-uptime
> industrial-control and embedded contexts more generally; railway is
> simply where this is currently being evaluated. Periodic
> re-measurement turns "trustworthy at boot" into "trustworthy for as
> long as it keeps checking," which is the property this class of
> system actually needs.
>=20
> Proposed design
>=20
> Two pieces:
>=20
> 1. Policy grammar: a new interval=3D option (milliseconds), together
>    with three new func=3D hook names -- RUNTIME_TEXT_CHECK,
>    RUNTIME_GOT_CHECK, KERNEL_TEXT_CHECK -- added to the existing
>    __ima_hooks() X-macro in ima.h, so the enum, the measuring-string
>    table, and the policy-readback token array all stay in sync
>    automatically, the same as every existing hook. interval=3D is
>    required for, and only accepted with, those three hooks, enforced
>    in ima_validate_rule() the same way IMA already enforces every
>    other func-specific option. Example rule this grammar accepts:
>=20
>        measure func=3DRUNTIME_TEXT_CHECK interval=3D30000 pcr=3D16
>=20
> 2. A dispatch engine: a new security/integrity/ima/ima_runtime.c,
>    compiled into ima.o (not a separate loadable module), holding a
>    delayed_work-based periodic worker that ima_update_policy()
>    starts, reconfigures, or stops to track whatever
>    RUNTIME_TEXT_CHECK rule is currently active. On each tick it
>    walks every live task's file-backed executable VMAs under a
>    locked snapshot, then hashes unlocked (a two-pass split that
>    exists specifically to avoid a nested-mmap_read_lock self-
>    deadlock hit during prototyping -- see "What's already been
>    tested" below), reuses ima_calc_buffer_hash() for the hash
>    itself, and PCR-extends via tpm_pcr_extend(ima_tpm_chip, ...)
>    directly, deliberately bypassing ima_add_template_entry()'s
>    measurement-list/htable path. That path dedups by (digest, pcr)
>    alone and skips the PCR extend on a repeat digest -- which would
>    silently break external verification, since an auditor replaying
>    the log's extend chain needs to reproduce exactly what the TPM
>    really did, including repeats of unchanged content across ticks.
>    Log-growth from repeatedly re-measuring unchanged content is
>    instead bounded by a small (pid, address)-keyed dedup cache,
>    checked after every hash (never instead of hashing), so nothing
>    is ever skipped without being freshly examined first.
>=20
> RUNTIME_GOT_CHECK and KERNEL_TEXT_CHECK are accepted by the grammar
> but not yet wired to the dispatch engine -- v1 measures .text only.
> Kernel-image .text re-measurement in particular needs its own
> reference-value handling (a statically-linked kernel image has
> link-time-relocated content, unlike the userspace PIC/PIE case this
> prototype already handles) and is intentionally left for a follow-up
> rather than folded into this first round.
>=20
> What's already been tested (reference implementation)
>=20
> Public repo, with everything below runnable, not just described:
>=20
>     https://gitlab.rlp.net/nicolai.kuntze/memory_attestation
>=20
> - The full DRIVE pipeline -- runtime re-measurement, DML/SMAF chain,
>   ELF-derived reference values (.text and per-GOT-slot), and an
>   external OBS/VS verification split with TPM-Quote cross-checking
>   -- is prototyped and validated end-to-end as a standalone
>   out-of-tree module (drive_ima/) plus a Rust verification toolchain
>   (drive-rs/), including real ptrace()-based tamper injection
>   correctly detected in every case, and real PCR extends confirmed
>   against a swtpm-backed TPM via tpm2_pcrread.
>=20
> - The two mainline patches this RFC describes
>   (kernel-patches/0001-ima-policy-add-interval-and-runtime-hook-
>   funcs.patch and 0002-ima-runtime-dispatch-engine-v1.patch), plus a
>   follow-on 0003-ima-runtime-per-mapping-dedup.patch adding the
>   dedup cache, apply cleanly against v6.8, pass checkpatch.pl
>   --no-tree with 0 errors/0 warnings, compile clean under W=3D1, link
>   into a full vmlinux, and boot and dispatch for real under QEMU/KVM:
>   writing a RUNTIME_TEXT_CHECK rule to /sys/kernel/security/ima/policy
>   in a running kernel causes the worker to fire on the configured
>   interval, correctly measure every live process each cycle, and
>   correctly reconfigure after a policy rewrite -- all empirically
>   timed, not just log-inspected.
>=20
> - One thing not yet exercised: a genuine hardware PCR extend from
>   this dispatch engine specifically. The test environment (QEMU
>   8.2.2 + SeaBIOS 1.16.3) hits a reproducible ACPI early-boot fault
>   whenever any TPM device is attached, confirmed unrelated to this
>   patch (fault is at PID 0, well before IMA runs). With no TPM
>   present, the code correctly takes its documented -ENODEV fallback
>   rather than crashing; that path is tested, a real PCR write from
>   this specific code path is not, in this environment. (The extend
>   call itself, and the extend-chain format, are the same ones
>   already confirmed working against real hardware in the standalone
>   prototype above.)
>=20
> Threat-model note, already accounted for
>=20
> Read-write access to /sys/kernel/security/ima/policy at runtime
> (CONFIG_IMA_WRITE_POLICY=3Don) lets anyone with CAP_SYS_ADMIN silently
> remove or weaken an active RUNTIME_TEXT_CHECK rule without touching
> any signed code -- which would defeat the "isolated from a post-boot
> adversary" property this is meant to provide, and matters more, not
> less, on the long-uptime deployments described above, since there's
> no near-term reboot to force a policy re-load. This isn't a gap in
> the proposed patches; it's a statement about deployment
> configuration, and it's already documented as a hard requirement for
> production use of this extension: CONFIG_IMA_WRITE_POLICY should be
> off, making the policy write-once at boot the same way it already is
> for every other IMA policy today.
>=20
> Questions for the list
>=20
> - Is a delayed_work periodic worker compiled into ima.o the right
>   shape for a non-event-triggered hook class, or would the list
>   prefer this live behind a separate mechanism (a kthread, an
>   LSM-adjacent facility, something eBPF-driven) rather than inside
>   IMA's own hook dispatch?
>=20
> - Is bypassing ima_add_template_entry()'s measurement-list htable
>   (for the reason given above -- external-verifier replay needs
>   every real extend, not a deduped view) an acceptable precedent, or
>   is there a preferred way to get an un-deduped extend through the
>   existing measurement-list path instead of calling
>   tpm_pcr_extend() directly?
>=20
> - Any objection to the interval=3D grammar addition / the X-macro-
>   based hook additions as scoped here, ahead of a full patch series?
>=20
> - Kernel-image .text re-measurement (KERNEL_TEXT_CHECK) is
>   deliberately left unimplemented in this round -- is that the
>   right place to split the series, or would the list rather see it
>   land together with RUNTIME_TEXT_CHECK?
>=20
>=20
> Thanks,
> Nicolai
