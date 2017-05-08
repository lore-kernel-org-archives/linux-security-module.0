From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 8 May 2017 17:26:00 +0200
Subject: IMA: Fine-tuning for three function implementations
In-Reply-To: <1494253597.4078.13.camel@linux.vnet.ibm.com>
References: <416e6b01-7abb-d894-3bd6-d8bda05ed6b2@users.sourceforge.net>
	<1494253597.4078.13.camel@linux.vnet.ibm.com>
Message-ID: <3593c4af-1957-715b-8080-381e53f3277a@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> Sorry, these changes make backporting and upstreaming other changes
> more difficult without much benefit.

I guess that they show general development challenges for further
software evolution as usual.
Would it be nice to achieve a bit more code reduction and improved
run time characteristics also for the affected logging functions?

Regards,
Markus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
