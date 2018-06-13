From: paul@paul-moore.com (Paul Moore)
Date: Wed, 13 Jun 2018 11:49:33 -0400
Subject: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
	<fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
	<alpine.LRH.2.21.1806130631400.13763@namei.org>
	<CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
	<3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
Message-ID: <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> Joe, in general I really appreciate the fixes you send, but these
>> patches that cross a lot of subsystem boundaries (this isn't the first
>> one that does this) causes unnecessary conflicts in -next and during
>> the merge window.  Could you split your patches up from now on please?
>
> Sorry. No.  Merge conflicts are inherent in this system.

Yes, merge conflicts are inherent in this system when one makes a
single change which impacts multiple subsystems, e.g. changing a core
kernel function which is called by multiple subsystems.  However, that
isn't what this patch does, it makes a number of self-contained
changes across multiple subsystems; there are no cross-subsystem
dependencies in this patch.  You are increasing the likelihood of
conflicts for no good reason; that is why I'm asking you to split this
patch and others like it.

> There is just no good way to do this as sending a set
> of per subsystem patches guarantees partial application
> of the entire set.

Please explain why all of these changes need to be made at the same
time?  Looking quickly at the patch it would appear that each chunk of
the patch could be applied independently and the kernel would still
build and operate correctly.  I'm not suggesting that you decompose
this patch with that level of granularity, that would be silly, but
splitting this patch (and many of the others you tend to submit) at
subsystem boundaries should be possible.

Further, as one could see from the responses of the other LSM
maintainers, splitting this patch is not just possible, it is
desirable.

> If you prefer, each sub-subsystem maintainer, at
> whatever granularity desired, could apply the patch
> to the appropriate subsystem by using
> "git am --include=<subsystem_path>".

Or you could split the patch up by subsystem before posting, like so
many other developers do already.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
