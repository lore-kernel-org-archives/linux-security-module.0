Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7844360
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040235; cv=none; b=ozJk7crsSPniKhu1jMdqhHb8GQNKHo0KpbhnE990DTXj3PNx61QMPW/Wo9UoZp7IE6VnsfEoWGjgRul+tAMCjea1qynCFHR0A5nXLXuzxPaslhvHmihKjwjwTJsHxjL5/acuD0nd5d6ekrqdsW/GAcBK/b35KJY2CicK/5V/Sus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040235; c=relaxed/simple;
	bh=c7iJis7Joy0QTpaOZaYBSRqrj/Rs7ZEBk6LEtw/Jnhg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ICjhxZSrk425/yurSZNxCTkPAGWbwP9PdcQzSoAm7dFRqh130bvjjx5EPNRErkT2Mi7mu4nimCTdfLMn83d2uvBUOQ9rTkRZz1rWMIbBM3/jeXdIKqip7hQZP+cd5w83c/dBMKks9AoGTsRSJDUwI9kEGXu7cigKYuVA3qIjUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ss97tGbQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ss97tGbQ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd1b895541so93038566d6.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 17:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040232; x=1736645032; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9qFWyzUy3S5M9WY77P7j48UYh+nD5po2O52FDMbMBA=;
        b=Ss97tGbQBwW42yW4lz5PKCNAKrVQbmbS0ix4Y7+s5bl5+wazyTVNb7cIEJbfexguUH
         saTD0VoJDiCiBd/zF/33prmMn5ODP3fRaaWHGrb8iWTlQTq6PxiKUx1UyLaNn4Mgb4WN
         CvdmeBqLKDW2lqdRtedzM+pScun0ryHoPeah7AAcoRg7vD58K1skippqZ4KiGHNJLrEA
         VuBTiRpDSfJvJ8FrJxF920wXP+nFOcHIqfl1/lxEDbbpP7awgF65m3ogJzHwr81ERvU5
         T4K3BXL97DuiUnRk7n5mHZKx1fFMTa/GibQ+JSRUD3ZbW+X48TnYWdJ52XDVQ/ZqHx5l
         RjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040232; x=1736645032;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9qFWyzUy3S5M9WY77P7j48UYh+nD5po2O52FDMbMBA=;
        b=FTy74wQZhUFnENgM22QgkNj+ZWFoNhXmaTP4uJU6Mt6AfRx0ibfUbBCV6mQI4TTLzK
         xSjyijEyMlrgrUfIJfVKuxm/TK8cA/Ok/h6OSbzSKqbUukzizR/skhMEcH8jowq3Yf4a
         bzaoZV4VwON2rVfZ4UuT7bHJ8udzSXR5WRrp5qtJ2xq0Q2jHoFtnONLfkx3rYfzZr12h
         m+0UaxNq0M/7r8xRr+u/bf3CWr9K1+D9goZ4UhpnWIy+kjZOPRs6WHy/r2Gk6vZ+rLOE
         gXZKLPkygVOg63axCs+efjTEt8ylUUD8G7rbmZdsBb2jceNgxMaJjP7O5TynJnmOlFDf
         Ux7g==
X-Forwarded-Encrypted: i=1; AJvYcCVT7SC+zH2CvsXjajQd1bGPKdzrZ+zqehrSr9eXAmlEX+zNHvHWTpxNN8RwPJD/B8OnTUfyWZWen5YIKVJ90U5SP+vBNoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//50VBhfWXg73fvNspKSvN9lazHdNFedVNrATrqNPkccFlc+q
	wZ+cvn5G9mFl1ecJpkOdv9WJTE2J66XiwwyLDMkOUt5nphCxHx34VugresTeow==
X-Gm-Gg: ASbGncvglVeFl00hntA4KbIPAcYPH9g1Sf9HQ7LNTQN7HB6YXN9mjUMAsDaLzGpb8qu
	Q5zlyMS5A2Dw1Ymx7irQgipaiuYaQK3NMoq/+Ak3xglys2g2hirJv31+65Jed1E3LKTdZX3Quie
	tj3Fj+1isK6xRv4hNAfejezaNSgri/+7Jb72kJ7+GGOn7H7k3mp5mmvQj1YH4AhEMNRGy8fsdTV
	OmwHKU4F/19dQQJY09O/Uy5/RxVoalu0l1q0eqfWQ3hIM3cUbA=
X-Google-Smtp-Source: AGHT+IEfM3aRLm/9PF0Qc1flQoRYUl60QDagEdxL1nDwYw4b8FPGKr14fDWDrH+KqR5s+N9tE84JXw==
X-Received: by 2002:ad4:5baa:0:b0:6d4:22d4:f5b0 with SMTP id 6a1803df08f44-6dd2338d333mr861831456d6.33.1736040232663;
        Sat, 04 Jan 2025 17:23:52 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180eaa0csm157113306d6.5.2025.01.04.17.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:52 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:51 -0500
Message-ID: <237bfe2be7b4ba5d59b3b832c23622bb@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 10/23] landlock: Log domain properties and release
References: <20241122143353.59367-11-mic@digikod.net>
In-Reply-To: <20241122143353.59367-11-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> TODO: Update sample with audit's creation time and now-removed parent
> hierarchy
> 
> Asynchronously log domain information when it first denies an access.
> This minimize the amount of generated logs, which makes it possible to
> always log denials since they should not happen (except with the new
> LANDLOCK_RESTRICT_SELF_LOGLESS flag).  These records are identified by
> AUDIT_LANDLOCK_DOM_INFO.
> 
> Log domain deletion with the AUDIT_LANDLOCK_DOM_DROP record type when
> a domain was previously logged.  This makes it possible for user space
> to free potential resources when a domain ID will never show again.
> 
> The logged domain properties include:
> - the domain ID
> - creation time
> - its creator's PID
> - its creator's UID
> - its creator's executable path (exe)
> - its creator's command line (comm)
> 
> This require each domain to save some task properties at creation time:
> time, PID, credentials, exe path, and comm.
> 
> It should be noted that we cannot use audit event's serial numbers
> because there may not be any related event.  However, it is still useful
> to use the same potential timestamp instead of a close one.  What really
> matter is how old the related Landlock domain is, not the uniquiness of
> the creation time.  If audit is not enabled, Landlock creates its own
> timestamp.  This timestamp will be exposed to user space with a future
> unprivileged interface.
> 
> Audit event sample for a first denial:
> 
>   type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=LL_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
>   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

As mentioned in patch 9/23, I don't want subsystems external to audit
to access the audit timestamp information, so the "creation=" field
in the audit event would need to be removed.  Assuming that the timestamp
was used either to reference the original domain creation and/or simply
provide some additional information for analysis, all of that information
should already be in the audit log, assuming of course that you are
logging domain creation (which you should, at least as an option).

Also, is there a good reason why the LL_DOM_INFO information can't be
recorded in the LL_DENY (or LL_ACCESS) record?  I think that would be
preferable.

> Audit event sample for logged domains deletion:
> 
>   type=LL_DOM_DROP msg=audit(1732186800.393:45): domain=195ba459b
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-11-mic@digikod.net
> ---
> Questions:
> - Should we also log the creator's loginuid?
> - Should we also log the creator's sessionid?

Creation of a Landlock domain can only happen through the Landlock
syscalls, yes?  If so, that information should already be logged in
the associated syscall record (see the "auid=" and "ses=" fields )and
we generally try to avoid duplicating information across records in
the same audit event.

> Changes since v2:
> - Fix docstring.
> - Fix log_status check in log_hierarchy() to also log
>   LANDLOCK_LOG_DISABLED.
> - Add audit's creation time to domain's properties.
> - Use hexadecimal notation for domain IDs.
> - Remove domain's parent records: parent domains are not really useful
>   in the logs.  They will be available with the upcoming introspection
>   feature though.
> - Extend commit message with audit's timestamp explanation.
> 
> Changes since v1:
> - Add a ruleset's version for atomic logs.
> - Rebased on the TCP patch series.
> - Rename operation using "_" instead of "-".
> - Rename AUDIT_LANDLOCK to AUDIT_LANDLOCK_RULESET.
> - Only log when audit is enabled, but always set domain IDs.
> - Don't log task's PID/TID with log_task() because it would be redundant
>   with the SYSCALL record.
> - Remove race condition when logging ruleset creation and logging
>   ruleset modification while the related file descriptor was already
>   registered but the ruleset creation not logged yet.
> - Fix domain drop logs.
> - Move the domain drop record from the previous patch into this one.
> - Do not log domain creation but log first domain use instead.
> - Save task's properties that sandbox themselves.
> ---
>  include/uapi/linux/audit.h   |  2 +
>  security/landlock/audit.c    | 74 ++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h    |  7 ++++
>  security/landlock/domain.c   | 41 ++++++++++++++++++++
>  security/landlock/domain.h   | 43 +++++++++++++++++++++
>  security/landlock/ruleset.c  |  7 ++++
>  security/landlock/ruleset.h  |  1 +
>  security/landlock/syscalls.c |  1 +
>  8 files changed, 176 insertions(+)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 60c909c396c0..a72f7b3403be 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -147,6 +147,8 @@
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
>  #define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
> +#define AUDIT_LANDLOCK_DOM_INFO	1424	/* Landlock domain properties */
> +#define AUDIT_LANDLOCK_DOM_DROP	1425	/* Landlock domain release */

See my comment about regarding AUDIT_LANDLOCK_DOM_INFO.

Similar to my previous comments regarding AUDIT_LANDLOCK_DENY, it might
be a good idea to change AUDIT_LANDLOCK_DOM_DROP to simply
AUDIT_LANDLOCK_DOM and use an "op=" field to indicate a drop, creation,
or other event.

> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index eab6b3a8a231..2d0a96797dd4 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -8,8 +8,11 @@
>  #include <kunit/test.h>
>  #include <linux/audit.h>
>  #include <linux/lsm_audit.h>
> +#include <linux/pid.h>
> +#include <linux/uidgid.h>
>  
>  #include "audit.h"
> +#include "cred.h"
>  #include "domain.h"
>  #include "ruleset.h"
>  
> @@ -30,6 +33,41 @@ static void log_blockers(struct audit_buffer *const ab,
>  	audit_log_format(ab, "%s", get_blocker(type));
>  }
>  
> +static void log_node(struct landlock_hierarchy *const node)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (WARN_ON_ONCE(!node))
> +		return;
> +
> +	/* Ignores already logged domains.  */
> +	if (READ_ONCE(node->log_status) == LANDLOCK_LOG_RECORDED)
> +		return;
> +
> +	ab = audit_log_start(audit_context(), GFP_ATOMIC,
> +			     AUDIT_LANDLOCK_DOM_INFO);
> +	if (!ab)
> +		return;
> +
> +	WARN_ON_ONCE(node->id == 0);

It seems like you might want to move the WARN_ON assertion up with the
other WARN_ON check?

> +	audit_log_format(ab, "domain=%llx creation=%llu.%03lu pid=%d uid=%u",
> +			 node->id,
> +			 /* See audit_log_start() */
> +			 (unsigned long long)node->creation.tv_sec,
> +			 node->creation.tv_nsec / 1000000, pid_nr(node->pid),
> +			 from_kuid(&init_user_ns, node->cred->uid));
> +	audit_log_d_path(ab, " exe=", &node->exe);
> +	audit_log_format(ab, " comm=");
> +	audit_log_untrustedstring(ab, node->comm);
> +	audit_log_end(ab);
> +
> +	/*
> +	 * There may be race condition leading to logging of the same domain
> +	 * several times but that is OK.
> +	 */
> +	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
> +}
> +
>  static struct landlock_hierarchy *
>  get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
>  {

--
paul-moore.com
