From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 3 May 2018 09:05:22 -0700
Subject: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
In-Reply-To: <87h8nospo5.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
	<87h8nqglpx.fsf@xmission.com>
	<1525275904.5669.308.camel@linux.vnet.ibm.com>
	<87h8nospo5.fsf@xmission.com>
Message-ID: <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/3/2018 8:51 AM, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>
>> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>>
>>>> Allow LSMs and IMA to differentiate between the kexec_load and
>>>> kexec_file_load syscalls by adding an "unnecessary" call to
>>>> security_kernel_read_file() in kexec_load.  This would be similar to the
>>>> existing init_module syscall calling security_kernel_read_file().
>>> Given the reasonable desire to load a policy that ensures everything
>>> has a signature I don't have fundamental objections.
>>>
>>> security_kernel_read_file as a hook seems an odd choice.  At the very
>>> least it has a bad name because there is no file reading going on here.
>>>
>>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
>>> anywhere.  Which means I could have a kernel compiled without that and I
>>> would be allowed to use kexec_file_load without signature checking.
>>> While kexec_load would be denied.
>>>
>>> Am I missing something here?
>> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
>> calls security_kernel_read_file(). ?So kexec_file_load and kexec_load
>> syscall would be using the same method for enforcing signature
>> verification.
> Having looked at your patches and the kernel a little more I think
> this should be a separate security hook that does not take a file
> parameter.
>
> Right now every other security module assumes !file is init_module.
> So I think this change has the potential to confuse other security
> modules, with the result of unintended policy being applied.
>
> So just for good security module hygeine I think this needs a dedicated
> kexec_load security hook.

I would rather see the existing modules updated than a new
hook added. Too many hooks spoil the broth. Two hooks with
trivial differences just add to the clutter and make it harder
for non-lsm developers to figure out what to use in their
code. 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
