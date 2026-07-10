Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE9225A38
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717254; cv=pass; b=hZCqyTJ/8hwvOdBjnBgi5aIwFvAttrOTJLmBgI5jYfEg2ll4x2LGy2dKgMIC1fU+x57n/KVpK8MtwQMwxRCJDzWsQwROImlkwq1cRe1PPzdnGPIEqmOuTLMVn1tqvj/7+8RN0nvC/T03klYod/CzX27/ZOgp1Z91StzL1x4iC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717254; c=relaxed/simple;
	bh=iU3/RXMAX+GVjN5fioFiTSUMMDJ92hJtkgR0pdqFRQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3ANJkt0a6YU78oczJwNoxmajNcVwmZNFKvW0KH5Tn205/Gz+LF0y4Hha2vFAVa5QlJuBGiO+pUCQhdf+9HEo7OT/HL6rXxbbjPTfwMM4QzPEekcfagFDlz099l6QGqRm4ocpu+/pOEBo7aXeXGe+VLEn26FFD+05HI7ltmtVJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hr4X+M8H; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hr4X+M8H"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso16468435ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 14:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783717252; cv=none;
        d=google.com; s=arc-20260327;
        b=fhu3PX1ZKCiBM+0wUm6mgrvIKGA/o/IhOYW78upS3g/BurYWkWERCHJGVfcUCmKyg6
         8dO5T4kASSl+ODVy0DQwi0F9gq1Mt4OGdbufZnTpCUFZHu2FONv5XGUfKWuHWEerZOH7
         BcSAgv603BRXdjZ9NDex2zfu8a+q/aFTSJM/U66G87nry+PJzdkZyrH3n2SrlHtcnGVd
         fZtV5VqdPI/srYHPOfyrr83zGYAiGoS4WCcbwXvIxFIliSOsMJlW8yybVGi0M9r/6ETa
         5BHcftMoiKXP0W/677H/E8p7syUzfbkS7+u8uJl2N7nGHfVF1oYgaN2Jb3XV0+4Q77Kr
         t6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rqzV29M/TfqY8poEDBrz7krImCgB8mIlNT5MO3ZgoJ8=;
        fh=V7nTrS683lqMnU/qTTkf/8bDuaiK5HkayiFvlyaIgbk=;
        b=DkyFrjNAMSIQrPbmmZgb0nUbbvOq6KQXTUu0J7Xun6m5lFZDRXgMoY0+0Y8olPL5yz
         R8JG5eba+Wc8IFd/CnjXsYCLY+O/hBuRKor0FhRbx6PVGwFpbLF+iPM920BIys7693FS
         HtmeJFKLjJBkwb5Wp/qshY5PfIw3mG92mfSaA4j5AuDunRywTMzEMKSjuvcOMry5ECek
         7Tsb8VfGD3oQePMzpQ9QZHYKQHowz/oP7CUqjv4rC49vVZJt6TR4cyMa9O7UUmEbQRuI
         yCW12to9ylT99mwchALkgkWa9jfOJyFK/zY8HJ0+f5jiVCb3H2Yo/0U1MDCqRGX7Vqiu
         JPXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783717252; x=1784322052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rqzV29M/TfqY8poEDBrz7krImCgB8mIlNT5MO3ZgoJ8=;
        b=Hr4X+M8HrK1NNury67xl6KZmQ3StenH6gzrKz+uBicDzpaNY4uyDwIsi2f+mf0PQUq
         wAH4lcO/ZkElawUEDnwCrKkhiC0o3FjQ0XkVZWHiunyglsCOp14vmmevG8x22ckqfwLG
         6u9JIIK98R0sy7kx1U2OKQeAL2+eONMilbtpD+CzrgjfSStp5uY809+zx2Wv3pNDygmp
         2wYfeeAiBB9uxZkyGYJ4Fh6YPlR0CwEUkhCYz79iFEtsHdAZ90558FMEyivs+47Zx2/i
         NOaIZOP+bOmnUqFHUfBlUltpGHNpXoFOlNMROHY3PhrcT3we5+CA0Okrac09DjX7onMM
         JFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717252; x=1784322052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqzV29M/TfqY8poEDBrz7krImCgB8mIlNT5MO3ZgoJ8=;
        b=oUpFLJXzOz8CpQOL3InXSrijOv6/J4XZcO6FBtgl+U/CPlxE19uCkDXndREwc23ckj
         ROSPhuv1pPF9EoqFeEFUxW3Q08w0TbILhpbsdDOazHH0AK95rixZRE8vEdUWu+JvUm6M
         jPVcH8zuT+nbz0wxfKi+VXmLa6YUfQ5St4vqjF7ywSxPQVWEHiDzWBVEzR79HVaCt5SE
         cIV1MUI5KVG05ADzduNV5hFL2VRo2Fgl9rrrnDOI8+wfCiCoLeJwQI+jASxNAzxEZIut
         UoD4RbNV3xYHDMe0oDA1KCgDPmSE7FFEsesRaglKZutFAofRuOHOFgZuC9HPMbtnH/HN
         z/qw==
X-Forwarded-Encrypted: i=1; AHgh+RpEbrf8E4XTz7LFAsNovJEq3f+RPYJPc678+9I18ur8TCVUshzI8UPcnHkKCe4EkkfymDQQIpWL2UVGl5NavXg2409n+YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKruW2juFRTuGDPCu2d8obICDgse5EGq5BTq1zu/Xyrb0/hJzH
	jQAn6f7MW/aV95oWSuI6aLxm2duKmrPcIWJzzS+9cGw17kaG3+QQNLGvBrAv2DyV2zUogtpGuUF
	Mx4cTgvxXs2ACO4M0fDlNM96CpgmQU+lv535Ra2Tq
X-Gm-Gg: AfdE7clzFKZQCk/GSD9yeTBeF5DnRXQwCk3FZRXCZ3kUq8vzMafJoLwRDg5kmD7jgkO
	8ycH0bQi+La7DuGPSVNGPfljSwTOoOie6JoPSer+usyzV/PHgLTSHhUvJ3pLXlEBcuL5mcKWtCi
	DlNKCeJWI3gZtxNLe7MP9SfWMBIp3OdRxK3Nc/LTB3odAgZFwgt4x5m8Qg3W/B4fvG5d5wr/3KJ
	0F4Aq+6loPhYlDlISoerScdM1MuHFG31Uh1yhUXYrsD6Vhx8z2IVGz/beGcHquVmqqO8SZX
X-Received: by 2002:a17:903:2f82:b0:2ca:16:c169 with SMTP id
 d9443c01a7336-2ce828a0820mr40343645ad.12.1783717251507; Fri, 10 Jul 2026
 14:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MZlCECz5s73hPgQxtqWZ2VbXNTCZnItnwMHu2iZQlRC6ba0B9GuqxT2EhvhwQ-uanBDsNn7Bg09nGVynBHdmSsiRjhyI1udkYbqOoPfpe6w=@proton.me>
In-Reply-To: <MZlCECz5s73hPgQxtqWZ2VbXNTCZnItnwMHu2iZQlRC6ba0B9GuqxT2EhvhwQ-uanBDsNn7Bg09nGVynBHdmSsiRjhyI1udkYbqOoPfpe6w=@proton.me>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 17:00:37 -0400
X-Gm-Features: AVVi8CelOVkwsnAMfu5Dx1B7_PEB-pnfELgYLYT_dts7Hvyr4wbqu6SLxvOLeqA
Message-ID: <CAHC9VhSWs4=-BN09XWUsJXh+9HB5zeYa0oiRsRNGb4s_sTW2HQ@mail.gmail.com>
Subject: Re: [RESEND][RFC/discuss] memfd_secret(): opt-in visibility for
 security monitoring (eBPF/audit)
To: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "rppt@kernel.org" <rppt@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:14=E2=80=AFAM BoxStrikesTeam <BoxStrikesTeam@proto=
n.me> wrote:
> Paul,
>
> Thanks - I found the Gottsche/inode_init_security_anon() thread and can s=
ee it landed. That answers (a) cleanly: labeling exists, policy can be laye=
red on top via SELinux/AppArmor if a site wants alerting on memfd_secret() =
creation. Good to have that confirmed as already solved.
>
> On (b), let me push on it a bit further, because I think it's worth spell=
ing out explicitly rather than dropping it.
>
> My concern: as it stands, an unprivileged process can populate a memfd_se=
cret() region and mseal() the mapping, producing memory that is (a) unreada=
ble by any kernel-side introspection path, including root-owned eBPF tracin=
g programs, and (b) can't be coerced back into an inspectable state via mpr=
otect/munmap. From a host-based detection standpoint that's a blind spot an=
 attacker can use to park a payload where a CAP_BPF-privileged monitoring a=
gent - something that in most other respects can inspect any process on the=
 box - simply cannot look, no matter what capabilities it holds.
>
> I understand the objection this invites, and I want to address it directl=
y rather than pretend it isn't there: the memfd_secret() man page is explic=
it that its ROP protection rests on the absence of any in-kernel primitive =
for reading this memory. If I'm reading that right, the objection to (b) is=
 that adding any such primitive - however capability-gated - re-creates exa=
ctly the artifact a ROP chain would want to call, undermining the "no primi=
tive exists" property regardless of who's nominally allowed to invoke it.
>
> I don't think that objection is wrong, but I'm not sure it's fully dispos=
itive either, and I'd like to hear the maintainers' take on the tradeoff ex=
plicitly:
>
> - The ROP threat model assumes an attacker who already has arbitrary kern=
el code execution (they're calling kernel functions directly). If they have=
 that, they can likely already walk page tables and reconstruct the mapping=
 by hand - the primitive removal raises the bar, but per the design's own c=
aveat ("no 100% guarantee"), it was never advertised as absolute.
> - The (b) scenario I'm raising is a different actor: a legitimate, privil=
eged, kernel-mediated monitoring agent (eBPF LSM/tracing program) operating=
 through the normal verifier-checked helper path, not an attacker executing=
 arbitrary kernel code via a ROP chain. Conflating "any code path that can =
read this memory" with "a gadget a ROP chain can call" may be overly conser=
vative if the new path is narrowly scoped (e.g., a new bpf_probe_read_secre=
tmem() helper, verifier-restricted to CAP_PERFMON|CAP_BPF programs, opt-in =
per region via a memfd_secret() flag the owning process must set at creatio=
n time).
>
> If that distinction doesn't hold up - if any additional kernel-callable r=
ead path is considered equally exploitable regardless of gating - I'd genui=
nely like to understand why, since it would mean the confidentiality guaran=
tee is fundamentally incompatible with any form of authorized introspection=
, which seems worth stating plainly in the documentation for anyone buildin=
g EDR/monitoring tooling around eBPF.
>
> Even if (b) is rejected, I believe explicitly documenting that memfd_secr=
et()+mseal() creates an introspection-proof region would be valuable for th=
e security community, so EDR vendors can adjust their threat models accordi=
ngly.

To be very honest, I'm not too concerned about out-of-tree, security
products; I'm focused on the in-tree kernel code.  If you are
concerned about userspace making use of memfd_secret(), you could
block the operation on a per-process/domain basis using either seccomp
or SELinux (other LSMs may have similar functionality, that's an
exercise left to the reader).

Also, it is important to note that if you find the kernel
documentation lacking in a particular area, I would encourage you to
submit a patch to address the shortcomings.

--=20
paul-moore.com
