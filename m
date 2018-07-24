From: zohar@linux.ibm.com (Mimi Zohar)
Date: Tue, 24 Jul 2018 09:34:50 -0400
Subject: [PATCH 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
	<1532302451.6206.22.camel@linux.ibm.com>
	<AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
Message-ID: <1532439290.3277.52.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-07-24 at 12:31 +0000, Udit Agarwal wrote:
> Yes the secure keys and CAAM are correlated. Secure keys depends on
> NXP CAAM crypto HW accelerator. ?Secure key is a random data of
> length X (passed using keyctl command) & derived using CAAM. Blob of
> this data is also created using CAAM. Only blob is visible to user
> space.

The term "secure keys" is really generic. ?What makes the "secure
keys" secure? ?We introduced "trusted keys", because TPM 1.2 didn't
support symmetric keys. ?We shouldn't just duplicate "trusted keys"
for different HW, but improve upon it (eg. symmetric keys never leave
the device).

The new key type should define generic methods, which are implemented
for NXP CAAM rypto HW accelerator as an example.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
