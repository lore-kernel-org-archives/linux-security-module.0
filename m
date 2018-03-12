From: smueller@chronox.de (Stephan Mueller)
Date: Mon, 12 Mar 2018 22:57:28 +0100
Subject: [tpmdd-devel] in-kernel user of ecdsa
In-Reply-To: <1520891735.4522.45.camel@linux.vnet.ibm.com>
References: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
	<31045526.HZb3ddfbbg@tauon.chronox.de>
	<1520891735.4522.45.camel@linux.vnet.ibm.com>
Message-ID: <4913167.EB42K91l1O@tauon.chronox.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Am Montag, 12. M?rz 2018, 22:55:35 CET schrieb James Bottomley:

Hi James,

> > ECDSA is not implemented currently in the kernel crypto API.
> 
> an ECDSA signature is produced as a ECDH operation using the DSA
> algorithm instead of KDFe, so it's trivial with what we have; signature
> verification involves a separate point addition but we have all the
> primitives for this in crypto/ecc.c so adding it isn't really
> difficult, is it?

No, it is not. There even was a patch posted about a year ago to add ECDSA. 
But it was rejected due to missing in-kernel users. I guess that patch could 
be reactivated.

Ciao
Stephan


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
