Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DD32B123
	for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802617; cv=none; b=iMGttvBRIM8Lwyj9lPX/f5gKrmMmgY6wy1qqffj6aNvn/uql5bcl1tJR4j13ysqZvqqxGUswdHEt1zQ2B9VetOqwzkf5ntV5czyi+uVuer5Rr4KSCeMYOAHsbsmSWViXKglXQik/xwduz3mrDjfcNx/T5V/EPZylBPLZmO3LhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802617; c=relaxed/simple;
	bh=xByEsDq77aq1mjC+sE081lytrYyrGP6yec4SyBZ96/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qvRAj9Mqz792J+J/Gg63Ewrkht1OLqm62P+4ZFV5Mt/V+OR+/hHLfyUUDFScKVeiaDm12BNS5UDK4vy7UDxn86P7neanA1H19Prw4zsTP9KXWl1tiEA6jtesaIvgARtx9OmohL/5g6jvgWOFMr7Artk2waMMoIyvuO4CvWz0jBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATa1CX6V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATa1CX6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785802610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5xAa6RBMhwgEch+Pl7oGtOo9pFaryzhZJe7EILEPh1o=;
	b=ATa1CX6VTeuaXQhq4NkFx2OFRsqaSJz7rIkcU7YiGSp+l6bnjZOy531wlZA1jNiu7AxDcb
	ibFx3U9pGJR67JhBMjB+vCZWPxd/yKY7X78YM3KNxaogEMXdD/jo3EfYwTcasQcTa2mZfT
	41ZFIFzayK5pvsLK97jTC1ETK0md4+E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-SLJ1pvlnNBub8gLpATO8ig-1; Mon, 03 Aug 2026 20:16:43 -0400
X-MC-Unique: SLJ1pvlnNBub8gLpATO8ig-1
X-Mimecast-MFC-AGG-ID: SLJ1pvlnNBub8gLpATO8ig_1785802603
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e71268bf6so19896747b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2026 17:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785802603; x=1786407403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5xAa6RBMhwgEch+Pl7oGtOo9pFaryzhZJe7EILEPh1o=;
        b=LkPEhfeSwAziqUJ9iKtZnCVnuIra/RgMuCLnv8IMNoGhH5hh2m2Q6T3cXReepRDBN2
         s+MhXwSTp21xTZFJ6L8u1iCxZjgD8wlWV5C0+417pqTOaM1uvV66HixjgEHKAzUtyARf
         77TaESoXl2IliBGcxekjLOhX4E0LN9cgfxJki9gLod5C4AlXidYWkHgXw3gcSpsFLLbA
         9PwKtXdWldEcwc9iqBuUT3KPHej1GNHtQqL/aKm4Nb70G1m1oH8X57sdKPz3TbrmEVyB
         2k5utpNgo358nl/qABIdMuaVhfY/IqqXxWfDeJWlUyqSpNlXV5fEILMjZlh0kAXQXn+j
         renw==
X-Forwarded-Encrypted: i=1; AHgh+RrntuTn0gM2+a/DaZXHKBpotOZs1b9rITmzLvhcib8YqlyOuUkxioT0AVFMMuHECqJQsxBygotLVXMLNQhhc84z/HS7Fng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1C1annOYSqcONjCRAjkha+c0q2I5XaRSfJIDr2kawd3Pxi0O
	4KiVn7zd2xkQkGqGtCteqYZQNOxXxjdhJB1vi9op7+LShqODgg6WAlxvg8n1v4Hl9jh+8pNo/Sk
	329MWcc6epHWZmUq1frPGf1AKBuOO2oder+n76wRUg9/rskWivcLWZvi1RT0AedeIn6h27IYDBm
	J7CwVJA14SMWAAKLd3N/Finty3yT2PALK7rYtQjRL3nX+MyLDhJ9igN0aW1Tkk
X-Gm-Gg: AR+sD10SIKSX5IbzOJRRBx3Ro4usyWCoghENvbxRzmHEmXx8XoEIkMYm7+GOiPOvlKS
	0RXHI6sfVNbvuwuFQsmsBAMSnCBPxg5/tk3yPYjsnqEC6gj3IOfIdRVNKhiuvopBfthDP36yYpi
	2ShXPnPqISB+KDgC3Wn+R7PbzVwppzrqLejypsDHbrxwIm0d3eNowajCIMVzAJqcKstN2hP/eNE
	XynkpKgs4xCPc3YyQ==
X-Received: by 2002:a05:690c:ecf:b0:81e:695b:585c with SMTP id 00721157ae682-81fd49cbfb5mr165889577b3.4.1785802603024;
        Mon, 03 Aug 2026 17:16:43 -0700 (PDT)
X-Received: by 2002:a05:690c:ecf:b0:81e:695b:585c with SMTP id
 00721157ae682-81fd49cbfb5mr165889257b3.4.1785802602583; Mon, 03 Aug 2026
 17:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiri Vozar <jvozar@redhat.com>
Date: Tue, 4 Aug 2026 02:16:14 +0200
X-Gm-Features: AUfX_mzTp9xEoeY1jgKdDtVsQZjCnRf1n_drXzmhsKQh3-QCRgmptscpHaU-KQU
Message-ID: <CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com>
Subject: Subject: [REGRESSION] selinux: ~90% throughput drop in System V IPC
 (msg) since commit 7edea6e8c8e8
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jirka Hladky <jhladky@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XVRwP-MfRskfESpQ0lQi3AvQsaUeDQYkG0BZwRmOxqM_1785802603
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Commit 7edea6e8c8e8 ("selinux: beef up isvalid checks") introduces a new
loop in mls_level_isvalid() that causes ~89-94% throughput regression in
System V IPC message queue operations (msgsnd/msgrcv).

The regression affects all architectures (x86_64, aarch64, ppc64le) and
is independent of SELinux enforcement mode (enforcing vs permissive).

Upstream commit:
https://github.com/torvalds/linux/commit/7edea6e8c8e8944e060da6b0b81d66db8d=
5fffcc
Merge commit:    https://github.com/torvalds/linux/commit/231e9d447ea9
(selinux-pr-20260615)
First affected:  v7.2-rc1

## Regression data

Measured with stress-ng msg stressor across multiple machines and
architectures. The percentage is throughput change vs a v6.12 baseline:

  NUMA config | Max drop | Avg drop | Hosts affected
  ------------|----------|----------|-------------------
  1 NUMA      |  -94%    |  -91.5%  | aarch64 5/5, ppc64le 3/3, x86_64 6/21
  2 NUMA      |  -94%    |  -92%    | x86_64 5 hosts
  4 NUMA      |  -94%    |  -90%    | x86_64 4 hosts
  8 NUMA      |  -89%    |  -89%    | x86_64 1 host

Architecture-independent =E2=80=94 confirms the regression is in the kernel=
 code
path, not hardware-specific.

## Root cause

The new loop in security/selinux/ss/mls.c mls_level_isvalid():

    ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
        if (!sym_name(p, SYM_CATS, bit))
            return false;
    }

iterates over every set bit in the category bitmap (~1024 bits in
standard MCS policy with c0.c1023 range). Each iteration calls
_find_next_bit() + sym_name() (array dereference into
p->sym_val_to_name[SYM_CATS]).

The function is called on every IPC operation via:

    msgsnd() -> security_msg_msg_alloc() -> selinux_msg_msg_alloc_security(=
)
      -> security_context_to_sid_core() -> mls_context_isvalid()
        -> mls_range_isvalid() -> mls_level_isvalid() (x2 per range)

This adds ~2048 iterations of bitmap scanning + array lookups per IPC
operation. SELinux permissive mode does not help (~0.6% difference)
because the overhead is in the validation path, not the enforcement
decision.

## Perf profile evidence

Single-threaded stress-ng --msg 1 -t 60 on x86_64:
  - Baseline (v6.12): ~67,000 msg ops/sec
  - Regressed (v7.2-rc4): ~7,400 msg ops/sec (-89%)

perf top on the regressed kernel shows _find_next_bit and sym_name
dominating kernel CPU time during the msg workload.

## How to reproduce

On any machine with kernel >=3D v7.2 and SELinux enabled:

    # Install stress-ng
    dnf install -y stress-ng

    # Run the msg stressor
    stress-ng --msg 1 -t 60 --metrics-brief

    # Compare with SELinux disabled (requires reboot with selinux=3D0):
    stress-ng --msg 1 -t 60 --metrics-brief

Expected: ~67,000 bogo-ops/sec (as on v6.12)
Actual:   ~7,400 bogo-ops/sec (on v7.2) =E2=80=94 approximately 89% drop

The regression affects any workload that uses System V IPC message queues
at high frequency. Other IPC stressors (sem, shm) may also be affected
to a lesser degree.

## Suggested fix

The ebitmap_for_each_positive_bit loop validates that every category bit
has a corresponding name in the policy symbol table. This is a property
of the policy itself and does not change at runtime. The validation
should be moved to policy load time in
security/selinux/ss/policydb_validate.c (e.g. in validate_level()) and
removed from the hot path in mls_level_isvalid().

Thanks,
Jiri Vozar

