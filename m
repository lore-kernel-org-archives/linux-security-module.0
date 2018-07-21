From: udit.agarwal@nxp.com (Udit Agarwal)
Date: Sat, 21 Jul 2018 14:44:15 +0000
Subject: [PATCH 1/2] security/keys/secure_key: Adds the secure key support
	based on CAAM.
In-Reply-To: <1532076042.3511.203.camel@pengutronix.de>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
	<1532076042.3511.203.camel@pengutronix.de>
Message-ID: <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

Thanks for sharing the documentation changes and feedback.

Below are the answers to the questions:

1. Currently the secure key patch series has been added  to support only data blobs.
It is not supporting key blobs as of now, we have thought of adding that support in future.

2. Yes secure keys could also be implemented using OPTEE. I will change the 
documentation in next patch version.

Best regards,
Udit Agarwal


> -----Original Message-----
> From: Jan L??bbe [mailto:jlu at pengutronix.de]
> Sent: Friday, July 20, 2018 2:11 PM
> To: Udit Agarwal <udit.agarwal@nxp.com>; dhowells at redhat.com;
> zohar at linux.vnet.ibm.com; jmorris at namei.org; serge at hallyn.com; linux-
> integrity at vger.kernel.org; keyrings at vger.kernel.org; linux-security-
> module at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: Sahil Malhotra <sahil.malhotra@nxp.com>
> Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key support based on
> CAAM.
> 
> On Fri, 2018-07-20 at 11:16 +0530, Udit Agarwal wrote:
> > +==========
> > +Secure Key
> > +==========
> > +
> > +Secure key is the new type added to kernel key ring service.
> > +Secure key is a symmetric type key of minimum length 32 bytes and
> > +with maximum possible length to be 128 bytes. It is produced in
> > +kernel using the CAAM crypto engine. Userspace can only see the blob
> > +for the corresponding key. All the blobs are displayed or loaded in
> > +hex ascii.
> > +
> > +Secure key can only be created on platforms which supports CAAM
> > +hardware block. Secure key can also be used as a master key to create
> > +the encrypted keys along with the existing key types in kernel.
> > +
> > +Secure key uses CAAM hardware to generate the key and blobify its
> > +content for userspace. Generated blobs are tied up with the hardware
> > +secret key stored in CAAM, hence the same blob will not be able to
> > +de-blobify with the different secret key on another machine.
> 
> Thanks for working on this, so far we've been using this functionality via a custom sysfs
> interface. Proper integration into the keyring framework would be very nice!
> 
> Some questions which might influence the userspace api design:
> 
> - If I remember correctly, CAAM key blobs contain flags which specify if the key can be
> exported from the CAAM after unwrapping or not (then it stays in one of the internal key
> registers). Which mode do you use?
> 
> - If that's not already supported by this series, do you intend to make secure keys (in the
> non-exportable-mode) usable for encryption/ decryption, so they could be used for dm-
> crypt? If so, you'd probably need some resource management in the CAAM driver, as the
> number of key registers is limited.
> 
> - Secure keys could also be implemented using OP-TEE for example, so the
> documentation shouldn't be CAAM-specific and only use it as an example.
> 
> Are there corresponding changes to the CAAM driver needed to test this?
> 
> Best regards,
> Jan
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutronix
> .de%2F&amp;data=02%7C01%7Cudit.agarwal%40nxp.com%7C01d1208748da4a2ae32308
> d5ee1c8189%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6366767285677184
> 93&amp;sdata=rRxZTlc%2BbrvD9VGL6fWlxS%2BcLWIt0RqEv1VT0zCLEs4%3D&amp;
> reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
