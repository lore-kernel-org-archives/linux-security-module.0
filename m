Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918053FA5E5
	for <linux-security-module@vger.kernel.org>; Fri,  8 May 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253239; cv=none; b=LBWuls1QtlqJHq3zeHumnS6HX6JWTfl3gaXSqV8JoJ+vgUp1iVfazea5JKNQ3GjXFOpmDLs2AniwQjbC5wax2sPkRJMb1yOGk+yiGXkRgs86iAdyf/6OBM9483id/M6iOsgQPK8BvU7vUBxYhxm1KQa02t6BQLWrQEtqpkZ1oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253239; c=relaxed/simple;
	bh=y1CxY52IRSX6K++lBulknnuyPbaxmvMHgr3SF/T83o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKImsaXegdPvx0gWUEmhfsAAOk+bGqReF/6add9NON8NHFDIdKf4LJYAnf+3n0oiy+x2MMXej+leqbbmwx5G/2fp8TZ+GiV69vQNYRgEO71eBE9npZM/iYkigyiC70XdmpTbjIN5wFsaAMUH6ZWe/wxnZRQ/Zfg6K3VZms4Wr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lA2vCrTf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lA2vCrTf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso24451055e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 May 2026 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778253236; x=1778858036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+fCtfac+MMOHgzkPCeDM7se4kodEc0gXMLjZi0MWCM=;
        b=lA2vCrTf4S78idyrbLvOLAM2+FEY37At6u6hFJEYZjK5V5SvfI97l5eHs62JMEUmzU
         1D5qGg8cS29WxawFtSKRr+OYNHM4KkjffadLe0xwc1ixR81dUVYuvJkp2K0EC/ey28BT
         1dAU/qAXz/ymf5QT1e28S0+eEGTf2uFGz/+vmtRILsKtx9RDwWemT9bPZOV5RxYFlQiD
         q86GCVsjiqYK/jwKng80ZjgMkBzixai22VP8CssWlgQUEyXNWrxRKdTf6jzVw2FqAoj6
         f2s8+svBf3h0dnRNr7SmuzKUNuJOhqFMxzQKhPlBWgxYxJ55JCN0Tovf/ZCFnKZROiVw
         wwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778253236; x=1778858036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+fCtfac+MMOHgzkPCeDM7se4kodEc0gXMLjZi0MWCM=;
        b=PMCDpyRLcg2OYtvWoeXznS1XSavP3WdnfyUZ/9yyKo/gTTrAOZK5wL9wa2cAHoPtbi
         ZQdXwPp7LzKNSlwj2UFqMKSJeyA/4rE2WeV+L6Ox4z89X07GGEhyH+WuvrBvHKZ1S0lu
         HVoqWmGcUY4cPwGZkVw57TWKUM5wOU4fc7dOwPSB3lWDoA7F7nwRDHWikIMQSe7GnAhg
         57NsTkVqXBB5n7POKJetHdvKJVPG/1FKM/C15iSD02BCEUfqD5YrhwUZNBGMfQFeLTV2
         AR7zTI7+ayUCNhCUXkv2XuCeKc26tMVrm66xCRa0HXMXNNbojQ/eqFW3RmfiO7j502Ht
         3Z+w==
X-Forwarded-Encrypted: i=1; AFNElJ+wAbXnTNp4aQU050b5rLcER0/mz7ZsrBccrnqM/0fYIBosPDHhcLH5hZlEm6c0mEYYluz07Zf+Z+SmnCuKhMJ+PRrUgL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8yE6eqgfk0ITS+rQKg8UnpQJylmknECwXjI2he2nNFsmrWzZ
	9tdNV+gHgXuV9h701Ui5u5qT5nYGlr1w7SDgTB2PCqoFsrb5vNhhmC5G2kVm0iDbqA==
X-Gm-Gg: AeBDiethzxLsiqakkjbE5/OS1oxJvCfS3UndoijW6z1kc1KdsHQ0xh/nZS03LCtGkfV
	WkUcxaZFrfzccWwfXL3O4FJF4ZPSJfLa2jMAKpKn6RQkbpIeUV0iYOT6LNB6razUE0OIE1+g0fC
	US8++HetvmEpTbXnI/O69B2i2LF8JYj4RTxZCu0C6vrkpXzUNBX9Yy59PlrSw4M8nA6qeeGD5hz
	bwdeToTDF/R8VOWeGMzL6xFzAMJLzzh0gKHZp/BudHvrFMbWnAc9iDwrTvZ4zFJdTFnt6oIWfvw
	QGnJLhdz9Tpb07z0PVqu+pwnBL5DIUBK8LGiqJWhk8RpUgKOy59dLH0wnm7KxJiAwyUusYPmxEU
	8n8u8mAaZgMAVz4r45xts++noikgiJPJLec4GLNjQBSfy/3OV7yKpGjuLabOtTGyJkfb5048jQA
	z1CXAJSw764cN/UdGYLwUe48sobrdc7MaUa8CdZfmX77CIWgrdQoPIHfAeIkIR0awk
X-Received: by 2002:a05:600c:3055:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48e51f4e492mr130288335e9.27.1778253235427;
        Fri, 08 May 2026 08:13:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d8c3:543d:1961:f820])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3b7casm1838725e9.12.2026.05.08.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:13:54 -0700 (PDT)
Date: Fri, 8 May 2026 17:13:48 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 11/11] landlock: Add documentation for capability
 and namespace restrictions
Message-ID: <af39llfstIu_weMM@google.com>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-12-mic@digikod.net>
 <20260422.5a7059c06fb0@gnoack.org>
 <20260423.yipaikooJ6oo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423.yipaikooJ6oo@digikod.net>

On Thu, Apr 23, 2026 at 03:52:12PM +0200, Mickaël Salaün wrote:
> On Wed, Apr 22, 2026 at 10:38:33PM +0200, Günther Noack wrote:
> > Hello!
> > 
> > On Thu, Mar 12, 2026 at 11:04:44AM +0100, Mickaël Salaün wrote:
> > > Document the two new Landlock permission categories in the userspace
> > > API guide, admin guide, and kernel security documentation.
> > > 
> > > The userspace API guide adds sections on capability restriction
> > > (LANDLOCK_PERM_CAPABILITY_USE with LANDLOCK_RULE_CAPABILITY), namespace
> > > restriction (LANDLOCK_PERM_NAMESPACE_ENTER with LANDLOCK_RULE_NAMESPACE
> > > covering creation via unshare/clone and entry via setns), and the
> > > backward-compatible degradation pattern for ABI < 9.  A table documents
> > > the per-namespace-type capability requirements for both creation and
> > > entry.
> > > 
> > > The admin guide adds the new perm.namespace_enter and
> > > perm.capability_use audit blocker names with their object identification
> > > fields (namespace_type, namespace_inum, capability).
> > > 
> > > The kernel security documentation adds a "Ruleset restriction models"
> > > section defining the three models (handled_access_*, handled_perm,
> > > scoped), their coverage and compatibility properties, and the criteria
> > > for choosing between them for future features.  It also documents
> > > composability with user namespaces and adds kernel-doc references for
> > > the new capability and namespace headers.
> > > 
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > ---
> > >  Documentation/admin-guide/LSM/landlock.rst |  19 ++-
> > >  Documentation/security/landlock.rst        |  80 ++++++++++-
> > >  Documentation/userspace-api/landlock.rst   | 156 ++++++++++++++++++++-
> > >  3 files changed, 245 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
> > > index 9923874e2156..99c6a599ce9e 100644
> > > --- a/Documentation/admin-guide/LSM/landlock.rst
> > > +++ b/Documentation/admin-guide/LSM/landlock.rst
> > > @@ -6,7 +6,7 @@ Landlock: system-wide management
> > >  ================================
> > >  
> > >  :Author: Mickaël Salaün
> > > -:Date: January 2026
> > > +:Date: March 2026
> > >  
> > >  Landlock can leverage the audit framework to log events.
> > >  
> > > @@ -59,14 +59,25 @@ AUDIT_LANDLOCK_ACCESS
> > >          - scope.abstract_unix_socket - Abstract UNIX socket connection denied
> > >          - scope.signal - Signal sending denied
> > >  
> > > +    **perm.*** - Permission restrictions (ABI 9+):
> > > +        - perm.namespace_enter - Namespace entry was denied (creation via
> > > +          :manpage:`unshare(2)` / :manpage:`clone(2)` or joining via
> > > +          :manpage:`setns(2)`);
> > > +          ``namespace_type`` indicates the type (hex CLONE_NEW* bitmask),
> > > +          ``namespace_inum`` identifies the target namespace for
> > > +          :manpage:`setns(2)` operations
> > > +        - perm.capability_use - Capability use was denied;
> > > +          ``capability`` indicates the capability number
> > > +
> > >      Multiple blockers can appear in a single event (comma-separated) when
> > >      multiple access rights are missing. For example, creating a regular file
> > >      in a directory that lacks both ``make_reg`` and ``refer`` rights would show
> > >      ``blockers=fs.make_reg,fs.refer``.
> > >  
> > > -    The object identification fields (path, dev, ino for filesystem; opid,
> > > -    ocomm for signals) depend on the type of access being blocked and provide
> > > -    context about what resource was involved in the denial.
> > > +    The object identification fields depend on the type of access being blocked:
> > > +    ``path``, ``dev``, ``ino`` for filesystem; ``opid``, ``ocomm`` for signals;
> > > +    ``namespace_type`` and ``namespace_inum`` for namespace operations;
> > > +    ``capability`` for capability use.
> > >  
> > >  
> > >  AUDIT_LANDLOCK_DOMAIN
> > > diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> > > index 3e4d4d04cfae..cd3d640ca5c9 100644
> > > --- a/Documentation/security/landlock.rst
> > > +++ b/Documentation/security/landlock.rst
> > > @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
> > >  ==================================
> > >  
> > >  :Author: Mickaël Salaün
> > > -:Date: September 2025
> > > +:Date: March 2026
> > >  
> > >  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
> > >  harden a whole system, this feature should be available to any process,
> > > @@ -89,6 +89,72 @@ this is required to keep access controls consistent over the whole system, and
> > >  this avoids unattended bypasses through file descriptor passing (i.e. confused
> > >  deputy attack).
> > >  
> > > +Composability with user namespaces
> > > +----------------------------------
> > > +
> > > +Landlock domain-based scoping and the kernel's user namespace-based capability
> > > +scoping enforce isolation over independent hierarchies.  Landlock checks domain
> > > +ancestry; the kernel's ``ns_capable()`` checks user namespace ancestry.  These
> > > +hierarchies are orthogonal: Landlock enforcement is deterministic with respect
> > > +to its own configuration, regardless of namespace or capability state, and vice
> > > +versa.  This orthogonality is a design invariant that must hold for all new
> > > +scoped features.
> > > +
> > > +Ruleset restriction models
> > > +--------------------------
> > 
> > I have to second Justin, it's a good idea to introduce this explanation.
> > 
> > > +
> > > +Landlock provides three restriction models, each with different coverage
> > > +and compatibility properties.
> > > +
> > > +Access rights (``handled_access_*``)
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +Access rights control **enumerated operations on kernel objects**
> > > +identified by a rule key (a file hierarchy or a network port).  Each
> > > +``handled_access_*`` field declares a set of access rights that the
> > > +ruleset restricts.  Multiple access rights share a single rule type.
> > > +Operations for which no access right exists yet remain uncontrolled;
> > > +new rights are added incrementally across ABI versions.
> > > +
> > > +Permissions (``handled_perm``)
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +Permissions control **broad operations enforced at single kernel
> > > +chokepoints**, achieving complete deny-by-default coverage.  Each
> > > +``LANDLOCK_PERM_*`` flag maps to its own rule type.  When a ruleset
> > > +handles a permission, all instances of that operation are denied unless
> > > +explicitly allowed by a rule.  New kernel values (new ``CAP_*``
> > > +capabilities, new ``CLONE_NEW*`` namespace types) are automatically
> > > +denied without any Landlock update.
> > 
> > I find the terminology of "chokepoints" and "gateways" in this and the
> > header documentation a bit vague; you could argue that opening a file
> > for reading is also a chokepoint/gateway for using read() later on;
> > it's not immediately clear to me how that's delineated.
> 
> Yeah, I wanted to express something wider that a fine-grained access
> right.  Any alternative words that would fit better?

I find it also difficult to explain.  A "critical enforcement point",
maybe?

     Permissions control **permission checks at critical enforcement
     points**, independent of individual kernel objects.  They guard
     critical features which are prerequisites for further access, such
     as entering namespaces and using capabilities, and do so in a
     deny-by-default manner (all namespace and capability types are
     denied without having to list these individually in the ruleset).

WDYT?

(FWIW, I also found the term "Policy Enforcement Point" on the web, but
that seems to be an Enterprise Software term which probably has more
specific meaning there; probably better to avoid that name.)
        
        
> > In my mind, the handled_* groups of access rights are usually defined
> > by the "namespace" of the objects they are protecting, more than
> > anything else: handled_access_fs: file paths, handled_access_net:
> > struct sockaddr (which we only expose as "port" for now).
> > 
> > To play the devil's advocate, a possible alternative would have been
> > to introduce:
> > 
> >   handled_access_ns with values LANDLOCK_ACCESS_NS_FOO_ENTER,
> >   LANDLOCK_ACCESS_NS_BAR_ENTER, etc. (and documenting somewhere that
> >   these are guaranteed to stay in sync; a static assert is enough to
> >   make sure they do).
> 
> That was actually one of my initial version, but I couldn't find any
> meaning ful other access rights that would both be useful for the
> sandboxing use case and worth the implementation.  At the end I
> concluded that we needed "ambiant" access rights for things that are not
> really tied to existing kernel objects, and to be able to fully express
> current and future properties, hence using non-Landlock UAPI
> (capabilities, namespace types...).  The handled_perm name was the less
> ambiguous one I could find, which still make sense.
> 
> Another important property is that the permissions rules don't have
> access rights, only *one* permission bit which could be removed.  I
> choose to keep it as a safeguard (for UAPI check) and to still be able
> to add new ones for such rule if one day we really find a useful use
> case.  Anyway, it's basically free.

Yes, sounds fair.  I also think these two points are the crucial ones
here, namely (a) it's not specific to a kernel object, and (b) the
deny-by-default property (you don't need to list out all the types in
the ruleset to block them all).  (My suggested rephrasing above talks
about these too.)


> >   handled_access_caps with values LANDLOCK_ACCESS_CAPS_USE_FOO,
> >   LANDLOCK_ACCESS_CAPS_USE_BAR, etc., also guaranteed to stay in sync.
> 
> Genuine question: what would be these FOO and BAR?  I couldn't find
> anything worth it.  The idea is to have a simple interface.  In fact,
> initially I didn't have these suffixes (i.e. _USE, _ENTER), and they are
> not really needed, but these are also safeguards in the case we would
> need one, and the main motivation is to make the semantic clear to
> users (and more consistent with other Landlock access rights).

By "FOO" and "BAR" I meant to imply the different capabilities, e.g.,
LANDLOCK_ACCESS_CAP_USE_AUDIT_CONTROL,
LANDLOCK_ACCESS_CAP_USE_AUDIT_READ, LANDLOCK_ACCESS_CAP_USE_AUDIT_WRITE,
LANDLOCK_ACCESS_CAP_USE_BLOCK_SUSPEND, etc.

> > That way the blocked accesses would still be "operations", and we
> > would not need to have rules for them because the "object" being
> > protected are the processes within the Landlock domain, so to say.
> 
> I'm not sure to understand, but an (also) previous version was to just
> put the capability (and namespace type) bits directly in the ruleset
> struct.  The issue with this approach is that it doesn't work well with
> a deny-by-default enforcement, and this would not be extensible, and
> this would not handle well compatibility (fields set to zero by
> default).
> 
> > 
> > Arguably, the LANDLOCK_ACCESS_FS_MAKE_* rights already follow a
> > similar pattern.
> 
> Hmm, I'm not following.

What I meant is that these are "rolled out" in a similar way to my
LANDLOCK_ACCESS_CAP_USE_... examples above, because they list the
different file types in LANDLOCK_ACCESS_FS_MAKE_CHAR, ..._MAKE_DIR,
..._MAKE_REG, ..._MAKE_SOCK, etc.


> > To be clear, I am myself only 50% convinced whether the API would be
> > better.  The implementation would be easier (but that doesn't count
> > much in comparison).
> > 
> > 
> > > +Each permission flag names a single gateway operation whose control
> > > +transitively covers an open-ended set of downstream operations: for
> > > +example, exercising a capability enables privileged operations across
> > > +many subsystems; entering a namespace enables gaining capabilities in a
> > > +new context.
> > > +
> > > +Permission rules identify what to allow using constants defined by other
> > > +kernel subsystems (``CAP_*``, ``CLONE_NEW*``).  Unknown values are
> > > +silently ignored because deny-by-default ensures they are denied anyway.
> > > +In contrast, unknown ``LANDLOCK_PERM_*`` flags in ``handled_perm`` are
> > > +rejected (``-EINVAL``), since Landlock owns that namespace.
> > 
> > OK I played through the compatibility scenarios which puzzled me in my
> > reply to the cover letter, for both namespaces and capabilities.
> > Namespaces are OK, so I'm just including that for completeness and for
> > comparison, but I think the capabilities might be tricky?
> > 
> > 
> > Case A: Namespaces
> > 
> > In the scenario where a caller restricts
> > LANDLOCK_PERM_NAMESPACE_ENTER, but then adds a rule to allow a
> > non-existent namespace number like 1<<63.
> > 
> > Landlock ABI v9:
> > * The rule is accepted and the unknown value for the namespace type
> >   silently ignored
> > * It is not possible to enter the namespace because the namespace API
> >   doesn't exist for it.  (But that's appropriate.)
> 
> Yes, the namespace would just be unknown to the kernel, Landlock doesn't
> do anything here.
> 
> > 
> > Landlock ABI v_future (the namespace type 1<<63 exists now):
> > * The rule continues to be accepted.
> > * When trying to exercise the namespace type, it works.
> 
> It works because the kernel now know about this namespace.  Again,
> nothing related to Landlock specifically.
> 
> > 
> > It seems that this scenario works fine.  In the earlier version,
> > entering the namespace already doesn't work because the kernel doesn't
> > have support for it.
> > 
> > 
> > Case B: Capabilities
> > 
> > Whne new capabilities are introduced, I see that people have used the
> > pattern where these capabilities are split off from operations which
> > were previously controlled by CAP_SYS_ADMIN.  An example is commit
> > a17b53c4a4b5 ("bpf, capability: Introduce CAP_BPF"), which states:
> > 
> >   Split BPF operations that are allowed under CAP_SYS_ADMIN into
> >   combination of CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN.  For backward
> >   compatibility include them in CAP_SYS_ADMIN as well.
> > 
> > (The same pattern was also used in the introduction of
> > CAP_CHECKPOINT_RESTORE and CAP_PERFMON.  CAP_AUDIT_READ is older and
> > did it differently.)
> 
> The key point here (and the architectural limitation) is that a new
> capability cannot completely replace an existing one.  The original
> capability check will remain forever.
> 
> > 
> > Let's say there is a frobnicate() syscall guarded by CAP_SYS_ADMIN.  A
> > future kernel introduces CAP_FOO and then checks for frobnicate() that
> > either one of CAP_FOO or CAP_SYS_ADMIN are present.
> > 
> > A caller creates a ruleset restricting capability use with Landlock,
> > and adds a rule to allow CAP_FOO but not CAP_SYS_ADMIN (e.g.,
> > ^CAP_SYS_ADMIN)
> > 
> > Landlock ABI v9:  (CAP_FOO doesn't exist)
> > * The rule for CAP_FOO is accepted and the unknown value for the
> >   capability silently ignored.
> > * The call to frobnicate() fails because the use of the capability is
> >   forbidden
> > 
> > Landlock ABI v10:  (CAP_FOO starts to exist)
> > * The rule continues to be accepted
> > * The call to frobnicate() **succeeds now**, because the new kernel guards
> >   the operation by either one of those capabilities.
> > 
> > 
> > So... for capabilities, it seems to be slightly incompatible if users
> > allow capabilities with a rule which are not known yet?  The reason
> > for that is the way how capabilities "fork off" from CAP_SYS_ADMIN.
> 
> The key point is that the compatibility is deferred to the other kernel
> subsystems.  User space need to know which capabilities (or namespace
> types) are supported before using them.  It's not a Landlock
> compatibility issue.

Fair enough, OK then.  Paraphrasing, to make sure we are aligned: If you
allow-list one of the newer capabilities through landlock_add_rule, and
then run your program on a kernel where that capability doesn't exist
yet, you can not expect that to work.  Seems fair.


> > I mean, I can see that it's a pretty fringe scenario if users pass
> > capabilities that don't exist yet, but it *is* strictly speaking an
> > incompatibiliy.  Should we check the range of the passed capabilities?
> > Am I overlooking any downsides to this if we force users to stay
> > between 0 and CAP_LAST_CAP?
> 
> Checking the range of known capabilities (or namespace types) could
> break the same Landlock rules on different kernels even if targeting the
> same Landlock ABI version, which would be much worse.  I definitely
> prefer to have idempotent/deterministic Landlock rules.

Hm, good point.  The list of supported capabilities can not be probed through
the Landlock ABI number.

—Günther
