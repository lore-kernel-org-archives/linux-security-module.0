From: sbuisson.ddn@gmail.com (Sebastien Buisson)
Date: Wed, 12 Apr 2017 17:19:14 +0200
Subject: [PATCH] selinux: add selinux_is_enforced() function
In-Reply-To: <1492005519.3881.8.camel@tycho.nsa.gov>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
	<CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
	<CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
	<1492005519.3881.8.camel@tycho.nsa.gov>
Message-ID: <CAPkE-bUCK2kFpi6Ls2VYPRDH624xgiu3GGnw5LyeFAfswiaeSA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-04-12 15:58 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> Even your usage of selinux_is_enabled() looks suspect; that should
> probably go away.  Only other user of it seems to be some cred validity
> checking that could be dropped as well.

Well the main reason for calling selinux_is_enabled() is performance
optimization.
Should I propose a patch to add a new security_is_enabled() function
at the LSM abstraction layer? Or do you consider we should not test
security enabled at all?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
