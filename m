From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 25 May 2018 14:51:00 -0500
Subject: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
In-Reply-To: <alpine.LRH.2.21.1805260139030.11624@namei.org> (James Morris's
	message of "Sat, 26 May 2018 01:41:52 +1000 (AEST)")
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87po1k2304.fsf@xmission.com>
	<alpine.LRH.2.21.1805260139030.11624@namei.org>
Message-ID: <871sdzy0nv.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Thu, 24 May 2018, Eric W. Biederman wrote:
>
>> Below is where I suggest you start on sorting out these security hooks.
>> - Adding a security_kernel_arg to catch when you want to allow/deny the
>>   use of an argument to a syscall.  What security_kernel_file_read and
>>   security_kernel_file_post_read have been abused for.
>
> NAK. This abstraction is too semantically weak.
>
> LSM hooks need to map to stronger semantics so we can reason about what 
> the hook and the policy is supposed to be mediating.

I will take that as an extremely weak nack as all I did was expose the
existing code and what the code is currently doing.  I don't see how you
can NAK what is already being merged and used.

I will be happy to see a better proposal.

The best I can see is to take each and every syscall that my patch
is calling syscall_kernel_arg and make it it's own hook without an
enumeration.  I did not see any real duplication between the cases in my
enumeration so I don't think that will be a problem.  Maybe a bit of a
challenge for loadpin but otherwise not.

Thank you in this for understanding why I am having problems with the
current hook.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
