Received: from mail-ed2-f30.google.com (mail-ed2-f30.google.com [74.125.228.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDC82866
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866329; cv=pass; b=e5LLKPHBdCWDHgiGL+q5wBEBBnSMAc77K/2+adm4nTY7VXS0VvfKOh2d04MGqT/roDoRSGHOvhJVv7R2SZHM7kgPDXcWkc4LnEpVhj5ld5kH7QVpBI9iwa3iB3NYM3LL46qHwOGDhdT10qlb+hgO/+Mcb1/km408fgRXmMKnL+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866329; c=relaxed/simple;
	bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pzh/n8KLbocYPrw4B5B8fT8mtHAmUQLfzBovRxMKD2XBwzqIvtLitLFkFGa4It+30VMPi3IVUv1PhAWZNNeefrawPLDhX/aKctCdbjLKp/58K4TvHOw5SRWGopDIDQVKmRVylK2Id3GMMFIoj2lWKSm4RQWQlJ3ZHdfJm9r624Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkcUQQqm; arc=pass smtp.client-ip=74.125.228.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkcUQQqm"
Received: by mail-ed2-f30.google.com with SMTP id 4fb4d7f45d1cf-6aa06e51bc3so3176275a12.2
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 18:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789866327; cv=none;
        d=google.com; s=arc-20260327;
        b=UtQw/r2wKR8VUmB3J6Kx7DhefzSxNC649n/t11oJeDsTa3zY27NdUAkV3hIk43o5jG
         L4ICGKsBKNgNluH2cidU/t1sb9lfCXC3xs1mwdHPoF2hXt/qtzHsDR1afIaj0kcW/4vG
         FC9cos9Vu4Fzd82YkKYZK60PioUJAideFK8ZHQYfpdMaAtXtCZ6aKl5RBEm7BVr8SK2o
         p9MAQfSyMYz1r65uH0bcBicwJ3Te0Sa71a1jEXHFv7Slm9C9QEpx6JiSy9qBDKFrqtvp
         fagpr2mGCMDWSm4M5IT2QjR8KT6HDgWkoxm39LtFX8IgTTak31kuOl+KlWso2A12unQk
         nmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
        fh=pOHn8TkHFejXkDE1ORfV2qrAzZm95uVchfx7g8VwDHc=;
        b=Tc9LSu7W5hHKlQX7W3S7/uEwU2eIuLRCSrnlDADXtRsAC4KDMKBpLSgk9jydsjJceg
         +GVEFLRPbw5sGFNpjdAzhWVNRsVauW3hU2kMYiVrPST/sRd/AdRBphonHSLTPQE49hbc
         1day2ObY1mS8pkvF9sWKpHwkEifZjBLbSevGU2NoMrluLy8xd4FEgk3XnJS1LeK6Gt7o
         +PPz4cJW+1bAk4sikHiZkdUjyjBLBbARhNkKvu8X3K/DTTe2H2i+s03NsG3w8t8MoaZ4
         y7zqZyHjbaew+F9rFm8r0tHLXHEA4eSm0bsT+5Pq8l4EwLvFYFn3xW/tKDmneCO4taV0
         1jDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789866327; x=1790471127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
        b=TkcUQQqmrXmajigL4ymUVXzgVzMfgsfniiweC8zQ4sDe/TQMRpnmaiZFRz7RnRR+rE
         agbH+5wFbgo4yYfMpx3mdH6C7kSiwdzQN+UqAaV5UTHrXK9VS0xVqtUf5uj+hi8667sI
         FlY3D4pPIpXU8TNxDlaeStNl7TVU8I2UHaL+0skLYh/4YP6qp0pw95eUM+7OtATga0Vi
         CIMK4By0WCJbhaTTgbmG2SuWh35/tG4XsEA1gp6Lo5l+pQi3U0Iea89hcqp9LSlcdO1d
         cBj9UkduyO2NbygdLz4NO/NHkUv6Y/auoBVFZb9wN3eprZKbtV40W7ZJlRCnVh9UoqAK
         krVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789866327; x=1790471127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
        b=hnmn+PFgA07woshsNdHmPtJlJn1rYpYRVbljpu01vTnFClN9vSuPArEvEyfq52cz0S
         Y+T8NwBuNODO8fJdnB51p+WwilFUTMzw7yzgSZb35zKRYnXtv4gMisst9S6Cihj7TEvT
         SLCdouBSP9DGZcOY2xOVZTBPV8L5vAW+KZhOdjR9R7KWjz2j8gkhc4ZMEd2sd25ANLhw
         zuQRuGa7I/H+4EbIP6g2RlGJeY8kfHDtzhyVHiwpCq+ODOUCzx6SKas5DYh/HmmCmAgW
         XWapGawS/EYWokFeDpdPGhTE2rBRfju7ae8HCcMFz6sel6T8GjjrNxRoMoyAuuUIFdrn
         yxNQ==
X-Gm-Message-State: AFuF++lFeXEMGB41956Oq+wxFBm7MOIUR3WmU/5SZ3Q2Z03A9HKXcZZ4
	U349NxgUCPWz+RUzc2YwcZHftkgqRUj98L1u8jfSIJm+MnJE23i+ZqKvSuDIW6MkduV2g8k8HK9
	/camv0RKVyF2c/Q+ePJbtM3uUeu+oihJsM3Ak
X-Gm-Gg: AYBFou1sPS5bws6wvvov4rFK1MvsjGLveZAQgO0SSN+E7OUmqlP7xQ93XtVzeDQxe0W
	iPttAp/iIjG2W1sD2Knluvg3k0gkRl5AoLl3z9E4ZfKMh9OCUhfYai+5I7/Qs2r3GzwVb/xgrFl
	VhYHSX56oSqvnOymaw1QlWFGydlkJ26qCheMkiNhB3X8hflc1kzpOfrKBYxf2z7PWSYXLC66Gcm
	HW3svbs7DGkwHr5I4aXHL2/iHdN6FlGWSMp5zXS80KUNGuwsSz5NTdOH2YrGCyqCFIlFCagyMjD
	TBwcEHVnhaSyNT+6xDTHLaPn0xMBapjldH1fmndD+gaa6XpFInS0Ug==
X-Received: by 2002:a05:6402:4150:b0:6a6:7d56:7977 with SMTP id
 4fb4d7f45d1cf-6aa5686e419mr4607422a12.22.1789866326378; Sat, 19 Sep 2026
 18:05:26 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 19 Sep 2026 18:05:25 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 19 Sep 2026 18:05:25 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Robles <erobles3224@gmail.com>
Date: Sat, 19 Sep 2026 18:05:25 -0700
X-Gm-Features: AcwNN1XJoucD_suv2L2FflovLq3kBi756l3AhDrFl5_waj8s73I6QDvJXyL4hvA
Message-ID: <CANBsAxr6=Q2AB-NOEGyZohEXt7F_3wMzi5O8yw=fEUmuj5zFqQ@mail.gmail.com>
Subject: [RFC] bpf-lsm: scoped one-shot userspace authorization binding for exec
To: bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello BPF and LSM reviewers,

I=E2=80=99m requesting review of a narrow BPF-LSM authorization pattern tha=
t
is already running as a live prototype.

The problem being tested is simple: how can an external userspace
authorization decision be bound to one exact exec consequence so that
the kernel enforces the final allow/deny rather than merely receiving
a post-execution log?

Prototype flow:

1. Fork the child and stop it before exec.
2. Resolve and measure the exact executable: path, argv, device/inode,
size/timestamps, SHA-256, running kernel, and active LSM chain.
3. Bind those facts into the userspace authorization decision.
4. Only after PERMIT + execution_authorized=3Dtrue, re-check the
executable identity and write a short-lived one-shot BPF map grant.
5. Resume the child.
6. A BPF-LSM program at bprm_check_security matches the governed TGID
+ executable device/inode.
7. Matching live grant: consume the grant and allow exec.
8. Missing, expired, or mismatched grant: return -EACCES.

Live result on Ubuntu 26.04.1 / Linux 7.0.0-31-generic:
- authorized governed exec: succeeded
- governed child deliberately given no grant: denied by Linux with
EACCES before exec
- BPF LSM active in the live LSM chain
- governed / exec_grants / events maps pinned and active
- 25/25 local tests green
- 6/6 adversarial ProofGate cases green

The review question is specifically about the kernel-facing binding
pattern, not about moving the external policy engine into the kernel.

I would value feedback on:
- whether TGID + dev_t + inode is a sufficiently strong exec binding
for this pattern;
- remaining TOCTOU concerns between userspace revalidation and
bprm_check_security;
- one-shot/TTL grant cleanup semantics;
- whether an existing kernel primitive would provide a stronger or
simpler authorization binding.

Linux-focused repo:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate

Live proof:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/LIVE_PR=
OOF.md

BPF-LSM source:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/kernel_=
integration/scqos_exec_gate.bpf.c

Userspace launcher:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/kernel_=
integration/scqos_kernel_exec.py

No claim is being made that Linux itself was patched, or that every
Linux operation is governed. The proven boundary is explicitly
enrolled process exec through the existing BPF-LSM hook.

Assisted-by: LLM

Knowledgee KZA
http://SupremeComputation.org
