From: smueller@chronox.de (Stephan Mueller)
Date: Mon, 18 Sep 2017 10:49:56 +0200
Subject: [PATCH v4] security/keys: rewrite all of big_key crypto
In-Reply-To: <20170916130034.17706-1-Jason@zx2c4.com>
References: <20170916130034.17706-1-Jason@zx2c4.com>
Message-ID: <2681038.03lnYPhpsa@tauon.chronox.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Am Samstag, 16. September 2017, 15:00:34 CEST schrieb Jason A. Donenfeld:

Hi Jason,

> This started out as just replacing the use of crypto/rng with
> get_random_bytes_wait, 

This change is a challenge. The use of the kernel crypto API's DRNG has been 
made to allow FIPS 140-2 compliance. Otherwise, the entire key generation 
logic will not be using the right(TM) DRNG. Thus, I would not suggest to 
replace that for a stable tree.

Note, I am currently working on a pluggable DRNG apporach for /dev/random and 
/dev/urandom to be able to get rid of the use of the kernel crypto API's DRNG 
API. It is ready and I will air that solution shortly. Yet, it needs work to 
be integrated upstream (and approval from Ted Tso).

Ciao
Stephan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
