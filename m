From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 10 Mar 2018 14:49:48 +0200
Subject: [RFC 0/5] add integrity and security to TPM2 transactions
In-Reply-To: <1520465374.4894.12.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
Message-ID: <18e2f4debbbc05ed4169d3eb263479df91941aa0.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-03-07 at 15:29 -0800, James Bottomley wrote:
> By now, everybody knows we have a problem with the TPM2_RS_PW easy
> button on TPM2 in that transactions on the TPM bus can be intercepted
> and altered.  The way to fix this is to use real sessions for HMAC
> capabilities to ensure integrity and to use parameter and response
> encryption to ensure confidentiality of the data flowing over the TPM
> bus.
> 
> This RFC is about adding a simple API which can ensure the above
> properties as a layered addition to the existing TPM handling code.
>  Eventually we can add this to the random number generator, the PCR
> extensions and the trusted key handling, but this all depends on the
> conversion to tpm_buf which is not yet upstream, so I've constructed a
> second patch which demonstrates the new API in a test module for those
> who wish to play with it.
> 
> This series is also dependent on additions to the crypto subsystem to
> fix problems in the elliptic curve key handling and add the Cipher
> FeedBack encryption scheme:
> 
> https://marc.info/?l=linux-crypto-vger&m=151994371015475
> 
> In the second version, I added security HMAC to our PCR extend and
> encryption to the returned random number generators and also extracted
> the parsing and tpm2b construction API into a new file.
> 
> James

Might take up until end of next week before I have time to try this out.
Anyway, I'll see if I get this running on my systems before at the code
that much.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
