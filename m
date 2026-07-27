Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34E3E9F8D
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168495; cv=none; b=OsedWEShRaTcFKor19ZOL2AD+0vZBhMNfDMbNpbZ3HIoOl0iB8QpgQpHqSQXHMuLm4FYoyj43+Ba1W79wdCArInMA2OvMlWoZoYdcd90nEZ0eZVHKOiHkHGxITs2KLVfUp+69eTSAygHCtIV6gWigC9vZ5xAFJW9EuAMjIbepXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168495; c=relaxed/simple;
	bh=z6RsxwGTzAzqktJqrDGyopDLfLb7fK9jLk+RdQ5saDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyyBYk0d/fou3mp1mxPUYlu18mV0JnpeSxGgSSx39JSpQsX7mvf7wfkQwMRm6/zzHE85/4Vix1qiAOmLXnsnRyiy1hdAhtxPyg60uFa0zSYvvVnvTTfye1wQmxVYb8OhNh58EBGrkm8Ik4cZ0QD0mwoODKSzVAy1U/TnfqMKexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swBrWGLi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swBrWGLi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so21808925e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785168490; x=1785773290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKr7Oo2YvTaUbYEorVUVMiDKHmdO6PpsC+cuNw9DnR8=;
        b=swBrWGLiWoDoyTxfV0HBn9jqoa3IpNHo9hXAbK7rz8hwrEPsKEp2n6uTJOmeoznT+u
         cD4RK+j4C9ofBX53hB6NoqzHOSXlzFmzTcQ/vXwI5BuyAGBn5bJgvMpTIl3li4T0+Y1D
         Gp8DVCetmSMYfp1xjqQWcUZZYoFUT2FjmZ0Vx1Zz6CTmeuo2ZIx5TgtzVAxsw05Oo8h7
         ljxFp/Qx9fAPwLDUm/qc/+5m8VgVIkGwkAVzSPhM8VB8LC2krjSj38jR0Ck3lgErMIq7
         luYEY2TrYERDF0qOvOgHyGXWd4BUJQXbteZvzhX2MPf7bvNm/qHh46rNZD2+2VDap2EV
         w0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785168490; x=1785773290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zKr7Oo2YvTaUbYEorVUVMiDKHmdO6PpsC+cuNw9DnR8=;
        b=OBBWVUwhGQMqBgSUO1dtn31kWWwUZmriQRFmPSgOdTJa4RnZN+4B8ixF2rpC4Fo/7Z
         LQbv7ijVNfGKtQtkE7XFQjRIZokuvfCIaeMNF+pmbyfWSlgyHWRdmYlc+0S68y1pqthD
         JucTBDv8jDTT+ZB6bGaCjeZhRCcATg7urPtPPVGa/4WZWYPDzASJylI5xZboho/Hrg/K
         vAyFQ5fkKAqgrvfrB0ie00Za5/UkQTxCUEVV7hxqDHczIRpdWx2pNUHVMA74F7qfen/i
         Q4vZyGizxhpde+w2zUgoULhHtAmYQBkRhsINmO6hLs7LGgU/84ClklHR2UkSBuo0g37z
         a7vQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGj0Pyb/Px9dCYSdn6CRe+Hseipu49LILqWBbpsyg2PS1ekqjUb8vsrniWGOjOrr8yvaklHKTdFR3JsIzqBOozG16wR6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM95uG25PpVeulmBg6Rz4SmrIpxpGIqmUNhtdrmB2Rj/NVAXX6
	6UK//VRfXYIYcHsItzZHJ6uto8KhoNlazGougD+1GerZ1b9V2jvWFNOsSLg/eU1YQg==
X-Gm-Gg: AR+sD12T+OqToTlYZz2cso4c1ZNO1ww/+E6bku6fbXYPblLDqVAUumdndI6hgpvCKpE
	6YbJcpWotIMAB4xKrMfrdvd5GvDBW7kYfNoGvp8V8FZuRKfUKnXjJo+LXVlyJoDWB8LmPqQk9J2
	Sh8zeovwWDWlGNPtuQICxODXOJqCy0w7KYBWMH2eI0WbQO1YaV2z5ttHj9edkb35vmbBQNPxuMH
	uifbBjyYRRL4d/bYOC7zSiZXM5TyhYkNhwPRZ6dUlYN6l/rgIK/2C4Gva5p9BJh7uM4oXrlt0VR
	Ag/tCoksRAxxyMjm4vlk1GIphtNKj/jOUx5qNzhQuekt21/jRgxIBfw6UEXwwo/BOlLCI+zcomn
	Ppq64PndE5a2MohrzB8dO+ZLtDu4fwlT5w0lvLAtQso+iYGMtYTAD+gLL5x+9aVrVWlMPeYIuWb
	rEDWbN1RDZADNhCeUdZ1uyXNr8DgQTr82iMYo2JDs88uA=
X-Received: by 2002:a05:6000:288b:b0:47f:73fb:daa1 with SMTP id ffacd0b85a97d-47f9fc8cf2bmr12301145f8f.19.1785168489509;
        Mon, 27 Jul 2026 09:08:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:3ca5:4c07:e7bf:ebf9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f96b9abc0sm29364420f8f.32.2026.07.27.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:08:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 18:08:02 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Paul Moore <paul@paul-moore.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Tingmao Wang <m@maowtm.org>,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Willy Tarreau <w@1wt.eu>, Yuxian Mao <maoyuxian@cqsoftware.com.cn>,
	kernel-team@cloudflare.com, landlock@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Document the threat model
Message-ID: <ameCYnxRXzDBbBlD@google.com>
References: <20260707210336.2060040-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707210336.2060040-1-mic@digikod.net>

Hello!

On Tue, Jul 07, 2026 at 11:03:33PM +0200, Mickaël Salaün wrote:
> Landlock's threat model has been defined since its initial submission
> [1] but is scattered across cover letters, commit messages, and
> mailing-list threads.  A security reporter has no single place to decide
> whether a behavior is a Landlock bug, leading to recurring invalid
> reports, for example treating io_uring's creation-time credentials,
> which are inherited from the sandboxed subject, as a bypass.
> 
> Add a self-sufficient "Threat model" section as the first section of the
> Landlock security documentation.  Read alongside the general kernel
> threat model, it consolidates that scattered knowledge and lets a
> reporter classify an issue without maintainer intervention: is this a
> Landlock security bug, and if so, what is its blast radius?
> 
> The section defines Landlock's guarantees (unprivileged self-sandboxing
> and per-domain confinement), its trust model (union-when-building versus
> intersection-when-transitioning), the per-right semantic contract, and
> the criteria that distinguish security bugs (under-enforcement) from
> compatibility bugs (over-enforcement), best-effort limitations, and
> out-of-scope behaviors.  It explains what makes a bypass narrow or
> broad, and which interactions are intentionally out of scope: privileged
> actions, same-domain and same-process-thread interactions, actions a
> user space service performs on the caller's behalf, resources passed
> into the sandbox from outside, information disclosure, denial of
> service, and syscall-argument filtering.
> 
> Retitle the document to reflect this: it documents Landlock's security
> design (threat model, guiding principles, design choices), and its title
> now follows the focus-based pattern of the other Landlock documents.

On grammar:

I ran a LLM on this to spot grammatical mistakes and specifically
asked it to make it sound more like a native speaker.  This worked
very well, and I'd recommend to use that.  The LLM knows both French
and English better than me and spotted a few places where grammar and
sentence structure could be improved.


On scope:

I find the sections "What Landlock protects" quite useful, as well as
the categorization of problems into security bugs, compatibility bugs
and "limitations".

I am less convinced about the reiteration of topics that are already
discussed in the existing documentation.  I am worried that if we
start duplicating that information here, we are just making our
documentation job harder when we have to keep this all in sync.

I am making a few suggestions below on how to restructure this and
remove sections that are redundant with existing documentation.

I think by and large, the LLM vulnerabilities that we got reported
already had the right understanding, it's just in corner cases where
they got it wrong, like the io_uring case (but that is also not
documented explicitly in the existing documentation).


> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Yuxian Mao <maoyuxian@cqsoftware.com.cn>
> Link: https://lore.kernel.org/r/20210422154123.13086-1-mic@digikod.net [1]
> Closes: https://github.com/landlock-lsm/linux/issues/64
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  Documentation/security/landlock.rst | 303 +++++++++++++++++++++++++++-
>  1 file changed, 299 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> index c5186526e76f..fae13145af5d 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst

Should this maybe go into a separate file?  The Linux kernel threat
model is also a separate file.


> @@ -1,13 +1,14 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  .. Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
>  .. Copyright © 2019-2020 ANSSI
> +.. Copyright © 2026 Cloudflare, Inc.
>  
> -==================================
> -Landlock LSM: kernel documentation
> -==================================
> +=========================
> +Landlock: Security design
> +=========================
>  
>  :Author: Mickaël Salaün
> -:Date: March 2026
> +:Date: July 2026
>  
>  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>  harden a whole system, this feature should be available to any process,
> @@ -28,6 +29,300 @@ constraints can be added.
>  User space documentation can be found here:
>  Documentation/userspace-api/landlock.rst.
>  
> +Threat model
> +============
> +
> +Landlock lets any process, even an unprivileged one, restrict itself.  Its
> +threat model therefore treats a sandboxed process as potentially malicious. The
> +adversary is a sandboxed process that tries to perform an action its own policy
> +should deny.  A Landlock security bug is when it succeeds.  This complements
> +Documentation/process/threat-model.rst.

I would add here at the top:

The Landlock Threat Model describes the security guarantees that
Landlock policies aim to provide.  For normal kernel bugs and
vulnerabilities in Landlock, the usual Linux-wide rules apply. (with
link to the Linux Threat Model)

(Your commit mentions this further below, but it feels like it belongs
to the top, as it clarifies the scope of the whole threat model
document.)

> +
> +What Landlock protects
> +----------------------
> +
> +A Landlock *domain* is a ruleset (a set of rules), or a stack of them, enforced
                                    ^^^^^^^^^^^^^^^^
                      seems redundant - that is what "ruleset means"

> +on a task (a thread), attached to its credentials and inherited across
> +:manpage:`fork(2)` and :manpage:`execve(2)`.

Suggestion:

    ..., or a stack of them, attached to a task's credentials and
    inherited across fork(2) and execve(2).

> A sandboxed *subject* (a task
> +restricted by a domain) is confined in the *actions* it may perform, such as
> +accessing files, binding or connecting to network ports, or sending signals.  A
> +ruleset declares the *handled* actions it restricts, in one of two shapes:
> +access rights and *scopes* that the running kernel supports.
> +

The following three paragraphs discuss (1) access rights, (2) scopes,
and (3) implicit restrictions.  I would recommend to align the visual
document structure more with the logical structure of the text, so
that it is easier to scan.  For example,

  ... The existing types of restrictions are:

  * **Access rights**, which deny actions: An access right rule grants
    rights on a target: an inode specified through a file descriptor,
    or a directory including the file hierarchy below it; or a network
    port.  Anything a handled right covers but no rule allows is
    denied.
  * **Scopes**, which deny *outgoing* interaction leaving a domain
    hierarchy (e.g. signals, abstract UNIX sockets).  IPC peers in the
    same domain or a nested one stay reachable.
  * **Implicit restrictions**, which no policy selects:
    * ptrace(2) only allowed to processes in the same domain (like
      *Scopes* above)
    * For domains restricting any file system access rights:
      * No mount topology changes allowed
      * Reparenting files across directories
        (unless LANDLOCK_ACCESS_FS_REFER is handled and allowed)

> +An access right allows specific accesses to a target named by a rule.  Currently
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   I feel that this is conflating the "handling" (restricting
   operations) and the rule (allowing operations)?

> +a target is a file descriptor, which designates one kernel object: the inode it
> +references, or for a directory the file hierarchy beneath it.  It can instead be
> +a network port, a value matching any socket using it rather than a specific
> +object.  Any access a handled right covers but does not explicitly allow is
                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
                                Sugg: "no rule explicitly allows" (for clarity)

> +denied.
> +
> +A scope instead restricts crossing out of the domain hierarchy, denying outgoing
> +interaction with processes or IPC peers that are neither in the subject's domain
> +nor in a domain nested under it (e.g. sending signals or connecting to abstract
> +UNIX sockets).
> +
> +Beyond these two declared shapes, a domain also carries restrictions Landlock
> +imposes implicitly, which a policy does not select.  It may :manpage:`ptrace(2)`
> +only a target confined by its own domain or by a domain nested under it
> +(necessarily more restricted); tracing a less restricted, unrelated, or
> +unsandboxed target is denied regardless of the policy.  A domain restricting the
> +filesystem also denies changes to the filesystem topology and, by default,
> +reparenting a file to a different directory, so inode-based rules cannot be
> +bypassed by relocating a file (see `Limitations are not security bugs`_).

(Split paragraph here? - the second half is not about implicit
restrictions any more, but about things that are out of scope for
Landlock to restrict)

> +Actions that are neither handled nor implicitly restricted are left to the
> +system's other access controls; likewise, semantics that live only in user
> +space, such as a service's own handling of the requests it receives, are beyond
> +a kernel mechanism's reach.  Landlock's coverage (the set of restrictable
> +actions) grows over time, extended without changing the meaning of existing
> +rights.
>
> +Landlock also supports observability: each domain has an identifier that is
> +unique and not reused for the system's lifetime and increases by a random step,
> +which hides the exact next value but not the underlying monotonic progression,
> +so the identifier is an observability aid, not a confidentiality boundary.
> +Denied actions can be logged through audit, but this per-domain configuration is
> +not a security boundary.  Landlock access records describe denials, never
> +allowed accesses, and a nested layer's denial is attributed to that layer, not
> +bypassing an outer one (see :ref:`admin-guide/LSM/landlock:Audit`).

The observability does not belong into the threat model, in my mind.
If we get LLM-assisted reports about these, maybe it would be enough
to list it under "What is not a Landlock security bug".

> +
> +Composition and trust boundaries
> +--------------------------------

I feel we are mixing two concerns here; I'd suggest to keep this
section about the "composition" alone.

The control that threads have over the entire process is mentionworthy
too, but might better go into a specific "Trust boundaries"
section, or into "What is not a Landlock security bug".

> +
> +Building a ruleset combines rights as a *union*: its rules come from a single
> +trusted author, so each rule grants the accesses it describes.
> +
> +Enforcing a ruleset on a thread (a domain transition) combines constraints as an
> +*intersection*: the stacked layers do not trust each other, so a thread's own
> +transition can only ever remove access.  A thread cannot un-sandbox itself or
> +regain an access a previous layer (or an inherited parent sandbox) denied. A
> +thread may enforce a ruleset on all threads of its process at once, replacing
> +the siblings' Landlock configuration.  This is not a relaxation across a
> +security boundary, since threads share an address space and are not a security
> +boundary (see `What is not a Landlock security bug`_).  Landlock's restrictions
> +therefore stay attached to the thread for its lifetime, aside from such
> +whole-process synchronization.

What's a union and what's an intersection depends on what sets we are
working with here.  I'd suggest to be slightly more explicit, e.g.

    The set of allowed actions for a landlocked process is **the
    intersection** of the allowed actions in the processes' nested
    domains.

    The set of allowed actions for a specific domain in a landlocked
    process is **the union** of actions allowed by the individual
    rules, for the actions which are restricted in that domain.

(This all sounds very similar to the
https://wiki.gnoack.org/LandlockFileSystemCompositionModel which I
wrote a while back.)


To discuss "Trust boundaries", I'd suggest:

    Trust boundaries
    ----------------

    Landlock assumes that there are no meaningful security boundaries
    between sibling threads in the same process.  It is expected that
    sibling threads can override each others' Landlock policies.

I think it's enough to keep it that short.  Or maybe even move it to
the 'What is not a Landlock security bug' section.

> +
> +Each access right has a precise and fixed semantic
        ^^^^^^^^^^^^                         ^^^^^^^^

"Semantic" does not exist in English, only "semantics".  Please
address this in the other places as well - there are multiple
occurrences in this document.

"Access right" is slightly misleading, because we defined that further
up to exclude "scoped" and implicit restrictions.  Maybe call this
"restrictable action"?


> +--------------------------------------------------
> +
> +An access right or scope controls exactly the operations its semantic defines,
> +no more and no less.  A semantic is defined by an operation's effect, not by the
> +syscall or code path used to reach it, including an indirect, deferred, or
> +kernel-mediated effect the subject arranges.  Every path that produces a covered
> +effect is in scope, so missing one is under-enforcement.  For example, the TCP
> +rights control TCP ``bind`` and ``connect`` only, on any path (including an
> +implicit connect performed while sending data), but they do not apply to MPTCP
> +or SCTP, even when those use TCP internally.  A scope likewise covers the
> +cross-domain interaction however it is produced: ``LANDLOCK_SCOPE_SIGNAL``
> +covers a signal the subject arranges the kernel to deliver (e.g. ``SIGIO`` via
> +:manpage:`fcntl(2)` ``F_SETOWN``), not only a direct :manpage:`kill(2)`.

Suggestion: Should we talk about "contracts" rather than "semantics"?
Maybe that would be a bit clearer?  e.g.

    The contract for restricting an access right or scope flag is defined in
    abstract operations and their effects rather than in specific system calls.

    For example, ``LANDLOCK_SCOPE_SIGNAL`` restricts signal delivery
    to threads and processes in more privileged Landlock domains,
    independent of the mechanism which triggered the delivery (e.g.,
    :manpage:`kill(2)`, ``SIGIO``).

I'd stick to only one example here and bring up the TCP discussion in
the 'What is not a Landlock security bug' section.


> +Each right is checked at its own enforcement point against the current domain,
> +and Landlock does not retroactively revoke access already tied to an explicitly
> +referenced kernel object (e.g. a file descriptor or io_uring instance).  A file
> +descriptor obtained before enforcement is thus not covered afterward.  This is
> +not under-enforcement but the intended capability-model behavior: a program can
> +open its dependencies before restricting itself, or use only what a broker
> +passes it while being unable to obtain those resources directly.

That paragraph as well -- I'd recommend to shorten it and move it
under 'What is not a Landlock security bug'.  It feels like the
detailed discussion should maybe rather be in the section "Rights
associated with file descriptors", which already exists further down
in this file?

> +
> +This semantic is a permanent interface contract: it does not change, and the set
> +of rights a policy targets does not grow on its own (new rights are opt-in; see
> +:ref:`userspace-api/landlock:Compatibility`).  A kernel update only makes
> +*enforcement* converge toward the semantic, in either direction:

(Nit: I find the discussion of "kernel updates" confusing; The
correctness of the implementation should be measured against the
documented contract, not against the previous kernel version's
implementation.)

> +
> +* Enforcing *less* than the semantic is under-enforcement: a security bug. The
> +  fix may make a deployed policy stricter, but only by finally enforcing what it
> +  already requested.
> +* Enforcing *more* than the semantic is over-enforcement: a compatibility bug,
> +  not a security bug.  The fix relaxes the restriction; because that is visible
> +  to user space, it is advertised through the errata mechanism (see
> +  :ref:`userspace-api/landlock:Compatibility`).  Most programs need not check
> +  errata; when they do, an erratum should only gate enabling a restriction,
> +  never dropping one.
> +* An operation whose effect lies outside every right's semantic is simply not
> +  covered; controlling it requires a new access right, not redefining an
> +  existing one.

(Nit: I would recommend to highlight the phrases "under-enforcement: a
security bug", "over-enforcement: a compatibility bug" and "not
covered" for better visual orientation.)

I think the categorization into security bugs, compatibility bugs and
current limitations is very useful.  This would also be a good place
where we could point to the correct reporting approach for each of
these bug types, by pointing to the kernel security reporting
guidelines and to the Landlock bugtracker, so that reporters can check
for duplicates before reporting.

> +
> +What is a Landlock security bug
> +-------------------------------
> +
> +A Landlock security bug is a deviation from this contract.  A sandboxed subject
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This can be read as contradicting the previous section - with this
headline, this can be read as "A Landlock security bug is defined to
be a deviation from this contract".  A deviation can be both
"under-enforcement" and "over-enforcement", but according to the above
section, only "under-enforcement" counts as security bug.

> +performs an action that its own active policy should deny (under-enforcement),
> +including regaining an access across a domain transition. To classify a
> +behavior, check in order:
> +
> +#. Does the domain *handle* the relevant access right or scope, or does an
                                            ^^^^^^^^^^^^^^^^^^^^^
					    "action"?
> +   implicit restriction above apply, and does that semantic cover the operation?
                           ^^^^^
			   (can be removed)
> +   If not, the action is not restricted, possibly a limitation described below,
> +   not a bug.
> +#. Could the subject perform an action that a missing allow-list entry, a scope,
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
					  "...that no rule allows"?
> +   or an implicit restriction should deny?  That is a security bug.
                                 ^^^^^^^^^^^
				 "should have denied"?

The phrase with the "missing allow-list entry" is unclear to me.  If
someone forgets to add a rule at ruleset creation time, that sounds
like a problem with the program that defined the policy, not with
Landlock?

> +#. Did an access become allowed for the transitioning thread only after a
> +   further domain transition, which must only remove access?  That is a security
> +   bug.

I would decouple that from the "domain transition":

  #. Did an action for a process become allowed,
     which was previously denied by the Landlock policy?
     That is a security bug.
     (A processes' Landlock domain (the weakest Landlock domain in a process)
     may never get weakened.)

It does not matter whether that happens through a "transition".
Arguably, Jann Horn's cred_transfer ("Houdini") bug is also one where
an existing enforcement was weakened, and that happened even though
the responsible code never did anything explicitly with Landlock
domains (just with credentials).

I'm talking about the "weakest domain in a process" here to cover the
TSYNC case.  I'm not 100% sure about that formulation; the alternative
would be to just say "thread" and link to the discussion of the
exceptions below.


> +Conversely, Landlock denying a *legitimate* action is not under-enforcement. An
> +intentional implicit restriction is expected, such as the ptrace hierarchy, or a
> +filesystem-topology or reparenting restriction while a filesystem right is
> +handled; these are non-selective limitations, described below.  Denying more
> +than a handled right's semantic requires is over-enforcement, a compatibility
> +bug, not a security bug.

I am confused what this paragraph is about; isn't that already all
explained further up?

> +
> +This concerns Landlock's access-control guarantees.  A vulnerability in
> +Landlock's own implementation that an unprivileged process could exploit to
> +escalate privileges or compromise the kernel, separate from this access-control
> +classification, is a security bug under the general kernel threat model, like
> +any other kernel code.

I'd move that paragraph to the very top; the Landlock Threat Model
describes the security guarantees that Landlock policies aim to
provide.  For normal kernel bugs and vulnerabilities in Landlock, the
usual Linux-wide rules apply. (with link) (I made this remark at the
top in that location as well)


> +
> +Impact and blast radius
> +-----------------------
> +
> +Security bugs (under-enforcement) vary in impact along two dimensions:
> +
> +* *Blast radius within a sandbox*: a flaw in a domain-wide mechanism such as
> +  credential handling can drop all of a domain's restrictions (broad), while a
> +  missing check for one access right only affects sandboxes using that right and
> +  leaves their other restrictions intact (narrow).
> +* *Affected processes*: a Landlock policy is self-imposed per domain, not
> +  system-wide, so a bug weakens only the sandboxes that requested the affected
> +  restriction; other sandboxes and unsandboxed processes are unaffected.
> +
> +Because Landlock only adds restrictions on top of existing access controls, an
> +*enforcement* bug can at most undo Landlock's own restrictions on the affected
> +sandbox: the leaked access is still subject to standard DAC and the other LSMs.

I'm not sure the "impact and blast radius" section is needed; we can
judge the severity when it is reported, IMHO, and it hasn't been a
challenge so far, I think?

> +
> +What is not a Landlock security bug
> +-----------------------------------
> +
> +The following are outside Landlock's threat model and are handled as ordinary
> +issues, not security bugs (see also Documentation/process/threat-model.rst):
> +
> +* **Actions relying on privileges Landlock does not control**: a sandboxed
> +  process stays bound by its domain whatever capabilities it holds, so bypassing
> +  a handled right is a bug even for a privileged process.  Out of scope is what
> +  a retained privilege (e.g. ``CAP_SYS_ADMIN``) enables outside Landlock's
> +  coverage, including undermining the sandbox's own construction; dropping such
> +  privileges is the sandbox's job (see `Sandboxing is layered`_).
> +
> +* **Interactions within the same domain**: the cross-domain restrictions
       ^
  Maybe add "Scoped" here?

> +  (:manpage:`ptrace(2)` and the ``LANDLOCK_SCOPE_*`` scopes) apply only when
> +  leaving the domain hierarchy, not among tasks of the same domain or a domain
> +  nested under it; a domain's filesystem and network access rights still apply
> +  to all of its tasks.
> +
> +* **Direct interactions between threads of the same process**: Linux manages
> +  credentials, and therefore the Landlock domain, per thread, so threads of one
> +  process may even be in different domains.  Sharing an address space, they are
> +  not a security boundary, and for practical reasons some restrictions are not
> +  enforced between them: notably ``LANDLOCK_SCOPE_SIGNAL`` always allows signals
> +  between threads of the same process, even in different domains (like the
> +  :manpage:`ptrace(2)` same-process exception), because user space synchronizes
> +  per-thread credentials by signaling within the process, and some runtimes do
> +  not expose thread control.  This does not extend to objects tied to a
> +  creator's domain, such as abstract UNIX sockets.  Consequently a per-thread
                                               (LLM) missing comma ^

> +  domain does not protect the process; a whole-process guarantee requires
> +  confining all its threads with the same domain (see `Sandboxing is layered`_).

I would maybe say more generally that interactions between threads of
the same process are not in scope:

  * **Interactions between threads of the same process**:
    Threads of the same process share an address space and therefore
    do not have proper security boundaries between them.  Even though
    sibling threads can technically be in separate Landlock domains,
    we assume that they can manipulate each other to do operations
    on each other's behalf.

    For practical reasons, the scoped restriction ``LANDLOCK_SCOPE_SIGNAL``
    is not enforced between sibling threads.

    Through ``LANDLOCK_RESTRICT_SELF_TSYNC``, a thread can override the
    Landlock domain on sibling threads.

> +
> +* **Resources obtained from outside the sandbox**: receiving or inheriting a
> +  file descriptor (or similar) is governed by the capability model, not
> +  Landlock.  If an unsandboxed process willingly passes a sensitive resource,
> +  that is a security-architecture issue (a possible confused deputy), not a
> +  bypass; the resource carries the access rights set when it was created (e.g.
> +  an FD's read/write mode), which may exceed the receiver's policy.  By
> +  contrast, a resource the sandboxed process obtains itself stays bound by its
> +  own domain: a subsystem it sets up, such as io_uring, captures the subject's
> +  credentials, and with them the domain, so the work it later performs stays
> +  restricted.

Maybe say "file descriptors" instead of "resources" to be more concrete?

Suggestion:

  * **File descriptors obtained from outside the sandbox**: Filesystem
    access rights for open files are checked at the time of opening
    them.  File descriptors that are opened *before* enforcing a
    Landlock policy, or which are provisioned by a cooperating
    process, are already open and not subject to further Landlock
    policy checks.

Also maybe:

    When opening files through a dirfd using :manpage:``openat2(2)`` and
    related syscalls, the processes' Landlock policy is checked.

...to make sure that there is no confusion.

> +
> +* **Actions a user space service performs on the caller's behalf**: Landlock
> +  mediates the kernel-level access to a service, such as reaching its socket,
> +  not the service's own authorization of the requests it receives.  Exposing a
> +  service to a sandbox is a policy choice; a more-privileged service that acts
> +  on a sandboxed client's request without checking what that client should be
> +  allowed is a confused deputy, an issue in the service, not a Landlock bypass.
>
> +* **Denial of service by an already-privileged user**: such a user can exhaust
                               ^^^^^^^^^^^^^^^^^^^^^^^
			       higher-privileged process?
> +  resources regardless of Landlock.  Landlock must, however, not give an
> +  *unprivileged* process a new way to do so: its long-lived allocations are
> +  accounted to the requesting task's memory cgroup (and thus limitable) and its
> +  computation impacts only the processes requesting it (see
> +  :ref:`userspace-api/landlock:Current limitations` and `Guiding principles for
> +  safe access controls`_).

Maybe the last section is too narrow, I think it's not just DoS, and
it should be processes, not users?  In my understanding, a process in
a parent Landlock domain has no Landlock-iimposed restrictions to mess
with a process in a child domain, and can do much more than just DoS,
including ptracing and reprogramming the process.  Am I
misunderstanding this?  Is this about resource use?
  
> +
> +* **Information disclosure about the policy or filesystem layout**: a denial
> +  error code (e.g. ``EACCES`` versus ``ENOENT`` or ``EXDEV``) or timing can
> +  reveal whether a path exists or what a policy allows.  Consistent with the
> +  general kernel threat model, such probing side channels are not Landlock
> +  security bugs; Landlock only minimizes avoidable ones (e.g. the random-step
> +  domain identifiers above).

(In case you are dropping the part about observability, the
random-step domain identifiers reference would have to disappear as
well.)

> +
> +* **Syscall-argument filtering**: that is seccomp-bpf's role, not Landlock's
> +  (see `Guiding principles for safe access controls`_).

Missing items:

  * **io_uring credentials**: Operations done through io_uring use the
    Landlock domain that was active at the time of creating the
    io_uring.  This is known and expected.

  * **Restrictable socket types**: ``LANDLOCK_ACCESS_NET_BIND_TCP``
    and ``LANDLOCK_ACCESS_NET_CONNECT_TCP`` only cover TCP sockets.
    In particular, the use of MPTCP and SCTP sockets is not restricted
    by these access rights.

  * **Documented Limitations**:
    See :ref:`userspace-api/landlock:Current limitations`

(I would just link that - people are supposed to read this anyway, so
 that we don't have to duplicate everything here.  This includes the
 discussion of chroot(2), /proc/<pid>/fd/*, the maximum number of
 rulesets, etc.)

(We should probably also link the warning box in the documentation,
 the one from the header which says "It is currently not possible to
 restrict some file-related actions accessible through these syscall
 families: ...")

> +
> +Limitations are not security bugs
> +---------------------------------

It feels like limitations were already explained above?

> +
> +Landlock is best-effort: it enforces what the running kernel and the program's
> +configuration allow rather than refusing to sandbox at all.

I find that misleading (and actually when I pointed an LLM at the
text, it did also misunderstand it): We have libraries that implement
that, and this is the intended use, but at the level of syscalls, this
is not best-effort: When the Landlock system calls succeed, they
guarantee you the restrictions that you successfully asked for.

The landlock_create_ruleset() syscall does fail (and refuse to
sandbox) when you ask for a ruleset that restricts things that the
running kernel doesn't know about.

It feels like the backwards compatibility might be best discussed
separately (or in the documentation for the libraries).  If people
find limitations in older kernels and if we include a link to our
bugtracker, they will already find these feature requests there
(opened or closed), and can pile onto these bugs instead of writing
lengthy reports.


> +An operation that
> +cannot be restricted is a limitation, not a bug, in three cases:
> +
> +#. **Not requested**: the program did not handle the relevant right (a policy
> +   choice).

For completeness:
 
      ...and it was not implicitly handled

> +#. **Not supported by the running kernel**: the right belongs to a newer ABI
> +   than the running kernel; programs query the ABI version and enable the
> +   largest available subset.
> +#. **Not supported by any kernel yet**: no access right covers the operation.
> +   For example, Landlock restricts access to a file's data but not yet changes
> +   to its metadata (chmod, chown, utime, setxattr).

Yes, I'm not sure this is worth discussing.  It feels like common
sense and we have already documented the ABI version probing
elsewhere.

> +
> +Likewise, some objects cannot be tied to rules and are not explicitly
> +restrictable, such as pipes or sockets reachable only through
> +``/proc/<pid>/fd/*``.  See :ref:`userspace-api/landlock:Current limitations`.
> +
> +Some restrictions are also non-selective rather than absent: a domain handling
> +any filesystem right denies filesystem-topology changes (:manpage:`mount(2)`,
> +:manpage:`pivot_root(2)` and the like), since Landlock cannot yet scope them to
> +particular mounts, and denies reparenting a file to a different directory by
> +default.  The ``LANDLOCK_ACCESS_FS_REFER`` right is denied even when not
> +handled, and allowing a reparenting is subject to further constraints (see
> +:ref:`userspace-api/landlock:Kernel interface`).  A policy cannot opt out of
> +these while keeping its filesystem rights.  :manpage:`chroot(2)` is not denied:
> +it only changes the calling process's root directory without relocating any
> +inode, so the inode-based rules still apply (it can even narrow the visible
> +tree).

It feels like the last two paragraphs are all already covered by the
existing documentation, specifically in the section "Current
limitations" and the header documentation for the REFER right.

> +
> +Best-effort matters because a program and its kernel are built and released
> +independently, often by different parties, so the running kernel is often
> +unknown at build time.  A program tested against the newest features it targets
> +should still protect users as much as possible on an older kernel. This is safe
> +because a right's semantic is identical across kernels (above), so a policy
> +degrades gracefully.
> +
> +Landlock started with a limited set of access rights and gains more over time.
                                                   "keeps gaining more over time"
(from LLM: Simple past and simple present don't mix well.)

> +Each new right is designed, tested, and documented, and once released its
> +meaning becomes a permanent interface (above) that can never change.

Feels a bit redundant; ABI compatibility is a basic expectation.

> +Classifying
> +an operation as a limitation does not discourage lifting it: extending
> +Landlock's coverage is welcome, and ongoing or planned work is listed in the
> +`Landlock issue tracker <https://github.com/landlock-lsm/linux/issues>`_.

I would move that under the place where "security bug", "compatibility
bug" and "limitation" are classified above.

> +
> +Sandboxing is layered
> +---------------------
> +
> +Landlock is the access-control layer of a sandbox, not the whole sandbox.  A
> +robust sandbox also needs steps that are the program's responsibility: switching
> +to an unprivileged user, dropping capabilities, setting ``PR_SET_NO_NEW_PRIVS``,
> +and confining all threads of the process with the same domain.  A
> +single-threaded process gets the latter for free; a multithreaded one can
> +enforce a ruleset atomically on all its threads, or must otherwise synchronize
> +them before any untrusted work.  Landlock is typically applied last, to tighten
> +access and make the domain identifiable and auditable.
> +
> +Stronger isolation can come from combining Landlock with other mechanisms in a
> +defense-in-depth approach, notably seccomp-bpf (see
> +Documentation/userspace-api/seccomp_filter.rst) for what Landlock does not yet
> +cover.  A long-term goal of Landlock is to control access to any kind of kernel
> +resource in a way suited to sandboxing.

I'm not sure whether the "Sandboxing is layered" section is needed for
the threat model documentation?

> +
>  Guiding principles for safe access controls
>  ===========================================
>  
> -- 
> 2.54.0
> 

—Günther
