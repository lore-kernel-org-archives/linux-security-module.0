Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD01B4138
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264685; cv=none; b=c0O/S7gpWYpn/8HwqNx5b3S/9BQFOT9U0lPmTU5uHJncxacTwwywTr03Yxz3gLiVzCpFXZoq+0azIvQ8GK+Yvb5/QgHMWesHYALQ2N9A48DCjDmbZsJ4COyvK/O9fraMHXdW6YW1yH7NTPCGW5jQmyPpOEYeDXRgept1phtiBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264685; c=relaxed/simple;
	bh=c83sDHtMZGgmWT39aIisxMkV8QZsjptaj9QxOf0Cuwg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e2BoBkgJJVkUZUPRO+Ud6mMImURcfv5Rb0AcpdAytaOyJTt8aEEI7eNKMicBnIJVnmRqqqILWvmoSkZSZt9OJ9sqLSyw5JN/BQsZ1aUW98Z1tvSg8XRp0njL7GrvihGAVPjk7pVPS0TLdTqYOfGE2Z431d/C5LU3gjwkXX9CYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RrwUEm0z; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RrwUEm0z"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4138136f02eso254964fac.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773264683; x=1773869483; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lT7OY2GNLRRTQ6yGPrWNzwOwj8gZsZvwkTPkyqlRx3M=;
        b=RrwUEm0zlX76Y4puZsOOpjHCew5NbqPdFe6kLaxHJ9mJrehQi97DVp66KjKq5+fqIr
         AESzaBKIjhNLiqMVd0vwjbY7Fz4/zZJJ/x0ctTjr5mfDoleWslEQH0SyDJoRNzzGLoMC
         48Gml41tTC2svXh0BgoWOQjA9elqZsco6jasZSrNISnt3eYtT59DyXbifIOF2gYtfa5p
         z0PoKVjnD20C5cm/NeTWqAXY1oG5P9Vy8333QD15tLbBBQsrfSxxCu2+jdAhxUG9kOLY
         kRiNO5SV979EliJWMRrCGndV7GFpI611XIV1vvRar3/tUloR5i4mkh4166SfPpCRbvH/
         bpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264683; x=1773869483;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT7OY2GNLRRTQ6yGPrWNzwOwj8gZsZvwkTPkyqlRx3M=;
        b=Ze18piipiGQ0Tf+MrylhOrNB0FgpNcDZvxjIvmKPtpjZwTIT2GK197zIwe7q8QM+JO
         Z+Tw0oD1QjN3J5PfzpRSM1ZHZLz4AUYM5cW86vVvHO1i1UUB7bgxygWnhrbWw+hfP5d9
         GuPgIiAvCVmDDwV3gpl6BsYmH8KFEIPsHPheeYuDyf+D9/3Ev1S0+02LNv7oIZxaxYR6
         LqlUN/tjPGsB3vaFpyvOHDWLzWZP/4bwntlH2eNGsrGzWudd9CeqcvdU4p1jMyMUfpcX
         FU5aV75aXOzU19ATFtk0ipqBnWrgU7HVT0v7wQLK8O3rXDNJ+vL+ipAseMl/WImMAei7
         dtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn6qefa6FWdge5uMAHWJoYdnAR6SGuboCWEDgJQJw1znAEfWPmucXjsOuzUVCtBwHwYcWpsS2ZBAqR/Ox4GpTa1g+Yr5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxmdB9ICqWtlsuYOoGDVldOd6KR0K84EzmzebvBXyh587PR/d
	WRa91/71vintnv0p/y2RgPyJTbDb8ESvuJH8SPQhHv668aS2Nmi3fOUVIVzEAeQ1LeA=
X-Gm-Gg: ATEYQzyCAvHMMT51F50ciwNwPav804UkWRxhoFMiKzTEHSduo4AE9dmvG9pGGnnENqZ
	4Gmqw/1Q/Gr6br+D620qr+WGGJqITIhzF2RMlGTFEOvW5Ad+LJvUqvoWtwJtvsecU+JPPkxL2zl
	TyRHXqRceF2uDumQJ5b/AQfQwaD4gGU9XzDknzJg/1Xj6DtzR4neQj4wqVfKj/Fy0bywV+O5wAh
	jryeDT7aTQNn0OVWpfUAElqx9XAOhD5Slj4gbSSIvhtTnvKluLFeiZWwW2ovq/V5NqQ3LdMdVRN
	IFRmCPWe0bmWDkb6mFzsh+J2WKpDY6lU/z0qzVn9Cj+w5+8PhY7ofUO7W6jXZ1I5g/HX5sM22ks
	vjuQw1ICGMZTVBU3/meg7rLQNDh0rQhr2if0gAHD//sE43eKQQ7b09a8npwr8rTWhiZYqU6XDj9
	+VzhJtmZI=
X-Received: by 2002:a05:6871:c8e8:b0:417:4d3:1751 with SMTP id 586e51a60fabf-4177cbc0afemr2554702fac.51.1773264682724;
        Wed, 11 Mar 2026 14:31:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb90csm3530413fac.4.2026.03.11.14.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:31:22 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
Date: Wed, 11 Mar 2026 16:31:16 -0500
Message-Id: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACTfsWkC/x2MQQqDMBAAvxL23IVoqw1eCz6gV/GwNmvdg1GyK
 oL498YeB2bmAOUorFCZAyJvojKFBNnNwGeg8GUUnxhym5c2swV2c4+0elk8KgePI6tS0h7k3N2
 WT6LOQarnyL3s/3MD7/plrjDwvkB7nj+1WrsudwAAAA==
X-Change-ID: 20260105-bpf-auditd-send-message-4a883067aab8
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 audit@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4248; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=c83sDHtMZGgmWT39aIisxMkV8QZsjptaj9QxOf0Cuwg=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpsd8n9jExOwY7o7vGO2DRL/PAuhexDPVJt7YTU
 J9BUtH+/MCJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCabHfJwAKCRCrJbR2A5LT
 bSiQEACPtWTnlmslusEnuOQDnGDS4N1FtR7aFG6hDI7yVEwaImE6tXGY+mSrd1YI1Zx+ZOhgdff
 5GWPT8Y2SdW9MCXBYuKAueFZWHxjvvYuKimRdPhmZ1IeIoNVsUEgY6+V3o1md+ZCF8v04xyjFAV
 kQdPCLhT2v0AgnDm1pIfVg/RqqreoZU6f4brM2tfC0S2dHy8HPP455izuXCzz4Zp8dgbwifdvSs
 0f4v4E4KqMbDISxrrgKjEUiZoyaUOoP5LAtSiW7asJQp7+2qBtFRuQnSkXlkQGWSJf3lckuzFlc
 Ifd1x7TvTyT+98QJ33TdXN5JFeI5TKtO8UUG5PjikHSJ5MvGk+a/UWj0QlJQp+7yYUDhxfTIjZp
 iKdsmll/RLcBA3RvNLN40ttiowey43rAvkQEG7DfcUgRwyPIIwH5Lf+/u5XndHACqcXtSqYXFGU
 61gMi3RKoQJxP/BXomczV/l5dz7r0G6NwOPE7XBG1Iq7I9wG24weoA5S1gnAiR2queukCYJgJHv
 eQ0co8fwRCrpcZYd7IqaKVjTxRJJH9r9AiiyBgLOxRmBUX4G9h09WE3xXYQKlsyhQ5NsIPxUt+J
 8Yryhoc2ZQasaMZh/uA7CyVK8ZAcHS8pa2VPEaTLLpPQjAEyBF8VBocT55GvBVcZ0ayioCL8B/s
 MloN+OPwk/6rXpg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

The motivation behind the change is to give BPF LSM developers the
ability to report accesses via the audit subsystem much like how LSMs
operate today.

Series:

Patch 1: Introduces bpf_audit_*() kfuncs
Patch 2: Enables bpf_audit_*() kfuns
Patch 3: Prepares audit helpers used for testing
Patch 4: Adds self tests

Documentation will be added when this becomes a versioned series.

Key features:

1. Audit logs include type=AUDIT_BPF_LSM_ACCESS, BPF program ID, and comm
that triggered the hook by default

We wanted audit log consumers to be able to track who and what created
the entry. prog-id=%d is already used for BPF LOAD/UNLOAD logs, thus
is reused here for this distinction. Though, it may be better to use
the tag instead to capture which _specific_ version of the program
made the log, since prog-id can be reused.

2. Leverages BPF KF_AQUIRE/KF_RELEASE semantics to force use of
  bpf_audit_log_end().

One side effect of this decision is that the BPF documentation states
that these flags allow the pointer to struct bpf_audit_context to be 
stored in a map, and then exchanged through bpf_kptr_xchg(). However,
there's prior work with net/netfilter/nf_conntrack_bpf.c such that the
struct is not exposed as a kptr to support that functionality nor is
that supplying a dtor function. The verifier will not allow this use case
due to not exposing the __kptr. Ideally, we don't want the pointer to
be exchanged anyway because the reporting program can become ambiguous.
I am sure there are other edge cases WRT to keeping the audit buffer in a
strange state too that I cannot think of at this moment.

3. All bpf_audit_log_*() functions are destructive

The audit subsystem allows for AUDIT_FAIL_PANIC to be set when the
subsystem can detect that missing events. Further, some call paths may
invoke a BUG_ON(). Therefore all the functions are marked destructive.

4. Functions are callable once per bpf_audit_context

The rationale for this was to prevent abuse. Logs with repeated fields
are not helpful, and may not be handled by user space audit coherently.

This is in the same vein as not providing a audit_format() wrapper.

Similarly, some functions such as bpf_audit_log_path() and
bpf_audit_log_file() report the same information, thus can be
interchangeable in use.

5. API wraps security/lsm_audit.c

lsm_audit.c functions are multiplexed and not handled by BPF verifier
very well, thus the wrapped functions are isolated to their sole
purpose for use within hooks.

Key considerations:

1. Audit field ordering

AFAIK, user space audit is particular about what fields are
present and their order. This patch series does not address ordering.

My assumption is that the first three fields: type, prog-id, pid, comm
are well known, and user space can make an assumption that other
fields after those can appear in any order.

If that is not acceptable, I would propose that we leverage the struct
common_audit_data type order to be the order--much like how the type is
used for log_once() functionality.

I am open to other ideas.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Frederick Lawler (4):
      audit: Implement bpf_audit_log_*() wrappers
      audit/security: Enable audit BPF kfuncs
      selftests/bpf: Add audit helpers for BPF tests
      selftests/bpf: Add lsm_audit_kfuncs tests

 include/linux/lsm_audit.h                          |   1 +
 include/uapi/linux/audit.h                         |   1 +
 security/Makefile                                  |   2 +
 security/lsm_audit_kfuncs.c                        | 306 +++++++++++
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/audit_helpers.c        | 281 ++++++++++
 tools/testing/selftests/bpf/audit_helpers.h        |  55 ++
 .../selftests/bpf/prog_tests/lsm_audit_kfuncs.c    | 598 +++++++++++++++++++++
 .../selftests/bpf/progs/test_lsm_audit_kfuncs.c    | 263 +++++++++
 9 files changed, 1509 insertions(+), 1 deletion(-)
---
base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
change-id: 20260105-bpf-auditd-send-message-4a883067aab8

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

