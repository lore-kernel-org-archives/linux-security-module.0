From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 02 Aug 2018 11:57:41 -0700
Subject: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <8060.1533226481@warthog.procyon.org.uk>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
	<8060.1533226481@warthog.procyon.org.uk>
Message-ID: <1533236261.12916.5.camel@HansenPartnership.com>
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
> interface, not one that's specifically tied to one piece of hardware
> -
> particularly if it's named with generic "secure".
> 
> Can you convert this into a "symmetric" type and make the backend
> pluggable?

This is a symmetric key backed by a piece of hardware, which is exactly
what trusted keys are, so if we're defining common infrastructure with
callouts, trusted keys should be part of it.

Additionally, when I look at the trusted key code, I have significant
qualms about using the TPM RNG exclusively in the same way CAAM wants
to use its own RNG.  What I think both should be doing is collecting
data from their local RNGs, mixing it into the kernel entropy pool and
using a kernel generated random number (just in case these RNGs
suddenly turn out to be less random than they should be).

James


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
