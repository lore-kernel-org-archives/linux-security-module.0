From: sbuisson.ddn@gmail.com (Sebastien Buisson)
Date: Wed, 12 Apr 2017 19:07:09 +0200
Subject: [PATCH] selinux: add selinux_is_enforced() function
In-Reply-To: <1492014294.3881.14.camel@tycho.nsa.gov>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
	<CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
	<CAPkE-bX5-Mo9AMPwf6dwBNT9FeWgAShWwKbkiJg3ZZVpt9itLA@mail.gmail.com>
	<1492007701.3881.10.camel@tycho.nsa.gov>
	<CAPkE-bWQLfSq0+J0uoMRKAPbSdO0giuGZzfRXA7VXL+xo3fNgg@mail.gmail.com>
	<1492014294.3881.14.camel@tycho.nsa.gov>
Message-ID: <CAPkE-bWrxxtcb5bUpSV07CUBGGxMt7y+OrAd9Qvk0o4-Lo26VA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-04-12 18:24 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> Maybe you want to register a notifier callback on policy reload? See
> the archives for the SELinux support for Infiniband RDMA patches (which
> seem to have stalled), which included LSM hooks and SELinux
> implementation to support notifications on policy reloads.

I need to have a look indeed. So it is a callback in kernelspace?

>> As I understand it, a userspace program can directly read the policy
>> info exposed by the kernel by reading this file. But how about
>> reading it from kernelspace?
>
> This seems very inefficient though for your purposes.  Wouldn't it be
> better to just extend SELinux to compute the checksum from the original
> image when the policy is loaded, save that checksum in the policydb,
> and provide you with a way to fetch the already computed checksum?  The
> computation would be done in security_load_policy() and saved in the
> policydb.  Then you could introduce a function and a LSM hook to export
> it to your code. We would probably want to also expose it via a
> selinuxfs node to userspace.

This is an excellent suggestion. It makes much more sense to have the
checksum computed on SELinux side when a policy is loaded. And then
just read this checksum when needed, both from kernel and userspace.

> This however only works for checking that you have a completely
> identical policy built in exactly the same way.  You could have
> semantically identical policies that still differ in the binary policy
> file, or policies with minor local customizations that aren't
> significant.  But perhaps that isn't an issue for Lustre environments.

If we can protect against local customizations this is great. What
could be the other scenario leading to different binary policies while
being semantically identical?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
