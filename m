From: rgb@redhat.com (Richard Guy Briggs)
Date: Mon, 28 Aug 2017 05:12:55 -0400
Subject: [PATCH V3 05/10] capabilities: use intuitive names for id changes
In-Reply-To: <20170825200646.GA27821@mail.hallyn.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
	<CALCETrVf4Vc8A+sFk6cFqfovmNOrgin3BEvsTEP8aBmiavhRnQ@mail.gmail.com>
	<20170825185127.GB26620@mail.hallyn.com>
	<9465A086-A2C8-41E6-994E-34C7B1B9F0F9@amacapital.net>
	<20170825200646.GA27821@mail.hallyn.com>
Message-ID: <20170828091255.GD24714@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-08-25 15:06, Serge E. Hallyn wrote:
> Quoting Andy Lutomirski (luto at amacapital.net):
> > 
> > --Andy
> > > On Aug 25, 2017, at 11:51 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > > 
> > > Quoting Andy Lutomirski (luto at kernel.org):
> > >>> On Wed, Aug 23, 2017 at 3:12 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > >>> Introduce a number of inlines to make the use of the negation of
> > >>> uid_eq() easier to read and analyse.
> > >>> 
> > >>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > >>> ---
> > >>> security/commoncap.c |   26 +++++++++++++++++++++-----
> > >>> 1 files changed, 21 insertions(+), 5 deletions(-)
> > >>> 
> > >>> diff --git a/security/commoncap.c b/security/commoncap.c
> > >>> index 36c38a1..1af7dec 100644
> > >>> --- a/security/commoncap.c
> > >>> +++ b/security/commoncap.c
> > >>> @@ -483,6 +483,15 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
> > >>> 
> > >>> static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
> > >>> 
> > >>> +static inline bool is_real(kuid_t uid, struct cred *cred)
> > >>> +{ return uid_eq(cred->uid, uid); }
> > >> 
> > >> OK I guess, but this just seems like a way to obfuscate the code a bit
> > >> and save typing "->uid".
> > > 
> > > Personally I find the new to be far more readable.  In the old, the
> > > distinction between uid and euid is one character hidden in the middle
> > > of the expression.
> > 
> > Would real_uid_eq be better?
> 
> Replacing is_real() with real_uid_eq() would be good.  I still think that a
> is_setuid() is worthwhile.

I was trying to get away entirely from "uid_eq" because I didn't find it
at all helpful in understanding what that function did, so I don't see
real_uid_eq() as an improvement.  (More below.)

> > >>> +static inline bool is_eff(kuid_t uid, struct cred *cred)
> > >>> +{ return uid_eq(cred->euid, uid); }
> > >> 
> > >> Ditto.
> > >> 
> > >>> +
> > >>> +static inline bool is_suid(kuid_t uid, struct cred *cred)
> > >>> +{ return !is_real(uid, cred) && is_eff(uid, cred); }
> > >> 
> > >> Please no.  This is IMO insane.  You're hiding really weird,
> > >> nonintuitive logic in an oddly named helper.
> > > 
> > > How is it nonintuitive?  It's very precisely checking that a
> > > nonroot user is executing something that results in euid=0.
> > 
> > I can think of several sensible predicated:
> > 
> > 1. Are we execing a setuid-root program, where the setuod bit wasn't suppressed by nnp, mount options, trace, etc?
> > 
> > 2. Same as 1, but also require that we weren't root.
> > 
> > 3. Is the new euid 0 and old uid != 0?
> > 
> > 4. Does suid == 0?
> > 
> > This helper checks something equivalent to 3, but only once were far enough through exec and before user code starts.  This is probably equivalent to 2 as well.  This is quite subtle and deserves an open-coded check, a much more carefully named helper, or, better yet, something that looks at binprm instead of cred.
> 
> Part of the motivation here is that the things we are checking for are some
> rather baroque combinations of conditions, so having each piece of those be
> as simple and clear as possible helps to better reason about what is going on
> (which helped Richard to find the bug he is fixing).
> 
> These helpers are local (should all be static, as James pointed out).  Making
> helpers to simplify the final checks is the right way to clarify code.  I'm
> all for making sure they are as clear as possible, but I do think their existence
> is justified.
> 
> > is_suid sounds like #4.
> [...]
> > >>> @@ -493,7 +502,7 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effe
> > >>>         * for a setuid root binary run by a non-root user.  Do set it
> > >>>         * for a root user just to cause least surprise to an admin.
> > >>>         */
> > >>> -       if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> > >>> +       if (has_fcap && is_suid(root_uid, new)) {
> > >> 
> > >> e.g. this.  The logic used to be obviously slightly dicey.  Now it
> > >> looks sane but doesn't do what you'd naively expect it to do, which is
> > >> far worse.
> > > 
> > > In what way does not do what you'd expect?
> > 
> > It doesn't look at cred->suid.
> 
> Heh, good point.  How about is_setuid()?

Except that *someone* earlier had come up with the local variable is_setid():

	58319057b784 luto 2015-09-04 ("capabilities: ambient capabilities")
 
So I'm finding this particular objection and renaming scheme a bit hard
to swallow.

I simply extended the convention and made the two conditions that feed
it follow the same naming pattern but for the fact that it is a function
name with the minimum necessary arguments in the order that made the
most sense to me to read aloud to understand its usage.  Making it a
macro that hides the arguments was my original effort.

I was trying to find another unique function name that got across the
intent of what I needed to express.

> -serge

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
