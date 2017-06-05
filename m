From: dhowells@redhat.com (David Howells)
Date: Mon, 05 Jun 2017 11:03:32 +0100
Subject: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP
	API
In-Reply-To: <2210575.YAdSgJatlP@tauon.chronox.de>
References: <2210575.YAdSgJatlP@tauon.chronox.de>
	<20170511003557.3467-1-mathew.j.martineau@linux.intel.com>
	<1638.1496419102@warthog.procyon.org.uk>
Message-ID: <30301.1496657012@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stephan M?ller <smueller@chronox.de> wrote:

> > Note that I haven't included Eric's DH patch that was obsoleted by Stephan's
> > patch that was obsoleted by this one.
> 
> Eric's patches 1, 2, 4, and 5 should be pulled as they are unrelated to any 
> other patch. Eric's patch 3 should be disregarded, my patch in response to 
> Eric's patch 3 should be disregarded, and this patch from Mat should be used.

Indeed.  But Mat's patch doesn't apply.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
