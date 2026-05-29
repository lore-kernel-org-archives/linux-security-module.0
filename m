Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41160361DD0
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025546; cv=pass; b=oKVRMkxtre27AZiJO/1Bx4dIGjx/0G7twHbMbWgoiBaxNSCHReoDH50AlApO7s1J0Ph9X1W+QPKxb5Baagbw04uHmh21udLwnBwUu7si2pmSx7GyovRrOYPeeS5vl8rt+WxYl63Ik7SYoyw1TgANTZGhQoP4I6kIS1niopx45gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025546; c=relaxed/simple;
	bh=0b3RB4nilJEDI7FKqXxZUGi9ynMM4tiYiKgrZZLgSfc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GQed873wF+1ugHNHa3ZkbwMTBcsbiRWkohSmnOy7cUjWLybNZWqA5PuRVPbzbTWgVpZXuGFG8t3tHRARRgQp7VgnAmzwop3UT2pnLoR0PonyXQGpLuieuhOmf9qGPAl+12+m7N4LuEEKHrVd63IePjpGhyefTNUJ1eLMLObw7r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=V78+/c4m; arc=pass smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="V78+/c4m"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7ca947f9b00so132604697b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 20:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780025543; cv=none;
        d=google.com; s=arc-20240605;
        b=dWBbMRGQcXo9e2cNXb5EYpf73uD7OOHPpCWwjS4fnHkYzYuDQH/zp4TVARtbbO/lKt
         qWFAQpqG6zoA+Cdvx33xJl5dMueOOXDbdCwPgd0LZ1GjTAwvIQ1XRF287lhFWjU8qbiI
         +aF5o9Jp/GsGvI8+33mgI7Kb6qnZHdGx1xxkpj1fgBoQyTqNQtAoDVA1mL/cL0JVAT2b
         K9J+rAs38bDutwU0u4+mSM/aJyDJhhQ2WdWq8Hro0EwoTkW9xl7lYPYnmliD+V1b9wyD
         Y+lGfcackOX6HfMDeqGFUUyZEuzuKXyG9gnApEvHwq3VwFFOeS/69sdQ1iLnvSJzGuNr
         hhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RBqWfCykUL5nrF8ZUl4yEg+LbTO9fGjmXMENdlsBnXg=;
        fh=gouKRaLnyTfLCaOeP3g0JkSNNjZgG3aQSN5qjLAvNmY=;
        b=IGl3Ul/+2OXulQEfPusVNwhQjM4HfJc5lkZCITfE+/BOEv8xjYKy1S3o0khPnhHz2K
         MiyoXtZB5+Vl94OoZ/FLJivG6SVx+uokdindIRBlGjg8wsLGIC9FFdNQQ3/O2IqpnGuq
         X8Ha3eLDz+5b9KdJNSUHWkkziaDgFWxbdku1Y+kwP2HVnsawRuYtyYtvaEZBpL1x0Sz4
         74jJi9FF6H5E2hWbzi/upHCc7iF6nO5x/o+WOO0kuvPHxCpowv3vTx2djEHc1T2AgBNq
         E3Y5QSFs/4m3aKypFRZBOuUteLTXYcE8KV5MO4fzflCP5XECkACNkaNm+6S73Kmz8HEM
         mQag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780025543; x=1780630343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBqWfCykUL5nrF8ZUl4yEg+LbTO9fGjmXMENdlsBnXg=;
        b=V78+/c4mhZQVdoF1M+cHy3+ra8IjkWRIG/FNXvoNL5FCXL7EOPBYz+ZI8hxPbtVZQ/
         VyUQYOE66c5JwubIsVWiYIiWLtHVei0Se2LrQkQwJV6rnTzojczKnrmjWN3V1TI7SglI
         34Hc+MD7US9EnPxl51W9j35W0DlY/M2AnUE+VbGPlHT29BAd1iOvcUmmHd/oPKaSb179
         oxiBWHRIE+jTd0C0VtQtIRr8m/OINJP20yG4OaNXmzvJ6mu1j2yNsqAWcF+izVWNhme8
         iON+yze5NXOJaQSeRWwJFmvWdeSDoBnTgOufb6H9/+gpd0UoSeKXGGLfaiZ37Xmf1ktg
         oRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780025543; x=1780630343;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBqWfCykUL5nrF8ZUl4yEg+LbTO9fGjmXMENdlsBnXg=;
        b=SnNoWwf6+hdPcIVs90UP/nK2jUu7qDoFYMWxRZ1dFBbEXkCtnePrRC7nd7r7y9vo06
         RCy4ak+bcIziUiYGk6xsvfs3AXHNZsF37cDX8X2H6BFqIebN5Zjhehe0/elY/x9UQYUX
         B5UNKsvmVtoc/OscZsA7Fy5GrB0idv0J9WkAIeruIR4vFWkIIaLdBd2DuzI74HMHNQpE
         m5XN9+7jilFw1Jvs9i05jtjlLbb3toJ/ZcVe4w5lfmY7l65ZiHYz8W8/CA64c3YS5zlY
         AYd1yFf/W5fBSIiopvZtVJLqQ9oPa3jm6JHNbDlcHO6BNW5xa6akozYP2AEwXa6PsfkN
         WmDg==
X-Forwarded-Encrypted: i=1; AFNElJ+7SpA3430Qvsq6HDLBA65ceSpBd8JPDEXf9SynMbJJKTswHojUKHXnnWfpuNJB/GUDsvH+Ah23EmV5nmmF96tA+LK0h6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBSkaixapksfd7bPmvtJbk/Jg1NgRkxtvDvY+FVkSkSmbf5oJ
	2ItlvrZ67DAktXFy++tZEmiow6q53ACM85U/PlcIq7gb24/zXQ2eZiCWuHvp+BmGoRNGfJt3W67
	/xSkBoVEr1DV14/FUqiCFvdaKE/bZ9r9j4a7c11hg
X-Gm-Gg: Acq92OEL0aA1PeWObvuJ+NG7xejMhV94KICq5lJP12vzpCbRHxLwxVmqcuWAELDQvU0
	GZdS9HXNREQ+aDxnh2CsMwuWs+kv8U0kQbFqzIAYk4D2sv1n1mSRsEljAK/NBvPeLEwrug4G9aM
	5EJWIju0t8Ua1Nn8xwyd3XL1d1a9PcEcRrThVgCQk96jfE6TfoXHra8FCFejd0FxwGUWGT5hENO
	Y+cLIaFFVu8rmJjbnYIcum23BrnELHDJH0LA/TwJw3fn/6RtimBd92/z1Ncacm/qGrKQBWCp8Sy
	xsCJO+nqitZk331xUTU=
X-Received: by 2002:a05:690c:22c6:b0:7d0:2b7:6b1f with SMTP id
 00721157ae682-7de4918b304mr9954777b3.38.1780025542068; Thu, 28 May 2026
 20:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Thu, 28 May 2026 20:32:10 -0700
X-Gm-Features: AVHnY4KlWtizcrQUMe9l3-ueiDAYDcvHwtyIveELawbEDEUpAicujB5kyRCyu2Y
Message-ID: <CA+0ovCiRudJGHuLj2gm-_byHD7ZhAxKuM_P1chy367VY_RG6bg@mail.gmail.com>
Subject: [BUG] apparmor: AA_BUG aa_policy_destroy on aa_alloc_profile error path
To: John Johansen <john.johansen@canonical.com>
Cc: falemi@asu.edu, Tiffany Bao <tbao@asu.edu>, =?UTF-8?Q?Adam_Doup=C3=A9?= <doupe@asu.edu>, 
	Fish Wang <fishw@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000021609e0652ec7eea"

--00000000000021609e0652ec7eea
Content-Type: text/plain; charset="UTF-8"

Hello John and the AppArmor team,

I am reporting an AppArmor AA_BUG WARN in aa_policy_destroy() found
by syzkaller as part of research at the SEFCOM Lab at ASU.

Summary:
A write(2) to /proc/<pid>/attr/<lsm>/current that drives the
aa_change_hat() -> aa_new_learning_profile() -> aa_alloc_null() ->
aa_alloc_profile() chain takes the error-rollback path at
security/apparmor/policy.c:409 (aa_alloc_profile()'s `fail:` label
calling aa_free_profile(profile)). aa_free_profile() then calls
aa_policy_destroy(&profile->base) at security/apparmor/policy.c:327,
which trips its first AA_BUG at security/apparmor/lib.c:509:

  void aa_policy_destroy(struct aa_policy *policy)
  {
          AA_BUG(on_list_rcu(&policy->profiles));   <-- :509
          AA_BUG(on_list_rcu(&policy->list));
          ...
  }

  /* security/apparmor/include/policy.h:60 */
  #define on_list_rcu(X) (!list_empty(X) && (X)->prev != LIST_POISON2)

The WARN reproduces the macro's condition verbatim (the kernel prints
the full stringified expression including the LIST_POISON2 numeric
0x122 + 0xdead000000000000UL); see crash-report.txt for the full
header.

Observed on:
- Linux v7.1-rc3-200-g70eda68668d1-dirty (the only local dirty file
  is drivers/tty/serial/serial_core.c, a console guard our fuzzing
  harness uses, unrelated to security/apparmor/), x86_64, QEMU Q35
- AA_BUG asserts enabled + panic_on_warn (the crash tail prints
  "Kernel panic - not syncing: kernel: panic_on_warn set")
- Source inspection of linus/master at commit e8c2f9fdadee
  (v7.1-rc4-754-ge8c2f9fdadee) shows the buggy structure is
  unchanged: security/apparmor/lib.c:509 still does
  AA_BUG(on_list_rcu(&policy->profiles)); aa_alloc_profile()'s fail
  path at security/apparmor/policy.c:409 still calls
  aa_free_profile(profile); aa_free_profile() at policy.c:327 still
  calls aa_policy_destroy(&profile->base). As no reproducer is available
  for this seed, I have not re-triggered the crash against e8c2f9fdadee.

Expected behavior:
Either aa_alloc_profile()'s rollback path must guarantee
profile->base.profiles is empty (or list_del'd so prev == LIST_POISON2)
before calling aa_free_profile(), or aa_policy_destroy()'s AA_BUG
should be softened to a WARN_ON-and-drain so it does not panic on an
alloc-rollback path. The maintainers are best placed to choose which
side of the contract owns this.

Reproducer:
A standalone .syz or C reproducer was not produced for this seed;
the crash fired during automated /proc/<pid>/attr/* fuzzing. The
console report is attached as crash-report.txt.

Novelty check:
I searched the syzbot dashboard's upstream open, fixed, stable, and
invalid (per-subsystem apparmor) namespaces; the Android dashboard;
the marc.info linux-security-module archive; and the complete
apparmor@lists.ubuntu.com list archive (2010 through 2026, full
message bodies), for "aa_policy_destroy", "on_list_rcu(&policy->
profiles)", "aa_alloc_profile" + "WARNING", and "AA_BUG" +
"policy->profiles". I did not find a prior report of this crash. The
three apparmor-titled entries in the syzbot invalid namespace are in
different functions (apparmor_sk_free_security UAF, aa_label_sk_perm
UAF, apparmor_file_open data-race). The only aa_policy_destroy
mentions on the AppArmor list are a 2022 "Fix memleak in alloc_ns()"
patch (a different aa_policy_destroy(&ns->base) call site), and there
is no occurrence of on_list_rcu(&policy->profiles) anywhere in the
list history.

I appreciate your time and consideration, and I'm grateful for your
work on this subsystem. I'd be glad to test any candidate patches.

Regards,

--00000000000021609e0652ec7eea
Content-Type: text/plain; charset="US-ASCII"; name="crash-report.txt"
Content-Disposition: attachment; filename="crash-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpqd8nky0>
X-Attachment-Id: f_mpqd8nky0

IDwvVEFTSz4KLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCkFwcEFybW9yIFdB
Uk4gYWFfcG9saWN5X2Rlc3Ryb3k6ICgoKCFsaXN0X2VtcHR5KCZwb2xpY3ktPnByb2ZpbGVzKSAm
JiAoJnBvbGljeS0+cHJvZmlsZXMpLT5wcmV2ICE9ICgodm9pZCAqKSAweDEyMiArICgweGRlYWQw
MDAwMDAwMDAwMDBVTCkpKSkpOiAKV0FSTklORzogc2VjdXJpdHkvYXBwYXJtb3IvbGliLmM6NTA5
IGF0IGFhX3BvbGljeV9kZXN0cm95KzB4MTY5LzB4MWMwIHNlY3VyaXR5L2FwcGFybW9yL2xpYi5j
OjUwOSwgQ1BVIzA6IHN5ei4zLjczOS8xMzg5OApNb2R1bGVzIGxpbmtlZCBpbjoKQ1BVOiAwIFVJ
RDogMCBQSUQ6IDEzODk4IENvbW06IHN5ei4zLjczOSBOb3QgdGFpbnRlZCA3LjEuMC1yYzMtMDAy
MDAtZzcwZWRhNjg2NjhkMS1kaXJ0eSAjMSBQUkVFTVBUKGZ1bGwpIApIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyAxLjE2LjMtZGViaWFuLTEu
MTYuMy0yIDA0LzAxLzIwMTQKUklQOiAwMDEwOmFhX3BvbGljeV9kZXN0cm95KzB4MTcwLzB4MWMw
IHNlY3VyaXR5L2FwcGFybW9yL2xpYi5jOjUwOQpDb2RlOiA4NSBlZCA3ZSA0ZCBlOCBjMSA5YSBk
YyBmZCA1YiA0MSA1YyA0MSA1ZSA0MSA1ZiA1ZCBjMyBjYyBjYyBjYyBjYyBjYyBlOCBhZSA5YSBk
YyBmZCA0OCA4ZCAzZCA4NyAxYyAwYiAwNSA0OCBjNyBjNiBiOCBhNyA4MiA4NyA8Njc+IDQ4IDBm
IGI5IDNhIGU5IDA0IGZmIGZmIGZmIGU4IDkxIDlhIGRjIGZkIDQ4IDhkIDNkIDdhIDFjIDBiIDA1
ClJTUDogMDAxODpmZmZmYzkwMDAxNDFmNTAwIEVGTEFHUzogMDAwMTAyOTMKUkFYOiBmZmZmZmZm
ZjgzYTU3MmIyIFJCWDogZmZmZjg4ODExOTA3YTQwMCBSQ1g6IGZmZmY4ODgxMmY3NzgwMDAKUkRY
OiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZmZmZmY4NzgyYTdiOCBSREk6IGZmZmZmZmZmODhi
MDhmNDAKUkJQOiAwMDAwMDAwMDAwMDAwY2MwIFIwODogMDAwMDAwMDAwMDAwMGNjMCBSMDk6IDAw
MDAwMDAwZmZmZmZmZmYKUjEwOiBkZmZmZmMwMDAwMDAwMDAwIFIxMTogZmZmZmZiZmZmMTAwYTI3
ZiBSMTI6IGRlYWQwMDAwMDAwMDAxMjIKUjEzOiBmZmZmODg4MTE5MDdhNDAwIFIxNDogZmZmZjg4
ODExOTA3YTQyOCBSMTU6IGRmZmZmYzAwMDAwMDAwMDAKRlM6ICAwMDAwN2Y1MWZkMmQ3NmMwKDAw
MDApIEdTOmZmZmY4ODgyYWI2YjYwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAwMDdm
NTFmZThjZmUxMCBDUjM6IDAwMDAwMDAxMWI2ZWEwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYwClBL
UlU6IDgwMDAwMDAwCkNhbGwgVHJhY2U6CiA8VEFTSz4KIGFhX2ZyZWVfcHJvZmlsZSsweGEyLzB4
OWYwIHNlY3VyaXR5L2FwcGFybW9yL3BvbGljeS5jOjMyNwogYWFfYWxsb2NfcHJvZmlsZSsweDFm
MS8weDNmMCBzZWN1cml0eS9hcHBhcm1vci9wb2xpY3kuYzo0MDkKIGFhX2FsbG9jX251bGwrMHgy
ZC8weDUzMCBzZWN1cml0eS9hcHBhcm1vci9wb2xpY3kuYzo2OTAKIGFhX25ld19sZWFybmluZ19w
cm9maWxlKzB4MjI2LzB4NGUwIHNlY3VyaXR5L2FwcGFybW9yL3BvbGljeS5jOjc2NwogYnVpbGRf
Y2hhbmdlX2hhdCsweDI5Mi8weDQwMCBzZWN1cml0eS9hcHBhcm1vci9kb21haW4uYzoxMDc5CiBj
aGFuZ2VfaGF0IHNlY3VyaXR5L2FwcGFybW9yL2RvbWFpbi5jOjExOTMgW2lubGluZV0KIGFhX2No
YW5nZV9oYXQrMHgxMTc3LzB4MmZiMCBzZWN1cml0eS9hcHBhcm1vci9kb21haW4uYzoxMjY5CiBh
YV9zZXRwcm9jYXR0cl9jaGFuZ2VoYXQrMHg0YTYvMHg1YjAgc2VjdXJpdHkvYXBwYXJtb3IvcHJv
Y2F0dHIuYzoxMzgKIGRvX3NldGF0dHIrMHg1NDgvMHg2YTAKIHByb2NfcGlkX2F0dHJfd3JpdGUr
MHg1ZDEvMHg2MzAgZnMvcHJvYy9iYXNlLmM6Mjg0NAogdmZzX3dyaXRlKzB4MjlmLzB4YjkwIGZz
L3JlYWRfd3JpdGUuYzo2ODYKIGtzeXNfd3JpdGUrMHgxNTUvMHgyNzAgZnMvcmVhZF93cml0ZS5j
Ojc0MAogZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjYzIFtpbmxp
bmVdCiBkb19zeXNjYWxsXzY0KzB4MTVmLzB4NTYwIGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQu
Yzo5NAogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgpSSVA6IDAwMzM6
MHg3ZjUxZmU4ODc3OGQKQ29kZTogZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAg
OTAgZjMgMGYgMWUgZmEgNDggODkgZjggNDggODkgZjcgNDggODkgZDYgNDggODkgY2EgNGQgODkg
YzIgNGQgODkgYzggNGMgOGIgNGMgMjQgMDggMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAw
MSBjMyA0OCBjNyBjMSBiMCBmZiBmZiBmZiBmNyBkOCA2NCA4OSAwMSA0OApSU1A6IDAwMmI6MDAw
MDdmNTFmZDJkNzAxOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAx
ClJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZjUxZmViMTVmYTAgUkNYOiAwMDAwN2Y1
MWZlODg3NzhkClJEWDogMDAwMDAwMDAwMDAwMDAyMiBSU0k6IDAwMDAyMDAwMDAwMDAwYzAgUkRJ
OiAwMDAwMDAwMDAwMDAwMDAzClJCUDogMDAwMDdmNTFmZDJkNzA4MCBSMDg6IDAwMDAwMDAwMDAw
MDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAw
MDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAxClIxMzogMDAwMDdmNTFmZWIxNjAz
OCBSMTQ6IDAwMDA3ZjUxZmViMTVmYTAgUjE1OiAwMDAwN2ZmYzQ5MTZiODcwCiA8L1RBU0s+Ci0t
LS0tLS0tLS0tLS0tLS0KQ29kZSBkaXNhc3NlbWJseSAoYmVzdCBndWVzcyk6CiAgIDA6CTg1IGVk
ICAgICAgICAgICAgICAgIAl0ZXN0ICAgJWVicCwlZWJwCiAgIDI6CTdlIDRkICAgICAgICAgICAg
ICAgIAlqbGUgICAgMHg1MQogICA0OgllOCBjMSA5YSBkYyBmZCAgICAgICAJY2FsbCAgIDB4ZmRk
YzlhY2EKICAgOToJNWIgICAgICAgICAgICAgICAgICAgCXBvcCAgICAlcmJ4CiAgIGE6CTQxIDVj
ICAgICAgICAgICAgICAgIAlwb3AgICAgJXIxMgogICBjOgk0MSA1ZSAgICAgICAgICAgICAgICAJ
cG9wICAgICVyMTQKICAgZToJNDEgNWYgICAgICAgICAgICAgICAgCXBvcCAgICAlcjE1CiAgMTA6
CTVkICAgICAgICAgICAgICAgICAgIAlwb3AgICAgJXJicAogIDExOgljMyAgICAgICAgICAgICAg
ICAgICAJcmV0CiAgMTI6CWNjICAgICAgICAgICAgICAgICAgIAlpbnQzCiAgMTM6CWNjICAgICAg
ICAgICAgICAgICAgIAlpbnQzCiAgMTQ6CWNjICAgICAgICAgICAgICAgICAgIAlpbnQzCiAgMTU6
CWNjICAgICAgICAgICAgICAgICAgIAlpbnQzCiAgMTY6CWNjICAgICAgICAgICAgICAgICAgIAlp
bnQzCiAgMTc6CWU4IGFlIDlhIGRjIGZkICAgICAgIAljYWxsICAgMHhmZGRjOWFjYQogIDFjOgk0
OCA4ZCAzZCA4NyAxYyAwYiAwNSAJbGVhICAgIDB4NTBiMWM4NyglcmlwKSwlcmRpICAgICAgICAj
IDB4NTBiMWNhYQogIDIzOgk0OCBjNyBjNiBiOCBhNyA4MiA4NyAJbW92ICAgICQweGZmZmZmZmZm
ODc4MmE3YjgsJXJzaQoqIDJhOgk2NyA0OCAwZiBiOSAzYSAgICAgICAJdWQxICAgICglZWR4KSwl
cmRpIDwtLSB0cmFwcGluZyBpbnN0cnVjdGlvbgogIDJmOgllOSAwNCBmZiBmZiBmZiAgICAgICAJ
am1wICAgIDB4ZmZmZmZmMzgKICAzNDoJZTggOTEgOWEgZGMgZmQgICAgICAgCWNhbGwgICAweGZk
ZGM5YWNhCiAgMzk6CTQ4IDhkIDNkIDdhIDFjIDBiIDA1IAlsZWEgICAgMHg1MGIxYzdhKCVyaXAp
LCVyZGkgICAgICAgICMgMHg1MGIxY2JhCgo8PDw8PDw8PDw8PDw8PDwgdGFpbCByZXBvcnQgPj4+
Pj4+Pj4+Pj4+Pj4+CgpNb2R1bGVzIGxpbmtlZCBpbjoKQ1BVOiAwIFVJRDogMCBQSUQ6IDEzODk4
IENvbW06IHN5ei4zLjczOSBOb3QgdGFpbnRlZCA3LjEuMC1yYzMtMDAyMDAtZzcwZWRhNjg2Njhk
MS1kaXJ0eSAjMSBQUkVFTVBUKGZ1bGwpIApIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBD
IChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyAxLjE2LjMtZGViaWFuLTEuMTYuMy0yIDA0LzAxLzIw
MTQKUklQOiAwMDEwOmFhX3BvbGljeV9kZXN0cm95KzB4MTcwLzB4MWMwCkNvZGU6IDg1IGVkIDdl
IDRkIGU4IGMxIDlhIGRjIGZkIDViIDQxIDVjIDQxIDVlIDQxIDVmIDVkIGMzIGNjIGNjIGNjIGNj
IGNjIGU4IGFlIDlhIGRjIGZkIDQ4IDhkIDNkIDg3IDFjIDBiIDA1IDQ4IGM3IGM2IGI4IGE3IDgy
IDg3IDw2Nz4gNDggMGYgYjkgM2EgZTkgMDQgZmYgZmYgZmYgZTggOTEgOWEgZGMgZmQgNDggOGQg
M2QgN2EgMWMgMGIgMDUKUlNQOiAwMDE4OmZmZmZjOTAwMDE0MWY1MDAgRUZMQUdTOiAwMDAxMDI5
MwpSQVg6IGZmZmZmZmZmODNhNTcyYjIgUkJYOiBmZmZmODg4MTE5MDdhNDAwIFJDWDogZmZmZjg4
ODEyZjc3ODAwMApSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZmZjg3ODJhN2I4IFJE
STogZmZmZmZmZmY4OGIwOGY0MApSQlA6IDAwMDAwMDAwMDAwMDBjYzAgUjA4OiAwMDAwMDAwMDAw
MDAwY2MwIFIwOTogMDAwMDAwMDBmZmZmZmZmZgpSMTA6IGRmZmZmYzAwMDAwMDAwMDAgUjExOiBm
ZmZmZmJmZmYxMDBhMjdmIFIxMjogZGVhZDAwMDAwMDAwMDEyMgpSMTM6IGZmZmY4ODgxMTkwN2E0
MDAgUjE0OiBmZmZmODg4MTE5MDdhNDI4IFIxNTogZGZmZmZjMDAwMDAwMDAwMApGUzogIDAwMDA3
ZjUxZmQyZDc2YzAoMDAwMCkgR1M6ZmZmZjg4ODJhYjZiNjAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwCkNTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMKQ1IyOiAwMDAwN2Y1MWZlOGNmZTEwIENSMzogMDAwMDAwMDExYjZlYTAwMCBDUjQ6IDAwMDAw
MDAwMDA3NTBlZjAKUEtSVTogODAwMDAwMDAKQ2FsbCBUcmFjZToKIDxUQVNLPgogYWFfZnJlZV9w
cm9maWxlKzB4YTIvMHg5ZjAKIGFhX2FsbG9jX3Byb2ZpbGUrMHgxZjEvMHgzZjAKIGFhX2FsbG9j
X251bGwrMHgyZC8weDUzMAogYWFfbmV3X2xlYXJuaW5nX3Byb2ZpbGUrMHgyMjYvMHg0ZTAKIGJ1
aWxkX2NoYW5nZV9oYXQrMHgyOTIvMHg0MDAKIGFhX2NoYW5nZV9oYXQrMHgxMTc3LzB4MmZiMAog
YWFfc2V0cHJvY2F0dHJfY2hhbmdlaGF0KzB4NGE2LzB4NWIwCiBkb19zZXRhdHRyKzB4NTQ4LzB4
NmEwCiBwcm9jX3BpZF9hdHRyX3dyaXRlKzB4NWQxLzB4NjMwCiB2ZnNfd3JpdGUrMHgyOWYvMHhi
OTAKIGtzeXNfd3JpdGUrMHgxNTUvMHgyNzAKIGRvX3N5c2NhbGxfNjQrMHgxNWYvMHg1NjAKIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YKUklQOiAwMDMzOjB4N2Y1MWZl
ODg3NzhkCkNvZGU6IGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDkwIGYzIDBm
IDFlIGZhIDQ4IDg5IGY4IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMyIDRkIDg5
IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDgg
YzcgYzEgYjAgZmYgZmYgZmYgZjcgZDggNjQgODkgMDEgNDgKUlNQOiAwMDJiOjAwMDA3ZjUxZmQy
ZDcwMTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAwMQpSQVg6IGZm
ZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2Y1MWZlYjE1ZmEwIFJDWDogMDAwMDdmNTFmZTg4Nzc4
ZApSRFg6IDAwMDAwMDAwMDAwMDAwMjIgUlNJOiAwMDAwMjAwMDAwMDAwMGMwIFJESTogMDAwMDAw
MDAwMDAwMDAwMwpSQlA6IDAwMDA3ZjUxZmQyZDcwODAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIw
OTogMDAwMDAwMDAwMDAwMDAwMApSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAw
MDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAwMQpSMTM6IDAwMDA3ZjUxZmViMTYwMzggUjE0OiAw
MDAwN2Y1MWZlYjE1ZmEwIFIxNTogMDAwMDdmZmM0OTE2Yjg3MAogPC9UQVNLPgpLZXJuZWwgcGFu
aWMgLSBub3Qgc3luY2luZzoga2VybmVsOiBwYW5pY19vbl93YXJuIHNldCAuLi4KQ1BVOiAwIFVJ
RDogMCBQSUQ6IDEzODk4IENvbW06IHN5ei4zLjczOSBOb3QgdGFpbnRlZCA3LjEuMC1yYzMtMDAy
MDAtZzcwZWRhNjg2NjhkMS1kaXJ0eSAjMSBQUkVFTVBUKGZ1bGwpIApIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyAxLjE2LjMtZGViaWFuLTEu
MTYuMy0yIDA0LzAxLzIwMTQKQ2FsbCBUcmFjZToKIDxUQVNLPgogdnBhbmljKzB4NTcxLzB4YTYw
CiBwYW5pYysweGNhLzB4ZDAKIF9fd2FybisweDMxYS8weDRkMAogX19yZXBvcnRfYnVnKzB4Mjlh
LzB4NTQwCiByZXBvcnRfYnVnX2VudHJ5KzB4MTlhLzB4MjkwCiBoYW5kbGVfYnVnKzB4Y2UvMHgy
MDAKIGV4Y19pbnZhbGlkX29wKzB4MWEvMHg1MAogYXNtX2V4Y19pbnZhbGlkX29wKzB4MWEvMHgy
MApSSVA6IDAwMTA6YWFfcG9saWN5X2Rlc3Ryb3krMHgxNzAvMHgxYzAKQ29kZTogODUgZWQgN2Ug
NGQgZTggYzEgOWEgZGMgZmQgNWIgNDEgNWMgNDEgNWUgNDEgNWYgNWQgYzMgY2MgY2MgY2MgY2Mg
Y2MgZTggYWUgOWEgZGMgZmQgNDggOGQgM2QgODcgMWMgMGIgMDUgNDggYzcgYzYgYjggYTcgODIg
ODcgPDY3PiA0OCAwZiBiOSAzYSBlOSAwNCBmZiBmZiBmZiBlOCA5MSA5YSBkYyBmZCA0OCA4ZCAz
ZCA3YSAxYyAwYiAwNQpSU1A6IDAwMTg6ZmZmZmM5MDAwMTQxZjUwMCBFRkxBR1M6IDAwMDEwMjkz
ClJBWDogZmZmZmZmZmY4M2E1NzJiMiBSQlg6IGZmZmY4ODgxMTkwN2E0MDAgUkNYOiBmZmZmODg4
MTJmNzc4MDAwClJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IGZmZmZmZmZmODc4MmE3YjggUkRJ
OiBmZmZmZmZmZjg4YjA4ZjQwClJCUDogMDAwMDAwMDAwMDAwMGNjMCBSMDg6IDAwMDAwMDAwMDAw
MDBjYzAgUjA5OiAwMDAwMDAwMGZmZmZmZmZmClIxMDogZGZmZmZjMDAwMDAwMDAwMCBSMTE6IGZm
ZmZmYmZmZjEwMGEyN2YgUjEyOiBkZWFkMDAwMDAwMDAwMTIyClIxMzogZmZmZjg4ODExOTA3YTQw
MCBSMTQ6IGZmZmY4ODgxMTkwN2E0MjggUjE1OiBkZmZmZmMwMDAwMDAwMDAwCiBhYV9mcmVlX3By
b2ZpbGUrMHhhMi8weDlmMAogYWFfYWxsb2NfcHJvZmlsZSsweDFmMS8weDNmMAogYWFfYWxsb2Nf
bnVsbCsweDJkLzB4NTMwCiBhYV9uZXdfbGVhcm5pbmdfcHJvZmlsZSsweDIyNi8weDRlMAogYnVp
bGRfY2hhbmdlX2hhdCsweDI5Mi8weDQwMAogYWFfY2hhbmdlX2hhdCsweDExNzcvMHgyZmIwCiBh
YV9zZXRwcm9jYXR0cl9jaGFuZ2VoYXQrMHg0YTYvMHg1YjAKIGRvX3NldGF0dHIrMHg1NDgvMHg2
YTAKIHByb2NfcGlkX2F0dHJfd3JpdGUrMHg1ZDEvMHg2MzAKIHZmc193cml0ZSsweDI5Zi8weGI5
MAoga3N5c193cml0ZSsweDE1NS8weDI3MAogZG9fc3lzY2FsbF82NCsweDE1Zi8weDU2MAogZW50
cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgpSSVA6IDAwMzM6MHg3ZjUxZmU4
ODc3OGQKQ29kZTogZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgZjMgMGYg
MWUgZmEgNDggODkgZjggNDggODkgZjcgNDggODkgZDYgNDggODkgY2EgNGQgODkgYzIgNGQgODkg
YzggNGMgOGIgNGMgMjQgMDggMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCBj
NyBjMSBiMCBmZiBmZiBmZiBmNyBkOCA2NCA4OSAwMSA0OApSU1A6IDAwMmI6MDAwMDdmNTFmZDJk
NzAxOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxClJBWDogZmZm
ZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZjUxZmViMTVmYTAgUkNYOiAwMDAwN2Y1MWZlODg3Nzhk
ClJEWDogMDAwMDAwMDAwMDAwMDAyMiBSU0k6IDAwMDAyMDAwMDAwMDAwYzAgUkRJOiAwMDAwMDAw
MDAwMDAwMDAzClJCUDogMDAwMDdmNTFmZDJkNzA4MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5
OiAwMDAwMDAwMDAwMDAwMDAwClIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAw
MDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAxClIxMzogMDAwMDdmNTFmZWIxNjAzOCBSMTQ6IDAw
MDA3ZjUxZmViMTVmYTAgUjE1OiAwMDAwN2ZmYzQ5MTZiODcwCiA8L1RBU0s+Cktlcm5lbCBPZmZz
ZXQ6IGRpc2FibGVkClJlYm9vdGluZyBpbiA4NjQwMCBzZWNvbmRzLi4KCjw8PDw8PDw8PDw8PDw8
PCB0YWlsIHJlcG9ydCA+Pj4+Pj4+Pj4+Pj4+Pj4KCg==
--00000000000021609e0652ec7eea--
