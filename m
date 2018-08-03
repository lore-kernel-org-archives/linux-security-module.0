From: dhowells@redhat.com (David Howells)
Date: Fri, 03 Aug 2018 15:55:42 +0100
Subject: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <1533307535.4337.415.camel@linux.ibm.com>
References: <1533307535.4337.415.camel@linux.ibm.com>
	<20180723111432.26830-1-udit.agarwal@nxp.com>
	<8060.1533226481@warthog.procyon.org.uk>
	<1533297482.4337.373.camel@linux.ibm.com>
	<1533306238.4140.1.camel@HansenPartnership.com>
Message-ID: <25968.1533308142@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> "trusted" keys are currently being used to decrypt other keys (eg.
> encrypted, ecryptfs, ...).

Can it decrypt both symmetric and asymmetric keys?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
