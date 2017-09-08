From: paul@paul-moore.com (Paul Moore)
Date: Fri, 8 Sep 2017 13:02:56 -0400
Subject: [PATCH V4 00/10] capabilities: do not audit log BPRM_FCAPS on
	set*id
In-Reply-To: <cover.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
Message-ID: <CAHC9VhTa_f+5zMq0OMmMgofCF-5FnMS-dwtiPZb4iEhg4P7a3A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 5, 2017 at 2:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> The audit subsystem is adding a BPRM_FCAPS record when auditing setuid
> application execution (SYSCALL execve). This is not expected as it was
> supposed to be limited to when the file system actually had capabilities
> in an extended attribute.  It lists all capabilities making the event
> really ugly to parse what is happening.  The PATH record correctly
> records the setuid bit and owner.  Suppress the BPRM_FCAPS record on
> set*id.
>
> See: https://github.com/linux-audit/audit-kernel/issues/16
>
> The first to eighth just massage the logic to make it easier to
> understand.  Some of them could be squashed together.
>
> The patch that resolves this issue is the ninth.
>
> It would be possible to address the original issue with a change of
>         "!uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid)"
> to
>         "!(uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid))"
> but it took me long enough to understand this logic that I don't think
> I'd be doing any favours by leaving it this difficult to understand.
>
> The final patch attempts to address all the conditions that need logging
> based on mailing list conversations, recoginizing there is probably some
> duplication in the logic.
>
> Passes: (ltp 20170516)
>         ./runltp -f syscalls -s cap
>         ./runltp -f securebits
>         ./runltp -f cap_bounds
>         ./runltp -f filecaps
>         make TARGETS=capabilities kselftest (when run locally, fails over nfs)
>
> v4
>   rebase on kees' 4.13 commoncap changes
>   minor local func renames
>
> v3
>   refactor into several sub-functions
>   convert most macros to inline funcs
>
> v2
>   use macros to clarify intent of calculations
>   fix original logic error
>   address additional audit logging conditions
>
> Richard Guy Briggs (10):
>   capabilities: factor out cap_bprm_set_creds privileged root
>   capabilities: intuitive names for cap gain status
>   capabilities: rename has_cap to has_fcap
>   capabilities: use root_priveleged inline to clarify logic
>   capabilities: use intuitive names for id changes
>   capabilities: move audit log decision to function
>   capabilities: remove a layer of conditional logic
>   capabilities: invert logic for clarity
>   capabilities: fix logic for effective root or real root
>   capabilities: audit log other surprising conditions
>
>  security/commoncap.c |  179 ++++++++++++++++++++++++++++++++------------------
>  1 files changed, 114 insertions(+), 65 deletions(-)

I took a quick look at this latest revision and aside from some
disagreements on style/formatting it looks okayish to me.  However, I
am going to walk back my previous I-can-take-this-via-the-audit-tree
comments, I think this probably should go in via the capabilities
(Serge) and/or linux-security (James) tree.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
