From: zohar@linux.ibm.com (Mimi Zohar)
Date: Fri, 03 Aug 2018 07:58:02 -0400
Subject: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <8060.1533226481@warthog.procyon.org.uk>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
	<8060.1533226481@warthog.procyon.org.uk>
Message-ID: <1533297482.4337.373.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> Udit Agarwal <udit.agarwal@nxp.com> wrote:
> 
> > +==========
> > +Secure Key
> > +==========
> > +
> > +Secure key is the new type added to kernel key ring service.
> > +Secure key is a symmetric type key of minimum length 32 bytes
> > +and with maximum possible length to be 128 bytes. It is produced
> > +in kernel using the CAAM crypto engine. Userspace can only see
> > +the blob for the corresponding key. All the blobs are displayed
> > +or loaded in hex ascii.
> 
> To echo Mimi, this sounds suspiciously like it should have a generic
> interface, not one that's specifically tied to one piece of hardware -
> particularly if it's named with generic "secure".
> 
> Can you convert this into a "symmetric" type and make the backend pluggable?

TPM 1.2 didn't support symmetric keys. ?For this reason, the TPM
"unseals" the random number, used as a symmetric key, and returns the
"unsealed" data to the kernel.

Does anyone know if CAAM or TPM 2.0 have support for symmetric keys?
?If they have symmetric key support, there would be no need for the
symmetric key ever to leave the device in the clear. ?The device would
unseal/decrypt data, such as an encrypted key.

The "symmetric" key type would be a generic interface for different
devices.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
