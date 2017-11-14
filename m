From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Tue, 14 Nov 2017 07:09:34 -0800
Subject: [paul@keyserver.paulfurley.com: PGP key expires in 3 days:
	0x7179B76704ABA18B (it can be extended)]
In-Reply-To: <20171114062354.j4nrch5xmevllb4l@linux.intel.com>
References: <20171114062354.j4nrch5xmevllb4l@linux.intel.com>
Message-ID: <1510672174.4078.2.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-11-14 at 08:25 +0200, Jarkko Sakkinen wrote:
> James,
> 
> Refreshed my key with expiration +2y in keys.gunpg.net and
> pgp.mit.edu.
> Please update.

The way this works in the main tree is that nothing happens until Linus
sees a tag signed with an expired key (which git refuses to pull).
?Then he swears a bit, does a pgp refresh and pulls again.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
