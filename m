From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sun, 04 Jun 2017 17:38:28 +0200
Subject: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP
	API
In-Reply-To: <1638.1496419102@warthog.procyon.org.uk>
References: <20170511003557.3467-1-mathew.j.martineau@linux.intel.com>
	<1638.1496419102@warthog.procyon.org.uk>
Message-ID: <2210575.YAdSgJatlP@tauon.chronox.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Am Freitag, 2. Juni 2017, 17:58:22 CEST schrieb David Howells:

Hi David,

> Note that I haven't included Eric's DH patch that was obsoleted by Stephan's
> patch that was obsoleted by this one.

Eric's patches 1, 2, 4, and 5 should be pulled as they are unrelated to any 
other patch. Eric's patch 3 should be disregarded, my patch in response to 
Eric's patch 3 should be disregarded, and this patch from Mat should be used.

Thanks a lot.

Ciao
Stephan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
