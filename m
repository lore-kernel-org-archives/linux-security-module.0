From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 18 May 2018 07:30:50 -0400
Subject: [PATCH v2 3/9] security: define security_kernel_read_blob()
	wrapper
In-Reply-To: <87y3ghhbws.fsf@xmission.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	<74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
	<87y3ghhbws.fsf@xmission.com>
Message-ID: <1526643050.3632.127.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-05-17 at 22:37 -0500, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
> 
> > On 5/17/2018 7:48 AM, Mimi Zohar wrote:
> >> In order for LSMs and IMA-appraisal to differentiate between the original
> >> and new syscalls (eg. kexec, kernel modules, firmware), both the original
> >> and new syscalls must call an LSM hook.
> >>
> >> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
> >> introduced calling security_kernel_module_from_file() in both the original
> >> and new syscalls.  Commit a1db74209483 ("module: replace
> >> copy_module_from_fd with kernel version") replaced these LSM calls with
> >> security_kernel_read_file().
> >>
> >> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
> >> with kernel version") and commit b804defe4297  ("kexec: replace call to
> >> copy_file_from_fd() with kernel version") replaced their own version of
> >> reading a file from the kernel with the generic
> >> kernel_read_file_from_path/fd() versions, which call the pre and post
> >> security_kernel_read_file LSM hooks.
> >>
> >> Missing are LSM calls in the original kexec syscall and firmware sysfs
> >> fallback method.  From a technical perspective there is no justification
> >> for defining a new LSM hook, as the existing security_kernel_read_file()
> >> works just fine.  The original syscalls, however, do not read a file, so
> >> the security hook name is inappropriate.  Instead of defining a new LSM
> >> hook, this patch defines security_kernel_read_blob() as a wrapper for
> >> the existing LSM security_kernel_file_read() hook.
> >
> > What a marvelous opportunity to bikeshed!
> >
> > I really dislike adding another security_ interface just because
> > the name isn't quite right. Especially a wrapper, which is just
> > code and execution overhead. Why not change security_kernel_read_file()
> > to security_kernel_read_blob() everywhere and be done?
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Nack on this sharing nonsense.  These two interfaces do not share any
> code in their implementations other than the if statement to distinguish
> between the two cases.
> 
> Casey you are wrong.  We need something different here.
> 
> Mimi a wrapper does not cut it.   The code is not shared.  Despite using
> a single function call today.
> 
> If we want comprehensible and maintainable code in the security modules
> we need to split these two pieces of functionality apart.

kernel_read_file() is a common, generic method of reading a file from
the kernel, which is being called from a number of places. ?The
kernel_read_file_id enumeration is needed to differentiate between the
callers. ?The purpose of the new security_kernel_read_file() calls is
not for the kernel to read a file, but as a method of identifying the
original buffer based methods containing a file.

Having to define a separate LSM hook for each of the original, non
kernel_read_file(), buffer based method callers, kind of makes sense,
as the callers themselves are specific, but is it really necessary?
Could we define a new, generic LSM hook named
security_kernel_buffer_data() for this purpose?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
