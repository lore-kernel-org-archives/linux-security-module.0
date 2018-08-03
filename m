From: zohar@linux.ibm.com (Mimi Zohar)
Date: Fri, 03 Aug 2018 11:23:35 -0400
Subject: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <25968.1533308142@warthog.procyon.org.uk>
References: <1533307535.4337.415.camel@linux.ibm.com>
	<20180723111432.26830-1-udit.agarwal@nxp.com>
	<8060.1533226481@warthog.procyon.org.uk>
	<1533297482.4337.373.camel@linux.ibm.com>
	<1533306238.4140.1.camel@HansenPartnership.com>
	<25968.1533308142@warthog.procyon.org.uk>
Message-ID: <1533309815.4337.437.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-08-03 at 15:55 +0100, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > "trusted" keys are currently being used to decrypt other keys (eg.
> > encrypted, ecryptfs, ...).
> 
> Can it decrypt both symmetric and asymmetric keys?

Yes, the "trusted" key is returned to the caller and is used to
decrypt a datablob.

For an example, refer to?encrypted_key_decrypt(). ?The call
to?request_master_key() returns either the "trusted" or "user" type
key, which is used to decrypt the "enccrypted" key type.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
