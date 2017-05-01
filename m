From: keescook@google.com (Kees Cook)
Date: Mon, 1 May 2017 09:31:55 -0700
Subject: converting Documentation/security/* to .rst
In-Reply-To: <20170501091159.63218239@lwn.net>
References: <CAGXu5j+YuXd70ZCNBJRfQNXwMqSPgVaqEyaq_yXkbgje3-gdVg@mail.gmail.com>
	<20170501091159.63218239@lwn.net>
Message-ID: <CAGXu5jKdE_WgdUQyJGBGfvGhxUES=FcuG_AsbqyKzuWTiq963g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 1, 2017 at 8:11 AM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 28 Apr 2017 13:24:36 -0700
> Kees Cook <keescook@google.com> wrote:
>
>> I was curious if the conversion of security/ (and prctl/ which only
>> has two files that should probably both be moved to security/) was
>> already on someone's TODO list? I'd love to get these done (I refer
>> people regularly to seccomp_filter.txt and self-protection.txt), but I
>> didn't want to duplicate any efforts.
>
> If anybody is working in that area, they've not told me about it.

I might take a shot at this, time permitting.

>> I read about various tools to help with auto-converting files to kind
>> of help speed up the process, but I couldn't find what seemed a
>> canonical answer to what to use as a helper. Is there one? (Perhaps
>> this was only for DocBook?)
>
> The tools, such as they are, are for the conversion of DocBook template
> files.  Most of the kernel's .txt files are already in something quite
> close to RST already, so the conversion is trivial.
>
> The real question would be one of organization.  Most of the security
> stuff looks like it properly belongs in the admin guide, but that's not
> universally the case.

Are the index area "purposes" documented anywhere? The admin guide
seems to cover things outside of "administration" (like reporting
security bugs, which is a developer/researcher activity usually),
There's already a top-level "security documentation" with some TPM
stuff in it.

Both things in prctl/ are "here's what this feature is and how to use
it", both exposed to userspace. In security/ there is a mix of LSM
highlevel descriptions and basic usage, key API documentation, and the
one sort of design goal document ("self-protection.txt").

I think it'd make sense to keep Security Documentation as a top-level
index for now, and create LSM and keys subsections for those items,
and then move prctl/* under security:

         deleted:    Documentation/security/00-INDEX
         deleted:    Documentation/security/conf.py
       renamed:    Documentation/security/IMA-templates.txt ->
Documentation/security/IMA-templates.rst
        renamed:    Documentation/security/credentials.txt ->
Documentation/security/credentials.rst
        renamed:    Documentation/security/keys-ecryptfs.txt ->
Documentation/security/keys/ecryptfs.rst
        renamed:    Documentation/security/keys.txt ->
Documentation/security/keys/index.rst
        renamed:    Documentation/security/keys-request-key.txt ->
Documentation/security/keys/request-key.rst
        renamed:    Documentation/security/keys-trusted-encrypted.txt
-> Documentation/security/keys/trusted-encrypted.rst
        renamed:    Documentation/security/LoadPin.txt ->
Documentation/security/lsm/LoadPin.rst
        renamed:    Documentation/security/SELinux.txt ->
Documentation/security/lsm/SELinux.rst
        renamed:    Documentation/security/Smack.txt ->
Documentation/security/lsm/Smack.rst
        renamed:    Documentation/security/Yama.txt ->
Documentation/security/lsm/Yama.rst
        renamed:    Documentation/security/apparmor.txt ->
Documentation/security/lsm/apparmor.rst
        renamed:    Documentation/security/LSM.txt ->
Documentation/security/lsm/index.rst
        renamed:    Documentation/security/tomoyo.txt ->
Documentation/security/lsm/tomoyo.rst
        renamed:    Documentation/prctl/no_new_privs.txt ->
Documentation/security/no_new_privs.rst
        renamed:    Documentation/prctl/seccomp_filter.txt ->
Documentation/security/seccomp_filter.rst
        renamed:    Documentation/security/self-protection.txt ->
Documentation/security/self-protection.rst
        modified:   Documentation/security/index.rst

This is just renames and an update to security/index.rst to include
the two new subdirs. This doesn't have any formatting updates. (What
is preferred, organizational changes first or .rst formatting first?)

Does this looks sensible?

What do LSM authors think of this? (e.g. various questions: should
LSM.txt become lsm/index.rst and keys.txt become keys/index.rst? Maybe
key "LSM" case for the new subdirectory? Should IMA be under LSM?)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
