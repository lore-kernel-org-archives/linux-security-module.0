From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 12 Mar 2018 08:57:13 -0700
Subject: [PATCH v3 0/6] add integrity and security to TPM2 transactions
In-Reply-To: <4aa8a4daf4b2f9f76f86b07bbdcb2f4c06b69a98.camel@linux.intel.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
	<4aa8a4daf4b2f9f76f86b07bbdcb2f4c06b69a98.camel@linux.intel.com>
Message-ID: <1520870233.4522.20.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-12 at 12:58 +0200, Jarkko Sakkinen wrote:
> On Sat, 2018-03-10 at 14:13 -0800, James Bottomley wrote:
> > 
> > By now, everybody knows we have a problem with the TPM2_RS_PW easy
> > button on TPM2 in that transactions on the TPM bus can be
> > intercepted
> > and altered.??The way to fix this is to use real sessions for HMAC
> > capabilities to ensure integrity and to use parameter and response
> > encryption to ensure confidentiality of the data flowing over the
> > TPM
> > bus.
> > 
> > This patch series is about adding a simple API which can ensure the
> > above properties as a layered addition to the existing TPM handling
> > code.??This series now includes protections for PCR extend, getting
> > random numbers from the TPM and data sealing and unsealing.??It
> > therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
> > encryption protection to sensitive data flowing into and out of the
> > TPM.
> > 
> > This series is also dependent on additions to the crypto subsystem
> > to
> > fix problems in the elliptic curve key handling and add the Cipher
> > FeedBack encryption scheme:
> > 
> > https://marc.info/?l=linux-crypto-vger&m=151994371015475
> > 
> > In the third version I've added data sealing and unsealing
> > protection,
> > apart from one API based problem which means that the way trusted
> > keys
> > were protected it's not currently possible to HMAC protect an
> > authority
> > that comes with a policy, so the API will have to be extended to
> > fix
> > that case
> > 
> > I've verified this using the test suite in the last patch on a VM
> > connected to a tpm2 emulator.??I also instrumented the emulator to
> > make
> > sure the sensitive data was properly encrypted.
> > 
> > James
> 
> 1. Can I ignore v2 and just review/test this version? I haven't even
> ???peeked into v2 yet.

Yes, v3 is a more complete version of v2 with a couple of sessions API
additions.

I think the way I'm going to fix the trusted key policy problem is to
move it back into the kernel for the simple PCR lock policy (which will
make changing from 1.2 to 2.0 seamless because the external Key API
will then become the same) so the kernel gets the missing TPM nonce and
can then do TPM2_PolicyAuthValue.

User generated policy sessions for trusted keys are very flexible but
also a hugely bad idea for consumers because it's so different from the
way 1.2 works and it means now the user has to exercise a TPM API to
produce the policy sessions.

Longer term, I think having a particular trusted key represent a policy
session which can then be attached to a different trusted key
representing the blob is the best idea because we can expose the policy
build up via the trusted key API and keep all the TPM nastiness inside
the kernel.

> 2. Do you know in which kernel version will the crypto additions
> land?

They're here:

https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/

So I'd guess next merge window.  You can do what we do in SCSI and
create a "postmerge" branch based on the cryptodev one (we often have
SCSI stuff with block tree precursors). ?The way I run it is that I
don't send the merge window pull request until I see the merge-base
against Linus master move to the base of the patches (meaning all the
precursors are upstream).

> /Jarkko
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
