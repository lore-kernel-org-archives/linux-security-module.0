From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 24 May 2018 19:29:52 -0400
Subject: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
In-Reply-To: <87po1k2304.fsf@xmission.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87po1k2304.fsf@xmission.com>
Message-ID: <1527204592.3424.132.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-05-24 at 15:49 -0500, Eric W. Biederman wrote:
> I already nacked this approach because the two cases don't
> share a bit of code.  When I looked closer it was even crazier.

It hasn't been clear what you meant by "the two cases don't share a
bit of code".??The first attempt called
security_kernel_read_file().??As per your comments, kexec_load doesn't
load a file.??Thinking it was a naming issue the second attempt
defined a wrapper named security_kernel_read_blob() for
security_kernel_read_file().??Still thinking it was a naming issue,
this attempt renamed the security_kernel_read_file() to
security_kernel_read_data().

> 
> The way ima uses this hook and the post_load hook today is a travesty.

Instead of having multiple functions, each a bit different, for
reading a file from the kernel, kernel_read_file() is a generic
implementation with both pre and post security calls.

 I think the pre and post security kernel_read_file() LSM hooks are
quite well thought out. ?The security_kernel_read_file is called
before the kernel reads the file. ?The security_kernel_post_read_file
is called after the kernel reads the file.

> The way the security_kernel_file_read and security_kernel_file_post_read
> are called today and are used by ima don't make the least little bit of
> sense.
> 
> Abusing security_kernel_file_read in the module loader and then abusing
> security_kernel_file_post_read in the firmware loader is insane.  The
> loadpin lsm could not even figure this out and so it failed to work
> because of these shenanighans.
> 
> Only implementing kernel_file_read to handle the !file case is pretty
> much insane.   There is no way this should be expanded to cover kexec
> until the code actually makes sense.  We need a maintainable kernel.

It wasn't implemented *only* for the IMA !file case, but as a generic
mechanism.??True, IMA is only using the security_kernel_read_file hook
for detecting !file, but the security_kernel_post_read_file hook is
used for verifying the file's integrity.

> Below is where I suggest you start on sorting out these security hooks.
> - Adding a security_kernel_arg to catch when you want to allow/deny the
>   use of an argument to a syscall.  What security_kernel_file_read and
>   security_kernel_file_post_read have been abused for.

Assuming we define a new LSM hook named "security_kernel_arg", would
we also define a new enumeration or could we still use the existing
kernel_read_file_id?

> 
> - Removing ima_file_read because it is completely subsumed by the new
>   call.

The existing IMA function wouldn't be removed, but renamed to whatever
the new LSM hook is named.

> 
> - Please note with adding this new hook there is no code shared between
>   the cases, and the lsm code becomes simpler shorter when it can assume
>   security_kernel_file_post_read always takes a struct file.  (Even with
>   the addition of a new security hook).

We would be defining a new LSM hook, not removing the existing
security_kernel_read_file hook, and only renaming the IMA usage of the
hook.

If defining a new LSM hook named security_kernel_arg makes you happy,
I don't have a problem with implementing it.

James, Casey, are you Ok with this?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
