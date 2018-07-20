From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Fri, 20 Jul 2018 10:40:42 +0200
Subject: [PATCH 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <20180720054656.29143-1-udit.agarwal@nxp.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
Message-ID: <1532076042.3511.203.camel@pengutronix.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-07-20 at 11:16 +0530, Udit Agarwal wrote:
> +==========
> +Secure Key
> +==========
> +
> +Secure key is the new type added to kernel key ring service.
> +Secure key is a symmetric type key of minimum length 32 bytes
> +and with maximum possible length to be 128 bytes. It is produced
> +in kernel using the CAAM crypto engine. Userspace can only see
> +the blob for the corresponding key. All the blobs are displayed
> +or loaded in hex ascii.
> +
> +Secure key can only be created on platforms which supports CAAM
> +hardware block. Secure key can also be used as a master key to
> +create the encrypted keys along with the existing key types in
> +kernel.
> +
> +Secure key uses CAAM hardware to generate the key and blobify its
> +content for userspace. Generated blobs are tied up with the hardware
> +secret key stored in CAAM, hence the same blob will not be able to
> +de-blobify with the different secret key on another machine.

Thanks for working on this, so far we've been using this functionality
via a custom sysfs interface. Proper integration into the keyring
framework would be very nice!

Some questions which might influence the userspace api design:

- If I remember correctly, CAAM key blobs contain flags which specify
if the key can be exported from the CAAM after unwrapping or not (then
it stays in one of the internal key registers). Which mode do you use?

- If that's not already supported by this series, do you intend to make
secure keys (in the non-exportable-mode) usable for encryption/
decryption, so they could be used for dm-crypt? If so, you'd probably
need some resource management in the CAAM driver, as the number of key
registers is limited.

- Secure keys could also be implemented using OP-TEE for example, so
the documentation shouldn't be CAAM-specific and only use it as an
example.

Are there corresponding changes to the CAAM driver needed to test this?

Best regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
