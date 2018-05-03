From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 03 May 2018 10:51:38 -0500
Subject: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
In-Reply-To: <1525275904.5669.308.camel@linux.vnet.ibm.com> (Mimi Zohar's
	message of "Wed, 02 May 2018 11:45:04 -0400")
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
	<87h8nqglpx.fsf@xmission.com>
	<1525275904.5669.308.camel@linux.vnet.ibm.com>
Message-ID: <87h8nospo5.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > Allow LSMs and IMA to differentiate between the kexec_load and
>> > kexec_file_load syscalls by adding an "unnecessary" call to
>> > security_kernel_read_file() in kexec_load.  This would be similar to the
>> > existing init_module syscall calling security_kernel_read_file().
>> 
>> Given the reasonable desire to load a policy that ensures everything
>> has a signature I don't have fundamental objections.
>> 
>> security_kernel_read_file as a hook seems an odd choice.  At the very
>> least it has a bad name because there is no file reading going on here.
>> 
>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
>> anywhere.  Which means I could have a kernel compiled without that and I
>> would be allowed to use kexec_file_load without signature checking.
>> While kexec_load would be denied.
>> 
>> Am I missing something here?
>
> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
> calls security_kernel_read_file(). ?So kexec_file_load and kexec_load
> syscall would be using the same method for enforcing signature
> verification.

Having looked at your patches and the kernel a little more I think
this should be a separate security hook that does not take a file
parameter.

Right now every other security module assumes !file is init_module.
So I think this change has the potential to confuse other security
modules, with the result of unintended policy being applied.

So just for good security module hygeine I think this needs a dedicated
kexec_load security hook.


> This is independent of the architecture specific method for verifying
> signatures. ?The coordination between these two methods was included
> in the lockdown patch set, but is being removed, as well the gating of
> kexec_load syscall. ?Instead of being based on the lockdown flag, I
> assume the coordination between the two methods will reappear based on
> a secure boot flag of some sort.

I was blind there for a moment.  Yes this is all about the ima xattrs
allowing a file to be loaded.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
