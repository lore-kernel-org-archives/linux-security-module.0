From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 12 Apr 2017 17:12:13 -0700
Subject: [PATCH] selinux: add selinux_is_enforced() function
In-Reply-To: <1492014798.3881.16.camel@tycho.nsa.gov>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
	<CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
	<CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
	<1492005519.3881.8.camel@tycho.nsa.gov>
	<CAPkE-bUCK2kFpi6Ls2VYPRDH624xgiu3GGnw5LyeFAfswiaeSA@mail.gmail.com>
	<1492014798.3881.16.camel@tycho.nsa.gov>
Message-ID: <2ad46d79-6e81-998d-3d8b-ed26c3d52a95@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/12/2017 9:33 AM, Stephen Smalley wrote:
> On Wed, 2017-04-12 at 17:19 +0200, Sebastien Buisson wrote:
>> 2017-04-12 15:58 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
>>> Even your usage of selinux_is_enabled() looks suspect; that should
>>> probably go away.  Only other user of it seems to be some cred
>>> validity
>>> checking that could be dropped as well.
>> Well the main reason for calling selinux_is_enabled() is performance
>> optimization.
>> Should I propose a patch to add a new security_is_enabled() function
>> at the LSM abstraction layer? Or do you consider we should not test
>> security enabled at all?
> It isn't clear what "is enabled" means in general, particularly with
> stacking. I would either drop it or replace it with a LSM hook that is
> more precise.  For example, NFSv4 introduced a security_ismaclabel()
> hook so that it could test whether a given security.* xattr is a MAC
> label.

You can determine what security modules are enabled
by reading /sys/kernel/security/lsm in userspace (4.11 feature).

Your kernel code *really* shouldn't care what security
modules are enabled. If you do care, you've designed poorly.
If you're trying to ensure consistent policy between members
of your cluster you're better off doing that in user space
than in the kernel.

>
> _______________________________________________
> Selinux mailing list
> Selinux at tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave at tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request at tycho.nsa.gov.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
