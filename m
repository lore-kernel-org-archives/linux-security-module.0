From: zohar@linux.ibm.com (Mimi Zohar)
Date: Wed, 26 Sep 2018 14:03:34 -0400
Subject: [PATCH v2, RESEND 0/3] tpm: retrieve digest size of unknown
	algorithms from TPM
In-Reply-To: <1537972840.3459.6.camel@linux.ibm.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
	<1537972840.3459.6.camel@linux.ibm.com>
Message-ID: <1537985014.3459.24.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-09-26 at 10:40 -0400, Mimi Zohar wrote:
> On Mon, 2018-09-17 at 11:38 +0200, Roberto Sassu wrote:
> > Resending to maintainer with correct mailing lists in CC.
> > 
> > The TPM driver currently relies on the crypto subsystem to determine the
> > digest size of supported TPM algorithms. In the future, TPM vendors might
> > implement new algorithms in their chips, and those algorithms might not
> > be supported by the crypto subsystem.
> > 
> > Usually, vendors provide patches for the new hardware, and likely
> > the crypto subsystem will be updated before the new algorithm is
> > introduced. However, old kernels might be updated later, after patches
> > are included in the mainline kernel. This would leave the opportunity
> > for attackers to misuse PCRs, as PCR banks with an unknown algorithm
> > are not extended.
> > 
> > This patch set provides a long term solution for this issue. If a TPM
> > algorithm is not known by the crypto subsystem, the TPM driver retrieves
> > the digest size from the TPM with a PCR read. All the PCR banks are
> > extended, even if the algorithm is not yet supported by the crypto
> > subsystem.
> 
> Other than checking the digest size before copying the pcrread buffer,
> the patches look good. ?Please add my Ack on all 3 patches.
> 
> (New address) Acked-by: Mimi Zohar <zohar@linux.ibm.com>

I've reviewed, and am currently running with these patches.

Even if the IMA changes were in a separate patch, we wouldn't be able
to break up the patch set anyway. ?Jarkko, I'd appreciate your
carrying the entire patch set.

Roberto, a similar change needs to be made for tpm_pcr_extend. ?Are
you planning on posting those changes as well?

Mimi
