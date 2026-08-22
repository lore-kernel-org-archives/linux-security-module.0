Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB637D12F
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419603; cv=none; b=TW8LhleMrrn5fA4KlVURAQD/7vauCrcvJBeJtO0X5GZN9e0NyC9S1VSGvXC8nXLnLJztJ5NgcEKx7rEYbre59a+RZUaic7ILpSJ/HD0RR7UAQiIx5Pq+YPfcvO4eCUXlD3I3lyDSDEsvVhyFNKxrrDr2nvKJ9WE9EW0s9TkLBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419603; c=relaxed/simple;
	bh=bkZHVCqf0dOPuM+LiO5llF44RgpK5tIFRkDtcKtGd10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkR4TbrQX7CjDhtqXExuE7DXTrK1TDILFa/ylut11eIWQwG0KeqMTFINpzV9kOw6rECrZWb7q4EL7oxFqbB85vDOfWJsRBNU8nEFmPFkn/SLaWJ9EyEqs/FVQqDwiQ0lWLLiNNiZVpz0hg0YDP0DFwsjJpuONzPd1b31nIiTFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G60jXeRz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G60jXeRz"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso396672766b.0
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787419600; x=1788024400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hmJcggkYuVzuwXriFmjmsAzHibtH8yTDufWUnsK56kY=;
        b=G60jXeRzb1vA72OLYIZzi9xcPNZYrcSHJuoRSFoTOC3WER28ZM81n1AIcidvHSXg5u
         p1Kg/Bd0Y235eo8c16w27aDTj8fIDk4Xoa0dyp3fq0NyKyK3DgBHygcwFbEG5bBV+UiO
         E3a+RvtEMsJBTjJZMFxwdg20wBEltje9zm6CFCL+LkWhIGiVuzKiMMQ9xOZQHBFriqKr
         KC9Setrooj1YMlkAhvUO6vrWxzWwWAGVLTWAjnt0l7CBMBgUZqdjnPqdtURL8hBbK4si
         jBaqk7TTKDYiSwLmmwQFzJmHKQ7jULcjJzlwH6K+alpT1RGwVeJVeZV9s6jJ+qi8dZ8H
         EGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787419600; x=1788024400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hmJcggkYuVzuwXriFmjmsAzHibtH8yTDufWUnsK56kY=;
        b=rm3FeIUB9oOK8cjV6ROQM+d+czSPMZOjcoCVUBtBb4dIJ1SuwSswBk8daNLeYZlVFO
         8wg3DGp5YLEC37qccIWxOt8jAk25bvnMoOR3lWcsTNnmf6D0qz+ct5hrtfS3jq09A6UX
         O2JSesUgkdFQvQ6IOJNGXc039VMY/4/SYKQk/b+n0IcFNf6KP7ygzYV9B2AJ+h6YtFsA
         ebpohRoQkvz8qIpqu96B0KiVwLt+1Ae8faZ85HFT99XzEGF1fPuoYWQDRmjpLPDy4/X4
         HJxYtjaz5iXByozJwCHMhEEy2w7FmL1G46jUBo6rsgELpjv+xRCz+O7tQyoLvLu3sjW4
         Vdeg==
X-Forwarded-Encrypted: i=1; AHgh+RoPsLmuxlgdkCMLSA2UmnTfJdShs+sAiBLNgn+4YCpdRTWgh2ZiNEjBMxadCmaapSUBXabmN//T5MAwAT5Ei3xXyM+4xF8=@vger.kernel.org
X-Gm-Message-State: AFuF++lYpgoCWwu55nlpfm1cqmmop86Sr4sLPPD+dmVerxvUo2TzZvZ4
	PvmJksHSpBIS4YG4MrPyVJ8tccExc3VbHTtMCyuX6/MH0fODmJRDNEEm
X-Gm-Gg: AR+sD134Wh/slwV7WAzLdT18PwGwTn1B+YCpjvcjSUq9W/FAoM2UNM8iGK14E05yLhg
	g1bjo6szwpj2psYEtZi1qCWa2/cH9ZZ/OI/hXDGNmu5VN2wbdX4inH3LV9Zp2LTfcL+Q6C3+v0z
	VHV86bd5TUC8NAfdTCRKZ1fJ3TRFtyHJazPVqzBGS2vqXc9vLk07g/PpJa7JqHx0NFZk+jY0cCc
	DjxygqvWTgsqj93hvkk3AChW4sScdERt9AlWIq9a6sSJtDxaYh6XGwB552s8tD5r4jNras9eFHG
	gIJdfGoDcNpR/LmQCPkZyFOfSfrj2E/Y8RlN+V+vHS/NSQ7GMM1gWgI9cdYGv1+FuTzvZ2Jejzj
	7SaERU5xchqLJcFy66U9I/EquR0/aULAivWTdsMrGu/hMgOSBgV+IoYo5H9iPHr783DmipWvMK5
	0wbBL686ua4mQggo0uuxW/hhJ/oU5Xp5dcCfdmvlC+HtdXyVyMnWSNNc1aPX9IaK+NuYuGybQXV
	6ezJ6cvjWgByA==
X-Received: by 2002:a17:907:a01:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c244d86d229mr1779512166b.16.1787419599232;
        Sat, 22 Aug 2026 10:26:39 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm464294066b.29.2026.08.22.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 10:26:38 -0700 (PDT)
Date: Sat, 22 Aug 2026 19:26:33 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <20260822.c9dcabf4999f@gnoack.org>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>

Hello Justin!

Thanks for the patch set and apologies for review delays; I had to
read up on SysV message queues first. :-] It's possible that I still
have misunderstandings and I'm happy to be corrected.

On Mon, Jul 27, 2026 at 07:08:27PM -0400, Justin Suess wrote:
> This series extends Landlock with a new scoped access right,
> LANDLOCK_SCOPE_SYSV_MSG_QUEUE, allowing a sandboxed process to be
> restricted from interacting with SysV message queues created outside
> of its Landlock domain (or a nested domain).
> 
> While use of SysV message queues is less common than other IPC types,
> they are commonly used in older applications which may be vulnerable
> to exploitation, so they are a meaningful attack surface to restrict.
> 
> Background
> ==========
> SysV message queues have no FD or process-local handle.  A msqid is
> valid IPC-namespace-wide and can be obtained without calling
> msgget(), so simply hooking msgget() is insufficient.  Domain
> provenance has to be tracked on the queue itself and checked on
> every operation against it.
> 
> Approach
> ========
> A new credential blob is attached to each kern_ipc_perm at creation
> time, recording the creating task's Landlock domain and a @kind
> tag identifying the IPC object type.  The @kind tag is required
> because the LSM core allocates an IPC blob for every kern_ipc_perm
> regardless of kind, and the generic ipc_permission hook fires for
> semaphores and shared memory as well as message queues.
> 
> The enum also leaves room to extend scoping to sem/shm later
> without changing the blob layout.
> 
> Enforcement is done from security_ipc_permission(), which is the
> single choke point for msgget() on an existing queue, msgsnd(),
> msgrcv(), and the msgctl() variants that go through ipcperms()
> (IPC_STAT, MSG_STAT, MSG_STAT_ANY).  msgctl_down() (IPC_RMID and
> IPC_SET) bypasses ipcperms(), so the per-call msg_queue_msgctl
> hook is kept for those cases.  msg_queue_msgctl also covers the
> IPC_INFO / MSG_INFO case where no specific queue exists.

I get the impression that with this scheme it would be possible for a
landlocked process to guess the key of a set of programs which have
not created their message queue yet, so that these would then start
communicating on that message queue which the sandboxed process has
access to.

(Other processes can in principle protect against that by using
IPC_CREAT only with IPC_EXCL, but if I understand correctly, it is
also a common pattern that communicating processes all simply use
msgget() with IPC_CREAT but *without* IPC_EXCL, so that the message
queue for them gets created on the fly when first used?)

To get a feeling for the number of invocations without IPC_EXCL,
compare the number of search results on Debian Code Search for:
https://codesearch.debian.net/search?q=msgget%5C%28.*IPC_CREAT&literal=0 (90 results)
https://codesearch.debian.net/search?q=msgget%5C%28.*IPC_EXCL&literal=0 (26 results))

The construction of the keys is often simple and not built to protect
against guessability.  ftok() is already somewhat guessable.  Some
programs even use hardcoded key numbers or invent their own
ftok()-like derivation scheme.

I do not see how we can prevent the message-queue-squatting situation
with the current patch set; It feels like a mistake that we need to
analyze what other programs outside the sandbox do, in order to
enforce that the sandboxed program can't talk to them.

Do you have thoughts on this?

> Quirks
> ======
> - Denials surface as -EACCES rather than -EPERM because the generic
>   ipcperms() path maps every LSM denial to -EACCES before returning
>   to userspace.  This is documented and the selftests check for
>   -EACCES accordingly.
> - Because there is no persistent handle, a msqid already obtained
>   by a process before it enforces this scope can become unusable
>   once the restriction is in place; this is intentional and
>   documented.
> 
> Patch layout
> ============
>   1. Add the kern_ipc_perm credential blob and @kind enum.
>   2. Implement LANDLOCK_SCOPE_SYSV_MSG_QUEUE, the ipc_permission
>      hook, and msg_queue_msgctl coverage for IPC_RMID/IPC_SET and
>      IPC_INFO/MSG_INFO.
>   3. Bump the Landlock ABI.
>   4. Selftests covering msgget plus a separate fixture for msgsnd,
>      msgrcv, and msgctl using a pre-created msqid.
>   5. sandboxer sample support for the new scope.
>   6. Documentation updates covering the new scope, the -EACCES
>      return code, and the implications of non-persistent handles.
> 
> Test coverage
> =============
> Selftests exercise denial and allow paths for msgget, msgsnd,
> msgrcv, and msgctl(IPC_STAT) across domain boundaries, including
> nested-domain inheritance.  All existing and added tests are
> passing.

An audit test would be nice as well; we have one for each possible
denial, I think.

> 
> Changes since v1
> ================
> - Rebased on mic/next.
> - Fixed the kernel-doc Return descriptions of hook_ipc_permission()
>   and hook_msg_queue_msgctl().
> - Renamed the internal audit request type to
>   LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE for consistency with the
>   UAPI macro and the "scope.sysv_msg_queue" audit blocker string.
> - Integrated the new scope with the sandboxer's quiet access
>   support added in ABI 10 (new "sysv_msg_queue" LL_QUIET_ACCESS
>   token).
> - Selftests: track the created msqid in the fixture and remove it in
>   FIXTURE_TEARDOWN_PARENT() so queues are reclaimed even when a failed
>   assertion aborts a test (and never subject to the scoping under
>   test); use IPC_PRIVATE where the key is not needed.
> - Added CONFIG_SYSVIPC=y to the selftest config fragment.
> - Fixed the patch 6 subject typo (LANDLOCK_SCOPE_SYSV_MESSAGE_QUEUE)
>   and replaced an incorrect ipcperms(3) manpage reference with the
>   kernel helper ipcperms().
> - Reworded the LANDLOCK_SCOPE_SYSV_MSG_QUEUE UAPI comment and the
>   in-code comment explaining the -EACCES mapping.
> 
> v1: https://lore.kernel.org/all/20260521160640.1716746-1-utilityemal77@gmail.com/
> 
> Kind Regards,
> Justin Suess
> 
> Justin Suess (6):
>   landlock: Add kern_ipc_perm credential blob structs
>   landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
>   landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
>   selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
>   samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
>   landlock: Document LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> 
>  Documentation/admin-guide/LSM/landlock.rst    |   1 +
>  Documentation/userspace-api/landlock.rst      |  30 +-
>  include/uapi/linux/landlock.h                 |   4 +
>  samples/landlock/sandboxer.c                  |  24 +-
>  security/landlock/audit.c                     |   4 +
>  security/landlock/audit.h                     |   1 +
>  security/landlock/limits.h                    |   2 +-
>  security/landlock/setup.c                     |   1 +
>  security/landlock/syscalls.c                  |   2 +-
>  security/landlock/task.c                      | 137 +++++++++
>  security/landlock/task.h                      |  50 ++++
>  tools/testing/selftests/landlock/base_test.c  |   2 +-
>  tools/testing/selftests/landlock/config       |   1 +
>  .../landlock/scoped_sysv_msg_queue_test.c     | 265 ++++++++++++++++++
>  .../testing/selftests/landlock/scoped_test.c  |   2 +-
>  15 files changed, 517 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
> 
> 
> base-commit: 28ca6f6f271d47253c240e64cc88a72c89456d74
> -- 
> 2.54.0
> 

–Günther
