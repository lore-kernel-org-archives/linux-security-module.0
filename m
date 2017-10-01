From: serge@hallyn.com (Serge E. Hallyn)
Date: Sun, 1 Oct 2017 14:54:37 -0500
Subject: [RFC][PATCH] security: Make the selinux setxattr and removexattr
	hooks behave
In-Reply-To: <fa55814b-469d-65a5-16dc-3641614b8a18@schaufler-ca.com>
References: <87tvzmqwoi.fsf@xmission.com>
	<1913d5c4-64ef-36c1-e8ad-c779ff5c7995@schaufler-ca.com>
	<1506694737.5571.9.camel@tycho.nsa.gov>
	<6f293107-6ff9-c4c7-f682-207a546c5061@schaufler-ca.com>
	<87vak0ma00.fsf@xmission.com>
	<db1c58f3-5a01-5276-eba7-5aac7cdcbcf5@schaufler-ca.com>
	<87d167ncms.fsf@xmission.com>
	<bf18e641-91ed-0d75-f514-c059b5dfbb14@schaufler-ca.com>
	<87tvzjllyu.fsf@xmission.com>
	<fa55814b-469d-65a5-16dc-3641614b8a18@schaufler-ca.com>
Message-ID: <20171001195437.GA2475@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 01, 2017 at 11:52:29AM -0700, Casey Schaufler wrote:
> I'm kind of surprised that the capability changes got sent
> upstream without SELinux ever being tested. That's a very common
> configuration in the Android enabled world.

hm, I'm sorry about that.  I'd intended years ago to get ubuntu with selinux
running again, but never found enough time.  Perhaps i should set up an Oracle
linux VM for such testing.  Would be useful in several ways..

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
