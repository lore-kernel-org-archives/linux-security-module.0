From: jikos@kernel.org (Jiri Kosina)
Date: Thu, 26 Apr 2018 10:20:29 +0200 (CEST)
Subject: [PATCH 07/24] hibernate: Disable when the kernel is locked
 down
In-Reply-To: <20180426072646.GA31822@amd>
References: <20180413202234.GA4484@amd>
	<152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
	<27926.1524148733@warthog.procyon.org.uk>
	<20180426072646.GA31822@amd>
Message-ID: <nycvar.YFH.7.76.1804261018030.28147@cbobk.fhfr.pm>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 26 Apr 2018, Pavel Machek wrote:

> That's not how the crypto needs to work. Talk to Jiri Kosina, ok?

Yeah, Joey Lee (adding to CC) implemented it here:

	https://lkml.org/lkml/2015/8/11/47

I think there have been more respins, Joey definitely knows more details 
and status quo.

The design is specifically tailored for secure-boot environments though.

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
