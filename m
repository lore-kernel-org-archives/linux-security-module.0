From: keescook@chromium.org (Kees Cook)
Date: Mon, 4 Jun 2018 15:03:01 -0700
Subject: [PATCH v4 0/8] kexec/firmware: support system wide policy
	requiring signatures
In-Reply-To: <1528121025.3237.116.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1528121025.3237.116.camel@linux.vnet.ibm.com>
Message-ID: <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jun 4, 2018 at 7:03 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
>> Instead of adding the security_kernel_read_file LSM hook - or defining a
>> wrapper for security_kernel_read_file LSM hook and adding it, or
>> renaming the existing hook to security_kernel_read_data() and adding it
>> - in places where the kernel isn't reading a file, this version of the
>> patch set defines a new LSM hook named security_kernel_load_data().
>>
>> The new LSM hook does not replace the existing security_kernel_read_file
>> LSM hook, which is still needed, but defines a new LSM hook allowing
>> LSMs and IMA-appraisal the opportunity to fail loading userspace
>> provided file/data.
>>
>> The only difference between the two LSM hooks is the LSM hook name and a
>> file descriptor.  Whether this is cause enough for requiring a new LSM
>> hook, is left to the security community.
>
> Paul does not have a preference as to adding a new LSM hook or calling
> the existing hook.  Either way is fine, as long as both the new and
> existing hooks call the existing function.
>
> Casey didn't like the idea of a wrapper.
> James suggested renaming the LSM hook.
>
> The maintainers for the callers of the LSM hook prefer a meaningful
> LSM hook name.  The "null" argument is not as much of a concern.  Only
> Eric seems to be asking for a separate, new LSM hook, without the
> "null" argument.
>
> Unless someone really objects, to accommodate Eric we'll define a new
> LSM hook named security_kernel_load_data.  Eric, are you planning on
> Ack'ing patches 1 & 2?

I'm sorry I'm late to review this series. Reading through what you
have, it seems like the existing hook is fine. If the name has
slipped, we can rename it, but I think adding another hook for the
same logical action (loading something into the kernel) is confusing.

It seems that only patches needed are 2 & 4 (new hook callsites), 5, 6
& 7 (IMA coverage and policy). 1 and 8 seem needless to me. If the
objection is that isn't use on non-file objects, sure, rename it. But
I don't see a _logical_ difference between the proposed and existing
callsites. enum kernel_read_file_id covers the "type" already....

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
