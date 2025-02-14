Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87A1591E3
	for <linux-security-module@vger.kernel.org>; Fri, 14 Feb 2025 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573572; cv=none; b=ENIrg3tykYpYihuxDhrgX80IfY7/QGwKxizNOf6XbArhxmvLNI42LeTclGJ2S4yeEu76eN/gh2Fv3lAyl/Ka3oxfGC7Qx/Bsfksbe3jW8J0v8qhKtjsnyHdlpXB0UsnKcCWeWaKYO8sYKI1Uf63zdYrcFcoAUMR8wZqcqUFJRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573572; c=relaxed/simple;
	bh=AeB2K/kfnYci205U3+nXnucLeUvf6uhlvI95vlFHxik=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kTre5ts1CSt1gKVrkePPxE5Mw21OmH/KnbbEKcUbX089xZPVW/r0xF3lbpDXuKnGL+SDSfZoroCVR7Nf4OICmskHfxGakvy0cekcn3CLq6+5H7GOzxpDiBus2iWEnc/z4KiinQJn7C6wtDrKzsYj+Oqg2HjVMQeTVeZXHMmAaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GLRpfKn0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GLRpfKn0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e6621960eeso18339676d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 14 Feb 2025 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739573569; x=1740178369; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRyPRF/DJDDmxPDCc/SHLLVfrO8B5SpPQVtnE2SBr6E=;
        b=GLRpfKn0pvZer5Ln9R72DhQ24f255VZrdI3HlYQku2ViG9E8dbno1IaHCPp0vlvx9M
         SS3BzA9dI3S2Hgt6T75WAbkQQuB2UwqtLyMY6gMzbC+aH0AIEL1Brffj6j27i1herZ4E
         fcWH1OTzU9zequq5tRudkKh+6YNFLwUnKVEYX56gSeh9LhP5JTO9F+/u5iuSiLEP9eIw
         /jztbxuX51kOKJuIhz8sRqMcZylo97rcCXg224ckS+kSb43xoCpItjQ86nUi3eRK5JH9
         xk/wZ+kYnpbekvDpUgFvBBnVPn8ysCmG1GflEudi0jqRdR7iXuWNpQFtZ0XsrO0lHJID
         A3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573569; x=1740178369;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRyPRF/DJDDmxPDCc/SHLLVfrO8B5SpPQVtnE2SBr6E=;
        b=T4I2e4gbb5G1d1sCvICE7asMlDsvBKDDNhRdhEouaRZv3cBrBKDsdCxex98vEBceIm
         m3mSF+wnZY6M8w3um1L1XJp1KRFEa/B7nXgysvxiT+qz00Vpi1VOcFeOFXk2xJGOfjZj
         RJGlZbCRtn9z9LPPaGHg73YwuK2AHHv18GrY5uQokYCA+jRqeAHCgCPgZ/iBv7Mo5CSs
         087VlRSb+xlxOHRNs7WbA3v34V/PwHqgO0LlxDoMgNXomN3Hiv++vSskWWEUvN+C6W+3
         kog3VoWKQrYvPSIaHZU0ou1eyK06ujd3AMsXOZUFQlbvo6oCYbEd18a1qBK2hfKTvs/v
         9V3A==
X-Forwarded-Encrypted: i=1; AJvYcCUFVMnNlzC5og04JLYCA3uHoW78ByAWjBPigKDgY36U8hwK2OGdemYWYuFXNHi1oKp2UAFI06X7q1KMgtwhoU8Lxo9YOzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMxgl/DYdjG2XCbAMNXv2zHA5jmtworyhe8TGM6rUqIIgLfyR
	QqqES46VLA7T0W0L5OHU5dqLl/fy0jRLEJpE+RxkHnpp1oVPtT4hr+VQCi6pyQ==
X-Gm-Gg: ASbGnctub+Zppj/PKlDbm80FjiPZjvim7D6VEDu4JmvPrfi0M5aTXdQPVNiivI8DeyU
	kO8yGzDCtAimFlXy8VC1apkP96JgG2KqRo4O5/FJFiE4wbd40o124r64c0wNGXUanxiHsHtmPma
	hvs97SBBEGYXNoG2nkPOV0pygKd/Tlr195EpLGXylHPhdWAziJploPOz/rs5635Oi1wj5FR7NWJ
	hOv4cY+5Q8bBFVdZwzUnY8tWu0RxFG6r4Z6eXN9WdVdeqZdqN9RZ3QYQoU7hCyECUU3twvOJU38
	uccwNYmoNQ==
X-Google-Smtp-Source: AGHT+IH5eqoSntsBdAzLEaEKc4vvJY4agRLXBl5Zvr6lqL1X7GECEM9Vn30hFQ9QopIU3InREdN86g==
X-Received: by 2002:ad4:5c49:0:b0:6e4:5fc3:723f with SMTP id 6a1803df08f44-6e65c84a2f5mr133555096d6.0.1739573568908;
        Fri, 14 Feb 2025 14:52:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c29ead52sm22315211cf.11.2025.02.14.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:52:48 -0800 (PST)
Date: Fri, 14 Feb 2025 17:52:47 -0500
Message-ID: <715d3d6c220bfd818bf50175cf14fd3c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250214_1255/pstg-lib:20250214_1549/pstg-pwork:20250214_1255
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 9/24] landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace  denials
References: <20250131163059.1139617-10-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-10-mic@digikod.net>

On Jan 31, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add a new AUDIT_LANDLOCK_ACCESS record type dedicated to an access
> request denied by a Landlock domain.  AUDIT_LANDLOCK_ACCESS indicates
> that something unexpected happened.
> 
> For now, only denied access are logged, which means that any
> AUDIT_LANDLOCK_ACCESS record is always followed by a SYSCALL record with
> "success=no".  However, log parsers should check this syscall property
> because this is the only sign that a request was denied.  Indeed, we
> could have "success=yes" if Landlock would support a "permissive" mode.
> We could also add a new field for this mode to AUDIT_LANDLOCK_DOMAIN
> (see following commit).
>
> By default, the only logged access requests are those coming from the
> same executed program that enforced the Landlock restriction on itself.
> In other words, no audit record are created for a task after it called
> execve(2).  This is required to avoid log spam because programs may only
> be aware of their own restrictions, but not the inherited ones.
> 
> Following commits will allow to conditionally generate
> AUDIT_LANDLOCK_ACCESS records according to dedicated
> landlock_restrict_self(2)'s flags.
> 
> The AUDIT_LANDLOCK_ACCESS message contains:
> - the "domain" ID restricting the action on an object,
> - the "blockers" that are missing to allow the requested access,
> - a set of fields identifying the related object (e.g. task identified
>   with "opid" and "ocomm").
> 
> The blockers are implicit restrictions (e.g. ptrace), or explicit access
> rights (e.g. filesystem), or explicit scopes (e.g. signal).  This field
> contains a list of at least one element, each separated with a comma.
> 
> The initial blocker is "ptrace", which describe all implicit Landlock
> restrictions related to ptrace (e.g. deny tracing of tasks outside a
> sandbox).
> 
> Add audit support to ptrace_access_check and ptrace_traceme hooks.  For
> the ptrace_access_check case, we log the current/parent domain and the
> child task.  For the ptrace_traceme case, we log the parent domain and
> the parent task.  Indeed, the requester is the current task, but the
> action would be performed by the parent task.
> 
> Audit event sample:
> 
>   type=LANDLOCK_ACCESS msg=audit(1729738800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=SYSCALL msg=audit(1729738800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> 
> A following commit adds user documentation.
> 
> Add KUnit tests to check reading of domain ID relative to layer level.
> 
> The quick return for non-landlocked tasks is moved from task_ptrace() to
> each LSM hooks.
> 
> Because the landlock_log_denial() function is only called when an access
> is denied, the compiler should be able to optimize the struct
> landlock_request initializations.  It is not useful to inline the
> audit_enabled check because other computation are performed anyway, and
> by the same landlock_log_denia() code.
> 
> Use scoped guards for RCU read-side critical sections.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250131163059.1139617-10-mic@digikod.net
> ---
> Changes since v4:
> - Rename AUDIT_LANDLOCK_DENY to AUDIT_LANDLOCK_ACCESS, requested by
>   Paul.
> - Make landlock_log_denial() get Landlock credential instead of Landlock
>   domain to be able to filter on the domain_exe variable.
> - Rebase on top of the migration from struct landlock_ruleset to struct
>   landlock_cred_security.
> - Rename landlock_init_current_hierarchy() to
>   landlock_init_hierarchy_log().
> - Rebase on top of the scoped guard patches.
> - By default, do not log denials after an execution.
> - Use scoped guards for RCU read-side critical sections.
> 
> Changes since v3:
> - Extend commit message.
> 
> Changes since v2:
> - Log domain IDs as hexadecimal number: this is a more compact notation
>   (i.e. at least one less digit), it improves alignment in logs, and it
>   makes most IDs start with 1 as leading digit (because of the 2^32
>   minimal value).  Do not use the "0x" prefix that would add useless
>   data to logs.
> - Constify function arguments.
> - Clean up Makefile entries.
> 
> Changes since v1:
> - Move most audit code to this patch.
> - Rebase on the TCP patch series.
> - Don't log missing access right: simplify and make it generic for rule
>   types.
> - Don't log errno and then don't wrap the error with
>   landlock_log_request(), as suggested by Jeff.
> - Add a WARN_ON_ONCE() check to never dereference null pointers.
> - Only log when audit is enabled.
> - Don't log task's PID/TID with log_task() because it would be redundant
>   with the SYSCALL record.
> - Move the "op" in front and rename "domain" to "denying_domain" to make
>   it more consistent with other entries.
> - Don't update the request with the domain ID but add an helper to get
>   it from the layer masks (and in a following commit with a struct
>   file).
> - Revamp get_domain_id_from_layer_masks() into
>   get_level_from_layer_masks().
> - For ptrace_traceme, log the parent domain instead of the current one.
> - Add documentation.
> - Rename AUDIT_LANDLOCK_DENIAL to AUDIT_LANDLOCK_DENY.
> - Only log the domain ID and the target task.
> - Log "blockers", which are either implicit restrictions (e.g. ptrace)
>   or explicit access rights (e.g. filesystem), or scopes (e.g. signal).
> - Don't log LSM hook names/operations.
> - Pick an audit event ID folling the IPE ones.
> - Add KUnit tests.
> ---
>  include/uapi/linux/audit.h  |   3 +-
>  security/landlock/Makefile  |   5 +-
>  security/landlock/audit.c   | 146 ++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h   |  53 +++++++++++++
>  security/landlock/domain.c  |  28 +++++++
>  security/landlock/domain.h  |  22 ++++++
>  security/landlock/ruleset.c |   6 ++
>  security/landlock/task.c    |  96 ++++++++++++++++++------
>  8 files changed, 334 insertions(+), 25 deletions(-)
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
>  create mode 100644 security/landlock/domain.c

Based on previous discussions I'm under the impression that you are
planning to add a Landlock "permissive" mode at some point in the
future and based on the comments above you plan to add a "success="
field to the _ACCESS record defined here.  There is no problem with
adding fields to an existing record, but the general guidance is that
new fields need to be added to the end of the record (limitations due
the the audit userspace and poor guidance in the early days of audit).
Assuming you are okay with that there is no need to change anything,
but if you would prefer the "permissive=" field to occur somewhere
else in the record you may want to consider adding a "permissive=no"
now.  Otherwise this looks okay from an audit perspective.

[P.S. I just got to patch 10/24 and saw the enforcing field there,
 the comments above still stand, but it looks like you chose to note
 this in the _DOMAIN record, which is fine.]

Acked-by: Paul Moore <paul@paul-moore.com> (Audit)

--
paul-moore.com
