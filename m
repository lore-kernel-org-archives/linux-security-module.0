From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 3 May 2017 15:42:47 -0600
Subject: converting Documentation/security/* to .rst
In-Reply-To: <CAGXu5jKdE_WgdUQyJGBGfvGhxUES=FcuG_AsbqyKzuWTiq963g@mail.gmail.com>
References: <CAGXu5j+YuXd70ZCNBJRfQNXwMqSPgVaqEyaq_yXkbgje3-gdVg@mail.gmail.com>
	<20170501091159.63218239@lwn.net>
	<CAGXu5jKdE_WgdUQyJGBGfvGhxUES=FcuG_AsbqyKzuWTiq963g@mail.gmail.com>
Message-ID: <20170503154247.3a8a9c4b@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 1 May 2017 09:31:55 -0700
Kees Cook <keescook@google.com> wrote:

> > The real question would be one of organization.  Most of the security
> > stuff looks like it properly belongs in the admin guide, but that's not
> > universally the case.  
> 
> Are the index area "purposes" documented anywhere? The admin guide
> seems to cover things outside of "administration" (like reporting
> security bugs, which is a developer/researcher activity usually),
> There's already a top-level "security documentation" with some TPM
> stuff in it.

They aren't really documented beyond what they, themselves, contain.  What
you're seeing is the beginning of an effort to bring some order to the
Documentation/ mess.  One of the biggest problems, IMO, is the lack of any
sort of audience targeting.  We have lots of different kinds of people
reading (we hope!) the docs, and they have to wade through a lot of
irrelevant stuff.

So we've set up guides for administrators, for kernel developers, and for
user-space developers (the last just landing in 4.12).  There will never be
a perfect spot for every document, but I hope we can create something
that's more useful in the end.
 
> Both things in prctl/ are "here's what this feature is and how to use
> it", both exposed to userspace.

That really seems like user-space API stuff.  prctl() goes beyond security,
after all.

> In security/ there is a mix of LSM
> highlevel descriptions and basic usage, key API documentation, and the
> one sort of design goal document ("self-protection.txt").
> 
> I think it'd make sense to keep Security Documentation as a top-level
> index for now, and create LSM and keys subsections for those items,
> and then move prctl/* under security:

Sigh.  Everybody wants to keep their stuff at the top level, which is how
we have a Documentation/ directory with 300 items in it.

I would rather not see it done that way; I would rather organize our docs
for the readers than for the convenience of the maintainers.  That said, if
you're working to improve the docs, I think it would be pretty dumb to turn
the results away because I don't like the organization.  So I'll not do
that.  But I do reserve the right to propose reorganizing things in the
future :)

>          deleted:    Documentation/security/00-INDEX
>          deleted:    Documentation/security/conf.py
>        renamed:    Documentation/security/IMA-templates.txt ->
> Documentation/security/IMA-templates.rst
>         renamed:    Documentation/security/credentials.txt ->
> Documentation/security/credentials.rst
>         renamed:    Documentation/security/keys-ecryptfs.txt ->
> Documentation/security/keys/ecryptfs.rst
>         renamed:    Documentation/security/keys.txt ->
> Documentation/security/keys/index.rst
>         renamed:    Documentation/security/keys-request-key.txt ->
> Documentation/security/keys/request-key.rst
>         renamed:    Documentation/security/keys-trusted-encrypted.txt
> -> Documentation/security/keys/trusted-encrypted.rst  
>         renamed:    Documentation/security/LoadPin.txt ->
> Documentation/security/lsm/LoadPin.rst
>         renamed:    Documentation/security/SELinux.txt ->
> Documentation/security/lsm/SELinux.rst
>         renamed:    Documentation/security/Smack.txt ->
> Documentation/security/lsm/Smack.rst
>         renamed:    Documentation/security/Yama.txt ->
> Documentation/security/lsm/Yama.rst
>         renamed:    Documentation/security/apparmor.txt ->
> Documentation/security/lsm/apparmor.rst
>         renamed:    Documentation/security/LSM.txt ->
> Documentation/security/lsm/index.rst
>         renamed:    Documentation/security/tomoyo.txt ->
> Documentation/security/lsm/tomoyo.rst
>         renamed:    Documentation/prctl/no_new_privs.txt ->
> Documentation/security/no_new_privs.rst
>         renamed:    Documentation/prctl/seccomp_filter.txt ->
> Documentation/security/seccomp_filter.rst
>         renamed:    Documentation/security/self-protection.txt ->
> Documentation/security/self-protection.rst
>         modified:   Documentation/security/index.rst
> 
> This is just renames and an update to security/index.rst to include
> the two new subdirs. This doesn't have any formatting updates. (What
> is preferred, organizational changes first or .rst formatting first?)

Ordering doesn't matter much, though hooking things into the documentation
tree is usually easier if it's done after things are in the intended
location.

> Does this looks sensible?

Module what I said above, yes.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
