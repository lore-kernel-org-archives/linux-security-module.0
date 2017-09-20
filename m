From: smueller@chronox.de (Stephan Mueller)
Date: Wed, 20 Sep 2017 16:06:48 +0200
Subject: [PATCH v6] security/keys: rewrite all of big_key crypto
In-Reply-To: <CAHmME9pLF7cdm3RuOa-k8knsikNwU-5BVsnoHNEYw-xpuhW0tg@mail.gmail.com>
References: <CAHmME9rjrz2Pn39ay3myApBeBtQAPNt0C+NvmFoV28NeT4_zLg@mail.gmail.com>
	<2545404.XUVGGHhd0i@tauon.chronox.de>
	<CAHmME9pLF7cdm3RuOa-k8knsikNwU-5BVsnoHNEYw-xpuhW0tg@mail.gmail.com>
Message-ID: <1882458.VgLOd8kIdz@tauon.chronox.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Am Mittwoch, 20. September 2017, 16:01:21 CEST schrieb Jason A. Donenfeld:

Hi Jason,

> 
> Section 3 shows an attack with repeated nonces, which we don't do here.

Maybe I miss a point here, but zero IVs is no repetition of nonces?


Ciao
Stephan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
