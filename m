Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773025;
	b=SGFKQDjHoZ4M5x+Spcws2sHA9pBIUK3qHrZtoNaJobB5Rtijq9/c8hsAgQiiCzZcbV1/
	 uqp4xrt5qw06QCTMCnt2EQDR5SyMwF1WkUUaW9j5eYRc9qlfywwWebWKHAUHiVvuQPubf
	 fClLGZXWTBQWCtNYcAqUOD0CU/C01ACzcsCNLRvvDY99+1weYvR4lD67P2skGMxT2NF8b
	 Bw8NDctf/14bGM4kcV5wtChKf32l5zvozrGbV3k8MwH0SPA8ZhppLwjJdJ8Qj+Wcc7lB9
	 V3bABMLQU25AIUdtYQ2mhCyT/nRiFuqhqAq1Ne2Ld/CN7rZoOiZ5+Uq+8Yq6IlipkBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=j9jiZ4x7MQDG/OPAT148x9Ct345CbdnVj/5GsIePkw4=;
	b=DGcLdJAPpwexvCZYkM98lHbmsxlNaxfLOIBzkiJ9IeCVxkeTarUDqSRjbelXv6SGCINt
	 UEoTMLF6zjHlTdNaOSVaBQMKCeSdE8PaQeqiolGtua4fcbMseXVUPjzDHsddJnn3FmJxo
	 JiGMRsQGRZg9REborieevzbxnUzzdY5Px2/96sDJva+le6ijVdv2yDG+ir1+FcwdzafzU
	 KeNemdBPFTYY+6OQx03fPklEFtbrl5YoiHjxumBGzwIcp5MpkU0Z7sPmkNsEsOoKYw8J4
	 G+3P0Jhy5dOKeN1pJJ+mvdR+dyueKJz3pNmqeNPK8mEswiiI5cMn1u7iT9mBpQ9xRzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=opkP6507;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E004606A31F
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E004606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=opkP6507
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535179e995bso9988431cf.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773023; x=1793377823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j9jiZ4x7MQDG/OPAT148x9Ct345CbdnVj/5GsIePkw4=;
        b=opkP65074euOtHIEVpBqGsAKHYNhZKOz1Dtt4iEP3QO2CKMXCZw3vyAn72vgdLPrdl
         O2c2UFFDwXdas3jlrbfGkAqp/4EXZE9uvMFzZ4VSXwKVxljCsTF4dJXsVbq0PGY7mDy7
         YT6OxA0oh6TFH/31iu6A3Ar6jIAQQDo/Ksjw2S02uNU5oxehS9cZLLmn+LJudabrG24C
         iSqlvkXUQFE8r8SHGCL3IBOWzhdC1FM9dfwhxXGWHzZz7MB0iJsBaqYepw5JPMKtEfw8
         1DkS4yjSTJx18cokPGWOOXPzhdbzYn5hpEyZjQ6ys/D1pJTXbyIaA9HvsEDSgMAKfq2I
         x3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773023; x=1793377823;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j9jiZ4x7MQDG/OPAT148x9Ct345CbdnVj/5GsIePkw4=;
        b=NxojHqvDSvVAxcDw89cX2CwvgABjMimU94DLm9cM5aehRQjCDK83u08EwcnR/VEya/
         nbbEfOAn8kMK6QW8U56io5GM2ykh45o4qXxRJMV1B/+7Se5ToT1zgVigeOQjQfC371MP
         noOCRK0fii4DgQIhm/o481grO/mXVxlTE197NVz8NlIBwWrF0ZDB18u6oLVYK1yoQQ1+
         07XvfPf/QJ+9NCYDwINiLXKz61DFFvIwaJqybh2HuJCEwq0v2hMaIZRbFrIgg9BzUDrM
         p7qxV8sxYibS9dypC23pbWt7pvJR4hevEFezIQKIbndrzdmZSAFH82EHdKotyQWFERnR
         AhQA==
X-Forwarded-Encrypted: i=1; AKwUvBzV9Bdm9lWJ97EEjSuS/awOwVzerhd5IEjsuICCLO32t0mltAG98jUgZr4FuAzXe2tzsmFjgXS9HZyptc5l1OmJvqeYjJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTMNjNnURRc0zhOHfP2YnYJo5N47wTF3caMxNkoLIaDQnWE+HR
	rob1eU8jHypj4q3OWtXat3DcmkhsCfdvuF3/Riq/avoHlHBszSds+kleP8UPWDt75yE=
X-Gm-Gg: AYBFou0fWWfN49/BRiqFTWr8KyLR35H6Rmm3C6E0hS7tAKI+7jk7fIuIo9C7miC2gET
	HuRbFKlSStytjqtqdKwCAo2gkgjRecxPJ9d8jMREU6SXe08yhAbc3ndLzQB48xDDk2eFDPHPmYm
	ZytrrPOciWXlkIAFcMnPGz8Nr+SieuN650/0zqdM4FrqcX/tMFNev13mhpkv5i2DAD9G/M6J6pr
	34fBPYIAKwC3RLQ+9/L1sFxgA6zTzyYlcErd146/JgzNxjxDnKFHTxLxEatb/WPZ9ZeljEhyOpE
	J5uVLTQyLA7NSvGiQZsKD5pbPr7tgom0AnuLHDqpYHiK/OLYAWqMHZXsvzTuyAm1OItmrTw+aZK
	48uh00vqZeXoopn0RmWPe+ext9Sadq2vNZBphcRpj5xuvNQVI6D4+ADIdgiGVOxmUYRtUi1RZf7
	qv3NGtbcj4ya9+bjbWvkILy2Ck/il3He4G3cbf4v5/b+A+QH9ghrANvwOcPPkrWQmheKbMpVrjr
	ktEjbbgzXc1n56OlAwxe3sJjRz3CkvJWwwE+gyAKktDlBkgjRQecW5xsM6QTGb7HGRXbN3L
X-Received: by 2002:a05:622a:17c5:b0:536:780e:8f42 with SMTP id d75a77b69052e-536c28e413dmr40716251cf.33.1792773022900;
        Fri, 23 Oct 2026 09:30:22 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836bea313sm1433011cf.14.2026.10.23.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Fri, 23 Oct 2026 16:30:06 +0000
Message-Id: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+L22oC/33Oy27DIBAF0F+JWJeGV4B01f+osuAx1FQttsCxE
 kX+94K7cVXUzUh3NHN0H6hAjlDQy+GBMiyxxDHVcHo6IDeY9A44+poRI0xSQiS2AheYgzMTvtb
 fVLCXnOqT4dQBR/VvyhDibTPfLj+5XO0HuLlB7cKaAthmk9zQVp/T0YrjtvxNt9shlnnM963gQ
 pv5X5eFYoKDUKDAS0kUe53HW3STSd48u/ELtUIL2zFU9BjWGOOEp2emqVddhu8YRnsMr8xZuVp
 GgOBAu4zYM6zHiMpobQwJoQ4d/jDrun4DXvwNEMoBAAA=
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=8618;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2vjA65nk0PA6OKgNJ33Ppv9FKYb5hz2xlQ3RIn7M4DM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM4TvJnVu5HMo0JtJ3t7dnfSMT9XZdgH6XEoxL1IpgvmjJuHqPdl1iKmOyCV1o64PSu04/BzNe/
 795l5zP+howo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
v3: https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/
v4: https://lore.kernel.org/all/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com/

v4->v5:
- 3/5: the uid_map check only looked for an extent at the parent's uid
  0.  The root user of an ancestor can sit at any uid in the parent, so
  a task without CAP_SETFCAP could map "0 1000 1" under a "1000 0 1"
  and get host uid 0 as its uid 0 unchecked.  It now finds every
  ancestor root user the map contains.  4/5 already refused the file
  capabilities after such a map, so this is the map rule itself
  (Sashiko).  Dropped Bradley's Reviewed-by on 3/5, which changed.

v3->v4:
- 4/5: a v2 security.capability xattr skipped the new checks, it was
  written as is whenever the writer had CAP_SETFCAP over the
  filesystem's namespace.  It now only does that when the filesystem's
  root user is within reach, and goes through the v3 conversion and its
  checks otherwise (Sashiko).

v2->v3:
- The setns() check in 2/5 and the ptrace check in 5/5 only apply to
  namespaces that map the root user of an ancestor within the creator's
  CAP_SETFCAP, or that have no uid_map yet.  Root users stored through
  an idmapped mount are left to whoever sets up the mount, so a root
  task without CAP_SETFCAP can join an ordinary "0 100000" container
  again (Serge, Christian).
- 2/5 adds cred_may_setfcap_userns() for those two checks and
  cred_setfcap_reaches() for the uid_map check; nothing outside
  create_user_ns() calls cap_setfcap_level() directly (Serge).
- Fixed the cap_setfcap_level() kernel-doc, @ns doesn't have to be the
  cred's namespace or below; cap_capable() is compared with != 0
  (Serge).
- Picked up Bradley's Reviewed-by on 1/5 and 3/5, not on 2/5, which
  changed.
- Rebased onto current vfs.all.

v1->v2:
- The state lives on the user namespace now: ns->setfcap_level replaces
  ns->parent_could_setfcap, and cred->setfcap_level is gone (Serge,
  Christian).
- New 2/5: setns() refuses a task whose CAP_SETFCAP doesn't reach as far
  up as the namespace's setfcap_level.  It applies to every user
  namespace, not only to those that map the parent's uid 0, because of
  idmapped mounts (Serge, Christian).
- 5/5 asks a tracer for what setns() asks for, also when the namespace
  doesn't map an ancestor's root user, again because of idmapped mounts.
- Dropped "userns: don't let setns() lend the right to map uid 0", the
  setns() check covers it.  Its nested case moved into 3/5, which checks
  the opener and the writer.
- set_cred_user_ns() isn't touched anymore, so the put-before-use in
  userns_install() is gone (Sashiko).
- Rebased onto current vfs.all.

What it does now:

Every user namespace gets a setfcap_level when it's created, which is
how far up the creator's CAP_SETFCAP counted.  If its tasks can write
file capabilities for the root user of an ancestor, because the
namespace maps that root user or can still map it, setns() only lets in
tasks whose own CAP_SETFCAP reaches that far, and PTRACE_ATTACH asks the
tracer for the same.  The checks on the way to file capabilities then go
by the namespace instead of the cred: a uid_map write that maps the
parent's uid 0 (opener and writer), and setting security.capability.

The visible difference from v1 is the setns() restriction.  A task
without CAP_SETFCAP can't join, or attach to tasks in, a namespace that
maps the root user of an ancestor, such as host uid 0, and was created
by a task that had it.  A task that joins takes on the namespace's
reach.  Containers that don't map host uid 0, unprivileged users and
anything with CAP_SETFCAP aren't affected.

Testing: the v1 flows plus the setns() and ptrace cases, 41 in all, on
vfs.all with and without the series.  For v4 also the v2 xattr route: a
task that unshared without CAP_SETFCAP mounts a tmpfs, writes a v2 xattr
on it, and an overlay mounted from the initial namespace makes a uid
1000 user run the file with CAP_SYS_ADMIN.  That works without the
series and with v3, and gets -EPERM with v4.  For v5 the "0 1000 1"
under "1000 0 1" map: allowed without the series and with v4, -EPERM
with v5.  Every flow gives what's expected, and the only ones that
changed from v2 are the five idmapped mount and "0 100000" container
cases, which are allowed again.  The pidfd, namespaces, mount_setattr
and ptrace selftests give identical results with and without.  The TLA+
model, which has no idmapped mounts, finds no violation with the
narrower checks, and still finds the setns() bypass when the check is
taken out.

--- Original email (v1) ---

Hello,

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
stops a root task that has given up CAP_SETFCAP from creating a user
namespace that maps uid 0 and then writing file capabilities in it that
the initial namespace honours.  The check only looks at the task that
creates the namespace, so if somebody who did have CAP_SETFCAP created
one, there are still several ways around it:

- setns() into their namespace and write uid_map from inside (patch 2)
- write "0 0 1" through a uid_map fd that they opened (patch 3)
- setns() into a namespace of theirs that already maps uid 0 and set
  security.capability there, no map write needed (patch 4)
- ptrace one of their tasks and have it do any of the above (patch 5)

On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
from its permitted, effective and bounding sets and, through each of
these, ended up with a file that a uid 1000 user execs with
CAP_SYS_ADMIN in its effective set.

Patch 1 adds cred->setfcap_level, which records how far up the
namespace tree a task's CAP_SETFCAP reached when it entered its
namespace, and patches 2-5 check it.  Patch 4 is the check that closes
the class, the map patches make the uid 0 map rule mean what
db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
the target is entitled to.

This does change behaviour.  Everything new is -EPERM:

- a task that entered a namespace without CAP_SETFCAP outside can't map
  uid 0 of the outside or write fscaps for that root user anymore
- a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
  task without it to map uid 0
- if a privileged task maps "0 0 1" from the parent for a namespace
  created by a task without CAP_SETFCAP, that namespace can no longer
  write fscaps honoured outside
- PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
  CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share a
  root user

Rootless containers, privileged runtimes writing the map from the
parent, nested unprivileged namespaces and containers that don't map
host uid 0 aren't affected.  The ptrace check is one compare for
targets in the initial namespace and in namespaces entered without
the capability.

Testing: a set of flows run on the base and patched kernels, every
bypass route above gets -EPERM with the series and the 16 legitimate
flows behave the same.  The capabilities, namespaces, ptrace, pidfd and
proc selftests give the same results before and after. Thanks,

Josef

---
Changes in v5:
- Link to v4: https://patch.msgid.link/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com

Changes in v4:
- Link to v3: https://patch.msgid.link/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com

Changes in v3:
- Link to v2: https://patch.msgid.link/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com

---
Josef Bacik (5):
      userns: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend CAP_SETFCAP
      userns: check the opener and the writer before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP

 include/linux/capability.h     |   6 ++
 include/linux/user_namespace.h |   7 +-
 kernel/user_namespace.c        |  90 ++++++++++++++------
 security/commoncap.c           | 183 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 252 insertions(+), 34 deletions(-)
---
base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

