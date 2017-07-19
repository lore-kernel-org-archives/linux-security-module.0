From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 18 Jul 2017 22:22:05 -0500
Subject: [PATCH v3 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <1500416736-49829-1-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
Message-ID: <20170719032205.GA23598@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 03:25:21PM -0700, Kees Cook wrote:
> This series has grown... :P
> 
> As discussed with Linus and Andy, we need to reset the stack rlimit
> before we do memory layouts when execing a privilege-gaining (e.g.
> setuid) program. To do this, we need to know the results of the
> bprm_secureexec hook before memory layouts. As it turns out, this
> can be made _mostly_ trivial by collapsing bprm_secureexec into
> bprm_set_creds.
> 
> The LSMs using bprm_secureexec nearly always save state between
> bprm_set_creds and bprm_secureexec. In the face of multiple calls to
> bprm_set_creds (via prepare_binprm() calls from binfmt_script, etc),
> all LSMs except commoncap only pay attention to the first call, so
> that aligns well with collapsing bprm_secureexec into bprm_set_creds.
> The commoncaps, though, needs to check the _last_ bprm_set_creds, so
> this series just swaps one bprm flag for another (cap_effective is no
> longer needed to save state between bprm_set_creds and bprm_secureexec,
> but we do need to keep a separate state, so we add the cap_elevated flag).
> 
> Once secureexec is available to setup_new_exec() before the memory
> layout, we can add an rlimit sanity-check for setuid execs. (With no
> need to clean up since we're past the point of no return.)
> 
> Along the way, this fixes comments, renames a variable, and consolidates
> dumpability and pdeath_signal clearing, which includes some commit log
> archeology to examine the subtle differences between what we had and
> what we need.
> 
> I'd appreciate some extra eyes on this to make sure this isn't broken
> in some special way. Looking at the diffstat, even after all my long
> comments, this is a net reduction in lines. :)
> 
> Given this crosses a bunch of areas, I think this is likely best to
> go via the -mm tree, which is where nearly all of my prior exec work
> has lived too.
> 
> Thanks!
> 
> -Kees
> ----------------------------------------------------------------
> Kees Cook (15):
>       binfmt: Introduce secureexec flag
>       exec: Rename bprm->cred_prepared to called_set_creds
>       apparmor: Refactor to remove bprm_secureexec hook
>       selinux: Refactor to remove bprm_secureexec hook
>       smack: Refactor to remove bprm_secureexec hook
>       commoncap: Refactor to remove bprm_secureexec hook
>       commoncap: Move cap_elevated calculation into bprm_set_creds
>       LSM: drop bprm_secureexec hook
>       exec: Correct comments about "point of no return"
>       exec: Use secureexec for setting dumpability
>       exec: Use secureexec for clearing pdeath_signal
>       smack: Remove redundant pdeath_signal clearing
>       exec: Consolidate dumpability logic
>       exec: Use sane stack rlimit under secureexec
>       exec: Consolidate pdeath_signal clearing

Thanks, the set looks good to me,

Acked-by: Serge Hallyn <serge@hallyn.com>

Have you had a chance to run the ltp caps tests against this?

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
