Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E73C3C12
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720309; cv=none; b=T+6KtpDZ84P55u2pGihwxQbXLlflQlnji4div0agpmR9XBjVEMiWl6aMOAf3jbyOLOfPaMkDP8SXQuQ0x45fdfohucVpNFVDU0Vl5Ab14+LCy386MvH7ttpQeGt1pHnSv9To2RLNzCre5pPtloD2b7agF3eHHYkKnHbuFNSsbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720309; c=relaxed/simple;
	bh=FPpbBhOU5SGTKOJLrnyQFFP/+iR5wqmEyhk0IVNZ6h8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr4RPrTIRZ7xGzfqTf/wwMIMHpen72ZkWKum9WZj9uTPxYd3ucanGoExSAfSmFznWQpGfTi31a57J0a51vsG868mqbBK/A9wZEfCsqq+eOf1dDTL6hmuQj/RPAFwvCX1PyfUb0NdbxsyKSsWXlNND5QM+ogFT1IXVOM12qPiR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YUTixyXP; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YUTixyXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783720297; x=1783979497;
	bh=1KkGK1kZyuzsCnW+0aqDpWwzXOCREZm2ehoIG/qf+7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YUTixyXPS+Mk4wmT8TNaCmlnNvCyNA67r16JcsD/cWMvbyYFn4yVPMsd5b/jlTPTk
	 fv8hSZdZGZjRpek1TGR2PGXygT+RGBQG0ixcBHj2MxZ5RL9wCqE1WjLDUaTrlWEfxx
	 6wIPOfPEGfOEE9WIimC2zjUbKCrZlP38nSc/ITp5ICJ85KlaTZZyWD1zki6RShIDC+
	 ogoPeQGcONmiynw/+fxKlM0YfCem4bCrG4Sk9OpLqOy89d1B7lzKqRxOdmrrO+x66A
	 8kqOGH0l3p4okL5RVRTJyT4j+Ou6eBd5xP1lZ1F7uVZWEeZadshJ2MaipXIqNTSCeP
	 4K4TFneqMkyjQ==
Date: Fri, 10 Jul 2026 21:51:32 +0000
To: "paul@paul-moore.com" <paul@paul-moore.com>
From: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rppt@kernel.org" <rppt@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "serge@hallyn.com" <serge@hallyn.com>, "jmorris@namei.org" <jmorris@namei.org>
Subject: =?utf-8?Q?=C4=B0lt:_Re:_[RESEND][RFC/discuss]_memfd=5Fsecret():_opt-in_visibility_for_security_monitoring_(eBPF/audit)?=
Message-ID: <efkpRkpZ91GfphzYue7OEdLG9WrkPjQx8RXvL3JZb0Fme2DTmcpkqBd3joAD25QFVfCnBY_TMNh2aHMwGRMySeMX0Bs34hN3sBphdj23nGk=@proton.me>
In-Reply-To: <CAHC9VhSWs4=-BN09XWUsJXh+9HB5zeYa0oiRsRNGb4s_sTW2HQ@mail.gmail.com>
References: <MZlCECz5s73hPgQxtqWZ2VbXNTCZnItnwMHu2iZQlRC6ba0B9GuqxT2EhvhwQ-uanBDsNn7Bg09nGVynBHdmSsiRjhyI1udkYbqOoPfpe6w=@proton.me> <CAHC9VhSWs4=-BN09XWUsJXh+9HB5zeYa0oiRsRNGb4s_sTW2HQ@mail.gmail.com>
Feedback-ID: 205449183:user:proton
X-Pm-Message-ID: 1f7ae8acb79f3cb6c99407764188494a0a0ba779
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





Proton Mail g=C3=BCvenli e-posta ile g=C3=B6nderildi.

------- Forwarded Message -------
Kimden: Paul Moore <paul@paul-moore.com>
Tarih: 11 Temmuz 2026 Cumartesi saat 00:00
Konu: Re: [RESEND][RFC/discuss] memfd_secret(): opt-in visibility for secur=
ity monitoring (eBPF/audit)
Kime: BoxStrikesTeam <BoxStrikesTeam@proton.me>
CC: rppt@kernel.org <rppt@kernel.org>, akpm@linux-foundation.org <akpm@linu=
x-foundation.org>, linux-mm@kvack.org <linux-mm@kvack.org>, linux-security-=
module@vger.kernel.org <linux-security-module@vger.kernel.org>, jmorris@nam=
ei.org <jmorris@namei.org>, serge@hallyn.com <serge@hallyn.com>


> On Thu, Jul 9, 2026 at 1:14=E2=80=AFAM BoxStrikesTeam <BoxStrikesTeam@pro=
ton.me> wrote:
> > Paul,
> >
> > Thanks - I found the Gottsche/inode_init_security_anon() thread and can=
 see it landed. That answers (a) cleanly: labeling exists, policy can be la=
yered on top via SELinux/AppArmor if a site wants alerting on memfd_secret(=
) creation. Good to have that confirmed as already solved.
> >
> > On (b), let me push on it a bit further, because I think it's worth spe=
lling out explicitly rather than dropping it.
> >
> > My concern: as it stands, an unprivileged process can populate a memfd_=
secret() region and mseal() the mapping, producing memory that is (a) unrea=
dable by any kernel-side introspection path, including root-owned eBPF trac=
ing programs, and (b) can't be coerced back into an inspectable state via m=
protect/munmap. From a host-based detection standpoint that's a blind spot =
an attacker can use to park a payload where a CAP_BPF-privileged monitoring=
 agent - something that in most other respects can inspect any process on t=
he box - simply cannot look, no matter what capabilities it holds.
> >
> > I understand the objection this invites, and I want to address it direc=
tly rather than pretend it isn't there: the memfd_secret() man page is expl=
icit that its ROP protection rests on the absence of any in-kernel primitiv=
e for reading this memory. If I'm reading that right, the objection to (b) =
is that adding any such primitive - however capability-gated - re-creates e=
xactly the artifact a ROP chain would want to call, undermining the "no pri=
mitive exists" property regardless of who's nominally allowed to invoke it.
> >
> > I don't think that objection is wrong, but I'm not sure it's fully disp=
ositive either, and I'd like to hear the maintainers' take on the tradeoff =
explicitly:
> >
> > - The ROP threat model assumes an attacker who already has arbitrary ke=
rnel code execution (they're calling kernel functions directly). If they ha=
ve that, they can likely already walk page tables and reconstruct the mappi=
ng by hand - the primitive removal raises the bar, but per the design's own=
 caveat ("no 100% guarantee"), it was never advertised as absolute.
> > - The (b) scenario I'm raising is a different actor: a legitimate, priv=
ileged, kernel-mediated monitoring agent (eBPF LSM/tracing program) operati=
ng through the normal verifier-checked helper path, not an attacker executi=
ng arbitrary kernel code via a ROP chain. Conflating "any code path that ca=
n read this memory" with "a gadget a ROP chain can call" may be overly cons=
ervative if the new path is narrowly scoped (e.g., a new bpf_probe_read_sec=
retmem() helper, verifier-restricted to CAP_PERFMON|CAP_BPF programs, opt-i=
n per region via a memfd_secret() flag the owning process must set at creat=
ion time).
> >
> > If that distinction doesn't hold up - if any additional kernel-callable=
 read path is considered equally exploitable regardless of gating - I'd gen=
uinely like to understand why, since it would mean the confidentiality guar=
antee is fundamentally incompatible with any form of authorized introspecti=
on, which seems worth stating plainly in the documentation for anyone build=
ing EDR/monitoring tooling around eBPF.
> >
> > Even if (b) is rejected, I believe explicitly documenting that memfd_se=
cret()+mseal() creates an introspection-proof region would be valuable for =
the security community, so EDR vendors can adjust their threat models accor=
dingly.
>
> To be very honest, I'm not too concerned about out-of-tree, security
> products; I'm focused on the in-tree kernel code.  If you are
> concerned about userspace making use of memfd_secret(), you could
> block the operation on a per-process/domain basis using either seccomp
> or SELinux (other LSMs may have similar functionality, that's an
> exercise left to the reader).
>
> Also, it is important to note that if you find the kernel
> documentation lacking in a particular area, I would encourage you to
> submit a patch to address the shortcomings.
>
> --
> paul-moore.com
>


Paul,

Thanks for the discussion and for the pointer to secretmem_file_create() =
=E2=80=94 that resolves (a) for me.

On (b), I've thought about it further and agree a kernel patch isn't the ri=
ght answer here. A few closing observations for the record:

1. Dynamic detection isn't actually closed off by memfd_secret()+mseal(). E=
very syscall a payload makes traps through the normal syscall entry path, a=
nd pt_regs->ip at that point reflects the calling address regardless of whe=
ther that address sits inside a secretmem VMA. Cross-referencing that IP ag=
ainst /proc/pid/maps (or vma->vm_start/vm_end in-kernel) lets a tracer attr=
ibute syscalls to a secretmem-backed region without ever reading the region=
's contents. So the confidentiality guarantee holds, but it doesn't buy an =
attacker syscall-level anonymity =E2=80=94 only content opacity.

2. That said, I recognize this is a bypassable heuristic on its own (an att=
acker can proxy syscalls through a separate, non-secretmem code path), whic=
h is why I don't think dynamic detection alone is a complete answer either.

3. The more durable idea, I think, is one that doesn't touch confidentialit=
y at all: hooking the memfd_secret()/mmap()/mseal() call sites and building=
 a signature purely from call metadata =E2=80=94 arguments, region size, pr=
otection flags, and the sequence/timing of these calls =E2=80=94 rather tha=
n from region contents. This gives EDR/eBPF tooling something for static/be=
havioral matching without requiring any new in-kernel read primitive, since=
 none of that metadata is protected by secretmem's threat model. This is ac=
hievable entirely in userspace/eBPF today with existing hooks, so no kernel=
 change is needed for it either.

Given that, I don't think there's a kernel patch to propose here. This look=
s like it's squarely a detection-engineering problem for security products =
to solve on top of existing tracepoints, not a kernel gap. I'll leave the f=
ollow-through on that side to the community.

Thanks again for engaging with this =E2=80=94 appreciated the back and fort=
h.

Best,
Eneshan Erdo=C4=9Fan Karaca
