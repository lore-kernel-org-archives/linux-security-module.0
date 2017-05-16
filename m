From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 16 May 2017 21:57:36 +0200
Subject: selinux: Use an other error code for an input validation failure
	in sidtab_insert()
In-Reply-To: <CAHC9VhQY7-Ls5bX_wbna1S6PjV2Ck_1+AR5R8Pngn1tivXxCdg@mail.gmail.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
	<38273216-97ad-7955-941a-68485534d39f@users.sourceforge.net>
	<CAHC9VhQY7-Ls5bX_wbna1S6PjV2Ck_1+AR5R8Pngn1tivXxCdg@mail.gmail.com>
Message-ID: <bd7cc69d-0b1b-010a-0a07-c287d25b8d6c@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> Have you tested this to determine any impact it may have on the
> SELinux userspace?

Not yet.


> I would agree that EINVAL is probably more appropriate in this case,

Thanks that a part of your view seems to fit also to mine.


> but changing this return code has very little value

I would appreciate if this aspect can clarified a bit more.


> and may disrupt userspace if it assumes EINVAL means something else
> when the policy load fails.

Would you find an other error code better there?

Do you care to distinguish an input validation failure in a specific
function implementation from other error situations?

Regards,
Markus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
