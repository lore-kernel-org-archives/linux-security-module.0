From: jmorris@namei.org (James Morris)
Date: Sat, 26 May 2018 01:41:52 +1000 (AEST)
Subject: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
In-Reply-To: <87po1k2304.fsf@xmission.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87po1k2304.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805260139030.11624@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 24 May 2018, Eric W. Biederman wrote:

> Below is where I suggest you start on sorting out these security hooks.
> - Adding a security_kernel_arg to catch when you want to allow/deny the
>   use of an argument to a syscall.  What security_kernel_file_read and
>   security_kernel_file_post_read have been abused for.

NAK. This abstraction is too semantically weak.

LSM hooks need to map to stronger semantics so we can reason about what 
the hook and the policy is supposed to be mediating.

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
