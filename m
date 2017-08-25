From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 25 Aug 2017 08:06:24 -0700
Subject: [PATCH V3 05/10] capabilities: use intuitive names for id changes
In-Reply-To: <1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
Message-ID: <CALCETrVf4Vc8A+sFk6cFqfovmNOrgin3BEvsTEP8aBmiavhRnQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Aug 23, 2017 at 3:12 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Introduce a number of inlines to make the use of the negation of
> uid_eq() easier to read and analyse.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   26 +++++++++++++++++++++-----
>  1 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 36c38a1..1af7dec 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -483,6 +483,15 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>
>  static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
>
> +static inline bool is_real(kuid_t uid, struct cred *cred)
> +{ return uid_eq(cred->uid, uid); }

OK I guess, but this just seems like a way to obfuscate the code a bit
and save typing "->uid".

> +
> +static inline bool is_eff(kuid_t uid, struct cred *cred)
> +{ return uid_eq(cred->euid, uid); }

Ditto.

> +
> +static inline bool is_suid(kuid_t uid, struct cred *cred)
> +{ return !is_real(uid, cred) && is_eff(uid, cred); }

Please no.  This is IMO insane.  You're hiding really weird,
nonintuitive logic in an oddly named helper.

Also, this is going to cause massive confusion and severe bugs: given
the same, the only remotely sensible guess as to what this function
does is uid_eq(cred->suid, uid).  So NAK to this.

> +
>  void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effective, kuid_t root_uid)
>  {
>         const struct cred *old = current_cred();
> @@ -493,7 +502,7 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effe
>          * for a setuid root binary run by a non-root user.  Do set it
>          * for a root user just to cause least surprise to an admin.
>          */
> -       if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +       if (has_fcap && is_suid(root_uid, new)) {

e.g. this.  The logic used to be obviously slightly dicey.  Now it
looks sane but doesn't do what you'd naively expect it to do, which is
far worse.

> @@ -519,6 +528,13 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effe
>         !cap_issubset(cred->cap_##target, cred->cap_##source)
>  #define cap_full(field, cred) \
>         cap_issubset(CAP_FULL_SET, cred->cap_##field)
> +
> +static inline bool is_setuid(struct cred *new, const struct cred *old)
> +{ return !uid_eq(new->euid, old->uid); }
> +
> +static inline bool is_setgid(struct cred *new, const struct cred *old)
> +{ return !gid_eq(new->egid, old->gid); }

Please don't.  This logic is fragile, and these helpers are pretending
it's not fragile even though it's still fragile.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
