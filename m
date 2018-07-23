From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Mon, 23 Jul 2018 14:42:36 +0200
Subject: [PATCH 1/2] security/keys/secure_key: Adds the secure key
	support based on CAAM.
In-Reply-To: <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
	<1532076042.3511.203.camel@pengutronix.de>
	<AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
Message-ID: <1532349756.4604.85.camel@pengutronix.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On Sat, 2018-07-21 at 14:44 +0000, Udit Agarwal wrote:
> Thanks for sharing the documentation changes and feedback.
> 
> Below are the answers to the questions:
> 
> 1. Currently the secure key patch series has been added  to support
> only data blobs.
> It is not supporting key blobs as of now, we have thought of adding
> that support in future.

OK. Do have a plan how the key blobs would be represented in the
keyring? It seems it would need to be some sort of handle instead of
the key data. Would it need a different userspace API?

> 2. Yes secure keys could also be implemented using OPTEE. I will
> change the documentation in next patch version.

Thanks!

Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
