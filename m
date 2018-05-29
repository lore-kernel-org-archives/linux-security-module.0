From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 29 May 2018 16:10:30 -0500
Subject: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
In-Reply-To: <alpine.LRH.2.21.1805300629220.2647@namei.org> (James Morris's
	message of "Wed, 30 May 2018 06:32:16 +1000 (AEST)")
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87po1k2304.fsf@xmission.com>
	<alpine.LRH.2.21.1805260139030.11624@namei.org>
	<871sdzy0nv.fsf@xmission.com>
	<alpine.LRH.2.21.1805300629220.2647@namei.org>
Message-ID: <87y3g2kw1l.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Fri, 25 May 2018, Eric W. Biederman wrote:
>
>> James Morris <jmorris@namei.org> writes:
>> 
>> > On Thu, 24 May 2018, Eric W. Biederman wrote:
>> >
>> >> Below is where I suggest you start on sorting out these security hooks.
>> >> - Adding a security_kernel_arg to catch when you want to allow/deny the
>> >>   use of an argument to a syscall.  What security_kernel_file_read and
>> >>   security_kernel_file_post_read have been abused for.
>> >
>> > NAK. This abstraction is too semantically weak.
>> >
>> > LSM hooks need to map to stronger semantics so we can reason about what 
>> > the hook and the policy is supposed to be mediating.
>> 
>> I will take that as an extremely weak nack as all I did was expose the
>> existing code and what the code is currently doing.  I don't see how you
>> can NAK what is already being merged and used.
>
> It's a strong NAK.

We are either not understading each other or you have just strong NAK'd
part of the existing LSM api.  Not my proposal.

> LSM is a logical API, it provides an abstraction layer for security 
> policies to mediate kernel security behaviors.

The way it deals with firmware blobs and module loading is not logical.
It is some random pass a NULL pointer into some other security hook.

> Adding an argument to a syscall is not a security behavior.
>
> Loading a firmware file is.

It is a firmware blob not a file.  Perhaps the blob is stored as a file
on-disk, perhaps it is not.

The similar case with kexec never stores all of the data in a file.

Why module_init (which does not take a file) is calling a file based lsm
hook is also bizarre.


Perhaps that means all 3 of these cases should have their own void
security hooks.  Perhaps it means something else.  I just know the name
on the security hook, how it is getting called, and how it is getting
used simply do not agree.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
