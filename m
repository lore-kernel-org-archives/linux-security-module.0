From: jejb@linux.vnet.ibm.com (James Bottomley)
Date: Mon, 12 Mar 2018 11:09:18 -0700
Subject: [tpmdd-devel] in-kernel user of ecdsa
In-Reply-To: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
References: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
Message-ID: <1520878158.4522.31.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-12 at 19:07 +0200, Tudor Ambarus wrote:
> Hi,
> 
> Would you consider using ECDSA in the kernel module signing facility?
> When compared with RSA, ECDSA has shorter keys, the key generation
> process is faster, the sign operation is faster, but the verify
> operation is slower than with RSA.

You missed the keyrings list, which is where the module signing utility
is discussed.

First question is, have you actually tried? ?It looks like sign-file
doesn't do anything RSA specific so if you give it an EC X.509
certificate it will produce an ECDSA signature.

I think our kernel internal x509 parsers don't have the EC OIDs, so
signature verification will fail; but, especially since we have the
rest of the EC machinery in the crypto subsystem, that looks to be
simply fixable.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
