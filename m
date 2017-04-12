From: sbuisson.ddn@gmail.com (Sebastien Buisson)
Date: Wed, 12 Apr 2017 15:30:02 +0200
Subject: [PATCH] selinux: add selinux_is_enforced() function
In-Reply-To: <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
	<CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
Message-ID: <CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-04-12 13:55 GMT+02:00 Paul Moore <pmoore@redhat.com>:
> As currently written this code isn't something we would want to merge
> upstream for two important reasons:
>
> * No abstraction layer at the LSM interface.  The core kernel code
> should not call directly into any specific LSM, all interaction should
> go through the LSM hooks.

The idea behind this patch and the other one was to replicate what is
done with selinux_is_enabled(). As I understand it now,
selinux_is_enabled() should remain the only exception to the LSM
hooks.
So do you agree if I propose a new security_is_enforced() function at
the LSM abstraction layer, which will be hooked to a
selinux_is_enforced() function defined inside the SELinux LSM?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
